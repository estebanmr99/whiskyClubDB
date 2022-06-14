
CREATE PROCEDURE prcFindEmploBySotre
@store int,
@idEmployee int
AS
BEGIN
	BEGIN TRY 

        IF @store = 1
        SELECT (
            select Eh.idEmployee,Ep.name, Ep.lastName, Ep.birthDate,Eh.localSalary,Eh.globalSalary from [IRELANDSQL].[ie_store1].[dbo].[employee] Eh
            inner join (select * from OPENQUERY([UNIVERSAL-MYSQL], 'SELECT * FROM employee.employee')) Ep on Eh.idEmployee = Ep.idEmployee
            where Eh.idEmployee = @idEmployee
            FOR JSON AUTO
            )as employees

        ELSE IF @store = 2
       SELECT (
            select Eh.idEmployee,Ep.name, Ep.lastName, Ep.birthDate,Eh.localSalary,Eh.globalSalary from [IRELANDSQL].[ie_store2].[dbo].[employee] Eh
            inner join (select * from OPENQUERY([UNIVERSAL-MYSQL], 'SELECT * FROM employee.employee')) Ep on Eh.idEmployee = Ep.idEmployee
            where Eh.idEmployee = @idEmployee
            FOR JSON AUTO
            )as employees

        ELSE IF @store = 3
       SELECT (
            select Eh.idEmployee,Ep.name, Ep.lastName, Ep.birthDate,Eh.localSalary,Eh.globalSalary from [IRELANDSQL].[ie_store3].[dbo].[employee] Eh
            inner join (select * from OPENQUERY([UNIVERSAL-MYSQL], 'SELECT * FROM employee.employee')) Ep on Eh.idEmployee = Ep.idEmployee
            where Eh.idEmployee = @idEmployee
            FOR JSON AUTO
            )as employees

        ELSE IF @store = 4
        SELECT (
            select Eh.idEmployee,Ep.name, Ep.lastName, Ep.birthDate,Eh.localSalary,Eh.globalSalary from [SCOTLANDSQL].[stk_store1].[dbo].[employee] Eh
            inner join (select * from OPENQUERY([UNIVERSAL-MYSQL], 'SELECT * FROM employee.employee')) Ep on Eh.idEmployee = Ep.idEmployee
            where Eh.idEmployee = @idEmployee
            FOR JSON AUTO
            )as employees
        ELSE IF @store = 5
       SELECT (
            select Eh.idEmployee,Ep.name, Ep.lastName, Ep.birthDate,Eh.localSalary,Eh.globalSalary from [SCOTLANDSQL].[stk_store2].[dbo].[employee] Eh
            inner join (select * from OPENQUERY([UNIVERSAL-MYSQL], 'SELECT * FROM employee.employee')) Ep on Eh.idEmployee = Ep.idEmployee
            where Eh.idEmployee = @idEmployee
            FOR JSON AUTO
            )as employees
        ELSE IF @store = 6
        SELECT (
            select Eh.idEmployee,Ep.name, Ep.lastName, Ep.birthDate,Eh.localSalary,Eh.globalSalary from [SCOTLANDSQL].[stk_store3].[dbo].[employee] Eh
            inner join (select * from OPENQUERY([UNIVERSAL-MYSQL], 'SELECT * FROM employee.employee')) Ep on Eh.idEmployee = Ep.idEmployee
            where Eh.idEmployee = @idEmployee
            FOR JSON AUTO
            )as employees
        ELSE IF @store = 7
       SELECT (
            select Eh.idEmployee,Ep.name, Ep.lastName, Ep.birthDate,Eh.localSalary,Eh.globalSalary from [UNITEDSTATESSQL].[usa_store1].[dbo].[employee] Eh
            inner join (select * from OPENQUERY([UNIVERSAL-MYSQL], 'SELECT * FROM employee.employee')) Ep on Eh.idEmployee = Ep.idEmployee
            where Eh.idEmployee = @idEmployee
            FOR JSON AUTO
            )as employees
        ELSE IF @store = 8
       SELECT (
            select Eh.idEmployee,Ep.name, Ep.lastName, Ep.birthDate,Eh.localSalary,Eh.globalSalary from [UNITEDSTATESSQL].[usa_store2].[dbo].[employee] Eh
            inner join (select * from OPENQUERY([UNIVERSAL-MYSQL], 'SELECT * FROM employee.employee')) Ep on Eh.idEmployee = Ep.idEmployee
            where Eh.idEmployee = @idEmployee
            FOR JSON AUTO
            )as employees
        ELSE IF @store = 9
        SELECT (
            select Eh.idEmployee,Ep.name, Ep.lastName, Ep.birthDate,Eh.localSalary,Eh.globalSalary from [UNITEDSTATESSQL].[usa_store3].[dbo].[employee] Eh
            inner join (select * from OPENQUERY([UNIVERSAL-MYSQL], 'SELECT * FROM employee.employee')) Ep on Eh.idEmployee = Ep.idEmployee
            where Eh.idEmployee = @idEmployee
            FOR JSON AUTO
            )as employees
        ELSE
            RAISERROR ( 'Whoops, an error occurred.', 11, 1);

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

EXECUTE prcFindEmploBySotre @store = 1,@idEmployee= 
EXECUTE prcFindEmploBySotre @store = 3,@idEmployee= 
EXECUTE prcFindEmploBySotre @store = 4,@idEmployee= 
EXECUTE prcFindEmploBySotre @store = 5,@idEmployee= 
EXECUTE prcFindEmploBySotre @store = 6,@idEmployee= 
EXECUTE prcFindEmploBySotre @store = 7,@idEmployee= 
EXECUTE prcFindEmploBySotre @store = 8,@idEmployee= 
EXECUTE prcFindEmploBySotre @store = 9,@idEmployee= 



CREATE PROCEDURE prcFindEmployeesBySotre
@store int
AS
BEGIN
	BEGIN TRY 

        IF @store = 1
        SELECT (
            select Eh.idEmployee,Ep.name,Ep.lastName  from [IRELANDSQL].[ie_store1].[dbo].[employee] Eh
            inner join (select * from OPENQUERY([UNIVERSAL-MYSQL], 'SELECT * FROM employee.employee')) Ep on Eh.idEmployee = Ep.idEmployee
            where Eh.deleted = 0
            FOR JSON AUTO
            )as employees

        ELSE IF @store = 2
       SELECT (
            select Eh.idEmployee,Ep.name, Ep.lastName from [IRELANDSQL].[ie_store2].[dbo].[employee] Eh
            inner join (select * from OPENQUERY([UNIVERSAL-MYSQL], 'SELECT * FROM employee.employee')) Ep on Eh.idEmployee = Ep.idEmployee
            where Eh.deleted = 0
            FOR JSON AUTO
            )as employees

        ELSE IF @store = 3
       SELECT (
            select Eh.idEmployee,Ep.name, Ep.lastName from [IRELANDSQL].[ie_store3].[dbo].[employee] Eh
            inner join (select * from OPENQUERY([UNIVERSAL-MYSQL], 'SELECT * FROM employee.employee')) Ep on Eh.idEmployee = Ep.idEmployee
            where Eh.deleted = 0
            FOR JSON AUTO
            )as employees

        ELSE IF @store = 4
        SELECT (
            select Eh.idEmployee,Ep.name, Ep.lastName from [SCOTLANDSQL].[stk_store1].[dbo].[employee] Eh
            inner join (select * from OPENQUERY([UNIVERSAL-MYSQL], 'SELECT * FROM employee.employee')) Ep on Eh.idEmployee = Ep.idEmployee
            where Eh.deleted = 0
            FOR JSON AUTO
            )as employees
        ELSE IF @store = 5
       SELECT (
            select Eh.idEmployee,Ep.name, Ep.lastName from [SCOTLANDSQL].[stk_store2].[dbo].[employee] Eh
            inner join (select * from OPENQUERY([UNIVERSAL-MYSQL], 'SELECT * FROM employee.employee')) Ep on Eh.idEmployee = Ep.idEmployee
            where Eh.deleted = 0
            FOR JSON AUTO
            )as employees
        ELSE IF @store = 6
        SELECT (
            select Eh.idEmployee,Ep.name, Ep.lastName from [SCOTLANDSQL].[stk_store3].[dbo].[employee] Eh
            inner join (select * from OPENQUERY([UNIVERSAL-MYSQL], 'SELECT * FROM employee.employee')) Ep on Eh.idEmployee = Ep.idEmployee
            where Eh.deleted = 0
            FOR JSON AUTO
            )as employees
        ELSE IF @store = 7
       SELECT (
            select Eh.idEmployee,Ep.name, Ep.lastName from [UNITEDSTATESSQL].[usa_store1].[dbo].[employee] Eh
            inner join (select * from OPENQUERY([UNIVERSAL-MYSQL], 'SELECT * FROM employee.employee')) Ep on Eh.idEmployee = Ep.idEmployee
            where Eh.deleted = 0
            FOR JSON AUTO
            )as employees
        ELSE IF @store = 8
       SELECT (
            select Eh.idEmployee,Ep.name, Ep.lastName from [UNITEDSTATESSQL].[usa_store2].[dbo].[employee] Eh
            inner join (select * from OPENQUERY([UNIVERSAL-MYSQL], 'SELECT * FROM employee.employee')) Ep on Eh.idEmployee = Ep.idEmployee
            where Eh.deleted = 0
            FOR JSON AUTO
            )as employees
        ELSE IF @store = 9
        SELECT (
            select Eh.idEmployee,Ep.name, Ep.lastName from [UNITEDSTATESSQL].[usa_store3].[dbo].[employee] Eh
            inner join (select * from OPENQUERY([UNIVERSAL-MYSQL], 'SELECT * FROM employee.employee')) Ep on Eh.idEmployee = Ep.idEmployee
            where Eh.deleted = 0
            FOR JSON AUTO
            )as employees
        ELSE
            RAISERROR ( 'Whoops, an error occurred.', 11, 1);

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

exec prcFindEmployeesBySotre
@store = 5

--
--
--
--
--
CREATE PROCEDURE prcUpdateEmploBySotre
@store int,
@idEmployee int,
@name varchar(50),
@lastName varchar(50),
@birthDate varchar(50),
@localSalary money,
@globalSalary money
AS
BEGIN
	BEGIN TRY 
		DECLARE @select varchar(150),@update varchar(150),@sql varchar(300)
		set @select = 'update OPENQUERY([UNIVERSAL-MYSQL],
					''SELECT idEmployee,name,lastName,birthDate,updateDate FROM employee.employee where (idEmployee ='+ CAST(@idEmployee as nvarchar(30))+')'')'
		set @update = 'set name = '+QUOTENAME(@name,'''')+   
					   ', lastName = '+QUOTENAME(@lastName,'''')+
					   ', birthDate = '+QUOTENAME(@birthDate,'''')+
					   ', updateDate = '+QUOTENAME((SELECT CONVERT(varchar, getdate(), 23)),'''')

		set @sql = @select + @update

        IF @store = 1
        BEGIN
            UPDATE [IRELANDSQL].[ie_store1].[dbo].[employee]
            SET localSalary= @localSalary,
                globalSalary= @globalSalary
            WHERE idEmployee = @idEmployee

			EXEC (@sql) 

       
        END

        ELSE IF @store = 2
            BEGIN
            UPDATE [IRELANDSQL].[ie_store2].[dbo].[employee]
            SET localSalary= @localSalary,
                globalSalary= @globalSalary
            WHERE idEmployee = @idEmployee

            EXEC (@sql) 
            END

        ELSE IF @store = 3
            BEGIN
            UPDATE [IRELANDSQL].[ie_store3].[dbo].[employee]
            SET localSalary= @localSalary,
                globalSalary= @globalSalary
            WHERE idEmployee = @idEmployee

            EXEC (@sql) 
            END

        ELSE IF @store = 4
            BEGIN
            UPDATE [SCOTLANDSQL].[stk_store1].[dbo].[employee]
            SET localSalary= @localSalary,
                globalSalary= @globalSalary
            WHERE idEmployee = @idEmployee

            EXEC (@sql) 
            END
        ELSE IF @store = 5
            BEGIN
            UPDATE [SCOTLANDSQL].[stk_store2].[dbo].[employee]
            SET localSalary= @localSalary,
                globalSalary= @globalSalary
            WHERE idEmployee = @idEmployee

            EXEC (@sql) 
            END
        ELSE IF @store = 6
            BEGIN
            UPDATE [SCOTLANDSQL].[stk_store3].[dbo].[employee]
            SET localSalary= @localSalary,
                globalSalary= @globalSalary
            WHERE idEmployee = @idEmployee

            EXEC (@sql) 
            END
        ELSE IF @store = 7
            BEGIN
            UPDATE [UNITEDSTATESSQL].[usa_store1].[dbo].[employee] 
            SET localSalary= @localSalary,
                globalSalary= @globalSalary
            WHERE idEmployee = @idEmployee

            EXEC (@sql) 
            END
        ELSE IF @store = 8
            BEGIN
            UPDATE [UNITEDSTATESSQL].[usa_store2].[dbo].[employee]
            SET localSalary= @localSalary,
                globalSalary= @globalSalary
            WHERE idEmployee = @idEmployee

            EXEC (@sql) 
            END
        ELSE IF @store = 9
            BEGIN
            UPDATE [UNITEDSTATESSQL].[usa_store3].[dbo].[employee]
            SET localSalary= @localSalary,
                globalSalary= @globalSalary
            WHERE idEmployee = @idEmployee

            EXEC (@sql) 
            END
        ELSE
            RAISERROR ( 'Whoops, an error occurred.', 11, 1);

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


EXEC prcUpdateEmploBySotre
@store =7,
@idEmployee =10,
@name ='froilan',
@lastName ='velasuqez',
@birthDate ='31-12-2020',
@localSalary =0,
@globalSalary =0

--
--
--
--
--
CREATE PROCEDURE prcInsertEmploBySotre
@store int,
@name varchar(50),
@lastName varchar(50),
@birthDate date,
@localSalary money,
@globalSalary money
AS
BEGIN
	BEGIN TRY 
        DECLARE @maxIDuser int;
        SET @maxIDuser = 0; 
		SELECT @maxIDuser = MAX(idEmployee) FROM OPENQUERY([UNIVERSAL-MYSQL], 'SELECT idEmployee FROM employee.employee')
		SET @maxIDuser = @maxIDuser+1; 
        IF @store = 1
			BEGIN
            INSERT INTO [IRELANDSQL].[ie_store1].[dbo].[employee](idEmployee,localSalary,globalSalary,deleted)--OPENQUERY ([IRELANDSQL],'select idEmployee,localSalary,globalSalary,deleted from [ie_store1].[dbo].[employee]')
            VALUES (@maxIDuser,@localSalary, @globalSalary,0)

            INSERT OPENQUERY([UNIVERSAL-MYSQL], 'SELECT idEmployee,name,lastName,birthDate,createDate,updateDate,deleted FROM employee.employee')   
            VALUES(@maxIDuser,@name,@lastName,@birthDate,(SELECT GETDATE()),(SELECT GETDATE()),0)
           END

        ELSE IF @store = 2
            BEGIN
            INSERT INTO [IRELANDSQL].[ie_store2].[dbo].[employee](idEmployee,localSalary,globalSalary,deleted)
            VALUES (@maxIDuser,@localSalary, @globalSalary,0)

            INSERT OPENQUERY([UNIVERSAL-MYSQL], 'SELECT idEmployee,name,lastName,birthDate,createDate,updateDate,deleted FROM employee.employee')   
            VALUES(@maxIDuser,@name,@lastName,@birthDate,(SELECT GETDATE()),(SELECT GETDATE()),0)
            END

        ELSE IF @store = 3
            BEGIN
            INSERT INTO [IRELANDSQL].[ie_store3].[dbo].[employee](idEmployee,localSalary,globalSalary,deleted)
            VALUES (@maxIDuser,@localSalary, @globalSalary,0)

            INSERT OPENQUERY([UNIVERSAL-MYSQL], 'SELECT idEmployee,name,lastName,birthDate,createDate,updateDate,deleted FROM employee.employee')   
            VALUES(@maxIDuser,@name,@lastName,@birthDate,(SELECT GETDATE()),(SELECT GETDATE()),0)
            END

        ELSE IF @store = 4
            BEGIN
            INSERT INTO [SCOTLANDSQL].[stk_store1].[dbo].[employee](idEmployee,localSalary,globalSalary,deleted)
            VALUES (@maxIDuser,@localSalary, @globalSalary,0)

            INSERT OPENQUERY([UNIVERSAL-MYSQL], 'SELECT idEmployee,name,lastName,birthDate,createDate,updateDate,deleted FROM employee.employee')   
            VALUES(@maxIDuser,@name,@lastName,@birthDate,(SELECT GETDATE()),(SELECT GETDATE()),0)
            END

        ELSE IF @store = 5
            BEGIN
            INSERT INTO [SCOTLANDSQL].[stk_store2].[dbo].[employee](idEmployee,localSalary,globalSalary,deleted)
            VALUES (@maxIDuser,@localSalary, @globalSalary,0)

            INSERT OPENQUERY([UNIVERSAL-MYSQL], 'SELECT idEmployee,name,lastName,birthDate,createDate,updateDate,deleted FROM employee.employee')   
            VALUES(@maxIDuser,@name,@lastName,@birthDate,(SELECT GETDATE()),(SELECT GETDATE()),0)
            END

        ELSE IF @store = 6
            BEGIN
            INSERT INTO [SCOTLANDSQL].[stk_store3].[dbo].[employee](idEmployee,localSalary,globalSalary,deleted)
            VALUES (@maxIDuser,@localSalary, @globalSalary,0)

            INSERT OPENQUERY([UNIVERSAL-MYSQL], 'SELECT idEmployee,name,lastName,birthDate,createDate,updateDate,deleted FROM employee.employee')   
            VALUES(@maxIDuser,@name,@lastName,@birthDate,(SELECT GETDATE()),(SELECT GETDATE()),0)
            END

        ELSE IF @store = 7
            BEGIN
            INSERT INTO [UNITEDSTATESSQL].[usa_store1].[dbo].[employee](idEmployee,localSalary,globalSalary,deleted)
            VALUES (@maxIDuser,@localSalary, @globalSalary,0)

            INSERT OPENQUERY([UNIVERSAL-MYSQL], 'SELECT idEmployee,name,lastName,birthDate,createDate,updateDate,deleted FROM employee.employee')   
            VALUES(@maxIDuser,@name,@lastName,@birthDate,(SELECT GETDATE()),(SELECT GETDATE()),0)
            END

        ELSE IF @store = 8
            BEGIN   
            INSERT INTO [UNITEDSTATESSQL].[usa_store2].[dbo].[employee](idEmployee,localSalary,globalSalary,deleted)
            VALUES (@maxIDuser,@localSalary, @globalSalary,0)

            INSERT OPENQUERY([UNIVERSAL-MYSQL], 'SELECT idEmployee,name,lastName,birthDate,createDate,updateDate,deleted FROM employee.employee')   
            VALUES(@maxIDuser,@name,@lastName,@birthDate,(SELECT GETDATE()),(SELECT GETDATE()),0)
            END

        ELSE IF @store = 9
            BEGIN
            INSERT INTO [UNITEDSTATESSQL].[usa_store3].[dbo].[employee](idEmployee,localSalary,globalSalary,deleted)
            VALUES (@maxIDuser,@localSalary, @globalSalary,0)

            INSERT OPENQUERY([UNIVERSAL-MYSQL], 'SELECT idEmployee,name,lastName,birthDate,createDate,updateDate,deleted FROM employee.employee')   
            VALUES(@maxIDuser,@name,@lastName,@birthDate,(SELECT GETDATE()),(SELECT GETDATE()),0)
            END
        ELSE
            RAISERROR ( 'Whoops, an error occurred.', 11, 1);

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


EXECUTE prcInsertEmploBySotre
@store=10 ,
@name='Keylor' ,
@lastName ='velasuqez',
@birthDate ='31-12-2000',
@localSalary =10000,
@globalSalary=20000  
--
--
--
---
--
CREATE PROCEDURE prcDeleteEmploBySotre
@store int,
@idEmployee int
AS
BEGIN
	BEGIN TRY 
		DECLARE @select varchar(150),@update varchar(150),@sql varchar(300)
		set @select = 'update OPENQUERY([UNIVERSAL-MYSQL],
					''SELECT idEmployee,deleted FROM employee.employee where (idEmployee ='+ CAST(@idEmployee as nvarchar(30))+')'')'
		set @update = 'set deleted = 1'

		set @sql = @select + @update

        IF @store = 1
            BEGIN
            UPDATE [IRELANDSQL].[ie_store1].[dbo].[employee]
            SET deleted= 1
            WHERE idEmployee = @idEmployee

            EXEC (@sql) 
           END

        ELSE IF @store = 2
            BEGIN
            UPDATE [IRELANDSQL].[ie_store2].[dbo].[employee]
            SET deleted= 1
            WHERE idEmployee = @idEmployee

            EXEC (@sql) 
            END

        ELSE IF @store = 3
            BEGIN
            UPDATE [IRELANDSQL].[ie_store3].[dbo].[employee]
            SET deleted= 1
            WHERE idEmployee = @idEmployee

            EXEC (@sql) 
            END

        ELSE IF @store = 4
            BEGIN
            UPDATE [SCOTLANDSQL].[stk_store1].[dbo].[employee]
            SET deleted= 1
            WHERE idEmployee = @idEmployee

            EXEC (@sql) 
            END

        ELSE IF @store = 5
            BEGIN
            UPDATE [SCOTLANDSQL].[stk_store2].[dbo].[employee]
            SET deleted= 1
            WHERE idEmployee = @idEmployee

            EXEC (@sql) 
            END

        ELSE IF @store = 6
            BEGIN
            UPDATE [SCOTLANDSQL].[stk_store3].[dbo].[employee]
            SET deleted= 1
            WHERE idEmployee = @idEmployee

            EXEC (@sql) 
            END

        ELSE IF @store = 7
            BEGIN
            UPDATE [UNITEDSTATESSQL].[usa_store1].[dbo].[employee] 
            SET deleted= 1
            WHERE idEmployee = @idEmployee

            EXEC (@sql) 
            END
        ELSE IF @store = 8
            BEGIN
            UPDATE [UNITEDSTATESSQL].[usa_store2].[dbo].[employee]
            SET deleted= 1
            WHERE idEmployee = @idEmployee

            EXEC (@sql) 
            END

        ELSE IF @store = 9
            BEGIN
            UPDATE [UNITEDSTATESSQL].[usa_store3].[dbo].[employee]
            SET deleted= 1
            WHERE idEmployee = @idEmployee

            EXEC (@sql) 
            END
        ELSE
            RAISERROR ( 'Whoops, an error occurred.', 11, 1);

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

exec prcDeleteEmploBySotre @store =7,
@idEmployee=10