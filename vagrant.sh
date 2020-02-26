#!/bin/bash

function printTitle() {
    echo "-[ $1 ]-"
}

# Docker Install
function dockerInstall() {
    printTitle "Docker Install"
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    apt-get update
    apt-get upgrade
    apt-get -y install apt-transport-https ca-certificates vim curl gnupg2 software-properties-common docker-ce docker-ce-cli containerd.io docker-compose
    usermod -aG docker vagrant
    cat > /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2",
  "insecure-registries" : ["docker-registry.local"]
}
EOF
    mkdir -p /etc/systemd/system/docker.service.d
    systemctl daemon-reload
    systemctl restart docker
}

# main
function main() {
    dockerInstall
    docker-compose -f /vagrant/docker-compose.yml up -d
}

main

printTitle "Finished!"
echo -e
echo -e "Update your /etc/hosts local file with: $(ip addr show eth1 | grep inet | grep eth1 | awk '{print $2}' | cut -d '/' -f1) docker-registry.local"
echo -e