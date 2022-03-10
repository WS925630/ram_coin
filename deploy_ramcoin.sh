#!/bin/bash

namespaceStatus=$(kubectl get namespaces ramcoin -o json | jq .status.phase -r)

if [ $namespaceStatus == "Active" ]
then
    echo "Namespace ramcoin exists, need to clean up"
    kubectl delete namespaces ramcoin
fi

kubectl create namespace ramcoin 
 
kubectl create -f ramcoin.yaml --namespace ramcoin
kubectl create -f ramcoin-service.yaml --namespace ramcoin

kubectl get pods -n ramcoin

