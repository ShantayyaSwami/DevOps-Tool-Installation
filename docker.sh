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


