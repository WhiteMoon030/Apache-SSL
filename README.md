# Apache-SSL
## Funktionsweise
Dieses Projekt hat zum Ziel, eine automatische Installation vom Apache-Webserver inklusive SSL Zertifikat mithilfe von Shellskripten zu gewährleisten.
Dazu stellt dieses Repository zwei Skripte zur Verfügung:
* installer.sh
* add_ssl.sh
### installer.sh
Installiert den Apache-Webserver über den Apt-Paketmanager und enabled und startet ihn automatisch über systemd. \
**Muss mit root-Rechten ausgeführt werden!**
### add_ssl.sh
Erstellt im gleichen Ordner ein selbst signiertes SSL-Zertifikat und bindet dieses automatisch in die Apache-Konfiguration ein. \
**Muss mit root-Rechten ausgeführt werden!**
## Wichtige Hinweise
Obwohl mithilfe des *add_ssl.sh* Skriptes eine vollständiges gültiges SSL-Zertifkat erstellt wird, so zeigen doch die meisten
Browser eine Warnung beim betreten der https-Seite an. Dies ist dadrin begründet, dass hier ein selbst signiertes Zertifikat verwendet wird
und die meisten Browser nur SSL-Zertifkate die von offiziellen Institutionen signiert wurden, als sicher einstufen.
