#!/bin/bash

# MySQLのクエリーをモニタリングする

mysql -uroot -e "set global general_log=ON"
trap 'mysql -uroot -e "set global general_log=OFF";exit 1'  1 2 3 15
LOG_FILE=`mysql -uroot -N -e "show variables like 'general_log_file'" | cut -f2`
tail -f $LOG_FILE
