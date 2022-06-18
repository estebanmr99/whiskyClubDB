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
--EXECUTE prcFindEmploBySotre @store = 9,@idEmployee= 12, @country = 'United States'



CREATE PROCEDURE prcFindEmployeesBySotre
@store int,
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
					EXECUTE [UNITEDSTATESSQL].[usa_user].[dbo].[prcFindEmployeesBySotre] @store = @store;
				ELSE IF @country = 'Scotland'
					insert into @storesEmployees
					EXECUTE [SCOTLANDSQL].[stk_user].[dbo].[prcFindEmployeesBySotre]@store = @store;
				ELSE IF @country = 'Ireland'
					insert into @storesEmployees
					EXECUTE [IRELANDSQL].[ie_user].[dbo].[prcFindEmployeesBySotre]@store = @store ;
				ELSE
					RAISERROR ( 'Whoops, an error occurred.', 11, 1);

          
			END

			select(
			select Eh.idEmployee, Ep.name, Ep.lastName, Ep.birthDate,Eh.localSalary,Eh.globalSalary from @storesEmployeesMYSQL Ep
            inner join (select * from @storesEmployees ) Eh on Eh.idEmployee = Ep.idEmployee
            where Eh.deleted = 0
            FOR JSON AUTO
            )as employees

        SELECT 'Succes';

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





CREATE PROCEDURE CRUD_product_type
	@idType INT,
    @name VARCHAR(50),
	@action CHAR(1)
AS
  BEGIN TRY   -- statements that may cause exceptions

	DECLARE @update VARCHAR(max),@delete VARCHAR(max)

	SET @delete = (SELECT CONCAT('UPDATE product.product_type SET deleted = 1 ',
					'WHERE idType=',
					QUOTENAME(@idType,'()')));

	SET @update = (SELECT CONCAT('UPDATE product.product_type SET name=',
					QUOTENAME(@name,''''),
					' WHERE idType=',
					QUOTENAME(@idType,'()')));

	IF @action = 'C'
	BEGIN 

	INSERT OPENQUERY([UNIVERSAL-MYSQL], 'SELECT name,deleted FROM product.product_type')   
    VALUES(@name,0)
		
	END
	IF @action = 'R'
	BEGIN 

	SELECT idType,name,deleted FROM OPENQUERY([UNIVERSAL-MYSQL], 'SELECT idType,name,deleted FROM product.product_type')  

	END
	IF @action='U'
	BEGIN 
		EXEC(@update)AT [UNIVERSAL-MYSQL] 
	END
	IF @action= 'D'
	BEGIN
		EXEC(@delete)AT [UNIVERSAL-MYSQL] 
	END;
	 
END TRY  
BEGIN CATCH  -- statements that handle exception
			 SELECT  
            ERROR_NUMBER() AS ErrorNumber  
            ,ERROR_SEVERITY() AS ErrorSeverity  
            ,ERROR_STATE() AS ErrorState  
            ,ERROR_PROCEDURE() AS ErrorProcedure  
            ,ERROR_LINE() AS ErrorLine  
            ,ERROR_MESSAGE() AS ErrorMessage;
END CATCH  





--
CREATE PROCEDURE prcUpdateEmploBySotre
@store int,
@idEmployee int,
@name varchar(50),
@lastName varchar(50),
@birthDate varchar(50),
@localSalary money,
@globalSalary money,
@country varchar(50)
AS
BEGIN
	BEGIN TRY 
		DECLARE @select varchar(150),@update varchar(150),@sql varchar(300)
		set @select = 'update OPENQUERY([UNIVERSAL-MYSQL],
					''SELECT idEmployee,name,lastName,birthDate,updateDate FROM employee.employee where (idEmployee ='+ CAST(@idEmployee as nvarchar(30))+')'')'
		set @update = 'set name = '+QUOTENAME(@name,'''')+   
					   ', lastName = '+QUOTENAME(@lastName,'''')+
					   ', birthDate = '+QUOTENAME(@birthDate,'''')+
					   ', updateDate = '+QUOTENAME((SELECT CONVERT(varchar, getdate(), 23)),'''')

		set @sql = @select + @update


        BEGIN
            IF @country = 'United States'
					EXECUTE [UNITEDSTATESSQL].[usa_user].[dbo].[prcUpdateEmploBySotre] @store=@store, @idEmployee = @idEmployee, @localSalary = @localSalary, @globalSalary=@globalSalary ;
				ELSE IF @country = 'Scotland'
					EXECUTE [SCOTLANDSQL].[stk_user].[dbo].[prcUpdateEmploBySotre] @store=@store, @idEmployee = @idEmployee, @localSalary = @localSalary, @globalSalary=@globalSalary ;
				ELSE IF @country = 'Ireland'
					EXECUTE [IRELANDSQL].[ie_user].[dbo].[prcUpdateEmploBySotre] @store=@store, @idEmployee = @idEmployee, @localSalary = @localSalary, @globalSalary=@globalSalary;
				ELSE
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


--EXEC prcUpdateEmploBySotre
--@store =7,
--@idEmployee =10,
--@name ='froilan',
--@lastName ='velasuqez',
--@birthDate ='31-12-2020',
--@localSalary =1000,
--@globalSalary =0,
--@country= 'United States'


--select * from [UNITEDSTATESSQL].[usa_store1].[dbo].[employee]

CREATE PROCEDURE prcInsertEmploBySotre
@store int,
@name varchar(50),
@lastName varchar(50),
@birthDate date,
@localSalary money,
@globalSalary money,
@country varchar(50)
AS
BEGIN
	BEGIN TRY 
        DECLARE @maxIDuser int;
        SET @maxIDuser = 0; 
		SELECT @maxIDuser = MAX(idEmployee) FROM OPENQUERY([UNIVERSAL-MYSQL], 'SELECT idEmployee FROM employee.employee')
		SET @maxIDuser = @maxIDuser+1; 
        
			BEGIN
					INSERT OPENQUERY([UNIVERSAL-MYSQL], 'SELECT idEmployee,name,lastName,birthDate,createDate,updateDate,deleted FROM employee.employee')   
					VALUES(@maxIDuser,@name,@lastName,@birthDate,(SELECT GETDATE()),(SELECT GETDATE()),0)
            IF @country = 'United States'

					EXECUTE [UNITEDSTATESSQL].[usa_user].[dbo].[prcInsertEmploBySotre] @store=@store, @idEmployee = @maxIDuser, @localSalary = @localSalary, @globalSalary=@globalSalary ;
				
			ELSE IF @country = 'Scotland'

					EXECUTE [SCOTLANDSQL].[stk_user].[dbo].[prcInsertEmploBySotre] @store=@store, @idEmployee = @maxIDuser, @localSalary = @localSalary, @globalSalary=@globalSalary ;
					
			ELSE IF @country = 'Ireland'

					EXECUTE [IRELANDSQL].[ie_user].[dbo].[prcInsertEmploBySotre] @store=@store, @idEmployee = @maxIDuser, @localSalary = @localSalary, @globalSalary=@globalSalary;
					
			ELSE
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



CREATE PROCEDURE prcDeleteEmploBySotre
@store int,
@idEmployee int,
@country varchar(50)
AS
BEGIN
	BEGIN TRY 
			
			DECLARE @select varchar(150),@update varchar(150),@sql varchar(300)
		set @select = 'update OPENQUERY([UNIVERSAL-MYSQL],
					''SELECT idEmployee,deleted FROM employee.employee where (idEmployee ='+ CAST(@idEmployee as nvarchar(30))+')'')'
		set @update = 'set deleted = 1'

		set @sql = @select + @update
		EXEC(@sql)


        
            BEGIN
					
            IF @country = 'United States'

					EXECUTE [UNITEDSTATESSQL].[usa_user].[dbo].[prcDeleteEmploBySotre] @store=@store, @idEmployee = @idEmployee;
			ELSE IF @country = 'Scotland'

					EXECUTE [SCOTLANDSQL].[stk_user].[dbo].[prcDeleteEmploBySotre] @store=@store, @idEmployee = @idEmployee;
					
			ELSE IF @country = 'Ireland'

					EXECUTE [IRELANDSQL].[ie_user].[dbo].[prcDeleteEmploBySotre] @store=@store, @idEmployee = @idEmployee;
					
			ELSE
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



CREATE PROCEDURE prcCreateProduct
@nameParam varchar(50),
@typeParam int,
@agedParam varchar(10),
@presentationParam varchar(150),
@imageParam nvarchar(MAX),
@globalPriceParam money
AS
BEGIN
	BEGIN TRY 
	 
	 DECLARE @maxIDProduct int;
        SET @maxIDProduct = 0; 
		SELECT @maxIDProduct = MAX(idProduct) FROM OPENQUERY([UNIVERSAL-MYSQL], 'SELECT idProduct FROM product.product')
		SET @maxIDProduct = @maxIDProduct+1; 



			BEGIN
					
					--insert product on the universal product database on MYSQL
					INSERT OPENQUERY([UNIVERSAL-MYSQL], 'SELECT idProduct,idType,name,features,image,createDate,updateDate,deleted FROM product.product')   
					VALUES(@maxIDProduct,@typeParam,@nameParam,'{"Aged": "@agedParam", "Presentation": "@presentationParam"}',TO_BASE64(@imageParam),(SELECT GETDATE()),(SELECT GETDATE()),0)


					--insert products on stores in the US
					EXECUTE [UNITEDSTATESSQL].[usa_user].[dbo].[prcCreateProduct]  @idProduct = @maxIDProduct, @globalPrice = @globalPriceParam, @image = @imageParam;
					--insert products on stores in STK
					EXECUTE [SCOTLANDSQL].[stk_user].[dbo].[prcCreateProduct]  @idProduct = @maxIDProduct, @globalPrice = @globalPriceParam, @image = @imageParam;
					--insert products on stores in IE
					EXECUTE [IRELANDSQL].[ie_user].[dbo].[prcCreateProduct]  @idProduct = @maxIDProduct, @globalPrice = @globalPriceParam, @image = @imageParam;
			END
		
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

CREATE PROCEDURE prcUpdateStoreInventory
@searchQuery varchar(255),
@idUserParam int,
@idType int,
@distance int,
@price int,
@order varchar(30),
@country varchar(30)
AS
BEGIN
	BEGIN TRY

		DECLARE @storeProducts TABLE (idStore int, idProduct int, storeName varchar(50), storeLocation geography, productQuantity int, currency varchar(30), localPrice int, globalPrice int, distanceUser int, idType int, productName varchar(50), features varchar(8000), [image] varchar(MAX), sales int)

		IF @country = 'United States'
			INSERT INTO @storeProducts (idStore, idProduct, storeName, storeLocation, productQuantity, currency, localPrice, globalPrice, distanceUser)
			EXECUTE [UNITEDSTATESSQL].[usa_store1].[dbo].[prcGetAllStoresInventory] @idUser = @idUserParam
		ELSE IF @country = 'Scotland'
			INSERT INTO @storeProducts (idStore, idProduct, storeName, storeLocation, productQuantity, currency, localPrice, globalPrice, distanceUser)
			EXECUTE [SCOTLANDSQL].[stk_store1].[dbo].[prcGetAllStoresInventory] @idUser = @idUserParam
		ELSE IF @country = 'Ireland'
			INSERT INTO @storeProducts (idStore, idProduct, storeName, storeLocation, productQuantity, currency, localPrice, globalPrice, distanceUser)
			EXECUTE [IRELANDSQL].[ie_store1].[dbo].[prcGetAllStoresInventory] @idUser = @idUserParam
		ELSE
			RAISERROR ( 'Whoops, an error occurred: Country not found', 11, 1);

		DECLARE @products TABLE (idProduct int, idType int, productName varchar(50), features varchar(8000), [image] varchar(MAX), sales int)
		INSERT INTO @products
		EXEC ('CALL product.prcGetProductsWithSales()') at [UNIVERSAL-MYSQL];

		UPDATE sp
		SET sp.idType = p.idType, sp.productName = p.productName, sp.features = p.features, sp.image = p.image, sp.sales = p.sales
		FROM @storeProducts as sp
		INNER JOIN @products as p on sp.idProduct = p.idProduct

		IF @order = 'Asc'
			SELECT idStore, idProduct, storeName storeLocation, productQuantity, currency, localPrice, globalPrice, distanceUser, idType, productName, features, [image], sales 
			FROM @storeProducts
			WHERE (productName LIKE '%' + @searchQuery + '%') AND 
					(idType = isnull(@idType, idType)) AND 
					(distanceUser <= isnull(@distance, distanceUser)) AND 
					(localPrice <= isnull(@price, localPrice))
			ORDER BY productName ASC
		ELSE IF @order = 'Desc'
			SELECT idStore, idProduct, storeName storeLocation, productQuantity, currency, localPrice, globalPrice, distanceUser, idType, productName, features, [image], sales 
			FROM @storeProducts
			WHERE (productName LIKE '%' + @searchQuery + '%') AND 
					(idType = isnull(@idType, idType)) AND 
					(distanceUser <= isnull(@distance, distanceUser)) AND 
					(localPrice <= isnull(@price, localPrice))
			ORDER BY productName DESC
		ELSE IF @order = 'Popular'
			SELECT idStore, idProduct, storeName storeLocation, productQuantity, currency, localPrice, globalPrice, distanceUser, idType, productName, features, [image], sales 
			FROM @storeProducts
			WHERE (productName LIKE '%' + @searchQuery + '%') AND 
					(idType = isnull(@idType, idType)) AND 
					(distanceUser <= isnull(@distance, distanceUser)) AND 
					(localPrice <= isnull(@price, localPrice))
			ORDER BY sales DESC
		ELSE
			RAISERROR ( 'Whoops, an error occurred: Order not possible', 11, 1);

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

-- EXECUTE prcUpdateStoreInventory @searchQuery = '', @idUserParam = 0, @idType = null, @distance = null, @price = null, @order = 'Popular', @country = 'United States'