USE [master]
--Scotlansql 
EXEC master.dbo.sp_addlinkedserver @server = N'104.198.181.117', @srvproduct=N'SQL Server'
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'104.198.181.117',@useself=N'False',
			@locallogin=NULL,@rmtuser=N'sqlserver',@rmtpassword='Wisky@Rules2022!'
EXEC master.dbo.sp_serveroption @server=N'104.198.181.117', @optname=N'rpc', @optvalue=N'false'
EXEC master.dbo.sp_serveroption @server=N'104.198.181.117', @optname=N'rpc out', @optvalue=N'false'


--Irelandsql 
EXEC master.dbo.sp_addlinkedserver @server = N'34.135.158.74', @srvproduct=N'SQL Server'
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'34.135.158.74',@useself=N'False',
			@locallogin=NULL,@rmtuser=N'sqlserver',@rmtpassword='Wisky@Rules2022!'
EXEC master.dbo.sp_serveroption @server=N'34.135.158.74', @optname=N'rpc', @optvalue=N'false'
EXEC master.dbo.sp_serveroption @server=N'34.135.158.74', @optname=N'rpc out', @optvalue=N'false'


--Unitedstatessql 
EXEC master.dbo.sp_addlinkedserver @server = N'34.136.239.50', @srvproduct=N'SQL Server'
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'34.136.239.50',@useself=N'False',
			@locallogin=NULL,@rmtuser=N'sqlserver',@rmtpassword='Wisky@Rules2022!'
EXEC master.dbo.sp_serveroption @server=N'34.136.239.50', @optname=N'rpc', @optvalue=N'false'
EXEC master.dbo.sp_serveroption @server=N'34.136.239.50', @optname=N'rpc out', @optvalue=N'false'


--Universalsql 
EXEC master.dbo.sp_addlinkedserver @server = N'MYSQL-PRODUCT', @srvproduct=N'Product', @provider=N'MSDASQL', @datasrc=N'Universal-MySQL-product'
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'MYSQL-PRODUCT',@useself=N'False',@locallogin=NULL,@rmtuser=N'root',@rmtpassword='Wisky@Rules2022!'
EXEC master.dbo.sp_serveroption @server=N'MYSQL-PRODUCT', @optname=N'rpc', @optvalue=N'true'
EXEC master.dbo.sp_serveroption @server=N'MYSQL-PRODUCT', @optname=N'rpc out', @optvalue=N'true'

EXEC master.dbo.sp_addlinkedserver @server = N'MYSQL-EMPLEADO', @srvproduct=N'Empleado', @provider=N'MSDASQL', @datasrc=N'Universal-MySQL-Empleado'
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'MYSQL-EMPLEADO',@useself=N'False',@locallogin=NULL,@rmtuser=N'root',@rmtpassword='Wisky@Rules2022!'
EXEC master.dbo.sp_serveroption @server=N'MYSQL-EMPLEADO', @optname=N'rpc', @optvalue=N'true'
EXEC master.dbo.sp_serveroption @server=N'MYSQL-EMPLEADO', @optname=N'rpc out', @optvalue=N'true'

select * from [34.135.158.74].[ie_store1].[dbo].[employee]
select * from openquery([34.135.158.74], 'select * from [ie_store1].[dbo].[store]') --para columnas con ubicacion
EXEC ('SELECT * FROM employee.department') AT [MYSQL-EMPLEADO] 
EXEC ('SELECT * FROM product.product') AT [MYSQL-PRODUCT] 
