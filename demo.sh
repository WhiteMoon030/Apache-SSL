#!/usr/bin/bash
# Demo Skript
# Erstellt für http und https zwei verschieden html Dateien
# Überprüfen ob das Skript als Administrator ausgeführt wird
if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    echo "Bitte führen Sie dieses Skript mit Administratorrechten aus (sudo/root)!"
    exit 1
fi
# Virtual Hosts in der Apache konfigurieren
exit 0
