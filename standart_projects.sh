#!/bin/bash

declare -a projects
source .env


if [ -z "${POSTGRES_HOST}" ]; then
  POSTGRES_HOST=`docker inspect   -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' indexer_db`
fi

if [ -z "${POSTGRES_HOST}" ]; then
      echo -e "\e[31m Cnnot detect POSTGRES SERVER IP ADDRESS \e[39m"
      exit;
fi


if [ -z "${COORDINATOR_IP}" ]; then
  POSTGRES_HOST=`docker inspect   -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' indexer_coordinator`
fi

if [ -z "${COORDINATOR_IP}" ]; then
      echo -e "\e[31m Cannot detect COORDINATOR IP ADDRESS \e[39m"
      exit;
fi

if [ -z "${BACKUP_PATH_TEMP}" ]; then
      echo -e "\e[31m BACKUP_PATH_TEMP is not set \e[39m"
      exit;
fi

if [ -z "${BACKUP_PATH}" ]; then
      echo -e "\e[31m BACKUP_PATH is not set \e[39m"
      exit;
fi


if [ -z "${POSTGRES_DB_NAME}" ]; then
      echo -e "\e[31m POSTGRES_DB_NAME is not set \e[39m"
      exit;
fi

if [ -z "${POSTGRES_DB_USERNAME}" ]; then
      echo -e "\e[31m POSTGRES_DB_USERNAME is not set \e[39m"
      exit;
fi

if [ -z "${POSTGRES_DB_PASSWORD}" ]; then
      echo -e "\e[31m POSTGRES_DB_PASSWORD is not set \e[39m"
      exit;
fi

query_container()
{
  cat <<EOF
{"variables":{},"query":"{\n  getProjects: getProjectsSimple {\n    id\n    status\n    chainType\n    projectType\n    rateLimit\n    hostType\n    details {\n      name\n      __typename\n    }\n    __typename\n  }\n}"}
EOF
}


data=`curl -s http://${COORDINATOR_IP}:8000/graphql  -X POST -H 'content-type: application/json'  --data-raw "$(query_container)"`

do_backup () {

  if [ -f "$BACKUP_PATH_TEMP/$1.zstd" ]; then
    rm "$BACKUP_PATH_TEMP/$1.zstd"
  fi
  PROJECT_CID=$1


  PROJECT_CID_PREFIX=$(echo $PROJECT_CID| tr "[:upper:]" "[:lower:]" | cut -c1-15)

  echo -e "\e[33m              Creating dump of schema $PROJECT_CID_PREFIX \e[39m"


  PGPASSWORD=${POSTGRES_DB_PASSWORD}  pg_dump --host=${POSTGRES_HOST:-127.0.0.1} --port=${POSTGRES_PORT:-5432}  -U ${POSTGRES_DB_USERNAME:-postgres} --dbname=${POSTGRES_DB_NAME:-postgres} --schema=schema_${PROJECT_CID_PREFIX} \
--format=custom --compress=zstd:9 > ${BACKUP_PATH_TEMP}/${PROJECT_CID}.zstd

  if [ $? = 0 ]; then

      if [ -f "$BACKUP_PATH_TEMP/$PROJECT_CID.zstd" ]; then
        mv $BACKUP_PATH_TEMP/$PROJECT_CID.zstd $BACKUP_PATH/$PROJECT_CID.zstd
        echo -e "\e[32m              + Complete  backup project $PROJECT_CID at  $(date -u)\e[39m"
      else
        echo -e "\e[31m              - Failed  backup project $PROJECT_CID at  $(date -u)\e[39m"
      fi
  else
      echo -e "\e[31m              - Failed  backup project $PROJECT_CID at  $(date -u)\e[39m"
  fi
}


readarray -t conversations < <(echo $data | jq -r -c ".data.getProjects |  map(select(.hostType == \"system-managed\")) | map(.id) | .[]")

stty size | perl -ale 'print "-"x$F[1]'

echo "   _____       _                                                             _           _       ";
echo "  / ____|     | |                                                           | |         | |      ";
echo " | (___  _   _| |__   __ _ _   _  ___ _ __ _   _   ___ _ __   __ _ _ __  ___| |__   ___ | |_ ___ ";
echo "  \___ \| | | | '_ \ / _\` | | | |/ _ \ '__| | | | / __| '_ \ / _\` | '_ \/ __| '_ \ / _ \| __/ __|";
echo "  ____) | |_| | |_) | (_| | |_| |  __/ |  | |_| | \__ \ | | | (_| | |_) \__ \ | | | (_) | |_\__ \\";
echo ' |_____/ \__,_|_.__/ \__, |\__,_|\___|_|   \__, | |___/_| |_|\__,_| .__/|___/_| |_|\___/ \__|___/';
echo '                        | |                 __/ |                 | |                            ';
echo '                        |_|                |___/                  |_|                            ';



echo -e "\e[33m"
echo -e "   Powered by: https://subquery.dev"
echo "   Total project prepared for backup: ${#conversations[@]}"
echo -e "   Backup process started at $(date -u)\e[39m"
stty size | perl -ale 'print "-"x$F[1]'

typeset -i i
let i=1
for conversation in "${conversations[@]}"; do
   echo -e "    \e[32m($i/${#conversations[@]})\e[39m  \e[34mStarting backup project $1 at  $(date -u)\e[39m"
   do_backup "$conversation"
   stty size | perl -ale 'print "-"x$F[1]'
   let i++
done
