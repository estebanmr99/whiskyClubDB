-- Store database stored procedures
-- The database has 9 distributed dbs, because of this we well have 3 section for each instance.


-------------------------------------------------------------------------------------------------------------------------------- USA
-- Procedure to get all stores information from the database, union all the stores results from each instance
CREATE PROCEDURE prcGetStoresInfo
AS
BEGIN
	BEGIN TRY

		SELECT idStore, name, 'United States' as country 
		FROM [usa_store1].[dbo].[store]
		UNION ALL
		SELECT idStore, name, 'United States' as country 
		FROM [usa_store2].[dbo].[store]
		UNION ALL
		SELECT idStore, name, 'United States' as country 
		FROM [usa_store3].[dbo].[store]

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

-- EXECUTE [dbo].[prcGetStoresInfo]
-- Procedure to get all stores inventory from the database, union all the stores results from each instance
CREATE PROCEDURE prcGetStoresInventory
AS
BEGIN
	BEGIN TRY

		SELECT p.idProduct, p.currency, p.localPrice, p.globalPrice, (i.quantity) as quantity, (i.idStore) as idStore 
		FROM [usa_store1].[dbo].[product] as p
		INNER JOIN [usa_store1].[dbo].[inventory] as i on p.idProduct = i.idProduct
		WHERE p.deleted = 0
		UNION ALL
		SELECT p.idProduct, p.currency, p.localPrice, p.globalPrice, (i.quantity) as quantity, (i.idStore) as idStore 
		FROM [usa_store2].[dbo].[product] as p
		INNER JOIN [usa_store2].[dbo].[inventory] as i on p.idProduct = i.idProduct
		WHERE p.deleted = 0
		UNION ALL
		SELECT p.idProduct, p.currency, p.localPrice, p.globalPrice, (i.quantity) as quantity, (i.idStore) as idStore 
		FROM [usa_store3].[dbo].[product] as p
		INNER JOIN [usa_store3].[dbo].[inventory] as i on p.idProduct = i.idProduct
		WHERE p.deleted = 0

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
-- Procedure to update the inventory of a store based on the product id and store id
-- Procedure to update the inventory of a store based on the product id and store id
CREATE PROCEDURE prcUpdateStoreInventory
@idStore int,
@idProduct int,
@currency varchar(30),
@localPrice int,
@globalPrice int,
@quantity int
AS
BEGIN
	BEGIN TRY 

		-- Update the data of product in the store
		UPDATE [dbo].[product] 
		SET currency = @currency, localPrice = @localPrice, globalPrice = @globalPrice
		WHERE idProduct = @idProduct

		-- update the data of inventory in the store
		IF NOT EXISTS (SELECT * FROM [dbo].[inventory] WHERE idStore = @idStore AND idProduct = @idProduct)
		BEGIN
			INSERT INTO [dbo].[inventory] (idStore, idProduct, quantity)
			VALUES (@idStore, @idProduct, @quantity)
		END
		ELSE
		BEGIN
			UPDATE [dbo].[inventory]
			SET quantity = @quantity
			WHERE idStore = @idStore AND idProduct = @idProduct
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

-- EXECUTE prcUpdateStoreInventory
-- Procedure to get all stores inventory from the database, union all the stores results from each instance
CREATE PROCEDURE prcGetAllStoresInventory
@idUser int
AS
BEGIN
	BEGIN TRY

    -- Get user location
	DECLARE @userLocation geography;
    SELECT @userLocation = location FROM [usa_user].[dbo].[user] WHERE idUser = @idUser;

	-- select everything from the union of all the stores
    select p.idStore, p.idProduct, p.storeName, p.storeLocation, p.productQuantity, p.currency, p.localPrice, p.globalPrice, (p.storeLocation.STDistance(@userLocation) / 1000) as distanceUser  from(		
            SELECT (s.idStore) as idStore, p.idProduct, (s.name) as storeName, (s.location) as storeLocation, (i.quantity) as productQuantity, p.currency, p.localPrice, p.globalPrice
            FROM [usa_store1].[dbo].[product] as p
            INNER JOIN [usa_store1].[dbo].[inventory] as i on p.idProduct = i.idProduct
            INNER JOIN [usa_store1].[dbo].[store] as s on i.idStore = s.idStore
            WHERE p.deleted = 0
            UNION ALL
            SELECT (s.idStore) as idStore, p.idProduct, (s.name) as storeName, (s.location) as storeLocation, (i.quantity) as productQuantity, p.currency, p.localPrice, p.globalPrice
            FROM [usa_store2].[dbo].[product] as p
            INNER JOIN [usa_store2].[dbo].[inventory] as i on p.idProduct = i.idProduct
            INNER JOIN [usa_store2].[dbo].[store] as s on i.idStore = s.idStore
            WHERE p.deleted = 0
            UNION ALL
            SELECT (s.idStore) as idStore, p.idProduct, (s.name) as storeName, (s.location) as storeLocation, (i.quantity) as productQuantity, p.currency, p.localPrice, p.globalPrice
            FROM [usa_store3].[dbo].[product] as p
            INNER JOIN [usa_store3].[dbo].[inventory] as i on p.idProduct = i.idProduct
            INNER JOIN [usa_store3].[dbo].[store] as s on i.idStore = s.idStore
            WHERE p.deleted = 0) as p

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

-- Procedure to get all stores information from the database, union all the stores results from each instance
CREATE PROCEDURE prcGetStoresInfo
AS
BEGIN
	BEGIN TRY

		SELECT idStore, name, 'Ireland' as country 
		FROM [ie_store1].[dbo].[store]
		UNION ALL
		SELECT idStore, name, 'Ireland' as country 
		FROM [ie_store2].[dbo].[store]
		UNION ALL
		SELECT idStore, name, 'Ireland' as country 
		FROM [ie_store3].[dbo].[store]

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

-- EXECUTE [dbo].[prcGetStoresInfo]

-- Procedure to get all stores inventory from the database, union all the stores results from each instance
CREATE PROCEDURE prcGetStoresInventory
AS
BEGIN
	BEGIN TRY

		SELECT p.idProduct, p.currency, p.localPrice, p.globalPrice, (i.quantity) as quantity, (i.idStore) as idStore 
		FROM [ie_store1].[dbo].[product] as p
		INNER JOIN [ie_store1].[dbo].[inventory] as i on p.idProduct = i.idProduct
		WHERE p.deleted = 0
		UNION ALL
		SELECT p.idProduct, p.currency, p.localPrice, p.globalPrice, (i.quantity) as quantity, (i.idStore) as idStore 
		FROM [ie_store2].[dbo].[product] as p
		INNER JOIN [ie_store2].[dbo].[inventory] as i on p.idProduct = i.idProduct
		WHERE p.deleted = 0
		UNION ALL
		SELECT p.idProduct, p.currency, p.localPrice, p.globalPrice, (i.quantity) as quantity, (i.idStore) as idStore 
		FROM [ie_store3].[dbo].[product] as p
		INNER JOIN [ie_store3].[dbo].[inventory] as i on p.idProduct = i.idProduct
		WHERE p.deleted = 0

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

-- Procedure to update the inventory of a store based on the product id and store id
CREATE PROCEDURE prcUpdateStoreInventory
@idStore int,
@idProduct int,
@currency varchar(30),
@localPrice int,
@globalPrice int,
@quantity int
AS
BEGIN
	BEGIN TRY 

		-- Update the data of product in the store
		UPDATE [dbo].[product] 
		SET currency = @currency, localPrice = @localPrice, globalPrice = @globalPrice
		WHERE idProduct = @idProduct

		-- update the data of inventory in the store
		IF NOT EXISTS (SELECT * FROM [dbo].[inventory] WHERE idStore = @idStore AND idProduct = @idProduct)
		BEGIN
			INSERT INTO [dbo].[inventory] (idStore, idProduct, quantity)
			VALUES (@idStore, @idProduct, @quantity)
		END
		ELSE
		BEGIN
			UPDATE [dbo].[inventory]
			SET quantity = @quantity
			WHERE idStore = @idStore AND idProduct = @idProduct
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

-- EXECUTE prcUpdateStoreInventory

-- Procedure to get all stores inventory from the database, union all the stores results from each instance
CREATE PROCEDURE prcGetAllStoresInventory
@idUser int
AS
BEGIN
	BEGIN TRY

    -- Get user location
	DECLARE @userLocation geography;
    SELECT @userLocation = location FROM [ie_user].[dbo].[user] WHERE idUser = @idUser;

	-- select everything from the union of all the stores
    select p.idStore, p.idProduct, p.storeName, p.storeLocation, p.productQuantity, p.currency, p.localPrice, p.globalPrice, (p.storeLocation.STDistance(@userLocation) / 1000) as distanceUser  from(		
            SELECT (s.idStore) as idStore, p.idProduct, (s.name) as storeName, (s.location) as storeLocation, (i.quantity) as productQuantity, p.currency, p.localPrice, p.globalPrice
            FROM [ie_store1].[dbo].[product] as p
            INNER JOIN [ie_store1].[dbo].[inventory] as i on p.idProduct = i.idProduct
            INNER JOIN [ie_store1].[dbo].[store] as s on i.idStore = s.idStore
            WHERE p.deleted = 0
            UNION ALL
            SELECT (s.idStore) as idStore, p.idProduct, (s.name) as storeName, (s.location) as storeLocation, (i.quantity) as productQuantity, p.currency, p.localPrice, p.globalPrice
            FROM [ie_store2].[dbo].[product] as p
            INNER JOIN [ie_store2].[dbo].[inventory] as i on p.idProduct = i.idProduct
            INNER JOIN [ie_store2].[dbo].[store] as s on i.idStore = s.idStore
            WHERE p.deleted = 0
            UNION ALL
            SELECT (s.idStore) as idStore, p.idProduct, (s.name) as storeName, (s.location) as storeLocation, (i.quantity) as productQuantity, p.currency, p.localPrice, p.globalPrice
            FROM [ie_store3].[dbo].[product] as p
            INNER JOIN [ie_store3].[dbo].[inventory] as i on p.idProduct = i.idProduct
            INNER JOIN [ie_store3].[dbo].[store] as s on i.idStore = s.idStore
            WHERE p.deleted = 0) as p

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

-- Procedure to get all stores information from the database, union all the stores results from each instance
CREATE PROCEDURE prcGetStoresInfo
AS
BEGIN
	BEGIN TRY

		SELECT idStore, name, 'Scotland' as country 
		FROM [stk_store1].[dbo].[store]
		UNION ALL
		SELECT idStore, name, 'Scotland' as country 
		FROM [stk_store2].[dbo].[store]
		UNION ALL
		SELECT idStore, name, 'Scotland' as country 
		FROM [stk_store3].[dbo].[store]

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

-- EXECUTE [dbo].[prcGetStoresInfo]

-- Procedure to get all stores inventory from the database, union all the stores results from each instance
CREATE PROCEDURE prcGetStoresInventory
AS
BEGIN
	BEGIN TRY

		SELECT p.idProduct, p.currency, p.localPrice, p.globalPrice, (i.quantity) as quantity, (i.idStore) as idStore 
		FROM [stk_store1].[dbo].[product] as p
		INNER JOIN [stk_store1].[dbo].[inventory] as i on p.idProduct = i.idProduct
		WHERE p.deleted = 0
		UNION ALL
		SELECT p.idProduct, p.currency, p.localPrice, p.globalPrice, (i.quantity) as quantity, (i.idStore) as idStore 
		FROM [stk_store2].[dbo].[product] as p
		INNER JOIN [stk_store2].[dbo].[inventory] as i on p.idProduct = i.idProduct
		WHERE p.deleted = 0
		UNION ALL
		SELECT p.idProduct, p.currency, p.localPrice, p.globalPrice, (i.quantity) as quantity, (i.idStore) as idStore 
		FROM [stk_store3].[dbo].[product] as p
		INNER JOIN [stk_store3].[dbo].[inventory] as i on p.idProduct = i.idProduct
		WHERE p.deleted = 0

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

-- Procedure to update the inventory of a store based on the product id and store id
CREATE PROCEDURE prcUpdateStoreInventory
@idStore int,
@idProduct int,
@currency varchar(30),
@localPrice int,
@globalPrice int,
@quantity int
AS
BEGIN
	BEGIN TRY 

		-- Update the data of product in the store
		UPDATE [dbo].[product] 
		SET currency = @currency, localPrice = @localPrice, globalPrice = @globalPrice
		WHERE idProduct = @idProduct

		-- update the data of inventory in the store
		IF NOT EXISTS (SELECT * FROM [dbo].[inventory] WHERE idStore = @idStore AND idProduct = @idProduct)
		BEGIN
			INSERT INTO [dbo].[inventory] (idStore, idProduct, quantity)
			VALUES (@idStore, @idProduct, @quantity)
		END
		ELSE
		BEGIN
			UPDATE [dbo].[inventory]
			SET quantity = @quantity
			WHERE idStore = @idStore AND idProduct = @idProduct
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
-- EXECUTE prcUpdateStoreInventory

-- Procedure to get all stores inventory from the database, union all the stores results from each instance
CREATE PROCEDURE prcGetAllStoresInventory
@idUser int
AS
BEGIN
	BEGIN TRY

    -- Get user location
	DECLARE @userLocation geography;
    SELECT @userLocation = location FROM [stk_user].[dbo].[user] WHERE idUser = @idUser;

	-- select everything from the union of all the stores
    select p.idStore, p.idProduct, p.storeName, p.storeLocation, p.productQuantity, p.currency, p.localPrice, p.globalPrice, (p.storeLocation.STDistance(@userLocation) / 1000) as distanceUser  from(		
            SELECT (s.idStore) as idStore, p.idProduct, (s.name) as storeName, (s.location) as storeLocation, (i.quantity) as productQuantity, p.currency, p.localPrice, p.globalPrice
            FROM [stk_store1].[dbo].[product] as p
            INNER JOIN [stk_store1].[dbo].[inventory] as i on p.idProduct = i.idProduct
            INNER JOIN [stk_store1].[dbo].[store] as s on i.idStore = s.idStore
            WHERE p.deleted = 0
            UNION ALL
            SELECT (s.idStore) as idStore, p.idProduct, (s.name) as storeName, (s.location) as storeLocation, (i.quantity) as productQuantity, p.currency, p.localPrice, p.globalPrice
            FROM [stk_store2].[dbo].[product] as p
            INNER JOIN [stk_store2].[dbo].[inventory] as i on p.idProduct = i.idProduct
            INNER JOIN [stk_store2].[dbo].[store] as s on i.idStore = s.idStore
            WHERE p.deleted = 0
            UNION ALL
            SELECT (s.idStore) as idStore, p.idProduct, (s.name) as storeName, (s.location) as storeLocation, (i.quantity) as productQuantity, p.currency, p.localPrice, p.globalPrice
            FROM [stk_store3].[dbo].[product] as p
            INNER JOIN [stk_store3].[dbo].[inventory] as i on p.idProduct = i.idProduct
            INNER JOIN [stk_store3].[dbo].[store] as s on i.idStore = s.idStore
            WHERE p.deleted = 0) as p

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