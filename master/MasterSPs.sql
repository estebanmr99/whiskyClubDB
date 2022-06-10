CREATE PROCEDURE prcFindUserByEmail
@emailParam varchar(50),
@select bit = 1
AS
BEGIN
	BEGIN TRY

		TRUNCATE TABLE [masterdb].[dbo].[tempUserJson]

		INSERT INTO [masterdb].[dbo].[tempUserJson]
		EXECUTE [UNITEDSTATESSQL].[usa_user].[dbo].[prcFindUserByEmail] @email = @emailParam;

		INSERT INTO [masterdb].[dbo].[tempUserJson]
		EXECUTE [SCOTLANDSQL].[stk_user].[dbo].[prcFindUserByEmail] @email = @emailParam;

		INSERT INTO [masterdb].[dbo].[tempUserJson]
		EXECUTE [IRELANDSQL].[ie_user].[dbo].[prcFindUserByEmail] @email = @emailParam;

		DELETE [masterdb].[dbo].[tempUserJson] WHERE userFound IS NULL;

		IF @select = 1
			SELECT userFound FROM [masterdb].[dbo].[tempUserJson] WHERE userFound IS NOT NULL;

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

-- EXECUTE prcFindUserByEmail @emailParam = 'usAdmin@whiskyclub.com';

CREATE PROCEDURE prcGetNextUserId
@select bit = 1
AS
BEGIN
	BEGIN TRY
		TRUNCATE TABLE [masterdb].[dbo].[tempNextUserId];
		DECLARE @maxIDuser INT;

		INSERT INTO [masterdb].[dbo].[tempNextUserId]
		EXECUTE [UNITEDSTATESSQL].[usa_user].[dbo].[prcGetNextUserId];

		INSERT INTO [masterdb].[dbo].[tempNextUserId]
		EXECUTE [SCOTLANDSQL].[stk_user].[dbo].[prcGetNextUserId];

		INSERT INTO [masterdb].[dbo].[tempNextUserId]
		EXECUTE [IRELANDSQL].[ie_user].[dbo].[prcGetNextUserId];

		SELECT @maxIDuser = (MAX(maxIDuser) + 1) FROM [masterdb].[dbo].[tempNextUserId];

		INSERT INTO [masterdb].[dbo].[tempNextUserId]
		VALUES (@maxIDuser);

		DELETE [masterdb].[dbo].[tempNextUserId] WHERE maxIDuser < @maxIDuser;

		IF @select = 1
			SELECT @maxIDuser AS maxIDuser;

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
@emailParam varchar(50),
@passwordParam varchar(255),
@locationLatParam int,
@locationLngParam int,
@nameParam varchar(50),
@lastnameParam varchar(50),
@telephoneParam varchar(30) = '',
@country varchar(30)
AS
BEGIN
	BEGIN TRY 
		EXECUTE [masterdb].[dbo].[prcFindUserByEmail] @emailParam = @emailParam, @select = 0;

		IF NOT EXISTS (SELECT * FROM [masterdb].[dbo].[tempUserJson])
			BEGIN
				EXECUTE [masterdb].[dbo].[prcGetNextUserId] @select = 0;

				DECLARE @maxIDuser int;
				SELECT @maxIDuser = MAX(maxIDuser) FROM [dbo].[tempNextUserId];

				IF @country = 'United States'
					EXECUTE [UNITEDSTATESSQL].[usa_user].[dbo].[prcRegisterUser] @iduser = @maxIDuser, @email = @emailParam, @password = @passwordParam, @locationLat = @locationLatParam, @locationLng = @locationLngParam, @name = @nameParam, @lastName = @lastnameParam, @telephone = @telephoneParam;
				ELSE IF @country = 'Scotland'
					EXECUTE [SCOTLANDSQL].[stk_user].[dbo].[prcRegisterUser] @iduser = @maxIDuser, @email = @emailParam, @password = @passwordParam, @locationLat = @locationLatParam, @locationLng = @locationLngParam, @name = @nameParam, @lastName = @lastnameParam, @telephone = @telephoneParam;
				ELSE IF @country = 'Ireland'
					EXECUTE [IRELANDSQL].[ie_user].[dbo].[prcRegisterUser] @iduser = @maxIDuser, @email = @emailParam, @password = @passwordParam, @locationLat = @locationLatParam, @locationLng = @locationLngParam, @name = @nameParam, @lastName = @lastnameParam, @telephone = @telephoneParam;
				ELSE
					RAISERROR ( 'Whoops, an error occurred.', 11, 1);

				SELECT 'Created';
			END
		ELSE
			BEGIN
				RAISERROR ('Email already in use.', 11, 1);
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

-- EXECUTE prcRegisterUser @email = 'usAdmin@whiskyclub.com';



-- ----------------------------

--- Store procedure FindProductByName (Masterdb)
CREATE PROCEDURE prcFindProductByName
@nameParam varchar(50),
@select bit = 1
AS
BEGIN
	BEGIN TRY

		TRUNCATE TABLE [masterdb].[dbo].[tempProductJson]

		INSERT INTO [masterdb].[dbo].[tempProductJson]
		EXECUTE [UNITEDSTATESSQL].[usa_user].[dbo].[prcFindProductByName] @name = @nameParam;

		INSERT INTO [masterdb].[dbo].[tempProductJson]
		EXECUTE [SCOTLANDSQL].[stk_user].[dbo].[prcFindProductByName] @name = @nameParam;

		INSERT INTO [masterdb].[dbo].[tempProductJson]
		EXECUTE [IRELANDSQL].[ie_user].[dbo].[prcFindProductByName] @name = @nameParam;

		DELETE [masterdb].[dbo].[tempProductJson] WHERE productFound IS NULL;

		IF @select = 1
			SELECT productFound FROM [masterdb].[dbo].[tempProductJson] WHERE productFound IS NOT NULL;

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


EXECUTE prcFindProductByName @nameParam = 'Wisky';


-- Store procedure to get next Product ID (Masterdb)
CREATE PROCEDURE prcGetNextProductId
@select bit = 1
AS
BEGIN
	BEGIN TRY
		TRUNCATE TABLE [masterdb].[dbo].[tempNextProductId];
		DECLARE @maxIDuser INT;

		INSERT INTO [masterdb].[dbo].[tempNextProductId]
		EXECUTE [UNITEDSTATESSQL].[usa_user].[dbo].[prcGetNextUserId];

		INSERT INTO [masterdb].[dbo].[tempNextProductId]
		EXECUTE [SCOTLANDSQL].[stk_user].[dbo].[prcGetNextUserId];

		INSERT INTO [masterdb].[dbo].[tempNextProductId]
		EXECUTE [IRELANDSQL].[ie_user].[dbo].[prcGetNextUserId];

		SELECT @maxIDuser = (MAX(maxIDuser) + 1) FROM [masterdb].[dbo].[tempNextProductId];

		INSERT INTO [masterdb].[dbo].[tempNextProductId]
		VALUES (@maxIDuser);

		DELETE [masterdb].[dbo].[tempNextProductId] WHERE maxIDuser < @maxIDuser;

		IF @select = 1
			SELECT @maxIDuser AS maxIDuser;

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




--- Store procedure CreateProduct (Masterdb)
CREATE PROCEDURE prcCreateProduct
@idProduct int,
@nameParam varchar(50),
@typeParam int,
@agedParam varchar(10),
@presentationParam varchar(150),
@imageParam image
AS
BEGIN
	BEGIN TRY 
		EXECUTE [masterdb].[dbo].[prcFindProductByName] @nameParam = @nameParam, @select = 0;

		IF NOT EXISTS (SELECT * FROM [masterdb].[dbo].[tempProductJson])
			BEGIN
					EXECUTE [masterdb].[dbo].[prcGetNextProductId] @select = 0;

					DECLARE @maxIDProduct int;
					SELECT @maxIDProduct = MAX(@maxIDProduct) FROM [dbo].[tempNextProductId];  -- falta hacer lo de get next id de productos
					
					--insert product on the universal product database on MYSQL
					EXEC ('Insert into product.product(idProduct, idType, name, features, image, createDate)
							values (@maxIDProduct,@typeParam,@nameParam,@presentationParam, @imageParam, GETDATE()  )') AT [UNIVERSAL-MYSQL] 


					--insert products on stores in the US
					EXECUTE [UNITEDSTATESSQL].[usa_user].[dbo].[prcCreateProductUS]  @maxIDProduct = @idProduct;
					--insert products on stores in STK
					EXECUTE [SCOTLANDSQL].[stk_user].[dbo].[prcCreateProductSTK]  @maxIDProduct = @idProduct;
					--insert products on stores in IE
					EXECUTE [IRELANDSQL].[ie_user].[dbo].[prcCreateProductIE]  @maxIDProduct = @idProduct;
	
				ELSE
					RAISERROR ( 'Whoops, an error occurred.', 11, 1);

				SELECT 'Created';
			END
		ELSE
			BEGIN
				RAISERROR ('Product already exist.', 11, 1);
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
