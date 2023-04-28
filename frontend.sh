script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
echo -e "\e[36m>>>>>>>Install nginx>>>>>>>>>>>>>>>>>\e[0m"
yum install nginx -y
echo -e "\e[36m>>>>>>>copy content>>>>>>>>>>>>>>>>>\e[0m"
cp frontend.confo /etc/nginx/default.d/roboshop.conf
echo -e "\e[36m>>>>>>>remove existed file in /usr/share/nginx/html>>>>>>>>>>>>>>>>>\e[0m"
rm -rf /usr/share/nginx/html/*
echo -e "\e[36m>>>>>>>download content>>>>>>>>>>>>>>>>>\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
echo -e "\e[36m>>>>>>>unzip content>>>>>>>>>>>>>>>>>\e[0m"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip
echo -e "\e[36m>>>>>>>start system services>>>>>>>>>>>>>>>>>\e[0m"
systemctl enable nginx
systemctl restart nginx