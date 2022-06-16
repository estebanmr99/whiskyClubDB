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

---Store Procedure, find product by name 


CREATE PROCEDURE prcFindProductByName
@name varchar(50)
AS
BEGIN
	BEGIN TRY 
		SELECT (		
			SELECT idProduct, idType, name 
        	FROM 
			OPENQUERY ([UNIVERSAL-MYSQL] , 'SELECT * FROM product.product WHERE name = @name') 
			FOR JSON AUTO
		) AS productFound

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


-- Insert productds on US stores (US_User)
CREATE PROCEDURE prcCreateProductUS
@idProduct int,
AS
BEGIN
	BEGIN TRY 

		INSERT INTO [dbo].[usa_store1].[product] (idProduct)
		VALUES (@idProduct);
		INSERT INTO [dbo].[usa_store2].[product] (idProduct)
		VALUES (@idProduct);
		INSERT INTO [dbo].[usa_store3].[product] (idProduct)
		VALUES (@idProduct);
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


-- Insert products on STK stores (STK_User)
CREATE PROCEDURE prcCreateProductSTK
@idProduct int,
AS
BEGIN
	BEGIN TRY 

		INSERT INTO [dbo].[stk_store1].[product] (idProduct)
		VALUES (@idProduct);
		INSERT INTO [dbo].[stk_store2].[product] (idProduct)
		VALUES (@idProduct);
		INSERT INTO [dbo].[stk_store3].[product] (idProduct)
		VALUES (@idProduct);
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

-- Store procedure to get next Product ID (User)
CREATE PROCEDURE prcGetNextProductId
AS
BEGIN
	BEGIN TRY 
		Exec( 'SELECT MAX(idProduct) as maxIDuser
		FROM product.product') AT [UNIVERSAL-MYSQL]  
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




-- Insert products on IE stores (IE_User)
CREATE PROCEDURE prcCreateProductIE
@idProduct int,
AS
BEGIN
	BEGIN TRY 

		INSERT INTO [dbo].[ie_store1].[product] (idProduct)
		VALUES (@idProduct);
		INSERT INTO [dbo].[ie_store2].[product] (idProduct)
		VALUES (@idProduct);
		INSERT INTO [dbo].[ie_store3].[product] (idProduct)
		VALUES (@idProduct);
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
