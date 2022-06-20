-- Master database schema (it the local database)
-- Makes use of the SQL server database system

CREATE DATABASE masterdb;

CREATE TABLE tempNextUserId (maxIDuser INT);
CREATE TABLE tempUserJson (userFound VARCHAR(MAX));

CREATE TABLE tempNextProductId (maxIDuser INT);
CREATE TABLE tempProductJson (productFound VARCHAR(MAX));
