script=$(realpath "$0")
script_path=$(dirname "$script")
app_user=roboshop


func_print(){

 echo -e "\e[36m>>>>>>>$1


}

func_schema(){
  func_print "Copy mongodb repo"
  cp $script_path/mongo.repo /etc/yum.repos.d/mongo.repo
  func_print "Install mongodb client"
  yum install mongodb-org-shell -y
  func_print "Load schema"
  mongo --host  mongodb-dev.afzalbasha.cloud</app/schema/catalogue.js

}


func_nodejs(){
   func_print "Installing NOdeJs"
    yum install nodejs -y
   func_print "Add Application User"
    useradd {app_user}
   func_print "Creating app directory"
    rm -rf /app
    mkdir /app
   func_print "Download app content"
    curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip
    cd /app
  func_print "unzip app content"
    unzip /tmp/${component}.zip
   func_print "Install NOdeJs dependencies"
    npm install
   func_print "Copy cart systemd file"
    cp $script_path/${component}.service /etc/systemd/system/${component}.service
   func_print "start cart service"
    systemctl daemon-reload
    systemctl enable ${component}
    systemctl restart ${component}
    func_schema
}