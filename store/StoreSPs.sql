-- Store database stored procedures
-- The database has 9 distributed dbs, because of this we well have 3 section for each instance.


-------------------------------------------------------------------------------------------------------------------------------- USA

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

		INSERT INTO [dbo].[product] (currency, localPrice, globalPrice)
		VALUES (@currency, @localPrice, @globalPrice);

		INSERT INTO [dbo].[inventory] (idProduct, idStore, quantity)
		VALUES (@idProduct, @idStore, @quantity);


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

CREATE PROCEDURE prcGetAllStoresInventory
@idUser int
AS
BEGIN
	BEGIN TRY

    DECLARE @userLocation geography;
    SELECT @userLocation = location FROM [usa_user].[dbo].[user] WHERE idUser = @idUser;

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

		INSERT INTO [dbo].[product] (currency, localPrice, globalPrice)
		VALUES (@currency, @localPrice, @globalPrice);

		INSERT INTO [dbo].[inventory] (idProduct, idStore, quantity)
		VALUES (@idProduct, @idStore, @quantity);


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

CREATE PROCEDURE prcGetAllStoresInventory
@idUser int
AS
BEGIN
	BEGIN TRY

    DECLARE @userLocation geography;
    SELECT @userLocation = location FROM [ie_user].[dbo].[user] WHERE idUser = @idUser;

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

		INSERT INTO [dbo].[product] (currency, localPrice, globalPrice)
		VALUES (@currency, @localPrice, @globalPrice);

		INSERT INTO [dbo].[inventory] (idProduct, idStore, quantity)
		VALUES (@idProduct, @idStore, @quantity);


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

CREATE PROCEDURE prcGetAllStoresInventory
@idUser int
AS
BEGIN
	BEGIN TRY

    DECLARE @userLocation geography;
    SELECT @userLocation = location FROM [stk_user].[dbo].[user] WHERE idUser = @idUser;

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