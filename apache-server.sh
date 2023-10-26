#!/usr/bin/bash
# Installer Skript zum installieren vom Apache-Webserver
echo "Starte Installation von Apache Webserver..."
# Variablen für farbige Konsolenausgabe
Red='\033[1;91m'
Green='\033[1;92m'
Default='\033[0m' 
sleep 2
# Prüfen ob das Paket "apache2" bereits installiert ist
# dpkg (Debian Package) prüft mit dem Parameter -s den Status eines bestimmten Pakets
if ! dpkg -s apache2 > /dev/null; then
  # Falls nicht -> Apache2 installieren
  sudo apt update
  sudo apt install -y apache2
  echo -e "${Green}Installation erfolgreich abgeschlossen!${Default}"
  # Prüfen ob der Apache-Service in systemd enabled ist
  status=$(sudo systemctl is-enabled apache2)
  if [ %status = "disabled" ]; then
    sudo systemctl enable apache2
    echo "Apache2 enabled!"
  else
    echo "Apache2 ist bereits enabled!"
  fi
  # Prüfen ob der Apache-Service in systemd gestartet wurde
  status=$(sudo systemctl is-active apache2)
  if [ %status = "inactive" ]; then
    sudo systemctl start apache2
    echo "Apache2 gestartet!"
  else
    echo "Apache2 ist bereits gestartet!"
  fi
else
  echo -e "${Red}Der Apache Webserver ist bereits installiert!${Default}"
  exit 1
fi
# ufw Firewall konfigurieren falls diese installiert ist
if dpkg -s ufw > /dev/null; then
  # Falls ja --> konfigurieren
  echo "Firewall (ufw) konfigurieren..."
  sleep 1
  # HTTP und HTTPS Port freigeben
  sudo ufw allow 80
  sudo ufw allow 443
fi
# ServerName in der Apache Konfiguration festlegen
echo "Server Namen festlegen..."
sleep 1
sudo sh -c 'echo "ServerName 127.0.0.1" >> /etc/apache2/apache2.conf'
sudo systemctl restart apache2
echo -e "${Green}Einrichtung abgeschlossen!${Default}"
exit 0
