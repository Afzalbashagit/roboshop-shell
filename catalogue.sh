
echo -e "\e[36m>>>>>>>Configuring nodejs repos>>>>>>>>>>>>>>>>>\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
echo -e "\e[36m>>>>>>>Installing NOdeJs>>>>>>>>>>>>>>>>>\e[0m"
yum install nodejs -y
echo -e "\e[36m>>>>>>>Add Application User>>>>>>>>>>>>>>>>>\e[0m"
useradd roboshop
echo -e "\e[36m>>>>>>>Creating app directory>>>>>>>>>>>>>>>>>\e[0m"
rm -rf /app
mkdir /app
echo -e "\e[36m>>>>>>>Download app content>>>>>>>>>>>>>>>>>\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
cd /app
echo -e "\e[36m>>>>>>>unzip app content>>>>>>>>>>>>>>>>>\e[0m"
unzip /tmp/catalogue.zip
echo -e "\e[36m>>>>>>>Install NOdeJs dependencies>>>>>>>>>>>>>>>>>\e[0m"
npm install
echo -e "\e[36m>>>>>>>Copy catalogue systemd file>>>>>>>>>>>>>>>>>\e[0m"
cp /root/roboshop-shell/catalogue.service /etc/systemd/system/catalogue.service
echo -e "\e[36m>>>>>>>start catalogue service>>>>>>>>>>>>>>>>>\e[0m"
systemctl daemon-reload
systemctl enable catalogue
systemctl restart catalogue
echo -e "\e[36m>>>>>>>Copy mongodb repo>>>>>>>>>>>>>>>>>\e[0m"
cp mongo.repo /etc/yum.repos.d/mongo.repo
echo -e "\e[36m>>>>>>>Install mongodb client>>>>>>>>>>>>>>>>>\e[0m"
yum install mongodb-org-shell -y
echo -e "\e[36m>>>>>>>Load schema>>>>>>>>>>>>>>>>>\e[0m"
mongo --host  mongodb.afzalbasha.cloud</app/schema/catalogue.js
