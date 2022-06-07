CREATE PROCEDURE prcFindUserByEmail
@emailParam varchar(50)
AS
BEGIN
	BEGIN TRY

		DROP TABLE IF EXISTS #user
		CREATE TABLE #user (userFound varchar(MAX));

		INSERT INTO #user
		EXECUTE [UNITEDSTATESSQL].[usa_user].[dbo].[prcFindUserByEmail] @email = @emailParam;

		INSERT INTO #user
		EXECUTE [SCOTLANDSQL].[stk_user].[dbo].[prcFindUserByEmail] @email = @emailParam;

		INSERT INTO #user
		EXECUTE [IRELANDSQL].[ie_user].[dbo].[prcFindUserByEmail] @email = @emailParam;

		SELECT userFound FROM #user WHERE userFound IS NOT NULL;

		DROP TABLE #user;

	END TRY 
	BEGIN CATCH
	SELECT
	  ERROR_NUMBER() AS ErrorNumber  
            ,ERROR_SEVERITY() AS ErrorSeverity  
            ,ERROR_STATE() AS ErrorState  
            ,ERROR_PROCEDURE() AS ErrorProcedure  
            ,ERROR_LINE() AS ErrorLine  
            ,ERROR_MESSAGE() AS ErrorMessage;

	END CATCH

END
GO

-- EXECUTE prcFindUserByEmail @email = 'usAdmin@whiskyclub.com';

CREATE PROCEDURE prcGetNextUserId
AS
BEGIN
	BEGIN TRY

		DROP TABLE IF EXISTS #user
		CREATE TABLE #user (maxIDuser varchar(MAX));

		INSERT INTO #user
		EXECUTE [UNITEDSTATESSQL].[usa_user].[dbo].[prcGetNextUserId];

		INSERT INTO #user
		EXECUTE [SCOTLANDSQL].[stk_user].[dbo].[prcGetNextUserId];

		INSERT INTO #user
		EXECUTE [IRELANDSQL].[ie_user].[dbo].[prcGetNextUserId];

		SELECT MAX(maxIDuser) + 1 FROM #user;

		DROP TABLE #user;

	END TRY 
	BEGIN CATCH
	SELECT
	  ERROR_NUMBER() AS ErrorNumber  
            ,ERROR_SEVERITY() AS ErrorSeverity  
            ,ERROR_STATE() AS ErrorState  
            ,ERROR_PROCEDURE() AS ErrorProcedure  
            ,ERROR_LINE() AS ErrorLine  
            ,ERROR_MESSAGE() AS ErrorMessage;

	END CATCH

END
GO

-- EXECUTE prcGetNextUserId;

CREATE PROCEDURE prcRegisterUser
@emailParam varchar(50),
@passwordParam varchar(255),
@locationLatParam int,
@locationLngParam int,
@nameParam varchar(50),
@lastnameParam varchar(50),
@telephoneParam varchar(30) = '',
@country varchar(30)
AS
BEGIN
	BEGIN TRY 

		DROP TABLE IF EXISTS #user
		CREATE TABLE #user (userFound varchar(MAX));

		INSERT INTO #user
		EXECUTE [masterdb].[dbo].[prcFindUserByEmail] @email = @emailParam;

		IF NOT EXISTS (SELECT * FROM #user)
			BEGIN
				DROP TABLE IF EXISTS #idUser
				CREATE TABLE #idUser (maxIDuser varchar(MAX));

				INSERT INTO #idUser
				EXECUTE [masterdb].[dbo].[prcGetNextUserId];

				DECLARE @maxIDuser int;
				SELECT @maxIDuser = maxIDuser FROM #idUser;

				IF @country = 'Unites States'
					EXECUTE [UNITEDSTATESSQL].[usa_user].[dbo].[prcRegisterUser] @iduser = @maxIDuser, @email = @emailParam, @password = @passwordParam, @locationLat = @locationLatParam, @locationLng = @locationLngParam, @name = @nameParam, @lastName = @lastnameParam, @telephone = @telephoneParam;
				ELSE IF @country = 'Scotland'
					EXECUTE [SCOTLANDSQL].[stk_user].[dbo].[prcRegisterUser] @iduser = @maxIDuser, @email = @emailParam, @password = @passwordParam, @locationLat = @locationLatParam, @locationLng = @locationLngParam, @name = @nameParam, @lastName = @lastnameParam, @telephone = @telephoneParam;
				ELSE IF @country = 'Ireland'
					EXECUTE [IRELANDSQL].[ie_user].[dbo].[prcRegisterUser] @iduser = @maxIDuser, @email = @emailParam, @password = @passwordParam, @locationLat = @locationLatParam, @locationLng = @locationLngParam, @name = @nameParam, @lastName = @lastnameParam, @telephone = @telephoneParam;
				ELSE
					RAISERROR ( 'Whoops, an error occurred.', 11, 1);

				SELECT 'Created';
			END
		ELSE
			BEGIN
				RAISERROR ('Email already in use.', 11, 1);
			END
	END TRY 
	BEGIN CATCH
	SELECT
	  ERROR_NUMBER() AS ErrorNumber  
            ,ERROR_SEVERITY() AS ErrorSeverity  
            ,ERROR_STATE() AS ErrorState  
            ,ERROR_PROCEDURE() AS ErrorProcedure  
            ,ERROR_LINE() AS ErrorLine  
            ,ERROR_MESSAGE() AS ErrorMessage;

	END CATCH

END
GO

-- EXECUTE prcRegisterUser @email = 'usAdmin@whiskyclub.com';