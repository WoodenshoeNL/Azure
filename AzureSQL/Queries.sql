

--get list of databases
select [name] as database_name, database_id, create_date
from sys.databases
order by name
go


--get current database
SELECT DB_NAME() AS [Current Database];
GO


--Get Tables
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
go

