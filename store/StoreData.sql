-------------------------------------------------------------------------------------------------------------------------------- Ireland
------------------------------------------------------------------------- store 1
INSERT INTO [ie_store1].[dbo].[store]
VALUES (0, 'Cork', geography::Point(51.89545714714142, -8.468307839127354, 4326), 0.65, 0);

DELETE inventory;
DELETE product;

DECLARE @str varchar(max);
SET @str = 'iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==';

INSERT INTO [ie_store1].[dbo].[product]
VALUES (0, 'Euro', cast(N'' as xml).value('xs:base64Binary(sql:variable("@str"))', 'varbinary(max)'), 40, 42, 0),
	   (1, 'Euro', cast(N'' as xml).value('xs:base64Binary(sql:variable("@str"))', 'varbinary(max)'), 100, 105, 0),
       (2, null, cast(N'' as xml).value('xs:base64Binary(sql:variable("@str"))', 'varbinary(max)'), null, null, 0),
       (3, null, cast(N'' as xml).value('xs:base64Binary(sql:variable("@str"))', 'varbinary(max)'), null, null, 0),
       (4, null, cast(N'' as xml).value('xs:base64Binary(sql:variable("@str"))', 'varbinary(max)'), null, null, 0),
       (5, null, cast(N'' as xml).value('xs:base64Binary(sql:variable("@str"))', 'varbinary(max)'), null, null, 0);

INSERT INTO [ie_store1].[dbo].[inventory]
VALUES (0, 0, 1),
		(1, 0, 3);

select * from product;

------------------------------------------------------------------------- store 2
INSERT INTO [ie_store2].[dbo].[store]
VALUES (1, 'Galway', geography::Point(53.275558513354085, -9.050912910850219, 4326), 0.70, 0);

DELETE inventory;
DELETE product;

DECLARE @str varchar(max);
SET @str = 'iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==';

INSERT INTO [ie_store2].[dbo].[product]
VALUES (0, 'Euro', cast(N'' as xml).value('xs:base64Binary(sql:variable("@str"))', 'varbinary(max)'), 40, 42, 0),
	   (1, 'Euro', cast(N'' as xml).value('xs:base64Binary(sql:variable("@str"))', 'varbinary(max)'), 100, 105, 0),
       (2, null, cast(N'' as xml).value('xs:base64Binary(sql:variable("@str"))', 'varbinary(max)'), null, null, 0),
       (3, null, cast(N'' as xml).value('xs:base64Binary(sql:variable("@str"))', 'varbinary(max)'), null, null, 0),
       (4, null, cast(N'' as xml).value('xs:base64Binary(sql:variable("@str"))', 'varbinary(max)'), null, null, 0),
       (5, null, cast(N'' as xml).value('xs:base64Binary(sql:variable("@str"))', 'varbinary(max)'), null, null, 0);

INSERT INTO [ie_store2].[dbo].[inventory]
VALUES (0, 1, 0),
		(1, 1, 10);

select * from product;

------------------------------------------------------------------------- store 3
INSERT INTO [ie_store3].[dbo].[store]
VALUES (2, 'Dublin', geography::Point(53.33330031045176, -6.269274948248049, 4326), 0.75, 0);

DELETE inventory;
DELETE product;

DECLARE @str varchar(max);
SET @str = 'iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==';

INSERT INTO [ie_store3].[dbo].[product]
VALUES (0, 'Euro', cast(N'' as xml).value('xs:base64Binary(sql:variable("@str"))', 'varbinary(max)'), 40, 42, 0),
	   (1, 'Euro', cast(N'' as xml).value('xs:base64Binary(sql:variable("@str"))', 'varbinary(max)'), 100, 105, 0),
       (2, null, cast(N'' as xml).value('xs:base64Binary(sql:variable("@str"))', 'varbinary(max)'), null, null, 0),
       (3, null, cast(N'' as xml).value('xs:base64Binary(sql:variable("@str"))', 'varbinary(max)'), null, null, 0),
       (4, null, cast(N'' as xml).value('xs:base64Binary(sql:variable("@str"))', 'varbinary(max)'), null, null, 0),
       (5, null, cast(N'' as xml).value('xs:base64Binary(sql:variable("@str"))', 'varbinary(max)'), null, null, 0);

INSERT INTO [ie_store3].[dbo].[inventory]
VALUES (0, 2, 4),
		(1, 2, 5);

select * from product;

-------------------------------------------------------------------------------------------------------------------------------- Scotland
------------------------------------------------------------------------- store 1
INSERT INTO [stk_store1].[dbo].[store]
VALUES (3, 'Inverness', geography::Point(57.47412984398131, -4.239453384881591, 4326), 0.60, 0);

DELETE inventory;
DELETE product;

DECLARE @str varchar(max);
SET @str = 'iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==';

INSERT INTO [stk_store1].[dbo].[product]
VALUES (0, 'Euro', cast(N'' as xml).value('xs:base64Binary(sql:variable("@str"))', 'varbinary(max)'), 40, 42, 0),
	   (1, 'Euro', cast(N'' as xml).value('xs:base64Binary(sql:variable("@str"))', 'varbinary(max)'), 100, 105, 0),
       (2, null, cast(N'' as xml).value('xs:base64Binary(sql:variable("@str"))', 'varbinary(max)'), null, null, 0),
       (3, null, cast(N'' as xml).value('xs:base64Binary(sql:variable("@str"))', 'varbinary(max)'), null, null, 0),
       (4, null, cast(N'' as xml).value('xs:base64Binary(sql:variable("@str"))', 'varbinary(max)'), null, null, 0),
       (5, null, cast(N'' as xml).value('xs:base64Binary(sql:variable("@str"))', 'varbinary(max)'), null, null, 0);

INSERT INTO [stk_store1].[dbo].[inventory]
VALUES (0, 3, 0),
		(1, 3, 0);

select * from product;

------------------------------------------------------------------------- store 2
INSERT INTO [stk_store2].[dbo].[store]
VALUES (4, 'Glasgow', geography::Point(55.86803289296835, -4.265528127997926, 4326), 0.70, 0);

DELETE inventory;
DELETE product;

DECLARE @str varchar(max);
SET @str = 'iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==';

INSERT INTO [stk_store2].[dbo].[product]
VALUES (0, 'Euro', cast(N'' as xml).value('xs:base64Binary(sql:variable("@str"))', 'varbinary(max)'), 40, 42, 0),
	   (1, 'Euro', cast(N'' as xml).value('xs:base64Binary(sql:variable("@str"))', 'varbinary(max)'), 100, 105, 0),
       (2, null, cast(N'' as xml).value('xs:base64Binary(sql:variable("@str"))', 'varbinary(max)'), null, null, 0),
       (3, null, cast(N'' as xml).value('xs:base64Binary(sql:variable("@str"))', 'varbinary(max)'), null, null, 0),
       (4, null, cast(N'' as xml).value('xs:base64Binary(sql:variable("@str"))', 'varbinary(max)'), null, null, 0),
       (5, null, cast(N'' as xml).value('xs:base64Binary(sql:variable("@str"))', 'varbinary(max)'), null, null, 0);

INSERT INTO [stk_store2].[dbo].[inventory]
VALUES (0, 4, 1),
		(1, 4, 3);

select * from product;

------------------------------------------------------------------------- store 3
INSERT INTO [stk_store3].[dbo].[store]
VALUES (5, 'Edinburgh', geography::Point(55.93519013197581, -3.219917253393694, 4326), 0.80, 0);

DELETE inventory;
DELETE product;

DECLARE @str varchar(max);
SET @str = 'iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==';

INSERT INTO [stk_store3].[dbo].[product]
VALUES (0, 'Euro', cast(N'' as xml).value('xs:base64Binary(sql:variable("@str"))', 'varbinary(max)'), 40, 42, 0),
	   (1, 'Euro', cast(N'' as xml).value('xs:base64Binary(sql:variable("@str"))', 'varbinary(max)'), 100, 105, 0),
       (2, null, cast(N'' as xml).value('xs:base64Binary(sql:variable("@str"))', 'varbinary(max)'), null, null, 0),
       (3, null, cast(N'' as xml).value('xs:base64Binary(sql:variable("@str"))', 'varbinary(max)'), null, null, 0),
       (4, null, cast(N'' as xml).value('xs:base64Binary(sql:variable("@str"))', 'varbinary(max)'), null, null, 0),
       (5, null, cast(N'' as xml).value('xs:base64Binary(sql:variable("@str"))', 'varbinary(max)'), null, null, 0);

INSERT INTO [stk_store3].[dbo].[inventory]
VALUES (0, 5, 15),
		(1, 5, 1);

select * from product;

-------------------------------------------------------------------------------------------------------------------------------- USA
------------------------------------------------------------------------- store 1
INSERT INTO [usa_store1].[dbo].[store]
VALUES (6, 'Washington', geography::Point(38.860582807021636, -77.09366705792416, 4326), 1.05, 0);

DELETE inventory;
DELETE product;

DECLARE @str varchar(max);
SET @str = 'iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==';

INSERT INTO [usa_store1].[dbo].[product]
VALUES (0, 'Dolar', cast(N'' as xml).value('xs:base64Binary(sql:variable("@str"))', 'varbinary(max)'), 42, 42, 0),
	   (1, 'Dolar', cast(N'' as xml).value('xs:base64Binary(sql:variable("@str"))', 'varbinary(max)'), 105, 105, 0),
       (2, null, cast(N'' as xml).value('xs:base64Binary(sql:variable("@str"))', 'varbinary(max)'), null, null, 0),
       (3, null, cast(N'' as xml).value('xs:base64Binary(sql:variable("@str"))', 'varbinary(max)'), null, null, 0),
       (4, null, cast(N'' as xml).value('xs:base64Binary(sql:variable("@str"))', 'varbinary(max)'), null, null, 0),
       (5, null, cast(N'' as xml).value('xs:base64Binary(sql:variable("@str"))', 'varbinary(max)'), null, null, 0);

INSERT INTO [usa_store1].[dbo].[inventory]
VALUES (0, 6, 15),
		(1, 6, 1);

select * from product;

------------------------------------------------------------------------- store 2
INSERT INTO [usa_store2].[dbo].[store]
VALUES (7, 'Los Angeles', geography::Point(34.03742229442408, -118.20257927528068, 4326), 0.95, 0);

DELETE inventory;
DELETE product;

DECLARE @str varchar(max);
SET @str = 'iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==';

INSERT INTO [usa_store2].[dbo].[product]
VALUES (0, 'Dolar', cast(N'' as xml).value('xs:base64Binary(sql:variable("@str"))', 'varbinary(max)'), 42, 42, 0),
	   (1, 'Dolar', cast(N'' as xml).value('xs:base64Binary(sql:variable("@str"))', 'varbinary(max)'), 105, 105, 0),
       (2, null, cast(N'' as xml).value('xs:base64Binary(sql:variable("@str"))', 'varbinary(max)'), null, null, 0),
       (3, null, cast(N'' as xml).value('xs:base64Binary(sql:variable("@str"))', 'varbinary(max)'), null, null, 0),
       (4, null, cast(N'' as xml).value('xs:base64Binary(sql:variable("@str"))', 'varbinary(max)'), null, null, 0),
       (5, null, cast(N'' as xml).value('xs:base64Binary(sql:variable("@str"))', 'varbinary(max)'), null, null, 0);

INSERT INTO [usa_store2].[dbo].[inventory]
VALUES (0, 7, 15),
		(1, 7, 1);

select * from product;

------------------------------------------------------------------------- store 3
INSERT INTO [usa_store3].[dbo].[store]
VALUES (8, 'Dallas', geography::Point(32.73279226789102, -96.69918800417629, 4326), 0.90, 0);

DELETE inventory;
DELETE product;

DECLARE @str varchar(max);
SET @str = 'iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==';

INSERT INTO [usa_store3].[dbo].[product]
VALUES (0, 'Dolar', cast(N'' as xml).value('xs:base64Binary(sql:variable("@str"))', 'varbinary(max)'), 42, 42, 0),
	   (1, 'Dolar', cast(N'' as xml).value('xs:base64Binary(sql:variable("@str"))', 'varbinary(max)'), 105, 105, 0),
       (2, null, cast(N'' as xml).value('xs:base64Binary(sql:variable("@str"))', 'varbinary(max)'), null, null, 0),
       (3, null, cast(N'' as xml).value('xs:base64Binary(sql:variable("@str"))', 'varbinary(max)'), null, null, 0),
       (4, null, cast(N'' as xml).value('xs:base64Binary(sql:variable("@str"))', 'varbinary(max)'), null, null, 0),
       (5, null, cast(N'' as xml).value('xs:base64Binary(sql:variable("@str"))', 'varbinary(max)'), null, null, 0);

INSERT INTO [usa_store3].[dbo].[inventory]
VALUES (0, 8, 15),
		(1, 8, 1);

select * from product;