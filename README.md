## pptpd

一键安装pptpd到Amazon EC2，支持Amazon Linxu AMI 的64位和32位的系统。

* 64位用的脚本是 pptpd_x64.sh
* 32位用的脚本是 pptpd_i686.sh


## 安装

  	sudo sh pptpd_x64.sh [subnet]
  
  
## 添加用户

  	vim /etc/ppp/chap-secrets
  	

默认已经添加了用户名是vpn的用户，根据需要添加账号，每行一个。

按照：“用户名 pptpd 密码 ip地址” 的格式输入，每一项之间用空格分开。

例如：

  	vpn pptpd password *    
