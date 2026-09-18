SKN Pterodactyl Installer
=========================
Premium Pterodactyl Install category.

Install flow:
1. Panel domain
2. Admin email
3. Admin username
4. Admin password
5. Pterodactyl release selector
6. Review configuration
7. Start installation

The SKN installer automatically supplies the upstream installer's prompts:
- Database name/user/password: upstream defaults/random generation
- Timezone: Asia/Kolkata
- Let's Encrypt email: entered admin email
- Initial admin email/username/password: entered SKN details
- Name: Skyler Nodes
- UFW: No
- HTTPS / Let's Encrypt: Yes
- Check-IP request: Yes
- DNS mismatch: No (installation stops instead of forcing a broken HTTPS setup)
- Anonymous telemetry: No
- Final install confirmation: Yes

The upstream pterodactyl-installer.se script is not affiliated with the official Pterodactyl Project.
The SKN version selector is a target/record selector; the upstream installer controls which release it actually installs.
