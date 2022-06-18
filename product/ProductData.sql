SET SQL_SAFE_UPDATES = 0;
SET sql_mode='NO_AUTO_VALUE_ON_ZERO';
DELETE FROM product.product;
ALTER TABLE product.product AUTO_INCREMENT = 0;
DELETE FROM product.product_type;
ALTER TABLE product.product_type AUTO_INCREMENT = 0;

DROP TABLE product.resolution;
DROP TABLE product.review;
DROP TABLE product.product;
DROP TABLE product.product_type;

INSERT INTO product.product_type (idType, name, deleted) 
VALUES (0, 'Single Malt', 0),
        (1, 'Blended Scotch', 0),
        (2, 'Irish', 0),
        (3, 'Blended Malt', 0),
        (4, 'Bourbon', 0),
        (5, 'Tennessee Whiskey', 0);

SELECT * FROM product.product_type;

INSERT INTO product.product (idProduct, idType, name, features, image, createDate, updateDate, deleted)
VALUES (0, 0, 'Deanston 18 Year Old', '{ "aged": 10, "presentation": "2 bottles", "supplier": "random supplier" }', FROM_BASE64('iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg=='), NOW(), NOW(), 0),
        (1, 1, 'Sheep Dip Scotch', '{ "aged": 20, "presentation": "1 bottle", "supplier": "random supplier" }', FROM_BASE64('iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg=='), NOW(), NOW(), 0),
        (2, 2, 'Dead Rabbit Irish Whiskey', '{ "aged": 50, "presentation": "1 bottle", "supplier": "random supplier" }', FROM_BASE64('iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg=='), NOW(), NOW(), 0),
        (3, 3, 'Monkey Shoulder', '{ "aged": 5, "presentation": "2 bottles", "supplier": "random supplier" }', FROM_BASE64('iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg=='), NOW(), NOW(), 0),
        (4, 4, 'Eagle Rare 10 Year Old', '{ "aged": 10, "presentation": "1 bottle", "supplier": "random supplier" }', FROM_BASE64('iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg=='), NOW(), NOW(), 0),
        (5, 5, 'George Dickel Barrel Select', '{ "aged": 15, "presentation": "2 bottles", "supplier": "random supplier" }', FROM_BASE64('iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg=='), NOW(), NOW(), 0);

SELECT * FROM product.product;