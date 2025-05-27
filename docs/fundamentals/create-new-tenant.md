---
title: Quickstart - Access and create new tenant
description: Instructions about how to find Microsoft Entra ID and how to create a new tenant for your organization.
author: barclayn
manager: femila
ms.service: entra
ms.subservice: fundamentals
ms.topic: quickstart
ms.date: 03/05/2025
ms.author: barclayn
ms.custom: it-pro, fasttrack-edit, mode-other, sfi-image-nochange
ms.collection: M365-identity-device-management
---

# Quickstart: Create a new tenant in Microsoft Entra ID

You can perform all of your administrative tasks using the Microsoft Entra admin center, including creating a new tenant for your organization.

In this quickstart article, you learn how to create a basic tenant for your organization.

>[!Note]
>Only paid customers can create a new Workforce tenant in Microsoft Entra ID. Customers using a free tenant, or a trial subscription won't be able to create additional tenants from the Microsoft Entra admin center. Customers facing this scenario who need a new tenant can sign up for a [free account](https://azure.microsoft.com/free/).

## Create a new tenant for your organization


After you sign in to the [Azure portal](https://portal.azure.com), you can create a new tenant for your organization. Your new tenant represents your organization and helps you to manage a specific instance of Microsoft Cloud services for your internal and external users.

>[!NOTE]
>
> - If you're unable to create a Microsoft Entra ID or Azure AD B2C tenant, review your user settings page to ensure that tenant creation isn't switched off. If it is not enabled you must be assigned at least the [Tenant Creator](../identity/role-based-access-control/permissions-reference.md#tenant-creator) role.
> - This article doesn't cover creating an *external* tenant configuration for consumer-facing apps; learn more about using [Microsoft Entra External ID](~/external-id/customers/overview-customers-ciam.md) for your customer identity and access management (CIAM) scenarios.

[!INCLUDE [active-directory-b2c-end-of-sale-notice.md](~/includes/active-directory-b2c-end-of-sale-notice.md)]

### To create a new tenant

[!INCLUDE [Create](../includes/definitions/create-new-tenant.md)]

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

- Change or add other domain names, see [How to add a custom domain name to Microsoft Entra ID](add-custom-domain.yml).

- Add users, see [Add or delete a new user](./add-users.md)

- Add groups and members, see [Create a basic group and add members](./how-to-manage-groups.yml).

- Learn about [Azure role-based access control (RBAC)](/azure/role-based-access-control/overview) and [Conditional Access](~/identity/conditional-access/overview.md) to help manage your organization's application and resource access.

- Learn about Microsoft Entra ID, including [basic licensing information, terminology, and associated features](./whatis.md).