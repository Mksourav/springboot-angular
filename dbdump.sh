echo *** Backup Started on `date` ***

timestamp=`date +%Y%m%d_%H%M`

echo Creating backup file mydb.sql
mysqldump -u demo --password="demo" --routines mydb > /home/lakj-backups/mydb-$timestamp.sql
echo Finished creating backup file.
