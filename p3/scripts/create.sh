#!/usr/bin/env bash


# start script
echo -e "\033[32;1;4;47m [INFO] Script create.sh is running \033[0m"

# Сreating cluster
echo -e "\033[34;1;4;47m [INFO] Сreating cluster \033[0m"
sudo k3d cluster create p3-cluster -p 8080:80@loadbalancer --port 8888:8888@loadbalancer --wait
sleep 10

# create namespaces https://argo-cd.readthedocs.io/en/stable/getting_started/
echo -e "\033[34;1;4;47m [INFO] Create namespaces \033[0m"
sudo kubectl create namespace argocd
sudo kubectl create namespace dev
sleep 5
sudo kubectl get ns

# Install Argo CD https://argo-cd.readthedocs.io/en/stable/getting_started/
echo -e "\033[34;1;4;47m [INFO] Install Argo CD \033[0m"
# curl https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml -o install_argo_cd.yaml
# After downloading the file, add the line "- --insecure" after the line "- argocd-server" and then run it.

curl -sfL https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml > /vagrant/scripts/install_argo_cd.yaml
sed -i '/- argocd-server/s/$/\n\t\t\t\t--insecure/' /vagrant/scripts/install_argo_cd.yaml
sudo kubectl apply -n argocd -f /vagrant/scripts/install_argo_cd.yaml

# kubectl --namespace argocd get all
echo "waiting the pods to be ready"
sudo kubectl wait -n argocd --for=condition=Ready pods --all
sleep 5

# ingress https://argo-cd.readthedocs.io/en/stable/getting_started/ https://argo-cd.readthedocs.io/en/stable/operator-manual/ingress/
echo -e "\033[34;1;4;47m [INFO] Apply ingress \033[0m"
sudo kubectl apply -f /vagrant/confs/ingress.yaml -n argocd
sleep 5

# Install application (wil42/playground)
echo -e "\033[34;1;4;47m [INFO] Install application (wil42/playground) \033[0m"
sudo kubectl apply -f /vagrant/confs/application.yaml -n argocd
echo "Waiting all pods..."
sleep 60
echo -e "\033[34;1;4;47m [INFO] Configured succesfully  \033[0m"
echo "Argocd password: $(sudo kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)"

# end script
echo -e "\033[32;1;4;47m [INFO] Script create.sh done \033[0m"
