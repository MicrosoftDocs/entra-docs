---
title: What is the My Access portal? - Microsoft Entra
description: A description of the My Access portal where users can manage access within Microsoft Entra.
author: owinfreyATL
ms.author: owinfrey
ms.service: entra-id-governance
ms.topic: overview
ms.date: 12/10/2024


---


# What is the My Access portal?

My Access is a web-based portal used by users to review or request access resources within Microsoft Entra, and by Administrators to configure this access. Depending on who is using the My Access portal, a different set of actions can be taken.

Users access the My Access portal to:

- Request access
- Approve or deny access
- Review access for themselves
- Review access for others

Administrators, via the Microsoft Entra admin center, can configure:

- Access packages that users can request
- Access reviews for access packages
- Access reviews for groups and applications
- An overview page

## License requirements

[!INCLUDE [entra-p2-governance-license.md](../includes/entra-p2-governance-license.md)]

## Overview page

The Overview page shows you key tasks that need your attention such as pending requests and reviews. It's the landing page for the My Access portal.

## Discover access packages

In the My Access portal, you can view the access packages you can request by selecting **Access packages** in the left-hand menu and the **Available** tab. Find the access package you want to request access to in the list. You can search for an access package by name, description, or resources via the search bar. Once you locate the access package, select the row. You might have to answer questions and provide business justification for your request.

Select Request history in the left-hand menu to see a list of your requests and the status.

For more information, see [Request an access package - entitlement management](entitlement-management-request-access.md).


## Approve or deny a request

In the My Access portal, you can view your pending requests by selecting **Approvals** in the left-hand menu. Select a pending request and review the details. Based on the information provided, approve or deny the request.  

For more information, see [Approve or deny access requests - entitlement management](entitlement-management-request-approve.md).

## Review access

In the My Access portal, you can view your pending access reviews by selecting **Access reviews** in the left-hand menu. On this page, select the specific review, and make a decision based on the information provided.

Microsoft Entra ID will also send you an email with instructions shortly after the review starts. Follow the instructions in the email to complete the review.

For more information about self-reviews, see: [Review your access to resources in access reviews](self-access-review.md).

For more information about reviews for others, see: [Review access to groups & applications in access reviews](perform-access-review.md).

## Next step

> [!div class="nextstepaction"]
> [What are access reviews? - Microsoft Entra](access-reviews-overview.md)
