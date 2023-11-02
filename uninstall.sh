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
	# Überprüfen ob /etc/apache2 und /var/www wirklich gelöscht wurden
	if [ -d "/etc/apache2"]; then
		sudo rm -fr /etc/apache2
	fi
	if [ -d "/var/www"]; then
		sudo rm -fr /var/www
	fi
	echo -e "${Green}Apache-Webserver erfolgreich deinstalliert!${Default}"
	sleep 1
fi
