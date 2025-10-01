---
author: barclayn
ms.service: entra-id
ms.topic: include
ms.date: 01/31/2025
ms.author: barclayn
ms.custom: include file, sfi-ga-nochange
---

1. Sign in to the [Azure portal](https://portal.azure.com).

1. From the Azure portal menu, select **Microsoft Entra ID**.

1. Navigate to **Entra ID** > **Overview** > **Manage tenants**.

1. Select **Create**.

   :::image type="content" source="/media/create-new-tenant/portal.png" alt-text="Screenshot of Microsoft Entra ID - Overview page - Create a tenant.":::

1. On the Basics tab, select the type of tenant you want to create, either **Microsoft Entra ID** or **Microsoft Entra ID (B2C)**.

1. Select **Next: Configuration** to move to the Configuration tab.

1. On the Configuration tab, enter the following information:

   :::image type="content" source="/media/create-new-tenant/create-new-tenant.png" alt-text="Screenshot of Microsoft Entra ID - Create a tenant page - configuration tab.":::

   - Type your desired Organization name (for example *Contoso Organization*) into the **Organization name** box.
   - Type your desired Initial domain name (for example *Contosoorg*) into the **Initial domain name** box.
   - Select your desired Country/Region or leave the *United States* option in the **Country or region** box.

1. Select **Next: Review + Create**. Review the information you entered and if the information is correct, select **Create** in the lower left corner.

Your new tenant is created with the domain contoso.onmicrosoft.com.

## Your user account in the new tenant

[!INCLUDE [tenant-installation-account](definitions/tenant-installation-account.md)]

Check out your user account by navigating to the [**Users**](https://portal.azure.com/#blade/Microsoft_AAD_IAM/UsersManagementMenuBlade/MsGraphUsers) page.

By default, you're also listed as the [technical contact](/microsoft-365/admin/manage/change-address-contact-and-more#what-do-these-fields-mean) for the tenant. Technical contact information is something you can change in [**Properties**](https://portal.azure.com/#blade/Microsoft_AAD_IAM/ActiveDirectoryMenuBlade/Properties).

[!INCLUDE [emergency-access-accounts](definitions/emergency-access-accounts.md)]