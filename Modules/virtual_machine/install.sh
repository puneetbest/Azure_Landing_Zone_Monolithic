#!/bin/bash

#-----------------------------------------------------
# Log everything
#-----------------------------------------------------
exec > >(tee /var/log/custom-script.log) 2>&1

echo "========== VM Bootstrap Started =========="

#-----------------------------------------------------
# Update Ubuntu
#-----------------------------------------------------
apt-get update -y
apt-get upgrade -y

#-----------------------------------------------------
# Install Common Utilities
#-----------------------------------------------------
apt-get install -y \
    unzip \
    wget \
    curl \
    git \
    jq \
    net-tools \
    dnsutils \
    apt-transport-https \
    software-properties-common

#-----------------------------------------------------
# Install NGINX
#-----------------------------------------------------
apt-get install nginx -y

systemctl enable nginx
systemctl start nginx

echo "<h1>Terraform deployed this VM successfully</h1>" > /var/www/html/index.html

#-----------------------------------------------------
# Install Terraform
#-----------------------------------------------------
TERRAFORM_VERSION="1.13.1"

wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip

unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip

mv terraform /usr/local/bin/

chmod +x /usr/local/bin/terraform

rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

#-----------------------------------------------------
# Install Azure CLI
#-----------------------------------------------------
curl -sL https://aka.ms/InstallAzureCLIDeb | bash

#-----------------------------------------------------
# Verify Installation
#-----------------------------------------------------
terraform version

az version

nginx -v

echo "========== Bootstrap Completed =========="