#!/bin/bash
set -e

# Beispiel: Anlegen eines SMB Users (Name und Passwort via ENV-Variablen)
# Du könntest auch mehrere User anlegen oder via env-Datei steuern
if [ -n "$SMB_USER" ] && [ -n "$SMB_PASSWORD" ]; then
    echo ">> Creating user: $SMB_USER"
    useradd -M -s /sbin/nologin "$SMB_USER" || true
    echo -e "$SMB_PASSWORD\n$SMB_PASSWORD" | smbpasswd -a -s "$SMB_USER"
fi

# Falls du weitere Aktionen brauchst (Ordner anlegen, Rechte setzen, etc.)
mkdir -p /share
chown "$SMB_USER":"$SMB_USER" /share
chmod 2770 /share

# Danach den eigentlichen CMD-Befehl ausführen
exec "$@"
