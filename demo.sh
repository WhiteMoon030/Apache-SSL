#!/usr/bin/bash
# Demo Skript
# Erstellt für http und https zwei verschieden html Dateien
# Demo-html-Dateien in /var/www/html verschieben
pfad=$(pwd)
sudo cp -r $pfad/demo/sicher/ /var/www/html
sudo cp -r $pfad/demo/unsicher/ /var/www/html
# Virtual Hosts in der Apache konfigurieren
# -z um die Datei in einer Zeile einzulesen
# |1 um das erste auftauchen von /var/www/html zu überschreiben, |2 für das zweite auftreten zu überschreiben
echo "Demo konfigurieren..."
sleep 1
sudo sed -i -z 's|/var/www/html|/var/www/html/unsicher|1' /etc/apache2/sites-enabled/000-default.conf
sudo sed -i -z 's|/var/www/html|/var/www/html/sicher|1' /etc/apache2/sites-enabled/apassl.conf
# Apache neustarten
echo "Apache neustarten..."
sleep 1
sudo systemctl restart apache2
firefox $(hostname -I | awk '{print $1}')
firefox -new-tab https://$(hostname -I | awk '{print $1}')
exit 0
