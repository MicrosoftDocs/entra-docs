---
title: Security update to remove support for KDFv1 algorithm for authentication
description: Removal of Key Derivation Function version 1 algorithm and proactive guidance for device administrators.

ms.service: entra-id
ms.subservice: devices
ms.topic: troubleshooting
ms.date: 06/27/2025

ms.author: owinfrey
author: owinfreyATL
manager: dougeby
ms.reviewer: sgrandhi
---
# Security update to remove KDFv1 algorithm support in Microsoft Entra authentication

Microsoft is removing support for the Key Derivation Function version 1 (KDFv1) algorithm used for the authentication of Microsoft Entra joined or Microsoft Entra hybrid joined devices in builds of Windows released before July 2021. 

The KDFv1 algorithm was historically used for device authentication in earlier versions of Windows. A critical security flaw was discovered that allowed unauthorized authentication, as outlined in [CVE-2021-33781](https://www.cve.org/CVERecord?id=CVE-2021-33781). To address this vulnerability, Microsoft issued a Windows security update in July 2021. All Windows builds released after July 2021 no longer use the KDFv1 algorithm.

As part of our ongoing commitment to enhancing security, Microsoft is incrementally rolling out a security update that blocks the use of the KDFv1 algorithm for authentication with Microsoft Entra.

## Effects of the security update

All Windows devices that authenticate using Microsoft Entra must have the security patch applied or be running builds of Windows released after July 2021. Unpatched Windows devices won't authenticate with Microsoft Entra once the rollout of this change completes.

<a name='sign-in-error-code-5000611'></a>

### Error messages

Users on unpatched devices encounter the following error message when attempting to sign in:

> Sign-in error code: 5000611
> 
> Failure reason: Symmetric Key Derivation Function version '1' is invalid. Update the device with the latest updates.

This error message is also present in the Microsoft Entra sign-in logs, allowing administrators to identify authentication failures due to the deprecated KDFv1 algorithm.

> [!NOTE]
> Due to the incremental rollout of the security update, authentication failures on unpatched Windows devices may initially appear transient or intermittent.  Early in the rollout retrying authentication will likely succeed. It is important to address these issues promptly by applying Windows security updates to maintain seamless authentication experiences.

## Actions required

Microsoft Entra administrators should proactively identify and address devices within their tenant that might be impacted by this security update. The following steps are recommended:

- Monitor Authentication Failures: Regularly check the Microsoft Entra sign-in logs for the error code 5000611 and the corresponding failure reason.
- Update Devices: If users report authentication failures with an error message referencing the KDFv1 algorithm, update their devices with the latest security updates for their Windows version.
- Search for Impacted Builds: Use the guidance provided in CVE Record CVE-2021-33781 to search for Windows devices within your tenant that might be running impacted builds.
- Communicate with Users: Inform users about the importance of keeping their devices updated and provide instructions on how to apply necessary updates.

### Proactive monitoring and updating

Proactively monitoring and updating devices is crucial to avoid any authentication disruptions. Microsoft Entra administrators can utilize the following strategies:

- Automated updates: Implement policies for automated updates to ensure all devices receive the latest security patches promptly.
- Regular audits: Conduct regular audits of your devices to ensure compliance with security update requirements.
- User training: Educate users about the significance of timely updates and how to check for and apply them.

## Related content

For more detailed information on the removal of the KDFv1 algorithm and associated security updates, refer to the following resources:

- [CVE Record CVE-2021-33781](https://www.cve.org/CVERecord?id=CVE-2021-33781)
- [What’s new in Microsoft Entra – June 2024](https://techcommunity.microsoft.com/blog/identity/what%e2%80%99s-new-in-microsoft-entra-%e2%80%93-june-2024/3796387)
- [Windows Update](https://support.microsoft.com/windows/how-to-update-windows-security-11e85d24-9f2c-16f9-af6d-c23cb1a473fe)
