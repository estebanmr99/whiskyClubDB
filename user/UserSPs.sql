CREATE PROCEDURE prcFindUserByEmail
@email varchar(50)
AS
BEGIN
	BEGIN TRY 
		SELECT (		
			SELECT idUser, idUserType, idLevel, email, password, name, lastName
        	FROM [dbo].[user]
        	WHERE email = @email
			FOR JSON AUTO
		) AS userFound

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
GO;

-- EXECUTE prcFindUserByEmail @email = 'usAdmin@whiskyclub.com';