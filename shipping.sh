script_path=$(dirname $0)
source ${script_path}/common.sh
echo ${app_user}
exit
echo -e "\e[36m>>>>>>>Install maven>>>>>>>>>>>>>>>>>\e[0m"
yum install maven -y
echo -e "\e[36m>>>>>>>add application user>>>>>>>>>>>>>>>>>\e[0m"
useradd {app_user}
echo -e "\e[36m>>>>>>>create app directory>>>>>>>>>>>>>>>>>\e[0m"
rm -rf /app
mkdir /app
echo -e "\e[36m>>>>>>>Download app content>>>>>>>>>>>>>>>>>\e[0m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip
echo -e "\e[36m>>>>>>>unzip app content>>>>>>>>>>>>>>>>>\e[0m"
cd /app
unzip /tmp/shipping.zip
echo -e "\e[36m>>>>>>>Install maven dependencies>>>>>>>>>>>>>>>>>\e[0m"
mvn clean package
mv target/shipping-1.0.jar shipping.jar
echo -e "\e[36m>>>>>>>Install mysql>>>>>>>>>>>>>>>>>\e[0m"
yum install mysql -y
echo -e "\e[36m>>>>>>>>>>Load schema>>>>>>>>>>>>>>\e[0m"
mysql -h mysql-dev.afzalbasha.cloud> -uroot -pRoboShop@1 < /app/schema/shipping.sql
echo -e "\e[36m>>>>>>>setup systemd shipping service>>>>>>>>>>>>>>>>>\e[0m"
cp /root/roboshop-shell/shipping.service /etc/systemd/system/shipping.service
echo -e "\e[36m>>>>>>>start shipping service>>>>>>>>>>>>>>>>>\e[0m"
systemctl daemon-reload
systemctl enable shipping
systemctl restart shipping
