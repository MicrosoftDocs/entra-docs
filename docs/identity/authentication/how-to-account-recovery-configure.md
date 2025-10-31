---
title: How to Enable and Test Account Recovery (Preview) in the Microsoft Entra Admin Center
description: How to enable Account Recovery (Preview) in the Microsoft Entra admin center.
ms.service: entra-id
ms.subservice: authentication
ms.topic: how-to
ms.date: 10/29/2025
ms.author: justinha
author: justinha
manager: dougeby
ms.reviewer: tilarso
ms.custom: sfi-ga-nochange, sfi-image-nochange
# Customer intent: As a Microsoft Entra Administrator, I want to learn how to enable and test Microsoft Entra ID account recovery for end users.
---

# How to enable and test Account Recovery (Preview) in the Microsoft Entra admin center

## Prerequisites

- You neeed a Microsoft Entra ID P1 license to use Account Recovery
- You need to be at an [Authentication Administrator](~/identity/role-based-access-control/permissions-reference.md#authentication-administrator) in the Microsoft Entra tenant
- You need the Contributor or Billing Administrator role for your Azure subscription

## Steps to enable Account Recovery (Preview) 

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Authentication Administrator](~/identity/role-based-access-control/permissions-reference.md#authentication-administrator).
1. Go to **Identity** > **Account recovery (Preview)**.
1. Under **Set up account recovery**, select **Get started**.

   :::image type="content" border="true" source="media/how-to-account-recovery-configure/get-started.png" alt-text="Screenshot that shows how to get started with account recovery."lightbox="media/how-to-account-recovery-configure/get-started.png":::

1. Under **Choose a recovery mode**, select **Evaluation**. 

   >[!NOTE]
   >In **Evaluation** mode, users can only test the identity verification process without actually recovering their accounts.

   :::image type="content" border="true" source="media/how-to-account-recovery-configure/recovery-mode.png" alt-text="Screenshot that shows how to choose an account recovery mode."lightbox="media/how-to-account-recovery-configure/recovery-mode.png":::

1. Under **User group selection**, click **Select groups**, choose any groups you want to include for account recovery, and select **Save**.

   :::image type="content" border="true" source="media/how-to-account-recovery-configure/group-selection.png" alt-text="Screenshot that shows how to select a group for account recovery."lightbox="media/how-to-account-recovery-configure/group-selection.png":::

1. After you choose groups you want to include for account recovery, select **Next**.

   :::image type="content" border="true" source="media/how-to-account-recovery-configure/group-selection-next.png" alt-text="Screenshot that shows how to select Next after you add a group for account recovery."lightbox="media/how-to-account-recovery-configure/group-selection-next.png":::

3. Under Identity verification providers, choose a provider and select **Get solution**.   

   >[!NOTE]
   >If you already subscribed to an Identity verification provider, proceed to step 15.

   :::image type="content" border="true" source="media/how-to-account-recovery-configure/get-solution.png" alt-text="Screenshot that shows how to get a solution for account recovery."lightbox="media/how-to-account-recovery-configure/get-solution.png":::

4. Select **Marketplace** and sign in to the [**Microsoft Security Store**](https://securitystore.microsoft.com/) as an Azure subscription owner or contributor.

   >[!NOTE]
   >For this step, you need to begin to purchase a SaaS offer from an IDV partner, which requires an Azure subscription. Make sure your signed-in account has the owner or contributor role of the Azure subscription linked to the tenant. To check role assignments, see [List Azure role assignments using the Azure portal](/azure/role-based-access-control/role-assignments-list-portal). To assign a role, see [Assign Azure roles using the Azure portal](/azure/role-based-access-control/role-assignments-portal).

   :::image type="content" border="true" source="media/how-to-account-recovery-configure/security-store.png" alt-text="Screenshot that shows how to sign in to Microsoft Security Store."lightbox="media/how-to-account-recovery-configure/security-store.png":::

5. On the **Overview** page for your Identity verification provider, select **Get solution**.
6. On the **Get solution** page:
   1. Under **Account details**, select a **Billing subscription**.
   2. Under **Account details**, select a **Resource group** and provide a **Resource name**.
   3. Under **Solution details**, select **Choose plan**, and select a price plan.
   4. Select **Next**.
7. Confirm your order details and select **Place order**.
8. When your SaaS subscription is ready, select **Configure account now**.

   >[!NOTE]
   >When clicking **Configure account now** you will be redirected to the SaaS provider admin portal to complete the purchase.

9.  Sign in to the SaaS subscription as an Azure subscription owner or contributor.
10. On the **General** page of the SaaS subscription, provide the required details requested by the SaaS provider (like contact name, email, and phone number), and select **Activate**.
11. once you see **Success**, return to the Account Recovery setup process in the [Microsoft Entra admin center](https://entra.microsoft.com) to complete the remaining steps.
12. Return to the Identity verification provider menu within the Account Recovery setup process, and choose **Select**.
13. In **Update account recovery setup (Preview)**, select **Next**.

   :::image type="content" border="true" source="media/how-to-account-recovery-configure/update-account-recovery-setup.png" alt-text="Screenshot that shows how to update account recovery setup."lightbox="media/how-to-account-recovery-configure/update-account-recovery-setup.png":::

14. On the **Review and finalize** page, review the details for account recovery configuration, and select **Done**.

   :::image type="content" border="true" source="media/how-to-account-recovery-configure/finalize.png" alt-text="Screenshot that shows how to finalize account recovery setup."lightbox="media/how-to-account-recovery-configure/finalize.png":::

15. After setup is finalized, the Account Recovery **Home** page opens in the Microsoft Entra admin center. 

   :::image type="content" border="true" source="media/how-to-account-recovery-configure/account-recovery-home.png" alt-text="Screenshot that shows account recovery home page."lightbox="media/how-to-account-recovery-configure/account-recovery-home.png":::

Once setup is complete, any users scoped to account recovery will now be able to attempt recovery and complete Identity Verification, but will not be able to recover their accounts as recovery is set in evaluation mode. 

## How to update and fully enable Account Recovery in the Microsoft Entra admin center

After testing account recovery in evaluation mode and confirming that the identity verification process works as expected, you can enable full recovery capabilities for your users. This process involves changing the recovery mode from **Evaluation** to **Recovery** and reviewing your user scope configuration.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Authentication Administrator](~/identity/role-based-access-control/permissions-reference.md#authentication-administrator).
1. Go to **Protection** > **Account Recovery**.
1. On the Account Recovery **Home** page, select **Manage**.
1. Under **Choose a recovery mode**, select **Production** to enable full account recovery capabilities.

   >[!NOTE]
   >In **Production** mode, users who complete identity verification will be able to fully recover their accounts and reset their authentication methods. In **Evaluation** mode, users can only test the identity verification process without actually recovering their accounts.

5. Under **User group selection**, review the groups currently configured for account recovery:
   - To add additional groups, click **Select groups**, choose the groups you want to include, and select **Save**.
   - To remove groups, select the group and click **Remove**.
   
   >[!IMPORTANT]
   >Carefully review which users are in scope for account recovery before enabling RProductionecovery mode. Ensure that only appropriate user populations have access to this capability based on your organization's security requirements.

6. Under **Identity verification providers**, review your selected provider. If needed, you can change to a different provider that has been subscribed to in the Microsoft Security Store.
7. Select **Next** to proceed to the review page.
8. On the **Review and finalize** page, carefully review all configuration changes:
   - Verify that **Recovery mode** is set to **Production**
   - Confirm that the correct user groups are in scope
   - Verify that the appropriate identity verification provider is selected
9. After reviewing the configuration, select **Complete** to apply the changes.
10. A confirmation message will appear indicating that account recovery has been successfully updated.

Once these steps are complete, users in the scoped groups will be able to use account recovery to fully regain access to their accounts when they lose all authentication methods. Users will complete identity verification through the configured provider and receive a Temporary Access Pass to re-enroll their authentication methods.