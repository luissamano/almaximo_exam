USE db_almaximo;
GO


IF EXISTS (
SELECT *
	FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
	AND SPECIFIC_NAME = N'spObtenerProveedores'
)
DROP PROCEDURE dbo.spObtenerProveedores
GO
-- Create the stored procedure in the specified schema
CREATE PROCEDURE dbo.spObtenerProveedores
AS
	-- body of the stored procedure
	SELECT [Nombre], [Descripcion]
	FROM dbo.Proveedor 
GO
-- example to execute the stored procedure we just created
EXECUTE dbo.spObtenerProveedores
GO


IF EXISTS (
SELECT *
	FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
	AND SPECIFIC_NAME = N'spObtenerProductos'
)
DROP PROCEDURE dbo.spObtenerProductos
GO
-- Create the stored procedure in the specified schema
CREATE PROCEDURE dbo.spObtenerProductos
AS
	-- body of the stored procedure
	SELECT [Clave], [Nombre], [Tipo_producto], 
		   [Costo] [Estatus], [Proveedor]
		FROM Producto
GO
-- example to execute the stored procedure we just created
EXECUTE dbo.spObtenerProductos
GO




-- Create a new stored procedure called 'spInsertarProducto' in schema 'SchemaName'
-- Drop the stored procedure if it already exists
IF EXISTS (
SELECT *
	FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
	AND SPECIFIC_NAME = N'spInsertarProducto'
)
DROP PROCEDURE SchemaName.spInsertarProducto
GO
-- Create the stored procedure in the specified schema
CREATE PROCEDURE dbo.spInsertarProducto
	@Clave NVARCHAR(50) = NULL, 
	@Nombre NVARCHAR(80) = NULL, 
	@Tipo NVARCHAR(80) = NULL,
	@Costo NUMERIC(18,2) = NULL,
	@Estatus BIT = NULL,
	@Proveedor NVARCHAR(80) = NULL
AS
	-- body of the stored procedure
	DECLARE @Error int
	-- Insert rows into table 'Producto'
	BEGIN TRAN
	
		INSERT INTO dbo.Producto 
		VALUES (@Clave, @Nombre, @Tipo, @Costo, @Estatus, @Proveedor)
		
		SET @Error=@@ERROR

		IF @Error=0 
			BEGIN
				PRINT 'Transacción realizada de manera correcta.' + @Clave + 'se agrego co exito'
				COMMIT TRAN
			END
			 
		ELSE IF @@Error<>0 
			BEGIN
				PRINT 'Ha ecorrido un error con ' + @Clave + ', se aborto la transaccion'
				ROLLBACK TRAN
			END
GO


CREATE PROCEDURE [dbo].[spObtenerTipoDeProductos]
AS
	SELECT [Nombre], [Descripcion]
	FROM [TipoDeProducto]

GO
