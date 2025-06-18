# serin-agent
Agent du projet canari
# 🐤 Serin — Agent Canari de Détection Passive d’Intrusion

**Serin** est un système d’agents canaris conçu pour détecter de manière passive toute activité réseau malveillante. Chaque agent est déployé automatiquement sur une machine Linux et permet de capturer des comportements anormaux via des services appâts et une remontée centralisée des logs.

---

## 🎯 Objectifs

- Déploiement **automatisé** sur les machines Linux (Debian, Ubuntu, RedHat)
- Détection passive par exposition de services simulés
- Remontée des logs vers un serveur central Loki
- Visualisation dans Grafana par tableaux de bord personnalisés
- Mise à jour automatique quotidienne via `git pull`

---

## 🛠️ Technologies utilisées

| Composant   | Rôle                                    |
|-------------|------------------------------------------|
| Flamingo    | Simule des services exposés (SSH, FTP...) et capture les connexions |
| Promtail    | Collecte et envoie les logs vers Loki    |
| Samba       | Simule un partage Windows vulnérable     |
| Grafana     | Interface de visualisation des logs      |
| Makefiles   | Orchestration du déploiement             |

---

## 📁 Structure du projet

```bash
serin-agent/
├── Makefile                   # Déploiement global
├── flamingo/
│   ├── Makefile
│   └── flamingo.service
├── promtail/
│   ├── Makefile
│   ├── promtail.service
│   ├── config-template.yml
│   └── heartbeat.sh
├── samba/
│   ├── Makefile
│   └── smb.conf
├── common/
│   ├── hostname_config.sh
│   └── git_pull.sh
└── README.md
⚙️ Prérequis

Sur chaque machine cible :

sudo apt install git make curl unzip -y

    Pour RedHat : utiliser dnf install à la place de apt install.

🚀 Installation

Cloner et exécuter :

git clone https://github.com/Flomgl/serin-agent.git /opt/serin-agent
cd /opt/serin-agent
sudo make all

Ce que fait le script :

    Configure le hostname automatiquement

    Installe Flamingo, Promtail et Samba

    Active les services avec systemd

    Crée un log heartbeat toutes les heures pour surveillance passive

🔄 Mise à jour automatique

Chaque machine vérifie les mises à jour du dépôt tous les jours via :

/etc/cron.daily/git_pull

Si le code du dépôt a changé, les Makefiles se relancent automatiquement.
🔐 Sécurité intégrée

    Services tournent sous utilisateurs non-root

    Flamingo utilise setcap pour écouter les ports bas sans privilèges

    Samba isolé et restreint

    NetBIOS désactivé par défaut

    Communication sécurisée avec Loki via proxy

📊 Visualisation des logs

    Serveur Loki : http://10.200.26.220:3100

    Interface Grafana : http://10.200.26.220:3000

    Accès : un dashboard par direction

    Notifications par email configurables dans Grafana

🔧 Exemple de logs capturés

    Tentative de connexion SSH sur port 22

    Scan de ports FTP, DNS, LDAP

    Tentative de connexion Samba

    Requêtes avec credentials suspects

    Signal de heartbeat toutes les heures

📫 Auteurs et crédits

Ce projet est mené dans le cadre d’un mémoire de fin d’études au sein du CNFPT
🔧 Responsable technique : Florian MAGLOIRE
🔗 Dépôt : github.com/Flomgl/serin-agent
📜 Licence

MIT — Libre d’utilisation et de modification à des fins de cybersécurité défensive uniquement.


---


