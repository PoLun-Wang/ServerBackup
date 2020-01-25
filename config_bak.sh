#!/bin/bash

CNF_DIR='/home/poweruser/MY_BAKUP/configs'
LOG_FILE='/home/poweruser/MY_BAKUP/backup_log'
CURR_TIME=`date +%Y-%m-%d\ %T`
CURR_DATE=`date +%Y-%m-%d`
DEL_DATE=`date --date='5 days ago' +%Y-%m-%d`

echo '==============================================' >> $LOG_FILE
echo "Begin of shell script. Time:${CURR_TIME}" >> $LOG_FILE

function BACKUP(){
  local BAK_TARGET=$1
  local BAK_FILE_NAME=$2
  local BAK_TYPE_ID=$3
  NEW_FILE="${BAK_FILE_NAME}_${CURR_DATE}.tar.gz"
  OLD_FILE="${BAK_FILE_NAME}_${DEL_DATE}.tar.gz"
  CURR_TIME=`date +%Y-%m-%d\ %T`

  echo '----------------------------------------------' >> $LOG_FILE
  echo "Backup CONFIG : Time:${CURR_TIME} -> ${BAK_TYPE_ID} ..." >> $LOG_FILE

  ## Try-catch
  {
    # Should cd to the folder that contains configs before you call BACKUP function.
    tar -czf $CNF_DIR/$NEW_FILE $BAK_TARGET
  } || {
    CURR_TIME=`date +%Y-%m-%d\ %T`
    echo "Result：Failure. Time：${CURR_TIME}, Error when executing tar. The backup file path should be: ${CNF_DIR}/${NEW_FILE}" >> $LOG_FILE
  }

  CURR_TIME=`date +%Y-%m-%d\ %T`

  if [ -f "$CNF_DIR/$OLD_FILE" ];
  then
     rm -f $CNF_DIR/$OLD_FILE
     echo "Delete old backup Success. File:${OLD_FILE}" >> $LOG_FILE
  fi

  CURR_TIME=`date +%Y-%m-%d\ %T`

  if [ -f "${CNF_DIR}/${NEW_FILE}" ];
  then
     echo "Result：Success. Time：${CURR_TIME} Path：${CNF_DIR}/${NEW_FILE}" >> $LOG_FILE
  else
     echo "Result：Failure. Time：${CURR_TIME} Path：${CNF_DIR}/${NEW_FILE}" >> $LOG_FILE
  fi

  return 1
}

## Call backup section.
## Backup Config
## Parameter1: Configuration folder name or file name.
## Parameter2: The backup file name.
## Parameter3: The display name for writing logs.
cd /etc/httpd/
BACKUP 'conf' 'httpd.conf' 'httpd-conf'

cd /etc/httpd/
BACKUP  'conf.d' 'httpd.conf.d' 'httpd-conf.d'

cd /etc/httpd/
BACKUP 'conf.modules.d' 'httpd.conf.modules.d' 'httpd-conf.modules.d'

cd /etc/opt/remi/php73/
BACKUP 'php.ini' 'php-config' 'php-config'

cd /etc/ssh/
BACKUP 'sshd_config' 'sshd-config' 'sshd-config'

cd /etc/
BACKUP 'my.cnf' 'mysql-config' 'mysql-config'

cd /var/spool/
BACKUP 'cron' 'cron-config' 'cron-config'


CURR_TIME=`date +%Y-%m-%d\ %T`
echo "End of shell script. Time:${CURR_TIME}" >> $LOG_FILE
