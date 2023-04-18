echo -e "\e[36m>>>>>>>Install erland repo>>>>>>>>>>>>>>>>>\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash
echo -e "\e[36m>>>>>>>Install rabbitmq repo>>>>>>>>>>>>>>>>>\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash
echo -e "\e[36m>>>>>>>Install erlang and rabbitmq>>>>>>>>>>>>>>>>>\e[0m"
yum install rabbitmq-server -y
yum install erlang -y
echo -e "\e[36m>>>>>>>start rabbitmq services>>>>>>>>>>>>>>>>>\e[0m"
systemctl enable rabbitmq-server
systemctl start rabbitmq-server
echo -e "\e[36m>>>>>>>Add application user in rabbitmq>>>>>>>>>>>>>>>>>\e[0m"
rabbitmqctl add_user roboshop roboshop123
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"