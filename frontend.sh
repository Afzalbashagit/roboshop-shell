script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
func_print "Install nginx"
yum install nginx -y &>>log_file
func_print"copy content"
cp frontend.confo /etc/nginx/default.d/roboshop.conf &>>log_file
func_print "remove existed file in /usr/share/nginx/html"
rm -rf /usr/share/nginx/html/*
func_print "download content"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>log_file
func_print "unzip content"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>>log_file
func_print "start system services"
systemctl enable nginx &>>log_file
systemctl restart nginx &>>log_file