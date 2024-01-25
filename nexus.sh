wget https://download.sonatype.com/nexus/3/latest-unix.tar.gz
tar -zxvf latest-unix.tar.gz
sudo mv nexus-3.x.y /opt/nexus
sudo ln -s /opt/nexus/bin/nexus /etc/init.d/nexus
sudo systemctl enable nexus --now

access http://your-ec2-instance-ip:8081
cat /opt/nexus/sonatype-work/nexus3/admin-password


