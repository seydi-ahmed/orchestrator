#!/bin/bash
set -e

print_usage() {
  echo "Usage: $0 {create|start|stop|destroy|status|build|push|deploy}"
}

case $1 in
  create)
    echo "[+] Creating cluster..."
    vagrant up
    echo "[✔] Cluster created"
    ;;

  start)
    echo "[+] Starting cluster..."
    vagrant up
    echo "[✔] Cluster started"
    ;;

  stop)
    echo "[+] Stopping cluster..."
    vagrant halt
    echo "[✔] Cluster stopped"
    ;;

  destroy)
    echo "[!] Destroying cluster..."
    vagrant destroy -f
    echo "[✔] Cluster destroyed"
    ;;

  status)
    echo "[?] Cluster status:"
    vagrant status
    ;;

  build)
    echo "[+] Building Docker images..."
    bash /vagrant/scripts/build-images.sh
    ;;

  push)
    echo "[↑] Pushing Docker images to Docker Hub..."
    bash /vagrant/scripts/push-images.sh
    ;;

  deploy)
    echo "[🚀] Deploying Kubernetes manifests..."
    bash /vagrant/scripts/deploy-all.sh
    ;;

  *)
    echo "[✗] Unknown command: '$1'"
    print_usage
    exit 1
    ;;
esac
