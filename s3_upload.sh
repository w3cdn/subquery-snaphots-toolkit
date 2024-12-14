#!/bin/bash
source .env

aws s3 sync ${BACKUP_PATH}  s3://${BACKUP_S3_BUCKET_NAME}/${BACKUP_S3_FOLDER}
echo -e "s3 sync done"
