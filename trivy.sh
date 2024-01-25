# Install necessary dependencies
sudo yum install -y wget

# Add Trivy GPG key
wget -qO - https://aquasecurity.github.io/trivy-repo/rpm/RPM-GPG-KEY-TRIVY-AQUA.pub | sudo gpg --import -
sudo gpg --export --armor 276E02F8 | sudo rpm --import -

# Add Trivy repository
echo -e "[trivy]\nname=Trivy repository\nbaseurl=https://aquasecurity.github.io/trivy-repo/rpm/releases/x86_64\nenabled=1\ngpgcheck=1\ngpgkey=https://aquasecurity.github.io/trivy-repo/rpm/RPM-GPG-KEY-TRIVY-AQUA.pub" | sudo tee /etc/yum.repos.d/trivy.repo

# Install Trivy
sudo yum install -y trivy
