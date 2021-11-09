#!/usr/bin/env bash
echo "----------------------------"
echo "----Deploying Kubernetes----"
echo "----------------------------"

#echo "Listing service accounts..."
#kubectl get serviceAccounts
#echo "Running POD..."
#kubectl run bookingapp-pod --image=juanvaes/bookingapp:latest --port=80 --labels app=bookingapp
#echo "Listing pods..."
#kubectl get pods
#echo "Waiting for pod to be ready..."
#kubectl wait pod/bookingapp-pod --for=condition=Ready --timeout=-1s
sudo kubectl apply -f $HOME/bookingapp/project/app-deployment.yml
sudo kubectl get nodes
export POD_NAME=$(sudo kubectl get pods --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}')
sudo kubectl wait --for=condition=Ready pod/$POD_NAME --timeout=-1s
echo "Forwarding port..."
sudo kubectl port-forward --address 0.0.0.0 pod/$POD_NAME 80:80