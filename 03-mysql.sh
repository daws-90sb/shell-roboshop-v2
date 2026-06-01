#!/bin/bash

source ./common.sh

root_check


dnf install mysql-server -y &>> $LOGS_FILE
VALIDATE $? "Installing MYSQL server"

systemctl enable mysqld   &>> $LOGS_FILE
systemctl start mysqld    &>> $LOGS_FILE
VALIDATE $? "Enable and Start MYSQL server"

mysql_secure_installation --set-root-pass RoboShop@1
VALIDATE $? "setting up root password"
 

 print_total_time