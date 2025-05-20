# scripts/build-images.sh
#!/bin/bash

# Stop on error
set -e

# Base DockerHub repo
DOCKERHUB_USERNAME="mouhameddiouf01"

# Liste des apps à builder
APPS=("api-gateway-app" "billing-app" "inventory-app" "postgres-db" "rabbitmq")

for APP in "${APPS[@]}"; do
  IMAGE_NAME="${DOCKERHUB_USERNAME}/${APP}:latest"
  echo "Building $IMAGE_NAME"
  docker build -t $IMAGE_NAME ./srcs/$APP
done
