#!/bin/bash

echo "===[ Simulation d'attaques pour OpenCanary à 10.200.26.219 ]==="

# FTP - test d'identifiants
echo "[+] Test FTP (login faux)..."
ftp -inv 10.200.26.219 <<EOF
user eviluser supersecret
bye
EOF

# HTTP - accès bidon
echo "[+] Test HTTP (curl vers honeypot)..."
curl -s http://10.200.26.219:80/fakepage -A "Mozilla/5.0 (CanaryAgent)" > /dev/null

# HTTPS - endpoint bidon
echo "[+] Test HTTPS..."
curl -sk https://10.200.26.219:443/login -d "user=hacker&pass=badpass" > /dev/null

# SSH - tentative échouée
echo "[+] Test SSH..."
ssh -o BatchMode=yes -o ConnectTimeout=3 test@10.200.26.219 exit || echo "SSH attendu en échec"

# MySQL - ping du port avec netcat
echo "[+] Test MySQL avec netcat..."
(echo "SHOW DATABASES;" | nc -w 2 10.200.26.219 3306) || echo "MySQL test échec ou nc absent"

# Telnet - connexion bidon
echo "[+] Test Telnet..."
(echo "GET / HTTP/1.0\n" | telnet 10.200.26.219 23) || echo "Telnet test échec ou telnet non installé"

# SNMP - requête bidon (si snmpwalk dispo)
if command -v snmpwalk >/dev/null 2>&1; then
  echo "[+] Test SNMP..."
  snmpwalk -v2c -c public 10.200.26.219
else
  echo "[!] SNMP non installé (snmpwalk manquant)"
fi

# ✅ Test IDS externe via DNS (trigger pour Suricata, Wazuh ou autres)
echo "[+] Test IDS via testmyids.com (génère un domaine DNS piégé)..."
curl -s http://testmyids.com > /dev/null

echo "[✔] Tests terminés. Consultez vos logs OpenCanary ou Grafana (Promtail/Loki)."
