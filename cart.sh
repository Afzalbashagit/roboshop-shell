script_path=$(dirname $0)
source ${script_path}/common.sh
echo -e "\e[36m>>>>>>>Installing NOdeJs>>>>>>>>>>>>>>>>>\e[0m"
yum install nodejs -y
echo -e "\e[36m>>>>>>>Add Application User>>>>>>>>>>>>>>>>>\e[0m"
useradd {app_user}
echo -e "\e[36m>>>>>>>Creating app directory>>>>>>>>>>>>>>>>>\e[0m"
rm -rf /app
mkdir /app
echo -e "\e[36m>>>>>>>Download app content>>>>>>>>>>>>>>>>>\e[0m"
curl -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip
cd /app
echo -e "\e[36m>>>>>>>unzip app content>>>>>>>>>>>>>>>>>\e[0m"
unzip /tmp/cart.zip
echo -e "\e[36m>>>>>>>Install NOdeJs dependencies>>>>>>>>>>>>>>>>>\e[0m"
npm install
echo -e "\e[36m>>>>>>>Copy cart systemd file>>>>>>>>>>>>>>>>>\e[0m"
cp $script_path/cart.service /etc/systemd/system/cart.service
echo -e "\e[36m>>>>>>>start cart service>>>>>>>>>>>>>>>>>\e[0m"
systemctl daemon-reload
systemctl enable cart
systemctl restart cart

