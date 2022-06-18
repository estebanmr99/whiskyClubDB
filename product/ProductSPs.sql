-- PRODUCT
DELIMITER //
CREATE PROCEDURE prcGetProductsWithSales()
BEGIN
	SET SQL_SAFE_UPDATES = 0;
	DROP TABLE IF EXISTS tempProducts;
	CREATE TEMPORARY TABLE tempProducts (idProduct int, idType int, productName varchar(50), features JSON, image varchar(16000), sales int);
    
    INSERT INTO tempProducts
    SELECT
		p.idProduct, p.idType, p.name, p.features, TO_BASE64(p.image), 0 as sales
	FROM
		product.product as p;
        
	DROP TABLE IF EXISTS tempSales;
	CREATE TEMPORARY TABLE tempSales (idProduct int, sales int);
    INSERT INTO tempSales
    SELECT tp.idProduct, COUNT(product.sale.products) as sales
	FROM product.sale, JSON_TABLE(products, "$[*].id" COLUMNS(nr INT PATH '$')) as ids
    INNER JOIN tempProducts as tp ON ids.nr = tp.idProduct
    GROUP BY tp.idProduct, product.sale.products;
    
    UPDATE tempProducts AS U1, tempSales AS U2 
	SET U1.sales = U2.sales
	WHERE U1.idProduct = U2.idProduct;
    
    SELECT idProduct, idType, productName, CAST(features AS CHAR(8000) CHARACTER SET utf8) as features, image, sales FROM tempProducts;
END //
    
DELIMITER ;

-- CALL product.prcGetProductsWithSales()