# 🧩 Orchestrator

## Rappel

### Projet 1 - Microservices: https://github.com/01-edu/public/tree/master/subjects/devops/crud-master-py
1) développer trois applications : api-gateway-app, inventory-app, billing-app.
2) utiliser deux bases PostgreSQL : billing-db, inventory-db.
3) utiliser RabbitMQ comme système de message pour billing-app.

### Projet 2 - Dockerisation: https://github.com/01-edu/public/tree/master/subjects/devops/play-with-containers
1) docker-compose.yml qui orchestre les services.
2) chaque microservice et composant a son propre Dockerfile.
3) relier les apps aux services dont elles dépendent (depends_on + healthcheck).
4) utiliser des volumes pour la persistance (DB & RabbitMQ).

## Projet 3(actuel) - Kubernetes (K3s + Vagrant): https://github.com/01-edu/public/tree/master/subjects/devops/orchestrator
1) tout migrer vers K8s (K3s sur 2 VMs : master + agent).
2) docker-pusher les images sur Docker Hub.
3) écrire des manifests (YAMLs) pour:
- Deployments (ou StatefulSet pour DB et billing-app)
- Services (type ClusterIP ou NodePort selon besoin)
- Ingress pour exposer api-gateway
- Autoscaling (HPA sur CPU pour inventory-app et api-gateway)
- Secrets pour les mots de passe (interdiction de les écrire dans les YAMLs hors Secret)
4) écrire un orchestrator.sh avec create, start, stop pour gérer l'infra.
5) documenter tout dans un README.md.

## 🚀 Description
- Orchestrator est un projet visant à déployer une architecture microservices complète sur un cluster Kubernetes (K3s) à l’aide de Vagrant, Docker, et des outils DevOps modernes. L’objectif est de comprendre, construire et orchestrer des services conteneurisés via Kubernetes, tout en appliquant des concepts fondamentaux tels que:
    - Déploiements, Services, Ingress, Secrets
    - StatefulSets & Persistent Volumes
    - Auto-scaling (HPA)
    - RabbitMQ pour la communication entre services
    - CI/CD & Infrastructure as Code

## 📦 Architecture du projet
- Voici les composants déployés dans le cluster:

```
+----------------+       +----------------+       +----------------+
| inventory-app  | <---> | inventory-db   |       |                |
| (Flask + SQL)  |       | (PostgreSQL)   |       |                |
+----------------+       +----------------+       |                |
                                                   |                |
+----------------+       +----------------+        |   K3s Cluster  |
| billing-app    | <---> | billing-db     |        |   (Vagrant)    |
| (Flask + MQ)   |       | (PostgreSQL)   |        |                |
+----------------+       +----------------+        |                |
                                                   |                |
        ^                      ^                   |                |
        |                      |                   |                |
        |                +----------------+        |                |
        +--------------> |   RabbitMQ     | <------+                |
                         +----------------+                         |
                                                                   |
+----------------------+                                          |
|  api-gateway-app     |  <---> all services (via proxy)          |
+----------------------+
```

## 🛠️ Technologies utilisées

| Outil/Technologie     | Rôle                                           |
|------------------------|------------------------------------------------|
| **Kubernetes (K3s)**   | Orchestration des services                     |
| **Vagrant**            | Provisionnement des VM locales                 |
| **Docker**             | Conteneurisation des applications              |
| **Flask**              | Framework web pour les microservices          |
| **PostgreSQL**         | Base de données relationnelle                  |
| **RabbitMQ**           | File de messages (Message Broker)             |
| **kubectl**            | Interface CLI pour interagir avec Kubernetes  |
| **HPA**                | Auto-scaling basé sur la consommation CPU      |
| **Kubernetes Secrets** | Gestion sécurisée des credentials              |


## 🖥️ Prérequis
- Docker
- Vagrant
- VirtualBox
- kubectl
- Accès à Docker Hub

## 📁 Structure du dépôt
```
.
├── Dockerfiles/           # Dockerfiles pour chaque service
├── Manifests/             # YAMLs pour déploiement K8s
├── Scripts/
│   ├── orchestrator.sh    # Script de gestion du cluster
│   └── deploy-all.sh      # Déployer tous les manifests
├── Vagrantfile            # Provisionnement K3s master/agent
└── README.md              # Documentation complète
```

## ⚙️ Configuration & Lancement
1. Cloner le projet
```
git clone https://learn.zone01dakar.sn/git/mouhameddiouf/orchestrator.git
cd orchestrator
code . -r
```
2. Lancer le cluster
```
bash script/./orchestrator create
```
3. Se connecter
```
vagrant ssh master
```
4. Appliquer les manifests
```
bash /vagrant/scripts/./deploy-all.sh
```
5. Vérifier les nodes
```
kubectl get nodes
```
6. Vérifier les pods
```
kubectl get pods
```
7. Ouvrir un tunnel
- attendre que tous les pods soient en Running
- ouvrir un deuxiéme terminal
    - vagrant ssh master
        - kubectl port-forward --address 0.0.0.0 deployment/api-gateway-app 3000:3000
- revenir au premier terminal pour lancer les requetes (ou ouvrir directement postman)

8. Requetes
- POST vers /api/billing
```
curl -X POST http://192.168.56.10:3000/api/billing/ \
  -H "Content-Type: application/json" \
  -d '{"user_id": "2", "number_of_items": "98", "total_amount": "57"}'
```

- POST vers /api/movies
```
curl -X POST http://192.168.56.10:3000/api/movies \
-H "Content-Type: application/json" \
-d '{"title": "Real Madrid", "description": "ewuipe bou mak bi"}'
```

- GET vers /api/movies
```
curl http://192.168.56.10:3000/api/movies
```

## Commandes utiles:
- couper billing-app
    - kubectl scale statefulset billing-app --replicas=0
- retester avec postamn et voir si ça fonctionne toujours

## 📈 Auto-scaling (HPA)
Deux services utilisent HorizontalPodAutoscaler :

| Service       | Min Pods | Max Pods | Seuil CPU |
|---------------|----------|----------|------------|
| api-gateway   | 1        | 3        | 60%        |
| inventory-app | 1        | 3        | 60%        |


## 🧪 Endpoints principaux

| Service       | URL                                      | Méthode         |
|---------------|------------------------------------------|------------------|
| API Gateway   | http://<cluster-ip>:3000/api/movies      | GET / POST / etc |
| Billing Queue | http://<cluster-ip>:3000/api/billing     | POST             |


## 🤖 Script Orchestrator
- bash script/./orchestrator.sh create   # Crée les VM et le cluster
- bash script/./orchestrator.sh start    # Démarre le cluster
- bash script/./orchestrator.sh stop     # Stoppe le cluster
- bash script/./orchestrator.sh destroy  # Détruire le cluster
- etc.


## Auteur
- **Nom** : Mouhamed DIOUF
- **GitHub** : [mouhameddiouf](https://github.com/seydi-ahmed)
- **Email** : seydiahmedelcheikh@gmail.com
- **Numéro** : +221776221681
- **Réseaux** : [LinkedIn](https://linkedin.com/in/mouhamed-diouf-435207174)

