CREATE DATABASE employee;

CREATE TABLE position (
    idPosition int identity,
    name varchar(50),
    deleted bit,
    PRIMARY KEY (idPosition)
);

CREATE TABLE employee (
    idEmployee int identity,
    idPosition int,
    name varchar(50),
    lastName varchar(50),
    address varchar(150),
    telephone varchar(30),
    birthDate date,
    createDate datetime,
    updateDate datetime,
    deleted bit,
    PRIMARY KEY (idEmployee),

    CONSTRAINT FK_EmployeeIdPosition
    FOREIGN KEY (idPosition)
    REFERENCES position(idPosition)
);

CREATE TABLE review (
    idReview int identity,
    idEmployee int,
    idUser int,
    calification int,
    review varchar(MAX),
    createDate datetime,
    updateDate datetime,
    deleted bit,
    PRIMARY KEY (idReview),

    CONSTRAINT FK_ReviewIdEmployee
    FOREIGN KEY (idEmployee)
    REFERENCES employee(idEmployee)
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