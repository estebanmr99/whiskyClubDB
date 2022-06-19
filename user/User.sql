-- User database schema
-- Makes use of the SQL server database system
-- A instance need to be created for each country

-------------------------------------------------------------- ireland --------------------------------------------------------------

-- CREATE DATABASE ie_user;

-- USE ie_user;

-------------------------------------------------------------- scotland --------------------------------------------------------------

-- CREATE DATABASE stk_user;

-- USE stk_user;

-------------------------------------------------------------- united states --------------------------------------------------------------

-- CREATE DATABASE usa_user;

-- USE usa_user;

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

CREATE TABLE [user] (
    idUser int,
    idUserType int,
    idLevel int,
    email varchar(50),
    password varchar(255),
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