SKN Pterodactyl Installer

Premium Pterodactyl Installer:
- Collects only Panel Domain, Admin Email, Admin Username and Admin Password.
- Installs the latest Panel release selected by the upstream installer at install time.
- Database name/username/password are sent as blank Enter, so upstream defaults are used.
- Timezone is automatically Asia/Kolkata.
- UFW is automatically set to No.
- HTTPS/Let's Encrypt is automatically set to Yes.
- Upstream interactive configuration prompts are hidden from the terminal and handled by SKN.
- DNS mismatch is never forced; the automation answers No so the install stops safely if DNS is wrong.

Debian 11 compatibility:
- Debian 11 Bullseye is EOL. The installer switches the Debian 11 base, updates and security repositories to the Debian archive before package operations.
- It repairs interrupted dpkg state, removes held packages, and attempts apt dependency repair before starting the upstream installer.
- Debian 12/13 or Ubuntu 22.04/24.04 are recommended for new servers.

Note: pterodactyl-installer.se is an unofficial third-party installer and is not the official Pterodactyl Project.


NONSTOP FIX: DNS mismatch is auto-answered y, telemetry is auto no, initial configuration is auto y. Upstream output is hidden while a live SKN progress indicator prevents the terminal from appearing frozen.
