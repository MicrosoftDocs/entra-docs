---
title: Create a Microsoft Entra developer tenant
description: Learn how to create a developer tenant for testing Microsoft Entra Verified ID.
ms.topic: how-to
ms.date: 03/09/2026
ai-usage: ai-assisted
# Customer intent: As a developer, I want to learn how to create a developer Microsoft Entra account so I can test verifiable credentials.
---

# Microsoft Entra Verified ID developer information

> [!NOTE]
> The requirement of a Microsoft Entra ID P2 license was removed in early May 2021. The Microsoft Entra ID Free tier is now supported.

## Create a Microsoft Entra tenant for development

You can create a Microsoft Entra tenant for development and testing in either of the following ways:

- **Microsoft 365 Developer Program** — Join the [Microsoft 365 Developer Program](https://aka.ms/o365devprogram) to get a sandbox tenant with E5 licenses, configured users, groups, and mailboxes. A qualifying subscription or program membership is required — see [who qualifies](/office/developer-program/microsoft-365-developer-program-faq#who-qualifies-for-a-microsoft-365-e5-developer-subscription-) for details.
- **Free Microsoft Entra tenant** — [Create a new tenant](~/identity-platform/quickstart-create-new-tenant.md) and [activate a free trial of Microsoft Entra ID P1 or P2](https://azure.microsoft.com/trial/get-started-active-directory/) in your new tenant.

> [!IMPORTANT]
> The Microsoft 365 Developer Program requires a qualifying subscription or program membership. Eligible members include Visual Studio Enterprise or Professional subscribers, ISV Success Program or Microsoft AI Cloud Partner Program participants, and Premier or Unified Support customers. For more information, see the [M365 Developer Program eligibility update](https://devblogs.microsoft.com/microsoft365dev/stay-ahead-of-the-game-with-the-latest-updates-to-the-microsoft-365-developer-program/) and [Who qualifies for a Microsoft 365 E5 developer subscription?](/office/developer-program/microsoft-365-developer-program-faq#who-qualifies-for-a-microsoft-365-e5-developer-subscription-). If you don't qualify, use the free tenant option instead.

### Sign up for the Microsoft 365 Developer Program

If you have a qualifying subscription or program membership and decide to sign up for the Microsoft 365 Developer Program, follow these steps:

1. On the [Microsoft 365 Developer Program](https://aka.ms/o365devprogram) page, select **Join now**.

1. Sign in with a new Microsoft account or use an existing (work) account.

1. On the sign-up page, select your region, enter a company name, and accept the terms and conditions of the program.

1. Select **Next**.

1. Select **Set up subscription**. Specify the region where you want to create your new tenant, create a username, domain, and enter a password. This step creates a new tenant and the first administrator of the tenant.

1. Enter the security information needed to protect the administrator account of your new tenant. This step sets up multifactor authentication for the account.

At this point, you've created a tenant with 25 E5 user licenses. The E5 licenses include Microsoft Entra ID P2 licenses. Optionally, you can add sample data packs with users, groups, mail, and SharePoint to help you test in your development environment. For the verifiable credential issuing service, they aren't required.

## Next steps

Now that you have a developer account, try our [first tutorial](./verifiable-credentials-configure-tenant.md) to learn more about verifiable credentials.
