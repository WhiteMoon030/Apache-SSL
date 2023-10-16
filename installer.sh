#!/usr/bin/bash
# Installer Skript zum installieren vom Apache-Webserver
# Überprüfen ob das Skript als Administrator ausgeführt wird
if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    echo "Bitte führen Sie dieses Skript mit Administratorrechten aus (sudo/root)!"
    exit 1
fi
# Falls ja, Installation starten
echo "Starte Installation von Apache Webserver..."
sleep 2
# Prüfen ob das Paket "apache2" bereits installiert ist
if ! dpkg -s apache2 > /dev/null; then
  # Falls nicht -> Apache2 installieren
  sudo apt update
  sudo apt install -y apache2
  echo "Installation Erfolgreich abgeschlossen!"
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
  echo "Der Apache Webserver ist bereits installiert!"
  exit 1
fi
# Firwall konfigurieren
echo "Firewall konfigurieren..."
sleep 1
sudo ufw allow 80
sudo ufw allow 443
# ServerName in der Apache Konfiguration festlegen
echo "Server Namen festlegen..."
sleep 1
sudo sh -c 'echo "ServerName 127.0.0.1" >> /etc/apache2/apache2.conf'
sudo systemctl restart apache2
firefox $(hostname -I | awk '{print $1}')
exit 0
