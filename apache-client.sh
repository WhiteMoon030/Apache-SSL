#!/usr/bin/bash
# Client Skript zur Überprüfung ob ein Browser(Firefox) installiert ist
# und zum testweisen Aufrufen der über Apache gehosteten Webseite

# Variablen für farbige Konsolenausgabe
Red='\033[1;91m'
Green='\033[1;92m'
Default='\033[0m' 

# Überprüfen ob Firefox installiert ist
if ! dpkg -s firefox > /dev/null; then
  # Falls nicht -> Firefox installieren
  echo -e "${Red}Firefox ist nicht installiert!${Default}"
  sleep 1
  echo "Installiere Firefox..."
  sleep 1
  sudo apt update
  sudo apt install firefox
else
  # Falls doch -> Meldung ausgeben
  echo "Firefox ist bereits installiert!"
  sleep 1
fi

# Fragen ob eine lokale oder externe Verbindung getestet werden soll
# Eingabe in einer Variable speichern
read -p "Externe oder lokale Verbindung testen [e/l]: " eingabeEL
if [ $eingabeEL = "e" ]; then
  # IP-Adresse des Zielsystems abfragen
  read -p "IP-Adresse oder Domain(FQDN): " eingabeIP
  echo "Verbindung testen..."
  sleep 1
  firefox http://$eingabeIP
elif [ $eingabeEL = "l" ]; then
  # Überprüfen ob der Apache Webserver installiert ist
  if ! dpkg -s firefox > /dev/null; then
    # Falls nicht -> Fehlermeldung
    echo -e "${Red}Der Apache-Webserver ist auf dem lokalen System nicht installiert!${Default}"
    exit 1
  fi
  # Überprüfen ob der Apache Webserver läuft
  status=$(sudo systemctl is-active apache2)
  if [ $status = "inactive" ]; then
    echo -e "${Red}Der Apache-Webserver ist nicht aktiv!${Default}"
    sleep 1
    echo "Starte Apache-Webserver..."
    sleep 1
    sudo systemctl start apache2
  fi
  echo "Verbindung testen..."
  sleep 1
  firefox http://localhost
else
  # Fehlermeldung und beenden wenn kein zulässiger Buchstabe eingegeben wurde
  echo -e "${Red}Fehlerhafte Eingabe!${Default}"
  exit 1
fi
exit 0
