.PHONY: install

install:
	@echo "➡️ Installation de Promtail..."
	sudo mkdir -p /opt/promtail
	curl -L -o promtail.zip https://github.com/grafana/loki/releases/latest/download/promtail-linux-amd64.zip
	unzip -o promtail.zip -d /opt/promtail
	sudo chmod +x /opt/promtail/promtail-linux-amd64
	sudo useradd -r -s /bin/false promtail || true
	sudo cp promtail.service /etc/systemd/system/
	sudo cp config-template.yml /opt/promtail/promtail.yml
	sudo cp heartbeat.sh /opt/promtail/heartbeat.sh
	sudo chmod +x /opt/promtail/heartbeat.sh
	sudo touch /var/log/serin-heartbeat.log
	sudo chown promtail:promtail /var/log/serin-heartbeat.log
	sudo systemctl daemon-reload
	sudo systemctl enable promtail --now
	@echo "✅ Promtail installé et lancé."
