.PHONY: install

install:
	@echo "➡️ Installation de Promtail..."
	sudo mkdir -p /opt/promtail
	curl -L -o promtail.zip https://github.com/grafana/loki/releases/latest/download/promtail-linux-amd64.zip
	sudo dnf install -y unzip curl
	unzip -o promtail.zip -d /opt/promtail
	sudo chmod +x /opt/promtail/promtail-linux-amd64

	# Crée l’utilisateur système promtail s’il n’existe pas
	@id promtail >/dev/null 2>&1 || sudo useradd -r -s /sbin/nologin promtail

	sudo cp promtail.service /etc/systemd/system/
	sudo cp config-template.yml /opt/promtail/promtail.yml
	sudo cp heartbeat.sh /opt/promtail/heartbeat.sh
	sudo chmod +x /opt/promtail/heartbeat.sh

	sudo touch /var/log/serin-heartbeat.log
	sudo chown promtail:promtail /var/log/serin-heartbeat.log

	sudo systemctl daemon-reload
	sudo systemctl enable promtail --now

	@echo "✅ Promtail installé et lancé."
