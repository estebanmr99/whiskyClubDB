-- Data to insert into the database user of each user instance by country

-- Inser the types of users in the database
SET IDENTITY_INSERT [dbo].[user_type] ON;
INSERT INTO [dbo].[user_type] (idUserType, name, deleted)
VALUES (0, 'admin', 0),
	   (1, 'user', 0);
SET IDENTITY_INSERT [dbo].[user_type] OFF;

-- Insert types of suscription in the database
SET IDENTITY_INSERT [dbo].[level] ON;
DELETE FROM [dbo].[level];
INSERT INTO [dbo].[level] (idLevel, description, discProduct, discShipping, deleted)
VALUES (0, 'User without suscription', 0, 0, 0),
	   (1, 'Tier Short Glass', 5, 0, 0),
	   (2, 'Tier Gleincairn', 10, 20, 0),
	   (3, 'Tier Master Distiller', 30, 100, 0);
SET IDENTITY_INSERT [dbo].[level] OFF;

-- Insert the admin user of USA
DELETE [dbo].[user];
INSERT INTO [dbo].[user]
VALUES (0, 0, 0, 'usAdmin@whiskyclub.com', '$2b$10$hyfKWZ6zXiWBhlQk1enA7uAeWkXkpop8evE4M/oeI4y5OIIEQsqWy', 'admin', 'admin', '00000000', geography::Point(34.242654312581806, -104.31417550970465, 4326), GETDATE(), GETDATE(), 0);

-- Insert the admin user of Ireland
DELETE [dbo].[user];
INSERT INTO [dbo].[user]
VALUES (1, 0, 0, 'ieAdmin@whiskyclub.com', '$2b$10$hyfKWZ6zXiWBhlQk1enA7uAeWkXkpop8evE4M/oeI4y5OIIEQsqWy', 'admin', 'admin', '00000000', geography::Point(53.25921170035985, -7.939292382812493, 4326), GETDATE(), GETDATE(), 0);

-- Insert the admin user of Scotland
DELETE [dbo].[user];
INSERT INTO [dbo].[user]
VALUES (2, 0, 0, 'stkAdmin@whiskyclub.com', '$2b$10$hyfKWZ6zXiWBhlQk1enA7uAeWkXkpop8evE4M/oeI4y5OIIEQsqWy', 'admin', 'admin', '00000000', geography::Point(56.02870674629225, -3.984973649529138, 4326), GETDATE(), GETDATE(), 0);