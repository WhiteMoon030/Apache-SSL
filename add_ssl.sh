#!/usr/bin/bash
# Erstellen eines signierten SSL Zertifikates
echo "Starte Erstellung eines SSL Zertifikates..."
sleep 2

# IP-Adresse in einer Variable speichern
ip=$(hostname -I | awk '{print $1}')
echo "Deine IP:" $ip
sleep 1

# Neuen Ordner für die Zertifikats Dateien erstellen
echo "Neuer Ordner erstellt..."
mkdir Zertifikat

# Pfad zu den Dateien in einer Variable speichern
pfad=$(pwd)/Zertifikat

# Schritt 1. SSL Key erstellen
sleep 1
echo "SSL Key erstellen..."
sleep 1
openssl genrsa -out server.key 2048

# Schritt 2. Signing Request mit dem Key erstellen
sleep 1
echo "Signing Request erstellen..."
sleep 1
openssl req -new -key server.key -out server.csr

# Schritt 3. Zertifikat für 365 Tage signieren
sleep 1
echo "Signing Request erstellen..."
sleep 1
openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt
echo "Zertifikat erstellt!"
