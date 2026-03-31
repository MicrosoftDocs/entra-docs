---
title: Install the Global Secure Access Client for Windows
description: The Global Secure Access client helps secure network traffic at the user device. This article describes how to download and install the Windows client.
ms.topic: how-to
ms.date: 02/02/2026
ms.author: jayrusso
author: HULKsmashGithub
ms.reviewer: lirazbarak
ai-usage: ai-assisted
ms.custom: sfi-image-nochange

# Customer intent: As a Windows user, I want to download and install the Global Secure Access client so that I can enhance network security.
---
# Install the Global Secure Access client for Windows

The Global Secure Access client is an essential part of Global Secure Access. It helps organizations manage and secure network traffic on user devices. The client routes traffic that needs to be secured by Global Secure Access to the cloud service. All other traffic goes directly to the network. The [forwarding profiles](concept-traffic-forwarding.md) that you set up in the portal determine which traffic the Global Secure Access client routes to the cloud service.

This article describes how to download and install the Global Secure Access client for Windows. The Global Secure Access client is also available for [macOS](how-to-install-macos-client.md), [Android](how-to-install-android-client.md), and [iOS](how-to-install-ios-client.md).

## Prerequisites

- A Microsoft Entra tenant onboarded to Global Secure Access.

- A device joined to or registered (preview) in the onboarded tenant:

  - The device must be Microsoft Entra joined, Microsoft Entra hybrid joined, or Microsoft Entra registered. To learn more, see [Global Secure Access client overview](concept-clients.md).
  - If the device isn't joined or registered, the Global Secure Access client registers it to the tenant when the user signs in.
  - If the device isn't joined and has multiple registrations, sign in with the Microsoft Entra user of the tenant that Global Secure Access should connect to.
  - On Microsoft Entra registered devices, only Private Access traffic is supported.

- A 64-bit version of Windows 10 (LTSC 2021 or newer), Windows 11, or an Arm64 version of Windows 11:

  - Azure Virtual Desktop single-session is supported.
  - Azure Virtual Desktop multi-session isn't supported.
  - Windows 365 is supported.
  - Windows on Arm devices (such as Surface Pro and Surface Laptop with Snapdragon processors) require a [separate client installer](https://aka.ms/GlobalSecureAccess-WindowsOnArm). Don't use the standard x64 installer on Arm64 devices.

- Local admin credentials to install or upgrade the Global Secure Access client.

- A license. For details, see the licensing section of [What is Global Secure Access?](overview-what-is-global-secure-access.md). If necessary, you can [buy licenses or get trial licenses](https://aka.ms/azureadlicense).

## Download the client

The most current version of the Global Secure Access client is available to download from the Microsoft Entra admin center:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Secure Access Administrator](/azure/active-directory/roles/permissions-reference#global-secure-access-administrator).

1. Go to **Global Secure Access** > **Connect** > **Client download**.

1. Select **Download Client**.

   :::image type="content" source="media/how-to-install-windows-client/client-download-screen.png" alt-text="Screenshot of the pane for client download with the Download Client button highlighted.":::

## Install the client

### Automated installation

Organizations can install the Global Secure Access client silently by using the `/quiet` switch. Or they can use mobile device management (MDM) solutions, such as [Microsoft Intune](/mem/intune/apps/apps-win32-app-management), to deploy the client to their devices.

### Use Microsoft Intune to deploy the Global Secure Access client

This section explains how to use Intune to install the Global Secure Access client on a Windows 11 client device.

#### Prerequisites

- A security group with devices or users to identify where to install the Global Secure Access client.

#### Package the client

Package the installation script into an `.intunewin` file:

1. Save the following PowerShell script to your device. Put the PowerShell script and the Global Secure Access `.exe` installer into a folder.

   The PowerShell installation script installs the Global Secure Access client, sets the `IPv4Preferred` registry key to prefer IPv4 over IPv6 traffic, and prompts for a reboot for the registry key change to take effect.

   > [!NOTE]
   > The name of the `.exe` file must be `GlobalSecureAccessClient.exe` for the PowerShell installation script to work properly. If you modify the name of the `.exe` file to something else, you must also modify `$installerPath` in the PowerShell script.

   ```powershell
   # Create log directory and log helper
   $logFile = "$env:ProgramData\GSAInstall\install.log"
   New-Item -ItemType Directory -Path (Split-Path $logFile) -Force | Out-Null

   function Write-Log {
       param([string]$message)
       $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
       Add-Content -Path $logFile -Value "$timestamp - $message"
   }

   try {
       $ErrorActionPreference = 'Stop'
       Write-Log "Starting Global Secure Access client installation."

       # IPv4 preferred via DisabledComponents registry value
       $ipv4RegPath    = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters"
       $ipv4RegName    = "DisabledComponents"
       $ipv4RegValue   = 0x20  # Prefer IPv4 over IPv6
       $rebootRequired = $false

       # Ensure the key exists
       if (-not (Test-Path $ipv4RegPath)) {
           New-Item -Path $ipv4RegPath -Force | Out-Null
           Write-Log "Created registry key: $ipv4RegPath"
       }

       # Get current value if present
       $existingValue = $null
       $valueExists = $false
       try {
           $existingValue = Get-ItemPropertyValue -Path $ipv4RegPath -Name $ipv4RegName -ErrorAction Stop
           $valueExists = $true
       } catch {
           $valueExists = $false
       }

       # Determine if we must change it
       $expected = [int]$ipv4RegValue
       $needsChange = -not $valueExists -or ([int]$existingValue -ne $expected)

       if ($needsChange) {
           if (-not $valueExists) {
               # Create as DWORD when missing
               New-ItemProperty -Path $ipv4RegPath -Name $ipv4RegName -PropertyType DWord -Value $expected -Force | Out-Null
               Write-Log ("IPv4Preferred value missing. Created '{0}' with value 0x{1} (dec {2})." -f $ipv4RegName, ([Convert]::ToString($expected,16)), $expected)
           } else {
               # Update if different
               Set-ItemProperty -Path $ipv4RegPath -Name $ipv4RegName -Value $expected
               Write-Log ("IPv4Preferred value differed. Updated '{0}' from 0x{1} (dec {2}) to 0x{3} (dec {4})." -f `
                   $ipv4RegName, ([Convert]::ToString([int]$existingValue,16)), [int]$existingValue, ([Convert]::ToString($expected,16)), $expected)
           }
           $rebootRequired = $true
       } else {
           Write-Log ("IPv4Preferred already set correctly: {0}=0x{1} (dec {2}). No change." -f `
               $ipv4RegName, ([Convert]::ToString($expected,16)), $expected)
       }

       # Resolve installer path
       $ScriptRoot = if ($PSScriptRoot) { $PSScriptRoot } else { Split-Path -Parent $MyInvocation.MyCommand.Path }
       $installerPath = Join-Path -Path $ScriptRoot -ChildPath "GlobalSecureAccessClient.exe"
       Write-Log "Running installer from $installerPath"

       if (Test-Path $installerPath) {
           $installProcess = Start-Process -FilePath $installerPath -ArgumentList "/quiet" -Wait -PassThru

           if ($installProcess.ExitCode -eq 1618) {
               Write-Log "Another installation is in progress. Exiting with code 1618."
               exit 1618
           } elseif ($installProcess.ExitCode -ne 0) {
               Write-Log "Installer exited with code $($installProcess.ExitCode)."
               exit $installProcess.ExitCode
           }

           Write-Log "Installer completed successfully."
       } else {
           Write-Log "Installer not found at $installerPath"
           exit 1
       }

       if ($rebootRequired) {
           Write-Log "Reboot required due to registry value creation or update."
           exit 3010  # Soft reboot required
       } else {
           Write-Log "Installation complete. No reboot required."
           exit 0
       }
   }
   catch {
       Write-Log "Fatal error: $_"
       exit 1603
   }
   ```

1. Go to the [Microsoft Win32 Content Prep Tool](https://github.com/Microsoft/Microsoft-Win32-Content-Prep-Tool). Select `IntuneWinAppUtil.exe`.

   :::image type="content" source="media/how-to-install-windows-client/install-content-prep-tool.png" alt-text="Screenshot of selecting the installation file in the prep tool.":::

1. In the upper-right corner, select **More file actions** > **Download**.

   :::image type="content" source="media/how-to-install-windows-client/raw-file-download.png" alt-text="Screenshot of the Download command on the menu for more file actions.":::

1. Browse to and run `IntuneWinAppUtil.exe`. A command prompt opens.

1. Enter the folder path location of the Global Secure Access `.exe` file. Select **Enter**.

1. Enter the name of the Global Secure Access installation `.ps1` file. Select **Enter**.

1. Enter the folder path in which to place the `.intunewin` file. Select **Enter**.

1. Enter **N**. Select **Enter**.

   :::image type="content" source="media/how-to-install-windows-client/install-from-command-line.png" alt-text="Screenshot of command line to install a client.":::

The `.intunewin` file is ready for you to deploy Microsoft Intune.

#### Deploy the client

For detailed guidance, see [Add a Win32 app to Intune](/mem/intune/apps/apps-win32-add#add-a-win32-app-to-intune).

1. Go to the [Intune admin center](https://intune.microsoft.com/).

1. Select **Apps** > **All apps** > **Add**.

1. On **Select app type**, under **Other** app types, select **Windows app (Win32)**.

1. Select **Select**. The **Add app** steps appear.

1. Select **Select app package file**.

1. Select the folder icon. Open the `.intunewin` file that you created in the previous section.

   :::image type="content" source="media/how-to-install-windows-client/app-package-file.png" alt-text="Screenshot that shows selection of an app package file.":::

1. Select **OK**.

1. On the **App Information** tab, configure these fields:

   - **Name**: Enter a name for the client app.
   - **Description**: Enter a description.
   - **Publisher**: Enter **Microsoft**.
   - **App Version** *(optional)*: Enter the client version.

1. Use the default values in the remaining fields.

   :::image type="content" source="media/how-to-install-windows-client/add-app.png" alt-text="Screenshot of adding app information to install a client." lightbox="media/how-to-install-windows-client/add-app.png":::

1. Select **Next**.

1. On the **Program** tab, configure these values:

   - **Install command**: Use the original name of the `.ps1` file for `powershell.exe -ExecutionPolicy Bypass -File OriginalNameOfFile.ps1`.
   - **Uninstall command**: Enter `"GlobalSecureAccessClient.exe" /uninstall /quiet /norestart`.
   - **Allow available uninstall**: Select **No**.
   - **Install behavior**: Select **System**.
   - **Device restart behavior**: Select **Determine behavior based on return codes**. Specify the following return codes.

     |Return code|Code type|
     |-----------|---------|
     |0|**Success**|
     |3010|**Soft reboot**|
     |1618|**Retry**|

   :::image type="content" source="media/how-to-install-windows-client/program-install-parameters.png" alt-text="Screenshot of the Program tab for configuring installation parameters." lightbox="media/how-to-install-windows-client/program-install-parameters.png":::

1. Select **Next**.

1. On the **Requirements** tab, configure these values:

   - **Check operating system architecture**: Select **Yes. Specify the systems the app can be installed on.** Then select the **Install on** options according to the system type that you're deploying to.
   - **Minimum operating system**: Select your minimum requirements.

1. Leave the remaining boxes blank.

   :::image type="content" source="media/how-to-install-windows-client/requirements-install-parameters.png" alt-text="Screenshot of the Requirements tab for configuring installation parameters." lightbox="media/how-to-install-windows-client/requirements-install-parameters.png":::

   > [!NOTE]
   > Windows on Arm devices have their own client, which is available at **aka.ms/GlobalSecureAccess-WindowsOnArm**.

1. Select **Next**.

1. On the **Detection rules** tab, under **Rules format**, select **Manually configure detection rules**.

1. Select **Add**.

1. Under **Rule type**, select **File**.

1. Configure these fields:

   - **Path**: Enter `C:\Program Files\Global Secure Access Client\TrayApp`.
   - **File or folder**: Enter `GlobalSecureAccessClient.exe`.
   - **Detection method**: Select **String (version)**.
   - **Operator**: Select **Greater than or equal to**.
   - **Value**: Enter the client version number.
   - **Associated with a 32-bit app on 64-bit client**: Select **No**.

   :::image type="content" source="media/how-to-install-windows-client/detection-rule.png" alt-text="Screenshot of the pane for creating a detection rule for the client." lightbox="media/how-to-install-windows-client/detection-rule.png":::

1. Select **OK**. Then select **Next**.

1. Select **Next** twice to go to **Assignments**.

1. Under **Required**, select **+Add group**. Select a group of users or devices, and then choose **Select**.

1. Set the **Restart grace period** to **Enabled** to avoid disrupting users with an abrupt device reboot.

    :::image type="content" source="media/how-to-install-windows-client/restart-grace-period.png" alt-text="Screenshot of the Assignments tab that shows the required groups and the restart grace period set to Enabled." lightbox="media/how-to-install-windows-client/restart-grace-period.png":::

1. Select **Next**. Then select **Create**.

> [!NOTE]
> Deploying the Global Secure Access client to a virtual machine might suppress the prompt to restart the device.

#### Update the client version

To update to the newest client version, follow the [Update a line-of-business app](/mem/intune/apps/lob-apps-windows#update-a-line-of-business-app) steps. Be sure to update the following settings in addition to uploading the new `.intunewin` file:

- Client version
- Detection rule value set to the new client version number

In a production environment, it's a good practice to deploy new client versions in a phased deployment approach:

1. Leave the existing app in place.

1. Add a new app for the new client version by repeating the previous steps.

1. Assign the new app to a small group of users to pilot the new client version. It's OK to assign these users to the app with the old client version for an in-place upgrade.

1. Slowly increase the membership of the pilot group until you deploy the new client to all desired devices.

1. Delete the app with the old client version.

### Configure Global Secure Access client settings by using Intune

Administrators can use [remediation scripts](/intune/intune-service/fundamentals/remediations) in Intune to enforce client-side controls, such as preventing general users from disabling the client or hiding specific buttons.

> [!IMPORTANT]
> Set `$gsaSettings` to the values that your organization requires in both the detection and remediation scripts.

Make sure to configure these scripts to run in 64-bit PowerShell.

:::image type="content" source="media/how-to-install-windows-client/run-script-64-bit.png" alt-text="Screenshot of the tab for creating custom script settings, with the option for running the script in 64-bit PowerShell set to Yes.":::

Select the PowerShell scripts to expand them.

<details>
  <summary>PowerShell detection script</summary>

#### Detection script

```powershell
# Check Global Secure Access registry keys 

$gsaPath = "HKLM:\SOFTWARE\Microsoft\Global Secure Access Client" 

$gsaSettings = @{ 

"HideSignOutButton" = 1 
 
"HideDisablePrivateAccessButton" = 1 
 
"HideDisableButton" = 0 
 
"RestrictNonPrivilegedUsers" = 0 

} 

$nonCompliant = $false 

foreach ($setting in $gsaSettings.GetEnumerator()) { 

$currentValue = (Get-ItemProperty -Path $gsaPath -Name $setting.Key -ErrorAction SilentlyContinue).$($setting.Key) 
 
if ($currentValue -ne $setting.Value) { 
 
    Write-Output "Non-compliant: $($setting.Key) is $currentValue, expected $($setting.Value)" 
 
    $nonCompliant = $true 
 
} 
  

} 

if (-not $nonCompliant) { 

Write-Output "Compliant" 
 
exit 0 
  

} else { 

Write-Output "Non-compliant" 
 
exit 1 
 

} 
```

</details>

<details>
  <summary>PowerShell remediation script</summary>

#### Remediation script

```powershell
# Ensure Global Secure Access registry keys are present 

$gsaPath = "HKLM:\SOFTWARE\Microsoft\Global Secure Access Client" 

$gsaSettings = @{ 

"HideSignOutButton" = 1 
 
"HideDisablePrivateAccessButton" = 1 
 
"HideDisableButton" = 0 
 
"RestrictNonPrivilegedUsers" = 0 
  

} 

if (-Not (Test-Path $gsaPath)) { 

New-Item -Path $gsaPath -Force | Out-Null 
  

} 

foreach ($setting in $gsaSettings.GetEnumerator()) { 

Set-ItemProperty -Path $gsaPath -Name $setting.Key -Value $setting.Value -Type DWord -Force | Out-Null 
 
Write-Output "Set $($setting.Key) to $($setting.Value)" 
  

}
```

</details>

### Configure settings for Microsoft Entra Internet Access by using Intune

Microsoft Entra Internet Access doesn't support DNS over HTTPS or Quick UDP Internet Connections (QUIC) traffic. To mitigate this limitation, disable these protocols in users' browsers. The following instructions provide guidance on how to enforce these controls by using Intune.

#### Disable QUIC in Microsoft Edge and Chrome by using Intune

1. In the Microsoft Intune admin center, select **Devices** > **Manage devices** > **Configuration**.

1. On the **Policies** tab, select **+ Create** > **+ New Policy**.

1. In the **Create a profile** dialog:

   - Set **Platform** to **Windows 10 and later**.
   - Set **Profile type** to **Settings catalog**.
   - Select **Create**. The **Create profile** form opens.

1. On the **Basics** tab, give the profile a name and description.

1. Select **Next**.

1. On the **Configuration settings** tab:

    1. Select **+ Add settings**.
    1. In **Settings picker**, search for **QUIC**.
    1. From the search results:
        1. Select **Microsoft Edge**, and then select the **Allow QUIC protocol** setting.
        1. Select **Google Chrome**, and then select the **Allow QUIC protocol** setting.
    1. In **Settings picker**, search for **DNS-over-HTTPS**.
    1. From the search results:
        1. Select **Microsoft Edge**, and then select the **Control the mode of DNS-over-HTTPS** setting.
        1. Select **Google Chrome**, and then select the **Control the mode of DNS-over-HTTPS** setting.
    1. Close **Settings picker**.

1. For **Google Chrome**, set both toggles to **Disabled**.

1. For **Microsoft Edge**, set both toggles to **Disabled**.

    :::image type="content" source="media/how-to-install-windows-client/edge-chrome-profile.png" alt-text="Screenshot of the tab for configuring Microsoft Edge and Chrome settings." lightbox="media/how-to-install-windows-client/edge-chrome-profile.png":::

1. Select **Next** twice.

1. On the **Assignments** tab:

    1. Select **Add groups**.
    1. Select a group of users or devices to assign the policy.
    1. Select **Select**.

1. Select **Next**.

1. On the **Review + create** tab, select **Create**.

### Configure Firefox browser settings

Admins can use [remediation scripts](/intune/intune-service/fundamentals/remediations) in Intune to disable DNS over HTTPS and QUIC protocols in the Firefox browser.

Make sure to configure these scripts to run in 64-bit PowerShell.

:::image type="content" source="media/how-to-install-windows-client/run-script-64-bit.png" alt-text="Screenshot of the tab for creating custom script settings, with the option for running the script in 64-bit PowerShell set to Yes.":::

<details>
  <summary>PowerShell detection script</summary>

#### Detection script 

```powershell
# Define the path to the Firefox policies.json file 

$destination = "C:\Program Files\Mozilla Firefox\distribution\policies.json" $compliant = $false 

# Check if the file exists 

if (Test-Path $destination) { try { # Read the file content $fileContent = Get-Content $destination -Raw if ($fileContent -and $fileContent.Trim().Length -gt 0) { # Parse JSON content $json = $fileContent | ConvertFrom-Json 

       # Check if Preferences exist under policies 
        if ($json.policies -and $json.policies.Preferences) { 
            $prefs = $json.policies.Preferences 
 
            # Convert Preferences to hashtable if needed 
            if ($prefs -isnot [hashtable]) { 
                $temp = @{} 
                $prefs.psobject.Properties | ForEach-Object { 
                    $temp[$_.Name] = $_.Value 
                } 
                $prefs = $temp 
            } 
 
            # Initialize compliance flags 
            $quicCompliant = $false 
            $dohCompliant = $false 
 
            # Check if QUIC is disabled and locked 
            if ($prefs.ContainsKey("network.http.http3.enable")) { 
                $val = $prefs["network.http.http3.enable"] 
                if ($val.Value -eq $false -and $val.Status -eq "locked") { 
                    $quicCompliant = $true 
                } 
            } 
 
            # Check if DNS over HTTPS is disabled and locked 
            if ($prefs.ContainsKey("network.trr.mode")) { 
                $val = $prefs["network.trr.mode"] 
                if ($val.Value -eq 0 -and $val.Status -eq "locked") { 
                    $dohCompliant = $true 
                } 
            } 
 
            # Set overall compliance if both settings are correct 
            if ($quicCompliant -and $dohCompliant) { 
                $compliant = $true 
            } 
        } 
    } 
} catch { 
    Write-Warning "Failed to parse policies.json: $_" 
} 
  

} 

# Output compliance result 

if ($compliant) { Write-Output "Compliant" Exit 0 } else { Write-Output "Non-compliant" Exit 1 } 
```

</details>

<details>
  <summary>PowerShell remediation script</summary>

#### Remediation script

```powershell
# Define paths 

$distributionDir = "C:\Program Files\Mozilla Firefox\distribution" $destination = Join-Path $distributionDir "policies.json" $backup = "$destination.bak" 

# Initialize variable for existing JSON 

$existingJson = $null 

# Try to read and parse existing policies.json 

if (Test-Path $destination) { $fileContent = Get-Content $destination -Raw if ($fileContent -and $fileContent.Trim().Length -gt 0) { try { $existingJson = $fileContent | ConvertFrom-Json } catch { Write-Warning "Existing policies.json is malformed. Starting fresh." } } } 

#Create a new JSON structure if none exists 

if (-not $existingJson) { $existingJson = [PSCustomObject]@{ policies = [PSCustomObject]@{ Preferences = @{} } } } 

# Ensure policies and Preferences nodes exist 

if (-not $existingJson.policies) { $existingJson | Add-Member -MemberType NoteProperty -Name policies -Value ([PSCustomObject]@{}) } if (-not $existingJson.policies.Preferences) { $existingJson.policies | Add-Member -MemberType NoteProperty -Name Preferences -Value @{} } 

# Convert Preferences to hashtable if needed 

if ($existingJson.policies.Preferences -isnot [hashtable]) { $prefs = @{} $existingJson.policies.Preferences.psobject.Properties | ForEach-Object { $prefs[$.Name] = $.Value } $existingJson.policies.Preferences = $prefs } 

$prefObj = $existingJson.policies.Preferences $updated = $false 

# Ensure QUIC is disabled and locked

if (-not $prefObj.ContainsKey("network.http.http3.enable") -or $prefObj["network.http.http3.enable"].Value -ne $false -or $prefObj["network.http.http3.enable"].Status -ne "locked") { 

$prefObj["network.http.http3.enable"] = @{ 
    Value = $false 
    Status = "locked" 
} 
$updated = $true 
  

} 

# Ensure DNS over HTTPS is disabled and locked 

if (-not $prefObj.ContainsKey("network.trr.mode") -or $prefObj["network.trr.mode"].Value -ne 0 -or $prefObj["network.trr.mode"].Status -ne "locked") { 

$prefObj["network.trr.mode"] = @{ 
    Value = 0 
    Status = "locked" 
} 
$updated = $true 
} 

# If any updates were made, back up and write the new JSON 

if ($updated) { if (Test-Path $destination) { Copy-Item $destination $backup -Force } 

$jsonOut = $existingJson | ConvertTo-Json -Depth 10 -Compress 
$utf8NoBomEncoding = New-Object System.Text.UTF8Encoding($false) 
[System.IO.File]::WriteAllText($destination, $jsonOut, $utf8NoBomEncoding) 
} 
```

</details>

### Manually install the Global Secure Access client

1. Run the `GlobalSecureAccessClient.exe` setup file. Accept the software license terms.

1. The client is installed and silently signs you in with your Microsoft Entra credentials. If the silent sign-in fails, the installer prompts you to sign in manually.

1. The connection icon turns green. Hover over it to open the client status notification, which should show as **Connected**.

:::image type="content" source="media/how-to-install-windows-client/global-secure-access-client-installed-connected.png" alt-text="Screenshot that shows a connected client.":::

## Client interface

To open the Global Secure Access client interface, select the Global Secure Access icon in the system tray. The client interface provides a view of the current connection status, the channels configured for the client, and access to diagnostics tools.

### Connections view

The **Connections** view shows the client status and the channels configured for the client.

To disable the client, select the **Disable** button. You can use the information in the **Additional details** section to troubleshoot the client connection. Select **Show more details** to expand the section and view more information.

:::image type="content" source="media/how-to-install-windows-client/client-interface-connections.png" alt-text="Screenshot of the Connections view of the Global Secure Access client interface.":::

### Troubleshooting view

In the **Troubleshooting** view, you can:

- Perform various diagnostic tasks.
- Export and share logs with your IT admin.
- Access the **Advanced diagnostics** tool, which provides an assortment of troubleshooting tools. (You can also open the **Advanced diagnostics** tool from the icon menu in the client's system tray.)

:::image type="content" source="media/how-to-install-windows-client/client-interface-troubleshooting.png" alt-text="Screenshot of the Troubleshooting view of the Global Secure Access client interface.":::

### Settings view

Switch to the **Settings** view to check the installed version or access the Microsoft Privacy Statement.

:::image type="content" source="media/how-to-install-windows-client/client-interface-settings.png" alt-text="Screenshot of the Settings view of the Global Secure Access client interface.":::

## Client actions

To view the available actions on the client menu, select the Global Secure Access icon in the system tray.

:::image type="content" source="media/how-to-install-windows-client/client-install-all-actions.png" alt-text="Screenshot that shows the complete list of Global Secure Access client actions.":::

> [!TIP]
> The Global Secure Access actions on the client menu depend on your configuration of [client registry keys](#client-registry-keys).

|Action   |Description  |
|---------|-------------|
|**Sign out**   |*Hidden by default*. Use the **Sign out** action when you need to sign in to the Global Secure Access client with a Microsoft Entra user other than the one that you used to sign in to Windows. To make this action available, update the appropriate [client registry keys](#client-registry-keys).         |
|**Disable**   |Select the **Disable** action to disable the client. The client remains disabled until you either enable the client or restart the machine.         |
|**Enable**   |Select this action to enable the Global Secure Access client.         |
|**Disable Private Access**   |*Hidden by default*. Use the **Disable Private Access** action when you want to bypass Global Secure Access whenever you connect your device directly to the corporate network to access private applications directly through the network rather than through Global Secure Access. To make this action available, update the appropriate [client registry keys](#client-registry-keys).         |
|**Collect logs**   |Select this action to collect client logs (information about the client machine, the related event logs for the services, and registry values) and archive them in a .zip file to share with Microsoft Support for investigation. The default location for the logs is `C:\Program Files\Global Secure Access Client\Logs`.  You can also collect client logs on Windows by entering the following command in the command prompt: `C:\Program Files\Global Secure Access Client\LogsCollector\LogsCollector.exe" <username> <user>`.      |
|**Advanced diagnostics**   |Select this action to open the advanced diagnostics and access an assortment of [troubleshooting](#troubleshooting) tools.         |

## Client status indicators

### Status notification

Select the Global Secure Access icon to open the client status notification and view the status of each channel that you configured for the client.

:::image type="content" source="media/how-to-install-windows-client/install-windows-client-client-status.png" alt-text="Screenshot that shows a client status of Connected.":::

### Client statuses in the system tray

|Icon    |Message    |Description    |
|--------|-----------|---------------|
|:::image type="icon" source="media/how-to-install-windows-client/global-secure-access-client-icon-initializing.png":::  |Global Secure Access |The client is initializing and checking its connection to Global Secure Access.    |
|:::image type="icon" source="media/how-to-install-windows-client/global-secure-access-client-icon-connected.png":::  |Global Secure Access - Connected  |The client is connected to Global Secure Access.    |
|:::image type="icon" source="media/how-to-install-windows-client/global-secure-access-client-icon-disabled.png":::   |Global Secure Access - Disabled  |The client is disabled because services are offline or the user disabled the client.    |
|:::image type="icon" source="media/how-to-install-windows-client/global-secure-access-client-icon-disconnected.png":::  |Global Secure Access - Disconnected  |The client failed to connect to Global Secure Access.    |
|:::image type="icon" source="media/how-to-install-windows-client/global-secure-access-client-icon-warning.png":::  |Global Secure Access - Some channels are unreachable  |The client is partially connected to Global Secure Access. That is, the connection to at least one channel failed: Microsoft Entra, Microsoft 365, Private Access, Internet Access.    |
|:::image type="icon" source="media/how-to-install-windows-client/global-secure-access-client-icon-warning.png":::  |Global Secure Access - Disabled by your organization  |Your organization disabled the client. That is, all traffic forwarding profiles are disabled.    |
|:::image type="icon" source="media/how-to-install-windows-client/global-secure-access-client-icon-warning.png":::  |Global Secure Access - Private Access is disabled   |The user disabled Private Access on this device.    |
|:::image type="icon" source="media/how-to-install-windows-client/global-secure-access-client-icon-warning.png":::  |Global Secure Access - could not connect to the Internet  |The client couldn't detect an internet connection. The device is either connected to a network that doesn't have an internet connection or connected to a network that requires captive portal sign-in.    |

## Known limitations

[!INCLUDE [known-limitations-include](../includes/known-limitations-include.md)]

## Troubleshooting

To troubleshoot the Global Secure Access client, select the client icon on the taskbar and then select one of the troubleshooting options: **Export logs** or **Advanced diagnostics tool**.

> [!TIP]
> Administrators can modify the options on the Global Secure Access client menu by revising the [Client registry keys](#client-registry-keys).

For more information on troubleshooting the Global Secure Access client, see the following articles:

- [Troubleshoot the Global Secure Access client for Windows: Advanced diagnostics](troubleshoot-global-secure-access-client-advanced-diagnostics.md)
- [Troubleshoot the Global Secure Access client for Windows: Health check tab](troubleshoot-global-secure-access-client-diagnostics-health-check.md)

## Security recommendations

To enhance the security of the Global Secure Access client, use the following configurations.

### Upgrade to the latest client version

Regularly test and deploy the latest Global Secure Access client release to take advantage of new features, performance improvements, and security fixes. Download the latest version of the [Global Secure Access client](#download-the-client) from the Microsoft Entra admin center.

### Restrict nonprivileged users from disabling the client

Administrators can prevent nonprivileged users on Windows devices from disabling or enabling the Global Secure Access client. This restriction ensures that the client stays on and that Global Secure Access continues to authenticate and help secure network traffic. Enabling this restriction requires elevated privileges to disable the client.

Before you enforce this restriction, let users work with the Global Secure Access client in a nonrestricted mode. Configure the client for your organization to ensure that users don't need to disable the client in specific scenarios (for example, to access specific websites or to use a non-Microsoft VPN in parallel).

To stop the Global Secure Access client on a device with restricted, nonprivileged users, make sure that there's a process in place to use a user with local administrator privileges when necessary. For more information about restricting nonprivileged users, see [Restrict nonprivileged users](#restrict-nonprivileged-users).

### Hide the Disable button

In addition to restricting nonprivileged users from disabling the client, administrators can hide the **Disable** button on the icon menu in the client's system tray. Removing the **Disable** button from view further reduces the likelihood that users disable the client by accident or without authorization.

For more information about hiding client menu buttons, see [Hide or unhide menu buttons in the system tray](#hide-or-unhide-menu-buttons-in-the-system-tray).

## Client registry keys

The Global Secure Access client uses specific registry keys to enable or disable functionalities. Administrators can use an MDM solution, such as Microsoft Intune or Group Policy, to control the registry values.

> [!CAUTION]
> Don't change other registry values unless Microsoft Support instructs you to.

### Restrict nonprivileged users

Administrators can prevent nonprivileged users on the Windows device from disabling or enabling the client by setting the following registry key:
`Computer\HKEY_LOCAL_MACHINE\Software\Microsoft\Global Secure Access Client`.

|Value  |Type  |Data  |Description  |
|-------|------|------|-------------|
|`RestrictNonPrivilegedUsers`  |`REG_DWORD`  |`0x0`  |Nonprivileged users on the Windows device can disable and enable the client.  |
|`RestrictNonPrivilegedUsers`  |`REG_DWORD`  |`0x1`  |Nonprivileged users on the Windows device are restricted from disabling and enabling the client. A User Account Control (UAC) prompt requires local administrator credentials for disable and enable options. The administrator can also hide the disable button (see [Hide or unhide menu buttons in the system tray](#hide-or-unhide-menu-buttons-in-the-system-tray)).  |

### Disable or enable Private Access on the client

This registry value controls whether Private Access is enabled or disabled for the client. If a user is connected to the corporate network, they can choose to bypass Global Secure Access and directly access private applications.

Users can disable or enable Private Access through the system tray menu.

> [!TIP]
> This option is available on the menu only if it isn't hidden (see [Hide or unhide menu buttons in the system tray](#hide-or-unhide-menu-buttons-in-the-system-tray)) and Private Access is enabled for this tenant.

Administrators can disable or enable Private Access for the user by setting the following registry key:
`Computer\HKEY_CURRENT_USER\Software\Microsoft\Global Secure Access Client`.

|Value  |Type  |Data  |Description  |
|-------|------|------|-------------|
|`IsPrivateAccessDisabledByUser`  |`REG_DWORD`  |`0x0`  |Private Access is enabled on this device. Network traffic to private applications goes through Global Secure Access.  |
|`IsPrivateAccessDisabledByUser`  |`REG_DWORD`  |`0x1`  |Private Access is disabled on this device. Network traffic to private applications goes directly to the network.  |

:::image type="content" source="media/how-to-install-windows-client/global-secure-access-registry-key-private-access-enabled.png" alt-text="Screenshot of the Registry Editor with the IsPrivateAccessDisabledByUser registry key highlighted.":::
  
If the registry value doesn't exist, the default value is `0x0` and Private Access is enabled.

### Hide or unhide menu buttons in the system tray

Administrators can show or hide specific buttons on the icon menu in the client's system tray. Create the values under the following registry key:
`Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Global Secure Access Client`.

|Value   |Type   |Data   |Default behavior   |Description   |
|---------|---------|---------|---------|---------|
|`HideSignOutButton`   |`REG_DWORD`   |`0x0` - shown   `0x1` - hidden   |Hidden   |Configure this setting to show or hide the **Sign out** action. This option is for specific scenarios when a user needs to sign in to the client with a different Microsoft Entra user than the one used to sign in to Windows. Note: You must sign in to the client with a user in the same Microsoft Entra tenant to which the device is joined. You can also use the **Sign out** action to reauthenticate the existing user.         |
|`HideDisablePrivateAccessButton`   |`REG_DWORD`   |`0x0` - shown   `0x1` - hidden   |Hidden   |Configure this setting to show or hide the **Disable Private Access** action. This option is for a scenario when the device is directly connected to the corporate network and the user prefers to access private applications directly through the network instead of through Global Secure Access.   |
|`HideDisableButton`   |`REG_DWORD`   |`0x0` - shown   `0x1` - hidden   |Shown   |Configure this setting to show or hide the **Disable** action. When the action is visible, the user can disable the Global Secure Access client. The client remains disabled until the user enables it again. If the **Disable** action is hidden, a nonprivileged user can't disable the client.   |

:::image type="content" source="media/how-to-install-windows-client/global-secure-access-registry-key-private-hide-signout.png" alt-text="Screenshot of the Registry Editor with the HideSignOutButton and HideDisablePrivateAccessButton registry keys highlighted.":::

For more information, see [Guidance for configuring IPv6 in Windows for advanced users](/troubleshoot/windows-server/networking/configure-ipv6-in-windows).

## Related content

- [Install the Global Secure Access client for macOS](how-to-install-macos-client.md)
- [Install the Global Secure Access client for Android](how-to-install-android-client.md)
- [Install the Global Secure Access client for iOS](how-to-install-ios-client.md)
