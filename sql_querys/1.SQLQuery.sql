--CREATE DATABASE db_almaximo;
--GO
--PRINT 'Se Creo la base de datos'

USE db_almaximo;
GO

DROP TABLE Producto

PRINT 'Cambio a db_almaximo'


-- Create a new table called 'Producto' in schema 'dbo'
-- Drop the table if it already exists
IF OBJECT_ID('dbo.Proveedor', 'U') IS NOT NULL
	DROP TABLE dbo.Proveedor
GO

CREATE TABLE Proveedor (
	IdProveedor INT IDENTITY(1,1) PRIMARY KEY, -- primary key column
	Nombre NVARCHAR(80) NOT NULL,
	Descripcion NVARCHAR(100) NOT NULL
); 
GO
CREATE UNIQUE INDEX nonclustered_Nombre ON Proveedor (Nombre);



-- Create a new table called 'TipoDeProducto' in schema 'dbo'
-- Drop the table if it already exists
IF OBJECT_ID('dbo.TipoDeProducto', 'U') IS NOT NULL
	DROP TABLE dbo.TipoDeProducto
GO

CREATE TABLE TipoDeProducto (
	Nombre [NVARCHAR](80) PRIMARY KEY,
	Descripcion [NVARCHAR](80) NOT NULL
); 
GO
-- CREATE UNIQUE INDEX nonclustered_Nombre_tdp ON TipoDeProducto (Nombre);


-- Create a new table called 'Producto' in schema 'dbo'
-- Drop the table if it already exists
IF OBJECT_ID('dbo.Producto', 'U') IS NOT NULL
DROP TABLE dbo.Producto
GO

CREATE TABLE Producto (
	Clave [NVARCHAR](50) PRIMARY KEY,  -- primary key column
	Nombre [NVARCHAR](80) NOT NULL,
	Tipo_producto [NVARCHAR](80) FOREIGN KEY REFERENCES TipoDeProducto(Nombre),
	Costo NUMERIC(18,2) NOT NULL,
	Estatus [NVARCHAR](50) NOT NULL,
	Proveedor [NVARCHAR](80) FOREIGN KEY REFERENCES Proveedor(Nombre)
);
GO
CREATE NONCLUSTERED INDEX idx_Nombre ON dbo.Producto (Nombre ASC);

PRINT 'Tablas generadas'




-- Insert rows into table 'Proveedor'
INSERT INTO Proveedor 
VALUES 
	('FEMSA', 'Productora de bebidas'),
	('Abarrotera Almaximo','Diversos productos de abarrotes'),
	('PepsiCo','Productora de bebidas y aperitivos')
GO

INSERT INTO TipoDeProducto
VALUES
	('Refresco', 'Bebicas azucaradas'),
	('Limpieza', 'Producto quimico para usado para la limpieza')
GO

-- Insert rows into table 'Producto'
INSERT INTO Producto
VALUES
	('coca355ml', 'Coca-Cola 355 ML', 'Refresco', 9.50, 'Activo', 'FEMSA'),
	('cocacola355ml', 'Coca-Cola 355 ML', 'Refresco', 9.60, 'No activo', 'Abarrotera Almaximo')
GO

PRINT 'Valores insertados de manera correcta'

SELECT * FROM [db_almaximo].[dbo].[Proveedor]
SELECT * FROM [db_almaximo].[dbo].[TipoDeProducto]
SELECT * FROM [db_almaximo].[dbo].[Producto]