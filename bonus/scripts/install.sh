#!/usr/bin/env bash

# start script
echo -e "\033[32;1;4;47m [INFO] Script install.sh is running \033[0m"

# System update apt upgrade
echo -e "\033[34;1;4;47m [INFO] System update and upgrade \033[0m"
sudo apt-get update && sudo apt-get upgrade -y

# install docker
# https://docs.docker.com/engine/install/debian/
echo -e "\033[34;1;4;47m [INFO] Install docker \033[0m"
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh ./get-docker.sh
docker --version

# install kubectl
# https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/
echo -e "\033[34;1;4;47m [INFO] Install kubectl \033[0m"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
kubectl version --client
sudo chmod u+s /usr/local/bin/kubectl

# install k3d
# https://k3d.io/v5.4.9/#installation
echo -e "\033[34;1;4;47m [INFO] Install k3d \033[0m"
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
k3d --version
sudo chmod u+s /usr/local/bin/k3d

# end script
echo -e "\033[32;1;4;47m [INFO] Script install.sh done \033[0m"
