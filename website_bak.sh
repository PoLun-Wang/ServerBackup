#!/bin/bash

SITE_DIR='/home/poweruser/MY_BAKUP/websites'
LOG_FILE='/home/poweruser/MY_BAKUP/backup_log'
CURR_TIME=`date +%Y-%m-%d\ %T`
CURR_DATE=`date +%Y-%m-%d`
DEL_DATE=`date --date='5 days ago' +%Y-%m-%d`

echo '==============================================' >> $LOG_FILE
echo "Begin of shell script. Time:${CURR_TIME}" >> $LOG_FILE

function BACKUP(){
  local WEBSITE_FOLDER_NAME=$1
  local WEBSITE_DOMAIN=$2
  NEW_FILE="${WEBSITE_FOLDER_NAME}_${CURR_DATE}.tar.gz"
  OLD_FILE="${WEBSITE_FOLDER_NAME}_${DEL_DATE}.tar.gz"
  CURR_TIME=`date +%Y-%m-%d\ %T`

  echo '----------------------------------------------' >> $LOG_FILE
  echo "Backup WEBSITE: Time:${CURR_TIME} -> ${WEBSITE_FOLDER_NAME}(${WEBSITE_DOMAIN}) ..." >> $LOG_FILE

  ## Try catch
  {
    tar -czf $SITE_DIR/$NEW_FILE $WEBSITE_FOLDER_NAME
  } || {
    CURR_TIME=`date +%Y-%m-%d\ %T`
    echo "Result：Failure. Time:${CURR_TIME}, Error when executing tar. The backup file path should be: ${SITE_DIR}/${NEW_FILE}" >> $LOG_FILE
  }

  CURR_TIME=`date +%Y-%m-%d\ %T`

  ## Check old backup exists.
  if [ -f "${SITE_DIR}/${OLD_FILE}" ];
  then
    rm -f $SITE_DIR/$OLD_FILE
    echo "Delete old backup Success. File:${OLD_FILE}" >> $LOG_FILE
  fi

  CURR_TIME=`date +%Y-%m-%d\ %T`

  if [ -f "${SITE_DIR}/${NEW_FILE}" ];
  then
     echo "Result：Success. Time：${CURR_TIME} Path：${SITE_DIR}/${NEW_FILE}" >> $LOG_FILE
  else
     echo "Result：Failure. Time：${CURR_TIME} Path：${SITE_DIR}/${NEW_FILE}" >> $LOG_FILE
  fi

  return 1
}


## Call backup section.
## Backup Websites
## Parameter1: Website folder name.
## Parameter2: Website domain name for displaying in log file.

## Switch in your website's folder.
cd /var/www
BACKUP 'myWordPress' 'www.brilliantcode.net'
BACKUP 'myTestingWordPress' 'testing.brilliantcode.net'
BACKUP 'phpMyAdmin' 'phpMyAdmin.brilliantcode.net'


CURR_TIME=`date +%Y-%m-%d\ %T`
echo "End of shell script. Time:${CURR_TIME}" >> $LOG_FILE
