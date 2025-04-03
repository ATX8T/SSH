#!/bin/bash

# 查看服务器是否安装ssh，是否启用状态
if ! command -v ssh >/dev/null 2>&1; then
    echo "SSH 未安装，请先安装 SSH。"
    exit 1
fi


if ! systemctl is-active --quiet sshd; then
    echo "SSH 服务未启用，现在启用..."
    sudo systemctl start sshd
    sudo systemctl enable sshd
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
sudo systemctl restart sshd

# 检查状态
if systemctl is-active --quiet sshd; then
    echo "SSH 服务已成功重启并处于运行状态。"
else
    echo "SSH 服务重启失败，请检查配置。"
fi    
