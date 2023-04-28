echo -e "\e[36m>>>>>>>copy  content>>>>>>>>>>>>>>>>>\e[0m"
cp mongo.repo /etc/yum.repos.d/mongo.repo
echo -e "\e[36m>>>>>>>Configuring nodejs repos>>>>>>>>>>>>>>>>>\e[0m"
yum install mongodb-org -y
echo -e "\e[36m>>>>>>>update address in mongod file>>>>>>>>>>>>>>>>>\e[0m"
sed -i -e 's|127.0.0.1|0.0.0.0|' /etc/mongod.conf
echo -e "\e[36m>>>>>>>Start system services>>>>>>>>>>>>>>>>>\e[0m"
systemctl enable mongod
systemctl restart mongod