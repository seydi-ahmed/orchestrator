#!/bin/bash

# ./scripts/deply-all.sh

set -e

echo "[+] Deploying all Kubernetes manifests..."

kubectl apply -f /vagrant/manifests/secrets/ || { echo "[!] Failed to deploy secrets"; exit 1; }

kubectl apply -f /vagrant/manifests/configmaps/app-config.yaml || { echo "[!] Failed to deploy ConfigMap"; exit 1; }

kubectl apply -f /vagrant/manifests/databases/ || { echo "[!] Failed to deploy databases"; exit 1; }

kubectl apply -f /vagrant/manifests/rabbitmq/ || { echo "[!] Failed to deploy rabbitmq"; exit 1; }

# Fonction d’attente sur les StatefulSets
wait_for_statefulset_ready() {
  local namespace=${1:-default}
  local statefulset_name=$2
  local timeout=${3:-300}  # 5 minutes timeout par défaut
  echo "[+] Waiting for StatefulSet '$statefulset_name' to be ready (timeout ${timeout}s)..."

  if ! kubectl wait --for=condition=ready pod -l app=$statefulset_name --timeout=${timeout}s -n "$namespace"; then
    echo "[!] Timeout waiting for StatefulSet $statefulset_name pods to be ready"
  else
    echo "[✓] StatefulSet $statefulset_name pods are ready"
  fi
}

# Attendre que les bases de données soient prêtes (adapter le label app si besoin)
wait_for_statefulset_ready default billing-db
wait_for_statefulset_ready default inventory-db

# Déployer les applications même si la DB a timeout (comme tu voulais)
kubectl apply -f /vagrant/manifests/billing-app/ || { echo "[!] Failed to deploy billing-app"; exit 1; }
kubectl apply -f /vagrant/manifests/inventory-app/ || { echo "[!] Failed to deploy inventory-app"; exit 1; }
kubectl apply -f /vagrant/manifests/api-gateway-app/ || { echo "[!] Failed to deploy api-gateway-app"; exit 1; }

kubectl apply -f /vagrant/manifests/ingress/ingress.yaml || { echo "[!] Failed to deploy ingress"; exit 1; }

echo "[✓] Deployment completed. Check pod status with: kubectl get pods"
