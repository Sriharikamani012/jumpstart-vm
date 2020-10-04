#!/bin/bash

# Title: Run SpringBoot Service
# Description: 
#   This script will run this app, https://github.com/Azure-Samples/mysql-spring-boot-todo,
#   as a sytemd service
# Prerequisites: This script assumes:
#   1. There exists a jar or war java package at /opt/todo-app/
#   2. ./todo.service is written to /usr/lib/systemd/system/
#       - the user running this service is ${APP_USER}
# Requires:
#       1. yum-config-manager --add-repo http://mirror.centos.org/centos-7/7/os/x86_64/"
#       2. JAVA_HOME='/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.242.b08-0.el7_7.x86_64/'
#       3. firewall-cmd --list-ports
#           8080/tcp 3306/tcp
#       3. The script is running as root

while getopts u:r:n:k:w:s: option
do
    case "${option}"
    in
    u) APP_USER=${OPTARG};;
    r) SQL_URL=${OPTARG};;
    n) SQL_USER=${OPTARG};;
    k) SQL_PASSWORD=${OPTARG};;
    esac
done

if [ -z "$APP_USER" ]; then
    APP_USER=app_admin
fi
if [ -z "$SQL_URL" ]; then
    SQL_URL=jdbc:mysql://mysql.svc.local/tododb
fi

# create user who will run the service
adduser ${APP_USER}

# folder where the package is
cd /opt/todo-app/

# remove and replace application.properties file
rm -f application.properties


# please note: applications must retrieve secrets from key vault
# TODO: implement
# https://docs.microsoft.com/en-us/azure/java/spring-framework/configure-spring-boot-starter-java-app-with-azure-key-vault
cat > application.properties <<EOF
spring.datasource.url=${SQL_URL}
spring.datasource.username=${SQL_USER}
spring.datasource.password=${SQL_PASSWORD}
spring.datasource.driver-class-name=com.mysql.jdbc.Driver
spring.jpa.hibernate.ddl-auto=update
EOF


cd /usr/lib/systemd/system/


systemctl daemon-reload
systemctl enable todo
systemctl start todo.service
cat "$(systemctl status todo.service)"
