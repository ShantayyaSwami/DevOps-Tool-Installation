# DevOps tools installation scripts

## Docker Installation
```
#!/bin/bash
sudo yum update -y

# Install Docker prerequisites
sudo yum install -y yum-utils device-mapper-persistent-data lvm2

# Set up Docker repository for Amazon Linux 2 or RHEL 7/8
sudo amazon-linux-extras install docker
# OR, for RHEL 7/8
# sudo subscription-manager repos --enable=rhel-7-server-extras-rpms (for RHEL 7)
# sudo subscription-manager repos --enable=rhel-8-for-x86_64-baseos-rpms --enable=rhel-8-for-x86_64-appstream-rpms (for RHEL 8)

# Install Docker
sudo yum install docker -y

# Start and enable Docker service
sudo systemctl enable docker --now

# Add the user to the docker group to run Docker without sudo
sudo usermod -aG docker ec2-user  # Change 'ec2-user' to your actual username
newgrp docker                      # reload docker group

```

## Jenkins Installation 
```
#!/bin/bash

sudo apt update -y

sudo apt upgrade -y 

sudo apt install openjdk-17-jre -y

curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update -y 
sudo apt-get install jenkins -y

```

## Jfrog Installation
```
##Install in Amazon REL
sudo usermod -aG docker $USER
docker pull docker.bintray.io/jfrog/artifactory-oss:latest
sudo mkdir -p /jfrog/artifactory
sudo chown -R 1030 /jfrog/
docker run --name artifactory -d \
  -p 8081:8081 \
  -p 8082:8082 \
  -v /jfrog/artifactory:/var/opt/jfrog/artifactory \
  docker.bintray.io/jfrog/artifactory-oss:latest

```

## Nexus Installation
```
wget https://download.sonatype.com/nexus/3/latest-unix.tar.gz
tar -zxvf latest-unix.tar.gz
sudo mv nexus-3.x.y /opt/nexus
sudo ln -s /opt/nexus/bin/nexus /etc/init.d/nexus
sudo systemctl enable nexus --now

access http://your-ec2-instance-ip:8081
cat /opt/nexus/sonatype-work/nexus3/admin-password

```

## Maven Installation
```
sudo yum update -y
sudo yum install maven -y
mvn -version

```

## Sonarqube Installation
```
 docker run -d --name sonarqube -p 9000:9000 -p 9092:9092 sonarqube

```

## Trivy Installation (Linting tool)
```
# Install necessary dependencies
sudo yum install -y wget

# Add Trivy GPG key
wget -qO - https://aquasecurity.github.io/trivy-repo/rpm/RPM-GPG-KEY-TRIVY-AQUA.pub | sudo gpg --import -
sudo gpg --export --armor 276E02F8 | sudo rpm --import -

# Add Trivy repository
echo -e "[trivy]\nname=Trivy repository\nbaseurl=https://aquasecurity.github.io/trivy-repo/rpm/releases/x86_64\nenabled=1\ngpgcheck=1\ngpgkey=https://aquasecurity.github.io/trivy-repo/rpm/RPM-GPG-KEY-TRIVY-AQUA.pub" | sudo tee /etc/yum.repos.d/trivy.repo

# Install Trivy
sudo yum install -y trivy

```

## Helm Installation
```
# Download Helm binary
wget https://get.helm.sh/helm-v3.7.0-linux-amd64.tar.gz

# Extract the archive
tar -zxvf helm-v3.7.0-linux-amd64.tar.gz

# Move the helm binary to a directory in your PATH
sudo mv linux-amd64/helm /usr/local/bin/helm

# Clean up the downloaded files
rm -rf linux-amd64 helm-v3.7.0-linux-amd64.tar.gz

# Check Helm version
helm version

# Initialize Helm (this will install Tiller on the Kubernetes cluster, but Helm v3 no longer requires Tiller)
helm init

```

## Prometheus Installation
```
# Add the Prometheus Helm repository
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

# Install Prometheus using Helm
helm install prometheus prometheus-community/prometheus

#By default, Prometheus is exposed as a NodePort service. Retrieve the NodePort by running:
kubectl get svc prometheus-server -o=jsonpath='{.spec.ports[0].nodePort}'

#access prometheus on 
http://<your-node-ip>:<node-port>

```

## Grafana Installation 
```
# Add the Grafana Helm repository
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update

# Install Grafana using Helm
helm install grafana grafana/grafana

#retrieve admin password
kubectl get secret --namespace default grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo

#get NodePort
kubectl get svc grafana -o=jsonpath='{.spec.ports[0].nodePort}'

#access url
http://<your-node-ip>:<node-port>

```

