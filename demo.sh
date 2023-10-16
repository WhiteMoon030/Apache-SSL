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
# -z um die Datei in einer Zeile einzulesen
# |1 um das erste auftauchen von /var/www/html zu überschreiben, |2 für das zweite auftreten zu überschreiben
echo "Demo konfigurieren..."
sleep 1
sed -i -z 's|/var/www/html|/var/www/html/unsicher|1' /etc/apache2/sites-enabled/000-default.conf
sed -i -z 's|/var/www/html|/var/www/html/sicher|2' /etc/apache2/sites-enabled/000-default.conf
# Apache neustarten
echo "Apache neustarten..."
sleep 1
systemctl restart apache2
firefox $(hostname -I | awk '{print $1}')
firefox -new-tab https://$(hostname -I | awk '{print $1}')
exit 0
