bulk insert LubricentroTX.dbo.clientes 
from 'D:\Backup\Fidelitas\VIQ Data Warehouse\Proyecto Grupal\sql-scripts-tx\inserts\clientes.csv'
with(FIELDTERMINATOR = ',',
     ROWTERMINATOR = '\n',
	 BATCHSIZE = 1000000,
	 TABLOCK);