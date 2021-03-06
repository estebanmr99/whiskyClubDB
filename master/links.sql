-- Script to create the linked servers in the master database (local)

USE [masterdb]
-- Create the Scotlansql instante
EXEC master.dbo.sp_addlinkedserver @server = N'104.198.181.117', @srvproduct=N'SQL Server';
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'104.198.181.117',@useself=N'False',
			@locallogin=NULL,@rmtuser=N'sqlserver',@rmtpassword='Wisky@Rules2022!';
EXEC master.dbo.sp_serveroption @server=N'104.198.181.117', @optname=N'rpc', @optvalue=N'true';
EXEC master.dbo.sp_serveroption @server=N'104.198.181.117', @optname=N'rpc out', @optvalue=N'true';
EXEC master.dbo.sp_serveroption @server=N'104.198.181.117', @optname = 'remote proc transaction promotion', @optvalue = 'false' ;
EXEC master.dbo.sp_serveroption @server=N'104.198.181.117', @optname=N'name', @optvalue=N'SCOTLANDSQL';

-- Create the Irelandsql instance
EXEC master.dbo.sp_addlinkedserver @server = N'34.135.158.74', @srvproduct=N'SQL Server';
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'34.135.158.74',@useself=N'False',
			@locallogin=NULL,@rmtuser=N'sqlserver',@rmtpassword='Wisky@Rules2022!';
EXEC master.dbo.sp_serveroption @server=N'34.135.158.74', @optname=N'rpc', @optvalue=N'true';
EXEC master.dbo.sp_serveroption @server=N'34.135.158.74', @optname=N'rpc out', @optvalue=N'true';
EXEC master.dbo.sp_serveroption @server=N'34.135.158.74', @optname = 'remote proc transaction promotion', @optvalue = 'false' ;
EXEC master.dbo.sp_serveroption @server=N'34.135.158.74', @optname=N'name', @optvalue=N'IRELANDSQL';

-- Create the Unitedstatessql intance
EXEC master.dbo.sp_addlinkedserver @server = N'34.136.239.50', @srvproduct=N'SQL Server';
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'34.136.239.50',@useself=N'False',
			@locallogin=NULL,@rmtuser=N'sqlserver',@rmtpassword='Wisky@Rules2022!';
EXEC master.dbo.sp_serveroption @server=N'34.136.239.50', @optname=N'rpc', @optvalue=N'true';
EXEC master.dbo.sp_serveroption @server=N'34.136.239.50', @optname=N'rpc out', @optvalue=N'true';
EXEC master.dbo.sp_serveroption @server=N'34.136.239.50', @optname = 'remote proc transaction promotion', @optvalue = 'false' ;
EXEC master.dbo.sp_serveroption @server=N'34.136.239.50', @optname=N'name', @optvalue=N'UNITEDSTATESSQL';

-- Create the Universalsql instance
EXEC master.dbo.sp_addlinkedserver @server = N'UNIVERSAL-MYSQL', @srvproduct=N'Product', @provider=N'MSDASQL', @datasrc=N'Universal-MySQL';
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'UNIVERSAL-MYSQL',@useself=N'False',@locallogin=NULL,@rmtuser=N'root',@rmtpassword='Wisky@Rules2022!';
EXEC master.dbo.sp_serveroption @server=N'UNIVERSAL-MYSQL', @optname=N'rpc', @optvalue=N'true';
EXEC master.dbo.sp_serveroption @server=N'UNIVERSAL-MYSQL', @optname=N'rpc out', @optvalue=N'true';