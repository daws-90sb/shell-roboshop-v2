#!/bin/bash


app_name=shipping
source ./common.sh
check_root

app_setup
java_Setup
systemd_setup


cp $SCRIPT_DIR/shipping.service /etc/systemd/system/shipping.service
VALIDATE $? "Created systemctl service"

dnf install mysql -y &>> $LOGS_FILE
VALIDATE $? "Installing mysql client"


mysql -h $MYSQL_HOST -u root  -pRoboShop@1 -e "use cities" &>> $LOGS_FILE

if [ $? -ne 0 ]; then
    
   mysql -h $MYSQL_HOST -uroot -pRoboShop@1 < /app/db/schema.sql
   mysql -h $MYSQL_HOST -uroot -pRoboShop@1 < /app/db/app-user.sql 
   mysql -h $MYSQL_HOST -uroot -pRoboShop@1 < /app/db/master-data.sql
   VAIDATE $? "Data Loaded"
else 
   echo -e "data already loaded....$Y SKIPPING $N"
fi
   
 app_restart
 print_total_time  