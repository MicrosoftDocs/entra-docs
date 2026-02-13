---
title: PowerShell Sample - Install the Global Secure Access Windows Client as Proof of Concept
description: Install the Global Secure Access Windows client as a proof of concept. This script automates installation and applies essential configurations.
author: HULKsmashGithub
ms.author: jayrusso
ms.topic: sample
ms.date: 11/18/2025
ms.reviewer: JeffBley

#customer intent: As an IT admin, I want to automate the installation of the Global Secure Access Windows client so that I can save time during proof-of-concept deployments.

---

# Use PowerShell to install the Global Secure Access Windows client as a proof of concept

To test the Global Secure Access Windows client as a proof of concept, use this script to automate the installation of the Global Secure Access client for Windows for proof-of-concept deployments. This script performs the following actions:

- Detects whether the Global Secure Access client is already installed. If not, the script installs the correct Global Secure Access client (Arm vs x86) depending on the detected Windows architecture.
- Sets several registry keys that configure the following settings:
  - Sets `IPv4Preferred` to prefer IPv4 over IPv6 traffic.
  - Sets `FarKdcTimeout` to 0 to avoid [Kerberos Negative Caching](../how-to-configure-kerberos-sso.md#how-to-avoid-kerberos-negative-caching-on-windows-machines).
  - Increases the Transmission Control Protocol (TCP) connection timeout threshold to 60 seconds to allow time to complete MFA during Remote Desktop Protocol (RDP) connection attempts.
  - Unhides several buttons in the Global Secure Access client.
  - Disables Domain Name System (DNS) over HTTPS in Microsoft Edge and Chrome browsers (if the corresponding browser is present).
  - Disables QUIC in Microsoft Edge and Chrome browsers (if the corresponding browser is present).
- Creates a `policy.json` file in the Firefox folder to disable DNS over HTTPS and QUIC if Firefox is present.
- Prompts for a device reboot if the script changes the registry key for `IPv4Preferred` (the registry change doesn't take effect until the device reboots).

```powershell
# --- Helper: Admin check ---
function Test-IsAdmin {
    $id = [Security.Principal.WindowsIdentity]::GetCurrent()
    $pr = New-Object Security.Principal.WindowsPrincipal($id)
    return $pr.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}
if (-not (Test-IsAdmin)) {
    Write-Host "This script must be run as Administrator. Please right-click and select 'Run as Administrator' before trying again." -ForegroundColor Red
    exit 1
}
# --- Config ---
$ReleaseHistoryUrl = "https://learn.microsoft.com/en-us/entra/global-secure-access/reference-windows-client-release-history"
$DownloadUrlX64    = "https://aka.ms/GlobalSecureAccess-Windows"
$DownloadUrlARM    = "https://aka.ms/GlobalSecureAccess-WindowsOnArm"
$InstallerPath     = Join-Path $env:TEMP "GSAClient.exe"
$ExePath           = "C:\Program Files\Global Secure Access Client\GlobalSecureAccessEngineService.exe"
# Registry settings for Global Secure Access client, Edge DoH/QUIC, Chrome DoH/QUIC
$RegistrySettings = @(
    # Global Secure Access-related keys
    @{ Key="HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters"; Name="DisabledComponents"; Type="DWord"; Value=255 },
    @{ Key="HKLM:\SYSTEM\CurrentControlSet\Control\Lsa\Kerberos\Parameters"; Name="FarKdcTimeout"; Type="DWord"; Value=0 },
    @{ Key="HKLM:\Software\Microsoft\Terminal Server Client"; Name="TimeoutTcpDirectConnection"; Type="DWord"; Value=60 },
    @{ Key="HKLM:\Software\Microsoft\Global Secure Access Client"; Name="HideDisablePrivateAccessButton"; Type="DWord"; Value=0 },
    @{ Key="HKLM:\Software\Microsoft\Global Secure Access Client"; Name="HideDisableButton"; Type="DWord"; Value=0 },
    @{ Key="HKLM:\Software\Microsoft\Global Secure Access Client"; Name="HideSignOutButton"; Type="DWord"; Value=0 },
    # Edge DoH and QUIC settings
    @{ Key="HKLM:\SOFTWARE\Policies\Microsoft\Edge"; Name="BuiltInDnsClientEnabled"; Type="DWord"; Value=0 },
    @{ Key="HKLM:\SOFTWARE\Policies\Microsoft\Edge"; Name="QuicAllowed"; Type="DWord"; Value=0 },
    # Chrome DoH and QUIC settings
    @{ Key="HKLM:\SOFTWARE\Policies\Google\Chrome"; Name="DnsOverHttpsMode"; ype="String"; Value="off" },
    @{ Key="HKLM:\SOFTWARE\Policies\Google\Chrome"; Name="QuicAllowed"; Type="DWord"; Value=0 }
)
# --- Track whether the IPv4-preferred setting was already correct ---
# We will only prompt for reboot if this value needed to change.
$Ipv6ParamsKey                 = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters"
$Ipv4PrefValueName             = "DisabledComponents"
$Ipv4PrefDesired               = 255
$WasIpv4PreferredAlreadyCorrect = $false
try {
    $prop = Get-ItemProperty -Path $Ipv6ParamsKey -Name $Ipv4PrefValueName -ErrorAction Stop
    $WasIpv4PreferredAlreadyCorrect = ([int64]$prop.$Ipv4PrefValueName -eq [int64]$Ipv4PrefDesired)
} catch {
    $WasIpv4PreferredAlreadyCorrect = $false
}
if (-not (Test-IsAdmin)) {
    Write-Error "This script must be run as Administrator."
    exit 1
}
# --- Helper: Enforce registry key value ---
function Ensure-RegistryValue {
    param(
        [Parameter(Mandatory)] [string] $Key,
        [Parameter(Mandatory)] [string] $Name,
        [Parameter(Mandatory)] [ValidateSet('String','ExpandString','Binary','DWord','MultiString','QWord')]
        [string] $Type,
        [Parameter(Mandatory)] $Value
    )
    if (-not (Test-Path -Path $Key)) {
        New-Item -Path $Key -Force | Out-Null
        Write-Host "Created key: $Key" -ForegroundColor DarkCyan
    }
    $hasValue = $false
    $current = $null
    try {
        $prop = Get-ItemProperty -Path $Key -Name $Name -ErrorAction Stop
        $current = $prop.$Name
        $hasValue = $true
    } catch { }
    $needsSet = $true
    if ($hasValue) {
        if ($Type -in @('DWord','QWord')) {
            $needsSet = ([int64]$Value -ne [int64]$current)
        } else {
            $needsSet = ($Value -ne $current)
        }
    }
    if (-not $hasValue) {
        New-ItemProperty -Path $Key -Name $Name -PropertyType $Type -Value $Value -Force | Out-Null
        Write-Host "Created value: $Key\$Name = $Value ($Type)" -ForegroundColor Green
    } elseif ($needsSet) {
        Set-ItemProperty -Path $Key -Name $Name -Value $Value
        Write-Host "Updated value: $Key\$Name from '$current' to '$Value'" -ForegroundColor Yellow
    } else {
        Write-Host "Already correct: $Key\$Name = $Value" -ForegroundColor Gray
    }
}
# --- Check for installed browsers (Edge, Chrome, Firefox) ---
function Get-InstalledApp {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Name
    )
    $registryPaths = @(
        'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*',
        'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*',
        'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*'
    )
    $results = @()
    foreach ($path in $registryPaths) {
        try {
            $items = Get-ItemProperty -Path $path -ErrorAction SilentlyContinue |
                Where-Object { $_.DisplayName -and ($_.DisplayName -like "*$Name*" -or $_.DisplayName -eq $Name) } |
                Select-Object DisplayName, DisplayVersion, Publisher, InstallDate, InstallLocation
            if ($items) { $results += $items }
        } catch { }
    }
    return $results
}
# --- Check if Global Secure Access client already installed and install if not present ---
if (Test-Path $ExePath) {
    Write-Host "GSA Client executable is present." -ForegroundColor Green
    try {
        $fileVersion = (Get-Item $ExePath).VersionInfo.ProductVersion
        Write-Host "Current version is $fileVersion. Please check $ReleaseHistoryUrl to make sure your client is the most up-to-date." -ForegroundColor Cyan
    } catch {
        Write-Host "Could not retrieve version info. Please check $ReleaseHistoryUrl manually to make sure your client is the most up-to-date." -ForegroundColor Yellow
    }
} else {
    Write-Host "GSA Client executable is NOT found. Proceeding with installation..." -ForegroundColor Yellow
    $isArm = $env:PROCESSOR_ARCHITECTURE -match 'ARM'
    $downloadUrl = if ($isArm) { $DownloadUrlARM } else { $DownloadUrlX64 }
    $archLabel   = if ($isArm) { 'ARM64' } else { 'x64' }
    try {
        Write-Host "Downloading GSA client for $archLabel..." -ForegroundColor Green
        Invoke-WebRequest -Uri $downloadUrl -OutFile $InstallerPath -UseBasicParsing
        Write-Host "Installing GSA client..." -ForegroundColor Green
        Start-Process -FilePath $InstallerPath -ArgumentList @('/quiet','/norestart') -Wait -WindowStyle Hidden
        Write-Host "Installation complete." -ForegroundColor Green
    }
    catch {
        Write-Error "Failed to download or install the GSA client. $_"
        if (Test-Path $InstallerPath) { Remove-Item $InstallerPath -Force }
        exit 1
    }
    finally {
        if (Test-Path $InstallerPath) { Remove-Item $InstallerPath -Force }
    }
    if (Test-Path $ExePath) {
        $fileVersion = (Get-Item $ExePath).VersionInfo.ProductVersion
        Write-Host "Installed version is $fileVersion." -ForegroundColor Cyan
    }
}
# --- Enforce registry keys ---
Write-Host "`nEnforcing required registry values..." -ForegroundColor Magenta
# 1) Always apply NON-browser (Global Secure Access) keys exactly as before
$nonBrowserSettings = $RegistrySettings | Where-Object {
    $_.Key -notmatch '\\Policies\\Microsoft\\Edge' -and $_.Key -notmatch '\\Policies\\Google\\Chrome'
}
foreach ($rk in $nonBrowserSettings) {
    Ensure-RegistryValue -Key $rk.Key -Name $rk.Name -Type $rk.Type -Value $rk.Value
}
# 2) Detect browsers via registry only 
$edgeFound    = Get-InstalledApp -Name 'Microsoft Edge'
$chromeFound  = Get-InstalledApp -Name 'Google Chrome'
$firefoxFound = Get-InstalledApp -Name 'Firefox'  # also catches "Mozilla Firefox"
Write-Host ""
Write-Host "Browser detection:" -ForegroundColor Cyan
Write-Host (" - Microsoft Edge : {0}"  -f ($(if ($edgeFound)   {'FOUND'} else {'Not installed'})))  -ForegroundColor $(if ($edgeFound) {'Green'} else {'Yellow'})
Write-Host (" - Google Chrome  : {0}"  -f ($(if ($chromeFound) {'FOUND'} else {'Not installed'})))  -ForegroundColor $(if ($chromeFound){'Green'} else {'Yellow'})
Write-Host (" - Firefox        : {0}"  -f ($(if ($firefoxFound){'FOUND'} else {'Not installed'})))  -ForegroundColor $(if ($firefoxFound){'Green'} else {'Yellow'})
# 3) Apply Edge policy keys only if Edge present
$edgeSettings = $RegistrySettings | Where-Object { $_.Key -match '\\Policies\\Microsoft\\Edge' }
if ($edgeFound) {
    Write-Host "`nApplying Microsoft Edge policy keys (DoH/QUIC)..." -ForegroundColor Cyan
    foreach ($rk in $edgeSettings) {
        Ensure-RegistryValue -Key $rk.Key -Name $rk.Name -Type $rk.Type -Value $rk.Value
    }
} else {
    Write-Host "Skipping Edge policy keys (Edge not detected)." -ForegroundColor DarkYellow
}
# 4) Apply Chrome policy keys only if Chrome present
$chromeSettings = $RegistrySettings | Where-Object { $_.Key -match '\\Policies\\Google\\Chrome' }
if ($chromeFound) {
    Write-Host "`nApplying Google Chrome policy keys (DoH/QUIC)..." -ForegroundColor Cyan
    foreach ($rk in $chromeSettings) {
        Ensure-RegistryValue -Key $rk.Key -Name $rk.Name -Type $rk.Type -Value $rk.Value
    }
} else {
    Write-Host "Skipping Chrome policy keys (Chrome not detected)." -ForegroundColor DarkYellow
}
Write-Host "`nGSA keys applied. Edge and Chrome browser policy keys applied only when detected." -ForegroundColor Cyan
# Firefox policies.json: disable QUIC (HTTP/3) and DoH only if Firefox present
if ($firefoxFound) {
    # Prefer existing Firefox install path; fall back to Program Files
    $ffBaseDirs = @(
        "C:\Program Files\Mozilla Firefox",
        "C:\Program Files (x86)\Mozilla Firefox"
    )
    $ffBaseDir = $ffBaseDirs | Where-Object { Test-Path $_ } | Select-Object -First 1
    if (-not $ffBaseDir) { $ffBaseDir = "C:\Program Files\Mozilla Firefox" }
    $distributionDir = Join-Path $ffBaseDir "distribution"
    $destination     = Join-Path $distributionDir "policies.json"
    $backup          = "$destination.bak"
    # Ensure distribution directory exists
    if (-not (Test-Path $distributionDir)) {
        New-Item -ItemType Directory -Path $distributionDir -Force | Out-Null
    }
    # Load existing JSON if present
    $existingJson = $null
    if (Test-Path $destination) {
        $fileContent = Get-Content $destination -Raw -ErrorAction SilentlyContinue
        if ($fileContent -and $fileContent.Trim().Length -gt 0) {
            try {
                $existingJson = $fileContent | ConvertFrom-Json -ErrorAction Stop
            } catch {
                Write-Warning "Existing policies.json is malformed at '$destination'. Starting fresh."
            }
        }
    }
    # Create base structure if needed
    if (-not $existingJson) {
        $existingJson = [PSCustomObject]@{
            policies = [PSCustomObject]@{
                Preferences = @{}
            }
        }
    }
    # Ensure nodes exist
    if (-not $existingJson.policies) {
        $existingJson | Add-Member -MemberType NoteProperty -Name policies -Value ([PSCustomObject]@{}) -Force
    }
    if (-not $existingJson.policies.Preferences) {
        $existingJson.policies | Add-Member -MemberType NoteProperty -Name Preferences -Value @{} -Force
    }
    # Normalize Preferences to hashtable for safe merging
    if ($existingJson.policies.Preferences -isnot [hashtable]) {
        $prefs = @{}
        $existingJson.policies.Preferences.psobject.Properties | ForEach-Object {
            $prefs[$_.Name] = $_.Value
        }
        $existingJson.policies.Preferences = $prefs
    }
    $prefs   = $existingJson.policies.Preferences
    $updated = $false
    # Disable QUIC (HTTP/3)
    if (-not $prefs.ContainsKey("network.http.http3.enable") -or
        $prefs["network.http.http3.enable"].Value  -ne $false) {
        $prefs["network.http.http3.enable"] = @{
            Value  = $false
        }
        $updated = $true
    }
    # Disable DNS-over-HTTPS (TRR mode 0 per your baseline)
    if (-not $prefs.ContainsKey("network.trr.mode") -or
        $prefs["network.trr.mode"].Value  -ne 0) {
        $prefs["network.trr.mode"] = @{
            Value  = 0
        }
        $updated = $true
    }
    # Write if updated (backup existing first)
    if ($updated) {
        if (Test-Path $destination) {
            Copy-Item -Path $destination -Destination $backup -Force
        }
        $jsonOut  = $existingJson | ConvertTo-Json -Depth 10 -Compress
        $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
        [System.IO.File]::WriteAllText($destination, $jsonOut, $utf8NoBom)
        Write-Host "QUIC and DoH disabled in Firefox. Firefox policies.json updated at '$destination'." -ForegroundColor Green
    } else {
        Write-Host "Firefox policies.json already contains required settings at '$destination'." -ForegroundColor Gray
    }
} else {
    Write-Host "Skipping Firefox policies.json (Firefox not detected)." -ForegroundColor DarkYellow
}
# --- Decide whether to prompt for reboot based on DisabledComponents change (IPv4Preferred) ---
$NowIpv4PreferredCorrect = $false
try {
    $prop = Get-ItemProperty -Path $Ipv6ParamsKey -Name $Ipv4PrefValueName -ErrorAction Stop
    $NowIpv4PreferredCorrect = ([int64]$prop.$Ipv4PrefValueName -eq [int64]$Ipv4PrefDesired)
} catch {
    $NowIpv4PreferredCorrect = $false
}
$PromptForReboot = (-not $WasIpv4PreferredAlreadyCorrect) -and $NowIpv4PreferredCorrect
if ($PromptForReboot) {
    # Prompt for reboot at the end ONLY if the DisabledComponents value was changed by this script
    $choice = Read-Host "Change of the IPv4Preffered registry key won't take effect until device reboot. Do you want to reboot now? (Y/N)"
    if ($choice -match '^[Yy]$') {
        Write-Host "Rebooting system..."
        Restart-Computer -Force
    } else {
        Write-Host "Reboot skipped by user."
    }
} else {
    # If the value was already correct before, don't prompt—just inform
    Write-Host "IPv4Preferred is already configured correctly. No reboot is required." -ForegroundColor Green
}
```

## Related content
- [Install the Global Secure Access client for Microsoft Windows](../how-to-install-windows-client.md)
