bulk insert LubricentroTX.dbo.vehiculos
from 'D:\Backup\Fidelitas\VIQ Data Warehouse\Proyecto Grupal\sql-scripts-tx\inserts\vehiculos.csv'
with(FIELDTERMINATOR = ',',
     ROWTERMINATOR = '\n',
	 BATCHSIZE = 1000000,
	 TABLOCK);