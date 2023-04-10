#!/usr/bin/env bash
#
# Configuration Script for Pop!OS
#
# Current Version: Pop!OS 22.04 LTS
# 
# Autor:         Felipe Lozada
# Github:
# LinkedIn:
#
# ------------------------------------------------------------------------ #
#
# HOW USE?
#   $ ./config.sh
#
# ----------------------------- VARIÁVEIS ----------------------------- #
set -e

##URLS

URL_GOOGLE_CHROME="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
URL_4K_VIDEO_DOWNLOADER="https://dl.4kdownload.com/app/4kvideodownloader_4.20.0-1_amd64.deb?source=website"
URL_INSYNC="https://d2t3ff60b2tol4.cloudfront.net/builds/insync_3.7.2.50318-impish_amd64.deb"
URL_HYPER="https://releases.hyper.is/download/deb"
URL_VSCODE="https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
URL_OBINS_KIT="https://s3.hexcore.xyz/occ/linux/deb/ObinsKit_1.2.11_x64.deb"
URL_DISCORD="https://discord.com/api/download?platform=linux&format=deb"
URL_DOCKER="https://desktop.docker.com/linux/main/amd64/docker-desktop-4.18.0-amd64.deb?utm_source=docker&utm_medium=webreferral&utm_campaign=docs-driven-download-linux-amd64"
URL_MONGODB_COMPASS="https://downloads.mongodb.com/compass/mongodb-compass_1.36.2_amd64.deb"
URL_JETBRAINS_TOOLBOX="https://www.jetbrains.com/toolbox-app/download/download-thanks.html?platform=linux"
URL_MINT_WEB_APPS="http://packages.linuxmint.com/pool/main/w/webapp-manager/webapp-manager_1.2.8_all.deb"
##URL_STUDIO3T=""

##DIRETÓRIOS E ARQUIVOS

DIRETORIO_DOWNLOADS="$HOME/Downloads/programas"
DIRETORIO_OTHER_DOWNLOADS="$HOME/Downloads/ManualInstallPrograms"

#CORES

VERMELHO='\e[1;91m'
VERDE='\e[1;92m'
SEM_COR='\e[0m'


#FUNÇÕES

# Atualizando repositório e fazendo atualização do sistema

apt_update(){
  sudo apt update && sudo apt dist-upgrade -y
}

# -------------------------------------------------------------------------------- #
# -------------------------------TESTES E REQUISITOS----------------------------------------- #

# Internet conectando?
testes_internet(){
if ! ping -c 1 8.8.8.8 -q &> /dev/null; then
  echo -e "${VERMELHO}[ERROR] - Seu computador não tem conexão com a Internet. Verifique a rede.${SEM_COR}"
  exit 1
else
  echo -e "${VERDE}[INFO] - Conexão com a Internet funcionando normalmente.${SEM_COR}"
fi
}

# ------------------------------------------------------------------------------ #


## Removendo travas eventuais do apt ##
travas_apt(){
  sudo rm /var/lib/dpkg/lock-frontend
  sudo rm /var/cache/apt/archives/lock
}

## Adicionando/Confirmando arquitetura de 32 bits ##
add_archi386(){
sudo dpkg --add-architecture i386
}

## Add TLP
add_tlp() {
sudo add-apt-repository ppa:linrunner/tlp -y
}

## Atualizando o repositório ##
just_apt_update(){
sudo apt update -y
}



##DEB SOFTWARES TO INSTALL

PROGRAMAS_PARA_INSTALAR=(
  snapd
  winff
  virtualbox
  gparted
  timeshift
  gufw
  synaptic
  solaar
  vlc
  gnome-sushi 
  folder-color
  git
  wget
  ubuntu-restricted-extras
  flameshot
  dconf-editor
  zsh
  cheese
  gnome-tweak-tool
  gnome-tweaks
  gnome-shell-extensions
  dia
  gir1.2-gda-5.0 
  gir1.2-gsound-1.0
  #tlp
  #tlp-rdw
)

# ---------------------------------------------------------------------- #

## Download e instalaçao de programas externos ##

install_debs(){

echo -e "${VERDE}[INFO] - Baixando pacotes .deb${SEM_COR}"

mkdir "$DIRETORIO_DOWNLOADS"
wget -c "$URL_GOOGLE_CHROME"       -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_4K_VIDEO_DOWNLOADER" -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_INSYNC"              -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_DISCORD"             -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_DOCKER"              -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_HYPER"               -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_MONGODB_COMPASS"     -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_OBINS_KIT"           -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_VSCODE"              -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_MINT_WEB_APPS"       -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_JETBRAINS_TOOLBOX"   -P "$DIRETORIO_OTHER_DOWNLOADS"

## Instalando pacotes .deb baixados na sessão anterior ##
echo -e "${VERDE}[INFO] - Instalando pacotes .deb baixados${SEM_COR}"
sudo dpkg -i $DIRETORIO_DOWNLOADS/*.deb

# Instalar programas no apt
echo -e "${VERDE}[INFO] - Instalando pacotes apt do repositório${SEM_COR}"

for nome_do_programa in ${PROGRAMAS_PARA_INSTALAR[@]}; do
  if ! dpkg -l | grep -q $nome_do_programa; then # Só instala se já não estiver instalado
    sudo apt install "$nome_do_programa" -y
  else
    echo "[INSTALADO] - $nome_do_programa"
  fi
done

}
## Instalando pacotes Flatpak ##
install_flatpaks(){

  echo -e "${VERDE}[INFO] - Instalando pacotes flatpak${SEM_COR}"

flatpak install flathub com.obsproject.Studio -y
flatpak install flathub org.gimp.GIMP -y
flatpak install flathub org.kde.kdenlive -y
flatpak install flathub com.spotify.Client -y
flatpak install flathub com.bitwarden.desktop -y
flatpak install flathub org.telegram.desktop -y
flatpak install flathub org.freedesktop.Piper -y
flatpak install flathub org.gnome.Boxes -y
flatpak install flathub org.onlyoffice.desktopeditors -y
flatpak install flathub org.qbittorrent.qBittorrent -y
flatpak install flathub org.flameshot.Flameshot -y
flatpak install flathub com.github.maoschanz.drawing -y
flatpak install flathub nl.hjdskes.gcolor3 -y
flatpak install flathub md.obsidian.Obsidian -y
flatpak install flathub com.microsoft.Edge -y
flatpak install flathub com.github.d4nj1.tlpui -y
flatpak install flathub org.audacityteam.Audacity -y
flatpak install flathub com.slack.Slack -y
flatpak install flathub us.zoom.Zoom -y
flatpak install flathub io.beekeeperstudio.Studio -y
flatpak install flathub io.dbeaver.DBeaverCommunity -y
flatpak install flathub io.github.mimbrero.WhatsAppDesktop -y
flatpak install flathub io.github.Figma_Linux.figma_linux -y
flatpak install flathub com.axosoft.GitKraken -y
flatpak install flathub rest.insomnia.Insomnia -y
flatpak install flathub org.localsend.localsend_app -y
flatpak install flathub org.filezillaproject.Filezilla -y
flatpak install flathub com.usebottles.bottles -y
flatpak install flathub org.gnome.Epiphany -y
flatpak install flathub com.mattjakeman.ExtensionManager -y
flatpak install flathub net.blix.BlueMail -y
flatpak install flathub com.getmailspring.Mailspring -y
flatpak install flathub org.mozilla.Thunderbird -y
flatpak install flathub org.gnome.Boxes -y
flatpak install flathub org.kde.umbrello -y
flatpak install flathub com.jgraph.drawio.desktop -y
flatpak install flathub org.nickvision.tubeconverter -y

}

## Instalando pacotes Snap ##

install_snaps(){

echo -e "${VERDE}[INFO] - Instalando pacotes snap${SEM_COR}"

sudo snap install notion-snap
sudo snap install rambox
sudo snap install postman

}

postgresql_install() {

echo -e "${VERDE}[INFO] - Instalando Postgresql${SEM_COR}"

sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get -y install postgresql
}

pgadmin_install() {

echo -e "${VERDE}[INFO] - Instalando PGAdmin${SEM_COR}"

curl -fsS https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo gpg --dearmor -o /usr/share/keyrings/packages-pgadmin-org.gpg
sudo sh -c 'echo "deb [signed-by=/usr/share/keyrings/packages-pgadmin-org.gpg] https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list && apt update'
sudo apt install pgadmin4 -y
}

docker_install() {

echo -e "${VERDE}[INFO] - Instalando Docker${SEM_COR}"

sudo apt-get update
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg
sudo mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
}

# r_install() {}
# rstudio_instll() {}


# -------------------------------------------------------------------------- #
# ----------------------------- PÓS-INSTALAÇÃO ----------------------------- #


## Finalização, atualização e limpeza##

system_clean(){

apt_update -y
flatpak update -y
sudo apt autoclean -y
sudo apt autoremove -y
nautilus -q
}

# -------------------------------------------------------------------------------- #
# -------------------------------EXECUÇÃO----------------------------------------- #

travas_apt
testes_internet
travas_apt
apt_update
travas_apt
add_archi386
just_apt_update
install_debs
install_flatpaks
install_snaps
postgresql_install
pgadmin_install
docker_install
apt_update
system_clean

## finalização

  echo -e "${VERDE}[INFO] - Script finalizado, instalação concluída! :)${SEM_COR}"