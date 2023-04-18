echo -e "\e[36m>>>>>>>Installing NOdeJs>>>>>>>>>>>>>>>>>\e[0m"
yum install nodejs -y
echo -e "\e[36m>>>>>>>Add Application User>>>>>>>>>>>>>>>>>\e[0m"
useradd roboshop
echo -e "\e[36m>>>>>>>Creating app directory>>>>>>>>>>>>>>>>>\e[0m"
rm -rf /app
mkdir /app
echo -e "\e[36m>>>>>>>Download app content>>>>>>>>>>>>>>>>>\e[0m"
curl -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip
cd /app
echo -e "\e[36m>>>>>>>unzip app content>>>>>>>>>>>>>>>>>\e[0m"
unzip /tmp/user.zip
echo -e "\e[36m>>>>>>>Install NOdeJs dependencies>>>>>>>>>>>>>>>>>\e[0m"
npm install
echo -e "\e[36m>>>>>>>Copy user systemd file>>>>>>>>>>>>>>>>>\e[0m"
cp /root/roboshop-shell/user.service /etc/systemd/system/user.service
echo -e "\e[36m>>>>>>>start user service>>>>>>>>>>>>>>>>>\e[0m"
systemctl daemon-reload
systemctl enable user
systemctl restart user
echo -e "\e[36m>>>>>>>Copy mongodb repo>>>>>>>>>>>>>>>>>\e[0m"
cp mongo.repo /etc/yum.repos.d/mongo.repo
echo -e "\e[36m>>>>>>>Install mongodb client>>>>>>>>>>>>>>>>>\e[0m"
yum install mongodb-org-shell -y
echo -e "\e[36m>>>>>>>Load schema>>>>>>>>>>>>>>>>>\e[0m"
mongo --host  mongodb-dev.afzalbasha.cloud</app/schema/user.js
