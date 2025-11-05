---
author: owinfreyATL
ms.service: entra-id
ms.topic: include
ms.date: 11/04/2024
ms.author: owinfrey
---


## How risk-based approvals work

When a user requests access to an access package through the **My Access** portal:
1.	**Risk evaluation**: Entitlement Management queries Microsoft Entra ID Protection and Microsoft Purview Insider Risk Management for the user’s current userRiskLevel 

1.	**Configuration check**: If the user’s risk level matches one of the administrator-selected thresholds (for example, Medium or High), Entitlement Management automatically adds an additional risk-based approval stage before the standard approval process.

1.	**Automatic approver assignment**:
    - If the risk source is Identity Protection, the request is routed to users assigned the Security Administrator role in Microsoft Entra ID.
    - If the risk source is Insider Risk Management, the request is routed to users assigned the Compliance Administrator role.
    - If the risk is flagged by both then the review will be triggered in the following order: to IDP approval, followed by IRM approval, followed by AP policy approvals.

1.	**Security or compliance review**: The assigned approvers review the user’s risk details and decide whether to approve or deny this stage of the request approval routing.
    - If approved, the request continues through the rest of the regular access package approval steps.
    - If denied, the request is closed, recorded in the audit logs, and no further approval routing takes place.

1.	**Audit logging**: All actions (approval and denial) and outcomes are captured in [Entitlement Management logs](../id-governance/entitlement-management-logs-and-reporting.md) for reporting and compliance visibility.