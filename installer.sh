#!/usr/bin/bash
# Installer Skript zum installieren von Apache2
# Auf Debian basierten Systemen über den Apt-Paketmanager
echo "Starte Installation von Apache Webserver..."
sleep 2
sudo apt update
# Prüfen ob das Paket "apache2" bereits installiert ist
if ! dpkg -s apache2 > /dev/null; then
  sudo apt install -y apache2
  echo "Installation Erfolgreich abgeschlossen!"
else
  echo "Der Apache Webserver ist bereits installiert!"
fi
