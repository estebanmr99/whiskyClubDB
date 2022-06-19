-- Store database schema
-- Makes use of the SQL server database system
-- A 3 databses need to be created for each country

-------------------------------------------------------------- ireland --------------------------------------------------------------

-- CREATE DATABASE ie_store1;
-- CREATE DATABASE ie_store2;
-- CREATE DATABASE ie_store3;

-- USE ie_store1;
-- USE ie_store2;
-- USE ie_store3;

-------------------------------------------------------------- scotland --------------------------------------------------------------

-- CREATE DATABASE stk_store1;
-- CREATE DATABASE stk_store2;
-- CREATE DATABASE stk_store3;

-- USE stk_store1;
-- USE stk_store2;
-- USE stk_store3;

-------------------------------------------------------------- united states --------------------------------------------------------------

-- CREATE DATABASE usa_store1;
-- CREATE DATABASE usa_store2;
-- CREATE DATABASE usa_store3;

-- USE usa_store1;
-- USE usa_store2;
-- USE usa_store3;

CREATE TABLE store (
    idStore int,
    name varchar(50),
    location geography,
    shipCost money,
    deleted bit,
    PRIMARY KEY (idStore)
);

CREATE TABLE product (
    idProduct int,
    currency varchar(30),
    image varbinary(max),
    localPrice money,
    globalPrice money,
    deleted bit,
    PRIMARY KEY (idProduct)
);

CREATE TABLE employee (
    idEmployee int,
    localSalary money,
    globalSalary money,
    deleted bit,
    PRIMARY KEY (idEmployee)
);

CREATE TABLE inventory (
    idProduct int,
    idStore int,
    quantity int,

    CONSTRAINT FK_InventoryIdProduct
    FOREIGN KEY (idProduct)
    REFERENCES product(idProduct),

    CONSTRAINT FK_InventoryIdStore
    FOREIGN KEY (idStore)
    REFERENCES store(idStore)
);

CREATE TABLE store_sale (
    idSale int,
    idStore int,
    
    CONSTRAINT FK_SaleIdStore
    FOREIGN KEY (idStore)
    REFERENCES store(idStore)
);