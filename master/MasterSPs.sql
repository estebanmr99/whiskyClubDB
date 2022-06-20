-- Mater database stored procedures
-- The procedures all run in the local machine.

CREATE PROCEDURE prcFindUserByEmail
@emailParam varchar(50),
@select bit = 1
AS
BEGIN
	BEGIN TRY
		-- The result of this operation quickly removes all data from a table
		TRUNCATE TABLE [masterdb].[dbo].[tempUserJson]
		-- call sp in USA instance to search for certain user by email, and if founded, insert into temporal table
		INSERT INTO [masterdb].[dbo].[tempUserJson]
		EXECUTE [UNITEDSTATESSQL].[usa_user].[dbo].[prcFindUserByEmail] @email = @emailParam;
		
		-- call sp in SCOTLAND instance to search for certain user by email, and if founded, insert into temporal table
		INSERT INTO [masterdb].[dbo].[tempUserJson]
		EXECUTE [SCOTLANDSQL].[stk_user].[dbo].[prcFindUserByEmail] @email = @emailParam;

		-- call sp in IRELAND instance to search for certain user by email, and if founded, insert into temporal table
		INSERT INTO [masterdb].[dbo].[tempUserJson]
		EXECUTE [IRELANDSQL].[ie_user].[dbo].[prcFindUserByEmail] @email = @emailParam;
		
		-- Delete table if nothing is found
		DELETE [masterdb].[dbo].[tempUserJson] WHERE userFound IS NULL;

		IF @select = 1
			-- return table if user is found
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
		-- The result of this operation quickly removes all data from a table
		TRUNCATE TABLE [masterdb].[dbo].[tempNextUserId];
		DECLARE @maxIDuser INT;
		
		-- call sp in USA instance to search for the max idUser , insert into temporal table
		INSERT INTO [masterdb].[dbo].[tempNextUserId]
		EXECUTE [UNITEDSTATESSQL].[usa_user].[dbo].[prcGetNextUserId];
		
		-- call sp in SCOTLAND instance to search for the max idUser , insert into temporal table
		INSERT INTO [masterdb].[dbo].[tempNextUserId]
		EXECUTE [SCOTLANDSQL].[stk_user].[dbo].[prcGetNextUserId];
		
		-- call sp in IRELAND instance to search for the max idUser , insert into temporal table
		INSERT INTO [masterdb].[dbo].[tempNextUserId]
		EXECUTE [IRELANDSQL].[ie_user].[dbo].[prcGetNextUserId];
			
		-- Get the max idUser for temp table +1, for the new insert of data
		SELECT @maxIDuser = (MAX(maxIDuser) + 1) FROM [masterdb].[dbo].[tempNextUserId];
		
		--insert the new maxIdUser 
		INSERT INTO [masterdb].[dbo].[tempNextUserId]
		VALUES (@maxIDuser);
		-- remove all idUsers that are less than the new maxIdUser from temp table
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
		-- validate if the user already exist
		EXECUTE [masterdb].[dbo].[prcFindUserByEmail] @emailParam = @emailParam, @select = 0;

		IF NOT EXISTS (SELECT * FROM [masterdb].[dbo].[tempUserJson])
			BEGIN
				--call sp for next user id
				EXECUTE [masterdb].[dbo].[prcGetNextUserId] @select = 0;
				
				-- declare new MaxIdUSer
				DECLARE @maxIDuser int;
				SELECT @maxIDuser = MAX(maxIDuser) FROM [dbo].[tempNextUserId];
				
				-- find the country of the new user for calling sp on that instance
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
		-- The result of this operation quickly removes all data from a table
		TRUNCATE TABLE [masterdb].[dbo].[tempProductJson]
		
		-- call sp in USA instance to search for certain product by name, and if founded, insert into temporal table
		INSERT INTO [masterdb].[dbo].[tempProductJson]
		EXECUTE [UNITEDSTATESSQL].[usa_user].[dbo].[prcFindProductByName] @name = @nameParam;
		
		-- call sp in SCOTLAND instance to search for certain product by name, and if founded, insert into temporal table
		INSERT INTO [masterdb].[dbo].[tempProductJson]
		EXECUTE [SCOTLANDSQL].[stk_user].[dbo].[prcFindProductByName] @name = @nameParam;
		
		-- call sp in IRELAND instance to search for certain product by name, and if founded, insert into temporal table
		INSERT INTO [masterdb].[dbo].[tempProductJson]
		EXECUTE [IRELANDSQL].[ie_user].[dbo].[prcFindProductByName] @name = @nameParam;
		
		-- delete table if productFound is null (there is no product with the same name)
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

-- Store procedure for subscriptions
CREATE PROCEDURE prcSubscription
@idUser int,
@idLevel int,
@country varchar(30)

AS
BEGIN
	BEGIN TRY 
			BEGIN
			-- find the country of the user 

				IF @country = 'United States'
					--call procedure on the country instance
					EXECUTE [UNITEDSTATESSQL].[usa_user].[dbo].[prcSubscription] @iduser = @iduser, @idLevel = @idLevel;
				ELSE IF @country = 'Scotland'
					--call procedure on the country instance
					EXECUTE [SCOTLANDSQL].[stk_user].[dbo].[prcSubscription] @iduser = @iduser, @idLevel = @idLevel;
				ELSE IF @country = 'Ireland'
					--call procedure on the country instance
					EXECUTE [IRELANDSQL].[ie_user].[dbo].[prcSubscription] @iduser = @iduser, @idLevel = @idLevel;
				ELSE
					--print error 
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

-- Stored procedure to return information from each store
CREATE PROCEDURE prcGetStoresInfo
AS
BEGIN
	BEGIN TRY
		DECLARE @storesInfo TABLE
		(idStore int, 
		 name varchar(50),
		 country varchar(30)
		);

		-- call sp to insert Ireland stores info on the @storesInfo table
		INSERT INTO @storesInfo
		EXECUTE [IRELANDSQL].[ie_store1].[dbo].[prcGetStoresInfo]

		-- call sp to insert Scotland stores info on the @storesInfo table
		INSERT INTO @storesInfo
		EXECUTE [SCOTLANDSQL].[stk_store1].[dbo].[prcGetStoresInfo]

		-- call sp to insert USA stores info on the @storesInfo table
		INSERT INTO @storesInfo
		EXECUTE [UNITEDSTATESSQL].[usa_store1].[dbo].[prcGetStoresInfo]
		
		-- return info of all the stores
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

-- Procedure to return information of each product
CREATE PROCEDURE prcGetProductsInfo
AS
BEGIN
	BEGIN TRY
		-- declare table for storing the product info 
		DECLARE @productsInfo TABLE
		(idProduct int, 
		 name varchar(50)
		);
		
		-- insert the info from mysql into the table 
		INSERT INTO @productsInfo
		SELECT * FROM OPENQUERY ([UNIVERSAL-MYSQL] , 'SELECT idProduct, name FROM product.product')
		
		--return data as json 
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
-- Procedure to return all stores inventory
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

		-- return data as json if they were retrieved successfully
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
-- Pocedure to update the inventory of each store
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
		-- Filter by country
		IF @country = 'United States'
		BEGIN
			-- update on the correct store in the United States
			IF EXISTS(SELECT idStore FROM OPENQUERY ([UNITEDSTATESSQL] , 'SELECT idStore FROM [usa_store1].[dbo].[store]') WHERE idStore = @idStoreParam)
				EXECUTE [UNITEDSTATESSQL].[usa_store1].[dbo].[prcUpdateStoreInventory] @idStore = @idStoreParam, @idProduct = @idProductParam, @currency = @currencyParam, @localPrice = @localPriceParam, @globalPrice = @globalPriceParam, @quantity = @quantityParam
			IF EXISTS(SELECT idStore FROM OPENQUERY ([UNITEDSTATESSQL] , 'SELECT idStore FROM [usa_store2].[dbo].[store]') WHERE idStore = @idStoreParam)
				EXECUTE [UNITEDSTATESSQL].[usa_store2].[dbo].[prcUpdateStoreInventory] @idStore = @idStoreParam, @idProduct = @idProductParam, @currency = @currencyParam, @localPrice = @localPriceParam, @globalPrice = @globalPriceParam, @quantity = @quantityParam
			IF EXISTS(SELECT idStore FROM OPENQUERY ([UNITEDSTATESSQL] , 'SELECT idStore FROM [usa_store3].[dbo].[store]') WHERE idStore = @idStoreParam)
				EXECUTE [UNITEDSTATESSQL].[usa_store3].[dbo].[prcUpdateStoreInventory] @idStore = @idStoreParam, @idProduct = @idProductParam, @currency = @currencyParam, @localPrice = @localPriceParam, @globalPrice = @globalPriceParam, @quantity = @quantityParam
		END
		ELSE IF @country = 'Scotland'
		BEGIN
			-- update on the correct store in the Scotland
			IF EXISTS(SELECT idStore FROM OPENQUERY ([SCOTLANDSQL] , 'SELECT idStore FROM [stk_store1].[dbo].[store]') WHERE idStore = @idStoreParam)
				EXECUTE [SCOTLANDSQL].[stk_store1].[dbo].[prcUpdateStoreInventory] @idStore = @idStoreParam, @idProduct = @idProductParam, @currency = @currencyParam, @localPrice = @localPriceParam, @globalPrice = @globalPriceParam, @quantity = @quantityParam
			IF EXISTS(SELECT idStore FROM OPENQUERY ([SCOTLANDSQL] , 'SELECT idStore FROM [stk_store2].[dbo].[store]') WHERE idStore = @idStoreParam)
				EXECUTE [SCOTLANDSQL].[stk_store2].[dbo].[prcUpdateStoreInventory] @idStore = @idStoreParam, @idProduct = @idProductParam, @currency = @currencyParam, @localPrice = @localPriceParam, @globalPrice = @globalPriceParam, @quantity = @quantityParam
			IF EXISTS(SELECT idStore FROM OPENQUERY ([SCOTLANDSQL] , 'SELECT idStore FROM [stk_store3].[dbo].[store]') WHERE idStore = @idStoreParam)
				EXECUTE [SCOTLANDSQL].[stk_store3].[dbo].[prcUpdateStoreInventory] @idStore = @idStoreParam, @idProduct = @idProductParam, @currency = @currencyParam, @localPrice = @localPriceParam, @globalPrice = @globalPriceParam, @quantity = @quantityParam
		END
		ELSE IF @country = 'Ireland'
		BEGIN
			-- update on the correct store in the Ireland
			IF EXISTS(SELECT idStore FROM OPENQUERY ([IRELANDSQL] , 'SELECT idStore FROM [ie_store1].[dbo].[store]') WHERE idStore = @idStoreParam)
				EXECUTE [IRELANDSQL].[ie_store1].[dbo].[prcUpdateStoreInventory] @idStore = @idStoreParam, @idProduct = @idProductParam, @currency = @currencyParam, @localPrice = @localPriceParam, @globalPrice = @globalPriceParam, @quantity = @quantityParam
			IF EXISTS(SELECT idStore FROM OPENQUERY ([IRELANDSQL] , 'SELECT idStore FROM [ie_store2].[dbo].[store]') WHERE idStore = @idStoreParam)
				EXECUTE [IRELANDSQL].[ie_store2].[dbo].[prcUpdateStoreInventory] @idStore = @idStoreParam, @idProduct = @idProductParam, @currency = @currencyParam, @localPrice = @localPriceParam, @globalPrice = @globalPriceParam, @quantity = @quantityParam
			IF EXISTS(SELECT idStore FROM OPENQUERY ([IRELANDSQL] , 'SELECT idStore FROM [ie_store3].[dbo].[store]') WHERE idStore = @idStoreParam)
				EXECUTE [IRELANDSQL].[ie_store2].[dbo].[prcUpdateStoreInventory] @idStore = @idStoreParam, @idProduct = @idProductParam, @currency = @currencyParam, @localPrice = @localPriceParam, @globalPrice = @globalPriceParam, @quantity = @quantityParam
		END
		ELSE
		BEGIN
			-- if country is not specified, return error
			RAISERROR ( 'Whoops, an error occurred: Country not found', 11, 1);
		END

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
-- procedure to find a employee by id
CREATE PROCEDURE prcFindEmployeeByStore
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
		-- insert all employees from Mysql universal database
		insert into @storesEmployeesMYSQL
		select * from OPENQUERY([UNIVERSAL-MYSQL], 'SELECT * FROM employee.employee')
			BEGIN
				-- call procedure on the country of the user
				IF @country = 'United States'
					-- insert all employees from selected store
					insert into @storesEmployees
					EXECUTE [UNITEDSTATESSQL].[usa_user].[dbo].[prcFindEmployeeByStore] @store = @store, @idEmployee = @idEmployee;
				ELSE IF @country = 'Scotland'
					-- insert all employees from selected store
					insert into @storesEmployees
					EXECUTE [SCOTLANDSQL].[stk_user].[dbo].[prcFindEmployeeByStore]@store = @store, @idEmployee =@idEmployee ;
				ELSE IF @country = 'Ireland'
					-- insert all employees from selected store
					insert into @storesEmployees
					EXECUTE [IRELANDSQL].[ie_user].[dbo].[prcFindEmployeeByStore]@store = @store , @idEmployee = @idEmployee;
				ELSE
					RAISERROR ( 'Whoops, an error occurred.', 11, 1);

          
			END
			
			-- select employee an returned it as a json
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

-- EXECUTE prcFindEmployeeByStore @store = 1,@idEmployee= 1, @country = 'Ireland'
--EXECUTE prcFindEmployeeByStore @store = 9,@idEmployee= 12, @country = 'United States'

-- procedure to get all employees from a store
CREATE PROCEDURE prcFindEmployeesByStore
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
			
		-- insert all employees from Mysql universal database
		insert into @storesEmployeesMYSQL
		select * from OPENQUERY([UNIVERSAL-MYSQL], 'SELECT * FROM employee.employee')
			BEGIN
				IF @country = 'United States'
					-- insert all employees from selected store
					insert into @storesEmployees
					EXECUTE [UNITEDSTATESSQL].[usa_user].[dbo].[prcFindEmployeesByStore] @store = @store;
				ELSE IF @country = 'Scotland'
					-- insert all employees from selected store
					insert into @storesEmployees
					EXECUTE [SCOTLANDSQL].[stk_user].[dbo].[prcFindEmployeesByStore]@store = @store;
				ELSE IF @country = 'Ireland'
					-- insert all employees from selected store
					insert into @storesEmployees
					EXECUTE [IRELANDSQL].[ie_user].[dbo].[prcFindEmployeesByStore]@store = @store ;
				ELSE
					RAISERROR ( 'Whoops, an error occurred.', 11, 1);

          
			END

			-- select all employees that are not deleted an returned it as a json
			select(
			select Eh.idEmployee, Ep.name, Ep.lastName, Ep.birthDate,Eh.localSalary,Eh.globalSalary from @storesEmployeesMYSQL Ep
            inner join (select * from @storesEmployees ) Eh on Eh.idEmployee = Ep.idEmployee
            where Ep.deleted = 0
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

-- procedure to perform CRUD operations on product types
CREATE PROCEDURE CRUD_product_type
	@idType INT = null,
    @name VARCHAR(50) = null,
	@action CHAR(1)
AS
  BEGIN TRY   -- statements that may cause exceptions

	DECLARE @update VARCHAR(max),@delete VARCHAR(max)

	-- prepare for delete operation
	SET @delete = (SELECT CONCAT('UPDATE product.product_type SET deleted = 1 ',
					'WHERE idType=',
					QUOTENAME(@idType,'()')));

	-- prepare for update operation
	SET @update = (SELECT CONCAT('UPDATE product.product_type SET name=',
					QUOTENAME(@name,''''),
					' WHERE idType=',
					QUOTENAME(@idType,'()')));

	-- if create
	IF @action = 'C'
		BEGIN 

			INSERT OPENQUERY([UNIVERSAL-MYSQL], 'SELECT name, deleted FROM product.product_type')   
			VALUES(@name,0)
			
		END
	-- if read
	IF @action = 'R'
		BEGIN 
			DECLARE @types TABLE (idType int, name varchar(255));

			INSERT INTO @types
			SELECT idType, name FROM OPENQUERY([UNIVERSAL-MYSQL], 'SELECT idType,name,deleted FROM product.product_type') WHERE deleted = 0

			SELECT(SELECT idType, name FROM @types FOR JSON AUTO) as productTypes

		END
	-- if update
	IF @action='U'
		BEGIN 
			EXEC(@update) AT [UNIVERSAL-MYSQL] 
		END
	-- if delete
	IF @action= 'D'
		BEGIN
			EXEC(@delete) AT [UNIVERSAL-MYSQL] 
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

-- EXECUTE CRUD_product_type @action = 'R'

-- procedure to update employee in store
CREATE PROCEDURE prcUpdateEmployeeByStore
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
		--update employee on Universal mysql database
		DECLARE @select varchar(150),@update varchar(150),@sql varchar(300)
		set @select = 'update OPENQUERY([UNIVERSAL-MYSQL],
					''SELECT idEmployee,name,lastName,birthDate,updateDate FROM employee.employee where (idEmployee ='+ CAST(@idEmployee as nvarchar(30))+')'')'
		set @update = 'set name = '+QUOTENAME(@name,'''')+   
					   ', lastName = '+QUOTENAME(@lastName,'''')+
					   ', birthDate = '+QUOTENAME(@birthDate,'''')+
					   ', updateDate = '+QUOTENAME((SELECT CONVERT(varchar, getdate(), 23)),'''')

		set @sql = @select + @update
		exec(@sql);

        	BEGIN		
				-- call procedure on the country of the user
            	IF @country = 'United States'
					EXECUTE [UNITEDSTATESSQL].[usa_user].[dbo].[prcUpdateEmployeeByStore] @store=@store, @idEmployee = @idEmployee, @localSalary = @localSalary, @globalSalary=@globalSalary ;
				ELSE IF @country = 'Scotland'
					EXECUTE [SCOTLANDSQL].[stk_user].[dbo].[prcUpdateEmployeeByStore] @store=@store, @idEmployee = @idEmployee, @localSalary = @localSalary, @globalSalary=@globalSalary ;
				ELSE IF @country = 'Ireland'
					EXECUTE [IRELANDSQL].[ie_user].[dbo].[prcUpdateEmployeeByStore] @store=@store, @idEmployee = @idEmployee, @localSalary = @localSalary, @globalSalary=@globalSalary;
				ELSE
					RAISERROR ( 'Whoops, an error occurred.', 11, 1);
            END
		SELECT 'SUCCES'
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


--EXEC prcUpdateEmployeeByStore
--@store =7,
--@idEmployee =10,
--@name ='froilan',
--@lastName ='velasuqez',
--@birthDate ='31-12-2020',
--@localSalary =1000,
--@globalSalary =0,
--@country= 'United States'

-- Procedure to create a new employee
CREATE PROCEDURE prcInsertEmployeeByStore
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
	-- get the max idEmployee +1 and set it as the new idEmployee for the new insert
        DECLARE @maxIDuser int;
        SET @maxIDuser = 0; 
		SELECT @maxIDuser = MAX(idEmployee) FROM OPENQUERY([UNIVERSAL-MYSQL], 'SELECT idEmployee FROM employee.employee')
		SET @maxIDuser = @maxIDuser+1; 
        
			BEGIN	
				-- insert the new employee into the universal Mysql employee database
				INSERT OPENQUERY([UNIVERSAL-MYSQL], 'SELECT idEmployee,name,lastName,birthDate,createDate,updateDate,deleted FROM employee.employee')   
				VALUES(@maxIDuser,@name,@lastName,@birthDate,(SELECT GETDATE()),(SELECT GETDATE()),0)
						
			-- call procedure on the country of the user
            IF @country = 'United States'

					EXECUTE [UNITEDSTATESSQL].[usa_user].[dbo].[prcInsertEmployeeByStore] @store=@store, @idEmployee = @maxIDuser, @localSalary = @localSalary, @globalSalary=@globalSalary ;
				
			ELSE IF @country = 'Scotland'

					EXECUTE [SCOTLANDSQL].[stk_user].[dbo].[prcInsertEmployeeByStore] @store=@store, @idEmployee = @maxIDuser, @localSalary = @localSalary, @globalSalary=@globalSalary ;
					
			ELSE IF @country = 'Ireland'

					EXECUTE [IRELANDSQL].[ie_user].[dbo].[prcInsertEmployeeByStore] @store=@store, @idEmployee = @maxIDuser, @localSalary = @localSalary, @globalSalary=@globalSalary;
					
			ELSE
					RAISERROR ( 'Whoops, an error occurred.', 11, 1);
            END
		SELECT 'Success'
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


-- Procedure to delete a employee by store and idEmployee
CREATE PROCEDURE prcDeleteEmployeeByStore
@store int,
@idEmployee int,
@country varchar(50)
AS
BEGIN
	BEGIN TRY 
		-- Update Universal Mysql employee database to deleted =1 on the selected idEmployee
		DECLARE @select varchar(150),@update varchar(150),@sql varchar(300)
		set @select = 'update OPENQUERY([UNIVERSAL-MYSQL],
					''SELECT idEmployee,deleted FROM employee.employee where (idEmployee ='+ CAST(@idEmployee as nvarchar(30))+')'')'
		set @update = 'set deleted = 1'

		set @sql = @select + @update
		EXEC(@sql)

        BEGIN
	    	--find the country of the user and call the procedure for deleting the user by setting deleted =1			
            IF @country = 'United States'

					EXECUTE [UNITEDSTATESSQL].[usa_user].[dbo].[prcDeleteEmployeeByStore] @Store=@store, @IdEmployee = @idEmployee;
			ELSE IF @country = 'Scotland'

					EXECUTE [SCOTLANDSQL].[stk_user].[dbo].[prcDeleteEmployeeByStore] @store=@store, @idEmployee = @idEmployee;
					
			ELSE IF @country = 'Ireland'

					EXECUTE [IRELANDSQL].[ie_user].[dbo].[prcDeleteEmployeeByStore] @store=@store, @idEmployee = @idEmployee;
					
			ELSE
					RAISERROR ( 'Whoops, an error occurred.', 11, 1);
            END
		SELECT 'Succes'
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

-- Procedure to get all information about products by country and apply a filters
CREATE PROCEDURE prcGetAllProducts
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
		-- create table to store the products
		DECLARE @storeProducts TABLE (idStore int, idProduct int, storeName varchar(50), storeLocation geography, productQuantity int, currency varchar(30), localPrice int, globalPrice int, distanceUser int, idType int, productName varchar(50), features varchar(8000), [image] varchar(MAX), sales int)

		-- filter by country
		IF @country = 'United States'
			-- Get inventory from United States stores
			INSERT INTO @storeProducts (idStore, idProduct, storeName, storeLocation, productQuantity, currency, localPrice, globalPrice, distanceUser)
			EXECUTE [UNITEDSTATESSQL].[usa_store1].[dbo].[prcGetAllStoresInventory] @idUser = @idUserParam
		ELSE IF @country = 'Scotland'
			-- Get inventory from Scotland stores
			INSERT INTO @storeProducts (idStore, idProduct, storeName, storeLocation, productQuantity, currency, localPrice, globalPrice, distanceUser)
			EXECUTE [SCOTLANDSQL].[stk_store1].[dbo].[prcGetAllStoresInventory] @idUser = @idUserParam
		ELSE IF @country = 'Ireland'
			-- Get inventory from Ireland stores
			INSERT INTO @storeProducts (idStore, idProduct, storeName, storeLocation, productQuantity, currency, localPrice, globalPrice, distanceUser)
			EXECUTE [IRELANDSQL].[ie_store1].[dbo].[prcGetAllStoresInventory] @idUser = @idUserParam
		ELSE
			RAISERROR ( 'Whoops, an error occurred: Country not found', 11, 1);

		-- Get all products information from mysql database
		DECLARE @products TABLE (idProduct int, idType int, productName varchar(50), features varchar(8000), [image] varchar(MAX), sales int)
		INSERT INTO @products
		EXEC ('CALL product.prcGetProductsWithSales()') at [UNIVERSAL-MYSQL];

		-- update the variable table with the information from the products table
		UPDATE sp
		SET sp.idType = p.idType, sp.productName = p.productName, sp.features = p.features, sp.image = p.image, sp.sales = p.sales
		FROM @storeProducts as sp
		INNER JOIN @products as p on sp.idProduct = p.idProduct

		-- return products based on order and apply filters
		IF @order = 'Asc'
			SELECT (
			SELECT idStore, idProduct, storeName storeLocation, productQuantity, currency, localPrice, globalPrice, distanceUser, idType, productName, features, [image], sales 
			FROM @storeProducts
			WHERE (productName LIKE '%' + @searchQuery + '%') AND 
					(idType = isnull(@idType, idType)) AND 
					(distanceUser <= isnull(@distance, distanceUser)) AND 
					(localPrice <= isnull(@price, localPrice))
			ORDER BY productName ASC FOR JSON AUTO ) AS allProducts
		ELSE IF @order = 'Desc'
			SELECT (
			SELECT idStore, idProduct, storeName storeLocation, productQuantity, currency, localPrice, globalPrice, distanceUser, idType, productName, features, [image], sales 
			FROM @storeProducts
			WHERE (productName LIKE '%' + @searchQuery + '%') AND 
					(idType = isnull(@idType, idType)) AND 
					(distanceUser <= isnull(@distance, distanceUser)) AND 
					(localPrice <= isnull(@price, localPrice))
			ORDER BY productName DESC FOR JSON AUTO ) AS allProducts
		ELSE IF @order = 'Popular'
			SELECT (
			SELECT idStore, idProduct, storeName storeLocation, productQuantity, currency, localPrice, globalPrice, distanceUser, idType, productName, features, [image], sales 
			FROM @storeProducts
			WHERE (productName LIKE '%' + @searchQuery + '%') AND 
					(idType = isnull(@idType, idType)) AND 
					(distanceUser <= isnull(@distance, distanceUser)) AND 
					(localPrice <= isnull(@price, localPrice))
			ORDER BY sales DESC FOR JSON AUTO ) AS allProducts
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

-- EXECUTE prcGetAllProducts @searchQuery = '', @idUserParam = 0, @idType = null, @distance = null, @price = null, @order = 'Popular', @country = 'United States'

-- procedure to create a new product
CREATE PROCEDURE prcCreateProduct
@nameParam varchar(50),
@typeParam int,
@agedParam varchar(10),
@presentationParam varchar(150),
@imageParam varchar(MAX),
@globalPriceParam money
AS
BEGIN
	BEGIN TRY 
	 -- get the max idProduct +1 and set it as the new idProduct for the new insert
	 DECLARE @maxIDProduct int;
        SET @maxIDProduct = 0; 
		SELECT @maxIDProduct = MAX(idProduct) FROM OPENQUERY([UNIVERSAL-MYSQL], 'SELECT idProduct FROM product.product')
		SET @maxIDProduct = @maxIDProduct+1; 

			BEGIN
				--insert product on the universal product database on MYSQL
				DECLARE 
				@values VARCHAR(max),
				@insert VARCHAR(max),
				@json nvarchar(max)=N'{"aged": '+'"'+@agedParam+'"'+', "presentation": '+'"'+@presentationParam+'"'+'}';

					SET @insert = 'INSERT INTO product.product (idProduct, idType,name, features, image,createDate,updateDate,deleted) '

					SET @values = (SELECT CONCAT('VALUES(',
									QUOTENAME(@maxIDProduct,'()'),',',
									QUOTENAME(@typeParam,'()'),',',
									QUOTENAME(@nameParam,''''),',',
									QUOTENAME(@json,''''),',',
									'FROM_BASE64(',QUOTENAME(@imageParam,''''),')',',',
									'NOW()',',','NOW()',',','0',')'
									));

				declare @query varchar(max)
				set @query=@insert+@values

				EXEC(@query)AT [UNIVERSAL-MYSQL]

				--insert products on stores in the US
				EXECUTE [UNITEDSTATESSQL].[usa_user].[dbo].[prcCreateProduct]  @idProduct = @maxIDProduct, @globalPrice = @globalPriceParam, @image = NULL;
				--insert products on stores in STK
				EXECUTE [SCOTLANDSQL].[stk_user].[dbo].[prcCreateProduct]  @idProduct = @maxIDProduct, @globalPrice = @globalPriceParam, @image = NULL;
				--insert products on stores in IE
				EXECUTE [IRELANDSQL].[ie_user].[dbo].[prcCreateProduct]  @idProduct = @maxIDProduct, @globalPrice = @globalPriceParam, @image = NULL;
			END
		
			BEGIN
				RAISERROR ('Product already exist.', 11, 1);
			END
		SELECT 'Succes'
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

-- Procedure to create a report of employees
CREATE PROCEDURE employeeReport
	@departamento INT,
    @calificación INT,
	@salario MONEY
AS
BEGIN
  BEGIN TRY   -- statements that may cause exceptions

	-- Get information from mysql database
	SELECT(
	SELECT E.idEmployee, E.idDepartment, R.calification 
	FROM openquery([UNIVERSAL-MYSQL],'select idEmployee,idDepartment from employee.employee') E
	INNER JOIN 
	(SELECT idEmployee,calification FROM openquery([UNIVERSAL-MYSQL],'select idEmployee,calification from employee.review'))R
	ON R.idEmployee = E.idEmployee
	WHERE E.idDepartment = @departamento AND R.calification = @departamento
	FOR JSON AUTO) as employeeReport
	

	 
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

-- Procedure to retrieve the sales of a user
CREATE PROCEDURE prcGetOrdersById
@user int
AS
BEGIN
	BEGIN TRY 

        SELECT (
            select S.idSale, S.createDate, S.totalSale 
            from OPENQUERY([UNIVERSAL-MYSQL], 'SELECT idUser,idSale, createDate, totalSale FROM product.sale') S
            where S.idUser = @user
            FOR JSON AUTO
            )as orders

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

-- stored procedure for storing product reviews
CREATE PROCEDURE prcstoreProductReviews
@idProduct int,
@idUser int,
@calification int,
@review varchar(1500)
AS
BEGIN
	BEGIN TRY
	-- get the last idReview +1, for the new insert
		 DECLARE @maxIdReview int;
        SET @maxIdReview = 0; 
		SELECT @maxIdReview = MAX(idReview) FROM OPENQUERY([UNIVERSAL-MYSQL], 'SELECT idReview FROM product.review')
		SET @maxIdReview = @maxIdReview+1; 
        
			BEGIN
			--insert review to MYSQL product.review database
					INSERT OPENQUERY([UNIVERSAL-MYSQL], 'SELECT idReview,idProduct,idUser,calification,review,createDate,updateDate, deleted FROM product.review')   
					VALUES(@maxIdReview,@idProduct,@idUser,@calification,@review,(SELECT GETDATE()),(SELECT GETDATE()),0)

            END
			-- print success if the procedure is done completely
		SELECT 'Succes'
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

--exec prcstoreProductReviews
--@idProduct= 1,
--@idUser = 1,
--@calification =4,
--@review = 'Greate product and excellent delivery'



-- stored procedure for responding to product reviews
CREATE PROCEDURE prcResolutionProductReviews
@idReview int,
@idUser int
AS
BEGIN
	BEGIN TRY
	-- get the last idResolution for the new insert
		DECLARE @resolution varchar(1500)
		SET  @resolution = 'Thank you for your feedback. We look forward to hearing from you in due time regarding our submission and to respond to
								any further questions and comments you may have. Sincerely, The Wisky Club'
	
        
			BEGIN
			--insert review to MYSQL product.resolution database
					INSERT OPENQUERY([UNIVERSAL-MYSQL], 'SELECT idReview,idUser,resolution,createDate,updateDate, deleted FROM product.resolution')   
					VALUES(@idReview,@idUser,@resolution,(SELECT GETDATE()),(SELECT GETDATE()),0)
            END
			-- print success if the procedure is done completely
		SELECT 'Succes'
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

--exec prcResolutionProductReviews
--@idReview= 1,
--@idUser = 1


-- stored procedure for storing employee reviews
CREATE PROCEDURE prcstoreEmployeeReviews
@idEmployee int,
@idUser int,
@calification int,
@review varchar(1500)
AS
BEGIN
	BEGIN TRY
	-- get the last idReview for the new insert
		 DECLARE @maxIdReview int;
        SET @maxIdReview = 0; 
		SELECT @maxIdReview = MAX(idReview) FROM OPENQUERY([UNIVERSAL-MYSQL], 'SELECT idReview FROM employee.review')
		SET @maxIdReview = @maxIdReview+1; 
        
			BEGIN
			-- insert review to MYSQL employee.review database
					INSERT OPENQUERY([UNIVERSAL-MYSQL], 'SELECT idReview,idEmployee,idUser,calification,review,createDate,updateDate, deleted FROM employee.review')   
					VALUES(@maxIdReview,@idEmployee,@idUser,@calification,@review,(SELECT GETDATE()),(SELECT GETDATE()),0)

            END
			-- print success if the procedure is done completely
		SELECT 'Success'
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

--exec prcstoreEmployeeReviews
--@idEmployee= 1,
--@idUser = 1,
--@calification =1,
--@review = 'Rude employee'


-- stored procedure for responding to employee reviews
CREATE PROCEDURE prcResolutionEmployeeReviews
@idReview int,
@idUser int
AS
BEGIN
	BEGIN TRY
	-- get the last idResolution for the new insert
		DECLARE @resolution varchar(1500)
		SET  @resolution = 'Thank you for your feedback. We look forward to hearing from you in due time regarding our submission and to respond to
								any further questions and comments you may have. Sincerely, The Wisky Club'
	
        
			BEGIN
			--insert review to MYSQL product.resolution database
					INSERT OPENQUERY([UNIVERSAL-MYSQL], 'SELECT idReview,idUser,resolution,createDate,updateDate, deleted FROM employee.resolution')   
					VALUES(@idReview,@idUser,@resolution,(SELECT GETDATE()),(SELECT GETDATE()),0)
            END
			-- print success if the procedure is done completely
		SELECT 'Succes'
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

--exec prcResolutionEmployeeReviews
--@idReview= 1,
--@idUser = 1
