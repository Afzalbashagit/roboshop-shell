echo -e "\e[36m>>>>>>>Disable mysql default version>>>>>>>>>>>>>>>>>\e[0m"
dnf module disable mysql -y
echo -e "\e[36m>>>>>>>Copy mysql repo>>>>>>>>>>>>>>>>>\e[0m"
cp /root/roboshop-shell/mysql.repo /etc/yum.repos.d/mysql.repo
echo -e "\e[36m>>>>>>>Install mysql>>>>>>>>>>>>>>>>>\e[0m"
yum install mysql-community-server -y
echo -e "\e[36m>>>>>>>Start mysql>>>>>>>>>>>>>>>>>\e[0m"
systemctl enable mysqld
systemctl restart mysqld
echo -e "\e[36m>>>>>>>Reset mysql password>>>>>>>>>>>>>>>>>\e[0m"
mysql_secure_installation --set-root-pass RoboShop@1
