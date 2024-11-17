/*INSERTS para la tabla Facturas*/

BULK INSERT factura
FROM 'C:\ruta\al\archivo\facturas.csv'
WITH
(
    FIELDTERMINATOR = ',',  
    ROWTERMINATOR = '\n',   
    FIRSTROW = 2           
);