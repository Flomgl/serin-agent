.PHONY: all update flamingo promtail samba

# Commande principale
all: update flamingo promtail samba

# Étape 1 : Met à jour la machine et installe les outils nécessaires
update:
	@echo "🔄 Mise à jour du système..."
	sudo dnf update -y
	sudo dnf install unzip curl git make cronie -y
	@echo "✅ Dépendances installées."

	@echo "🔧 Configuration du nom de machine..."
	sudo cp common/hostname_config.sh /usr/local/bin/hostname_config.sh
	sudo chmod +x /usr/local/bin/hostname_config.sh
	sudo /usr/local/bin/hostname_config.sh

	@echo "📦 Installation du cron pour mise à jour automatique..."
	sudo cp common/git_pull.sh /etc/cron.daily/git_pull
	sudo chmod +x /etc/cron.daily/git_pull
	sudo systemctl enable --now crond

# Étape 2 : Installation de Flamingo
flamingo:
	@echo "🐤 Déploiement de Flamingo..."
	$(MAKE) -C flamingo install

# Étape 3 : Installation de Promtail
promtail:
	@echo "📦 Déploiement de Promtail..."
	$(MAKE) -C promtail install

# Étape 4 : Installation de Samba
samba:
	@echo "🧲 Déploiement de Samba..."
	$(MAKE) -C samba install
