---  
title: Restrict password usage on Microsoft Entra apps  
description: Block the addition of passwords on Microsoft Entra apps to improve security 
author: arcrowe
ms.author: arcrowe
ms.date: 08/19/2025
ms.topic: how-to
ms.service: microsoft-365-admin
ms.localizationpriority: medium
ms.collection: RestrictedMode
audience: admin
---

# Restrict password usage on Microsoft Entra apps

Passwords are one of the weakest methods of service authentication and are vulnerable to compromise by bad actors. Microsoft recommends that organizations switch applications in their tenant to a [more secure credential method](/docs/identity-platform/security-best-practices-for-app-registration.md#credentials-including-certificates-and-secrets). This improves security and reduces management overhead.

Tenant administrators can block the addition of new passwords to applications in their tenant. This should eventually deprecate password usage in their organization as apps modernize their credential methods and existing passwords expire. Administrators can also speed up this process by identifying apps with existing passwords and removing them.

## Block password addition

New password addition can be blocked in the Microsoft 365 admin center.

1. Go to the admin center and select Org settings.
1. Select Restricted Mode, find the **Block addition of new password credentials to apps** setting, and switch the toggle to **On**.

Password addition can also be blocked using the [Microsoft Entra admin center](https://aka.ms/app-mgmt-policy-ux). See the [app management policy usage documentation](https://aka.ms/app-mgmt-policy-ux-docs) for more details.

Enabling this setting blocks the addition of passwords to existing apps, or setting passwords during new app creation. You can gauge the impact of enabling this setting by identifying recent password addition activity. From the Microsoft 365 admin center:

1. Go to the admin center and select Org settings.
1. Select Restricted Mode, find the **Block addition of new password credentials to apps** setting.
1. Select **download report** to view recent password additions in your organization.

## Remove existing passwords

Blocking addition of new passwords won't affect existing passwords. Existing apps using passwords can be identified using the Microsoft 365 admin center.

1. Go to the admin center and select Org settings.
1. Select Restricted Mode, find the **Block addition of new password credentials to apps** setting.
1. Select **download report** to view existing apps with passwords.

Apps using passwords should be modernized before their existing passwords are removed.  Passwords on existing applications can be removed using the [Microsoft Entra admin center](https://entra.microsoft.com/#view/Microsoft_AAD_RegisteredApps/ApplicationsListBlade/quickStartType~/null/sourceType/Microsoft_AAD_IAM), [Microsoft Graph Powershell](https://learn.microsoft.com/en-us/powershell/module/microsoft.graph.applications/remove-mgapplicationpassword?view=graph-powershell-1.0), or the [Microsoft Graph API](https://learn.microsoft.com/en-us/graph/api/application-removepassword?view=graph-rest-1.0&tabs=http).
