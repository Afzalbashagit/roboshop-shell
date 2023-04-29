script=$(realpath "$0")
script_path=$(dirname "$script")
app_user=roboshop

func_nodejs(){
    echo -e "\e[36m>>>>>>>Installing NOdeJs>>>>>>>>>>>>>>>>>\e[0m"
    yum install nodejs -y
    echo -e "\e[36m>>>>>>>Add Application User>>>>>>>>>>>>>>>>>\e[0m"
    useradd {app_user}
    echo -e "\e[36m>>>>>>>Creating app directory>>>>>>>>>>>>>>>>>\e[0m"
    rm -rf /app
    mkdir /app
    echo -e "\e[36m>>>>>>>Download app content>>>>>>>>>>>>>>>>>\e[0m"
    curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip
    cd /app
    echo -e "\e[36m>>>>>>>unzip app content>>>>>>>>>>>>>>>>>\e[0m"
    unzip /tmp/${component}.zip
    echo -e "\e[36m>>>>>>>Install NOdeJs dependencies>>>>>>>>>>>>>>>>>\e[0m"
    npm install
    echo -e "\e[36m>>>>>>>Copy cart systemd file>>>>>>>>>>>>>>>>>\e[0m"
    cp $script_path/${component}.service /etc/systemd/system/${component}.service
    echo -e "\e[36m>>>>>>>start cart service>>>>>>>>>>>>>>>>>\e[0m"
    systemctl daemon-reload
    systemctl enable ${component}
    systemctl restart ${component}
}