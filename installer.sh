# Installer Skript zum installieren von Apache2
# Auf Debian basierten Systemen über den Apt Paketmanager
echo "Starte Installation von Apache Webserver..."
echo "======================================="
sleep 2
sudo apt update
sudo apt install apache2
echo "======================================="
echo "Installation Erfolgreich abgeschlossen!"
