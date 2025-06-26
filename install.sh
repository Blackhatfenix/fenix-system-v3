#!/bin/bash

# FENIX-SYSTEM-V3 - INSTALADOR AUTOMÁTICO SUPREMO
# Para que houvesse paz, houve guerra.

banner() {
  clear
  echo ""
  echo "===============================================" | lolcat
  figlet -f slant "FENIX SYSTEM V3" | lolcat
  echo "===============================================" | lolcat
  echo "MAIOR PAINEL DE FERRAMENTAS HACKER PARA TERMUX" | lolcat
  echo ""
}

banner

echo "[1/6] Atualizando o Termux..." | lolcat
pkg update -y && pkg upgrade -y

# Dependências gerais
echo "[2/6] Instalando pacotes essenciais..." | lolcat
pkg install -y git python python2 wget curl nmap openssh php figlet toilet ruby \
  termux-api tsu proot tmux nano dnsutils net-tools \
  dialog tree unzip clang jq coreutils grep sed

pip install lolcat colorama requests

# Criando estrutura do sistema
echo "[3/6] Estruturando diretórios do sistema..." | lolcat
mkdir -p ~/FENIX/tools
mkdir -p ~/FENIX/logs
mkdir -p ~/FENIX/output

cd ~/FENIX/tools

# Lista de ferramentas para clonar automaticamente
repos=(
  "https://github.com/sherlock-project/sherlock"
  "https://github.com/mxrch/GHunt"
  "https://github.com/Datalux/Osintgram"
  "https://github.com/m4ll0k/Infoga"
  "https://github.com/soxoj/maigret"
  "https://github.com/laramies/metagoofil"
  "https://github.com/xHak9x/finduser"
  "https://github.com/haqplk/PhoneInfoga"
  "https://github.com/sqlmapproject/sqlmap"
  "https://github.com/1N3/Sn1per"
  "https://github.com/lgandx/Responder"
  "https://github.com/initstring/linkedin2username"
  "https://github.com/Ekultek/WhatWaf"
  "https://github.com/Tuhinshubhra/RED_HAWK"
  "https://github.com/UltimateHackers/ReconDog"
  "https://github.com/thewhiteh4t/seeker"
  "https://github.com/th3unkn0n/Trackers"
  "https://github.com/DanMcInerney/net-creds"
  "https://github.com/UndeadSec/SocialFish"
  "https://github.com/Dionach/CMSmap"
  "https://github.com/04x/SEEK"
  "https://github.com/Ranginang67/Fsociety"
  "https://github.com/rajkumardusad/IP-Tracer"
  "https://github.com/maldevel/IPGeoLocation"
  "https://github.com/k4m4/kickthemout"
)

echo "[4/6] Clonando ferramentas..." | lolcat
for repo in "${repos[@]}"; do
  echo "Clonando: $repo" | lolcat
  git clone "$repo"
done

# Download de ferramentas adicionais
echo "[5/6] Baixando complementos..." | lolcat
wget -O ~/FENIX/fenix.sh "https://raw.githubusercontent.com/Blackhatfenix/fenix-system-v3/main/fenix.sh"
chmod +x ~/FENIX/fenix.sh

echo "[6/6] Instalação concluída com sucesso!" | lolcat
sleep 1
clear
banner

echo "Digite o comando abaixo para iniciar o FENIX SYSTEM:" | lolcat
echo "cd ~/FENIX && ./fenix.sh" | lolcat

