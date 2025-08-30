---
title: Add your custom domain
description: Instructions about how to add your custom domain name to your tenant.
author: barclayn
ms.author: barclayn
manager: pmwongera
ms.service: entra
ms.subservice: fundamentals
ms.topic: how-to
ms.date: 03/05/2025
ms.reviewer: elkuzmen
ms.custom: ge-structured-content-pilot, sfi-ga-nochange
---

# Add your custom domain name to your tenant


Microsoft Entra tenants come with an initial domain name like `domainname.onmicrosoft.com`. You can't change or delete the initial domain name, but you can add your organization's DNS name as a custom domain name and set it as primary. By adding your domain name, you can add user names that are familiar to your users, such as `alain@contoso.com`.

## Prerequisites

Before you can add a custom domain name, create your domain name with a domain registrar. For an accredited domain registrar, see [ICANN-Accredited Registrars](https://www.icann.org/registrar-reports/accredited-list.html).

## Create your directory

After you get your domain name, you can create your first directory. Sign in to the [Azure portal](https://portal.azure.com) for your directory, using an account with the [Owner](/azure/role-based-access-control/built-in-roles#owner) role for the subscription.

1. Create your new directory by following the steps in [Create a new tenant for your organization](./create-new-tenant.md#create-a-new-tenant-for-your-organization).

2. [!INCLUDE [tenant-installation-account](../includes/definitions/tenant-installation-account.md)]

> [!TIP]
> If you plan to federate on-premises Windows Server Active Directory with Microsoft Entra ID, then you need to select **I plan to configure this domain for single sign-on with my local Active Directory** when you run the Microsoft Entra Connect tool to synchronize your directories.
>
> You also need to register the same domain name you select for federating with your on-premises directory in the **Microsoft Entra Domain** step in the wizard. To see what that setup looks like, see [Verify the domain selected for federation](~/identity/hybrid/connect/how-to-connect-install-custom.md#verify-the-azure-ad-domain-selected-for-federation). If you don't have the Microsoft Entra Connect tool, you can [download it here](https://go.microsoft.com/fwlink/?LinkId=615771).

## Add your custom domain name

After you create your directory, you can add your custom domain name.

> [!IMPORTANT]
> When updating domain information, you may be unable to complete the process and encounter an HTTP 500 Internal Server Error message. Under some conditions, this error may be expected. This message may appear if you try to use a protected DNS suffix. Protected DNS suffixes may only be used by Microsoft. If you believe that this operation should have been completed successfully, contact your Microsoft representative for assistance.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Domain Name Administrator](~/identity/role-based-access-control/permissions-reference.md#domain-name-administrator).

2. Browse to **Entra ID** > **Domain names** > **Add custom domain**.

  :::image type="content" source="media/add-custom-domain/add-custom-domain.png" alt-text="Screenshot of Custom domain names page, with Add custom domain shown.":::

3. In **Custom domain name**, enter your organization's domain, in this example, *contoso.com*. Select **Add domain**.

  :::image type="content" source="media/add-custom-domain/add-custom-domain-blade.png" alt-text="Screenshot of Custom domain names page, with Add custom domain page.":::

> [!IMPORTANT]
> You must include *.com*, *.net*, or any other top-level extension for this to work. When adding a custom domain, the Password Policy values will be inherited from the initial domain.

4. The unverified domain is added. The **contoso.com** page appears showing the DNS information needed to validate your domain ownership. Save this information.

  :::image type="content" source="media/add-custom-domain/contoso-blade-with-dns-info.png" alt-text="Screenshot of Contoso page with DNS entry information.":::

## Add your DNS information to the domain registrar

Follow these steps:

1. After you add your custom domain name, you must return to your domain registrar and add the DNS information from your copied from the previous step. Creating this TXT or MX record for your domain verifies ownership of your domain name.

2. Go back to your domain registrar and create a new TXT or MX record for your domain based on your copied DNS information. Set the time to live (TTL) to 3600 seconds (60 minutes), and then save the record.

> [!IMPORTANT]
> You can register as many domain names as you want. However, each domain gets its own TXT or MX record. Be careful when you enter the information at the domain registrar. If you enter the wrong or duplicate information by mistake, you'll have to wait until the TTL times out (60 minutes) before you can try again.

## Verify your custom domain name

After you register your custom domain name, make sure it's valid in Microsoft Entra. The propagation time can be instantaneous or it can take a few days, depending on your domain registrar.

To verify your custom domain name, follow these steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Domain Name Administrator](~/identity/role-based-access-control/permissions-reference.md#domain-name-administrator).

2. Browse to **Entra ID** > **Domain names**.

3. In **Custom domain names**, select the custom domain name. In this example, select **contoso.com**.

  :::image type="content" source="media/add-custom-domain/custom-blade-with-contoso-highlighted.png" alt-text="Screenshot of Fabrikam - Custom domain names page, with Contoso highlighted.":::

4. On the **contoso.com** page, select **Verify** to make sure your custom domain is properly registered and is valid.

  :::image type="content" source="media/add-custom-domain/contoso-blade-with-dns-info-verify.png" alt-text="Screenshot of Contoso page with DNS entry information and the Verify button.":::

## Common verification issues

If you can't verify a custom domain name, try the following suggestions:

1. **Wait at least an hour and try again.** DNS records must propagate before you can verify the domain. This process can take an hour or more.

2. **Make sure the DNS record is correct.** Go back to the domain name registrar site. Make sure the entry is there, and that it matches the DNS entry information provided in the Microsoft Entra admin center.

  - If you can't update the record on the registrar site, share the entry with someone who has permissions to add the entry and verify it's correct.

3. **Make sure the domain name isn't already in use in another directory.** A domain name can only be verified in one directory. If your domain name is currently verified in another directory, it can't also be verified in the new directory. To fix this duplication problem, you must delete the domain name from the old directory. For more information about deleting domain names, see [Manage custom domain names](~/identity/users/domains-manage.md).

4. **Make sure you don't have any unmanaged Power BI tenants.** If your users have activated Power BI through self-service sign-up and created an unmanaged tenant for your organization, you must take over management as an internal or external admin, using PowerShell. For more information, see [Take over an unmanaged directory](~/identity/users/domains-admin-takeover.md).

## Related content

- [How to assign roles and administrators](./how-subscriptions-associated-directory.md)
- [How to add or delete users](./add-users.md)
- [Managing custom domain names](~/identity/users/domains-manage.md)
