CREATE DATABASE store;

CREATE TABLE store (
    idStore int identity,
    location geography,
    shipCost money,
    deleted bit,
    PRIMARY KEY (idStore)
);

CREATE TABLE product (
    idProduct int,
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