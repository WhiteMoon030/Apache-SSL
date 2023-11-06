#!/usr/bin/bash
# Erstellen eines signierten SSL Zertifikates
echo "Starte Erstellung eines SSL Zertifikates..."
sleep 2

# Prüfen ob bereits ein Ordner für die Zertifikate vorliegt
if [ -d $(pwd)/Zertifikat/ ]
then
  echo "Es existiert bereits ein Zertifikat im gleichen Ordner!"
  exit 1
fi

# IP-Adresse in einer Variable speichern
ip=$(hostname -I | awk '{print $1}')
echo "Deine IP:" $ip
sleep 1

# Neuen Ordner für die Zertifikats Dateien erstellen
echo "Neuer Ordner erstellt..."
mkdir Zertifikat

# Pfad zu den Dateien in einer Variable speichern
pfad=$(dirname "$0")/Zertifikat

# Prüfen ob openssl installiert ist (wird zur Schlüsselerzeugung benötigt)
if ! dpkg -s openssl > /dev/null; then
  echo "Openssl nicht installiert!"
  sleep 1
  echo "Installiere openssl..."
  sleep 1
  sudo apt update
  sudo apt install openssl
  exit 0
fi

# Schritt 1. SSL Key erstellen
sleep 1
echo "SSL Key erstellen..."
sleep 1
openssl genrsa -out $pfad/server.key 2048

# Schritt 2. Signing Request mit dem Key erstellen
sleep 1
echo "Signing Request erstellen..."
sleep 1
openssl req -new -key $pfad/server.key -out $pfad/server.csr -subj "/C=DE/ST=Thueringen/L=Gera/O=DHGE/CN=$ip"

# Schritt 3. Zertifikat für 365 Tage signieren
sleep 1
echo "Zertifikat signieren..."
sleep 1
openssl x509 -req -days 365 -in $pfad/server.csr -signkey $pfad/server.key -out $pfad/server.crt
echo "Zertifikat erstellt!"

# Apache Konfiguration anpassen
if ! dpkg -s apache2 > /dev/null; then
  echo "Apache Webserver nicht installiert, einbinden wird übersprungen!"
  exit 0
fi
sleep 1
echo "Anpassen der Apache Konfiguration..."
sleep 1
# Neue Konfigurationsdatei erzeugen
sudo touch /etc/apache2/sites-available/apassl.conf
# Neuen Virtualhost mit eingebunden SSL Modul erzeugen
echo "<VirtualHost $ip:443>
        ServerName $ip
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/html
          SSLEngine on
          SSLCertificateFile $pfad/server.crt
          SSLCertificateKeyFile $pfad/server.key
          SSLCertificateChainFile $pfad/server.crt
        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>" | sudo tee -a /etc/apache2/sites-available/apassl.conf >/dev/null
sleep 1
echo "Aktivieren des Virtualhosts mit SSL Moduls..."
# SSL Modul herunterladen und aktivieren
sudo a2enmod ssl
# Virtualhost mit SSL aktivieren
sudo a2ensite apassl.conf
sleep 1
echo "Neustarten des Apache Services..."
sleep 1
sudo systemctl restart apache2.service
sleep 1
echo "SSL Zertifkat erfolgreich erstellt und in Apache eingebunden!"
echo "Über folgende Adresse erreichbar: https://"$ip
sleep 1
read -p "Enter drücken um Firefox zu starten..." </dev/tty
firefox https://$ip
exit 0
