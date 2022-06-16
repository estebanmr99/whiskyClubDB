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


-- EXECUTE prcFindProductByName @nameParam = 'Wisky';


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

-- Store procedure for subscriptions
CREATE PROCEDURE prcSubscription
@idUser int,
@idLevel int,
@country varchar(30)

AS
BEGIN
	BEGIN TRY 
			BEGIN

				IF @country = 'United States'
					EXECUTE [UNITEDSTATESSQL].[usa_user].[dbo].[prcSubscription] @iduser = @iduser, @idLevel = @idLevel;
				ELSE IF @country = 'Scotland'
					EXECUTE [SCOTLANDSQL].[stk_user].[dbo].[prcSubscription] @iduser = @iduser, @idLevel = @idLevel;
				ELSE IF @country = 'Ireland'
					EXECUTE [IRELANDSQL].[ie_user].[dbo].[prcSubscription] @iduser = @iduser, @idLevel = @idLevel;
				ELSE
					RAISERROR ( 'Whoops, an error occurred.', 11, 1);

				SELECT 'Subscription Updated';
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

CREATE PROCEDURE prcGetStoresInfo
AS
BEGIN
	BEGIN TRY
		DECLARE @storesInfo TABLE
		(idStore int, 
		 name varchar(50),
		 country varchar(30)
		);

		-- Ireland stores info
		INSERT INTO @storesInfo
		EXECUTE [IRELANDSQL].[ie_store1].[dbo].[prcGetStoresInfo]

		-- Scotland stores info
		INSERT INTO @storesInfo
		EXECUTE [SCOTLANDSQL].[stk_store1].[dbo].[prcGetStoresInfo]

		-- United States stores info
		INSERT INTO @storesInfo
		EXECUTE [UNITEDSTATESSQL].[usa_store1].[dbo].[prcGetStoresInfo]

		SELECT (SELECT idStore, name, country FROM @storesInfo FOR JSON AUTO) AS storesInfo

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

-- EXECUTE prcGetStoresInfo
-- DROP PROCEDURE prcGetStoresInfo

CREATE PROCEDURE prcGetProductsInfo
AS
BEGIN
	BEGIN TRY
		DECLARE @productsInfo TABLE
		(idProduct int, 
		 name varchar(50)
		);

		INSERT INTO @productsInfo
		SELECT * FROM OPENQUERY ([UNIVERSAL-MYSQL] , 'SELECT idProduct, name FROM product.product')

		IF EXISTS (SELECT idProduct, name FROM @productsInfo)
			SELECT (SELECT idProduct, name FROM @productsInfo FOR JSON AUTO) AS productsInfo

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

-- EXECUTE prcGetProductsInfo
-- DROP PROCEDURE prcGetProductsInfo

CREATE PROCEDURE prcGetStoresInventory
AS
BEGIN
	BEGIN TRY

		DECLARE @storesInventory TABLE
		(idProduct int, 
		 currency varchar(30),
		 localPrice money,
		 globalPrice money,
		 quantity int,
		 idStore int
		);

				-- Ireland stores info
		INSERT INTO @storesInventory
		EXECUTE [IRELANDSQL].[ie_store1].[dbo].[prcGetStoresInventory]

		-- Scotland stores info
		INSERT INTO @storesInventory
		EXECUTE [SCOTLANDSQL].[stk_store1].[dbo].[prcGetStoresInventory]

		-- United States stores info
		INSERT INTO @storesInventory
		EXECUTE [UNITEDSTATESSQL].[usa_store1].[dbo].[prcGetStoresInventory]

		IF EXISTS (SELECT idProduct FROM @storesInventory)
			SELECT (SELECT idProduct, currency, localPrice, globalPrice, quantity, idStore FROM @storesInventory FOR JSON AUTO, INCLUDE_NULL_VALUES) AS storesInventory

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

-- EXECUTE prcGetStoresInventory

CREATE PROCEDURE prcUpdateStoreInventory
@idStoreParam int,
@idProductParam int,
@currencyParam varchar(30),
@localPriceParam int,
@globalPriceParam int,
@quantityParam int,
@country varchar(30)
AS
BEGIN
	BEGIN TRY

		IF @country = 'United States'
			IF EXISTS(SELECT idStore FROM OPENQUERY ([UNITEDSTATESSQL] , 'SELECT idStore FROM [usa_store1].[dbo].[store]') WHERE idStore = @idStoreParam)
				EXECUTE [UNITEDSTATESSQL].[usa_store1].[dbo].[prcUpdateStoreInventory] @idStore = @idStoreParam, @idProduct = @idProductParam, @currency = @currencyParam, @localPrice = @localPriceParam, @glocalPrice = @globalPriceParam, @quantity = @quantityParam
			IF EXISTS(SELECT idStore FROM OPENQUERY ([UNITEDSTATESSQL] , 'SELECT idStore FROM [usa_store2].[dbo].[store]') WHERE idStore = @idStoreParam)
				EXECUTE [UNITEDSTATESSQL].[usa_store2].[dbo].[prcUpdateStoreInventory] @idStore = @idStoreParam, @idProduct = @idProductParam, @currency = @currencyParam, @localPrice = @localPriceParam, @glocalPrice = @globalPriceParam, @quantity = @quantityParam
			IF EXISTS(SELECT idStore FROM OPENQUERY ([UNITEDSTATESSQL] , 'SELECT idStore FROM [usa_store3].[dbo].[store]') WHERE idStore = @idStoreParam)
				EXECUTE [UNITEDSTATESSQL].[usa_store3].[dbo].[prcUpdateStoreInventory] @idStore = @idStoreParam, @idProduct = @idProductParam, @currency = @currencyParam, @localPrice = @localPriceParam, @glocalPrice = @globalPriceParam, @quantity = @quantityParam
		ELSE IF @country = 'Scotland'
			IF EXISTS(SELECT idStore FROM OPENQUERY ([SCOTLANDSQL] , 'SELECT idStore FROM [stk_store1].[dbo].[store]') WHERE idStore = @idStoreParam)
				EXECUTE [SCOTLANDSQL].[stk_store1].[dbo].[prcUpdateStoreInventory] @idStore = @idStoreParam, @idProduct = @idProductParam, @currency = @currencyParam, @localPrice = @localPriceParam, @glocalPrice = @globalPriceParam, @quantity = @quantityParam
			IF EXISTS(SELECT idStore FROM OPENQUERY ([SCOTLANDSQL] , 'SELECT idStore FROM [stk_store2].[dbo].[store]') WHERE idStore = @idStoreParam)
				EXECUTE [SCOTLANDSQL].[stk_store2].[dbo].[prcUpdateStoreInventory] @idStore = @idStoreParam, @idProduct = @idProductParam, @currency = @currencyParam, @localPrice = @localPriceParam, @glocalPrice = @globalPriceParam, @quantity = @quantityParam
			IF EXISTS(SELECT idStore FROM OPENQUERY ([SCOTLANDSQL] , 'SELECT idStore FROM [stk_store3].[dbo].[store]') WHERE idStore = @idStoreParam)
				EXECUTE [SCOTLANDSQL].[stk_store3].[dbo].[prcUpdateStoreInventory] @idStore = @idStoreParam, @idProduct = @idProductParam, @currency = @currencyParam, @localPrice = @localPriceParam, @glocalPrice = @globalPriceParam, @quantity = @quantityParam
		ELSE IF @country = 'Ireland'
			IF EXISTS(SELECT idStore FROM OPENQUERY ([IRELANDSQL] , 'SELECT idStore FROM [ie_store1].[dbo].[store]') WHERE idStore = @idStoreParam)
				EXECUTE [IRELANDSQL].[ie_store1].[dbo].[prcUpdateStoreInventory] @idStore = @idStoreParam, @idProduct = @idProductParam, @currency = @currencyParam, @localPrice = @localPriceParam, @glocalPrice = @globalPriceParam, @quantity = @quantityParam
			IF EXISTS(SELECT idStore FROM OPENQUERY ([IRELANDSQL] , 'SELECT idStore FROM [ie_store2].[dbo].[store]') WHERE idStore = @idStoreParam)
				EXECUTE [IRELANDSQL].[ie_store2].[dbo].[prcUpdateStoreInventory] @idStore = @idStoreParam, @idProduct = @idProductParam, @currency = @currencyParam, @localPrice = @localPriceParam, @glocalPrice = @globalPriceParam, @quantity = @quantityParam
			IF EXISTS(SELECT idStore FROM OPENQUERY ([IRELANDSQL] , 'SELECT idStore FROM [ie_store3].[dbo].[store]') WHERE idStore = @idStoreParam)
				EXECUTE [IRELANDSQL].[ie_store2].[dbo].[prcUpdateStoreInventory] @idStore = @idStoreParam, @idProduct = @idProductParam, @currency = @currencyParam, @localPrice = @localPriceParam, @glocalPrice = @globalPriceParam, @quantity = @quantityParam
		ELSE
			RAISERROR ( 'Whoops, an error occurred: Country not found', 11, 1);

		SELECT 'Updated';


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

-- EXECUTE prcUpdateStoreInventory

CREATE PROCEDURE prcFindEmploBySotre
@store int,
@idEmployee int,
@country varchar(50)
AS
BEGIN
	BEGIN TRY 
		DECLARE @storesEmployeesMYSQL TABLE
			(idEmployee int, 
			 idDepartment int, 
			 name varchar(30),
			 lastName varchar(30),
			 address varchar(30),
			 telephone varchar(30),
			 birthDate date,
			 createDate date,
			 updateDate date,
			 deleted bit
			);

			DECLARE @storesEmployees TABLE
			(idEmployee int, 
			 localSalary money, 
			 globalSalary money,
			 deleted bit
			);

		insert into @storesEmployeesMYSQL
		select * from OPENQUERY([UNIVERSAL-MYSQL], 'SELECT * FROM employee.employee')
			BEGIN
				IF @country = 'United States'
					insert into @storesEmployees
					EXECUTE [UNITEDSTATESSQL].[usa_user].[dbo].[prcFindEmploBySotre] @store = @store, @idEmployee = @idEmployee;
				ELSE IF @country = 'Scotland'
					insert into @storesEmployees
					EXECUTE [SCOTLANDSQL].[stk_user].[dbo].[prcFindEmploBySotre]@store = @store, @idEmployee =@idEmployee ;
				ELSE IF @country = 'Ireland'
					insert into @storesEmployees
					EXECUTE [IRELANDSQL].[ie_user].[dbo].[prcFindEmploBySotre]@store = @store , @idEmployee = @idEmployee;
				ELSE
					RAISERROR ( 'Whoops, an error occurred.', 11, 1);

          
			END

			select(
			select Eh.idEmployee, Ep.name, Ep.lastName, Ep.birthDate,Eh.localSalary,Eh.globalSalary from @storesEmployeesMYSQL Ep
            inner join (select * from @storesEmployees ) Eh on Eh.idEmployee = Ep.idEmployee
            where Eh.idEmployee = @idEmployee
            FOR JSON AUTO
            )as employees

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

-- EXECUTE prcFindEmploBySotre @store = 1,@idEmployee= 1, @country = 'Ireland'

