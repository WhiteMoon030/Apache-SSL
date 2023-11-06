#!/usr/bin/bash
# Skript zum deinstallieren vom Apache-Webserver und alle dazugehörigen Dateien
# inklusive dieses Verzeichnis

# Variablen für farbige Konsolenausgabe
Red='\033[1;91m'
Green='\033[1;92m'
Default='\033[0m'

# Sicherheitsfrage
read -p "Sind Sie sich sicher das Sie den Apache-Webserver deinstallieren möchten? [y/n] " eingabeSicherheit
if [ $eingabeSicherheit = n ]; then
	exit 0
else
	# Deinstallation vom Apache-Webserver und Co.
	echo "Deinstallieren vom Apache-Webserver und allen dazugehörigen Konfigurationsdateien sowie von Abhängigkeiten..."
	sleep 1
	sudo apt autoremove apache2 -y
	sudo apt purge apache2 -y
 	# Firewall Regeln löschen, sofern ufw installiert ist
  	if dpkg -s ufw > /dev/null; then
   		sudo ufw delete allow 80
     		sudo ufw delete allow 443
   	fi
	# Überprüfen ob /etc/apache2, /var/www und /var/lib/apache2 wirklich gelöscht wurden
	if [ -d "/etc/apache2" ]; then
		sudo rm -fr /etc/apache2
	fi
	if [ -d "/var/www" ]; then
		sudo rm -fr /var/www
	fi
 	if [ -d "/var/lib/apache2" ]; then
		sudo rm -fr /var/lib/apache2
	fi
	echo -e "${Green}Apache-Webserver erfolgreich deinstalliert!${Default}"
	sleep 1
fi
