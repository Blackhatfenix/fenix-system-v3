#!/data/data/com.termux/files/usr/bin/bash
#
# FENIX SYSTEM V3 – MENU PRINCIPAL
# “PARA QUE HOUVESSE PAZ, TEVE GUERRA”
#

# ── CORES ─────────────────────────────────────
RED='\033[1;31m';  GRN='\033[1;32m'
YLW='\033[1;33m';  BLU='\033[1;34m'
NC='\033[0m'

# ── BANNER ────────────────────────────────────
banner(){
  clear
  printf "\n${YLW}=============================================${NC}\n"
  figlet -f slant "FENIX V3" | lolcat
  printf "${YLW}=============================================${NC}\n\n"
  printf "${GRN}Menu Principal | +40 Ferramentas | +100 Melhorias${NC}\n\n"
}

# ── LOGGING ───────────────────────────────────
LOGDIR=~/FENIX/logs
mkdir -p "$LOGDIR"

# ── CHECK DEPENDÊNCIAS ────────────────────────
deps=(git python3 figlet lolcat dialog tmux nmap)
for d in "${deps[@]}"; do
  command -v $d >/dev/null 2>&1 || {
    echo -e "${RED}Falta: $d${NC}"; exit 1;
  }
done

# ── FUNÇÃO DE EXECUÇÃO stealth/non-stealth ───
run_tool(){
  local cmd="$1"; shift
  if [[ $STEALTH == "y" ]]; then
    eval "$cmd" &> "$LOGDIR/$(date +%Y%m%d_%H%M%S)_$(echo $cmd|cut -c1-10).log"
  else
    eval "$cmd"
  fi
  read -p "Pressione Enter…" dummy
}

# ── MENU ──────────────────────────────────────
menu_main(){
  banner
  echo -e "${YLW}[S] Stealth Mode: ${STEALTH^^}${NC}\n"
  echo -e "${BLU}[1] OSINT Profundo${NC}"
  echo -e "${BLU}[2] Rede / Intranet${NC}"
  echo -e "${BLU}[3] Espionagem Social${NC}"
  echo -e "${BLU}[4] Exploração Avançada${NC}"
  echo -e "${BLU}[5] Toggle Stealth${NC}"
  echo -e "${BLU}[0] Sair${NC}\n"
  read -p "Escolha → " opt
  case $opt in
    1) menu_osint ;;
    2) menu_rede ;;
    3) menu_social ;;
    4) menu_exploit ;;
    5) toggle_stealth ;;
    0) exit 0 ;;
    *) menu_main ;;
  esac
}

# ── Stealth toggle ───────────────────────────
STEALTH="n"
toggle_stealth(){
  [[ $STEALTH == "n" ]] && STEALTH="y" || STEALTH="n"
  menu_main
}

# ── SUBMENUS (exemplo OSINT) ──────────────────
menu_osint(){
  banner
  echo -e "${GRN}→ OSINT Profundo${NC}\n"
  echo "[1] Sherlock"
  echo "[2] GHunt"
  echo "[3] Osintgram"
  echo "[4] Voltar"
  read -p "→ " o
  case $o in
    1) run_tool "cd ~/FENIX/tools/sherlock && python3 sherlock.py fenixuser" ;;
    2) run_tool "cd ~/FENIX/tools/GHunt && python3 ghunt.py email user@gmail.com" ;;
    3) run_tool "cd ~/FENIX/tools/Osintgram && python3 main.py" ;;
    4) menu_main ;;
    *) menu_osint ;;
  esac
  menu_osint
}

menu_rede(){
  banner
  echo -e "${GRN}→ Rede / Intranet${NC}\n"
  echo "[1] Nmap Scan"
  echo "[2] Responder NBT"
  echo "[3] Mimikatz"
  echo "[4] Voltar"
  read -p "→ " o
  case $o in
    1) run_tool "nmap -sS 192.168.0.1/24" ;;
    2) run_tool "cd ~/FENIX/tools/Responder && python3 Responder.py -I wlan0" ;;
    3) run_tool "cd ~/FENIX/tools/Seeker && bash mimikatz.sh" ;;
    4) menu_main ;;
    *) menu_rede ;;
  esac
  menu_rede
}

menu_social(){
  banner
  echo -e "${GRN}→ Espionagem Social${NC}\n"
  echo "[1] SocialFish"
  echo "[2] Twint"
  echo "[3] Maigret"
  echo "[4] Voltar"
  read -p "→ " o
  case $o in
    1) run_tool "cd ~/FENIX/tools/SocialFish && python3 socialfish.py" ;;
    2) run_tool "cd ~/FENIX/tools/Twint && python3 twint.py -u user" ;;
    3) run_tool "cd ~/FENIX/tools/maigret && python3 maigret.py user" ;;
    4) menu_main ;;
    *) menu_social ;;
  esac
  menu_social
}

menu_exploit(){
  banner
  echo -e "${GRN}→ Exploração Avançada${NC}\n"
  echo "[1] sqlmap"
  echo "[2] Hydra (FTP brute)"
  echo "[3] XSStrike"
  echo "[4] Voltar"
  read -p "→ " o
  case $o in
    1) run_tool "cd ~/FENIX/tools/sqlmap && python3 sqlmap.py -u http://target.com --batch" ;;
    2) run_tool "hydra -l user -P pass.txt ftp://192.168.1.100" ;;
    3) run_tool "cd ~/FENIX/tools/XSStrike && python3 xsstrike.py -u http://target.com" ;;
    4) menu_main ;;
    *) menu_exploit ;;
  esac
  menu_exploit
}

# ── INICIAÇÃO ─────────────────────────────────
if [[ ! -f ~/FENIX/fenix.sh ]]; then
  echo -e "${RED}Arquivo fenix.sh não encontrado em ~/FENIX!${NC}"
  exit 1
fi

banner
menu_main

