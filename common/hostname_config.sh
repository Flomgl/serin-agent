#!/bin/bash
echo "Entrer le nom de la machine (ex: canari-dsi-lyon):"
read hostname
hostnamectl set-hostname "$hostname"
