# Subquery Snapshots Toolkit


## 1. Prepare
```
cd /sr/src
git clone https://github.com/w3cdn/subquery-snaphots-toolkit.git
cd subquery-snaphots-toolkit
cp .env.default .env
```

## 2. Configuration (.env)

- `COORDINATOR_IP` (`Optional`). if variable not set, script will try to detect from system
- `POSTGRES_HOST`  (`Optional`). if variable not set, script will try to detect from system
- `POSTGRES_PORT` (`Optional`). if variable not set, script will try to detect from system
- `POSTGRES_DB_NAME` (`Required`) name of database (default is "postgres")
- `POSTGRES_DB_USERNAME` (`Required`) username for postgres (default is "postgres")
- `POSTGRES_DB_PASSWORD` (`Required`) password for postgres
- `BACKUP_PATH_TEMP` (`Required`) Temp folder where system try to create snapshot (Danger. Folder must be different of BACKUP_PATH). Sample /mnt/temp
- `BACKUP_PATH` (`Required`) Path where dump sill be saved. Sample: /mnt/snapshots
- `BACKUP_S3_BUCKET_NAME` (`Optional`) If S3 used (Bucket name) Sample: mysnap
- `BACKUP_S3_FOLDER` (`Optional`) If S3 used (Full path in s3 bucket) Sample: SQ_SNAPSHOTS

## 3. Setup crontab
every 5 days at 3AM.
```
echo "0 3 */5 * * /usr/src/subquery-snaphots-toolkit/standart_projects.sh > /usr/src/subquery-snaphots-toolkit/execution.log && /usr/src/subquery-snaphots-toolkit/s3_upload.sh > /usr/src/subquery-snaphots-toolkit/s3_sync.log" > /etc/cron.d/subquery_db_backup 
```




![image](https://github.com/user-attachments/assets/5f7a0d55-8356-4027-9ac4-d03f08340d6d)
