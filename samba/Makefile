.PHONY: install

install:
	@echo "➡️ Installation de Samba..."
	sudo apt install samba samba-common samba-client -y

	@echo "📁 Création du répertoire de partage..."
	sudo mkdir -p /srv/samba/share
	sudo chmod -R 0777 /srv/samba/share
	sudo chown -R nobody:nobody /srv/samba/share

	@echo "🧾 Déploiement du fichier de configuration Samba..."
	sudo cp smb.conf /etc/samba/smb.conf

	@echo "🔐 Configuration d’un utilisateur fictif Samba..."
	sudo useradd -M -s /sbin/nologin smbcanafront || true
	echo -e "MotDePasseBidon\nMotDePasseBidon" | sudo smbpasswd -a smbcanafront

	@echo "📦 Droits sur le dossier partagé..."
	sudo mkdir -p /home/cana/partage
	sudo chown -R smbcanafront:smbcanafront /home/cana/partage
	sudo chmod -R 770 /home/cana/partage

	@echo "🛡️ Désactivation de NetBIOS..."
	sudo systemctl stop nmb
	sudo systemctl disable nmb

	@echo "🔌 Activation de Samba..."
	sudo systemctl daemon-reload
	sudo systemctl enable smb --now

	@echo "✅ Samba installé et activé avec un partage appât."
