---
title: KDFv1 algorithm deprecation
description: Deprecation of Key Derivation Function version 1 algorithm guidance for device administrators

ms.service: entra-id
ms.subservice: devices
ms.topic: troubleshooting
ms.date: 11/08/2024

ms.author: joflore
author: MicrosoftGuyJFlo
manager: amycolannino
ms.reviewer: paulgarn
---
# Deprecation of KDFv1 algorithm in Microsoft Entra authentication

Microsoft is deprecating support for the Key Derivation Function version 1 (KDFv1) algorithm used for the authentication of Microsoft Entra joined or Microsoft Entra hybrid joined devices in builds of Windows released before July 2021. 

The KDFv1 algorithm was historically used for device authentication in earlier versions of Windows. A critical security flaw was discovered that allowed unauthorized authentication, as outlined in [CVE-2021-33781](https://www.cve.org/CVERecord?id=CVE-2021-33781). To address this vulnerability, Microsoft issued a Windows security update in July 2021. All Windows builds released after July 2021 no longer use the KDFv1 algorithm.

As part of our ongoing commitment to enhancing security, Microsoft is incrementally rolling out a change that blocks the use of the KDFv1 algorithm for authentication with Microsoft Entra.

## Impact of the deprecation

All Windows devices that authenticate using Microsoft Entra must have the security patch applied or be running builds of Windows released after July 2021. Unpatched Windows devices won't authenticate with Microsoft Entra once the rollout of this change completes.

<a name='sign-in-error-code-5000611'></a>

### Error messages

Users on unpatched devices encounter the following error message when attempting to sign in:

> Sign-in error code: 5000611
> 
> Failure reason: Symmetric Key Derivation Function version '1' is invalid. Update the device with the latest updates.

This error message will also be present in the Microsoft Entra sign-in logs, allowing administrators to identify authentication failures due to the deprecated KDFv1 algorithm.

> [!NOTE]
> Due to the incremental rollout of the deprecation, authentication failures on unpatched Windows devices may initially appear transient or intermittent. It is important to address these issues promptly by applying Windows security updates to maintain seamless authentication experiences.

## Actions required

Microsoft Entra administrators should proactively identify and address devices within their tenant that might be impacted by this deprecation. The following steps are recommended:

- Monitor Authentication Failures: Regularly check the Microsoft Entra sign-in logs for the error code 5000611 and the corresponding failure reason.
- Update Devices: If users report authentication failures with an error message referencing the KDFv1 algorithm, update their devices with the latest security updates for their Windows version.
- Search for Impacted Builds: Use the guidance provided in CVE Record CVE-2021-33781 to search for Windows devices within your tenant that might be running impacted builds. [PowerShell script to discover devices requiring an update](#powershell-script-to-discover-devices-requiring-an-update).
- Communicate with Users: Inform users about the importance of keeping their devices updated and provide instructions on how to apply necessary updates.

### PowerShell script to discover devices requiring an update

```powershell
# Script to discover devices requiring an update to address KDFv1 vulnerability

Connect-MgGraph -Scope "Device.Read.All"

Import-Module Microsoft.Graph.Identity.DirectoryManagement

# Define the output file
$file = ".\AffectedDevices.txt"

# Calculate the date for stale devices. Stale devices won't be listed
# Change this to a period you want to cover
$staleDate = (Get-Date).AddDays(-30)
Write-Host "Stale Date = $($staleDate)" 
# Retrieve all Windows devices
$WinDevices = Get-MgDevice -Property "id,displayName,operatingSystem,approximateLastSignInDateTime" -All -ErrorAction Stop | Where-Object {
$_.operatingSystem -eq "Windows" -and $_.approximateLastSignInDateTime -gt $staleDate
}

# Check if there are any devices in the $WinDevices array
if ($WinDevices.Count -eq 0) {
    Write-Host "No Windows devices found."
} else {
    Write-Host "Found $($WinDevices.Count) Windows devices."

    # Initialize an array to hold the output lines
    $outputLines = @()

    # Iterate through each device in the $WinDevices array
    foreach ($device in $WinDevices) {
        Write-Host "Processing device ID: $($device.id)"

        # Retrieve the device details including LastSignInDateTime
        $deviceDetails = Get-MgDevice -DeviceId $device.id -Property "id,deviceId,displayName,operatingSystem,operatingSystemVersion,approximateLastSignInDateTime" -ErrorAction Stop

        # Check if the device matches the filter for affected devices and LastSignInDateTime
        if (($deviceDetails.operatingSystemVersion -ge '10.0.22000' -and $deviceDetails.operatingSystemVersion -lt '10.0.22000.258') -or
             ($deviceDetails.operatingSystemVersion -ge '10.0.19041' -and $deviceDetails.operatingSystemVersion -lt '10.0.19044') -or
             ($deviceDetails.operatingSystemVersion -ge '10.0.18363' -and $deviceDetails.operatingSystemVersion -lt '10.0.18363.1679') -and
            ($deviceDetails.approximateLastSignInDateTime -ge $staleDate)){
            Write-Host "Device matches filter: $($deviceDetails.displayName)"
            $outputLines += "ID: $($deviceDetails.id)"
            $outputLines += "Device ID: $($deviceDetails.deviceId)"
            $outputLines += "Display Name: $($deviceDetails.displayName)"
            $outputLines += "Operating System: $($deviceDetails.operatingSystem)"
            $outputLines += "Operating System Version: $($deviceDetails.operatingSystemVersion)"
            $outputLines += "Last Sign-In DateTime: $($deviceDetails.approximateLastSignInDateTime)"
            $outputLines += "-----"
        } else {
            Write-Host "Device does not match filter: $($deviceDetails.displayName) OS Version $($deviceDetails.operatingSystemVersion)  Last Sign-In DateTime $($deviceDetails.approximateLastSignInDateTime)"
        }
    }

    # Write the output lines to the file
    $outputLines | Out-File -FilePath $file -Encoding UTF8
    Write-Host "AffectedDevices.txt file has been created."
}
```

### Proactive monitoring and updating

Proactively monitoring and updating devices is crucial to avoid any authentication disruptions. Microsoft Entra administrators can utilize the following strategies:

- Automated updates: Implement policies for automated updates to ensure all devices receive the latest security patches promptly.
- Regular audits: Conduct regular audits of your devices to ensure compliance with security update requirements.
- User training: Educate users about the significance of timely updates and how to check for and apply them.

## Related content

For more detailed information on the deprecation of the KDFv1 algorithm and associated security updates, refer to the following resources:

- [CVE Record CVE-2021-33781](https://www.cve.org/CVERecord?id=CVE-2021-33781)
- [What’s new in Microsoft Entra – June 2024](https://techcommunity.microsoft.com/blog/identity/what%e2%80%99s-new-in-microsoft-entra-%e2%80%93-june-2024/3796387)
- [Windows Update](https://support.microsoft.com/windows/how-to-update-windows-security-11e85d24-9f2c-16f9-af6d-c23cb1a473fe)
