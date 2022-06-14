CREATE PROCEDURE prcGetOrdersById
@user int
AS
BEGIN
	BEGIN TRY 

        SELECT (
            select S.idSale, S.createDate, S.totalSale 
            from OPENQUERY([UNIVERSAL-MYSQL], 'SELECT idUser,idSale, createDate, totalSale FROM product.sale') S
            where S.idUser = @user
            FOR JSON AUTO
            )as orders

        SELECT 'Succes';

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