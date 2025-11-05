---
title: Configure ID Protection-based approvals for access package requests in Entitlement Management (Preview)
description: This article describes how to configure ID Protection-based approvals for access package requests.
author: owinfreyATL
ms.author: owinfrey
ms.service: entra-id-governance
ms.subservice: entitlement-management
ms.topic: how-to #Required; leave this attribute/value as-is
ms.date: 11/04/2025

#CustomerIntent: As a < type of user >, I want < what? > so that < why? >.
---

# Configure ID Protection-based approvals for access package requests in Entitlement Management (Preview)


<!-- 2. Introductory paragraph ----------------------------------------------------------

Required: Lead with a light intro that describes, in customer-friendly language, what the customer will do. Answer the fundamental “why would I want to do this?” question. Keep it short.

Readers should have a clear idea of what they will do in this article after reading the introduction.

* Introduction immediately follows the H1 text.
* Introduction section should be between 1-3 paragraphs.
* Don't use a bulleted list of article H2 sections.

Example: In this article, you will migrate your user databases from IBM Db2 to SQL Server by using SQL Server Migration Assistant (SSMA) for Db2.

-->

Making sure risky users dont gain access to sensitive resources is an important part of securing your environment. You can further secure the entitlement management request process by integrating [Microsoft Entra ID Protection (IDP)](../id-protection/overview-identity-protection.md) signals into the access package approval workflow in Microsoft Entra ID Governance’s Entitlement Management. With ID protection, Entitlement Management automatically adds a new first approval stage when a user flagged as risky requests access to an access package. This ensures that users identified as potentially compromised or at-risk are reviewed by authorized security or compliance approvers before access requests are routed for standard approval routing. This article describes how to further secure your entitlement request process with ID protection.

## License requirements

[!INCLUDE [active-directory-entra-governance-license.md](~/includes/entra-entra-governance-license.md)]

[!INCLUDE [Entitlement Management risk-based-approvals](../includes/entitlement-management-risk-based-approvals.md)]

## Configure ID protection-based approvals for an access package using the Microsoft Entra admin center

To configure ID protection-based approvals for an access package in the Microsoft Entra admin center, you'd do the following steps:


1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Identity Governance Administrator](../identity/role-based-access-control/permissions-reference.md#identity-governance-administrator).
    
1. Browse to **ID Governance** > **Entitlement management** > **Control configurations**.

1. On the control configurations screen you are able to see the options  
    :::image type="content" source="media/entitlement-management-configure-risk-approvals/control-configurations-cards.png" alt-text="Screenshot of the control configuration cards in Entitlement Management.":::

1. On the card **Risk-based approval (Preview)**, select View settings.

1. On the risk-based approval page, next to **Require approval for users with ID protection risk (Preview)**, select **Customize**.
    :::image type="content" source="media/entitlement-management-configure-risk-approvals/risk-based-approval-overview.png" alt-text="Screenshot of the risk-based approval overview screen."::: 

1. You can set whether or not approval is required for users with ID protection risk, what the risk signal is, who are approvers and fallback approvers for these risky users, when a decision must be made on these risky users, and whether or not justification is required by the approver. Select **Save** when finished.  
    :::image type="content" source="media/entitlement-management-configure-risk-approvals/id-protection-risk-settings.png" alt-text="Screenshot of the ID protection risk settings in entitlement management.":::




## Approving a risky user

When a risky user has submitted a request for an access package, administrators are able to see their pending status via the requests page within the access package:
:::image type="content" source="media/entitlement-management-configure-risk-approvals/risky-user-pending-request.png" alt-text="Screenshot of a pending request for an access package by a risky user.":::

A user set as an approver, or fallback approver, for risky users can view the request to approve or deny via the my access portal:
:::image type="content" source="media/entitlement-management-configure-risk-approvals/risky-user-approvals.png" alt-text="Screenshot of the approvals page in my acess showing the risky user.":::



## Next step


- [Change approval and requestor information settings for an access package in entitlement management](entitlement-management-access-package-approval-policy.md)




