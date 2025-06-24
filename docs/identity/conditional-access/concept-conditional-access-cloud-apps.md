---
title: Cloud apps, actions, and authentication context in Conditional Access policy
description: What are cloud apps, actions, and authentication context in a Microsoft Entra Conditional Access policy

ms.service: entra-id
ms.subservice: conditional-access
ms.custom: has-azure-ad-ps-ref
ms.topic: conceptual

ms.date: 06/24/2025

ms.author: joflore
author: MicrosoftGuyJFlo
manager: femila
ms.reviewer: lhuangnorth
---
# Conditional Access: Target resources

Target resources (formerly Cloud apps, actions, and authentication context) are key signals in a Conditional Access policy. Conditional Access policies allow administrators to assign controls to specific applications, services, actions, or authentication context.

- Administrators can choose from the list of applications or services that include built-in Microsoft applications and any [Microsoft Entra integrated applications](~/identity/enterprise-apps/what-is-application-management.md) including gallery, non-gallery, and applications published through [Application Proxy](~/identity/app-proxy/overview-what-is-app-proxy.md).
- Administrators might choose to define policy not based on a cloud application but on a [user action](#user-actions) like **Register security information** or **Register or join devices**, allowing Conditional Access to enforce controls around those actions.
- Administrators can target [traffic forwarding profiles](#traffic-forwarding-profiles) from Global Secure Access for enhanced functionality.
- Administrators can use [authentication context](#authentication-context) to provide an extra layer of security in applications.

:::image type="content" source="media/concept-conditional-access-cloud-apps/conditional-access-cloud-apps-or-actions.png" alt-text="Screenshot displaying a Conditional Access policy and the target resources panel." lightbox="media/concept-conditional-access-cloud-apps/conditional-access-cloud-apps-or-actions.png":::

## Microsoft cloud applications

Administrators can assign a Conditional Access policy to cloud apps from Microsoft as long as the service principal appears in their tenant, except for Microsoft Graph. Microsoft Graph functions as an umbrella resource. Use [Audience Reporting](troubleshoot-conditional-access.md#audience-reporting) to see the underlying services and target those services in your policies. Some apps like [Office 365](#office-365) and [Windows Azure Service Management API](#windows-azure-service-management-api) include multiple related child apps or services. When new Microsoft cloud applications are created, they appear in the app picker list as soon as the service principal for that is created in the tenant. 

### Office 365

Microsoft 365 provides cloud-based productivity and collaboration services like Exchange, SharePoint, and Microsoft Teams. Microsoft 365 cloud services are deeply integrated to ensure smooth and collaborative experiences. This integration can cause confusion when creating policies as some apps such as Microsoft Teams have dependencies on others such as SharePoint or Exchange.

The Office 365 suite makes it possible to target these services all at once. We recommend using the new Office 365 suite, instead of targeting individual cloud apps to avoid issues with [service dependencies](service-dependencies.md).

Targeting this group of applications helps to avoid issues that might arise because of inconsistent policies and dependencies. For example: The Exchange Online app is tied to traditional Exchange Online data like mail, calendar, and contact information. Related metadata might be exposed through different resources like search. To ensure that all metadata is protected by as intended, administrators should assign policies to the Office 365 app.

Administrators can exclude the entire Office 365 suite or specific Office 365 cloud apps from the Conditional Access policy.

A complete list of all services included can be found in the article [Apps included in Conditional Access Office 365 app suite](reference-office-365-application-contents.md).

### Windows Azure Service Management API

When you target the Windows Azure Service Management API application, policy is enforced for tokens issued to a set of services closely bound to the portal. This grouping includes the application IDs of:

- Azure Resource Manager
- Azure portal, which also covers the Microsoft Entra admin center
- Azure Data Lake
- Application Insights API
- Log Analytics API

Because the policy is applied to the Azure management portal and API, any services or clients that depend on the Azure API can be indirectly affected. For example:

- Azure CLI
- Azure Data Factory portal
- Azure DevOps
- Azure Event Hubs
- Azure PowerShell
- Azure Service Bus
- Azure SQL Database
- Azure Synapse
- Classic deployment model APIs
- Microsoft 365 admin center
- Microsoft IoT Central
- SQL Managed Instance
- Visual Studio subscriptions administrator portal

> [!NOTE]
> The Windows Azure Service Management API application applies to [Azure PowerShell](/powershell/azure/what-is-azure-powershell), which calls the [Azure Resource Manager API](/azure/azure-resource-manager/management/overview). It doesn't apply to [Microsoft Graph PowerShell](/powershell/microsoftgraph/overview), which calls the [Microsoft Graph API](/graph/overview).

For more information on how to set up a sample policy for Windows Azure Service Management API, see [Conditional Access: Require MFA for Azure management](policy-old-require-mfa-azure-mgmt.md).

> [!TIP]
> For Azure Government, you should target the Azure Government Cloud Management API application.

### Microsoft Admin Portals

When a Conditional Access policy targets the Microsoft Admin Portals cloud app, the policy is enforced for tokens issued to application IDs of the following Microsoft administrative portals:

- Azure portal
- Exchange admin center
- Microsoft 365 admin center
- Microsoft 365 Defender portal
- Microsoft Entra admin center
- Microsoft Intune admin center
- Microsoft Purview compliance portal
- Microsoft Teams admin center

We're continually adding more administrative portals to the list.

> [!NOTE]
> The Microsoft Admin Portals app applies to interactive sign-ins to the listed admin portals only. Sign-ins to the underlying resources or services like Microsoft Graph or Azure Resource Manager APIs aren't covered by this application. Those resources are protected by the [Windows Azure Service Management API](#windows-azure-service-management-api) app. This grouping enables customers to move along the MFA adoption journey for admins without impacting automation that relies on APIs and PowerShell. When you're ready, Microsoft recommends using a [policy requiring administrators perform MFA always](policy-old-require-mfa-admin.md) for comprehensive protection.

### Other applications

Administrators can add any Microsoft Entra registered application to Conditional Access policies. These applications might include:

- Applications published through [Microsoft Entra application proxy](~/identity/app-proxy/overview-what-is-app-proxy.md)
- [Applications added from the gallery](~/identity/enterprise-apps/add-application-portal.md)
- [Custom applications not in the gallery](~/identity/enterprise-apps/view-applications-portal.md)
- [Legacy applications published through app delivery controllers and networks](~/identity/enterprise-apps/secure-hybrid-access.md)
- Applications that use [password based single sign-on](~/identity/enterprise-apps/configure-password-single-sign-on-non-gallery-applications.md)

> [!NOTE]
> Since Conditional Access policy sets the requirements for accessing a service, you aren't able to apply it to a client (public/native) application. In other words, the policy isn't set directly on a client (public/native) application, but is applied when a client calls a service. For example, a policy set on SharePoint service applies to all clients calling SharePoint. A policy set on Exchange applies to the attempt to access the email using Outlook client. That is why client (public/native) applications aren't available for selection in the app picker and Conditional Access option isn't available in the application settings for the client (public/native) application registered in your tenant.

Some applications don't appear in the picker at all. The only way to include these applications in a Conditional Access policy is to include **All resources (formerly 'All cloud apps')** or add the missing service principal using the [New-MgServicePrincipal](/powershell/module/microsoft.graph.applications/new-mgserviceprincipal) PowerShell cmdlet.

#### Understanding Conditional Access for different client types

Conditional Access applies to resources not clients, except when the client is a confidential client requesting an ID token.

- Public client
   - Public clients are those that run locally on devices like Microsoft Outlook on the desktop or mobile apps like Microsoft Teams. 
   - Conditional Access policies don't apply to the public client itself, but apply based on the resources requested by the public clients.
- Confidential client
   - Conditional Access applies to the resources requested by the client and the confidential client itself if it requests an ID token.
   - For example: If Outlook Web requests a token for scopes `Mail.Read` and `Files.Read`, Conditional Access applies policies for Exchange and SharePoint. Additionally, if Outlook Web requests an ID token, Conditional Access also applies the policies for Outlook Web.

To view [sign-in logs](/entra/identity/monitoring-health/concept-sign-ins) for these client types from the Microsoft Entra admin center:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Reports Reader](../role-based-access-control/permissions-reference.md#reports-reader).
1. Browse to **Entra ID** > **Monitoring & health** > **Sign-in logs**. 
1. Add a filter for **Client credential type**.
1. Adjust the filter to view a specific set of logs based on the client credential used in the sign-in.

For more information see the article [Public client and confidential client applications](/entra/identity-platform/msal-client-applications).

<a name='all-cloud-apps'></a>

### All resources

Applying a Conditional Access policy to **All resources (formerly 'All cloud apps')** without any app exclusions results in the policy being enforced for all token requests from web sites and services including [Global Secure Access traffic forwarding profiles](/entra/global-secure-access/concept-traffic-forwarding). This option includes applications that aren't individually targetable in Conditional Access policy, such as `Windows Azure Active Directory` (00000002-0000-0000-c000-000000000000).

> [!IMPORTANT]
> Microsoft recommends creating a baseline multifactor authentication policy targeting all users and all resources (without any app exclusions), like the one explained in [Require multifactor authentication for all users](policy-all-users-mfa-strength.md).

#### Conditional Access behavior when an all resources policy has an app exclusion

If any app is excluded from the policy, in order to not inadvertently block user access, certain low privilege scopes are excluded from policy enforcement. These scopes allow calls to the underlying Graph APIs, like `Windows Azure Active Directory` (00000002-0000-0000-c000-000000000000) and `Microsoft Graph` (00000003-0000-0000-c000-000000000000), to access user profile and group membership information commonly used by applications as part of authentication. For example: when Outlook requests a token for Exchange, it also asks for the `User.Read` scope to be able to display the basic account information of the current user.

Most apps have a similar dependency, which is why these low privilege scopes are automatically excluded whenever there's an app exclusion in an **All resources** policy. These low privilege scope exclusions don't allow data access beyond basic user profile and group information. The excluded scopes are listed as follows, consent is still required for apps to use these permissions.

- Native clients and Single page applications (SPAs) have access to the following low privilege scopes:  
   - Azure AD Graph: `email`, `offline_access`, `openid`, `profile`, `User.Read`
   - Microsoft Graph: `email`, `offline_access`, `openid`, `profile`, `User.Read`, `People.Read`
- Confidential clients have access to the following low privilege scopes, if they're excluded from an **All resources** policy:         
   - Azure AD Graph: `email`, `offline_access`, `openid`, `profile`, `User.Read`, `User.Read.All`,`User.ReadBasic.All`
   - Microsoft Graph: `email`, `offline_access`, `openid`, `profile`, `User.Read`, `User.Read.All`, `User.ReadBasic.All`, `People.Read`, `People.Read.All`, `GroupMember.Read.All`, `Member.Read.Hidden`

For more information on the scopes mentioned, see [Microsoft Graph permissions reference](/graph/permissions-reference#peopleread) and [Scopes and permissions in the Microsoft identity platform](/entra/identity-platform/scopes-oidc#openid-connect-scopes).

#### Protecting directory information

If the [recommended baseline MFA policy without app exclusions](policy-all-users-mfa-strength.md) can't be configured due to business reasons, and your organization’s security policy must include directory-related low privilege scopes (`User.Read`, `User.Read.All`, `User.ReadBasic.All`, `People.Read`, `People.Read.All`, `GroupMember.Read.All`, `Member.Read.Hidden`), the alternative is to create a separate Conditional Access policy targeting `Windows Azure Active Directory` (00000002-0000-0000-c000-000000000000). Windows Azure Active Directory (also called Azure AD Graph) is a resource representing data stored in the directory such as users, groups, and applications. The Windows Azure Active Directory resource is included in **All resources** but can be individually targeted in Conditional Access policies by using the following steps:
 
1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as an [Attribute Definition Administrator](/entra/identity/role-based-access-control/permissions-reference#attribute-definition-administrator) and [Attribute Assignment Administrator](/entra/identity/role-based-access-control/permissions-reference#attribute-assignment-administrator).
1. Browse to **Entra ID** > **Custom security attributes**.
1. Create a new attribute set and attribute definition. For more information, see [Add or deactivate custom security attribute definitions in Microsoft Entra ID](../../fundamentals/custom-security-attributes-add.md).
1. Browse to **Entra ID** > **Enterprise apps**.
1. Remove the **Application type** filter and search for **Application ID** that starts with 00000002-0000-0000-c000-000000000000. 
1. Select **Windows Azure Active Directory** > **Custom security attributes** > **Add assignment**.
1. Select the attribute set and attribute value that you plan to use in the policy.
1. Browse to **Entra ID** > **Conditional Access** > **Policies**.
1. Create or modify an existing policy.
1. Under **Target resources** > **Resources (formerly cloud apps)** > **Include**, select > **Select resources** > **Edit filter**.  
1. Adjust the filter to include your attribute set and definition from earlier.
1. Save the policy 

<a name='traffic-forwarding-profiles'></a>

#### All internet resources with Global Secure Access

The **All internet resources with Global Secure Access** option allows administrators to target the [internet access traffic forwarding profile](/entra/global-secure-access/concept-traffic-forwarding) from [Microsoft Entra Internet Access](/entra/global-secure-access/overview-what-is-global-secure-access#microsoft-entra-internet-access).

These profiles in Global Secure Access enable administrators to define and control how traffic is routed through Microsoft Entra Internet Access and Microsoft Entra Private Access. Traffic forwarding profiles can be assigned to devices and remote networks. For an example of how to apply a Conditional Access policy to these traffic profiles, see the article [How to apply Conditional Access policies to the Microsoft 365 traffic profile](/entra/global-secure-access/how-to-target-resource-microsoft-365-profile).

For more information about these profiles, see the article [Global Secure Access traffic forwarding profiles](/entra/global-secure-access/concept-traffic-forwarding).

## User actions

User actions are tasks that a user performs. Currently, Conditional Access supports two user actions:

- **Register security information**: This user action allows Conditional Access policy to enforce when users who are enabled for combined registration attempt to register their security information. More information can be found in the article, [Combined security information registration](~/identity/authentication/concept-registration-mfa-sspr-combined.md).

> [!NOTE]
> When administrators apply a policy targeting user actions for register security information, if the user account is a guest from [Microsoft personal account (MSA)](~/external-id/microsoft-account.md), using the control 'Require multifactor authentication', will require the MSA user to register security information with the organization. If the guest user is from another provider such as [Google](~/external-id/google-federation.md), access is blocked.

- **Register or join devices**: This user action enables administrators to enforce Conditional Access policy when users [register](~/identity/devices/concept-device-registration.md) or [join](~/identity/devices/concept-directory-join.md) devices to Microsoft Entra ID. It provides granularity in configuring multifactor authentication for registering or joining devices instead of a tenant-wide policy that currently exists. There are three key considerations with this user action:
   - `Require multifactor authentication` is the only access control available with this user action and all others are disabled. This restriction prevents conflicts with access controls that are either dependent on Microsoft Entra device registration or not applicable to Microsoft Entra device registration. 
   - `Client apps`, `Filters for devices`, and `Device state` conditions aren't available with this user action since they're dependent on Microsoft Entra device registration to enforce Conditional Access policies.

> [!WARNING]
> When a Conditional Access policy is configured with the **Register or join devices** user action, you must set **Entra ID** > **Devices** > **Overview** > **Device Settings** - `Require Multifactor Authentication to register or join devices with Microsoft Entra` to **No**. Otherwise, Conditional Access policies with this user action aren't properly enforced. More information about this device setting can found in [Configure device settings](~/identity/devices/manage-device-identities.md#configure-device-settings).

## Authentication context

Authentication context can be used to further secure data and actions in applications. These applications can be your own custom applications, custom line of business (LOB) applications, applications like SharePoint, or applications protected by Microsoft Defender for Cloud Apps.

For example, an organization might keep files in SharePoint sites like the lunch menu or their secret BBQ sauce recipe. Everyone might have access to the lunch menu site, but users who have access to the secret BBQ sauce recipe site might need to access from a managed device and agree to specific terms of use.

Authentication context works with users or [workload identities](workload-identity.md), but not in the same Conditional Access policy.

### Configure authentication contexts

Authentication contexts are managed under **Entra ID** > **Conditional Access** > **Authentication context**.

:::image type="content" source="media/concept-conditional-access-cloud-apps/conditional-access-authentication-context-get-started.png" alt-text="Screenshot showing the management of authentication contexts." lightbox="media/concept-conditional-access-cloud-apps/conditional-access-authentication-context-get-started.png":::

Create new authentication context definitions by selecting **New authentication context**. Organizations are limited to a total of 99 authentication context definitions **c1-c99**. Configure the following attributes:

- **Display name** is the name that is used to identify the authentication context in Microsoft Entra ID and across applications that consume authentication contexts. We recommend names that can be used across resources, like *trusted devices*, to reduce the number of authentication contexts needed. Having a reduced set limits the number of redirects and provides a better end to end-user experience.
- **Description** provides more information about the policies. This information is used by administrators and those applying authentication contexts to resources.
- **Publish to apps** checkbox when checked, advertises the authentication context to apps and makes them available to be assigned. If not checked the authentication context is unavailable to downstream resources.
- **ID** is read-only and used in tokens and apps for request-specific authentication context definitions. Listed here for troubleshooting and development use cases.

#### Add to Conditional Access policy

Administrators can select published authentication contexts in their Conditional Access policies under **Assignments** > **Cloud apps or actions** and selecting **Authentication context** from the **Select what this policy applies to** menu.

:::image type="content" source="media/concept-conditional-access-cloud-apps/conditional-access-authentication-context-in-policy.png" alt-text="Screenshot showing how to add a Conditional Access authentication context to a policy":::

#### Delete an authentication context

When you delete an authentication context, make sure no applications are still using it. Otherwise access to app data is no longer protected. You can confirm this prerequisite by checking sign-in logs for cases when the authentication context Conditional Access policies are being applied.

To delete an authentication context, it must have no assigned Conditional Access policies and must not be published to apps. This requirement helps prevent the accidental deletion of an authentication context that is still in use.

### Tag resources with authentication contexts

For more information about authentication context use in applications, see the following articles.

- [Use sensitivity labels to protect content in Microsoft Teams, Microsoft 365 groups, and SharePoint sites](/purview/sensitivity-labels-teams-groups-sites)
- [Microsoft Defender for Cloud Apps](/defender-cloud-apps/session-policy-aad?branch=pr-en-us-2082#require-step-up-authentication-authentication-context)
- [Custom applications](~/identity-platform/developer-guide-conditional-access-authentication-context.md)

## Next steps

- [Conditional Access: Conditions](concept-conditional-access-conditions.md)
- [Conditional Access common policies](concept-conditional-access-policy-common.md)
- [Client application dependencies](service-dependencies.md)
