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



-----

## Single snapshot restore

```
zstdcat %YOUR_DUMP_NAME%.zstd  | PGPASSWORD="%DATABASE_PASSWORD%" pg_restore --host=%POSTGRES_HOST% --port=%POSTGRES_PORT%  -U postgres -d postgres
```
Replace next fields with your values and run command:

 - `%YOUR_DUMP_NAME%` file path where located zstd snapshot.
 - `%DATABASE_PASSWORD%` Password for Postgres
 - `%POSTGRES_HOST%` Host with Postgres
 - `%POSTGRES_PORT%` Port with Postgres

## Restore all from snapshots
`TBA`



## Latest snapshot sizes.
- `2024-12-14 23:12:09 11558295822 QmP1BMJoyJ5iFq6XLSfTJ3D23iWuTG1tnsEffJpNieQnwN.zstd`
- `2024-12-14 23:12:47 12108873643 QmP2KRbGx4vLaL8HqugVXrNPMyziFL6aM9NAd4NbFqsPA9.zstd`
- `2024-12-14 23:01:58 1951947572 QmPQQA28fxR1hePk25MHNS1vEYRs4Gbz3PXry8G4dfC76N.zstd`
- `2024-12-14 23:01:19 1385038945 QmPYABw93FKwx8zhzzCw6J69Y664RzFn8mUmThUsP1YWUR.zstd`
- `2024-12-14 23:13:31 12863328928 QmPffAuzcstfwY6PY64bsMqDZpQV2bt5xj3zxJVubw81y8.zstd`
- `2024-12-14 23:02:59 1481437853 QmPiTswpMTeipwnmJkAcwkcg5Se8XfrucGYVKbwuAxQgJ6.zstd`
- `2024-12-07 14:43:19 618152453098 QmSKrk3BpzjWzKfS8sZRS5vyjmtXvkJnK8nHUVBhiCmz41.zstd`
- `2024-12-09 14:37:47  762160886 QmScHyGv2fyJUB2prBKCKx3i8kGrQ3wU7USq8yBJ9DWiG9.zstd`
- `2024-12-14 23:02:17  282152633 QmTTXz7yyxTSDHbSt8fLDbhzwQ3UwWC3jwvwnjZXvDQKuW.zstd`
- `2024-12-14 23:11:07 8268969585 QmUHAsweQYXYrY5Swbt1eHkUwnE5iLc7w9Fh62JY6guXEK.zstd`
- `2024-12-07 13:27:38  466307751 QmULvX7eUVbyBzPqFJs1A8udTRMtkUZWjYK5BZD5hMztMt.zstd`
- `2024-12-14 23:05:01 1897226446 QmUj8yYCE1YU5UNdtm4q4di4GBDEAmL8vprSRWVGrYeEFm.zstd`
- `2024-12-14 23:05:47  703317265 QmVnojxfmZJzWihvmSuixZsAxPrGqVeNB4EdTtmL3UGiFY.zstd`
- `2024-12-14 23:15:38 9367337433 QmWD7SwH7aUyVvyydZRzS7XtM8bSU6izkvWgzYgrtw3V82.zstd`
- `2024-12-14 23:12:05  939461212 QmWeQZWNrmHUvac2yz9ePpQqVwJM9QFpK9ULwt7ype3CmP.zstd`
- `2024-12-14 23:18:07 5927587484 QmWhwLQA4P6iZv6bmQxUqG5zumNK8KDBwcq8wxN4G213dq.zstd`
- `2024-12-14 23:32:45 21708893646 QmWmm1teaAzm699PBQQ6MuEEmbNJubXHyTpWqCWKurqSNs.zstd`
- `2024-12-14 23:13:13  374222134 QmWtjALhGB9QEkf2GqVJued71xpLpP4jVUVh4vQDdrgXhv.zstd`
- `2024-12-14 23:31:52 19220740310 QmWv9Ja5AQ9cPpXb6U7sGCvkhK6XbZ7xQntTBqidsSf5SF.zstd`
- `2024-12-14 23:15:26 1927515335 QmZpj5wYpUbGqJDg6KWgbkK5bmeuCqYX6kwk317jdJ9DZ4.zstd`
- `2024-12-14 23:15:54  456794960 QmaUJQgjMw8ufsFW8nPnbgP3iGRknhKHB3z6S1WyHahsZ8.zstd`
- `2024-12-14 23:27:54 12189374110 QmaYR3CJyhywww1Cf5TMJP15DAcD3YE9ZSNmdLbM7KiQHi.zstd`
- `2024-12-14 23:22:21 6388700054 QmapQ6cNKPtZE1jkeUp5V6xy7sPSiJiZpoqZcRRtyc4Stq.zstd`
- `2024-12-09 15:21:03 12133721734 QmbQmLgzmoFEhAsMZDB4pGZYznXHZSHENMki1ymbDowehY.zstd`
- `2024-12-09 15:15:59  762483216 QmcoJLxSeBnGwtmtNmWFCRusXVTGjYWCK1LoujthZ2NyGP.zstd`
- `2024-12-14 23:19:56 1794037836 QmcvcN4gZkiB2JkmK6BdHh7Wzy8Gfp8R7ZHSgGajbGv6Wy.zstd`
- `2024-12-14 23:20:46  779274013 Qmd3hcVGc61HWxFF9JYVYn2LuxMXZxZqGq58XLxEq6TGpy.zstd`
- `2024-12-14 23:23:25 2678713927 QmdbhaQ6mFJNHVk5WbNyFsevfJysiXyueMRHqWN7FTXMtN.zstd`
- `2024-12-14 23:22:46  441124093 QmdbxBVjARyGtCgqvyeXN9JAmsskFnVD7ngzrzrBRRknTS.zstd`
- `2024-12-14 23:24:37 1837281163 QmdrqzazvSmrr6rgfxJEssJH9jqhYCZARm92UxNXMv5f86.zstd`
- `2024-12-14 23:24:17  836657656 QmdzL852vGNgmdmk4UdvpPWeVsTtYJiMsjJd6ZxnSbQsfP.zstd`
- `2024-12-14 23:25:59 1667376625 Qme1iQvwLoeh1ZLZVL4zDGZBK1hnMG3xZz1oaLBRvZxT7X.zstd`
- `2024-12-14 23:25:55 1273239503 QmeBTNuhahUo2EhTRxV3qVAVf5bC8zVQRrrHd3SUDXgtbF.zstd`
- `2024-12-14 23:27:51 1883350937 QmeBhTYHBcqJTJgfN7HDeSM4nHFR1c7fryZfRxGmRpwNHU.zstd`
- `2024-12-14 23:27:26 1403099157 QmeKUwv1ThJerboGV8t6zBYGCpJXkht1QMHY6QMU9xmWWm.zstd`
- `2024-12-14 23:33:01 7170795989 QmeMyqVHN7YxCHT6ftpaJ26APMCAPi4VfV5T1Zj8o8Cy3c.zstd`
- `2024-12-14 23:28:43  802515055 QmeYyergeJvU26s9g46yXBEA8216vBmzpYZYjLQeW9MSb1.zstd`
- `2024-12-14 23:34:42 14637665286 QmfVyLpFjkvT7DKU8hdqBpxKR677ak6bo7jeU68XsCPHLZ.zstd`
- `2024-12-08 13:12:08 30758864316 QmUGBdhQKnzE8q6x6MPqP6LNZGa8gzXf5gkdmhzWjdFGfL.zstd`
- `2024-12-07 20:30:33 140165221461 QmYNRtrcD2QKftkff2UpjV3fr3ubPZuYahTNDAct4Ad2NW.zstd`
- `2024-12-10 20:58:16 1264123904 QmaYR3CJyhywww1Cf5TMJP15DAcD3YE9ZSNmdLbM7KiQHi.zstd`
- `2024-12-07 22:24:16 29880870862 Qmbe5g5vbEJYYAfpjcwNDzuhjeyaEQPQbxKyKx6PveYnR8.zstd`
