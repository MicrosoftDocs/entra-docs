---
title: Require Terms of Use at sign-in to Microsoft Admin Portals
description: How to require terms of use acceptance before access to selected cloud apps is granted with Microsoft Entra Conditional Access.

ms.service: entra-id
ms.subservice: conditional-access
ms.topic: how-to
ms.date: 03/11/2024

ms.author: joflore
author: MicrosoftGuyJFlo
manager: amycolannino
ms.reviewer: 
---
# Require terms of use to be accepted before accessing Microsoft Admin Portals

Organizations might want to require users to accept [terms of use (ToU)](terms-of-use.md) before accessing certain applications in their environment. This example helps you create a policy requiring terms of use to be accepted as part of the initial sign in process for administrators who access any of the [Microsoft Admin Portals](concept-conditional-access-cloud-apps.md#microsoft-admin-portals).

## Create your terms of use

This section provides you with the steps to create a sample terms of use document. When you create a terms of use document, you select a value for **Enforce with Conditional Access policy templates**. Selecting **Custom policy** opens a dialog to create a new Conditional Access policy as soon as your terms of use is created.

1. Create a new terms of use document and save it as a PDF file.
1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Protection** > **Conditional Access** > **Terms of use**.
1. In the menu on the top, select **New terms**.
1. In the **Name** textbox, provide a name for your terms of use policy.
1. Upload your terms of use PDF file.
   1. Select your default language.
   1. In the **Display name** textbox, type the name you want to be displayed.
1. For **Require users to expand the terms of use**, select **On**.
1. For **Enforce with Conditional Access policy templates**, select **Custom policy**.
1. Select **Create**.

## Create a Conditional Access policy

This section shows how to create the required Conditional Access policy. 

**To configure your Conditional Access policy:**

1. Give your policy a name. We recommend that organizations create a meaningful standard for the names of their policies.
1. Under **Assignments**, select **Users or workload identities**.
   1. Under **Include**, select **All users**.
   1. Under **Exclude**, select **Users and groups** and choose your organization's emergency access or break-glass accounts.
1. Under **Target resources** > **Cloud apps**, select the following options:
   1. Under **Include**, choose **Select apps**.
   1. Select **Microsoft Admin Portals**, and then choose **Select**.
1. Under **Access controls**, select **Grant**.
   1. Select **Grant access**.
   1. Select the terms of use you created previously called and choose **Select**.
1. Confirm your settings and set **Enable policy** to **Report-only**.
1. Select **Create** to create to enable your policy.

After administrators confirm the settings using [report-only mode](howto-conditional-access-insights-reporting.md), they can move the **Enable policy** toggle from **Report-only** to **On**.

## Test your Conditional Access policy

In the previous section, you created a Conditional Access policy requiring terms of use be accepted when accessing any of the [Microsoft Admin Portals](concept-conditional-access-cloud-apps.md#microsoft-admin-portals). 

To test your policy, try to sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) using a test account. You should see a dialog that requires you to accept your terms of use.

## Related content

[Microsoft Entra terms of use](terms-of-use.md)

[Conditional Access templates](concept-conditional-access-policy-common.md)

[Use report-only mode for Conditional Access to determine the results of new policy decisions.](concept-conditional-access-report-only.md)
