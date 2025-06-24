#!/bin/bash

SHARE_DIR="/srv/samba/share"
DATE=$(date +"%Y%m%d")

# Créer le dossier s'il n'existe pas
if [ ! -d "$SHARE_DIR" ]; then
  echo "📁 Création du dossier de partage $SHARE_DIR..."
  sudo mkdir -p "$SHARE_DIR"
fi

echo "📄 Création de faux fichiers nommés selon le protocole..."

# Fichiers avec nommage YYYYMMDD_75_<nom>
sudo tee "$SHARE_DIR/${DATE}_75_motdepasse.txt" > /dev/null <<EOF
admin:1234
florian:azerty123
EOF

sudo tee "$SHARE_DIR/${DATE}_75_budget_2025.xlsx" > /dev/null <<EOF
[Données budgétaires fictives]
EOF

sudo tee "$SHARE_DIR/${DATE}_75_todo_securite.txt" > /dev/null <<EOF
- Réviser les logs canaris
- Vérifier accès SSH suspects
- Synchroniser avec Loki
EOF

sudo tee "$SHARE_DIR/${DATE}_75_annuaire_CN.txt" > /dev/null <<EOF
Liste partielle - confidentiel
EOF

# Metadonnées anciennes pour renforcer l'illusion
sudo touch -d "2024-12-01" "$SHARE_DIR/${DATE}_75_budget_2025.xlsx"
sudo touch -d "2025-01-05" "$SHARE_DIR/${DATE}_75_annuaire_CN.txt"

# Droits d'accès anonymes
sudo chmod -R 0777 "$SHARE_DIR"

echo "✅ Fichiers appâts crédibles générés dans $SHARE_DIR"
