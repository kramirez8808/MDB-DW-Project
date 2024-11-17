bulk insert LubricentroTX.dbo.trabajos
from 'D:\Backup\Fidelitas\VIQ Data Warehouse\Proyecto Grupal\sql-scripts-tx\inserts\trabajos.csv'
with(FIELDTERMINATOR = ',',
     ROWTERMINATOR = '\n',
	 BATCHSIZE = 1000000,
	 TABLOCK);