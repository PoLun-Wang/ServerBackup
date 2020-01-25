#!/bin/bash

DB_USER='root'
DB_PWD='Password of DB root'
DB_DIR='/home/poweruser/MY_BAKUP/db'
LOG_FILE='/home/poweruser/MY_BAKUP/backup_log'
CURR_TIME=`date +%Y-%m-%d\ %T`
CURR_DATE=`date +%Y-%m-%d`
DEL_DATE=`date --date='5 days ago' +%Y-%m-%d`

echo '==============================================' >> $LOG_FILE
echo "Begin of shell script. Time:${CURR_TIME}" >> $LOG_FILE

function BACKUP(){
  local DB_NAME=$1
  local WEBSITE_DOMAIN=$2
  NEW_FILE="${DB_NAME}_${CURR_DATE}.sql"
  OLD_FILE="${DB_NAME}_${DEL_DATE}.sql"
  CURR_TIME=`date +%Y-%m-%d\ %T`

  echo '----------------------------------------------' >> $LOG_FILE
  echo "Backup DB     : Time:${CURR_TIME} -> ${DB_NAME}(${WEBSITE_DOMAIN}) ..." >> $LOG_FILE

  ## Try-catch
  {
    mysqldump -u$DB_USER -p$DB_PWD $DB_NAME > $DB_DIR/$NEW_FILE
  } || {
    CURR_TIME=`date +%Y-%m-%d\ %T`
    echo "Result：Failure. Date：${CURR_TIME}, Error when executing mysqldump. Database：${DB_NAME}" >> $LOG_FILE
  }

  CURR_TIME=`date +%Y-%m-%d\ %T`

  ## Check old backup exists.
  if [ -f "${DB_DIR}/${OLD_FILE}" ];
  then
    rm -f $DB_DIR/$OLD_FILE
    echo "Delete old backup Success. File:${OLD_FILE}" >> $LOG_FILE
  fi

  CURR_TIME=`date +%Y-%m-%d\ %T`

  if [ -f "${DB_DIR}/${NEW_FILE}" ];
  then
     echo "Result：Success. Time：${CURR_TIME} Path：${DB_DIR}/${NEW_FILE}" >> $LOG_FILE
  else
     echo "Result：Failure. Time：${CURR_TIME} Path：${DB_DIR}/${NEW_FILE}" >> $LOG_FILE
  fi

  return 1
}

## Call backup section.
## Backup Database
## Parameter1: Database name.
## Parameter2: The domain name related to this database.
BACKUP 'wordpress_db' 'www.brilliantcode.net'
BACKUP 'wp_testing_db' 'testing.brilliantcode.net'


CURR_TIME=`date +%Y-%m-%d\ %T`
echo "End of shell script. Time:${CURR_TIME}" >> $LOG_FILE
