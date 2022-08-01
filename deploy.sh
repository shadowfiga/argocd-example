#!/bin/bash

# 1. Install argocd in cluster
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# 2. Wait for pods to come up
# TODO: Find better solution
echo "[O]: Waiting for services to come online ..."
# sleep 1m 30s

# 3. Forward port of the argocd dashboard
echo "[O]: Forwarding argo cd dashboard ui port to https://localhost:8080"
kubectl port-forward -n argocd svc/argocd-server 8080:443 &

# 4. Output credentials
PASSWORD=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 --decode)
echo "[O]: Username: admin"
echo "[O]: Password: $PASSWORD"

# 5. Apply argocd
# kubectl apply -f application.yaml

read -n 1 -s -r -p "Press any key to continue"