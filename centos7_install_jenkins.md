#  Install Jenkins on CentOS 7

### Step 1: Update your CentOS 7 system
```
sudo yum install epel-release
sudo yum update
sudo reboot
```

### Step 2: Install Java
```
sudo yum install java-1.8.0-openjdk.x86_64
java -version
```

In order to help Java-based applications locate the Java virtual machine properly, you need to set two environment variables: "JAVA_HOME" and "JRE_HOME".
```
sudo cp /etc/profile /etc/profile_backup
echo 'export JAVA_HOME=/usr/lib/jvm/jre-1.8.0-openjdk' | sudo tee -a /etc/profile
echo 'export JRE_HOME=/usr/lib/jvm/jre' | sudo tee -a /etc/profile
source /etc/profile

echo $JAVA_HOME
echo $JRE_HOME
```

### Step 3: Install Jenkins

Use the official YUM repo to install the latest stable version of Jenkins:
```
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
sudo rpm --import http://pkg.jenkins-ci.org/redhat-stable/jenkins-ci.org.key

sudo yum install jenkins
```
Start the Jenkins service and set it to run at boot time:
```
sudo systemctl start jenkins.service
sudo systemctl enable jenkins.service
```

In order to allow visitors access to Jenkins, you need to allow inbound traffic on port 8080:
```
sudo firewall-cmd --zone=public --permanent --add-port=8080/tcp
sudo firewall-cmd --reload
```

Now, test Jenkins by visiting the following address from your web browser:
```
http://<your-server-IP>:8080
```

### Step 4: Install Nginx

In order to facilitate visitors' access to Jenkins, you can setup an Nginx reverse proxy for Jenkins, so visitors will no longer need to key in the port number 8080 when accessing your Jenkins application.

Install Nginx using YUM:
```
sudo yum install nginx
```

Modify the configuration of Nginx:
```
sudo vi /etc/nginx/nginx.conf
```

Find the two lines below:
```
location / {
}
```

Insert the six lines below into the { } segment:
```
proxy_pass http://127.0.0.1:8080;
proxy_redirect off;
proxy_set_header Host $host;
proxy_set_header X-Real-IP $remote_addr;
proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
proxy_set_header X-Forwarded-Proto $scheme;
```

The final result should be:
```
location / {
    proxy_pass http://127.0.0.1:8080;
    proxy_redirect off;
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
}
```
Start and enable the Nginx service:
```
sudo systemctl start nginx.service
sudo systemctl enable nginx.service
```

Allow traffic on port 80:
```
sudo firewall-cmd --zone=public --permanent --add-service=http
sudo firewall-cmd --reload
```

Finally, visit the following address from your web browser to confirm your installation:
```
http://<your-server-IP>
```
