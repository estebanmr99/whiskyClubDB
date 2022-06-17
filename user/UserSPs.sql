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

-- -------------------------



-- CREATE PRODUCT USER USA
CREATE PROCEDURE prcCreateProduct
@idProduct int,
@globalPrice money
AS
BEGIN
	BEGIN TRY 

		INSERT INTO [dbo].[usa_store1].[product] (idProduct, globalPrice)
		VALUES (@idProduct, @globalPrice);
		INSERT INTO [dbo].[usa_store2].[product] (idProduct, globalPrice)
		VALUES (@idProduct, @globalPrice);
		INSERT INTO [dbo].[usa_store3].[product] (idProduct, globalPrice)
		VALUES (@idProduct, @globalPrice);
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



-- CREATE PRODUCT USER SCOTLAN
CREATE PROCEDURE prcCreateProduct
@idProduct int,
@globalPrice money
AS
BEGIN
	BEGIN TRY 

		INSERT INTO [dbo].[stk_store1].[product] (idProduct, globalPrice)
		VALUES (@idProduct, @globalPrice);
		INSERT INTO [dbo].[stk_store2].[product] (idProduct, globalPrice)
		VALUES (@idProduct, @globalPrice);
		INSERT INTO [dbo].[stk_store3].[product] (idProduct, globalPrice)
		VALUES (@idProduct, @globalPrice);
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





-- CREATE PRODUCT USER IRELAND
CREATE PROCEDURE prcCreateProduct
@idProduct int,
@globalPrice money
AS
BEGIN
	BEGIN TRY 

		INSERT INTO [dbo].[ie_store1].[product] (idProduct, globalPrice)
		VALUES (@idProduct, @globalPrice);
		INSERT INTO [dbo].[ie_store2].[product] (idProduct, globalPrice)
		VALUES (@idProduct, @globalPrice);
		INSERT INTO [dbo].[ie_store3].[product] (idProduct, globalPrice)
		VALUES (@idProduct, @globalPrice);
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


--USER IRELAND


CREATE PROCEDURE prcFindEmploBySotre
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


--USER SCOTLAND

CREATE PROCEDURE prcFindEmploBySotre
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



--USER IRELAND


CREATE PROCEDURE prcFindEmployeesBySotre
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


exec prcFindEmployeesBySotre @store=3




--USER SCOTLAND

CREATE PROCEDURE prcFindEmployeesBySotre
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



--USER USA

CREATE PROCEDURE prcFindEmployeesBySotre
@store int
AS
BEGIN
	BEGIN TRY 
			BEGIN
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



--USER USA

CREATE PROCEDURE prcFindEmploBySotre
@store int,
@idEmployee int
AS
BEGIN
	BEGIN TRY 
			BEGIN
				IF @store = 7
					SELECT idEmployee, localSalary, globalSalary, deleted FROM [usa_store1].[dbo].[employee] eh
					WHERE eh.idEmployee = @idEmployee 


        ELSE IF @store = 8
					SELECT idEmployee, localSalary, globalSalary, deleted FROM [usa_store2].[dbo].[employee] eh
					WHERE eh.idEmployee = @idEmployee 

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



--USER IRELAND

CREATE PROCEDURE prcUpdateEmploBySotre
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





--USER SCOTLAND

CREATE PROCEDURE prcUpdateEmploBySotre
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




--USER USA

CREATE PROCEDURE prcUpdateEmploBySotre
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

