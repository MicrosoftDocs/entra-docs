---
title: Custom role permissions for app registration
description: Delegate custom administrator role permissions for managing app registrations.
author: barclayn
manager: pmwongera
ms.service: entra-id
ms.subservice: role-based-access-control
ms.topic: how-to
ms.date: 03/30/2025
ms.author: barclayn
ms.reviewer: vincesm
ms.custom: it-pro, has-azure-ad-ps-ref, azure-ad-ref-level-one-done, sfi-image-nochange
---

# Application registration permissions for custom roles in Microsoft Entra ID

This article outlines the app registration permissions available for custom role definitions in Microsoft Entra ID. These permissions allow administrators to manage application registrations with specific access levels, ensuring secure and efficient management of applications within the organization.

## License requirements

[!INCLUDE [License requirement for using custom roles in Azure AD](~/includes/entra-p1-license.md)]

## Permissions for managing single-tenant applications

When choosing the permissions for your custom role, you can grant access to manage only single-tenant applications. Single-tenant applications are available only to users in the Microsoft Entra organization where the application is registered. 

Single-tenant applications are defined as having **Supported account types** set to "Accounts in this organizational directory only." In the Graph API, single-tenant applications have the signInAudience property set to "AzureADMyOrg."

To grant access to manage only single-tenant applications, use the permissions indicated as follows with the subtype **applications.myOrganization**. For example, microsoft.directory/applications.myOrganization/basic/update.

See the [custom roles overview](custom-overview.md) for an explanation of the terms subtype, permission, and property set. The following information is specific to application registrations.

## Create and delete

There are two permissions available for granting the ability to create application registrations, each with different behavior:

#### microsoft.directory/applications/createAsOwner

Assigning this permission results in the creator being added as the first owner of the created app registration. The created app registration counts towards the creator's 250 created objects quota.

#### microsoft.directory/applications/create

Granting this permission prevents the creator from being added as the first owner of the app registration and excludes the app registration from the creator's 250-object quota. Use this permission carefully as there's nothing preventing the assignee from creating app registrations until the directory-level quota is reached.

If both permissions are assigned, the /create permission takes precedence. Though the /createAsOwner permission doesn't automatically add the creator as the first owner, owners can be specified during the creation of the app registration when using Graph APIs or PowerShell cmdlets.

Create permissions grant access to the **New registration** command.

:::image type="content" source="./media/custom-available-permissions/new-custom-role.png" alt-text="Screenshot of permissions to grant access to the New Registration portal command." lightbox="./media/custom-available-permissions/new-custom-role.png":::

There are two permissions available for granting the ability to delete app registrations:

#### microsoft.directory/applications/delete

Grants the ability to delete app registrations regardless of subtype including both single-tenant and multitenant applications.

#### microsoft.directory/applications.myOrganization/delete

Grants the ability to delete app registrations restricted to those that are accessible only to accounts in your organization or single-tenant applications (myOrganization subtype).

:::image type="content" source="./media/custom-available-permissions/delete-app-registration.png" alt-text="Screenshot of permissions to grant access to the Delete app registration command." lightbox="./media/custom-available-permissions/delete-app-registration.png":::

> [!NOTE]
> When assigning a role that contains create permissions, the role assignment must be made at the directory scope. A create permission assigned at a resource scope doesn't grant the ability to create app registrations.

## Read

All member users in the organization can read app registration information by default. However, guest users and application service principals can't. If you plan to assign a role to a guest user or application, you must include the appropriate read permissions.

#### microsoft.directory/applications/allProperties/read

Grants the ability to read all properties of single-tenant and multitenant applications outside of properties that can't be read in any situation like credentials.

#### microsoft.directory/applications.myOrganization/allProperties/read

Grants the same permissions as microsoft.directory/applications/allProperties/read, but only for single-tenant applications.

#### microsoft.directory/applications/owners/read

Grants the ability to read owners property on single-tenant and multitenant applications. Grants access to all fields on the application registration owners page:

:::image type="content" source="./media/custom-available-permissions/app-registration-owners.png" alt-text="Screenshot of permissions to grant access to the app registration owners page." lightbox="./media/custom-available-permissions/app-registration-owners.png":::

#### microsoft.directory/applications/standard/read

Grants access to read standard application registration properties. This includes properties across application registration pages.

#### microsoft.directory/applications.myOrganization/standard/read

Grants the same permissions as microsoft.directory/applications/standard/read, but for only single-tenant applications.

## Update

The "Update" permissions in Microsoft Entra ID allow administrators to modify various properties of application registrations. These permissions are essential for maintaining and managing both single-tenant and multitenant applications. Depending on the specific permission granted, administrators can update properties such as supported account types, authentication settings, branding details, and more. The following is a detailed list of the available update permissions and their specific capabilities.

#### microsoft.directory/applications/allProperties/update

Allows the ability to update all properties on single-tenant and multitenant applications.

#### microsoft.directory/applications.myOrganization/allProperties/update

Grants the same permissions as microsoft.directory/applications/allProperties/update, but only for single-tenant applications.

#### microsoft.directory/applications/audience/update

Allows the ability to update the supported account type (signInAudience) property on single-tenant and multitenant applications.

:::image type="content" source="./media/custom-available-permissions/supported-account-types.png" alt-text="Screenshot of permission to grant access to app registration supported account type property on authentication page." lightbox="./media/custom-available-permissions/supported-account-types.png":::

#### microsoft.directory/applications.myOrganization/audience/update

Grants the same permissions as microsoft.directory/applications/audience/update, but only for single-tenant applications.

#### microsoft.directory/applications/authentication/update

Allows the ability to update the reply URL, sign-out URL, implicit flow, and publisher domain properties on single-tenant and multitenant applications. Grants access to all fields on the application registration authentication page except supported account types:

:::image type="content" source="./media/custom-available-permissions/supported-account-types.png" alt-text="Screenshot of permissions to grant access to app registration authentication, but not supported account types." lightbox="./media/custom-available-permissions/supported-account-types.png":::

#### microsoft.directory/applications.myOrganization/authentication/update

Grants the same permissions as microsoft.directory/applications/authentication/update, but only for single-tenant applications.

#### microsoft.directory/applications/basic/update

Allows the ability to update the name, logo, homepage URL, terms of service URL, and privacy statement URL properties on single-tenant and multitenant applications. Grants access to all fields on the application registration branding page:

:::image type="content" source="./media/custom-available-permissions/app-registration-branding.png" alt-text="Screenshot of permission to grant access to the app registration branding page." lightbox="./media/custom-available-permissions/app-registration-branding.png":::

#### microsoft.directory/applications.myOrganization/basic/update

Grants the same permissions as microsoft.directory/applications/basic/update, but only for single-tenant applications.

#### microsoft.directory/applications/credentials/update

Allows the ability to update the certificates and client secrets properties on single-tenant and multitenant applications. Grants access to all fields on the application registration certificates & secrets page:

:::image type="content" source="./media/custom-available-permissions/app-registration-secrets.png" alt-text="Screenshot of permission to grant access to the app registration certificates & secrets page." lightbox="./media/custom-available-permissions/app-registration-secrets.png":::

#### microsoft.directory/applications.myOrganization/credentials/update

Grants the same permissions as microsoft.directory/applications/credentials/update, but only for single-tenant applications.

#### microsoft.directory/applications/owners/update

Allows the ability to update the owner property on single-tenant and multitenant. Grants access to all fields on the application registration owners page:

:::image type="content" source="./media/custom-available-permissions/app-registration-owners.png" alt-text="Screenshot of permissions to grant access to the app registration owners page." lightbox="./media/custom-available-permissions/app-registration-owners.png":::

#### microsoft.directory/applications.myOrganization/owners/update

Grants the same permissions as microsoft.directory/applications/owners/update, but only for single-tenant applications.

#### microsoft.directory/applications/permissions/update

This permission allows updates to various properties on single-tenant and multitenant applications, including delegated permissions, application permissions, authorized client applications, required permissions, and consent properties. It doesn't grant the ability to perform consent. Grants access to all fields on the application registration API permissions and Expose an API pages:

:::image type="content" source="./media/custom-available-permissions/app-registration-api-permissions.png" alt-text="Screenshot of permissions to grant access to the app registration API permissions page." lightbox="./media/custom-available-permissions/app-registration-api-permissions.png":::

:::image type="content" source="./media/custom-available-permissions/app-registration-expose-api.png" alt-text="Screenshot of permissions to grant access to the app registration Expose an API page." lightbox="./media/custom-available-permissions/app-registration-expose-api.png":::

#### microsoft.directory/applications.myOrganization/permissions/update

Grants the same permissions as microsoft.directory/applications/permissions/update, but only for single-tenant applications.

## Next steps

- [Create a custom role in Microsoft Entra ID](custom-create.md)
- [List role assignments](view-assignments.md)