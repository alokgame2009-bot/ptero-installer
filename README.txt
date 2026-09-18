SKN Pterodactyl Installer - Connected Version + APT Fix

Changes in this build:
- SKN installer collects domain, admin email, username, password and a real Pterodactyl release selection.
- Selected version is bound to the downloaded upstream installer instead of being display-only.
- Database name, database username and database password are supplied automatically during installation.
- Timezone is automatically set to Asia/Kolkata.
- Admin first/last name are automatically set to Skyler / Nodes.
- UFW is automatically answered No.
- Let's Encrypt HTTPS is automatically answered Yes, including its agreement prompt.
- DNS mismatch / "Proceed anyways" is NOT auto-answered. If it appears, the user gets the choice so a broken HTTPS setup is not silently forced.
- Telemetry is automatically answered No.
- On Debian 11, the installer detects the Bullseye EOL repository problem and prepares archive-compatible APT sources before installing dependencies.
- Temporary installer/config files are removed after the run.

Important:
- pterodactyl-installer.se is an unofficial third-party installer, not the official Pterodactyl Project.
- Debian 11 reached LTS end-of-life on 31 August 2026. Debian 12 or 13 is recommended for new servers.
