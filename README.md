# Proaxiom Cyber – Entra ID Audit App Package

Everything you need to deploy the **Proaxiom Cyber – Audit Application** in any Microsoft Entra ID (Azure AD) tenant.

Running the PowerShell script (`Add-ProaxiomCyberAppRegistration.ps1`) will:
1. Connect to Microsoft Graph (prompting for login / tenant as needed).
2. Register the app with all required API permissions.
3. Create the corresponding Service Principal.
4. Generate a client secret (valid for 1 month) **shown once**.

---

## Quick Start

```powershell
# Install Microsoft Graph SDK if you haven't already
Install-Module Microsoft.Graph -Scope CurrentUser

# Run the script (interactive tenant selection)
.\Add-ProaxiomCyberAppRegistration.ps1

# Or target a specific tenant
.\Add-ProaxiomCyberAppRegistration.ps1 -TenantId 01234567-89ab-cdef-0123-456789abcdef
```

---

## Post-deployment: Grant admin consent

After the script finishes, grant tenant-wide admin consent for the newly created application:

1. Open the Azure portal and navigate to **Entra ID / Azure Active Directory → App registrations**.
2. Locate **"Proaxiom Cyber – Audit Application".**
3. Select **API permissions** in the left-hand menu.
4. Click **Grant admin consent for <tenant>** and confirm the prompt.

This authorises the application to use the Microsoft Graph roles and scopes that were added automatically by the script.

---

## Delivering the Client Secret Securely

1. Copy the client-secret value that the script prints.
2. Go to **Proaxiom Pass** → <https://pass.proaxiom.com>.
3. Paste the secret into Proaxiom Pass, set an expiry (e.g. 1 day) and generate a secure share link.
4. Send the generated link—**never the plain secret**—to your Proaxiom Cyber contact via **Teams** or **Signal**.

---

## Repository Contents

| Path / File | Purpose |
|-------------|---------|
| `Add-ProaxiomCyberAppRegistration.ps1` | Self-contained deployment script |
| `docs/` | Architecture, permission rationale, troubleshooting |
| `samples/` | Example CI/CD or Terraform snippets (coming soon) |

---

## Security Notes

• The client secret is created with a default **30-day expiry**.  
• The client secret cannot be retrieved later—store or transmit it safely using the steps above.

---

## Contributing

Issues welcome for bugs, enhancements, or docs updates.

---

## License

MIT 