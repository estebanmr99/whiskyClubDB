-- Product database schema
-- Makes use of the MySQL database system

CREATE DATABASE product;

-- Set the database to use and the start id of the coloumns 
USE product;
SET sql_mode='NO_AUTO_VALUE_ON_ZERO';

CREATE TABLE product_type (
    idType int NOT NULL AUTO_INCREMENT,
    name varchar(50),
    deleted bit,
    PRIMARY KEY (idType)
);

CREATE TABLE product (
    idProduct int NOT NULL AUTO_INCREMENT,
    idType int,
    name varchar(50),
    features json,
    image longblob,
    createDate datetime,
    updateDate datetime,
    deleted bit,
    PRIMARY KEY (idProduct),

    CONSTRAINT FK_ProductIdType
    FOREIGN KEY (idType)
    REFERENCES product_type(idType)
);

CREATE TABLE sale (
    idSale int NOT NULL AUTO_INCREMENT,
    idUser int,
    products json,
    totalSale int,
    createDate datetime,
    updateDate datetime,
    deleted bit,
    PRIMARY KEY (idSale)
);

CREATE TABLE review (
    idReview int NOT NULL AUTO_INCREMENT,
    idProduct int,
    idUser int,
    calification int,
    review varchar(1500),
    createDate datetime,
    updateDate datetime,
    deleted bit,
    PRIMARY KEY (idReview),

    CONSTRAINT FK_ReviewIdProduct
    FOREIGN KEY (idProduct)
    REFERENCES product(idProduct)
);

CREATE TABLE resolution (
    idResolution int NOT NULL AUTO_INCREMENT,
    idReview int,
    idUser int,
    resolution varchar(1500),
    createDate datetime,
    updateDate datetime,
    deleted bit,
    PRIMARY KEY (idResolution),

    CONSTRAINT FK_ResolutionIdReview
    FOREIGN KEY (idReview)
    REFERENCES review(idReview)
);