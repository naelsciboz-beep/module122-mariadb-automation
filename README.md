# Module 122 – Automatisation de l'installation de MariaDB

## Contexte professionnel

Dans le cadre d'un mandat d'administration système, il est nécessaire de préparer plusieurs serveurs Linux destinés à héberger des applications internes. Afin de gagner du temps et d'éviter les erreurs manuelles, l'installation et la configuration de MariaDB ont été automatisées à l'aide d'un script Bash.

## Objectif du projet

Créer un script Bash permettant :

* d'installer MariaDB ;
* de sécuriser MariaDB ;
* de créer une base de données ;
* de créer un utilisateur MariaDB ;
* d'attribuer les droits nécessaires ;
* de générer un fichier log ;
* d'automatiser l'ensemble de la procédure.

## Paramètres du script

| Paramètre | Description               |
| --------- | ------------------------- |
| $1        | Mot de passe root MariaDB |
| $2        | Nom de la base de données |
| $3        | Nom de l'utilisateur      |
| $4        | Mot de passe utilisateur  |
| $5        | Nom du fichier log        |

## Exemple d'exécution

sudo ./install_mariadb.sh "Root123!" "app_interne" "app_user" "User123!" "install_mariadb.log"

## Actions réalisées

* Mise à jour des paquets
* Installation de MariaDB
* Démarrage du service
* Activation au démarrage
* Sécurisation de MariaDB
* Création de la base de données
* Création de l'utilisateur
* Attribution des droits
* Génération d'un fichier log

## Emplacement du log

logs/install_mariadb.log

## Procédure de test

* Test sans paramètres
* Test avec paramètres valides
* Vérification de l'installation MariaDB
* Vérification du service MariaDB
* Vérification de la base de données
* Vérification de l'utilisateur
* Vérification du fichier log

## Auteur

Thibault
