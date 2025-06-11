---
title: Require MFA for Azure management with Conditional Access
description: Create a custom Conditional Access policy to require multifactor authentication for Azure management tasks.

ms.service: entra-id
ms.subservice: conditional-access
ms.topic: how-to
ms.date: 04/01/2025

ms.author: joflore
author: MicrosoftGuyJFlo
manager: femila
ms.reviewer: lhuangnorth
---
# Require MFA for Azure management

Organizations use many Azure services and manage them from Azure Resource Manager based tools like:

* Azure portal
* Azure PowerShell
* Azure CLI

These tools can provide highly privileged access to resources that can make the following changes: 

- Alter subscription-wide configurations 
- Service settings
- Subscription billing

To protect these privileged resources, Microsoft recommends requiring multifactor authentication for any user accessing these resources. In Microsoft Entra ID, these tools are grouped together in a suite called [Windows Azure Service Management API](concept-conditional-access-cloud-apps.md#windows-azure-service-management-api). For Azure Government, this suite should be the Azure Government Cloud Management API app. 

## User exclusions
[!INCLUDE [active-directory-policy-exclusions](~/includes/entra-policy-exclude-user.md)]

[!INCLUDE [active-directory-policy-deploy-template](~/includes/entra-policy-deploy-template.md)]

## Create a Conditional Access policy

The following steps help create a Conditional Access policy to require users who access the [Windows Azure Service Management API](concept-conditional-access-cloud-apps.md#windows-azure-service-management-api) suite do multifactor authentication.

> [!CAUTION]
> Make sure you understand how Conditional Access works before setting up a policy to manage access to Windows Azure Service Management API. Make sure you don't create conditions that could block your own access to the portal.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Entra ID** > **Conditional Access** > **Policies**.
1. Select **New policy**.
1. Give your policy a name. We recommend that organizations create a meaningful standard for the names of their policies.
1. Under **Assignments**, select **Users or workload identities**.
   1. Under **Include**, select **All users**.
   1. Under **Exclude**, select **Users and groups** and choose your organization's emergency access or break-glass accounts. 
1. Under **Target resources** > **Resources (formerly cloud apps)** > **Include** > **Select resources**, choose **Windows Azure Service Management API**, and select **Select**.
1. Under **Access controls** > **Grant**, select **Grant access**, **Require multifactor authentication**, and select **Select**.
1. Confirm your settings and set **Enable policy** to **Report-only**.
1. Select **Create** to create to enable your policy.

[!INCLUDE [conditional-access-report-only-mode](../../includes/conditional-access-report-only-mode.md)]

## Next steps

[Conditional Access templates](concept-conditional-access-policy-common.md)

[Use report-only mode for Conditional Access to determine the results of new policy decisions.](concept-conditional-access-report-only.md)
