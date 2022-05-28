CREATE DATABASE product;

CREATE TABLE product_type (
    idType int identity,
    name varchar(50),
    deleted bit,
    PRIMARY KEY (idType)
);

CREATE TABLE product (
    idProduct int identity,
    idType int,
    name varchar(50),
    features varchar(MAX),
    image varbinary(MAX),
    createDate datetime,
    updateDate datetime,
    deleted bit,
    PRIMARY KEY (idProduct),

    CONSTRAINT FK_ProductIdType
    FOREIGN KEY (idType)
    REFERENCES product_type(idType)
);

CREATE TABLE sale (
    idSale int identity,
    idUser int,
    products varchar(MAX),
    totalSale money,
    createDate datetime,
    updateDate datetime,
    deleted bit,
    PRIMARY KEY (idSale)
);

CREATE TABLE review (
    idReview int identity,
    idProduct int,
    idUser int,
    calification int,
    review varchar(MAX),
    createDate datetime,
    updateDate datetime,
    deleted bit,
    PRIMARY KEY (idReview),

    CONSTRAINT FK_ReviewIdProduct
    FOREIGN KEY (idEmployee)
    REFERENCES product(idProduct)
);

CREATE TABLE resolution (
    idResolution int identity,
    idReview int,
    idUser int,
    resolution varchar(MAX),
    createDate datetime,
    updateDate datetime,
    deleted bit,
    PRIMARY KEY (idResolution),

    CONSTRAINT FK_ResolutionIdReview
    FOREIGN KEY (idReview)
    REFERENCES review(idReview)
);