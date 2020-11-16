#!/bin/bash

kubectl create ns jenkins

kubectl apply -f jenkins-sa.yml -n jenkins

helm install jenkins jenkinsci/jenkins --values values.yml --namespace jenkins