script=$(realpath "$0")
script_path=$(dirname "$script")
app_user=roboshop


func_print(){

 echo -e "\e[36m>>>>>>>$1>>>>>>>>>>>>>>>>>\e[0m"


}

func_schema(){
  if [ "$schema_setup" == "mongo" ];then
  func_print "Copy mongodb repo"
  cp $script_path/mongo.repo /etc/yum.repos.d/mongo.repo
  func_stat_check $?
  func_print "Install mongodb client"
  yum install mongodb-org-shell -y
  func_stat_check $?
  func_print "Load schema"
  mongo --host  mongodb-dev.afzalbasha.cloud</app/schema/${component}.js
  func_stat_check $?
 fi
  if [ "$schema_setup" == "mysql" ];then
    func_print "Install mysql"
    yum install mysql -y
    func_stat_check $?
    func_print "Load schema"
    mysql -h mysql-dev.afzalbasha.cloud> -uroot -p${mysql_root_password} < /app/schema/${component}.sql
    func_stat_check $?
  fi

}


func_app_prereq(){
   func_print "add application user"
    useradd {app_user}
    func_stat_check $?
    func_print "create app directory"
    rm -rf /app
    mkdir /app
    func_stat_check $?
    func_print "Download app content"
    curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip
    func_stat_check $?
    func_print "unzip app content"
    cd /app
    unzip /tmp/${component}.zip
    func_stat_check $?
}
func_systemd_service()
{
    func_print "setup systemd  service"
    cp $script_path/${component}.service /etc/systemd/system/${component}.service
    func_stat_check $?
    func_print "start systemd service"
    systemctl daemon-reload
    systemctl enable ${component}
    systemctl restart ${component}
    func_stat_check $?
}
func_stat_check(){
        if [ $1 -eq 0 ]; then
          echo -e "\e[32mSuccess\e[0m"
        else
           echo -e "\e[31mFailure\e[0m"
           exit 1
        fi
}
func_nodejs(){
   func_print "Installing NOdeJs"
    yum install nodejs -y >/tmp/robshop.log
   func_stat_check $?
   func_app_prereq
   func_print "Install NOdeJs dependencies"
    npm install
    func_stat_check $?

   func_systemd_service

    func_schema
}

func_java(){
   func_print "Install maven"
  yum install maven -y
  func_stat_check $?
 func_app_prereq
  func_print "Install maven dependencies"
  mvn clean package
  mv target/${component}-1.0.jar ${component}.jar
 func_stat_check $?
 func_schema
 func_systemd_service
}
