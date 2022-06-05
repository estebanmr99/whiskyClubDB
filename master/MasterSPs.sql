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

-- EXECUTE prcFindUserByEmail @emailParam = 'usAdmin@whiskyclub.com';