#!/bin/bash

ROOT_PASS="$1"
DB_NAME="$2"
DB_USER="$3"
DB_PASS="$4"
LOG="$5"

if [ "$#" -ne 5 ]; then
  echo "Utilisation : sudo ./install_mariadb.sh \"Root123!\" \"app_interne\" \"app_user\" \"User123!\" \"install_mariadb.log\""
  exit 1
fi

if [ "$EUID" -ne 0 ]; then
  echo "Erreur : le script doit être exécuté avec sudo."
  exit 1
fi

echo "===== Début installation MariaDB =====" >> "$LOG"

echo "Mise à jour des paquets..." >> "$LOG"
apt update >> "$LOG" 2>> "$LOG"

echo "Installation de MariaDB..." >> "$LOG"
apt install mariadb-server -y >> "$LOG" 2>> "$LOG"

echo "Démarrage du service MariaDB..." >> "$LOG"
systemctl start mariadb >> "$LOG" 2>> "$LOG"

echo "Activation de MariaDB au démarrage..." >> "$LOG"
systemctl enable mariadb >> "$LOG" 2>> "$LOG"

echo "Sécurisation de MariaDB..." >> "$LOG"

mariadb <<EOF >> "$LOG" 2>> "$LOG"
ALTER USER 'root'@'localhost' IDENTIFIED BY '$ROOT_PASS';
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost');
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
FLUSH PRIVILEGES;
EOF

echo "Création de la base et de l'utilisateur..." >> "$LOG"

mariadb -u root -p"$ROOT_PASS" <<EOF >> "$LOG" 2>> "$LOG"
CREATE DATABASE IF NOT EXISTS $DB_NAME;
CREATE USER IF NOT EXISTS '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASS';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'localhost';
FLUSH PRIVILEGES;
EOF

echo "Vérification du service MariaDB..." >> "$LOG"
systemctl status mariadb --no-pager >> "$LOG" 2>> "$LOG"

echo "===== Installation terminée =====" >> "$LOG"

echo "Installation terminée. Consulte le fichier log : $LOG"