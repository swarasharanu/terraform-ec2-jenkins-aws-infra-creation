#!/bin/bash

# Update package lists
sudo apt update

# Install Docker
sudo apt install -y docker.io

echo "hi"

# Install Jenkins
sudo apt update -y
sudo apt install fontconfig openjdk-17-jre -y
java -version


#jenkins
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
/etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt update -y
sudo apt install jenkins -y
sudo systemctl start jenkins
sudo systemctl enable jenkins

# Install SonarQube
docker run -d --name sonar -p 9000:9000 sonarqube:lts-community

# Install OWASP ZAP
sudo wget https://github.com/zaproxy/zaproxy/releases/download/v2.14.0/ZAP_2_14_0_unix.sh
sudo chmod +x  ZAP_2_14_0_unix.sh
sudo ./ZAP_2_14_0_unix.sh -q
sudo tar -xvf ZAP_2.14.0_Linux.tar.gz

# Install Trivy
wget https://github.com/aquasecurity/trivy/releases/download/v0.16.0/trivy_0.16.0_Linux-64bit.deb
sudo dpkg -i trivy_0.16.0_Linux-64bit.deb

# Start services
sudo su
sudo usermod -aG docker jenkins
sudo systemctl restart jenkins
sudo systemctl start sonarqube
