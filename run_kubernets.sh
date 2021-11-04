#!/usr/bin/env bash

cd /home/ubuntu/bookingapp/project
echo "Initializing conntrack and socat..."
sudo apt-get install -y conntrack
sudo apt-get install -y socat
echo "Initializing cluster..."
sudo minikube start --driver=none
sudo kubectl get nodes
sudo kubectl create deployment bookingapp-deployment --image=juanvaes/bookingapp:latest
sudo kubectl get deployments
sudo kubectl expose deployment/bookingapp-deployment --type="NodePort" --port=80
sudo kubectl describe services/bookingapp-deployment
sudo kubectl wait --for=condition=Ready pod -l app=bookingapp-deployment --timeout=10s
export NODE_PORT=$(sudo kubectl get services/bookingapp-deployment -o go-template='{{(index .spec.ports 0).nodePort}}')
echo NODE_PORT=$NODE_PORT
curl $(sudo minikube ip):$NODE_PORT/index
sudo kubectl port-forward --address 0.0.0.0 deployment/bookingapp-deployment 80:80