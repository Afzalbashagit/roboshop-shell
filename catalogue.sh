script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
echo -e "\e[36m>>>>>>>Configuring nodejs repos>>>>>>>>>>>>>>>>>\e[0m"
component=catalogue
func_nodejs
echo -e "\e[36m>>>>>>>Copy mongodb repo>>>>>>>>>>>>>>>>>\e[0m"
cp $script_path/mongo.repo /etc/yum.repos.d/mongo.repo
echo -e "\e[36m>>>>>>>Install mongodb client>>>>>>>>>>>>>>>>>\e[0m"
yum install mongodb-org-shell -y
echo -e "\e[36m>>>>>>>Load schema>>>>>>>>>>>>>>>>>\e[0m"
mongo --host  mongodb-dev.afzalbasha.cloud</app/schema/catalogue.js
