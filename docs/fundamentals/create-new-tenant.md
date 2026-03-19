---
title: Quickstart - Access and create new tenant
description: Instructions about how to find Microsoft Entra ID and how to create a new tenant for your organization.
manager: pmwongera
ms.topic: quickstart
ms.date: 03/12/2026
ms.custom: it-pro, fasttrack-edit, mode-other, sfi-image-nochange
ms.collection: M365-identity-device-management
---

# Quickstart: Create a new tenant in Microsoft Entra ID

You can perform all of your administrative tasks using the Microsoft Entra admin center, including creating a new tenant for your organization.

In this quickstart article, you learn how to create a basic tenant for your organization.

>[!Note]
>Only paid customers can create a new Workforce tenant in Microsoft Entra ID. Customers using a free tenant, or a trial subscription won't be able to create additional tenants from the Microsoft Entra admin center. Customers facing this scenario who need a new tenant can sign up for a [free account](https://azure.microsoft.com/pricing/purchase-options/azure-account?cid=msft_learn).

## Create a new tenant for your organization


After you sign in to the [Azure portal](https://portal.azure.com), you can create a new tenant for your organization. Your new tenant represents your organization and helps you to manage a specific instance of Microsoft Cloud services for your internal and external users.

>[!NOTE]
>
> - If you're unable to create a Microsoft Entra ID or Azure AD B2C tenant, review your user settings page to ensure that tenant creation isn't switched off. If it is not enabled you must be assigned at least the [Tenant Creator](../identity/role-based-access-control/permissions-reference.md#tenant-creator) role.
> - This article doesn't cover creating an *external* tenant configuration for consumer-facing apps; learn more about using [Microsoft Entra External ID](~/external-id/customers/overview-customers-ciam.md) for your customer identity and access management (CIAM) scenarios.
> - If you're unable to create a Governed Workforce tenant, verify your billing account permissions. You must have at least Tenant Contributor permissions on at least one Microsoft Customer Agreement (MCA) subscription. Enterprise Agreement (EA) subscriptions aren't currently supported for this scenario.

### To create a new tenant

# [Workforce / B2C](#tab/workforce)

[!INCLUDE [Create](../includes/definitions/create-new-tenant.md)]

# [Secure add-on tenant creation (preview)](#tab/governed-workforce)

> [!IMPORTANT]
> This information relates to a prerelease product that might be substantially modified before release. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

Use the secure add-on tenant creation flow to create a new Governed Workforce tenant. This process creates the tenant and automatically establishes a [governance relationship](~/id-governance/tenant-governance/governance-relationships.md) with your home tenant.

### Define the default governance policy template

In order to automatically establish governance relationships with add-on tenants, you first need to define the default governance policy template.

1. Sign in to the governing tenant as an administrator.

1. Navigate to Templates.

1. Select the default policy template and configure the following options as needed:

   - **Delegated administration**: Select one or more Microsoft Entra built-in roles and assign them to a role assignable security group in the governing tenant. Members of this group can use their governing tenant credentials to sign in to the governed tenant without needing an account in the governed tenant. Each group can have multiple role assignments, and each policy template can have multiple groups defined.

   - **Multitenant application management**: Select a custom, multitenant application. The governed tenant creates a service principal with the same permissions when you establish the relationship.

### Create the tenant

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).

1. Browse to **Entra ID** > **Overview** > **Manage tenants**.

1. Select **Create**.

1. On the Basics tab, select **Governed Workforce** to access the secure add-on tenant creation feature.

1. Select **Next: Configuration** to move to the Configuration tab.

1. On the Configuration tab, enter the following information:

   - Type your desired Organization name (for example *Contoso Organization*) into the **Organization name** box.
   - Type your desired Initial domain name (for example *Contosoorg*) into the **Initial domain name** box.
   - Select your desired Country/Region or leave the *United States* option in the **Country or region** box.
   - Select your desired cloud subscription and resource group for storing the Microsoft Entra ID Free billing asset for your new tenant.

   > [!NOTE]
   > The subscription must be a Microsoft Customer Agreement (MCA) subscription. Other subscription types aren't currently supported.

1. Select **Next: Review + Create**. Review the information you entered and if the information is correct, select **Create** in the lower left corner.

Your new tenant is created with the domain contoso.onmicrosoft.com. If you defined a governance policy template, a tenant governance relationship is automatically formed between your home tenant and your newly created tenant. Your billing account now shows a Microsoft Entra ID Free billing asset linked to your newly created tenant under the selected subscription and resource group.

To learn more about governance relationships and policy templates, see [Governance relationships](~/id-governance/tenant-governance/governance-relationships.md) and [Governance policy templates](~/id-governance/tenant-governance/governance-policy-templates.md).

---

## Your user account in the new tenant

[!INCLUDE [Create](../includes/definitions/tenant-installation-account.md)]

By default, you're also listed as the [technical contact](/microsoft-365/admin/manage/change-address-contact-and-more#what-do-these-fields-mean) for the tenant. Technical contact information is something you can change in [**Properties**](https://portal.azure.com/#blade/Microsoft_AAD_IAM/ActiveDirectoryMenuBlade/Properties).

[!INCLUDE [emergency-access-accounts](../includes/definitions/emergency-access-accounts.md)]

## Clean up resources

If you're not going to continue to use this application, you can delete the tenant using the following steps:

- Ensure that you're signed in to the directory that you want to delete through the **Directory + subscription** filter in the Azure portal. Switch to the target directory if needed.
- Select **Microsoft Entra ID**, and then on the **Contoso - Overview** page, select **Delete directory**.

    The tenant and its associated information are deleted.

   :::image type="content" source="media/create-new-tenant/delete-new-tenant.png" alt-text="Screenshot of Overview page, with highlighted Delete directory button.":::

## Next steps

- Change or add other domain names, see [How to add a custom domain name to Microsoft Entra ID](add-custom-domain.md).

- Add users, see [Add or delete a new user](./add-users.md)

- Add groups and members, see [Create a basic group and add members](./how-to-manage-groups.yml).

- Learn about [Azure role-based access control (RBAC)](/azure/role-based-access-control/overview) and [Conditional Access](~/identity/conditional-access/overview.md) to help manage your organization's application and resource access.

- Learn about Microsoft Entra ID, including [basic licensing information, terminology, and associated features](./whatis.md).