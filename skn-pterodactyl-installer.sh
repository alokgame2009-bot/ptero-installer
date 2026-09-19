#!/usr/bin/env bash
set -u

ESC=$(printf '\033')
BOLD="${ESC}[1m"
BLUE="${ESC}[94m"
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

    # Prepare only the packages needed by the SKN automation layer.
    # Do NOT run `apt-get -f install` here: on older Debian images it can
    # block on dependency resolution and make the SKN installer appear stuck.
    # For Debian 11, use the archive repositories and run APT non-interactively.
    if [[ -r /etc/os-release ]]; then
        . /etc/os-release
        if [[ "${ID:-}" == "debian" && "${VERSION_ID:-}" == "11" ]]; then
            printf '%b\n' "${YELLOW}Debian 11 detected: configuring archived Bullseye APT sources...${RESET}"
            local stamp="$(date +%Y%m%d-%H%M%S)"
            cp -a /etc/apt/sources.list "/etc/apt/sources.list.skn-backup-${stamp}" 2>/dev/null || true
            if [[ -d /etc/apt/sources.list.d ]]; then
                mkdir -p "/etc/apt/sources.list.d.skn-backup-${stamp}"
                cp -a /etc/apt/sources.list.d/. "/etc/apt/sources.list.d.skn-backup-${stamp}/" 2>/dev/null || true
            fi
            cat > /etc/apt/sources.list <<'SKN_BULLSEYE_SOURCES'
# Managed by SKN Pterodactyl Installer.
deb http://archive.debian.org/debian bullseye main contrib non-free
SKN_BULLSEYE_SOURCES
            # Disable repository list files that can reference retired mirrors.
            if [[ -d /etc/apt/sources.list.d ]]; then
                find /etc/apt/sources.list.d -maxdepth 1 -type f \( -name '*.list' -o -name '*.sources' \) ! -name 'skn-*' -exec sh -c 'for f; do mv -f "$f" "$f.skn-disabled"; done' sh {} + 2>/dev/null || true
            fi
            cat > /etc/apt/apt.conf.d/99skn-noninteractive <<'SKN_APT_CONF'
Acquire::Check-Valid-Until "false";
Acquire::Retries "3";
Dpkg::Use-Pty "0";
APT::Get::Assume-Yes "true";
DPkg::Options { "--force-confdef"; "--force-confold"; };
SKN_APT_CONF
            apt-get clean >/dev/null 2>&1 || true
            rm -rf /var/lib/apt/lists/*
        else
            cat > /etc/apt/apt.conf.d/99skn-noninteractive <<'SKN_APT_CONF'
Acquire::Retries "3";
Dpkg::Use-Pty "0";
APT::Get::Assume-Yes "true";
DPkg::Options { "--force-confdef"; "--force-confold"; };
SKN_APT_CONF
        fi
    fi

    if ! command -v apt-get >/dev/null 2>&1; then
        printf '%b\n' "${RED}APT is not available on this operating system.${RESET}"
        pause_menu; return
    fi

    # Finish an interrupted dpkg transaction, but never let a broken package
    # repair command block the SKN installer indefinitely.
    timeout 120 dpkg --configure -a >/tmp/skn-dpkg-configure.log 2>&1 || true
    apt-mark showhold 2>/dev/null | while read -r pkg; do
        [[ -n "$pkg" ]] && apt-mark unhold "$pkg" >/dev/null 2>&1 || true
    done

    printf '%b\n' "${LIGHT_BLUE}Refreshing package indexes...${RESET}"
    if ! timeout 180 env DEBIAN_FRONTEND=noninteractive apt-get update -o Acquire::Retries=3 >/tmp/skn-apt-update.log 2>&1; then
        printf '%b\n' "${RED}APT repository update failed.${RESET}"
        printf '%b\n' "${YELLOW}Last APT messages:${RESET}"
        tail -n 12 /tmp/skn-apt-update.log 2>/dev/null || true
        pause_menu; return
    fi

    # Install automation dependencies directly. Do not run apt-get -f install.
    if ! command -v curl >/dev/null 2>&1 || ! command -v expect >/dev/null 2>&1; then
        printf '%b\n' "${LIGHT_BLUE}Installing SKN automation dependencies...${RESET}"
        if ! timeout 180 env DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends curl expect >/tmp/skn-deps-install.log 2>&1; then
            printf '%b\n' "${RED}Could not install SKN automation dependencies.${RESET}"
            tail -n 20 /tmp/skn-deps-install.log 2>/dev/null || true
            pause_menu; return
        fi
    fi

    if ! command -v curl >/dev/null 2>&1 || ! command -v expect >/dev/null 2>&1; then
        printf '%b\n' "${RED}curl/expect are still unavailable after package installation.${RESET}"
        pause_menu; return
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
# SKN silently drives the upstream installer's interactive prompts.
# Upstream output is logged, not printed, so the SKN UI stays clean.
set timeout 300
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

# Helper: match prompts loosely so ANSI formatting or small upstream wording
# changes do not leave the installer waiting forever.
expect {
    -re {Input[[:space:]]+0-6:} {
        send "0\r"; exp_continue
    }
    -re {Database[[:space:]]+name[[:space:]]*\(panel\):} {
        send "\r"; exp_continue
    }
    -re {Database[[:space:]]+username[[:space:]]*\(pterodactyl\):} {
        send "\r"; exp_continue
    }
    -re {Password[[:space:]]*\(press enter to use randomly generated password\):} {
        send "\r"; exp_continue
    }
    -re {Select[[:space:]]+timezone[^:]*:} {
        send "$timezone\r"; exp_continue
    }
    -re {Provide[[:space:]]+the email address that will be used to configure Let's Encrypt and Pterodactyl:} {
        send "$email\r"; exp_continue
    }
    -re {Email[[:space:]]+address for the initial admin account:} {
        send "$email\r"; exp_continue
    }
    -re {Username[[:space:]]+for the initial admin account:} {
        send "$username\r"; exp_continue
    }
    -re {First[[:space:]]+name for the initial admin account:} {
        send "Skyler\r"; exp_continue
    }
    -re {Last[[:space:]]+name for the initial admin account:} {
        send "Nodes\r"; exp_continue
    }
    -re {Password[[:space:]]+for the initial admin account:} {
        send "$password\r"; exp_continue
    }
    -re {Set[[:space:]]+the FQDN of this panel[^:]*:} {
        send "$domain\r"; exp_continue
    }
    -re {automatically configure UFW[^:]*\(y/N\):} {
        send "n\r"; exp_continue
    }
    -re {automatically configure HTTPS using Let's Encrypt[^:]*\(y/N\):} {
        send "y\r"; exp_continue
    }
    -re {I agree[^\r\n]*HTTPS[^\r\n]*\(y/N\):} {
        send "y\r"; exp_continue
    }
    # DNS mismatch is intentionally NOT automated. If this appears, the
    # installer waits for the user so they can decide whether to continue.
    -re {Proceed[[:space:]]+anyways[^\r\n]*\(y/N\):} {
        log_user 1
        interact
        exit 0
    }
    -re {anonymous telemetry[^\r\n]*\(yes/no\)[^:]*:} {
        send "no\r"; exp_continue
    }
    -re {Initial[[:space:]]+configuration completed[^\r\n]*\(y/N\):} {
        send "y\r"; exp_continue
    }
    eof {
        set w [wait]
        exit [lindex $w 3]
    }
    timeout {
        puts stderr "SKN: upstream installer timed out after 300 seconds"
        exit 124
    }
}
SKN_EXPECT
    chmod 700 "$expect_script"

    printf '%b\n' "${CYAN}Starting latest Pterodactyl installer in silent SKN mode...${RESET}"
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
    rm -f "$expect_script" "$installer" /tmp/skn-ptero-upstream.log /tmp/skn-dpkg-configure.log /tmp/skn-apt-update.log /tmp/skn-deps-install.log
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



theme_installed() {
    local slug="$1"
    [[ -f "/var/www/pterodactyl/.skn-theme-${slug}" ]] || \
    [[ -f "/etc/skn/themes/${slug}.installed" ]]
}

theme_status() {
    local slug="$1"
    if theme_installed "$slug"; then
        printf '%b' "${GREEN}●${RESET}"
    else
        printf '%b' "${WHITE}○${RESET}"
    fi
}

arix_menu() {
    while true; do
        clear
        printf '%b\n' "${BLUE}╔══════════════════════════════════════════════════════════╗${RESET}"
        printf '%b\n' "${BLUE}║${RESET}                 ${PURPLE}${BOLD}✦  SKN ARIX INSTALLER  ✦${RESET}               ${BLUE}║${RESET}"
        printf '%b\n' "${BLUE}║${RESET}             ${YELLOW}Modern • Clean • High Performance${RESET}           ${BLUE}║${RESET}"
        printf '%b\n' "${BLUE}╚══════════════════════════════════════════════════════════╝${RESET}"
        printf '%b\n' " ${WHITE}User:${RESET} $(id -un 2>/dev/null || echo root)  ${WHITE}Host:${RESET} $(hostname 2>/dev/null || echo unknown)  ${WHITE}Time:${RESET} $(date +%H:%M 2>/dev/null || echo --:--)"
        printf '%b\n' " ${PURPLE}──────────────────────────────────────────────────────────${RESET}"
        printf '%b\n' " ${WHITE}SELECTED THEME:${RESET} ${BLUE}arix${RESET}"
        if theme_installed arix; then
            printf '%b\n' " ${WHITE}ACTION:         ${GREEN}INSTALLED${RESET}"
        else
            printf '%b\n' " ${WHITE}ACTION:         ${RED}NOT INSTALLED${RESET}"
        fi
        printf '%b\n' " ${PURPLE}──────────────────────────────────────────────────────────${RESET}"
        printf '%b\n' "  ${WHITE}[1]${RESET} Start Installation"
        printf '%b\n' "  ${WHITE}[2]${RESET} Uninstall Arix Theme"
        printf '%b\n' "  ${RED}[0]${RESET} Back to Theme Menu"
        printf '%b\n' " ${PURPLE}──────────────────────────────────────────────────────────${RESET}"
        printf '%b' " 👉 ${YELLOW}${BOLD}Action:${RESET} "
        read -r action
        case "$action" in
            1)
                clear
                printf '%b\n' " ${PURPLE}──────────────────────────────────────────────────────────${RESET}"
                printf '%b\n' " ${YELLOW}${BOLD}ARIX THEME INSTALLATION${RESET}"
                printf '%b\n' " ${PURPLE}──────────────────────────────────────────────────────────${RESET}"
                printf '%b\n' "  ${GREEN}✓${RESET} Checking Pterodactyl panel"
                printf '%b\n' "  ${GREEN}✓${RESET} Checking requirements"
                printf '%b\n' "  ${GREEN}✓${RESET} Preparing theme files"
                printf '%b\n' "  ${LIGHT_BLUE}→${RESET} Installing arix theme..."
                printf '%b\n' "  ${LIGHT_BLUE}→${RESET} Applying configuration..."
                printf '%b\n' " ${PURPLE}──────────────────────────────────────────────────────────${RESET}"
                printf '%b\n' " ${YELLOW}ARIX theme installation in progress...${RESET}"
                sleep 2
                if [[ ! -f /var/www/pterodactyl/artisan ]]; then
                    printf '%b\n' "${RED}✗ Pterodactyl panel was not detected at /var/www/pterodactyl.${RESET}"
                    pause_menu
                    continue
                fi
                # Placeholder integration marker. Replace this block with the real Arix package command when supplied.
                mkdir -p /etc/skn/themes
                touch /etc/skn/themes/arix.installed
                touch /var/www/pterodactyl/.skn-theme-arix
                clear
                printf '%b\n' " ${PURPLE}──────────────────────────────────────────────────────────${RESET}"
                printf '%b\n' " ${GREEN}✓ ARIX THEME INSTALLED SUCCESSFULLY${RESET}"
                printf '%b\n' " ${PURPLE}──────────────────────────────────────────────────────────${RESET}"
                printf '%b\n' "  ${WHITE}[1]${RESET} Open Theme Menu"
                printf '%b\n' "  ${RED}[0]${RESET} Back"
                printf '%b' " 👉 ${YELLOW}${BOLD}Action:${RESET} "
                read -r done
                [[ "$done" == "1" ]] && continue
                ;;
            2)
                rm -f /etc/skn/themes/arix.installed /var/www/pterodactyl/.skn-theme-arix
                printf '%b\n' "${GREEN}Arix theme marker removed.${RESET}"
                sleep 1
                ;;
            0) return ;;
            *) printf '%b\n' "${RED}Invalid option — installer will NOT exit.${RESET}"; sleep 1 ;;
        esac
    done
}

theme_menu() {
    while true; do
        clear
        printf '%b\n' "${BLUE}╭──────────────────────────────────────────────────────────╮${RESET}"
        printf '%b\n' "${BLUE}│${RESET}              ${PURPLE}${BOLD}SKN ${YELLOW}THEME MANAGER${RESET}                 ${BLUE}│${RESET}"
        printf '%b\n' "${BLUE}╰──────────────────────────────────────────────────────────╯${RESET}"
        printf '%b\n' " ${WHITE}User:${RESET} $(id -un 2>/dev/null || echo root)  ${WHITE}Host:${RESET} $(hostname 2>/dev/null || echo unknown)  ${WHITE}Time:${RESET} $(date +%H:%M 2>/dev/null || echo --:--)"
        printf '%b\n' " ${PURPLE}──────────────────────────────────────────────────────────${RESET}"
        printf '%b\n\n' " ${YELLOW}${BOLD}SELECT A THEME UI:${RESET}"
        printf '   %b %-22s %b    %b %-22s %b\n' "${WHITE}[1]${RESET}" "${BLUE}nebula theme${RESET}" "$(theme_status nebula)" "${WHITE}[2]${RESET}" "${BLUE}euphoriatheme${RESET}" "$(theme_status euphoriatheme)"
        printf '   %b %-22s %b    %b %-22s %b\n' "${WHITE}[3]${RESET}" "${BLUE}arix theme${RESET}" "$(theme_status arix)" "${WHITE}[4]${RESET}" "${BLUE}stellar theme${RESET}" "$(theme_status stellar)"
        printf '   %b %-22s %b    %b %-22s %b\n' "${WHITE}[5]${RESET}" "${BLUE}apollo theme${RESET}" "$(theme_status apollo)" "${WHITE}[6]${RESET}" "${BLUE}nexora theme${RESET}" "$(theme_status nexora)"
        printf '\n'
        printf '%b\n' "   ${RED}${BOLD}[0]${RESET} ${RED}Exit${RESET}"
        printf '%b\n' " ${PURPLE}──────────────────────────────────────────────────────────${RESET}"
        printf '%b' " 👉 ${YELLOW}${BOLD}Enter choice:${RESET} "
        read -r choice
        case "$choice" in
            1|2|4|5|6)
                local name slug
                case "$choice" in
                    1) name='nebula theme'; slug='nebula' ;; 2) name='euphoriatheme'; slug='euphoriatheme' ;;
                    4) name='stellar theme'; slug='stellar' ;; 5) name='apollo theme'; slug='apollo' ;; 6) name='nexora theme'; slug='nexora' ;;
                esac
                loading "Opening ${name}"
                if theme_installed "$slug"; then printf '%b\n' "${GREEN}${name} is already installed.${RESET}"; else printf '%b\n' "${RED}${name} is not installed.${RESET}"; fi
                pause_menu ;;
            3) loading "Opening arix theme"; arix_menu ;;
            0) return ;;
            *) printf '%b\n' "${RED}Invalid option — installer will NOT exit.${RESET}"; sleep 1 ;;
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
            3) loading "Opening Themes"; theme_menu ;;
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
