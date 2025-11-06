---
title: Configure ID Protection-based approvals for access package requests in Entitlement Management (Preview)
description: This article describes how to configure ID Protection-based approvals for access package requests.
author: owinfreyATL
ms.author: owinfrey
ms.service: entra-id-governance
ms.subservice: entitlement-management
ms.topic: how-to #Required; leave this attribute/value as-is
ms.date: 11/04/2025

#CustomerIntent: As an IT admin, I want to configure ID Protection-based approvals for access package requests so that I can ensure risky users are reviewed before gaining access to sensitive resources.
---

# Configure ID Protection-based approvals for access package requests in Entitlement Management (Preview)

Making sure risky users don’t gain access to sensitive resources is an important part of securing your environment. You can further secure the entitlement management request process by integrating [Microsoft Entra ID Protection (IDP)](../id-protection/overview-identity-protection.md) signals into the access package approval workflow in Microsoft Entra ID Governance entitlement management. With ID protection, entitlement management automatically adds a new first approval stage when a user flagged as risky requests access to an access package. This feature ensures that users identified as potentially compromised or at risk are reviewed by authorized security or compliance approvers before access requests are routed for standard approval routing. This article describes how to further secure your entitlement request process with ID Protection.

## License requirements

[!INCLUDE [active-directory-entra-governance-license.md](~/includes/entra-entra-governance-license.md)]

## Prerequisites

To use ID-protection with Entitlement management, you must first [deploy ID protection](../id-protection/how-to-deploy-identity-protection.md).

## How risk-based approvals work

When a user requests access to an access package through the **My Access** portal:
1.	**Risk evaluation**: Entitlement Management queries Microsoft Entra ID Protection for the user’s current userRiskLevel 

1.	**Configuration check**: If the user’s risk level matches one of the administrator-selected thresholds (for example, Medium or High), Entitlement Management automatically adds an additional risk-based approval stage before the standard approval process.

1.	**Automatic approver assignment**:
    - If the risk source is Identity Protection, the request is routed to users assigned the Security Administrator role in Microsoft Entra ID.

1.	**Security or compliance review**: The assigned approvers review the user’s risk details and decide whether to approve or deny this stage of the request approval routing.
    - If approved, the request continues through the rest of the regular access package approval steps.
    - If denied, the request is closed, recorded in the audit logs, and no further approval routing takes place.

1.	**Audit logging**: All actions (approval and denial) and outcomes are captured in [Entitlement Management logs](../id-governance/entitlement-management-logs-and-reporting.md) for reporting and compliance visibility.

## Configure ID protection-based approvals for an access package using the Microsoft Entra admin center

To configure ID protection-based approvals for an access package in the Microsoft Entra admin center, you'd do the following steps:


1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Identity Governance Administrator](../identity/role-based-access-control/permissions-reference.md#identity-governance-administrator).
    
1. Browse to **ID Governance** > **Entitlement management** > **Control configurations**.

1. On the control configurations screen, you're able to see the options  
    :::image type="content" source="media/entitlement-management-configure-risk-approvals/control-configurations-cards.png" alt-text="Screenshot of the control configuration cards in Entitlement Management." lightbox="media/entitlement-management-configure-risk-approvals/control-configurations-cards.png":::

1. On the card **Risk-based approval (Preview)**, select **View settings**.

1. On the risk-based approval page, next to **Require approval for users with ID protection risk (Preview)**, select **Customize**.
    :::image type="content" source="media/entitlement-management-configure-risk-approvals/risk-based-approval-overview.png" alt-text="Screenshot of the risk-based approval overview screen."::: 

1. You can set the ID protection user risk level and then select **Save**.  
    :::image type="content" source="media/entitlement-management-configure-risk-approvals/id-protection-risk-settings.png" alt-text="Screenshot of the ID protection risk settings in entitlement management.":::




## Approving a risky user

To Approve a risky user, approvers must have the [Security Reader](../identity/role-based-access-control/permissions-reference.md#security-reader) role at the time of approval.

When a risky user submits a request for an access package, administrators are able to see their pending status via the requests page within the access package:
:::image type="content" source="media/entitlement-management-configure-risk-approvals/risky-user-pending-request.png" alt-text="Screenshot of a pending request for an access package by a risky user.":::

A user set as an approver, or fallback approver, for risky users can view the request to approve or deny via the my access portal:
:::image type="content" source="media/entitlement-management-configure-risk-approvals/risky-user-approvals.png" alt-text="Screenshot of the approvals page in my access showing the risky user." lightbox="media/entitlement-management-configure-risk-approvals/risky-user-approvals.png":::

> [!NOTE]
> Approvers have a maximum of 14 days to take action. If they don't take action within that time frame, requests are automatically denied.



## Next step

- [Configure Insider risk management-based approvals for access package requests in Entitlement Management (Preview)](entitlement-management-configure-insider-risk-management-approvals.md) Should be configured next if you plan to use it. Then Access Package policies should be configured.




