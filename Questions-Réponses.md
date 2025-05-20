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