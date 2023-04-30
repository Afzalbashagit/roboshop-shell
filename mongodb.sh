script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
func_print "copy  content"
cp mongo.repo /etc/yum.repos.d/mongo.repo &>>log_file
func_stat_check $?
func_print "Install mongodb"
yum install mongodb-org -y &>>log_file
func_stat_check $?
func_print "update address in mongod file"
sed -i -e 's|127.0.0.1|0.0.0.0|' /etc/mongod.conf &>>log_file
func_stat_check $?
func_print "Start system services"
systemctl enable mongod
systemctl restart mongod
func_stat_check $?
