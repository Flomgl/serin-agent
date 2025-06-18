.PHONY: all update flamingo promtail samba

all: update flamingo promtail samba

update:
	sudo apt update -y && sudo apt upgrade -y
	sudo apt install unzip curl -y
	sudo cp common/hostname_config.sh /usr/local/bin/
	sudo bash /usr/local/bin/hostname_config.sh
	sudo cp common/git_pull.sh /etc/cron.daily/git_pull
	chmod +x /etc/cron.daily/git_pull

flamingo:
	$(MAKE) -C flamingo install

promtail:
	$(MAKE) -C promtail install

samba:
	$(MAKE) -C samba install
