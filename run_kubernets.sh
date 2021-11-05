#!/usr/bin/env bash

cd /home/ubuntu/bookingapp/project
echo "Initializing conntrack and socat..."
sudo apt-get install -y conntrack
sudo apt-get install -y socat
echo "Initializing cluster..."
sudo minikube start --driver=none
sudo kubectl run bookingapp --image=juanvaes/bookingapp:latest --port=80 --labels app=bookingapp
sudo kubectl wait pod/bookingapp --for=condition=Ready --timeout=-1s
sudo kubectl get nodes
sudo kubectl port-forward --address 0.0.0.0 pod/bookingapp 80:80