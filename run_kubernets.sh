#!/usr/bin/env bash
echo "----------------------------"
echo "----Deploying Kubernetes----"
echo "----------------------------"

echo "Listing service accounts..."
kubectl get serviceAccounts
echo "Running POD..."
kubectl run bookingapp-pod --image=juanvaes/bookingapp:latest --port=80 --labels app=bookingapp
echo "Listing pods..."
kubectl get pods
echo "Waiting for pod to be ready..."
kubectl wait pod/bookingapp-pod --for=condition=Ready --timeout=-1s
kubectl get nodes
echo "Forwarding port..."
kubectl port-forward --address 0.0.0.0 pod/bookingapp-pod 80:80