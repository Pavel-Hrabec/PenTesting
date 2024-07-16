# Install ADD Internals
Install-Module AADInternals

# Import the module
Import-Module AADInternals

# Get Tenant ID
Get-AADIntTenantID -Domain cybercheckpentest.onmicrosoft.com

# Get All domains of the tenant
Get-AADIntTenantDomains -Domain cybercheckpentest.onmicrosoft.com

# Get OpenID configuration
Get-AADIntOpenIDConfiguration -Domain cybercheckpentest.onmicrosoft.com

# Invoke reconnaissance as outsider
Invoke-AADIntReconAsOutsider -DomainName verizon.onmicrosoft.com | Format-Table

<#
| DNS - Does the DNS record exists?
| MX - https://learn.microsoft.com/en-us/microsoft-365/enterprise/external-domain-name-system-records?#external-dns-records-required-for-email-in-office-365-exchange-online | Does the MX point to Office 365? |
| SPF - https://learn.microsoft.com/en-us/microsoft-365/enterprise/external-domain-name-system-records?#external-dns-records-required-for-email-in-office-365-exchange-online | Does the SPF contain Exchange Online? |
| Type - https://learn.microsoft.com/en-us/microsoft-365/enterprise/deploy-identity-solution-identity-model?#authentication-for-hybrid-identity | Federated or Managed |
| DMARC - https://learn.microsoft.com/en-us/microsoft-365/security/office-365-security/email-authentication-dmarc-configure | Is the DMARC record configured? |
| DKIM - https://learn.microsoft.com/en-us/microsoft-365/security/office-365-security/email-authentication-dkim-configure | Is the DKIM record configured? |
| MTA-STS - https://techcommunity.microsoft.com/t5/exchange-team-blog/introducing-mta-sts-for-exchange-online/ba-p/3106386 | Is the MTA-STS recored configured? |
| STS - The FQDN of the federated IdP’s (Identity Provider) STS (Security Token Service) server |
| RPS - https://learn.microsoft.com/en-us/windows-server/identity/ad-fs/operations/create-a-relying-party-trust | Relaying parties of STS (AD FS). Requires -GetRelayingParties switch. |
#>


<#
Check if user exists

Supports four enumeration methods:

Normal 	Uses GetCredentialType endpoint to query user information
Login 	Tries to log in to Entra ID using oauth2 endpoint
Autologon 	Tries to log in to Entra ID using autologon endpoint (attempts are not logged)
RST2 	Tries to log in to Entra ID using RST2 endpoint (attempts are not logged)
#>
Invoke-AADIntUserEnumerationAsOutsider -UserName "admin.hrabec@cybercheckpentest.onmicrosoft.com", "pavel.hrabec.@cybercheckpentest.onmicrosoft.com" -method Login

# Move to Directory
cd 'E:\CyberCheck\Cloud Pentesting\Tools'

# Check if users exists from file
Get-Content .\users.txt | Invoke-AADIntUserEnumerationAsOutsider
