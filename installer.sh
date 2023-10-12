#!/usr/bin/bash
# Installer Skript zum installieren von Apache2
# Auf Debian basierten Systemen über den Apt-Paketmanager
echo "Starte Installation von Apache Webserver..."
sleep 2
# Prüfen ob das Paket "apache2" bereits installiert ist
if ! dpkg -s apache2 > /dev/null; then
  # Falls nicht -> Apache2 installieren
  sudo apt update
  sudo apt install -y apache2
  echo "Installation Erfolgreich abgeschlossen!"
  # Prüfen ob der Apache Service in systemd enabled ist
  status=$(sudo systemctl is-enabled apache2)
  if [ %status = "disabled" ]; then
    sudo systemctl enable apache2
    echo "Apache2 enabled!"
  else
    echo "Apache2 ist bereits enabled!"
  fi
  # Prüfen ob der Apache Service in systemd gestartet ist
  status=$(sudo systemctl is-active apache2)
  if [ %status = "inactive" ]; then
    sudo systemctl start apache2
    echo "Apache2 gestartet!"
  else
    echo "Apache2 ist bereits gestartet!"
  fi
else
  echo "Der Apache Webserver ist bereits installiert!"
fi
