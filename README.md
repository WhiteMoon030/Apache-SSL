# Apache-SSL
## Funktionsweise
Dieses Projekt hat zum Ziel, eine automatische Installation vom Apache-Webserver inklusive SSL Zertifikat mithilfe von Shellskripten zu gewährleisten.
Dazu stellt dieses Repository drei Skripte zur Verfügung:
* installer.sh
* add_ssl.sh
* demo.sh
### installer.sh
Installiert den Apache-Webserver über den Apt-Paketmanager und enabled und startet ihn automatisch über systemd. Zusätzlich werden die Ports
80 und 443 in ufw freigeben.
### add_ssl.sh
Erstellt im gleichen Ordner ein selbst signiertes SSL-Zertifikat und bindet dieses automatisch in die Apache-Konfiguration ein.
### demo.sh
Kopiert die Demo-Html Dateien in /var/www/html und konfiguriert den Apache Webserver so das die http und https Seite unterschiedliche Inhalte anzeigen.
## Wichtige Hinweise
Obwohl mithilfe des *add_ssl.sh* Skriptes eine vollständiges gültiges SSL-Zertifkat erstellt wird, so zeigen doch die meisten
Browser eine Warnung beim betreten der https-Seite an. Dies ist dadrin begründet, dass hier ein selbst signiertes Zertifikat verwendet wird
und die meisten Browser nur SSL-Zertifkate die von offiziellen Institutionen signiert wurden, als sicher einstufen.
Wenn Apache auf einer virtuellen Maschine installiert wird, dann muss für diese eine Netzwerkbrücke als Netzwerkinterface konfiguriert werden.
Dies hat den Hintergrund das, wenn als Netzwerkinterface NAT konfiguriert wurde, der Apache Webserver nur lokal in der VM zu erreichen ist.
