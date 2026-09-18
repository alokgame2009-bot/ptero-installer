#!/usr/bin/env bash
set -u

ESC=$(printf '\033')
RESET="${ESC}[0m"
WHITE="${ESC}[97m"
LIGHT_BLUE="${ESC}[94m"
CYAN="${ESC}[96m"
YELLOW="${ESC}[93m"
PURPLE="${ESC}[95m"
RED="${ESC}[91m"
GREEN="${ESC}[92m"

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
    printf '%b' "${LIGHT_BLUE}"
    cat <<'SKN_PTERO_LOGO'
               .                                      .o8                          .               oooo
             .o8                                     "888                        .o8               `888
 oo.ooooo.  .o888oo  .ooooo.  oooo d8b  .ooooo.   .oooo888   .oooo.    .ooooo.  .o888oo oooo    ooo  888
  888' `88b   888   d88' `88b `888""8P d88' `88b d88' `888  `P  )88b  d88' `"Y8   888    `88.  .8'   888
  888   888   888   888ooo888  888     888   888 888   888   .oP"888  888         888     `88..8'    888
  888   888   888 . 888    .o  888     888   888 888   888  d8(  888  888   .o8   888 .    `888'     888
  888bod8P'   "888" `Y8bod8P' d888b    `Y8bod8P' `Y8bod88P" `Y888""8o `Y8bod8P'   "888"     .8'     o888o
  888                                                                                   .o..P'
 o888o                                                                                  `Y8P'
SKN_PTERO_LOGO
    printf '%b\n' "${RESET}"
    center "PREMIUM PTERODACTYL INSTALLER" "$YELLOW"
    printf '%b\n' "${CYAN}────────────────────────────────────────────────────────────${RESET}"

    local domain email username password
    printf '%b\n' "  ${WHITE}• Panel Domain ${LIGHT_BLUE}[panel.example.com]${RESET}"
    printf '%b' "  ${LIGHT_BLUE}╰─> ${RESET}"; read -r domain
    printf '%b\n' "  ${WHITE}• Admin Email ${LIGHT_BLUE}[admin@example.com]${RESET}"
    printf '%b' "  ${LIGHT_BLUE}╰─> ${RESET}"; read -r email
    printf '%b\n' "  ${WHITE}• Admin Username ${LIGHT_BLUE}[admin]${RESET}"
    printf '%b' "  ${LIGHT_BLUE}╰─> ${RESET}"; read -r username
    printf '%b\n' "  ${WHITE}• Admin Password ${LIGHT_BLUE}[hidden]${RESET}"
    printf '%b' "  ${LIGHT_BLUE}╰─> ${RESET}"; read -rs password; printf '\n'

    printf '\n%b\n' "  ${CYAN}┌─[ REVIEW CONFIGURATION ]${RESET}"
    printf '%b\n' "  ${CYAN}│${RESET} Domain:   ${LIGHT_BLUE}${domain}${RESET}"
    printf '%b\n' "  ${CYAN}│${RESET} Email:    ${LIGHT_BLUE}${email}${RESET}"
    printf '%b\n' "  ${CYAN}│${RESET} User:     ${LIGHT_BLUE}${username}${RESET}"
    printf '%b\n' "  ${CYAN}└───────────────────────────${RESET}"

    local confirm
    printf '%b' "\n  ${WHITE}Start Installation? (y/n): ${RESET}"; read -r confirm
    if [[ ! "$confirm" =~ ^[Yy]$ ]]; then printf '%b\n' "${YELLOW}Installation cancelled.${RESET}"; pause_menu; return; fi

    if [[ ! "$domain" =~ ^[A-Za-z0-9.-]+$ || -z "$email" || -z "$username" || -z "$password" ]]; then
        printf '%b\n' "${RED}Invalid configuration. Domain, email, username and password are required.${RESET}"
        pause_menu; return
    fi

    printf '%b\n' "${CYAN}Proceeding to deployment...${RESET}"
    printf '%b\n' "${CYAN}────────────────────────────────────────────────────────────${RESET}"
    printf '%b\n' "${LIGHT_BLUE}Preparing system packages and connecting SKN configuration...${RESET}"

    # Debian 11 Bullseye reached EOL on 2026-08-31. Its live security mirror can
    # return 404s for packages that are still referenced by old package indexes.
    # Keep the installer usable by switching Bullseye's normal repositories to
    # the Debian archive and disabling the now-retired security suite. Debian 12/13
    # are recommended for new deployments.
    repair_bullseye_apt() {
        if [[ -r /etc/os-release ]]; then
            . /etc/os-release
            if [[ "${ID:-}" == "debian" && "${VERSION_ID:-}" == "11" ]]; then
                printf '%b\n' "${YELLOW}Debian 11 detected: repairing retired Bullseye APT sources...${RESET}"
                local stamp="$(date +%Y%m%d-%H%M%S)"
                cp -a /etc/apt/sources.list "/etc/apt/sources.list.skn-backup-${stamp}" 2>/dev/null || true
                if [[ -d /etc/apt/sources.list.d ]]; then
                    tar -czf "/etc/apt/sources.list.d.skn-backup-${stamp}.tar.gz" /etc/apt/sources.list.d 2>/dev/null || true
                fi
                sed -i -E 's#^[[:space:]]*deb([[:space:]]+)https?://(deb\.debian\.org|security\.debian\.org)/debian(-security)?[[:space:]]+bullseye(-security)?#deb.disabled.skn \1https://archive.debian.org/debian bullseye#' /etc/apt/sources.list 2>/dev/null || true
                # Rebuild a clean Bullseye archive list so stale third-party entries
                # cannot break apt during this installation.
                cat > /etc/apt/sources.list <<'SKN_BULLSEYE_SOURCES'
# Managed by SKN Pterodactyl Installer for Debian 11 Bullseye archive compatibility.
deb http://archive.debian.org/debian bullseye main contrib non-free
deb http://archive.debian.org/debian bullseye-updates main contrib non-free
deb http://archive.debian.org/debian-security bullseye-security main contrib non-free
SKN_BULLSEYE_SOURCES
                rm -f /etc/apt/sources.list.d/*debian* 2>/dev/null || true
                cat > /etc/apt/apt.conf.d/99skn-bullseye-eol <<'SKN_APT_CONF'
Acquire::Check-Valid-Until "false";
SKN_APT_CONF
                apt-get clean || true
            fi
        fi
    }

    repair_bullseye_apt

    if ! command -v apt-get >/dev/null 2>&1; then
        printf '%b\n' "${RED}APT is not available on this operating system.${RESET}"
        pause_menu; return
    fi
    # Repair interrupted/held package state before the upstream installer starts.
    dpkg --configure -a >/tmp/skn-dpkg-configure.log 2>&1 || true
    apt-mark showhold 2>/dev/null | while read -r pkg; do
        [[ -n "$pkg" ]] && apt-mark unhold "$pkg" >/dev/null 2>&1 || true
    done
    apt-get -f install -y >/tmp/skn-apt-fix.log 2>&1 || true
    if ! apt-get update >/tmp/skn-apt-update.log 2>&1; then
        printf '%b\n' "${RED}APT update failed. Check /tmp/skn-apt-update.log.${RESET}"
        pause_menu; return
    fi
    apt-get -f install -y >/tmp/skn-apt-fix2.log 2>&1 || true
    if ! command -v curl >/dev/null 2>&1; then
        apt-get install -y curl >/tmp/skn-curl-install.log 2>&1 || { printf '%b\n' "${RED}Could not install curl.${RESET}"; pause_menu; return; }
    fi
    if ! command -v expect >/dev/null 2>&1; then
        printf '%b\n' "${LIGHT_BLUE}Installing Expect for automatic prompt handling...${RESET}"
        apt-get install -y expect >/tmp/skn-expect-install.log 2>&1 || { printf '%b\n' "${RED}Could not install Expect.${RESET}"; pause_menu; return; }
    fi

    local installer="/tmp/skn-pterodactyl-installer.sh"
    if ! curl -fsSL https://pterodactyl-installer.se -o "$installer"; then
        printf '%b\n' "${RED}Could not download the Pterodactyl installer.${RESET}"
        pause_menu; return
    fi
    chmod 700 "$installer"

    # Database prompts are intentionally left blank. The upstream installer
    # applies its own defaults (panel / pterodactyl) and generates the DB
    # password when Enter is pressed.
    local db_name=""
    local db_user=""
    local db_password=""
    export SKN_DOMAIN="$domain"
    export SKN_EMAIL="$email"
    export SKN_USERNAME="$username"
    export SKN_PASSWORD="$password"
    export SKN_TIMEZONE="Asia/Kolkata"
    export SKN_DB_NAME="$db_name"
    export SKN_DB_USER="$db_user"
    export SKN_DB_PASSWORD="$db_password"

    local expect_script="/tmp/skn-ptero-expect.exp"
    cat > "$expect_script" <<'SKN_EXPECT'
#!/usr/bin/expect -f
set timeout -1
log_user 0
log_file -noappend /tmp/skn-ptero-upstream.log
set domain $env(SKN_DOMAIN)
set email $env(SKN_EMAIL)
set username $env(SKN_USERNAME)
set password $env(SKN_PASSWORD)
set timezone $env(SKN_TIMEZONE)
set db_name $env(SKN_DB_NAME)
set db_user $env(SKN_DB_USER)
set db_password $env(SKN_DB_PASSWORD)

spawn bash /tmp/skn-pterodactyl-installer.sh

expect {
    -re {Input 0-6:} { send "0\r"; exp_continue }
    -re {Database name \(panel\):} { send "$db_name\r"; exp_continue }
    -re {Database username \(pterodactyl\):} { send "$db_user\r"; exp_continue }
    -re {Password \(press enter to use randomly generated password\):} { send "$db_password\r"; exp_continue }
    -re {Select timezone \[Europe/Stockholm\]:} { send "$timezone\r"; exp_continue }
    -re {Provide the email address that will be used to configure Let's Encrypt and Pterodactyl:} { send "$email\r"; exp_continue }
    -re {Email address for the initial admin account:} { send "$email\r"; exp_continue }
    -re {Username for the initial admin account:} { send "$username\r"; exp_continue }
    -re {First name for the initial admin account:} { send "Skyler\r"; exp_continue }
    -re {Last name for the initial admin account:} { send "Nodes\r"; exp_continue }
    -re {Password for the initial admin account:} { send "$password\r"; exp_continue }
    -re {Set the FQDN of this panel \(panel.example.com\):} { send "$domain\r"; exp_continue }
    -re {Do you want to automatically configure UFW \(firewall\)\? \(y/N\):} { send "n\r"; exp_continue }
    -re {Do you want to automatically configure HTTPS using Let's Encrypt\? \(y/N\):} { send "y\r"; exp_continue }
    -re {I agree that this HTTPS request is performed \(y/N\):} { send "y\r"; exp_continue }
    # Never force a DNS mismatch. Stop safely and let the user fix DNS before retrying.
    -re {Proceed anyways \(your install will be broken if you do not know what you are doing\? \(y/N\):} { send "n\r"; exp_continue }
    -re {Enable sending anonymous telemetry data\? \(yes/no\) \[yes\]:} { send "no\r"; exp_continue }
    -re {Initial configuration completed\. Continue with installation\? \(y/N\):} { send "y\r"; exp_continue }
    eof { set w [wait]; exit [lindex $w 3] }
    timeout { puts stderr "SKN: timed out waiting for an upstream installer prompt"; exit 124 }
}
SKN_EXPECT
    chmod 700 "$expect_script"

    printf '%b\n' "${CYAN}Starting Pterodactyl installer with SKN configuration...${RESET}"
    if expect "$expect_script"; then
        if [[ -f /var/www/pterodactyl/artisan ]]; then
            local installed_version=""
            if [[ -f /var/www/pterodactyl/.env ]]; then
                installed_version="$(grep -oE 'APP_VERSION=.*' /var/www/pterodactyl/.env 2>/dev/null | head -1 | cut -d= -f2- || true)"
            fi
            printf '%b\n' "${GREEN}Pterodactyl Panel installation completed successfully.${RESET}"
            printf '%b\n' "${LIGHT_BLUE}Panel URL: https://${domain}${RESET}"
            [[ -n "$installed_version" ]] && printf '%b\n' "${LIGHT_BLUE}Panel environment version: ${installed_version}${RESET}"
        else
            printf '%b\n' "${YELLOW}Installer exited, but /var/www/pterodactyl/artisan was not found.${RESET}"
            printf '%b\n' "${YELLOW}Check the installer output above for the exact reason.${RESET}"
        fi
    else
        printf '%b\n' "${RED}Pterodactyl installer failed.${RESET}"
        if [[ -f /tmp/skn-ptero-upstream.log ]]; then
            printf '%b\n' "${YELLOW}Last installer messages:${RESET}"
            tail -n 20 /tmp/skn-ptero-upstream.log | sed -E 's/\x1B\[[0-9;]*[[:alpha:]]//g'
        fi
    fi
    rm -f "$expect_script" "$installer" /tmp/skn-ptero-upstream.log /tmp/skn-dpkg-configure.log /tmp/skn-apt-fix.log /tmp/skn-apt-fix2.log /tmp/skn-apt-update.log /tmp/skn-curl-install.log /tmp/skn-expect-install.log
    unset SKN_DOMAIN SKN_EMAIL SKN_USERNAME SKN_PASSWORD SKN_TIMEZONE SKN_DB_NAME SKN_DB_USER SKN_DB_PASSWORD
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

        printf '%b\n' "${LIGHT_BLUE}"
        cat <<'SKN_PTERO_LOGO'
  ____  _                     _            _         _ 
 |  _ \| |_ ___ _ __ ___   __| | __ _  ___| |_ _   _| |
 | |_) | __/ _ \ '__/ _ \ / _\ |/ _` |/ __| __| | | | |
 |  __/| ||  __/ | | (_) | (_| | (_| | (__| |_| |_| | |
 |_|    \__\___|_|  \___/ \__,_|\__,_|\___|\__|\__, |_|
                                               |___/   
SKN_PTERO_LOGO
        printf '%b\n\n' "${RESET}"

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
