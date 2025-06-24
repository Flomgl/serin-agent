.PHONY: install

install:
	@echo "➡️ Téléchargement et installation de Flamingo v0.0.20..."

	# Création du dossier
	sudo mkdir -p /opt/flamingo

	# Téléchargement fiable via wget
	sudo wget -O /opt/flamingo/flamingo https://github.com/atredispartners/flamingo/releases/download/v0.0.20/flamingo-linux-amd64

	# Rendre exécutable
	sudo chmod +x /opt/flamingo/flamingo

	# Créer utilisateur système s'il n'existe pas
	sudo useradd -r -s /bin/false flamingo || true

	# Créer dossier de logs
	sudo mkdir -p /var/log/flamingo
	sudo chown flamingo:flamingo /var/log/flamingo

	# Donner les capabilities (ports <1024 sans root)
	sudo setcap 'cap_net_bind_service=+ep' /opt/flamingo/flamingo

	# Copier le service systemd
	sudo cp flamingo.service /etc/systemd/system/

	# (Re)charger systemd
	sudo systemctl daemon-reexec
	sudo systemctl daemon-reload
	sudo systemctl enable flamingo --now

	@echo "✅ Flamingo installé et démarré avec succès."
