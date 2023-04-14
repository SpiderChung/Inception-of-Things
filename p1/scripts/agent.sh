#!/usr/bin/env bash

echo "The script agent.sh is running"


# apt update apt upgrade
# sudo apt update
# sudo apt upgrade -y

# echo '$#' $#
# echo '$@' $@

# add k3s master node token
export TOKEN_FILE="/vagrant/scripts/node-token"

# download and run k3s agent. https://docs.k3s.io/quick-start "curl -sfL https://get.k3s.io | sh -"
# INSTALL_K3S_EXEC - https://docs.k3s.io/installation/configuration https://docs.k3s.io/cli/agent https://docs.k3s.io/reference/env-variables
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="agent --server https://$1:6443 --token-file $TOKEN_FILE --node-ip $2 --flannel-iface eth1" sh -s -

# sleep to wait for k3s to be ready
sleep 10

echo "The script agent.sh is over"