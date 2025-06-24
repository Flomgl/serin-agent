.PHONY: install

install:
	@echo "➡️ Installation de Samba..."
	sudo dnf install -y samba samba-common samba-client

	@echo "📁 Création du répertoire de partage..."
	sudo mkdir -p /srv/samba/share
	sudo chmod -R 0777 /srv/samba/share
	sudo chown -R nobody:nobody /srv/samba/share

	@echo "🧾 Déploiement du fichier de configuration Samba..."
	sudo cp smb.conf /etc/samba/smb.conf

	@echo "🔐 Configuration d’un utilisateur fictif Samba..."
	@id smbcanafront >/dev/null 2>&1 || sudo useradd -M -s /sbin/nologin smbcanafront
	echo -e "MotDePasseBidon\nMotDePasseBidon" | sudo smbpasswd -a smbcanafront

	@echo "📦 Droits sur le dossier partagé..."
	sudo mkdir -p /home/cana/partage
	sudo chown -R smbcanafront:smbcanafront /home/cana/partage
	sudo chmod -R 770 /home/cana/partage

	@echo "🛡️ Désactivation de NetBIOS..."
	sudo systemctl stop nmb.service || true
	sudo systemctl disable nmb.service || true

	@echo "🔌 Activation de Samba..."
	sudo systemctl daemon-reload
	sudo systemctl enable smb --now

	@echo "✅ Samba installé et activé avec un partage appât."
