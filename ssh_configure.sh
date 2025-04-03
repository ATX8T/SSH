#!/bin/bash

# 查看服务器是否安装ssh
if command -v ssh >/dev/null 2>&1; then
    echo "SSH 客户端已安装"
    # 检查 sshd 服务是否存在
    if! systemctl list-units --full --all | grep -Fq "sshd.service"; then
        echo "SSH 服务端未安装，正在安装..."
        if [[ -f /etc/debian_version ]]; then
            sudo apt-get update
            sudo apt-get install -y openssh-server
        elif [[ -f /etc/redhat-release ]]; then
            sudo yum install -y openssh-server
        else
            echo "不支持的系统，无法安装 SSH 服务端。"
            exit 1
        fi
    fi
else
    echo "SSH 客户端未安装，正在安装..."
    if [[ -f /etc/debian_version ]]; then
        sudo apt-get update
        sudo apt-get install -y openssh-client openssh-server
    elif [[ -f /etc/redhat-release ]]; then
        sudo yum install -y openssh-clients openssh-server
    else
        echo "不支持的系统，无法安装 SSH。"
        exit 1
    fi
fi

# 查看SSH服务是否启用
if systemctl is-active --quiet sshd; then
    echo "SSH 服务已启用"
else
    echo "SSH 服务未启用，现在启用..."
    sudo systemctl start sshd
    if systemctl is-active --quiet sshd; then
        echo "SSH 服务启用成功"
        sudo systemctl enable sshd
    else
        echo "SSH 服务启用失败，可能原因："
        systemctl status sshd | grep -i "failed"
    fi
fi

# 生成OpenSSH密钥对, 一路回车即可
while true; do
    ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa <<< $'\n' >/dev/null 2>&1
    if [ -f ~/.ssh/id_rsa ] && [ -f ~/.ssh/id_rsa.pub ]; then
        echo "OpenSSH 密钥对生成成功。"
        break
    else
        echo "密钥对生成失败，重新生成..."
    fi
done

# 查看生成的公钥，密钥
echo "私钥内容："
cat ~/.ssh/id_rsa
echo "公钥内容："
cat ~/.ssh/id_rsa.pub

# 将公钥追加到到服务器的authorized_keys文件中
mkdir -p ~/.ssh
chmod 700 ~/.ssh
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys

# 查看是否添加成功
if grep -q "$(cat ~/.ssh/id_rsa.pub)" ~/.ssh/authorized_keys; then
    echo "公钥已成功添加到 authorized_keys 文件中。"
else
    echo "公钥添加失败。"
fi

# 修改ssh配置文件
sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
sudo sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config

# 重启 SSH 服务
echo "正在重启SSH服务..."
sudo systemctl restart sshd
if systemctl is-active --quiet sshd; then
    echo "SSH 服务已成功重启并处于运行状态。"
else
    echo "SSH 服务重启失败，可能原因："
    systemctl status sshd | grep -i "failed"
fi    
