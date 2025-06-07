---
title: PowerShell sample - Add a custom bypass rule to internet access forwarding profile
description: PowerShell example that bypasses a certain fqdn or IP from being acquired by the GSA Client in the Internet Access forwarding profile.
author: fgomulka
manager: ashishj
ms.service: global-secure-access
ms.topic: sample
ms.date: 06/06/2025
ms.author: frankgomulka
ms.reviewer: katabish
---

# Add a custom bypass rule to Global Secure Access Internet Access

This PowerShell script demonstrates how to programmatically add a custom bypass rule to the Microsoft Entra Internet Access forwarding policy. The script finds the "Custom Bypass" forwarding policy and adds a sample rule to bypass specified domains.

The sample requires the [Microsoft Graph Beta PowerShell module](/powershell/microsoftgraph/installation) 2.10 or newer.

## Important considerations
- Run the PowerShell script as an Administrator from an elevated PowerShell session.
- Make sure you have installed the Microsoft.Graph.Beta module:
  ```powershell
  Install-Module Microsoft.Graph.Beta -AllowClobber -Force
  ```
- The account used for `Connect-MgGraph` must have the following permissions:
  - Policy.Read.All
  - NetworkAccess.ReadWrite.All

## Sample script

```powershell
# bypassscript.ps1 adds sample endpoints to the custom bypass policy in the internet access forwarding profile
# 
# Version 1.0
# 
# This script requires following 
#    - PowerShell 5.1 (x64) or beyond
#    - Module: Microsoft.Graph.Beta
#
# Before you begin:
# - Make sure you are running PowerShell as an Administrator
# - Make sure you run: Install-Module Microsoft.Graph.Beta -AllowClobber -Force
# - Make sure the account used for Connect-MgGraph has the following permissions:
#   - Policy.Read.All
#   - NetworkAccess.ReadWrite.All
# 
if (-not (Get-Module -ListAvailable -Name Microsoft.Graph.Beta.Identity.SignIns)) {
    Write-Host "Module Microsoft.Graph.Beta.Identity.SignIns is not installed. Please install it using: Install-Module Microsoft.Graph.Beta -AllowClobber"
    exit
}
Import-Module Microsoft.Graph.Beta.Identity.SignIns
Connect-MgGraph -Scopes "Policy.Read.All,NetworkAccess.ReadWrite.All"

# Find out custom bypass forwarding policy id
$custombypass = $null
$forwardingpolicies = Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/beta/networkaccess/forwardingpolicies"
foreach ($policy in $forwardingpolicies.value) {
	if ($policy.name -eq "Custom Bypass"){
		$custombypass = $policy.id
	}
}
if ($custombypass -eq $null) {
	Write-Host "Could not find the IA custom bypass forwarding policy. Exiting."
	exit
}

# First, Bypass the Intune endpoints
$samplerule = [PSCustomObject]@{
    name = "Sample FQDN bypass rule"
    action = "bypass"
    destinations = @()
    ruleType = "fqdn"
    ports = @("80", "443")
    protocol = "tcp"
    '@odata.type' = "#microsoft.graph.networkaccess.internetAccessForwardingRule"
}
$sampledomains = @(
	"bing.com",
	"*.bing.com"
)

foreach ($sampledomain in $sampledomains) {
	$fqdn = [PSCustomObject]@{
	   '@odata.type' = "#microsoft.graph.networkaccess.fqdn"
	   value = $sampledomain
	}
	$samplerule.destinations += $fqdn
}
$body = $samplerule | ConvertTo-Json
Invoke-MgGraphRequest -Method POST -Uri "https://graph.microsoft.com/beta/networkaccess/forwardingPolicies('$($custombypass)')/policyRules" -Body $body -ContentType "application/json"

# Next, Bypass the sample IP-based endpoints
$sampleipbypassrule = [PSCustomObject]@{
    name = "Sample IP bypass rule"
    action = "bypass"
    destinations = @()
    ruleType = "ipSubnet"
    ports = @("80", "443")
    protocol = "tcp"
    '@odata.type' = "#microsoft.graph.networkaccess.internetAccessForwardingRule"
}
$sampleipbypassdomains = @(
	"1.2.3.4/32"
)
foreach ($sampleipbypassdomain in $sampleipbypassdomains) {
	$ip = [PSCustomObject]@{
	   '@odata.type' = "#microsoft.graph.networkaccess.ipSubnet"
	   value = $sampleipbypassdomain
	}
	$sampleipbypassrule.destinations += $ip
}
$body = $sampleipbypassrule | ConvertTo-Json
Invoke-MgGraphRequest -Method POST -Uri "https://graph.microsoft.com/beta/networkaccess/forwardingPolicies('$($custombypass)')/policyRules" -Body $body -ContentType "application/json"
```

## Next steps

- [Microsoft Graph PowerShell overview](/powershell/microsoftgraph/overview)
