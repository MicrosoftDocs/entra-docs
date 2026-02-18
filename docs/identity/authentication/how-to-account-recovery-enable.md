---
title: How to Enable and Test Account Recovery (Preview) in the Microsoft Entra Admin Center
description: How to enable Account Recovery (Preview) in the Microsoft Entra admin center.
ms.topic: how-to
ms.date: 11/08/2025
ms.reviewer: tilarso
ms.custom: sfi-ga-nochange, sfi-image-nochange
# Customer intent: As a Microsoft Entra Administrator, I want to learn how to enable and test Microsoft Entra ID account recovery for end users.
---

# How to enable and test Account Recovery (Preview) in the Microsoft Entra admin center

Account Recovery (Preview) is a Microsoft Entra ID feature that helps users regain access to their accounts when they lose all their authentication methods, such as when they lose their phone or hardware token. This capability uses third-party identity verification providers to securely verify a user's identity through alternative means, allowing them to recover their account and re-enroll their authentication methods. This article walks you through the complete process of enabling and configuring Account Recovery in your Microsoft Entra tenant, from initial setup in evaluation mode through full production deployment.

## Prerequisites

- You need a Microsoft Entra ID P1 license to use Account Recovery
- You need to enable Verified ID and configure Face Check
- You need to be an [Authentication Administrator](~/identity/role-based-access-control/permissions-reference.md#authentication-administrator) in the Microsoft Entra tenant
- You need the Contributor or Billing Administrator role for your Azure subscription

## Steps to enable Account Recovery (Preview) 

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Authentication Administrator](~/identity/role-based-access-control/permissions-reference.md#authentication-administrator).
1. Go to **Identity** > **Account recovery (Preview)**.
1. Under **Set up account recovery**, select **Get started**.
1. Under **Choose a recovery mode**, select **Evaluation**. 

   >[!NOTE]
   >In **Evaluation** mode, users can only test the identity verification process without actually recovering their accounts.

   :::image type="content" border="true" source="media/how-to-account-recovery-enable/recovery-mode.png" alt-text="Screenshot that shows how to choose an account recovery mode."lightbox="media/how-to-account-recovery-enable/recovery-mode.png":::

1. Under **User group selection**, click **Select groups**, choose any groups you want to include for account recovery, and select **Save**.

   :::image type="content" border="true" source="media/how-to-account-recovery-enable/group-selection.png" alt-text="Screenshot that shows how to select a group for account recovery."lightbox="media/how-to-account-recovery-enable/group-selection.png":::

1. After you choose groups you want to include for account recovery, select **Next**.

1. Under **Identity verification providers**, choose a provider and select **Get solution**.   

   >[!NOTE]
   >If you already subscribed to an Identity verification provider, proceed to step 15.

   :::image type="content" border="true" source="media/how-to-account-recovery-enable/get-solution.png" alt-text="Screenshot that shows how to get a solution for account recovery."lightbox="media/how-to-account-recovery-enable/get-solution.png":::

1. Select **Marketplace** and sign in to the [**Microsoft Security Store**](https://securitystore.microsoft.com/) as an Azure subscription owner or contributor.

   >[!NOTE]
   >For this step, you need to begin to purchase a Software-as-a-Service (SaaS) offer from an IDV partner, which requires an Azure subscription. Make sure your signed-in account has the owner or contributor role of the Azure subscription linked to the tenant. To check role assignments, see [List Azure role assignments using the Azure portal](/azure/role-based-access-control/role-assignments-list-portal). To assign a role, see [Assign Azure roles using the Azure portal](/azure/role-based-access-control/role-assignments-portal).

   :::image type="content" border="true" source="media/how-to-account-recovery-enable/security-store-vendor.png" alt-text="Screenshot that shows how to sign in to Microsoft Security Store."lightbox="media/how-to-account-recovery-enable/security-store-vendor.png":::

1. On the **Overview** page for your Identity verification provider, select **Get solution**.
1. On the **Get solution** page:
   1. Under **Account details**, select a **Billing subscription**.
   1. Under **Account details**, select a **Resource group** and provide a **Resource name**.
   1. Under **Solution details**, select **Choose plan**, and select a price plan.
   1. Select **Next**.
1. Confirm your order details and select **Place order**.
1. When your SaaS subscription is ready, select **Configure account now**.

   >[!NOTE]
   >After you select **Configure account now**, you're redirected to the SaaS provider admin portal to complete the purchase.

1. Sign in to the SaaS subscription as an Azure subscription owner or contributor.
1. On the **General** page of the SaaS subscription, provide the required details requested by the SaaS provider (like contact name, email, and phone number), and select **Activate**.
1. After you see **Success**, return to the Account Recovery setup process in the [Microsoft Entra admin center](https://entra.microsoft.com) to complete the remaining steps.
1. Return to the Identity verification provider menu within the Account Recovery setup process, and choose **Select**.
1. In **Update account recovery setup (Preview)**, select **Next**.

   :::image type="content" border="true" source="media/how-to-account-recovery-enable/update-account-recovery-setup.png" alt-text="Screenshot that shows how to update account recovery setup."lightbox="media/how-to-account-recovery-enable/update-account-recovery-setup.png":::

1. On the **Review and finalize** page, review the details for account recovery configuration, and select **Done**.

   :::image type="content" border="true" source="media/how-to-account-recovery-enable/finalize.png" alt-text="Screenshot that shows how to finalize account recovery setup."lightbox="media/how-to-account-recovery-enable/finalize.png":::

1. After setup is finalized, the Account Recovery **Home** page opens in the Microsoft Entra admin center. 

   :::image type="content" border="true" source="media/how-to-account-recovery-enable/home.png" alt-text="Screenshot that shows account recovery home page."lightbox="media/how-to-account-recovery-enable/home.png":::

Once setup is complete, any users scoped to account recovery can try recovery and complete Identity Verification. But they can't recover their accounts because recovery is set in evaluation mode. 

## Ensure user profiles are ready for account recovery

Make sure the **User Properties** are correct for all users assigned to the group that's allowed to try the recovery flow.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [User Administrator](~/identity/role-based-access-control/permissions-reference.md#user-administrator).
1. Go to **Identity** > **Users** > **All Users** and select the user you want to modify properties for.
1. Select **Edit properties**.
 
   :::image type="content" border="true" source="media/how-to-account-recovery-enable/user-properties.png" alt-text="Screenshot that shows how to check user properties."lightbox="media/how-to-account-recovery-enable/user-properties.png":::

1. Make sure the **First Name** property and the **Last Name** property are filled in. If they're blank, there's no way for Microsoft Entra ID Account Recovery to match the ID claims values returned from the Identity Verification Provider.
   Often, the real name of a user on their government ID doesn't match what's listed for their user account in Microsoft Entra ID. The display name isn't used in the account recovery process; only the **First name** and **Last name** properties are used.
   For more information about how the Verified ID issued from a provider is matched against a Microsoft Entra ID account, see [FAQ for account recovery](self-service-account-recovery.yml#how-is-the-verified-id-issued-from-a-provider-matched-against-microsoft-entra-id-account-details-). 

## How to update and fully enable Account Recovery in the Microsoft Entra admin center

After testing account recovery in evaluation mode and confirming that the identity verification process works as expected, you can enable full recovery capabilities for your users. This process involves changing the recovery mode from **Evaluation** to **Recovery** and reviewing your user scope configuration.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Authentication Administrator](~/identity/role-based-access-control/permissions-reference.md#authentication-administrator).
1. Go to **Protection** > **Account Recovery**.
1. On the Account Recovery **Home** page, select **Manage**.

   :::image type="content" border="true" source="media/how-to-account-recovery-enable/manage.png" alt-text="Screenshot that shows how to select Manage on the account recovery home page."lightbox="media/how-to-account-recovery-enable/manage.png":::

1. Under **Choose a recovery mode**, select **Production** to enable full account recovery capabilities.

   >[!NOTE]
   >In **Production** mode, users who complete identity verification can fully recover their accounts and reset their authentication methods. In **Evaluation** mode, users can only test the identity verification process without actually recovering their accounts.

1. Under **User group selection**, review the groups currently configured for account recovery:
   - To add more groups, click **Select groups**, choose the groups you want to include, and select **Save**.
   - To remove groups, select the group and click **Remove**.
   
   >[!IMPORTANT]
   >Carefully review which users are in scope for account recovery before enabling Recovery mode. Ensure that only appropriate user populations have access to this capability based on your organization's security requirements.

1. Under **Identity verification providers**, review your selected provider. If needed, you can change to a different provider that has been subscribed to in the Microsoft Security Store.
1. Select **Next** to proceed to the review page.
1. On the **Review and finalize** page, carefully review all configuration changes:
   - Verify that **Recovery mode** is set to **Production**
   - Confirm that the correct user groups are in scope
   - Verify that the appropriate identity verification provider is selected
1. After reviewing the configuration, select **Complete** to apply the changes.
1. A confirmation message says that account recovery was successful.

Once these steps are complete, users in the scoped groups can use account recovery to fully regain access to their accounts when they lose all authentication methods. They need to complete identity verification through the configured provider and receive a Temporary Access Pass to re-enroll their authentication methods.


## Related content

[How end users can perform account recovery in Microsoft Entra ID](how-to-account-recovery-for-users.md)
