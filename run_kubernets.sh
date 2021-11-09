#!/usr/bin/env bash
echo "----------------------------"
echo "----Deploying Kubernetes----"
echo "----------------------------"

echo "Listing service accounts..."
sudo kubectl get serviceAccounts
echo "Running POD..."
sudo kubectl run bookingapp-pod --image=juanvaes/bookingapp:latest --port=80 --labels app=bookingapp
echo "Listing pods..."
sudo kubectl get pods
echo "Waiting for pod to be ready..."
sudo kubectl wait pod/bookingapp-pod --for=condition=Ready --timeout=-1s
sudo kubectl get nodes
echo "Forwarding port..."
sudo kubectl port-forward --address 0.0.0.0 pod/bookingapp-pod 80:80