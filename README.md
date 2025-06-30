# Proaxiom Cyber – Entra ID Audit App Package

Everything you need to deploy the **Proaxiom Cyber – Audit Application** in any Microsoft Entra ID (Azure AD) tenant.

Running the PowerShell script (`Add-ProaxiomCyberAppRegistration.ps1`) will:
1. Connect to Microsoft Graph (prompting for login / tenant as needed).
2. Register the app with all required API permissions.
3. Create the corresponding Service Principal.
4. Generate a client secret (valid for 1 month) **shown once**.

---

## Prerequisites

• **PowerShell 7.x** (cross-platform, recommended) or **Windows PowerShell 5.1** with .NET Framework 4.7.2 or later.  
• Ability to install the Microsoft.Graph PowerShell SDK (requires an internet connection and installation rights).

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

1. Open the Azure portal (direct link: [App registrations](https://entra.microsoft.com/#view/Microsoft_AAD_RegisteredApps/ApplicationsListBlade/quickStartType~/null/sourceType/Microsoft_AAD_IAM)).
2. Navigate to **Entra ID / Azure Active Directory → App registrations** if not already there.
3. Locate **"Proaxiom Cyber – Audit Application".**
4. Select **API permissions** in the left-hand menu.
5. Click **Grant admin consent for <tenant>** and confirm the prompt.

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

<!-- PERMISSIONS-TABLE-START -->
| API | Permission | Type | GUID | Description |
| --- | ---------- | ---- | ---- | ----------- |
| Microsoft Graph | Application.Read.All | Role | 9a5d68dd-52b0-4cc2-bd40-abcf44ac3a30 | Allows the app to read all applications and service principals |
| Microsoft Graph | AttackSimulation.Read.All | Role | 93283d0a-6322-4fa8-966b-8c121624760d | Allows the app to read attack simulation and training data for an organization |
| Microsoft Graph | AuthenticationContext.Read.All | Role | 381f742f-e1f8-4309-b4ab-e3d91ae4c5c1 | Allows the app to read the authentication context information in your organization |
| Microsoft Graph | BackupRestore-Configuration.Read.All | Role | 5fbb5982-3230-4882-93c0-2167523ce0c2 | Allows the app to read all backup configurations, and lists of Microsoft 365 service resources to be backed-up, |
| Microsoft Graph | BackupRestore-Control.Read.All | Role | 6fe20a79-0e15-45a1-b019-834c125993a0 | Allows the app to read the status of M365 backup service (enable/disable), |
| Microsoft Graph | BackupRestore-Monitor.Read.All | Role | ecae8511-f2d7-4be4-bdbf-91f244d45986 | Allows the app to monitor all backup and restore jobs, view quota usage and billing details, |
| Microsoft Graph | CloudApp-Discovery.Read.All | Role | 64a59178-dad3-4673-89db-84fdcd622fec | Allows the app to read all details of discovered cloud apps in the organization, |
| Microsoft Graph | CloudPC.Read.All | Role | a9e09520-8ed4-4cde-838e-4fdea192c227 | Allows the app to read the properties of Cloud PCs, |
| Microsoft Graph | CrossTenantInformation.ReadBasic.All | Role | cac88765-0581-4025-9725-5ebc13f729ee | Allows the application to obtain basic tenant information about another target tenant within the Azure AD ecosystem |
| Microsoft Graph | CrossTenantUserProfileSharing.Read.All | Role | 8b919d44-6192-4f3d-8a3b-f86f8069ae3c | Allows the application to list and query any shared user profile information associated with the current tenant   It also permits the application to export external user data (e.g. customer content or system-generated logs), for any user associated with the current tenant |
| Microsoft Graph | CustomDetection.Read.All | Role | 673a007a-9e0f-4c97-b066-3c0164486909 | Allows the app to read custom detection rules |
| Microsoft Graph | CustomSecAttributeAssignment.Read.All | Role | 3b37c5a4-1226-493d-bec3-5d6c6b866f3f | Allows the app to read custom security attribute assignments for all principals in the tenant |
| Microsoft Graph | CustomSecAttributeDefinition.Read.All | Role | b185aa14-d8d2-42c1-a685-0f5596613624 | Allows the app to read custom security attribute definitions for the tenant |
| Microsoft Graph | DelegatedPermissionGrant.Read.All | Role | 81b4724a-58aa-41c1-8a55-84ef97466587 | Allows the app to read all delegated permission grants, |
| Microsoft Graph | Device.Read.All | Role | 7438b122-aefc-4978-80ed-43db9fcc7715 | Allows the app to read your organization's devices' configuration information |
| Microsoft Graph | DeviceManagementApps.Read.All | Role | 7a6ee1e7-141e-4cec-ae74-d9db155731ff | Allows the app to read the properties, group assignments and status of apps, app configurations and app protection policies managed by Microsoft Intune, |
| Microsoft Graph | DeviceManagementCloudCA.Read.All | Role | 315b6e8c-d92a-4691-919d-00ce76d1344a | Allows the app to read certification authority information |
| Microsoft Graph | DeviceManagementConfiguration.Read.All | Role | dc377aa6-52d8-4e23-b271-2a7ae04cedf3 | Allows the app to read properties of Microsoft Intune-managed device configuration and device compliance policies and their assignment to groups, |
| Microsoft Graph | DeviceManagementManagedDevices.Read.All | Role | 2f51be20-0bb4-4fed-bf7b-db946066c75e | Allows the app to read the properties of devices managed by Microsoft Intune, |
| Microsoft Graph | DeviceManagementRBAC.Read.All | Role | 58ca0d9a-1575-47e1-a3cb-007ef2e4583b | Allows the app to read the properties relating to the Microsoft Intune Role-Based Access Control (RBAC) settings, |
| Microsoft Graph | DeviceManagementScripts.Read.All | Role | c7a5be92-2b3d-4540-8a67-c96dcaae8b43 | Allows the app to read Microsoft Intune device compliance scripts, device management scripts, device shell scripts, device custom attribute shell scripts and device health scripts, |
| Microsoft Graph | DeviceManagementServiceConfig.Read.All | Role | 06a5fe6d-c49d-46a7-b082-56b1b14103c7 | Allows the app to read Microsoft Intune service properties including device enrollment and third party service connection configuration, |
| Microsoft Graph | DeviceTemplate.Read.All | Role | dd9febb5-0c6d-419f-b256-3afe12c6adeb | Allows the app to read all device templates, |
| Microsoft Graph | Directory.Read.All | Role | 7ab1d382-f21e-4acd-a863-ba3e13f7da61 | Allows the app to read data in your organization's directory, such as users, groups and apps, |
| Microsoft Graph | DirectoryRecommendations.Read.All | Role | ae73097b-cb2a-4447-b064-5d80f6093921 | Allows the app to read all Azure AD recommendations, |
| Microsoft Graph | Domain.Read.All | Role | dbb9058a-0e50-45d7-ae91-66909b5d4664 | Allows the app to read all domain properties |
| Microsoft Graph | ExternalConnection.Read.All | Role | 1914711b-a1cb-4793-b019-c2ce0ed21b8c | Allows the app to read all external connections |
| Microsoft Graph | ExternalUserProfile.Read.All | Role | 1987d7a0-d602-4262-ab90-cfdd43b37545 | Allows the app to read available properties of external user profiles, |
| Microsoft Graph | Group.Read.All | Role | 5b567255-7703-4780-807c-7be8301ae99b | Allows the app to read group properties and memberships, and read conversations for all groups, |
| Microsoft Graph | IdentityProvider.Read.All | Role | e321f0bb-e7f7-481e-bb28-e3b0b32d4bd0 | Allows the app to read your organization’s identity (authentication) providers’ properties |
| Microsoft Graph | IdentityRiskEvent.Read.All | Role | 6e472fd1-ad78-48da-a0f0-97ab2c6b769e | Allows the app to read the identity risk event information for your organization |
| Microsoft Graph | IdentityRiskyServicePrincipal.Read.All | Role | 607c7344-0eed-41e5-823a-9695ebe1b7b0 | Allows the app to read all risky service principal information for your organization, |
| Microsoft Graph | IdentityRiskyUser.Read.All | Role | dc5007c0-2d7d-4c42-879c-2dab87571379 | Allows the app to read the identity risky user information for your organization |
| Microsoft Graph | IdentityUserFlow.Read.All | Role | 1b0c317f-dd31-4305-9932-259a8b6e8099 | Allows the app to read your organization's user flows, |
| Microsoft Graph | InformationProtectionConfig.Read.All | Role | 14f49b9f-4bf2-4d24-b80e-b27ec58409bd | Allows the app to read all configurations applicable to users for protecting organizational data, |
| Microsoft Graph | InformationProtectionPolicy.Read.All | Role | 19da66cb-0fb0-4390-b071-ebc76a349482 | Allows an app to read published sensitivity labels and label policy settings for the entire organization or a specific user, |
| Microsoft Graph | MailboxSettings.Read | Role | 40f97065-369a-49f4-947c-6a255697ae91 | Allows the app to read user's mailbox settings  Does not include permission to send mail. |
| Microsoft Graph | MultiTenantOrganization.Read.All | Role | 4f994bc0-31bb-44bb-b480-7a7c1be8c02e | Allows the app to read all multi-tenant organization details and tenants, |
| Microsoft Graph | MutualTlsOauthConfiguration.Read.All | Role | 6daaff82-2880-496d-9d80-57e8e31195e2 | Allows the app to read configuration used for OAuth 2.0 mutual-TLS client authentication,  This includes reading trusted certificate authorities. |
| Microsoft Graph | PartnerSecurity.Read.All | Role | 21ffa320-2e7f-47d3-a466-7ff04d2dd68d | Allows the app to read security alerts of customer with CSP relationship, |
| Microsoft Graph | PlaceDevice.Read.All | Role | 8b724a84-ceac-4fd9-897e-e31ba8f2d7a3 | Allows the app to read all workplace devices, |
| Microsoft Graph | PlaceDeviceTelemetry.ReadWrite.All | Role | 27fc435f-44e2-4b30-bf3c-e0ce74aed618 | Allows the app to read and write telemetry for all workplace devices, |
| Microsoft Graph | Policy.Read.All | Role | 246dd0d5-5bd0-4def-940b-0421030a5b68 | Allows the app to read all your organization's policies |
| Microsoft Graph | Policy.Read.AuthenticationMethod | Role | 8e3bc81b-d2f3-4b7b-838c-32c88218d2f0 | Allows the app to read all authentication method policies for the tenant, |
| Microsoft Graph | Policy.Read.ConditionalAccess | Role | 37730810-e9ba-4e46-b07e-8ca78d182097 | Allows the app to read your organization's conditional access policies, |
| Microsoft Graph | Policy.Read.DeviceConfiguration | Role | bdba4817-6ba1-4a7c-8a01-be9bc7c242dd | Allows the application to read your organization's device configuration policies   For example, device registration policy can limit initial provisioning controls using quota restrictions, additional authentication and authorization checks. |
| Microsoft Graph | Policy.Read.IdentityProtection | Role | b21b72f6-4e6a-4533-9112-47eea9f97b28 | Allows the app to read your organization’s identity protection policy |
| Microsoft Graph | Policy.Read.PermissionGrant | Role | 9e640839-a198-48fb-8b9a-013fd6f6cbcd | Allows the app to read policies related to consent and permission grants for applications, |
| Microsoft Graph | PrivilegedAccess.Read.AzureAD | Role | 4cdc2547-9148-4295-8d11-be0db1391d6b | Allows the app to read time-based assignment and just-in-time elevation (including scheduled elevation) of Azure AD built-in and custom administrative roles in your organization, |
| Microsoft Graph | PrivilegedAccess.Read.AzureADGroup | Role | 01e37dc9-c035-40bd-b438-b2879c4870a6 | Allows the app to read time-based assignment and just-in-time elevation (including scheduled elevation) of Azure AD groups in your organization, |
| Microsoft Graph | PrivilegedAccess.Read.AzureResources | Role | 5df6fe86-1be0-44eb-b916-7bd443a71236 | Allows the app to read time-based assignment and just-in-time elevation of user privileges to audit Azure resources in your organization, |
| Microsoft Graph | PrivilegedAssignmentSchedule.Read.AzureADGroup | Role | cd4161cb-f098-48f8-a884-1eda9a42434c | Allows the app to read time-based assignment schedules for access to Azure AD groups, |
| Microsoft Graph | PrivilegedEligibilitySchedule.Read.AzureADGroup | Role | edb419d6-7edc-42a3-9345-509bfdf5d87c | Allows the app to read time-based eligibility schedules for access to Azure AD groups, |
| Microsoft Graph | ProtectionScopes.Compute.All | Role | e5a76501-dbb0-492c-ab55-5d09e8837263 | Allows the app to identify Purview data protection, compliance and governance policy scopes defined for all users across tenant. |
| Microsoft Graph | PublicKeyInfrastructure.Read.All | Role | 214fda0c-514a-4650-b037-b562b1a66124 | Allows the application to read  certificate-based authentication configuration such as all public key infrastructures (PKI) and certificate authorities (CA) configured for the organization, |
| Microsoft Graph | RecordsManagement.Read.All | Role | ac3a2b8e-03a3-4da9-9ce0-cbe28bf1accd | Allows the application to read any data from Records Management, such as configuration, labels, and policies |
| Microsoft Graph | RoleAssignmentSchedule.Read.Directory | Role | d5fe8ce8-684c-4c83-a52c-46e882ce4be1 | Allows the app to read the active role-based access control (RBAC) assignments and schedules for your company's directory,  This includes reading directory role templates, and directory roles. |
| Microsoft Graph | RoleEligibilitySchedule.Read.Directory | Role | ff278e11-4a33-4d0c-83d2-d01dc58929a5 | Allows the app to read the eligible role-based access control (RBAC) assignments and schedules for your company's directory,  This includes reading directory role templates, and directory roles. |
| Microsoft Graph | RoleManagement.Read.Directory | Role | 483bed4a-2ad3-4361-a73b-c83ccdbdc53c | Allows the app to read the role-based access control (RBAC) settings for your company's directory,   This includes reading directory role templates, directory roles and memberships. |
| Microsoft Graph | RoleManagementAlert.Read.Directory | Role | ef31918f-2d50-4755-8943-b8638c0a077e | Allows the app to read all role-based access control (RBAC) alerts for your company's directory,  This includes reading alert statuses, alert definitions, alert configurations and incidents that lead to an alert. |
| Microsoft Graph | RoleManagementPolicy.Read.Directory | Role | fdc4c997-9942-4479-bfcb-75a36d1138df | Allows the app to read policies for privileged role-based access control (RBAC) assignments of your company's directory, |
| Microsoft Graph | SecurityActions.Read.All | Role | 5e0edab9-c148-49d0-b423-ac253e121825 | Allows the app to read security actions, |
| Microsoft Graph | SecurityAlert.Read.All | Role | 472e4a4d-bb4a-4026-98d1-0b0d74cb74a5 | Allows the app to read all security alerts, |
| Microsoft Graph | SecurityAnalyzedMessage.Read.All | Role | b48f7ac2-044d-4281-b02f-75db744d6f5f | Read email metadata and security detection details, |
| Microsoft Graph | SecurityEvents.Read.All | Role | bf394140-e372-4bf9-a898-299cfc7564e5 | Allows the app to read your organization’s security events |
| Microsoft Graph | SecurityIdentitiesHealth.Read.All | Role | f8dcd971-5d83-4e1e-aa95-ef44611ad351 | Allows the app to read all the identity security health issues |
| Microsoft Graph | SecurityIdentitiesSensors.Read.All | Role | 5f0ffea2-f474-4cf2-9834-61cda2bcea5c | Allows the app to read all the identity security sensors |
| Microsoft Graph | SecurityIdentitiesUserActions.Read.All | Role | 3e5d0bee-973f-4736-a123-4e1ab146f3a8 | Allows the app to read all the identity security available user actions |
| Microsoft Graph | SecurityIncident.Read.All | Role | 45cc0394-e837-488b-a098-1918f48d186c | Allows the app to read all security incidents, |
| Microsoft Graph | SensitivityLabels.Read.All | Role | e46a01e9-b2cf-4d89-8424-bcdc6dd445ab | Allows the app to get sensitivity labels. |
| Microsoft Graph | TeamsAppInstallation.Read.All | Role | 0fdf35a5-82f8-41ff-9ded-0b761cc73512 | Allows the app to read the Teams apps that are installed in any scope,  Does not give the ability to read application-specific settings. |
| Microsoft Graph | TeamSettings.Read.All | Role | 242607bd-1d2c-432c-82eb-bdb27baa23ab | Read all team's settings, |
| Microsoft Graph | TeamsUserConfiguration.Read.All | Role | a91eadaf-2c3c-4362-908b-fb172d208fc6 | Allows the app to read your tenant's user configurations,  User configuration may include attributes related to user, such as telephone number, assigned policies, etc. |
| Microsoft Graph | TeamworkDevice.Read.All | Role | 0591bafd-7c1c-4c30-a2a5-2b9aacb1dfe8 | Allow the app to read the management data for Teams devices, |
| Microsoft Graph | ThreatIndicators.Read.All | Role | 197ee4e9-b993-4066-898f-d6aecc55125b | Allows the app to read all the indicators for your organization, |
| Microsoft Graph | ThreatIntelligence.Read.All | Role | e0b77adb-e790-44a3-b0a0-257d06303687 | Allows the app to read threat intelligence information, such as indicators, observations, and and articles, |
| Microsoft Graph | User.Read | Scope | e1fe6dd8-ba31-4d61-89e7-88639da4683d |  |
| Microsoft Graph | User.Read.All | Role | df021288-bdef-4463-88db-98f22de89214 | Allows the app to read user profiles |
| Microsoft Graph | User.ReadBasic.All | Role | 97235f07-e226-4f63-ace3-39588e11d3a1 | Allows the app to read a basic set of profile properties of other users in your organization  Includes display name, first and last name, email address, open extensions, and photo. |
| Microsoft Graph | UserAuthenticationMethod.Read.All | Role | 38d9df27-64da-44fd-b7c5-a6fbac20248f | Allows the app to read authentication methods of all users in your organization,  Authentication methods include things like a user’s phone numbers and Authenticator app settings. This does not allow the app to see secret information like passwords, or to sign-in or otherwise use the authentication methods. |
| Microsoft Graph | UserAuthMethod-Passkey.Read.All | Role | 72e00c1d-3e3d-43bb-a0b9-c435611bb1d2 | Allows the app to read passkey authentication methods of all users in your organization,  This does not allow the app to see secret information like passwords, or to sign-in or otherwise use the authentication methods. |
| WindowsDefenderATP | Machine.Read.All | Role | ea8291d3-4b9a-44b5-bc3a-6cea3026dc79 | Allows the app to read all machine profiles, including the commands that were sent to each machine |
| WindowsDefenderATP | RemediationTasks.Read.All | Role | 6a33eedf-ba73-4e5a-821b-f057ef63853a | Allows the app to read all remediation tasks |
| WindowsDefenderATP | Score.Read.All | Role | 02b005dd-f804-43b4-8fc7-078460413f74 | Allows the app to read any Threat and Vulnerability Management  score |
| WindowsDefenderATP | SecurityConfiguration.Read.All | Role | 227f2ea0-c2c2-4428-b7af-9ff40f1a720e | Allows the app to read all security configurations |
| WindowsDefenderATP | SecurityRecommendation.Read.All | Role | 6443965c-7dd2-4cfd-b38f-bb7772bee163 | Allows the app to read any Threat and Vulnerability Management security recommendation |
| WindowsDefenderATP | Software.Read.All | Role | 37f71c98-d198-41ae-964d-2c49aab74926 | Allows the app to read any Threat and Vulnerability Management software information |
| WindowsDefenderATP | Ti.Read.All | Role | 528ca142-c849-4a5b-935e-10b8b9c38a84 | Allows the app to read all IOCs |
| WindowsDefenderATP | Url.Read.All | Role | 721af526-ffa8-42d7-9b84-1a56244dd99d | Allows the app to read all URL profiles |
| WindowsDefenderATP | User.Read.All | Role | a833834a-4cf1-4732-8acf-bbcfa13fb610 | Allows the app to read all user profiles |
| WindowsDefenderATP | Vulnerability.Read.All | Role | 41269fc5-d04d-4bfd-bce7-43a51cea049a | Allows the app to read any Threat and Vulnerability Management vulnerability information |
<!-- PERMISSIONS-TABLE-END -->

