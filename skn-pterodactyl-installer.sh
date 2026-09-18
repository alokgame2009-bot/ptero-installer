#!/usr/bin/env bash
set -u

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
    local pad=$(( (width - ${#text}) / 2 ))
    (( pad < 0 )) && pad=0
    printf "%*s%b%s%b\n" "$pad" "" "$color" "$text" "$RESET"
}

loading() {
    local msg="$1"
    printf "\n${LIGHT_BLUE}${msg}${RESET}"
    for _ in 1 2 3 4 5; do
        printf "${CYAN}.${RESET}"
        sleep 0.15
    done
    printf " ${GREEN}DONE${RESET}\n"
    sleep 0.25
}

pause_menu() {
    printf "\n${WHITE}Press Enter to return to menu...${RESET}"
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

panel_menu() {
    while true; do
        banner
        printf "${WHITE}  🛰️  SERVER PANEL MANAGER v1${RESET}\n"
        printf "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}\n\n"
        printf "   ${LIGHT_BLUE}AVAILABLE DEPLOYMENTS${RESET}\n"
        printf "  ┌──────────────────────────┬──────────────────────────┐\n"
        printf "  │ ${WHITE}[1]${RESET} ${LIGHT_BLUE}Ptero${RESET}                │ ${WHITE}[2]${RESET} ${LIGHT_BLUE}JexPanel${RESET}             │\n"
        printf "  │ ${WHITE}[3]${RESET} ${LIGHT_BLUE}Mythicaldash${RESET}         │ ${WHITE}[4]${RESET} ${LIGHT_BLUE}Reviactyl${RESET}             │\n"
        printf "  │ ${WHITE}[5]${RESET} ${LIGHT_BLUE}Mythicaldashv3${RESET}       │ ${WHITE}[6]${RESET} ${LIGHT_BLUE}CtrlPanel${RESET}              │\n"
        printf "  │ ${WHITE}[7]${RESET} ${LIGHT_BLUE}Paymenter${RESET}            │                          │\n"
        printf "  └──────────────────────────┴──────────────────────────┘\n\n"
        printf "  ${RED}[0]${RESET} ${RED}Exit${RESET}\n"
        printf "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}\n"
        printf "${WHITE}📝 Select Module [0-7]: ${RESET}"
        read -r choice
        case "$choice" in
            1) loading "Opening Pterodactyl Manager"; ptero_submenu ;;
            2) loading "Opening JexPanel"; module "JEXPANEL" "JexPanel deployment module is ready for integration." ;;
            3) loading "Opening Mythicaldash"; module "MYTHICALDASH" "Mythicaldash deployment module is ready for integration." ;;
            4) loading "Opening Reviactyl"; module "REVIACTYL" "Reviactyl deployment module is ready for integration." ;;
            5) loading "Opening Mythicaldashv3"; module "MYTHICALDASH V3" "Mythicaldashv3 deployment module is ready for integration." ;;
            6) loading "Opening CtrlPanel"; module "CTRLPANEL" "CtrlPanel deployment module is ready for integration." ;;
            7) loading "Opening Paymenter"; module "PAYMENTER" "Paymenter deployment module is ready for integration." ;;
            0) return ;;
            *) printf "${RED}Invalid option — installer will NOT exit.${RESET}\n"; sleep 1 ;;
        esac
    done
}

ptero_install() {
    clear
    printf "${LIGHT_BLUE}"
    cat <<'EOF'
               .                                      .o8                          .               oooo
             .o8                                     "888                        .o8               `888
oo.ooooo.  .o888oo  .ooooo.  oooo d8b  .ooooo.   .oooo888   .oooo.    .ooooo.  .o888oo oooo    ooo  888
 888' `88b   888   d88' `88b `888""8P d88' `88b d88' `888  `P  )88b  d88' `"Y8   888    `88.  .8'   888
 888   888   888   888ooo888  888     888   888 888   888   .oP"888  888         888     `88..8'    888
 888   888   888 . 888    .o  888     888   888 888   888  d8(  888  888   .o8   888 .    `888'     888
 888bod8P'   "888" `Y8bod8P' d888b    `Y8bod8P' `Y8bod88P" `Y888""8o `Y8bod8P'   "888"     .8'     o888o
 888                                                                                   .o..P'
o888o                                                                                  `Y8P'
EOF
    printf "${RESET}\n"
    center "PREMIUM PTERODACTYL INSTALLER" "$YELLOW"
    printf "${CYAN}────────────────────────────────────────────────────────────${RESET}\n"

    local domain email username password version_choice version
    read -rp "  ${WHITE}• Panel Domain ${LIGHT_BLUE}[panel.example.com]${RESET}\n  ${LIGHT_BLUE}╰─> ${RESET}" domain
    read -rp "  ${WHITE}• Admin Email ${LIGHT_BLUE}[admin@example.com]${RESET}\n  ${LIGHT_BLUE}╰─> ${RESET}" email
    read -rp "  ${WHITE}• Admin Username ${LIGHT_BLUE}[admin]${RESET}\n  ${LIGHT_BLUE}╰─> ${RESET}" username
    read -rsp "  ${WHITE}• Admin Password ${LIGHT_BLUE}[hidden]${RESET}\n  ${LIGHT_BLUE}╰─> ${RESET}" password
    echo

    local versions=(
      "v1.15.1" "v1.15.0" "v1.14.1" "v1.14.0" "v1.13.0"
      "v1.12.4" "v1.12.3" "v1.12.2" "v1.12.1" "v1.12.0"
      "v1.11.11" "v1.11.10" "v1.11.9" "v1.11.8" "v1.11.7"
      "v1.11.6" "v1.11.5" "v1.11.4" "v1.11.3" "v1.11.2"
    )
    printf "\n  ${WHITE}:: Available Panel Versions${RESET}\n"
    local i
    for i in "${!versions[@]}"; do
        printf "  ${WHITE}%2d.${RESET} ${LIGHT_BLUE}%s${RESET}\n" "$((i+1))" "${versions[$i]}"
    done

    while true; do
        read -rp $'\n  \033[97m• Select version [1-20] [1 = latest]\033[0m\n  \033[94m╰─> \033[0m' version_choice
        if [[ "$version_choice" =~ ^[0-9]+$ ]] && ((version_choice >= 1 && version_choice <= 20)); then
            version="${versions[$((version_choice-1))]}"
            break
        fi
        printf "${RED}Invalid version. Please choose 1-20.${RESET}\n"
    done

    printf "\n  ${CYAN}┌─[ REVIEW CONFIGURATION ]${RESET}\n"
    printf "  ${CYAN}│${RESET} Domain:   ${LIGHT_BLUE}%s${RESET}\n" "$domain"
    printf "  ${CYAN}│${RESET} Email:    ${LIGHT_BLUE}%s${RESET}\n" "$email"
    printf "  ${CYAN}│${RESET} User:     ${LIGHT_BLUE}%s${RESET}\n" "$username"
    printf "  ${CYAN}│${RESET} Version:  ${LIGHT_BLUE}%s${RESET}\n" "$version"
    printf "  ${CYAN}└───────────────────────────${RESET}\n"

    local confirm
    read -rp $'\n  \033[97mStart Installation? (y/n): \033[0m' confirm
    [[ "$confirm" =~ ^[Yy]$ ]] || { printf "${YELLOW}Installation cancelled.${RESET}\n"; pause_menu; return; }

    printf "${CYAN}  Proceeding to deployment...${RESET}\n"
    printf "${CYAN}────────────────────────────────────────────────────────────${RESET}\n"

    # The official community installer is used for dependency/database/web-server setup.
    # The selected release is then checked out explicitly so the requested panel version
    # is installed rather than silently using whatever release is current.
    if [[ ! "$domain" =~ ^[A-Za-z0-9.-]+$ || -z "$email" || -z "$username" || -z "$password" ]]; then
        printf "${RED}Invalid configuration. Domain, email, username and password are required.${RESET}\n"
        pause_menu
        return
    fi

    if ! command -v curl >/dev/null 2>&1; then
        printf "${YELLOW}Installing curl...${RESET}\n"
        apt-get update && apt-get install -y curl
    fi

    printf "${LIGHT_BLUE}Running Pterodactyl dependency installer...${RESET}\n"
    bash <(curl -fsSL https://pterodactyl-installer.se)

    if [[ ! -f /var/www/pterodactyl/artisan ]]; then
        printf "${RED}Panel installation did not complete successfully.${RESET}\n"
        pause_menu
        return
    fi

    cd /var/www/pterodactyl || return
    printf "${LIGHT_BLUE}Switching panel files to ${version}...${RESET}\n"
    if ! command -v git >/dev/null 2>&1; then
        apt-get update && apt-get install -y git
    fi
    git fetch --tags https://github.com/pterodactyl/panel.git "refs/tags/${version}:refs/tags/${version}" || {
        printf "${RED}Could not fetch ${version}.${RESET}\n"; pause_menu; return;
    }
    git checkout -f "tags/${version}" || {
        printf "${RED}Could not switch to ${version}.${RESET}\n"; pause_menu; return;
    }

    # Refresh dependencies and application cache for the selected release.
    if command -v composer >/dev/null 2>&1; then
        COMPOSER_ALLOW_SUPERUSER=1 composer install --no-dev --optimize-autoloader --no-interaction
    fi
    php artisan migrate --force
    php artisan optimize:clear

    printf "${LIGHT_BLUE}Creating/updating administrator account...${RESET}\n"
    # p:user:make is interactive, so provide the collected values to it.
    printf "%s\n%s\n%s\n%s\nY\n" "$email" "$username" "$password" "$password" | php artisan p:user:make --email="$email" --username="$username" --name="$username" --admin=1 2>/dev/null || \
      printf "${YELLOW}Admin creation may require the interactive Pterodactyl user command.${RESET}\n"

    printf "\n${GREEN}Installation process completed for ${version}.${RESET}\n"
    printf "${LIGHT_BLUE}Panel URL: https://%s${RESET}\n" "$domain"
    printf "${YELLOW}If DNS/SSL was not configured by the dependency installer, use Domain from the Ptero menu.${RESET}\n"
    pause_menu
}

ptero_submenu() {
    while true; do
        clear
        local STATUS
        if [[ -f /var/www/pterodactyl/artisan ]]; then
            STATUS="${GREEN}INSTALLED ✔${RESET}"
        else
            STATUS="${RED}NOT INSTALLED ✘${RESET}"
        fi

        printf "${LIGHT_BLUE}  ____  _                     _            _         _ ${RESET}\n"
        printf "${LIGHT_BLUE} |  _ \\| |_ ___ _ __ ___   __| | __ _  ___| |_ _   _| |${RESET}\n"
        printf "${LIGHT_BLUE} | |_) | __/ _ \\ '__/ _ \\ / _\' |/ _\' |/ __| __| | | | |${RESET}\n"
        printf "${LIGHT_BLUE} |  __/| ||  __/ | | (_) | (_| | (_| | (__| |_| |_| | |${RESET}\n"
        printf "${LIGHT_BLUE} |_|    \\__\\___|_|  \\___/ \\__,_|\\__,_|\\___|\\__|\\__, |_|${RESET}\n"
        printf "${LIGHT_BLUE}                                               |___/   ${RESET}\n\n"

        printf "${CYAN} ┌────────────────────────────────────────────────────────────┐${RESET}\n"
        printf "${CYAN} │${RESET} PANEL STATUS: %-42b ${CYAN}│${RESET}\n" "$STATUS"
        printf "${CYAN} ├────────────────────────────────────────────────────────────┤${RESET}\n"
        printf "${CYAN} │${RESET}                                                            ${CYAN}│${RESET}\n"
        printf "${CYAN} │${RESET}  ${WHITE}[1]${RESET} ${LIGHT_BLUE}Install${RESET}       :: ${WHITE}(Fresh Install)${RESET}                  ${CYAN}│${RESET}\n"
        printf "${CYAN} │${RESET}  ${WHITE}[2]${RESET} ${LIGHT_BLUE}User${RESET}          :: ${WHITE}(Add Admin/User)${RESET}                 ${CYAN}│${RESET}\n"
        printf "${CYAN} │${RESET}  ${WHITE}[3]${RESET} ${LIGHT_BLUE}Update${RESET}        :: ${WHITE}(Latest Release)${RESET}                ${CYAN}│${RESET}\n"
        printf "${CYAN} │${RESET}  ${WHITE}[4]${RESET} ${LIGHT_BLUE}Domain${RESET}        :: ${WHITE}(Change Domain/SSL)${RESET}             ${CYAN}│${RESET}\n"
        printf "${CYAN} │${RESET}  ${WHITE}[5]${RESET} ${LIGHT_BLUE}Uninstall${RESET}     :: ${WHITE}(Remove Data)${RESET}                    ${CYAN}│${RESET}\n"
        printf "${CYAN} │${RESET}                                                            ${CYAN}│${RESET}\n"
        printf "${CYAN} │${RESET}  ${RED}[0]${RESET} ${LIGHT_BLUE}Exit System${RESET}                                     ${CYAN}│${RESET}\n"
        printf "${CYAN} └────────────────────────────────────────────────────────────┘${RESET}\n\n"
        printf "${WHITE}  root@ptero:~# ${RESET}"
        read -r choice
        case "$choice" in
            1) loading "Opening Premium Panel Installer"; ptero_install ;;
            2) loading "Opening User / Admin"; if [[ -f /var/www/pterodactyl/artisan ]]; then (cd /var/www/pterodactyl && php artisan p:user:make); else printf "${RED}Pterodactyl Panel is not installed.${RESET}\n"; fi; pause_menu ;;
            3) loading "Checking Latest Release"; if [[ -f /var/www/pterodactyl/artisan ]]; then (cd /var/www/pterodactyl && php artisan --version); else printf "${RED}Pterodactyl Panel is not installed.${RESET}\n"; fi; pause_menu ;;
            4) loading "Opening Domain + SSL"; printf "${YELLOW}Domain/SSL module ready for configuration.${RESET}\n"; pause_menu ;;
            5) loading "Opening Uninstall Panel"; printf "${YELLOW}Uninstall module ready. No data has been removed.${RESET}\n"; pause_menu ;;
            0) return ;;
            *) printf "${RED}Invalid option — installer will NOT exit.${RESET}\n"; sleep 1 ;;
        esac
    done
}

module() {
    local title="$1"
    local message="$2"
    banner
    printf "  ${WHITE}${title}${RESET}\n"
    printf "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}\n"
    printf "${LIGHT_BLUE}${message}${RESET}\n"
    printf "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}\n"
    pause_menu
}

main() {
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
            2) loading "Opening Wings Installation"
               if command -v curl >/dev/null 2>&1; then bash <(curl -fsSL https://pterodactyl-installer.se); else printf "${RED}curl is not installed.${RESET}\n"; fi
               pause_menu ;;
            3) loading "Opening Themes"; module "THEMES" "Theme management module is ready for integration." ;;
            4) loading "Opening Extensions"; module "EXTENSIONS" "Extension management module is ready for integration." ;;
            5) loading "Opening Cloudflare Setup"; module "CLOUDFLARE SETUP" "Cloudflare setup module is ready for integration." ;;
            6)
                loading "Loading System Information"
                banner
                printf "  ${WHITE}SYSTEM INFORMATION${RESET}\n"
                printf "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}\n"
                [[ -f /etc/os-release ]] && . /etc/os-release
                printf "${LIGHT_BLUE}OS:${RESET} %s\n" "${PRETTY_NAME:-Unknown}"
                printf "${LIGHT_BLUE}Kernel:${RESET} %s\n" "$(uname -sr 2>/dev/null)"
                printf "${LIGHT_BLUE}Architecture:${RESET} %s\n" "$(uname -m 2>/dev/null)"
                printf "${LIGHT_BLUE}Hostname:${RESET} %s\n" "$(hostname 2>/dev/null)"
                printf "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}\n"
                pause_menu ;;
            7) loading "Opening Database Setup"; module "DATABASE SETUP" "Coming soon — no database changes are performed." ;;
            0) printf "\n${RED}Exiting SKN Pterodactyl Installer...${RESET}\n"; exit 0 ;;
            *) printf "${RED}Invalid option — installer will NOT exit.${RESET}\n"; sleep 1 ;;
        esac
    done
}

main
