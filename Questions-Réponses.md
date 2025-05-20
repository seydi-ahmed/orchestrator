# Questions / Réponses:
## Partie 1:
1) Qu’est-ce que l’orchestration de conteneurs et ses avantages?
- L’orchestration de conteneurs, c’est le fait de gérer automatiquement le déploiement, le démarrage, l’arrêt, la mise à jour et le bon fonctionnement de plusieurs conteneurs (Docker, par exemple) sur un ou plusieurs serveurs.
- Ses avantages:
    - Lancement automatique des conteneurs.
    - Répartition de la charge entre plusieurs machines.
    - Redémarrage automatique des services en cas de problème.
    - Mises à jour facilitées (rolling updates).
    - Scalabilité (ajouter ou retirer des conteneurs selon le besoin).

2) Qu’est-ce que Kubernetes(K8s) et son rôle principal?
- Kubernetes est un outil d’orchestration de conteneurs open-source développé à l’origine par Google. C’est le standard pour gérer des applications en conteneurs à grande échelle.
- Son rôle principal:
    - Automatiser le déploiement, la gestion et la montée en charge (scaling) des applications en conteneurs.

3) Qu’est-ce que K3s et son rôle principale?
- K3s est une version légère de Kubernetes, développée par Rancher (SUSE). Il est conçu pour être plus simple, plus léger et plus rapide à installer et à exécuter, notamment sur des petits serveurs, des environnements de développement, ou de l’edge computing (Raspberry Pi, IoT, etc.).
- Son rôle principal :
    - Fournir les mêmes fonctionnalités que Kubernetes, mais de façon plus légère et facile à déployer, surtout dans des environnements limités en ressources.

## Parie 2:
1) Qu’est-ce que l’Infrastructure as Code (IaC) et ses avantages?
- L’Infrastructure as Code (IaC) consiste à définir et gérer l’infrastructure (serveurs, réseaux, bases de données, etc.) avec du code plutôt qu’en le faisant manuellement.
- Par exemple : au lieu de configurer un serveur à la main, on écrit un fichier (souvent YAML, JSON, ou en langage comme Terraform) qui décrit ce que l’on veut, et l’outil s’en charge automatiquement.
- Ses avantages:
- Automatisation des déploiements.
- Reproductibilité: on peut recréer le même environnement à l’identique.
- Versionning: on garde l’historique dans Git.
- Moins d’erreurs humaines.
- Gain de temps et cohérence entre les environnements (dev/test/prod).

2) Qu’est-ce qu’un manifest Kubernetes?
- Un manifest Kubernetes est un fichier YAML qui décrit un objet à créer dans un cluster Kubernetes (comme un pod, un service, un déploiement…).
- C’est un exemple d’Infrastructure as Code, mais spécifique à Kubernetes.

3) Explication des principaux manifests Kubernetes: Voici les manifests les plus courants.
- Pod
    - Le plus petit objet.
    - Contient un ou plusieurs conteneurs (souvent un seul).
- Deployment
    - Permet de déployer automatiquement plusieurs Pods, avec gestion des mises à jour.
    - Kubernetes gère les restarts, les rollbacks, le scaling.
- Service
    - Permet de donner une adresse stable aux Pods.
    - Il expose l’application sur un port, souvent pour permettre l’accès depuis l’extérieur.
- ConfigMap
    - Sert à fournir des variables de configuration (clé/valeur) aux Pods.
- Secret
    - Comme ConfigMap, mais pour des données sensibles (mot de passe, token…).
    - Encodé en base64.
- Ingress
    - Gère les règles d’accès HTTP à l’extérieur du cluster.
    - Expose plusieurs services sous différents noms de domaine ou chemins.