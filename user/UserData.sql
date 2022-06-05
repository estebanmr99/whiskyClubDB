SET IDENTITY_INSERT [dbo].[user_type] ON;
INSERT INTO [dbo].[user_type] (idUserType, name, deleted)
VALUES (0, 'admin', 0),
	   (1, 'user', 0);

SET IDENTITY_INSERT [dbo].[user_type] OFF;

SET IDENTITY_INSERT [dbo].[level] ON;
INSERT INTO [dbo].[level] (idLevel, description, discProduct, discShipping, deleted)
VALUES (0, 'User without suscription', 0, 0, 0);

SET IDENTITY_INSERT [dbo].[level] OFF;

ALTER TABLE [dbo].[user] ALTER COLUMN [password] VARCHAR (255);

-- USA
INSERT INTO [dbo].[user]
VALUES (0, 0, 0, 'usAdmin@whiskyclub.com', '$2b$10$hyfKWZ6zXiWBhlQk1enA7uAeWkXkpop8evE4M/oeI4y5OIIEQsqWy', 'admin', 'admin', '00000000', null, GETDATE(), GETDATE(), 0);

-- Ireland
INSERT INTO [dbo].[user]
VALUES (1, 0, 0, 'ieAdmin@whiskyclub.com', '$2b$10$hyfKWZ6zXiWBhlQk1enA7uAeWkXkpop8evE4M/oeI4y5OIIEQsqWy', 'admin', 'admin', '00000000', null, GETDATE(), GETDATE(), 0);

-- Scotland
INSERT INTO [dbo].[user]
VALUES (2, 0, 0, 'stkAdmin@whiskyclub.com', '$2b$10$hyfKWZ6zXiWBhlQk1enA7uAeWkXkpop8evE4M/oeI4y5OIIEQsqWy', 'admin', 'admin', '00000000', null, GETDATE(), GETDATE(), 0);