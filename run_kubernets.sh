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



echo "----------------------------"
echo "--Running Minikube cluster--"
echo "----------------------------"

cd /home/ubuntu/bookingapp/project
echo "-> Initializing cluster..."
sudo minikube start --driver=none
export NODE_NAME=$(sudo kubectl get nodes --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}')
echo $NODE_NAME
echo "-> Waiting for node to be ready..."
sudo kubectl wait node/$NODE_NAME --for=condition=Ready --timeout=-1s
echo "-> Node is ready"
echo "-> Listing Nodes"
sudo kubectl get nodes

echo "-> Applying deployment..."
sudo kubectl apply -f /home/ubuntu/bookingapp/project/app-deployment.yml

echo "-> Listing Pods"
sudo kubectl get pods
export POD_NAME=$(sudo kubectl get pods --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}')
echo POD_NAME=$POD_NAME
sudo kubectl wait --for=condition=Ready pod/$POD_NAME --timeout=-1s
echo "Forwarding port..."
sudo kubectl port-forward --address 0.0.0.0 pod/$POD_NAME 80:80