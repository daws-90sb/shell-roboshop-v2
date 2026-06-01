#!/bin/bash


app_name=catalogue
source ./common.sh

check_root

app_setup
nodejs_setup


cp $SCRIPT_DIR/mongo.repo /etc/yum.repos.d/mongo.repo
VALIDATE $? "Added Mongo Repo"

dnf install mongodb-mongosh -y  &>> $LOGS_FILE
VALIDATE $? "Installed Mongodb Client"

 INDEX=$(mongosh --host mongodb.daws-90sb.online --eval 'db.getMongo().getDBNames().indexOf("catalogue")')

 if [ $INDEX -lt 0 ]; then
    mongosh --host mongodb.daws-90sb.online </app/db/master-data.js &>> $LOGS_FILE
    VALIDATE $? "Load Products"
else 
    echo -e " products already loaded....$Y skipping $N "
fi

print_total_time

