script=$(realpath "$0")
script_path=$(dirname "$script")
app_user=roboshop


func_printhead(){
    echo -e "\e[36m>>>>>>>$1>>>>>>>>>>>>>>>>>\e[0m
}

func_nodejs(){
 func_printhead "Installing NOdeJs"
    yum install nodejs -y
func_printhead " Add Application User"
    useradd {app_user}
  func_printhead " Creating app directory"
    rm -rf /app
    mkdir /app
   func_printhead "Download app content"
    curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip
    cd /app
   func_printhead "unzip app content"
    unzip /tmp/${component}.zip
 func_printhead "Install NOdeJs dependencies"
    npm install
   func_printhead "Copy cart systemd file"
    cp $script_path/${component}.service /etc/systemd/system/${component}.service
   func_printhead "start cart service"
    systemctl daemon-reload
    systemctl enable ${component}
    systemctl restart ${component}
}