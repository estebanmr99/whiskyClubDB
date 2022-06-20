-- Product database stored procedures

-- Procedure to get all products from the database with their sales
DELIMITER //
CREATE PROCEDURE prcGetProductsWithSales()
BEGIN
    -- Disable unsafe mode
	SET SQL_SAFE_UPDATES = 0;

	-- create temporary table to store the results
	DROP TABLE IF EXISTS tempProducts;
	CREATE TEMPORARY TABLE tempProducts (idProduct int, idType int, productName varchar(50), features JSON, image varchar(8000), sales int);
    
	-- get all products from the database and convert the image to base64
    INSERT INTO tempProducts
    SELECT
		p.idProduct, p.idType, p.name, p.features, TO_BASE64(p.image), 0 as sales
	FROM
		product.product as p;
    
	-- create temporary table to store the sales and proces the json data
	DROP TABLE IF EXISTS tempSales;
	CREATE TEMPORARY TABLE tempSales (idProduct int, sales int);
    INSERT INTO tempSales
    SELECT tp.idProduct, COUNT(product.sale.products) as sales
	FROM product.sale, JSON_TABLE(products, "$[*].id" COLUMNS(nr INT PATH '$')) as ids --  get the product ids from the json data
    INNER JOIN tempProducts as tp ON ids.nr = tp.idProduct
    GROUP BY tp.idProduct, product.sale.products;
    
	-- update the sales in the temporary table
    UPDATE tempProducts AS U1, tempSales AS U2 
	SET U1.sales = U2.sales
	WHERE U1.idProduct = U2.idProduct;
    
	-- return the results
    SELECT idProduct, idType, productName, CAST(features AS CHAR(8000) CHARACTER SET utf8) as features, image, sales FROM tempProducts;
END //
    
DELIMITER ;

-- CALL product.prcGetProductsWithSales()