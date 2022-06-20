-- Product database stored procedures
-- The database has 3 instances, because of this we well have 3 section for each instance.

-------------------------------------------------------------------------------------------------------------------------------- USA
CREATE PROCEDURE prcFindUserByEmail
@email varchar(50)
AS
BEGIN
	BEGIN TRY 
	-- select user where email match
		SELECT (		
			SELECT idUser, idUserType, idLevel, email, password, name, lastName
        	FROM [dbo].[user]
        	WHERE email = @email
			FOR JSON AUTO
		) AS userFound

	END TRY 
	BEGIN CATCH
	SELECT
	  ERROR_NUMBER() AS ErrorNumber  
            ,ERROR_SEVERITY() AS ErrorSeverity  
            ,ERROR_STATE() AS ErrorState  
            ,ERROR_PROCEDURE() AS ErrorProcedure  
            ,ERROR_LINE() AS ErrorLine  
            ,ERROR_MESSAGE() AS ErrorMessage;

	END CATCH

END
GO

-- EXECUTE prcFindUserByEmail @email = 'usAdmin@whiskyclub.com';

CREATE PROCEDURE prcGetNextUserId
AS
BEGIN
	BEGIN TRY 
	-- get de max from  all the idUser
		SELECT MAX(idUser) as maxIDuser
		FROM [dbo].[user]
	END TRY 
	BEGIN CATCH
	SELECT
	  ERROR_NUMBER() AS ErrorNumber  
            ,ERROR_SEVERITY() AS ErrorSeverity  
            ,ERROR_STATE() AS ErrorState  
            ,ERROR_PROCEDURE() AS ErrorProcedure  
            ,ERROR_LINE() AS ErrorLine  
            ,ERROR_MESSAGE() AS ErrorMessage;

	END CATCH

END
GO

-- EXECUTE prcGetNextUserId;

CREATE PROCEDURE prcRegisterUser
@iduser int,
@email varchar(50),
@password varchar(255),
@locationLat int,
@locationLng int,
@name varchar(50),
@lastName varchar(50),
@telephone varchar(30) = ''
AS
BEGIN
	BEGIN TRY 
	
		-- insert user into user database
		INSERT INTO [dbo].[user] (idUser, idUserType, idLevel, email, password, name, lastName, telephone, location, createDate, updateDate, deleted)
		VALUES (@idUser, 1, 0, @email, @password, @name, @lastName, @telephone, geography::Point(@locationLat, @locationLng, 4326), GETDATE(), GETDATE(), 0);

	END TRY 
	BEGIN CATCH
	SELECT
	  ERROR_NUMBER() AS ErrorNumber  
            ,ERROR_SEVERITY() AS ErrorSeverity  
            ,ERROR_STATE() AS ErrorState  
            ,ERROR_PROCEDURE() AS ErrorProcedure  
            ,ERROR_LINE() AS ErrorLine  
            ,ERROR_MESSAGE() AS ErrorMessage;

	END CATCH

END
GO

-- EXECUTE prcRegisterUser @idUser = 100, @email = 'test@test.com', @password = 'test', @locationLat = 1, @locationLng = 1, @name = 'test', @lastName = 'test', @telephone = '8888899';

CREATE PROCEDURE prcSubscription
@idUser int,
@idLevel int
AS
BEGIN
	BEGIN TRY 
		-- update the idLevel the the subscription given by the user
		update [dbo].[user] 
		SET idLevel = @idLevel
		WHERE idUser = @idUser

	END TRY 
	BEGIN CATCH
	SELECT
	  ERROR_NUMBER() AS ErrorNumber  
            ,ERROR_SEVERITY() AS ErrorSeverity  
            ,ERROR_STATE() AS ErrorState  
            ,ERROR_PROCEDURE() AS ErrorProcedure  
            ,ERROR_LINE() AS ErrorLine  
            ,ERROR_MESSAGE() AS ErrorMessage;

	END CATCH

END
GO

CREATE PROCEDURE prcCreateProduct
@idProduct int,
@globalPrice money,
@image varbinary(max)
AS
BEGIN
		DECLARE @localPrice money
		 set @localPrice = @globalPrice
	BEGIN TRY 
		-- insert product into all the store
		INSERT INTO [usa_store1].[dbo].[product] (idProduct, currency, localPrice, globalPrice, image)
		VALUES (@idProduct, 'USD',@localPrice ,@globalPrice, @image);
		INSERT INTO [usa_store2].[dbo].[product] (idProduct, currency, localPrice, globalPrice, image)
		VALUES (@idProduct, 'USD',@localPrice ,@globalPrice, @image);
		INSERT INTO [usa_store3].[dbo].[product] (idProduct, currency, localPrice, globalPrice, image)
		VALUES (@idProduct, 'USD',@localPrice ,@globalPrice, @image);
	END TRY 
	BEGIN CATCH
	SELECT
	  ERROR_NUMBER() AS ErrorNumber  
            ,ERROR_SEVERITY() AS ErrorSeverity  
            ,ERROR_STATE() AS ErrorState  
            ,ERROR_PROCEDURE() AS ErrorProcedure  
            ,ERROR_LINE() AS ErrorLine  
            ,ERROR_MESSAGE() AS ErrorMessage;

	END CATCH

END
GO

CREATE PROCEDURE prcFindEmployeesByStore
@store int
AS
BEGIN
	BEGIN TRY 
			BEGIN
	-- find all employees that are not deleted		
	IF @store = 7
					SELECT idEmployee, localSalary, globalSalary, deleted FROM [usa_store1].[dbo].[employee] eh
					WHERE deleted =0


        ELSE IF @store = 8
					SELECT idEmployee, localSalary, globalSalary, deleted FROM [usa_store2].[dbo].[employee] eh
					WHERE deleted =0 

        ELSE IF @store = 9
					SELECT idEmployee, localSalary, globalSalary, deleted FROM [usa_store3].[dbo].[employee] eh
					WHERE deleted =0 
          
			Else
			RAISERROR ( 'Whoops, an error occurred.', 11, 1);

			END

	END TRY 
		BEGIN CATCH
			SELECT
			  ERROR_NUMBER() AS ErrorNumber  
					,ERROR_SEVERITY() AS ErrorSeverity  
					,ERROR_STATE() AS ErrorState  
					,ERROR_PROCEDURE() AS ErrorProcedure  
					,ERROR_LINE() AS ErrorLine  
					,ERROR_MESSAGE() AS ErrorMessage;
		END CATCH
END
GO

-- exec prcFindEmployeesByStore @store=3

CREATE PROCEDURE prcFindEmployeeByStore
@store int,
@idEmployee int
AS
BEGIN
	BEGIN TRY 
			BEGIN
			-- find specific employee that macth idEmployee	 on store1
				IF @store = 7
					SELECT idEmployee, localSalary, globalSalary, deleted FROM [usa_store1].[dbo].[employee] eh
					WHERE eh.idEmployee = @idEmployee 

	-- find specific employee that macth idEmployee	on store2
        ELSE IF @store = 8
					SELECT idEmployee, localSalary, globalSalary, deleted FROM [usa_store2].[dbo].[employee] eh
					WHERE eh.idEmployee = @idEmployee 
	-- find specific employee that macth idEmployee	 on store3
        ELSE IF @store = 9
					SELECT idEmployee, localSalary, globalSalary, deleted FROM [usa_store3].[dbo].[employee] eh
					WHERE eh.idEmployee = @idEmployee 
          
			END

	END TRY 
		BEGIN CATCH
			SELECT
			  ERROR_NUMBER() AS ErrorNumber  
					,ERROR_SEVERITY() AS ErrorSeverity  
					,ERROR_STATE() AS ErrorState  
					,ERROR_PROCEDURE() AS ErrorProcedure  
					,ERROR_LINE() AS ErrorLine  
					,ERROR_MESSAGE() AS ErrorMessage;
		END CATCH
END
GO


CREATE PROCEDURE prcUpdateEmployeeByStore
@store int,
@idEmployee int, 
@localSalary money,
@globalSalary money
AS
BEGIN
	BEGIN TRY 
			BEGIN
		IF @store = 7
					UPDATE [usa_store1].[dbo].[employee]
					SET localSalary= @localSalary,
						globalSalary= @globalSalary
					WHERE idEmployee = @idEmployee
        ELSE IF @store = 8
					UPDATE [usa_store2].[dbo].[employee]
					SET localSalary= @localSalary,
						globalSalary= @globalSalary
					WHERE idEmployee = @idEmployee

        ELSE IF @store = 9
					UPDATE [usa_store3].[dbo].[employee]
					SET localSalary= @localSalary,
						globalSalary= @globalSalary
					WHERE idEmployee = @idEmployee 
          
			Else
			RAISERROR ( 'Whoops, an error occurred.', 11, 1);

        
			END

	END TRY 
		BEGIN CATCH
			SELECT
			  ERROR_NUMBER() AS ErrorNumber  
					,ERROR_SEVERITY() AS ErrorSeverity  
					,ERROR_STATE() AS ErrorState  
					,ERROR_PROCEDURE() AS ErrorProcedure  
					,ERROR_LINE() AS ErrorLine  
					,ERROR_MESSAGE() AS ErrorMessage;
		END CATCH
END
GO

CREATE PROCEDURE prcInsertEmployeeByStore
@store int,
@idEmployee int, 
@localSalary money,
@globalSalary money
AS
BEGIN
	BEGIN TRY 
			BEGIN
			-- insert employee by specific store
		IF @store = 7
					INSERT INTO [usa_store1].[dbo].[employee](idEmployee,localSalary,globalSalary,deleted)
					VALUES (@idEmployee,@localSalary, @globalSalary,0)
        ELSE IF @store = 8
					INSERT INTO [usa_store2].[dbo].[employee](idEmployee,localSalary,globalSalary,deleted)
					VALUES (@idEmployee,@localSalary, @globalSalary,0)

        ELSE IF @store = 9
					INSERT INTO [usa_store3].[dbo].[employee](idEmployee,localSalary,globalSalary,deleted)
					VALUES (@idEmployee,@localSalary, @globalSalary,0)
          
			Else
			RAISERROR ( 'Whoops, an error occurred.', 11, 1);

        
			END

	END TRY 
		BEGIN CATCH
			SELECT
			  ERROR_NUMBER() AS ErrorNumber  
					,ERROR_SEVERITY() AS ErrorSeverity  
					,ERROR_STATE() AS ErrorState  
					,ERROR_PROCEDURE() AS ErrorProcedure  
					,ERROR_LINE() AS ErrorLine  
					,ERROR_MESSAGE() AS ErrorMessage;
		END CATCH
END
GO


CREATE PROCEDURE prcDeleteEmployeeByStore
@store int,
@idEmployee int
AS
BEGIN
	BEGIN TRY 
			BEGIN
			-- delete employee by specific store
		IF @store = 7
					UPDATE [usa_store1].[dbo].[employee]
					SET deleted = 1
					WHERE idEmployee = @idEmployee
        ELSE IF @store = 8
					UPDATE [usa_store2].[dbo].[employee]
					SET deleted = 1
					WHERE idEmployee = @idEmployee

        ELSE IF @store = 9
					UPDATE [usa_store3].[dbo].[employee]
					SET deleted = 1
					WHERE idEmployee = @idEmployee
          
			Else
			RAISERROR ( 'Whoops, an error occurred.', 11, 1);

        
			END

	END TRY 
		BEGIN CATCH
			SELECT
			  ERROR_NUMBER() AS ErrorNumber  
					,ERROR_SEVERITY() AS ErrorSeverity  
					,ERROR_STATE() AS ErrorState  
					,ERROR_PROCEDURE() AS ErrorProcedure  
					,ERROR_LINE() AS ErrorLine  
					,ERROR_MESSAGE() AS ErrorMessage;
		END CATCH
END
GO

-------------------------------------------------------------------------------------------------------------------------------- Ireland
CREATE PROCEDURE prcFindUserByEmail
@email varchar(50)
AS
BEGIN
	BEGIN TRY 
	-- find user by email on the user database
		SELECT (		
			SELECT idUser, idUserType, idLevel, email, password, name, lastName
        	FROM [dbo].[user]
        	WHERE email = @email
			FOR JSON AUTO
		) AS userFound

	END TRY 
	BEGIN CATCH
	SELECT
	  ERROR_NUMBER() AS ErrorNumber  
            ,ERROR_SEVERITY() AS ErrorSeverity  
            ,ERROR_STATE() AS ErrorState  
            ,ERROR_PROCEDURE() AS ErrorProcedure  
            ,ERROR_LINE() AS ErrorLine  
            ,ERROR_MESSAGE() AS ErrorMessage;

	END CATCH

END
GO

-- EXECUTE prcFindUserByEmail @email = 'usAdmin@whiskyclub.com';

CREATE PROCEDURE prcGetNextUserId
AS
BEGIN
	BEGIN TRY 
		-- get the max idUser from user database
		SELECT MAX(idUser) as maxIDuser
		FROM [dbo].[user]
	END TRY 
	BEGIN CATCH
	SELECT
	  ERROR_NUMBER() AS ErrorNumber  
            ,ERROR_SEVERITY() AS ErrorSeverity  
            ,ERROR_STATE() AS ErrorState  
            ,ERROR_PROCEDURE() AS ErrorProcedure  
            ,ERROR_LINE() AS ErrorLine  
            ,ERROR_MESSAGE() AS ErrorMessage;

	END CATCH

END
GO

-- EXECUTE prcGetNextUserId;

CREATE PROCEDURE prcRegisterUser
@iduser int,
@email varchar(50),
@password varchar(255),
@locationLat int,
@locationLng int,
@name varchar(50),
@lastName varchar(50),
@telephone varchar(30) = ''
AS
BEGIN
	BEGIN TRY 

		INSERT INTO [dbo].[user] (idUser, idUserType, idLevel, email, password, name, lastName, telephone, location, createDate, updateDate, deleted)
		VALUES (@idUser, 1, 0, @email, @password, @name, @lastName, @telephone, geography::Point(@locationLat, @locationLng, 4326), GETDATE(), GETDATE(), 0);

	END TRY 
	BEGIN CATCH
	SELECT
	  ERROR_NUMBER() AS ErrorNumber  
            ,ERROR_SEVERITY() AS ErrorSeverity  
            ,ERROR_STATE() AS ErrorState  
            ,ERROR_PROCEDURE() AS ErrorProcedure  
            ,ERROR_LINE() AS ErrorLine  
            ,ERROR_MESSAGE() AS ErrorMessage;

	END CATCH

END
GO

-- EXECUTE prcRegisterUser @idUser = 100, @email = 'test@test.com', @password = 'test', @locationLat = 1, @locationLng = 1, @name = 'test', @lastName = 'test', @telephone = '8888899';

CREATE PROCEDURE prcSubscription
@idUser int,
@idLevel int
AS
BEGIN
	BEGIN TRY 
	
		update [dbo].[user] 
		SET idLevel = @idLevel
		WHERE idUser = @idUser

	END TRY 
	BEGIN CATCH
	SELECT
	  ERROR_NUMBER() AS ErrorNumber  
            ,ERROR_SEVERITY() AS ErrorSeverity  
            ,ERROR_STATE() AS ErrorState  
            ,ERROR_PROCEDURE() AS ErrorProcedure  
            ,ERROR_LINE() AS ErrorLine  
            ,ERROR_MESSAGE() AS ErrorMessage;

	END CATCH

END
GO

CREATE PROCEDURE prcCreateProduct
@idProduct int,
@globalPrice money,
@image varbinary(max)
AS
BEGIN
		DECLARE @localPrice money
		 set @localPrice = (@globalPrice*0.96)
	BEGIN TRY 
		

		INSERT INTO [ie_store1].[dbo].[product] (idProduct, currency, localPrice, globalPrice, image)
		VALUES (@idProduct, 'EUR',@localPrice ,@globalPrice, @image);
		INSERT INTO [ie_store2].[dbo].[product] (idProduct, currency, localPrice, globalPrice, image)
		VALUES (@idProduct, 'EUR',@localPrice ,@globalPrice, @image);
		INSERT INTO [ie_store3].[dbo].[product] (idProduct, currency, localPrice, globalPrice, image)
		VALUES (@idProduct, 'EUR',@localPrice ,@globalPrice, @image);
	END TRY 
	BEGIN CATCH
	SELECT
	  ERROR_NUMBER() AS ErrorNumber  
            ,ERROR_SEVERITY() AS ErrorSeverity  
            ,ERROR_STATE() AS ErrorState  
            ,ERROR_PROCEDURE() AS ErrorProcedure  
            ,ERROR_LINE() AS ErrorLine  
            ,ERROR_MESSAGE() AS ErrorMessage;

	END CATCH

END
GO

CREATE PROCEDURE prcFindEmployeeByStore
@store int,
@idEmployee int
AS
BEGIN
	BEGIN TRY 
			BEGIN
				IF @store = 1
					SELECT idEmployee, localSalary, globalSalary, deleted FROM [ie_store1].[dbo].[employee] eh
					WHERE eh.idEmployee = @idEmployee 


        ELSE IF @store = 2
					SELECT idEmployee, localSalary, globalSalary, deleted FROM [ie_store2].[dbo].[employee] eh
					WHERE eh.idEmployee = @idEmployee 

        ELSE IF @store = 3
					SELECT idEmployee, localSalary, globalSalary, deleted FROM [ie_store3].[dbo].[employee] eh
					WHERE eh.idEmployee = @idEmployee 
          
			END

	END TRY 
		BEGIN CATCH
			SELECT
			  ERROR_NUMBER() AS ErrorNumber  
					,ERROR_SEVERITY() AS ErrorSeverity  
					,ERROR_STATE() AS ErrorState  
					,ERROR_PROCEDURE() AS ErrorProcedure  
					,ERROR_LINE() AS ErrorLine  
					,ERROR_MESSAGE() AS ErrorMessage;
		END CATCH
END
GO

CREATE PROCEDURE prcFindEmployeesByStore
@store int
AS
BEGIN
	BEGIN TRY 
			BEGIN
				IF @store = 1
					SELECT idEmployee, localSalary, globalSalary, deleted FROM [ie_store1].[dbo].[employee] eh
					WHERE deleted = 0 


        ELSE IF @store = 2
					SELECT idEmployee, localSalary, globalSalary, deleted FROM [ie_store2].[dbo].[employee] eh
					WHERE deleted = 0 

        ELSE IF @store = 3
					SELECT idEmployee, localSalary, globalSalary, deleted FROM [ie_store3].[dbo].[employee] eh
					WHERE deleted = 0 
          
			Else
			RAISERROR ( 'Whoops, an error occurred.', 11, 1);

			END

	END TRY 
		BEGIN CATCH
			SELECT
			  ERROR_NUMBER() AS ErrorNumber  
					,ERROR_SEVERITY() AS ErrorSeverity  
					,ERROR_STATE() AS ErrorState  
					,ERROR_PROCEDURE() AS ErrorProcedure  
					,ERROR_LINE() AS ErrorLine  
					,ERROR_MESSAGE() AS ErrorMessage;
		END CATCH
END
GO

-- exec prcFindEmployeesByStore @store=3

CREATE PROCEDURE prcInsertEmployeeByStore
@store int,
@idEmployee int, 
@localSalary money,
@globalSalary money
AS
BEGIN
	BEGIN TRY 
			BEGIN
		IF @store = 1
					INSERT INTO [ie_store1].[dbo].[employee](idEmployee,localSalary,globalSalary,deleted)
					VALUES (@idEmployee,@localSalary, @globalSalary,0)
        ELSE IF @store = 2
					INSERT INTO [ie_store2].[dbo].[employee](idEmployee,localSalary,globalSalary,deleted)
					VALUES (@idEmployee,@localSalary, @globalSalary,0)

        ELSE IF @store = 3
					INSERT INTO [ie_store3].[dbo].[employee](idEmployee,localSalary,globalSalary,deleted)
					VALUES (@idEmployee,@localSalary, @globalSalary,0)
          
			Else
			RAISERROR ( 'Whoops, an error occurred.', 11, 1);

        
			END

	END TRY 
		BEGIN CATCH
			SELECT
			  ERROR_NUMBER() AS ErrorNumber  
					,ERROR_SEVERITY() AS ErrorSeverity  
					,ERROR_STATE() AS ErrorState  
					,ERROR_PROCEDURE() AS ErrorProcedure  
					,ERROR_LINE() AS ErrorLine  
					,ERROR_MESSAGE() AS ErrorMessage;
		END CATCH
END
GO


CREATE PROCEDURE prcUpdateEmployeeByStore
@store int,
@idEmployee int, 
@localSalary money,
@globalSalary money
AS
BEGIN
	BEGIN TRY 
			BEGIN
		IF @store = 1
					UPDATE [ie_store1].[dbo].[employee]
					SET localSalary= @localSalary,
						globalSalary= @globalSalary
					WHERE idEmployee = @idEmployee
        ELSE IF @store = 2
					UPDATE [ie_store2].[dbo].[employee]
					SET localSalary= @localSalary,
						globalSalary= @globalSalary
					WHERE idEmployee = @idEmployee

        ELSE IF @store = 3
					UPDATE [ie_store3].[dbo].[employee]
					SET localSalary= @localSalary,
						globalSalary= @globalSalary
					WHERE idEmployee = @idEmployee 
          
			Else
			RAISERROR ( 'Whoops, an error occurred.', 11, 1);

        
			END

	END TRY 
		BEGIN CATCH
			SELECT
			  ERROR_NUMBER() AS ErrorNumber  
					,ERROR_SEVERITY() AS ErrorSeverity  
					,ERROR_STATE() AS ErrorState  
					,ERROR_PROCEDURE() AS ErrorProcedure  
					,ERROR_LINE() AS ErrorLine  
					,ERROR_MESSAGE() AS ErrorMessage;
		END CATCH
END
GO


CREATE PROCEDURE prcDeleteEmployeeByStore
@store int,
@idEmployee int
AS
BEGIN
	BEGIN TRY 
			BEGIN
		IF @store = 1
					UPDATE [ie_store1].[dbo].[employee]
					SET deleted = 1
					WHERE idEmployee = @idEmployee
        ELSE IF @store = 2
					UPDATE [ie_store2].[dbo].[employee]
					SET deleted = 1
					WHERE idEmployee = @idEmployee

        ELSE IF @store = 3
					UPDATE [ie_store3].[dbo].[employee]
					SET deleted = 1
					WHERE idEmployee = @idEmployee
          
			Else
			RAISERROR ( 'Whoops, an error occurred.', 11, 1);

        
			END

	END TRY 
		BEGIN CATCH
			SELECT
			  ERROR_NUMBER() AS ErrorNumber  
					,ERROR_SEVERITY() AS ErrorSeverity  
					,ERROR_STATE() AS ErrorState  
					,ERROR_PROCEDURE() AS ErrorProcedure  
					,ERROR_LINE() AS ErrorLine  
					,ERROR_MESSAGE() AS ErrorMessage;
		END CATCH
END
GO

-------------------------------------------------------------------------------------------------------------------------------- Scotland
CREATE PROCEDURE prcFindUserByEmail
@email varchar(50)
AS
BEGIN
	BEGIN TRY 
		SELECT (		
			SELECT idUser, idUserType, idLevel, email, password, name, lastName
        	FROM [dbo].[user]
        	WHERE email = @email
			FOR JSON AUTO
		) AS userFound

	END TRY 
	BEGIN CATCH
	SELECT
	  ERROR_NUMBER() AS ErrorNumber  
            ,ERROR_SEVERITY() AS ErrorSeverity  
            ,ERROR_STATE() AS ErrorState  
            ,ERROR_PROCEDURE() AS ErrorProcedure  
            ,ERROR_LINE() AS ErrorLine  
            ,ERROR_MESSAGE() AS ErrorMessage;

	END CATCH

END
GO

-- EXECUTE prcFindUserByEmail @email = 'usAdmin@whiskyclub.com';

CREATE PROCEDURE prcGetNextUserId
AS
BEGIN
	BEGIN TRY 
		SELECT MAX(idUser) as maxIDuser
		FROM [dbo].[user]
	END TRY 
	BEGIN CATCH
	SELECT
	  ERROR_NUMBER() AS ErrorNumber  
            ,ERROR_SEVERITY() AS ErrorSeverity  
            ,ERROR_STATE() AS ErrorState  
            ,ERROR_PROCEDURE() AS ErrorProcedure  
            ,ERROR_LINE() AS ErrorLine  
            ,ERROR_MESSAGE() AS ErrorMessage;

	END CATCH

END
GO

-- EXECUTE prcGetNextUserId;

CREATE PROCEDURE prcRegisterUser
@iduser int,
@email varchar(50),
@password varchar(255),
@locationLat int,
@locationLng int,
@name varchar(50),
@lastName varchar(50),
@telephone varchar(30) = ''
AS
BEGIN
	BEGIN TRY 

		INSERT INTO [dbo].[user] (idUser, idUserType, idLevel, email, password, name, lastName, telephone, location, createDate, updateDate, deleted)
		VALUES (@idUser, 1, 0, @email, @password, @name, @lastName, @telephone, geography::Point(@locationLat, @locationLng, 4326), GETDATE(), GETDATE(), 0);

	END TRY 
	BEGIN CATCH
	SELECT
	  ERROR_NUMBER() AS ErrorNumber  
            ,ERROR_SEVERITY() AS ErrorSeverity  
            ,ERROR_STATE() AS ErrorState  
            ,ERROR_PROCEDURE() AS ErrorProcedure  
            ,ERROR_LINE() AS ErrorLine  
            ,ERROR_MESSAGE() AS ErrorMessage;

	END CATCH

END
GO

-- EXECUTE prcRegisterUser @idUser = 100, @email = 'test@test.com', @password = 'test', @locationLat = 1, @locationLng = 1, @name = 'test', @lastName = 'test', @telephone = '8888899';

CREATE PROCEDURE prcSubscription
@idUser int,
@idLevel int
AS
BEGIN
	BEGIN TRY 
	
		update [dbo].[user] 
		SET idLevel = @idLevel
		WHERE idUser = @idUser

	END TRY 
	BEGIN CATCH
	SELECT
	  ERROR_NUMBER() AS ErrorNumber  
            ,ERROR_SEVERITY() AS ErrorSeverity  
            ,ERROR_STATE() AS ErrorState  
            ,ERROR_PROCEDURE() AS ErrorProcedure  
            ,ERROR_LINE() AS ErrorLine  
            ,ERROR_MESSAGE() AS ErrorMessage;

	END CATCH

END
GO

CREATE PROCEDURE prcCreateProduct
@idProduct int,
@globalPrice money,
@image varbinary(max)
AS
BEGIN
		DECLARE @localPrice money
		 set @localPrice = (@globalPrice*0.96)
	BEGIN TRY 
		

		INSERT INTO [stk_store1].[dbo].[product] (idProduct, currency, localPrice, globalPrice, image)
		VALUES (@idProduct, 'EUR',@localPrice ,@globalPrice, @image);
		INSERT INTO [stk_store2].[dbo].[product] (idProduct, currency, localPrice, globalPrice, image)
		VALUES (@idProduct, 'EUR',@localPrice ,@globalPrice, @image);
		INSERT INTO [stk_store3].[dbo].[product] (idProduct, currency, localPrice, globalPrice, image)
		VALUES (@idProduct, 'EUR',@localPrice ,@globalPrice, @image);
	END TRY 
	BEGIN CATCH
	SELECT
	  ERROR_NUMBER() AS ErrorNumber  
            ,ERROR_SEVERITY() AS ErrorSeverity  
            ,ERROR_STATE() AS ErrorState  
            ,ERROR_PROCEDURE() AS ErrorProcedure  
            ,ERROR_LINE() AS ErrorLine  
            ,ERROR_MESSAGE() AS ErrorMessage;

	END CATCH

END
GO


CREATE PROCEDURE prcFindEmployeeByStore
@store int,
@idEmployee int
AS
BEGIN
	BEGIN TRY 
			BEGIN
				IF @store = 4
					SELECT idEmployee, localSalary, globalSalary, deleted FROM [stk_store1].[dbo].[employee] eh
					WHERE eh.idEmployee = @idEmployee 


        ELSE IF @store = 5
					SELECT idEmployee, localSalary, globalSalary, deleted FROM [stk_store2].[dbo].[employee] eh
					WHERE eh.idEmployee = @idEmployee 

        ELSE IF @store = 6
					SELECT idEmployee, localSalary, globalSalary, deleted FROM [stk_store3].[dbo].[employee] eh
					WHERE eh.idEmployee = @idEmployee 
          
			END

	END TRY 
		BEGIN CATCH
			SELECT
			  ERROR_NUMBER() AS ErrorNumber  
					,ERROR_SEVERITY() AS ErrorSeverity  
					,ERROR_STATE() AS ErrorState  
					,ERROR_PROCEDURE() AS ErrorProcedure  
					,ERROR_LINE() AS ErrorLine  
					,ERROR_MESSAGE() AS ErrorMessage;
		END CATCH
END
GO

CREATE PROCEDURE prcFindEmployeesByStore
@store int
AS
BEGIN
	BEGIN TRY 
			BEGIN
				IF @store = 4
					SELECT idEmployee, localSalary, globalSalary, deleted FROM [stk_store1].[dbo].[employee] eh
					WHERE deleted = 0 


        ELSE IF @store = 5
					SELECT idEmployee, localSalary, globalSalary, deleted FROM [stk_store2].[dbo].[employee] eh
					WHERE deleted = 0 

        ELSE IF @store = 6
					SELECT idEmployee, localSalary, globalSalary, deleted FROM [stk_store3].[dbo].[employee] eh
					WHERE deleted = 0 
          
			Else
			RAISERROR ( 'Whoops, an error occurred.', 11, 1);

			END

	END TRY 
		BEGIN CATCH
			SELECT
			  ERROR_NUMBER() AS ErrorNumber  
					,ERROR_SEVERITY() AS ErrorSeverity  
					,ERROR_STATE() AS ErrorState  
					,ERROR_PROCEDURE() AS ErrorProcedure  
					,ERROR_LINE() AS ErrorLine  
					,ERROR_MESSAGE() AS ErrorMessage;
		END CATCH
END
GO

-- exec prcFindEmployeesByStore @store=3

CREATE PROCEDURE prcUpdateEmployeeByStore
@store int,
@idEmployee int, 
@localSalary money,
@globalSalary money
AS
BEGIN
	BEGIN TRY 
			BEGIN
		IF @store = 3
					UPDATE [stk_store1].[dbo].[employee]
					SET localSalary= @localSalary,
						globalSalary= @globalSalary
					WHERE idEmployee = @idEmployee
        ELSE IF @store = 4
					UPDATE [stk_store2].[dbo].[employee]
					SET localSalary= @localSalary,
						globalSalary= @globalSalary
					WHERE idEmployee = @idEmployee

        ELSE IF @store = 5
					UPDATE [stk_store3].[dbo].[employee]
					SET localSalary= @localSalary,
						globalSalary= @globalSalary
					WHERE idEmployee = @idEmployee 
          
			Else
			RAISERROR ( 'Whoops, an error occurred.', 11, 1);

        
			END

	END TRY 
		BEGIN CATCH
			SELECT
			  ERROR_NUMBER() AS ErrorNumber  
					,ERROR_SEVERITY() AS ErrorSeverity  
					,ERROR_STATE() AS ErrorState  
					,ERROR_PROCEDURE() AS ErrorProcedure  
					,ERROR_LINE() AS ErrorLine  
					,ERROR_MESSAGE() AS ErrorMessage;
		END CATCH
END
GO


CREATE PROCEDURE prcInsertEmployeeByStore
@store int,
@idEmployee int, 
@localSalary money,
@globalSalary money
AS
BEGIN
	BEGIN TRY 
			BEGIN
		IF @store = 4
					INSERT INTO [stk_store1].[dbo].[employee](idEmployee,localSalary,globalSalary,deleted)
					VALUES (@idEmployee,@localSalary, @globalSalary,0)
        ELSE IF @store = 5
					INSERT INTO [stk_store2].[dbo].[employee](idEmployee,localSalary,globalSalary,deleted)
					VALUES (@idEmployee,@localSalary, @globalSalary,0)

        ELSE IF @store = 6
					INSERT INTO [stk_store3].[dbo].[employee](idEmployee,localSalary,globalSalary,deleted)
					VALUES (@idEmployee,@localSalary, @globalSalary,0)
          
			Else
			RAISERROR ( 'Whoops, an error occurred.', 11, 1);

        
			END

	END TRY 
		BEGIN CATCH
			SELECT
			  ERROR_NUMBER() AS ErrorNumber  
					,ERROR_SEVERITY() AS ErrorSeverity  
					,ERROR_STATE() AS ErrorState  
					,ERROR_PROCEDURE() AS ErrorProcedure  
					,ERROR_LINE() AS ErrorLine  
					,ERROR_MESSAGE() AS ErrorMessage;
		END CATCH
END
GO

CREATE PROCEDURE prcDeleteEmployeeByStore
@store int,
@idEmployee int
AS
BEGIN
	BEGIN TRY 
			BEGIN
		IF @store = 3
					UPDATE [stk_store1].[dbo].[employee]
					SET deleted = 1
					WHERE idEmployee = @idEmployee
        ELSE IF @store = 4
					UPDATE [stk_store2].[dbo].[employee]
					SET deleted = 1
					WHERE idEmployee = @idEmployee

        ELSE IF @store = 5
					UPDATE [stk_store3].[dbo].[employee]
					SET deleted = 1
					WHERE idEmployee = @idEmployee
          
			Else
			RAISERROR ( 'Whoops, an error occurred.', 11, 1);

        
			END

	END TRY 
		BEGIN CATCH
			SELECT
			  ERROR_NUMBER() AS ErrorNumber  
					,ERROR_SEVERITY() AS ErrorSeverity  
					,ERROR_STATE() AS ErrorState  
					,ERROR_PROCEDURE() AS ErrorProcedure  
					,ERROR_LINE() AS ErrorLine  
					,ERROR_MESSAGE() AS ErrorMessage;
		END CATCH
END
GO
