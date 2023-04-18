echo -e "\e[36m>>>>>>>Install python>>>>>>>>>>>>>>>>>\e[0m"
yum install python36 gcc python3-devel -y
echo -e "\e[36m>>>>>>>Add application user>>>>>>>>>>>>>>>>>\e[0m"
useradd roboshop
echo -e "\e[36m>>>>>>>create app directory>>>>>>>>>>>>>>>>>\e[0m"
rm -rf /app
mkdir /app
echo -e "\e[36m>>>>>>>Download app content>>>>>>>>>>>>>>>>>\e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip
echo -e "\e[36m>>>>>>>unzip app content>>>>>>>>>>>>>>>>>\e[0m"
cd /app
unzip /tmp/payment.zip
echo -e "\e[36m>>>>>>>Install python dependencies>>>>>>>>>>>>>>>>>\e[0m"
pip3.6 install -r requirements.txt
echo -e "\e[36m>>>>>>>Add application user in rabbitmq>>>>>>>>>>>>>>>>>\e[0m"
cp /root/roboshop-shell/payment.service /etc/systemd/system/payment.service
echo -e "\e[36m>>>>>>>start payment services>>>>>>>>>>>>>>>>>\e[0m"
systemctl daemon-reload
systemctl enable payment
systemctl start payment