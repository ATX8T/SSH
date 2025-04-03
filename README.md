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
