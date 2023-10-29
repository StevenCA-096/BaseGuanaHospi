--Creacion de la base de datos
USE master
GO

CREATE DATABASE Guana_HospiDB ON
(
	NAME = 'Guana_HospiDB',
    FILENAME = 'C:\SQLSERVER\SqlDATA\Guana_HospiDB.mdf',
    SIZE = 10Mb,
    MAXSIZE = 500Mb,
    FILEGROWTH = 5Mb
)
LOG ON
(
	NAME = 'GuanaHospiDB_log',
    FILENAME = 'C:\SQLSERVER\SqlLOG\Guana_HospiDB.ldf',
    SIZE = 5 MB,
    MAXSIZE = 30MB,
    FILEGROWTH = 5 MB
)
GO