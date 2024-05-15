---
title: How to get the most from Microsoft Entra documentation
description: What is least privilege and how to navigate using Microsoft Entra documentation?

ms.service: entra
ms.subservice: fundamentals
ms.topic: how-to
ms.date: 04/15/2024

ms.author: joflore
author: MicrosoftGuyJFlo
manager: amycolannino
ms.reviewer:
---
# How to get the most from Microsoft Entra documentation

Within the Microsoft Entra documentation, you might notice some changes in how we explain things. These changes are intended to help you be more secure and make navigation easier.

## Least privilege

As your organization begins to manage Microsoft Entra, our documentation guides administrators to use a concept called "least privilege" where administrators use only the role required to do the job at hand. This concept is one of the three guiding principles of a [Zero Trust strategy](/security/zero-trust/zero-trust-overview) of:

- Verify explicitly
- **Use least privilege access**
- Assume breach

You see this concept surfaced in the first step of content called out like the following example with a link to the least privileged role definition:

- Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) **as at least a [Security Administrator](../identity/role-based-access-control/permissions-reference.md#security-administrator)**.

:::image type="content" source="media/how-to-navigate/least-privilge-steps.png" alt-text="Sreenshot of a document showing how to complete a step using the principle of least privilege.":::

There's still a need for the highly privileged [Global Administrator](../identity/role-based-access-control/permissions-reference.md#global-administrator) role in certain edge cases and we call them out as such.

Microsoft doesn't recommend that administrators work day to day with an active privileged role assignment. To combat these bad habits, organizations can use features like:

- [Privileged Identity Management](/entra/id-governance/privileged-identity-management/pim-configure) to elevate their accounts on a time limited basis to these highly privileged administrator roles.
- [Microsoft Entra Permissions Management](/entra/permissions-management/overview) to identify and remediate over-privileged users across multicloud infrastructures in Microsoft Azure, Amazon Web Services (AWS), and Google Cloud Platform (GCP).

### Find the right role

Use the following resources to find the right role for your administrators.

- [Common tasks mapped to applicable roles](/entra/identity/role-based-access-control/delegate-by-task)
- [Microsoft Entra built-in role listing](/entra/identity/role-based-access-control/permissions-reference)

## Portal navigation

There are many ways to find features and several portals you can use, including the following examples:

- [Microsoft Entra admin center](https://entra.microsoft.com/)
- [Azure portal](https://portal.azure.com/)
- [Microsoft Intune admin center](https://intune.microsoft.com/)
- [Microsoft 365 admin center](https://admin.microsoft.com/)

In our documentation, we primarily focus on the Microsoft Entra admin center and the shortest route to features. We guide users to features using a left to right navigation method like the following example:

- Browse to **Identity** > **Applications** > **Enterprise applications** > **New application**.

:::image type="content" source="media/how-to-navigate/navigation-example.png" alt-text="Screenshot showing an example of how to navigate using the steps found in an article.":::

This approach helps administrators new to a feature understand how to find what they're looking for in a standardized approach. More advanced administrators might find other ways to accomplish the same tasks including using the [Microsoft Graph APIs](/graph/use-the-api), but in content we primarily focus on these steps.

## Next steps

- [Improve your security posture](concept-secure-remote-workers.md)
- [What is Zero Trust?](/security/zero-trust/zero-trust-overview)
- [Security resources](/security/ciso-workshop/adoption)
