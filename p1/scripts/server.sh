#!/usr/bin/env bash

echo "The script server.sh is running"

# apt update apt upgrade
# sudo apt update
# sudo apt upgrade -y

# echo '$#' $#
# echo '$@' $@

echo "Install iptables"
sudo apt-get -y install iptables
sleep 10

# download and run k3s agent. https://docs.k3s.io/quick-start "curl -sfL https://get.k3s.io | sh -"
# INSTALL_K3S_EXEC - https://docs.k3s.io/installation/configuration https://docs.k3s.io/cli/server https://docs.k3s.io/reference/env-variables
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --write-kubeconfig-mode=644 --node-ip $1 --flannel-iface eth1" sh -s -

# sleep to wait for k3s to be ready
sleep 10

# copy master node token for worker node
sudo cp /var/lib/rancher/k3s/server/node-token /vagrant/scripts/

echo "The script server.sh is over"
