#i/bin/bash
wait_time=15s
user=SA
password=Pa5Sw0rd2021
server=mssql-server,1433

#weit for SQL to come up
echo import data will start in $wait_time...
sleep $wait_time
echo executing script...

#run the init script to create the DB and tables in /table
/opt/mssql-tools/bin/sqlcmd -S $server -U $user -P $password -i ./setup.sql