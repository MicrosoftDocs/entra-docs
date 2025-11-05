---
title: Configure Insider risk management-based approvals for access package requests in Entitlement Management (Preview)
description: This article describes how to configure Insider risk management-based approvals for access package requests.
author: owinfreyATL
ms.author: owinfrey
ms.service: entra-id-governance
ms.subservice: entitlement-management
ms.topic: how-to #Required; leave this attribute/value as-is
ms.date: 11/04/2025

#CustomerIntent: As an IT admin, I want to configure Insider risk management-based approvals for access package requests so that I can ensure risky users are reviewed before gaining access to sensitive resources.
---

# Configure Insider risk management-based approvals for access package requests in Entitlement Management (Preview)

Making sure risky users dont gain access to sensitive resources is an important part of securing your environment. You can further secure the entitlement management request process by integrating [Microsoft Purview Insider Risk Management (IRM)](/purview/insider-risk-management-configure) signals into the access package approval workflow in Microsoft Entra ID Governance’s Entitlement Management. With risk management-based approvals, Entitlement Management automatically adds a new first approval stage when a user flagged as risky requests access to an access package. This ensures that users identified as potentially compromised or at-risk are reviewed by authorized security or compliance approvers before access requests are routed for standard approval routing. This article describes how to further secure your entitlement request process with these features.

## License requirements

[!INCLUDE [active-directory-entra-governance-license.md](~/includes/entra-entra-governance-license.md)]

## Prerequisites

To use Insider Risk Management approvals with Entitlement management, you must first [Create an Insider Risk Management policy](/purview/insider-risk-management-policies).

[!INCLUDE [Entitlement Management risk-based-approvals](../includes/entitlement-management-risk-based-approvals.md)]

## Configure Insider Risk Management-based approvals for an access package using the Microsoft Entra admin center

To configure Insider Risk Management-based approvals for an access package in the Microsoft Entra admin center, you'd do the following steps:


1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Identity Governance Administrator](../identity/role-based-access-control/permissions-reference.md#identity-governance-administrator).
    
1. Browse to **ID Governance** > **Entitlement management** > **Control configurations**.

1. On the control configurations screen, you're able to see the options  
    :::image type="content" source="media/entitlement-management-configure-risk-approvals/control-configurations-cards.png" alt-text="Screenshot of the control configuration cards in Entitlement Management.":::

1. On the card **Risk-based approval (Preview)**, select **View settings**.

1. On the risk-based approval page, next to **Require approval for users with insider risk level (Preview)**, select **Customize**.
    :::image type="content" source="media/entitlement-management-configure-risk-approvals/risk-based-approval-overview.png" alt-text="Screenshot of the risk-based approval overview screen."::: 

1. You can set the insider risk level and then select **Save**.  
    :::image type="content" source="media/entitlement-management-configure-risk-approvals/insider-risk-levels-settings.png" alt-text="Screenshot of the insider risk level settings in entitlement management.":::




## Approving a risky user

When a risky user submits a request for an access package, administrators are able to see their pending status via the requests page within the access package:
:::image type="content" source="media/entitlement-management-configure-risk-approvals/risky-user-pending-request.png" alt-text="Screenshot of a pending request for an access package by a risky user.":::

A user set as an approver, or fallback approver, for risky users can view the request to approve or deny via the my access portal:
:::image type="content" source="media/entitlement-management-configure-risk-approvals/risky-user-approvals.png" alt-text="Screenshot of the approvals page in my access showing the risky user.":::



## Next step


- [Change approval and requestor information settings for an access package in entitlement management](entitlement-management-access-package-approval-policy.md)
