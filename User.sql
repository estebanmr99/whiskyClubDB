CREATE DATABASE user;

CREATE TABLE user_type (
    idUserType int identity,
    name varchar(50),
    deleted bit,
    PRIMARY KEY (idUserType)
);

CREATE TABLE level (
    idLevel int identity,
    description varchar(MAX),
    discProduct int,
    discShipping int,
    deleted bit,
    PRIMARY KEY (idLevel)
);

CREATE TABLE user (
    idUser int identity,
    idUserType int,
    idLevel int,
    email varchar(50),
    password varchar(50),
    name varchar(50),
    lastName varchar(50),
    telephone varchar(30),
    location geography,
    createDate datetime,
    updateDate datetime,
    deleted bit,
    PRIMARY KEY (idUser),

    CONSTRAINT FK_UserIdUserType
    FOREIGN KEY (idUserType)
    REFERENCES user_type(idUserType),

    CONSTRAINT FK_UserIdLevel
    FOREIGN KEY (idLevel)
    REFERENCES level(idLevel)
);