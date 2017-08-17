## 生成密钥
```
ssh-keygen -t rsa -C "username@host.com"
```
## 测试是否能连接git服务器
```
ssh -T git@github.com
```
## pull
```
git clone https://github.com/lordyung/ssh.git ~/.ssh
```
or
```
git clone git@github.com:lordyung/ssh.git ~/.ssh
```
