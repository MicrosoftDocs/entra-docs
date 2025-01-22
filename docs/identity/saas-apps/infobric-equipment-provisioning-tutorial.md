---
title: "Tutorial: Configure Infobric Equipment for automatic user provisioning with Microsoft Entra ID"
description: Learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Infobric Equipment.

author: CvBlixen
manager: fogbring
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: tutorial
ms.date: 01/22/2025
ms.author: CvBlixen
# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Infobric Equipment so that I can streamline the user management process and ensure that users have the appropriate access to Infobric Equipment.
---

# Tutorial: Configure Infobric Equipment for automatic user provisioning

This tutorial describes the steps you need to perform in both Infobric Equipment and Microsoft Entra ID to configure automatic user and group provisioning.

When configured, Microsoft Entra ID automatically provisions and deprovisions users and groups to Infobric Equipment using the Microsoft Entra provisioning service.

For important details on what this service does, how it works, and frequently asked questions, see [What is app provisioning in Microsoft Entra ID?](~/identity/app-provisioning/user-provisioning.md).

## Supported capabilities

> [!div class="checklist"]
>
> - Create users in Infobric Equipment.
> - Remove users from Infobric Equipment.
> - Synchronize Microsoft Entra ID and Infobric Equipment user attributes.
> - Create groups in Infobric Equipment.
> - Remove groups from Infobric Equipment.
> - Synchronize Microsoft Entra ID and Infobric Equipment group memberships.

## Prerequisites

The scenario outlined in this tutorial assumes that you already have the following prerequisites:

- [A Microsoft Entra tenant](~/identity-platform/quickstart-create-new-tenant.md)
- A user in said tenant that is either an [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator) or a [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator).
- A user in Infobric Equipment with administrator permissions in the Infobric Equipment company for which we are setting up user provisioning.

## Step 1: Obtain your Infobric Equipment endpoint and token

1. Log in to Infobric Equipment [here](https://company.infobricequipment.app/).
1. If you are a member of multiple companies: Make sure you have picked the correct company in the top left corner:

   ![Screenshot of Infobric Equipment company picker](./media/infobric-equipment-provisioning-tutorial/pick-company.png)

1. Browse to **Admin** > **Settings** and **enable Microsoft Entra user provisioning**. Note the endpoint and token. You will need them in Step 4.

   ![Screenshot of enabling Entra in Infobric Equipment.](./media/infobric-equipment-provisioning-tutorial/enable-entra-provisioning.png)

## Step 2: Create the Infobric Equipment application in Microsoft Entra ID

If the Infobric Equipment app has already been created, you can skip this step.

Infobric is not yet listed in the Microsoft Entra application gallery, so you need to create the app manually, like so:

1. Go to the [Microsoft Entra admin center](https://entra.microsoft.com) and browse to **Applications** > **Enterprise applications**.
1. Click **New application**.
1. Click **Create your own application**.
1. Name the application "Infobric Equipment". If this is a test or if you are running multiple Infobric Equipment companies, then consider adding something to tell this new application apart from others, such as the company name or "Test".
1. Choose "Integrate any other application you don't find in the gallery (Non-gallery)" for what you want to do with the application.
1. Click **Create**.

## Step 3: Give users and groups access to Infobric Equipment

1. If you are not already there, browse to the newly created application's **Overview** page.
1. Click **Users and groups** (under the **Manage** heading).
1. Click **Add user/group** and add the users and groups you want to have access to Infobric Equipment. (Tip: Start with a small set of users and groups before rolling out to everyone.)

   ![Screenshot of single user added to Infobric Equipment in Entra.](./media/infobric-equipment-provisioning-tutorial/single-user-added-to-application.png)

## Step 4: Connect the Entra application to Infobric Equipment

1. Click **Provisioning**.
1. Click **Connect you application**.
1. Enter the endpoint and token you noted in Step 1.

   ![Screenshot of Token.](./media/infobric-equipment-provisioning-tutorial/endpoint-and-token-pasted-to-entra.png)

1. Click **Test Connection** to ensure Microsoft Entra ID can connect to Infobric Equipment. If the connection fails, please go back to Infobric Equipment and use the support chat for assistance. If the connection is successful, click **Create**.

## Step 5: Map user and group attributes

1. Click **Attribute mapping** (may still be **Attribute mapping (Preview)**)
1. Click **Provision Microsoft Entra ID Users**.
1. Keep the default mappings for application attributes `userName`, `active`, `emails[type eq "work"].value`, `name.givenName`, `name.familyName` and `phoneNumbers[type eq "mobile"].value`.
1. Delete all other mappings.
1. Keep all other defaults on the Attribute mapping page.
1. Click **Save**.

Note: No changes are needed for the group mappings.

## Step 6: Provision a single user and a single group

1. Click **Provision on demand**.
1. Select a user and click **Provision**. Make everything looks good on the Entra side and on the Infobric Equipment side.
1. Select a group and click **Provision**. Make everything looks good on the Entra side and on the Infobric Equipment side.

## Step 7: Enable e-mail notifications on failure

1. Find the field for this and fill in you email.

## Step 8: Enable automatic provisioning

1. Click **Start provisioning**.
