#!/usr/bin/env bash
# SKN Pterodactyl Installer
# Powered by Skyler Nodes | Made by Zyren

RESET='\033[0m'
WHITE='\033[97m'
LIGHT_BLUE='\033[94m'
CYAN='\033[96m'
YELLOW='\033[93m'
PURPLE='\033[95m'
RED='\033[91m'
GREEN='\033[92m'

center() {
    local text="$1" color="$2" width=64
    local len=${#text} pad=$(( (width - ${#text}) / 2 ))
    (( pad < 0 )) && pad=0
    printf "%*s%b%s%b\n" "$pad" "" "$color" "$text" "$RESET"
}

loading() {
    local msg="${1:-Loading}"
    printf "\n${LIGHT_BLUE}${msg}${RESET}"
    for _ in 1 2 3 4 5; do printf "${CYAN}.${RESET}"; sleep 0.16; done
    printf " ${GREEN}DONE${RESET}\n"
    sleep 0.25
}

pause_return() {
    printf "\n${WHITE}Press Enter to return...${RESET}"
    read -r _
}

banner() {
    clear
    center "███████╗██╗  ██╗███╗   ██╗" "$LIGHT_BLUE"
    center "██╔════╝██║ ██╔╝████╗  ██║" "$PURPLE"
    center "███████╗█████╔╝ ██╔██╗ ██║" "$YELLOW"
    center "╚════██║██╔═██╗ ██║╚██╗██║" "$LIGHT_BLUE"
    center "███████║██║  ██╗██║ ╚████║" "$PURPLE"
    center "╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝" "$YELLOW"
    echo
    center "PTERODACTYL INSTALLER" "$WHITE"
    echo
    center "POWERED BY SKYLER NODES" "$YELLOW"
    center "MADE BY ZYREN" "$WHITE"
    printf "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}\n"
}

run_installer() {
    if [[ $EUID -ne 0 ]]; then
        printf "${RED}Root access is required for installation.${RESET}\n"
        pause_return
        return
    fi
    if ! command -v curl >/dev/null 2>&1; then
        printf "${RED}curl is not installed.${RESET}\n"
        pause_return
        return
    fi
    loading "Preparing installer"
    bash <(curl -fsSL https://pterodactyl-installer.se)
    printf "\n${WHITE}Installer returned to SKN.${RESET}\n"
    pause_return
}

panel_menu() {
    while true; do
        banner
        printf "${WHITE}  PANEL INSTALLATION${RESET}\n"
        printf "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}\n"
        printf "  ${WHITE}[1]${RESET} ${LIGHT_BLUE}Install Panel${RESET}\n"
        printf "  ${WHITE}[2]${RESET} ${LIGHT_BLUE}Panel User/Admin${RESET}\n"
        printf "  ${WHITE}[3]${RESET} ${LIGHT_BLUE}Update Panel${RESET}\n"
        printf "  ${WHITE}[4]${RESET} ${LIGHT_BLUE}Domain + SSL${RESET}\n"
        printf "  ${RED}[5]${RESET} ${LIGHT_BLUE}Uninstall Panel${RESET}\n"
        printf "  ${WHITE}[0]${RESET} ${LIGHT_BLUE}Back${RESET}\n"
        printf "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}\n"
        printf "${WHITE}📝 Select an option [0-5]: ${RESET}"
        read -r choice
        case "$choice" in
            1) loading "Opening Panel installer"; run_installer ;;
            2) loading "Opening User/Admin setup"
               if [[ -f /var/www/pterodactyl/artisan ]]; then
                   (cd /var/www/pterodactyl && php artisan p:user:make)
               else
                   printf "${RED}Pterodactyl Panel is not installed.${RESET}\n"
               fi
               pause_return ;;
            3) loading "Opening Panel update"
               if [[ -f /var/www/pterodactyl/artisan ]]; then
                   (cd /var/www/pterodactyl && php artisan --version)
                   printf "${WHITE}Use the release-specific update procedure for your installed version.${RESET}\n"
               else
                   printf "${RED}Pterodactyl Panel is not installed.${RESET}\n"
               fi
               pause_return ;;
            4) loading "Opening Domain + SSL"
               printf "${WHITE}Domain/SSL module ready. Verify DNS and ports 80/443 before changes.${RESET}\n"
               pause_return ;;
            5) loading "Opening Panel uninstall"
               printf "${YELLOW}Confirmation-based uninstall module ready. No data is deleted here.${RESET}\n"
               pause_return ;;
            0) return ;;
            *) printf "${RED}Invalid option. Returning to Panel menu...${RESET}\n"; sleep 1 ;;
        esac
    done
}

module_screen() {
    local title="$1" detail="$2"
    banner
    printf "${WHITE}  ${title}${RESET}\n"
    printf "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}\n"
    printf "${LIGHT_BLUE}${detail}${RESET}\n"
    printf "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}\n"
    pause_return
}

main_menu() {
    while true; do
        banner
        printf "  ${WHITE}[1]${RESET} ${LIGHT_BLUE}Panel Installation${RESET}\n"
        printf "  ${WHITE}[2]${RESET} ${LIGHT_BLUE}Wings Installation${RESET}\n"
        printf "  ${WHITE}[3]${RESET} ${LIGHT_BLUE}Themes${RESET}\n"
        printf "  ${WHITE}[4]${RESET} ${LIGHT_BLUE}Extensions${RESET}\n"
        printf "  ${WHITE}[5]${RESET} ${LIGHT_BLUE}Cloudflare Setup${RESET}\n"
        printf "  ${WHITE}[6]${RESET} ${LIGHT_BLUE}System Information${RESET}\n"
        printf "  ${WHITE}[7]${RESET} ${LIGHT_BLUE}Database Setup ${YELLOW}(Coming soon)${RESET}\n"
        echo
        printf "  ${RED}[0]${RESET} ${RED}Exit${RESET}\n"
        printf "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}\n"
        printf "${WHITE}📝 Select an option [0-7]: ${RESET}"
        read -r choice
        case "$choice" in
            1) loading "Opening Panel Installation"; panel_menu ;;
            2) loading "Opening Wings Installation"; run_installer ;;
            3) loading "Opening Themes"; module_screen "THEMES" "Theme management module is ready for integration." ;;
            4) loading "Opening Extensions"; module_screen "EXTENSIONS" "Extension management module is ready for integration." ;;
            5) loading "Opening Cloudflare Setup"; module_screen "CLOUDFLARE SETUP" "Cloudflare setup module is ready for integration." ;;
            6) loading "Collecting System Information"
               banner
               printf "${WHITE}  SYSTEM INFORMATION${RESET}\n"
               printf "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}\n"
               if [[ -f /etc/os-release ]]; then . /etc/os-release; fi
               printf "${LIGHT_BLUE}OS:${RESET} %s\n" "${PRETTY_NAME:-Unknown}"
               printf "${LIGHT_BLUE}Kernel:${RESET} %s\n" "$(uname -sr 2>/dev/null)"
               printf "${LIGHT_BLUE}Architecture:${RESET} %s\n" "$(uname -m 2>/dev/null)"
               printf "${LIGHT_BLUE}Hostname:${RESET} %s\n" "$(hostname 2>/dev/null)"
               printf "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}\n"
               pause_return ;;
            7) loading "Opening Database Setup"; module_screen "DATABASE SETUP" "Coming soon — no database changes are made by this option." ;;
            0) printf "\n${RED}Exiting SKN Pterodactyl Installer...${RESET}\n"; exit 0 ;;
            *) printf "${RED}Invalid option. The installer will NOT exit.${RESET}\n"; sleep 1 ;;
        esac
    done
}

main_menu
