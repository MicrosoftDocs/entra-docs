---
title: Configure Requestor Visibility of Approver Details (Preview)
description: Learn how to configure whether requestors can see approver details for pending access package requests in the My Access portal at the tenant or package level.
author: OWinfreyATL
ms.service: entra-id-governance
ms.topic: how-to
ms.date: 08/20/2025
ms.author: owinfrey
ms.reviewer: owinfrey
---

# Configure whether requestors can see approver details (Preview)

> [!NOTE]
> This feature will be available beginning in September 2025.

Admins can control whether requestors see approver details for pending access package requests in the [My Access](https://myaccess.microsoft.com) portal. You can set this option at the access package level, or at the tenant level (default for all packages). The access package setting overrides the tenant setting when explicitly set to Yes or No.

## Tenant-level setting (applies to all access packages by default)

Use this setting to define the default behavior for all access packages in your tenant. This setting applies to **members only** and can be overridden by the access package-level setting.

1. In the Microsoft Entra admin center, go to **Identity Governance** > **Entitlement management** > **Control configurations**.

2. Under **My Access settings for end users**, find **Show approver details to members on pending access package requests (preview).**

3. Choose the desired behavior:

   - **Checked** – All members (excluding guests) will see their approver’s name and email address on pending access package requests in My Access.

   - **Unchecked** – Members won’t see approver details by default.

4. Select **Save**.

> [!NOTE]
> - The tenant setting applies to all access packages by default but can be overridden on a per-package basis via Advanced request settings.
> - To show approver details to guests and connected organization users, set the access package-level setting to Yes.



## Next step

> [!div class="nextstepaction"]
> [What are access reviews? - Microsoft Entra](access-reviews-overview.md)
> [What is the My Access portal?](my-access-portal-overview.md)