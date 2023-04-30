script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
mysql_root_password=$1
if [ -z "$mysql_root_password" ]
then
  echo mysql root password missing
  exit
fi
func_print "Disable mysql default version"
dnf module disable mysql -y &>>log_file
func_stat_check $?
func_print "Copy mysql repo"
cp $script_path/mysql.repo /etc/yum.repos.d/mysql.repo &>>log_file
func_stat_check $?
func_print "Install mysql"
yum install mysql-community-server -y &>>log_file
func_stat_check $?
func_print "Start mysql"
systemctl enable mysqld &>>log_file
systemctl restart mysqld &>>log_file
func_stat_check $?
func_print "Reset mysql password"
mysql_secure_installation --set-root-pass $mysql_root_password &>>log_file
func_stat_check $?