#!/usr/bin/bash
# Demo Skript
# Erstellt für http und https zwei verschieden html Dateien
# Überprüfen ob das Skript als Administrator ausgeführt wird
if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    echo "Bitte führen Sie dieses Skript mit Administratorrechten aus (sudo/root)!"
    exit 1
fi
# Demo-html-Dateien in /var/www/html verschieben
pfad=$(pwd)
cp -r $pfad/demo/sicher/ /var/www/html
cp -r $pfad/demo/unsicher/ /var/www/html
# Virtual Hosts in der Apache konfigurieren
exit 0
