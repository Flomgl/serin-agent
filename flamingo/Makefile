.PHONY: install

install:
	@echo "➡️ Installation de Flamingo..."
	sudo mkdir -p /opt/flamingo
	sudo curl -L https://github.com/atr3ides/flamingo/releases/latest/download/flamingo-linux-amd64 -o /opt/flamingo/flamingo
	sudo chmod +x /opt/flamingo/flamingo
	sudo useradd -r -s /bin/false flamingo || true
	sudo setcap 'cap_net_bind_service=+ep' /opt/flamingo/flamingo
	sudo mkdir -p /var/log/flamingo
	sudo chown flamingo:flamingo /var/log/flamingo
	sudo cp flamingo.service /etc/systemd/system/
	sudo systemctl daemon-reexec
	sudo systemctl daemon-reload
	sudo systemctl enable flamingo --now
	@echo "✅ Flamingo installé et lancé."

