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

    # Ubuntu-only preparation: supported targets are Ubuntu 22.04 LTS and 24.04 LTS.
    # The upstream Pterodactyl installer supports both versions with PHP 8.3.
    if [[ ! -r /etc/os-release ]]; then
        printf '%b\n' "${RED}Cannot detect operating system.${RESET}"
        pause_menu; return
    fi
    . /etc/os-release
    local os_major="${VERSION_ID%%.*}"
    if [[ "${ID:-}" != "ubuntu" || ( "$os_major" != "22" && "$os_major" != "24" ) ]]; then
        printf '%b\n' "${RED}This SKN Panel installer supports Ubuntu 22.04 LTS and Ubuntu 24.04 LTS only.${RESET}"
        printf '%b\n' "${YELLOW}Detected: ${PRETTY_NAME:-Unknown}${RESET}"
        printf '%b\n' "${YELLOW}Please use a fresh Ubuntu 22.04/24.04 VPS.${RESET}"
        pause_menu; return
    fi

    printf '%b\n' "${LIGHT_BLUE}Detected supported OS: ${PRETTY_NAME}${RESET}"
    printf '%b\n' "${LIGHT_BLUE}Preparing Ubuntu packages...${RESET}"

    # Fast Ubuntu package preparation. Do not run a full upgrade: the SKN
    # installer only needs curl/expect/CA certificates before handing control
    # to the Pterodactyl installer. Ubuntu 24.04 stores its official sources
    # in ubuntu.sources; 22.04 normally uses sources.list.
    mkdir -p /etc/apt/apt.conf.d
    cat > /etc/apt/apt.conf.d/99skn-fast <<'SKN_APT_CONF'
Acquire::Retries "1";
Acquire::http::Timeout "15";
Acquire::https::Timeout "15";
Acquire::ftp::Timeout "15";
Dpkg::Use-Pty "0";
APT::Get::Assume-Yes "true";
DPkg::Options { "--force-confdef"; "--force-confold"; };
SKN_APT_CONF

    # Repair only an interrupted dpkg transaction. Never perform a broad
    # dist-upgrade here because that makes a hosting installer unnecessarily
    # slow and can introduce unrelated package changes.
    timeout 60 dpkg --configure -a >/tmp/skn-dpkg-configure.log 2>&1 || true

    # If curl + expect already exist, skip APT completely. This is the fastest
    # path on most fresh Ubuntu VPS images.
    if command -v curl >/dev/null 2>&1 && command -v expect >/dev/null 2>&1; then
        printf '%b\n' "${GREEN}curl and expect are already installed — skipping APT refresh.${RESET}"
    else
        printf '%b\n' "${LIGHT_BLUE}Preparing official Ubuntu repositories...${RESET}"

        # Third-party repositories can make apt update wait or fail. Temporarily
        # disable non-Ubuntu source files during SKN bootstrap; their files are
        # restored after package installation. Ubuntu's own ubuntu.sources or
        # sources.list remains untouched.
        local disabled_sources="/tmp/skn-disabled-apt-sources"
        rm -rf "$disabled_sources"; mkdir -p "$disabled_sources"
        shopt -s nullglob
        for src in /etc/apt/sources.list.d/*.list /etc/apt/sources.list.d/*.sources; do
            [[ "$(basename "$src")" == "ubuntu.sources" ]] && continue
            mv "$src" "$disabled_sources/" 2>/dev/null || true
        done
        shopt -u nullglob

        printf '%b\n' "${LIGHT_BLUE}Refreshing Ubuntu package indexes...${RESET}"
        local apt_ok=0
        if timeout 90 env DEBIAN_FRONTEND=noninteractive apt-get update -o Acquire::Retries=1 >/tmp/skn-apt-update.log 2>&1; then
            apt_ok=1
        else
            # One controlled fallback for mirror/network hiccups. Use HTTPS
            # archive.ubuntu.com without touching the user's normal sources.
            printf '%b\n' "${YELLOW}Primary Ubuntu mirror did not respond; trying archive.ubuntu.com...${RESET}"
            local codename="${VERSION_CODENAME:-}"
            if [[ -n "$codename" ]]; then
                cat > /tmp/skn-bootstrap.sources <<EOF
Types: deb
URIs: https://archive.ubuntu.com/ubuntu/
Suites: $codename $codename-updates $codename-backports
Components: main universe restricted multiverse
Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg

Types: deb
URIs: https://security.ubuntu.com/ubuntu/
Suites: $codename-security
Components: main universe restricted multiverse
Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg
EOF
                mv /tmp/skn-bootstrap.sources /etc/apt/sources.list.d/ubuntu-skn-bootstrap.sources
                if timeout 90 env DEBIAN_FRONTEND=noninteractive apt-get update -o Acquire::Retries=1 >/tmp/skn-apt-update.log 2>&1; then
                    apt_ok=1
                fi
            fi
        fi

        if [[ "$apt_ok" != "1" ]]; then
            printf '%b\n' "${RED}Ubuntu APT could not refresh package indexes.${RESET}"
            printf '%b\n' "${YELLOW}Last APT messages:${RESET}"
            tail -n 25 /tmp/skn-apt-update.log 2>/dev/null || true
            # Restore third-party source files before returning.
            shopt -s nullglob
            for src in "$disabled_sources"/*.list "$disabled_sources"/*.sources; do
                mv "$src" /etc/apt/sources.list.d/ 2>/dev/null || true
            done
            shopt -u nullglob
            rm -f /etc/apt/sources.list.d/ubuntu-skn-bootstrap.sources
            pause_menu; return
        fi

        printf '%b\n' "${LIGHT_BLUE}Installing SKN automation packages...${RESET}"
        if ! timeout 120 env DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends curl expect ca-certificates >/tmp/skn-deps-install.log 2>&1; then
            printf '%b\n' "${RED}Could not install SKN automation packages.${RESET}"
            tail -n 25 /tmp/skn-deps-install.log 2>/dev/null || true
            shopt -s nullglob
            for src in "$disabled_sources"/*.list "$disabled_sources"/*.sources; do
                mv "$src" /etc/apt/sources.list.d/ 2>/dev/null || true
            done
            shopt -u nullglob
            rm -f /etc/apt/sources.list.d/ubuntu-skn-bootstrap.sources
            pause_menu; return
        fi

        # Restore third-party repositories after bootstrap. They are not needed
        # for the Pterodactyl install itself.
        shopt -s nullglob
        for src in "$disabled_sources"/*.list "$disabled_sources"/*.sources; do
            mv "$src" /etc/apt/sources.list.d/ 2>/dev/null || true
        done
        shopt -u nullglob
        rm -f /etc/apt/sources.list.d/ubuntu-skn-bootstrap.sources
    fi

    if ! command -v curl >/dev/null 2>&1 || ! command -v expect >/dev/null 2>&1; then
        printf '%b\n' "${RED}curl/expect are unavailable after package preparation.${RESET}"
        pause_menu; return
    fi

    local installer="/tmp/skn-pterodactyl-installer.sh"
    if ! curl -fsSL https://pterodactyl-installer.se -o "$installer"; then
        printf '%b\n' "${RED}Could not download the Pterodactyl installer.${RESET}"
        pause_menu; return
    fi
    chmod 700 "$installer"

    # The upstream installer performs its own apt update. A third-party
    # repository (for example Cloudflare's repo) can block or break that
    # update even though curl/expect are already installed. Temporarily move
    # non-Ubuntu sources aside for the duration of the panel installation.
    local upstream_disabled="/tmp/skn-upstream-disabled-apt"
    rm -rf "$upstream_disabled"; mkdir -p "$upstream_disabled"
    shopt -s nullglob
    for src in /etc/apt/sources.list.d/*.list /etc/apt/sources.list.d/*.sources; do
        base="$(basename "$src")"
        [[ "$base" == "ubuntu.sources" ]] && continue
        mv "$src" "$upstream_disabled/" 2>/dev/null || true
    done
    shopt -u nullglob

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
set timeout 900
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
    # DNS mismatch: always proceed automatically.
    -re {Proceed[[:space:]]+anyways[^\r\n]*\(y/N\):} {
        send "y\r"; exp_continue
    }
    # Also catch DNS bypass prompts if upstream wording changes slightly.
    -re {(?i)proceed[^\r\n]*(anyway|anyways)[^\r\n]*\(y/N\):} {
        send "y\r"; exp_continue
    }
    -re {anonymous telemetry[^\r\n]*\(yes/no\)[^:]*:} {
        send "no\r"; exp_continue
    }
    -re {(?i)enable sending anonymous telemetry data[^\r\n]*:} {
        send "no\r"; exp_continue
    }
    -re {Initial[[:space:]]+configuration completed[^\r\n]*\(y/N\):} {
        send "y\r"; exp_continue
    }
    -re {(?i)initial configuration completed[^\r\n]*\(y/N\):} {
        send "y\r"; exp_continue
    }
    eof {
        set w [wait]
        exit [lindex $w 3]
    }
    timeout {
        puts stderr "SKN: upstream installer timed out after 900 seconds"
        exit 124
    }
}
SKN_EXPECT
    chmod 700 "$expect_script"

    printf '%b\n' "${CYAN}Starting latest Pterodactyl installer in silent SKN mode...${RESET}"
    printf '%b\n' "${LIGHT_BLUE}SKN automation is answering installer prompts automatically. Installation may take several minutes...${RESET}"

    # Keep upstream output hidden, but show a live SKN progress indicator so
    # the terminal never looks frozen while apt/PHP/Composer/SSL work runs.
    expect "$expect_script" >/tmp/skn-expect-stdout.log 2>/tmp/skn-expect-stderr.log &
    local expect_pid=$!
    local spin='|/-\\'
    local i=0
    while kill -0 "$expect_pid" 2>/dev/null; do
        printf '\r%b' "${CYAN}  SKN INSTALLATION IN PROGRESS ${spin:i%4:1}  ${RESET}"
        sleep 1
        i=$((i+1))
    done
    wait "$expect_pid"
    local expect_rc=$?
    printf '\r%b\n' "${GREEN}  SKN INSTALLATION PROCESS FINISHED.                         ${RESET}"

    if [[ "$expect_rc" -eq 0 ]]; then
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
        printf '%b\n' "${RED}Pterodactyl installer failed (exit code ${expect_rc}).${RESET}"
        if [[ -f /tmp/skn-ptero-upstream.log ]]; then
            printf '%b\n' "${YELLOW}Last installer messages:${RESET}"
            tail -n 30 /tmp/skn-ptero-upstream.log | sed -E 's/\x1B\[[0-9;]*[[:alpha:]]//g'
        fi
        if [[ -s /tmp/skn-expect-stderr.log ]]; then
            printf '%b\n' "${YELLOW}Automation messages:${RESET}"
            tail -n 10 /tmp/skn-expect-stderr.log
        fi
    fi
    # Restore any third-party repositories after the upstream installer exits.
    shopt -s nullglob
    for src in "$upstream_disabled"/*.list "$upstream_disabled"/*.sources; do
        mv "$src" /etc/apt/sources.list.d/ 2>/dev/null || true
    done
    shopt -u nullglob
    rm -rf "$upstream_disabled"
    rm -f "$expect_script" "$installer" /tmp/skn-ptero-upstream.log /tmp/skn-expect-stdout.log /tmp/skn-expect-stderr.log /tmp/skn-dpkg-configure.log /tmp/skn-apt-update.log /tmp/skn-deps-install.log
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
