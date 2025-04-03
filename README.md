# 为服务器创建root用户，避免编辑文件的麻烦，以及没有宝塔面板作文件权限问题
- ssh_configure.sh功能描述
- 判断是否安装ssh
- 启动ssh
- 生成openssh密钥
- 添加到authorized_keys中
- 修改ssh配置文件，允许root和密钥登录
- 在命令行输出密钥，
## 输出密钥后需要复制保存密钥到本地，重命名为id_rsa
- 在本地创建id_rsa 并且放入命令行的私钥
- 或者在本地使用openssh生成一样的id_rsa文件，然后打开替换密钥
## 使用密钥连接
- Windows使用Windows PowerShell连接出现读取密钥的权限异常问题，推荐使用FinalShell与id_rsa密钥连接
   ```
   F:\IM\ls\id_rsa 本地存放路径
    ssh -i "F:\IM\ls\id_rsa" root@170.106.110.14
  ```
- 使用FinalShell➕密钥登录
- ![替代文本](https://raw.githubusercontent.com/ATX8T/SSH/main/img/image.png)
- ![替代文本](https://raw.githubusercontent.com/ATX8T/SSH/main/img/image%20(1).png)
- 


## 连接成功后删除服务器私钥
```
删除命令
rm ~/.ssh/id_rsa
rm ~/.ssh/id_rsa.pub
删除这两个文件
rm ~/.ssh/id_rsa ~/.ssh/id_rsa.pub
```

- 👌👌👌👌👌👌👌👌👌👌
- 👌👌👌👌👌👌👌👌👌👌
- 👌👌👌👌👌👌👌👌👌👌
- 👌👌👌👌👌👌👌👌👌👌


## 如果连接失败：
    1. 本地.ssh下面 known_hosts 文件中仍保留着之前远程主机的密钥记录，当再次连接时，客户端会先检查该文件中的记录，发现与新密钥不一致就报错。
    2. 从 known_hosts 文件中删除指定主机的密钥记录，然后重新连接。
    3. Windows位于C:\Users\ai861\.ssh下面







# README.md 中显示图片操作
- 将图片上传到GitHub 仓库中。点击“Add file”按钮，右键点击图片，选择“复制图片地址”或“复制链接地址”，这样你就得到了图片的 URL。
- 或者直接查看图片
- 有中文名图片要使用右键地址
- 原地址：https://github.com/ATX8T/SSH/blob/main/img/03122915.png
- 修改后只要：/ATX8T/SSH/main/img/03122915.png   删除blob与https://github.com
- 组合到：https://raw.githubusercontent.com/中去
  ```
  原地址：
  https://github.com/ATX8T/SSH/blob/main/img/03122915.png
  组合
  ![替代文本](https://raw.githubusercontent.com/ATX8T/SSH/main/img/03122915.png)
  ```
  
![替代文本](https://raw.githubusercontent.com/ATX8T/SSH/main/img/03122915.png)
