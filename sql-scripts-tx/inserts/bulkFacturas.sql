bulk insert LubricentroTX.dbo.facturas
from 'D:\Backup\Fidelitas\VIQ Data Warehouse\Proyecto Grupal\sql-scripts-tx\inserts\facturaV3inserts.csv'
with(FIELDTERMINATOR = ',',
     ROWTERMINATOR = '\n',
	 BATCHSIZE = 1000000,
	 TABLOCK);