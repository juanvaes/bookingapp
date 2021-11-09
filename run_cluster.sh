#!/usr/bin/env bash
echo "----------------------------"
echo "--Running Minikube cluster--"
echo "----------------------------"

cd /home/ubuntu/bookingapp/project
echo "Initializing conntrack and socat..."
sudo apt-get install -y conntrack
sudo apt-get install -y socat
echo "Initializing cluster..."
sudo minikube start --driver=none
export NODE_NAME=$(sudo kubectl get nodes --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}')
echo $NODE_NAME
echo "Waiting for node to be ready..."
sudo kubectl wait node/$NODE_NAME --for=condition=Ready --timeout=-1s
echo "Node is ready"