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
    local domain email username password version_choice version
    local first_name="Skyler" last_name="Nodes"
    local versions=("v1.15.1" "v1.15.0" "v1.14.1" "v1.14.0" "v1.13.0" "v1.12.4" "v1.12.3" "v1.12.2" "v1.12.1" "v1.12.0" "v1.11.11" "v1.11.10" "v1.11.9" "v1.11.8" "v1.11.7" "v1.11.6" "v1.11.5" "v1.11.4" "v1.11.3" "v1.11.2")

    printf '%b\n' "${LIGHT_BLUE}                 PREMIUM PTERODACTYL INSTALLER${RESET}"
    printf '%b\n' "${CYAN}────────────────────────────────────────────────────────────${RESET}"

    printf '%b\n' "  ${WHITE}• Panel Domain ${LIGHT_BLUE}[panel.example.com]${RESET}"
    printf '%b' "  ${LIGHT_BLUE}╰─> ${RESET}"; read -r domain
    printf '%b\n' "  ${WHITE}• Admin Email ${LIGHT_BLUE}[admin@example.com]${RESET}"
    printf '%b' "  ${LIGHT_BLUE}╰─> ${RESET}"; read -r email
    printf '%b\n' "  ${WHITE}• Admin Username ${LIGHT_BLUE}[admin]${RESET}"
    printf '%b' "  ${LIGHT_BLUE}╰─> ${RESET}"; read -r username
    printf '%b\n' "  ${WHITE}• Admin Password ${LIGHT_BLUE}[hidden]${RESET}"
    printf '%b' "  ${LIGHT_BLUE}╰─> ${RESET}"; read -rs password; printf '\n'

    printf '%b\n' "  ${WHITE}:: Available Panel Versions${RESET}"
    local i
    for i in "${!versions[@]}"; do
        printf '%b\n' "  ${WHITE}$((i+1)).${RESET} ${LIGHT_BLUE}${versions[$i]}${RESET}"
    done

    while true; do
        printf '%b\n' "  ${WHITE}• Select version [1-20] [1 = latest]${RESET}"
        printf '%b' "  ${LIGHT_BLUE}╰─> ${RESET}"; read -r version_choice
        if [[ "$version_choice" =~ ^[0-9]+$ ]] && ((version_choice >= 1 && version_choice <= 20)); then
            version="${versions[$((version_choice-1))]}"
            break
        fi
        printf '%b\n' "${RED}Invalid version. Please choose 1-20.${RESET}"
    done

    printf '\n%b\n' "  ${CYAN}┌─[ REVIEW CONFIGURATION ]${RESET}"
    printf '%b\n' "  ${CYAN}│${RESET} Domain:   ${LIGHT_BLUE}${domain}${RESET}"
    printf '%b\n' "  ${CYAN}│${RESET} Email:    ${LIGHT_BLUE}${email}${RESET}"
    printf '%b\n' "  ${CYAN}│${RESET} User:     ${LIGHT_BLUE}${username}${RESET}"
    printf '%b\n' "  ${CYAN}│${RESET} Version:  ${LIGHT_BLUE}${version}${RESET}"
    printf '%b\n' "  ${CYAN}└───────────────────────────${RESET}"

    local confirm
    printf '%b' "\n  ${WHITE}Start Installation? (y/n): ${RESET}"; read -r confirm
    if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
        printf '%b\n' "${YELLOW}Installation cancelled.${RESET}"
        pause_menu
        return
    fi

    if [[ ! "$domain" =~ ^[A-Za-z0-9.-]+$ || -z "$email" || -z "$username" || -z "$password" ]]; then
        printf '%b\n' "${RED}Invalid configuration. Domain, email, username and password are required.${RESET}"
        pause_menu
        return
    fi

    if ! command -v curl >/dev/null 2>&1; then
        apt-get update && apt-get install -y curl || { pause_menu; return; }
    fi

    # The upstream installer is interactive. SKN drives its prompts from the
    # configuration entered above, so the user does not have to re-enter them.
    # Automatic choices:
    #   database credentials = generated by upstream installer
    #   timezone             = Asia/Kolkata
    #   first/last name      = Skyler / Nodes
    #   UFW                  = no
    #   Let's Encrypt        = yes
    #   IP check             = yes
    #   telemetry            = no
    #   final confirmation   = yes
    #
    # If the DNS check fails, SKN answers "no" to "Proceed anyways" so an
    # obviously broken HTTPS installation is not forced through.
    printf '%b\n' "${LIGHT_BLUE}Starting Pterodactyl installer with SKN configuration...${RESET}"
    printf '%b\n' "${CYAN}Selected release: ${version}${RESET}"
    printf '%b\n' "${CYAN}Automatic setup: Asia/Kolkata • HTTPS: ON • UFW: OFF • Telemetry: OFF${RESET}"
    printf '%b\n' "${CYAN}────────────────────────────────────────────────────────────${RESET}"

    local expect_file="/tmp/skn-ptero-install-$$.expect"
    cat > "$expect_file" <<'EXPECT'
#!/usr/bin/expect -f
set timeout -1
set domain [lindex $argv 0]
set email [lindex $argv 1]
set username [lindex $argv 2]
set password [lindex $argv 3]
set first_name "Skyler"
set last_name "Nodes"

spawn bash -c {curl -fsSL https://pterodactyl-installer.se | bash}

expect {
    -re {Input 0-6:} { send "0\r"; exp_continue }
    -re {Database name \(panel\):} { send "\r"; exp_continue }
    -re {Database username \(pterodactyl\):} { send "\r"; exp_continue }
    -re {Password \(press enter to use randomly generated password\):} { send "\r"; exp_continue }
    -re {Select timezone \[Europe/Stockholm\]:} { send "Asia/Kolkata\r"; exp_continue }
    -re {Provide the email address.*Let's Encrypt.*Pterodactyl:} { send -- "$email\r"; exp_continue }
    -re {Email address for the initial admin account:} { send -- "$email\r"; exp_continue }
    -re {Username for the initial admin account:} { send -- "$username\r"; exp_continue }
    -re {First name for the initial admin account:} { send -- "$first_name\r"; exp_continue }
    -re {Last name for the initial admin account:} { send -- "$last_name\r"; exp_continue }
    -re {Password for the initial admin account:} { send -- "$password\r"; exp_continue }
    -re {Set the FQDN of this panel.*:} { send -- "$domain\r"; exp_continue }
    -re {automatically configure UFW.*\(y/N\):} { send "n\r"; exp_continue }
    -re {automatically configure HTTPS.*Let's Encrypt.*\(y/N\):} { send "y\r"; exp_continue }
    -re {I agree that this HTTPS request is performed.*\(y/N\):} { send "y\r"; exp_continue }
    -re {Proceed anyways.*\(y/N\):} { send "n\r"; exp_continue }
    -re {Enable sending anonymous telemetry data\?.*\[yes\]:} { send "no\r"; exp_continue }
    -re {Initial configuration completed\. Continue with installation\?.*\(y/N\):} { send "y\r"; exp_continue }
    eof
}
EXPECT
    chmod 700 "$expect_file"

    if ! command -v expect >/dev/null 2>&1; then
        printf '%b\n' "${LIGHT_BLUE}Installing Expect for non-interactive prompt handling...${RESET}"
        apt-get update && apt-get install -y expect || {
            rm -f "$expect_file"
            printf '%b\n' "${RED}Could not install Expect. Installation stopped.${RESET}"
            pause_menu
            return
        }
    fi

    expect "$expect_file" "$domain" "$email" "$username" "$password"
    local rc=$?
    rm -f "$expect_file"

    if (( rc != 0 )); then
        printf '%b\n' "${RED}Pterodactyl installation failed or was cancelled.${RESET}"
        pause_menu
        return
    fi

    if [[ ! -f /var/www/pterodactyl/artisan ]]; then
        printf '%b\n' "${RED}Panel installation did not complete successfully.${RESET}"
        pause_menu
        return
    fi

    printf '%b\n' "${GREEN}Panel installation completed.${RESET}"
    printf '%b\n' "${LIGHT_BLUE}Panel URL: https://${domain}${RESET}"
    printf '%b\n' "${YELLOW}Note: the upstream installer currently installs its supported release. The SKN version selector records your selected target, but it does not force an unsupported historical release.${RESET}"
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
