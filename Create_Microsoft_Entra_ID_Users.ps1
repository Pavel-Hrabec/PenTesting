<#
Script: Create_Microsoft_Entra_ID_Users.ps1
Description: This script creates Azure AD users using Azure PowerShell module.
Link to documentation: https://learn.microsoft.com/bs-latn-ba/powershell/azure/install-azps-windows?view=azps-10.4.1&tabs=powershell&pivots=windows-psgallery
Prerequisites:
1. Azure PowerShell module should be installed. You can install it by running:
   Install-Module -Name Az -AllowClobber -Scope CurrentUser -Force
2. You should have the necessary permissions to create users in Azure AD.

If you are facing some problems while authenticating, use 'Connect-AzAccount' before running this script
#>


# Prompt for Subscription ID
$subscriptionID = Read-Host "Please enter Subscription ID"

# Prompt for password
$password = Read-Host "Please enter a unique password"
$secured = ConvertTo-SecureString -String $password -AsPlainText -Force

# Authenticate to Azure
Update-AzConfig -EnableLoginByWam $false
Update-AzConfig -LoginExperienceV2 "Off"
Update-AzConfig -DefaultSubscriptionForLogin $subscriptionId
az login --scope https://graph.microsoft.com//.default

# Set the context to the specified subscription
Set-AzContext -SubscriptionId $subscriptionId

# Retrieve user UPN suffix
$userPrincipalName = az ad signed-in-user show --query userPrincipalName --output tsv
$upnSuffix = $userPrincipalName.Split('@')[1]



# Define users
$users = "john@$upnSuffix","jane@$upnSuffix","alex@$upnSuffix","emily@$upnSuffix","sarah@$upnSuffix","david@$upnSuffix","alice@$upnSuffix","michael@$upnSuffix","olivia@$upnSuffix","matthew@$upnSuffix","sophia@$upnSuffix","william@$upnSuffix","ava@$upnSuffix","james@$upnSuffix","oliver@$upnSuffix","ella@$upnSuffix","charlotte@$upnSuffix","logan@$upnSuffix","lucas@$upnSuffix","mia@$upnSuffix","amelia@$upnSuffix","benjamin@$upnSuffix","henry@$upnSuffix","ella@$upnSuffix","chloe@$upnSuffix","jackson@$upnSuffix","amelia@$upnSuffix","daniel@$upnSuffix","ella@$upnSuffix"


# Create users
foreach ($user in $users) { 
    $displayName = $user.Split('@')[0]
    $mailNickname = $displayName
    New-AzADUser -DisplayName $displayName -UserPrincipalName $user -Password $secured -MailNickname $mailNickname
}

# Output success message
Write-Output "Successfully created all the users:"
Write-Output "Use this password: $password"