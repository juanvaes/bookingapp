#!/usr/bin/env bash

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
sudo kubectl get serviceAccounts
sudo kubectl run bookingapp-pod --image=juanvaes/bookingapp:latest --port=80 --labels app=bookingapp
echo "Waiting for pod to be ready..."
sudo kubectl wait pod/bookingapp-pod --for=condition=Ready --timeout=-1s
sudo kubectl get nodes
sudo kubectl port-forward --address 0.0.0.0 pod/bookingapp-pod 80:80