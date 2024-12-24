#!/bin/bash

# 检查是否以 root 用户运行脚本
if [ "$(id -u)" != "0" ]; then
    echo "此脚本需要以 root 用户权限运行。"
    echo "请尝试使用 'sudo -i' 命令切换到 root 用户，然后再次运行此脚本。"
    exit 1
fi


curl -s https://raw.githubusercontent.com/jiangyaqiii/envirment/main/needrestart.sh |bash
curl -s https://raw.githubusercontent.com/jiangyaqiii/envirment/main/docker.sh |bash

if [[ $(docker ps -qf name=iniverse-contain) ]]; then
    echo "已存在iniverse容器，停止此容器"
    docker stop iniverse-contain
    docker rm iniverse-contain
fi

echo ''
echo '启动新容器'
random_num=$((RANDOM % 10000))
docker run -d --name iniverse-contain -e PATH="/root/.local/bin:$PATH" -e addr=$addr -e random_num=$random_num -w /root ubuntu:22.04 /bin/bash -c "apt-get update && apt-get install -y wget && wget -O iniverse_start.sh https://raw.githubusercontent.com/jiangyaqiii/InitVerse/main/iniverse_start.sh && chmod +x iniverse_start.sh &&./iniverse_start.sh"
rm -f iniverse_docker.sh
