CREATE DATABASE employee;

USE employee;

CREATE TABLE department (
    idDepartment int NOT NULL AUTO_INCREMENT,
    name varchar(50),
    deleted bit,
    PRIMARY KEY (idDepartment)
);

CREATE TABLE employee (
    idEmployee int NOT NULL AUTO_INCREMENT,
    idDepartment int,
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
    FOREIGN KEY (idDepartment)
    REFERENCES department(idDepartment)
);

CREATE TABLE review (
    idReview int NOT NULL AUTO_INCREMENT,
    idEmployee int,
    idUser int,
    calification int,
    review varchar(1500),
    createDate datetime,
    updateDate datetime,
    deleted bit,
    PRIMARY KEY (idReview),

    CONSTRAINT FK_ReviewIdEmployee
    FOREIGN KEY (idEmployee)
    REFERENCES employee(idEmployee)
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