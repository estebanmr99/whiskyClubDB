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
		UNION ALL
		SELECT p.idProduct, p.currency, p.localPrice, p.globalPrice, (i.quantity) as quantity, (i.idStore) as idStore 
		FROM [usa_store2].[dbo].[product] as p
		INNER JOIN [usa_store2].[dbo].[inventory] as i on p.idProduct = i.idProduct
		UNION ALL
		SELECT p.idProduct, p.currency, p.localPrice, p.globalPrice, (i.quantity) as quantity, (i.idStore) as idStore 
		FROM [usa_store3].[dbo].[product] as p
		INNER JOIN [usa_store3].[dbo].[inventory] as i on p.idProduct = i.idProduct
		FOR JSON PATH, INCLUDE_NULL_VALUES

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

DROP PROCEDURE prcGetStoresInventory
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

DROP PROCEDURE prcGetStoresInventory
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

DROP PROCEDURE prcGetStoresInventory
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