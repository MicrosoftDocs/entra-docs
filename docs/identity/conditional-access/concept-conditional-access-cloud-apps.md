---
title: Targeting Resources in Conditional Access Policies
description: Learn how to configure Conditional Access policies to target specific resources, actions, and authentication contexts in Microsoft Entra ID.
ms.topic: concept-article
ms.date: 01/26/2026
manager: dougeby
ms.reviewer: lhuangnorth
ms.custom:
  - has-azure-ad-ps-ref
  - ai-gen-docs-bap
  - ai-gen-title
  - ai-seo-date:07/25/2025
  - ai-gen-description
---
# Conditional Access: Target resources

Target resources (formerly cloud apps, actions, and authentication context) are key signals in a Conditional Access policy. Conditional Access policies let admins assign controls to specific applications, services, actions, or authentication context.

- Admins can choose from the list of applications or services that include built-in Microsoft applications and any [Microsoft Entra integrated applications](~/identity/enterprise-apps/what-is-application-management.md), including gallery, non-gallery, and applications published through [Application Proxy](~/identity/app-proxy/overview-what-is-app-proxy.md).
- Admins might define a policy based on a [user action](#user-actions) like **Register security information** or **Register or join devices**, letting Conditional Access enforce controls around those actions.
- Admins can target [traffic forwarding profiles](#traffic-forwarding-profiles) from Global Secure Access for enhanced functionality.
- Admins can use [authentication context](#authentication-context) to provide an extra layer of security in applications.

:::image type="content" source="media/concept-conditional-access-cloud-apps/conditional-access-cloud-apps-or-actions.png" alt-text="Screenshot of a Conditional Access policy and the target resources panel." lightbox="media/concept-conditional-access-cloud-apps/conditional-access-cloud-apps-or-actions.png":::

## Microsoft cloud applications

Admins can assign a Conditional Access policy to Microsoft cloud apps if the service principal appears in their tenant, except for Microsoft Graph. Microsoft Graph functions as an umbrella resource. Use [Audience Reporting](troubleshoot-conditional-access.md#audience-reporting) to see the underlying services and target those services in your policies. Some apps like [Microsoft 365/Office 365](#office-365) and [Windows Azure Service Management API](#windows-azure-service-management-api) include multiple related child apps or services. When new Microsoft cloud applications are created, they appear in the app picker list as soon as the service principal is created in the tenant. 

## Office 365

Microsoft 365 offers cloud-based productivity and collaboration services like Exchange, SharePoint, and Microsoft Teams. In Conditional Access, the Microsoft 365 suite of applications appears under 'Office 365'. Microsoft 365 cloud services are deeply integrated to ensure smooth and collaborative experiences. This integration might cause confusion when creating policies because some apps, like Microsoft Teams, depend on others, like SharePoint or Exchange.

The Office 365 app grouping in Conditional Access makes it possible to target these services all at once. We recommend using the Microsoft 365 grouping, instead of targeting individual cloud apps to avoid issues with [service dependencies](service-dependencies.md).

Targeting this group of applications helps to avoid issues that might arise because of inconsistent policies and dependencies. For example: The Exchange Online app is tied to traditional Exchange Online data like mail, calendar, and contact information. Related metadata might be exposed through different resources like search. To ensure that all metadata is protected by as intended, admins should assign policies to the Microsoft 365 app.

Admins can exclude the entire Microsoft 365 suite or specific Microsoft 365 cloud apps from Conditional Access policies.

A complete list of all services included can be found in the article [Apps included in Conditional Access Microsoft 365 app suite](reference-office-365-application-contents.md).

## Windows Azure Service Management API

When you target the Windows Azure Service Management API application, policy is enforced for tokens issued to a set of services closely bound to the portal. This grouping includes the application IDs of:

- Azure Resource Manager
- Azure portal, which also covers the Microsoft Entra admin center and the Microsoft Engage Center
- Azure Data Lake
- Application Insights API
- Log Analytics API

Because the policy is applied to the Azure management portal and API, any services or clients that depend on the Azure API can be indirectly affected. For example:

- Azure CLI
- Azure Data Factory portal
- Azure Event Hubs
- Azure PowerShell
- Azure Service Bus
- Azure SQL Database
- Azure Synapse
- Classic deployment model APIs
- Microsoft 365 admin center
- Microsoft IoT Central
- Microsoft Defender Multitenant management
- SQL Managed Instance
- Visual Studio subscriptions administrator portal
  

> [!CAUTION]
> Conditional Access policies associated with the Windows Azure Service Management API [no longer cover Azure DevOps](/azure/devops/organizations/accounts/conditional-access-policies#azure-resource-manager-audience).

> [!NOTE]
> The Windows Azure Service Management API application applies to [Azure PowerShell](/powershell/azure/what-is-azure-powershell), which calls the [Azure Resource Manager API](/azure/azure-resource-manager/management/overview). It doesn't apply to [Microsoft Graph PowerShell](/powershell/microsoftgraph/overview), which calls the [Microsoft Graph API](/graph/overview).
>
> For Azure Government, you should target the Azure Government Cloud Management API application.

## Microsoft Admin Portals

When a Conditional Access policy targets the Microsoft Admin Portals cloud app, the policy is enforced for tokens issued to application IDs of the following Microsoft administrative portals:

- Azure portal
- Exchange admin center
- Microsoft 365 admin center
- Microsoft 365 Defender portal
- Microsoft Entra admin center
- Microsoft Intune admin center
- Microsoft Purview portal
- Microsoft Teams admin center

We're continually adding more administrative portals to the list.

> [!NOTE]
> Block policies that target the Microsoft Admin Portals will block end users from accessing the Microsoft 365 self-install page, as this page is currently located in the Microsoft 365 admin center. For information on alternative deployment options, see [Plan your enterprise deployment of Microsoft 365 Apps](/microsoft-365-apps/deploy/plan-microsoft-365-apps).

### Other applications

Admins can add any Microsoft Entra registered application to Conditional Access policies. These applications might include:

- Applications published through [Microsoft Entra application proxy](~/identity/app-proxy/overview-what-is-app-proxy.md)
- [Applications added from the gallery](~/identity/enterprise-apps/add-application-portal.md)
- [Custom applications not in the gallery](~/identity/enterprise-apps/view-applications-portal.md)
- [Legacy applications published through app delivery controllers and networks](~/identity/enterprise-apps/secure-hybrid-access.md)
- Applications that use [password based single sign-on](~/identity/enterprise-apps/configure-password-single-sign-on-non-gallery-applications.md)

> [!NOTE]
> Because Conditional Access policy sets the requirements for accessing a service, you aren't able to apply it to a client (public/native) application. In other words, the policy isn't set directly on a client (public/native) application, but is applied when a client calls a service. For example, a policy set on SharePoint service applies to all clients calling SharePoint. A policy set on Exchange applies to the attempt to access the email using Outlook client. That is why client (public/native) applications aren't available for selection in the app picker and Conditional Access option isn't available in the application settings for the client (public/native) application registered in your tenant.

Some applications don't appear in the picker at all. The only way to include these applications in a Conditional Access policy is to include **All resources (formerly 'All cloud apps')** or add the missing service principal using the [New-MgServicePrincipal](/powershell/module/microsoft.graph.applications/new-mgserviceprincipal) PowerShell cmdlet or by using the [Microsoft Graph API](/graph/api/serviceprincipal-post-serviceprincipals).

### Conditional Access for different client types

Conditional Access applies to resources not clients, except when the client is a confidential client requesting an ID token.

- Public client
   - Public clients are those that run locally on devices like Microsoft Outlook on the desktop or mobile apps like Microsoft Teams. 
   - Conditional Access policies don't apply to public clients themselves but are based on the resources they request.
- Confidential client
   - Conditional Access applies to the resources requested by the client and the confidential client itself if it requests an ID token.
   - For example: If Outlook Web requests a token for scopes `Mail.Read` and `Files.Read`, Conditional Access applies policies for Exchange and SharePoint. Additionally, if Outlook Web requests an ID token, Conditional Access also applies the policies for Outlook Web.

To view [sign-in logs](/entra/identity/monitoring-health/concept-sign-ins) for these client types from the Microsoft Entra admin center:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Reports Reader](../role-based-access-control/permissions-reference.md#reports-reader).
1. Browse to **Entra ID** > **Monitoring & health** > **Sign-in logs**. 
1. Add a filter for **Client credential type**.
1. Adjust the filter to view a specific set of logs based on the client credential used in the sign-in.

For more information, see the article [Public client and confidential client applications](/entra/identity-platform/msal-client-applications).

<a name='all-cloud-apps'></a>

## Conditional Access for ALL resources

Applying a Conditional Access policy to **All resources (formerly 'All cloud apps')** without any resource exclusions enforces the policy for all token requests from websites and services, including [Global Secure Access traffic forwarding profiles](/entra/global-secure-access/concept-traffic-forwarding). This option includes applications that aren't individually targetable in Conditional Access policy, such as `Windows Azure Active Directory` (00000002-0000-0000-c000-000000000000).

> [!IMPORTANT]
> Microsoft recommends creating a baseline multifactor authentication policy targeting all users and all resources (without any resource exclusions), like the one explained in [Require multifactor authentication for all users](policy-all-users-mfa-strength.md).

### Legacy Conditional Access behavior when an ALL resources policy has a resource exclusion

> [!WARNING]
> [The following Conditional Access behavior is changing](https://aka.ms/CAAllResourcesWithExclusionsChange). Those low privileged scopes that were previously excluded from policy enforcement will **no longer be excluded**. This change means that users who were previously able to access the application without any Conditional Access enforcement might now receive Conditional Access challenges. The change is rolling out in phases starting in March, 2026.

If any app is excluded from the policy, in order to not inadvertently block user access, certain low privilege scopes were *previously* excluded from policy enforcement. These scopes allowed calls to the underlying Graph APIs, like `Windows Azure Active Directory` (00000002-0000-0000-c000-000000000000) and `Microsoft Graph` (00000003-0000-0000-c000-000000000000), to access user profile and group membership information commonly used by applications as part of authentication. For example: when Outlook requests a token for Exchange, it also asks for the `User.Read` scope to be able to display the basic account information of the current user.

Most apps have a similar dependency, which is why these low privilege scopes were automatically excluded in **All resources** policies. The *previously* excluded scopes are listed as follows, consent is still required for apps to use these permissions.

- Native clients and Single page applications (SPAs) have access to the following low privilege scopes:  
   - Azure AD Graph: `email`, `offline_access`, `openid`, `profile`, `User.Read`
   - Microsoft Graph: `email`, `offline_access`, `openid`, `profile`, `User.Read`, `People.Read`
- Confidential clients have access to the following low privilege scopes, if they're excluded from an **All resources** policy:         
   - Azure AD Graph: `email`, `offline_access`, `openid`, `profile`, `User.Read`, `User.Read.All`,`User.ReadBasic.All`
   - Microsoft Graph: `email`, `offline_access`, `openid`, `profile`, `User.Read`, `User.Read.All`, `User.ReadBasic.All`, `People.Read`, `People.Read.All`, `GroupMember.Read.All`, `Member.Read.Hidden`

### New Conditional Access behavior when an ALL resources policy has a resource exclusion

The scopes listed in the previous section are now evaluated as directory access and mapped to Azure AD Graph (resource: Windows Azure Active Directory, ID: 00000002-0000-0000-c000-000000000000) for Conditional Access evaluation purposes. 

Conditional Access policies that target All resources with one or more resource exclusions, or policies that explicitly target Azure AD Graph, are enforced in user sign-in flows where the client application requests only these scopes. There is no change in behavior when an application requests any additional scope beyond those listed above.

> [!NOTE]
> The [Azure AD Graph retirement](https://techcommunity.microsoft.com/blog/microsoft-entra-blog/important-update-azure-ad-graph-retirement/4364990) does not affect the Azure AD Graph (Windows Azure Active Directory) resource registered in your tenant.

### User experience

In user sign-in flows where client applications request only the scopes listed above, users might now receive Conditional Access challenges (such as MFA or device compliance). The exact challenge depends on the access controls configured in your policies that target All resources (with or without resource exclusions) or policies that explicitly target Azure AD Graph. 

In the following example, the tenant has a Conditional Access policy with the following details:
- Targeting All users and All resources
- Resource exclusions for a confidential client application and Exchange Online
- MFA is configured as the grant control

#### Example scenarios

| Example scenario | User impact (before → after) | Conditional Access evaluation |
|---|---|---|
| A user signs into VSCode desktop client, which requests openid and profile scopes. | **Before**: User not prompted for MFA</br>**After**: User is prompted for MFA | Conditional Access is now evaluated using Windows Azure Active Directory as the enforcement audience. |
| A user signs in using Azure CLI, which requests only `User.Read`. | **Before**: User not prompted for MFA</br>**After**: User is prompted for MFA | Conditional Access is now evaluated using Windows Azure Active Directory as the enforcement audience. |
| A user signs in through a confidential client application (excluded from the policy) that requests only `User.Read` and `People.Read`. | **Before**: User not prompted for MFA</br>**After**: User is prompted for MFA | Conditional Access is now evaluated using Windows Azure Active Directory as the enforcement audience. |

There is no change in behavior when a client application requests a scope beyond those listed previously, as illustrated in the following examples.

#### Example scenarios

| Example scenario | User impact | Conditional Access evaluation |
|---|---|---|
| A user signs in to a confidential client application (excluded from the policy) that requests offline_access and SharePoint access (`Files.Read`). | No change in behavior | Conditional Access continues to be enforced based on the SharePoint resource. |
| A user signs in to the OneDrive desktop sync client. OneDrive requests offline_access and Exchange Online access (`Mail.Read`). | No change in behavior | Conditional Access is not enforced because Exchange Online is excluded from the policy. |

Most applications request scopes beyond the previously listed scopes and are already subject to Conditional Access enforcement, unless the application is explicitly excluded from the policy. In such cases, there is no change in behavior.  

Custom applications that are intentionally designed to request only the previously listed scopes and are not designed to handle Conditional Access challenges might need to be updated so that they can handle Conditional Access challenges. Refer to the [Microsoft Conditional Access developer guidance](../../identity-platform/v2-conditional-access-dev-guide.md) for implementation details.   

### How to identify applications affected by the low-privilege scope enforcement change

Applications can be pre-authorized to request only one or more of the previously listed scopes. Use the following options to identify affected applications.

#### [PowerShell](#tab/powershell)

Use the following PowerShell script to list all applications in your tenant that are pre-authorized to request only one or more of the scopes that are affected by this change. 

> [!NOTE]
> Applications can request additional scopes dynamically (with admin consent). This script will not identify such applications.

```powershell
# ==============================
# Inventory of tenant-owned apps whose delegated consent grants include ONLY
# the OIDC scopes + specific directory scopes listed below.
#
# Output:
#  - ServicePrincipalObjectId (oauth2PermissionGrants.clientId = SP object id)
#  - Scopes (union of delegated scopes granted)
# ==============================

$TenantId = Read-Host "Enter your Microsoft Entra tenant ID (GUID)"

$BaselineScopes = @(
  "openid", "profile", "email", "offline_access",
  "User.Read", "User.Read.All", "User.ReadBasic.All",
  "People.Read", "People.Read.All",
  "GroupMember.Read.All", "Member.Read.Hidden"
)

Disconnect-MgGraph -ErrorAction SilentlyContinue
Connect-MgGraph -TenantId $TenantId -Scopes @(
  "DelegatedPermissionGrant.Read.All",
  "Directory.Read.All"
)

# Pull oauth2PermissionGrants (paging)
$uri = "https://graph.microsoft.com/beta/oauth2PermissionGrants?`$select=clientId,scope"
$grants = @()
while ($uri) {
  $resp = Invoke-MgGraphRequest -Method GET -Uri $uri
  $grants += $resp.value
  $uri = $resp.'@odata.nextLink'
}

# Build baseline-only candidate set (paste-safe: no leading pipes)
$candidates = @()
foreach ($g in ($grants | Group-Object clientId)) {
  $spObjectId = $g.Name

  $scopes = $g.Group |
  ForEach-Object { ($_.scope -split '\s+') } |
  Where-Object { $_ -and $_.Trim() -ne "" } |
  Sort-Object -Unique

  if ($scopes.Count -gt 0) {
    $outside = $scopes | Where-Object { $_ -notin $BaselineScopes }
    if ($outside.Count -eq 0) {
      $candidates += [PSCustomObject]@{
        ServicePrincipalObjectId = $spObjectId
        Scopes = ($scopes -join " ")
      }
    }
  }
}

$resultsTenantOwned = @()
$resultsNotTenantOwned = @()

# Filter to tenant-owned or external apps
foreach ($c in $candidates) {
  try {
    $spUri = "https://graph.microsoft.com/beta/servicePrincipals/$($c.ServicePrincipalObjectId)?`$select=id,appOwnerOrganizationId"
    $sp = Invoke-MgGraphRequest -Method GET -Uri $spUri

    if ($sp.appOwnerOrganizationId -eq $TenantId) {
      $resultsTenantOwned += [PSCustomObject]@{
        ServicePrincipalObjectId = $c.ServicePrincipalObjectId
        Scopes = $c.Scopes
      }
    }
    else {
      $resultsNotTenantOwned += [PSCustomObject]@{
        ServicePrincipalObjectId = $c.ServicePrincipalObjectId
        Scopes = $c.Scopes
      }
    }
  }
  catch {
    # Ignore non-enumerable / non-tenant-owned service principals
  }
}

# Output
'=== All tenant-owned apps whose delegated consent grants include ONLY the OIDC scopes + specific directory scopes ==='
$resultsTenantOwned | Sort-Object ServicePrincipalObjectId

'=== All external apps whose delegated consent grants include ONLY the OIDC scopes + specific directory scopes ==='
$resultsNotTenantOwned | Sort-Object ServicePrincipalObjectId
```

#### [Usage and Insights report](#tab/usage-and-insights-report)

The [Usage and Insights report in Microsoft Entra](../monitoring-health/concept-usage-insights-report.md) can help monitor application sign-in activity for specific applications.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Reports Reader](../role-based-access-control/permissions-reference.md#reports-reader). 
1. Browse to **Entra ID** > **Monitoring & health** > **Usage & insights**.
1. Select an application > select **Usage & insights**.

#### [Sign-in logs](#tab/sign-in-logs)

Microsoft Entra ID sign-in logs can also provide a detailed list of sign-ins for specific applications. 

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Reports Reader](../role-based-access-control/permissions-reference.md#reports-reader). 
1. Browse to **Entra ID** > **Monitoring & health** > **Sign-in logs**.
1. Set the filter **Application** and enter the application name or application ID as the value.

---

### Protecting directory information

> [!NOTE]
> The following section applies until the rollout of the low-privilege scope enforcement change is complete.

If the [recommended baseline MFA policy without resource exclusions](policy-all-users-mfa-strength.md) can't be configured because of business reasons, and your organization's security policy must include directory-related low privilege scopes (`User.Read`, `User.Read.All`, `User.ReadBasic.All`, `People.Read`, `People.Read.All`, `GroupMember.Read.All`, `Member.Read.Hidden`), create a separate Conditional Access policy targeting `Windows Azure Active Directory` (00000002-0000-0000-c000-000000000000). Windows Azure Active Directory (also called Azure AD Graph) is a resource representing data stored in the directory such as users, groups, and applications. The Windows Azure Active Directory resource is included in **All resources** but can be individually targeted in Conditional Access policies by using the following steps:
 
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
1. Under **Access controls** > **Grant**, select **Grant access**, **Require authentication strength**, select **Multifactor authentication**, then select **Select**.
1. Confirm your settings and set **Enable policy** to **Report-only**.
1. Select **Create** to create to enable your policy.

> [!NOTE]
> Configure this policy as described in the guidance above. Any deviations in creating the policy as described (such as defining resource exclusions) may result in low privilege scopes being excluded and the policy not applying as intended.

<a name='traffic-forwarding-profiles'></a>

#### All internet resources with Global Secure Access

The **All internet resources with Global Secure Access** option allows admins to target the [internet access traffic forwarding profile](/entra/global-secure-access/concept-traffic-forwarding) from [Microsoft Entra Internet Access](/entra/global-secure-access/overview-what-is-global-secure-access#microsoft-entra-internet-access).

These profiles in Global Secure Access enable admins to define and control how traffic is routed through Microsoft Entra Internet Access and Microsoft Entra Private Access. Traffic forwarding profiles can be assigned to devices and remote networks. For an example of how to apply a Conditional Access policy to these traffic profiles, see the article [How to apply Conditional Access policies to the Microsoft 365 traffic profile](/entra/global-secure-access/how-to-target-resource-microsoft-365-profile).

For more information about these profiles, see the article [Global Secure Access traffic forwarding profiles](/entra/global-secure-access/concept-traffic-forwarding).

#### All agent resources (Preview)

Applying a Conditional Access policy to All agent resources enforces the policy for all token requests to agent identity blueprint principals and agent identities.

## User actions

User actions are tasks that a user performs. Conditional Access supports two user actions:

- **Register security information**: This user action lets Conditional Access policies enforce rules when users try to register their security information. For more information, see [Combined security information registration](~/identity/authentication/concept-registration-mfa-sspr-combined.md).

> [!NOTE]
> If admins apply a policy targeting user actions for registering security information and the user account is a guest from a [Microsoft personal account (MSA)](~/external-id/microsoft-account.md), the 'Require multifactor authentication' control requires the MSA user to register security information with the organization. If the guest user is from another provider such as [Google](~/external-id/google-federation.md), access is blocked.

- **Register or join devices**: This user action enables admins to enforce Conditional Access policy when users [register](~/identity/devices/concept-device-registration.md) or [join](~/identity/devices/concept-directory-join.md) devices to Microsoft Entra ID. It lets admins configure multifactor authentication for registering or joining devices with more granularity than a tenant-wide policy. There are three key considerations with this user action:
   - `Require multifactor authentication` and `Require auth strength` are the only access controls available with this user action and all others are disabled. This restriction prevents conflicts with access controls that are either dependent on Microsoft Entra device registration or not applicable to Microsoft Entra device registration.
       - Windows Hello for Business and device-bound passkeys aren't supported because those scenarios require the device to be already registered.
   - `Client apps`, `Filters for devices`, and `Device state` conditions aren't available with this user action because they're dependent on Microsoft Entra device registration to enforce Conditional Access policies.

> [!WARNING]
> If a Conditional Access policy is configured with the **Register or join devices** user action, set **Entra ID** > **Devices** > **Overview** > **Device Settings** - `Require Multifactor Authentication to register or join devices with Microsoft Entra` to **No**. Otherwise, Conditional Access policies with this user action aren't properly enforced. Learn more about this device setting in [Configure device settings](~/identity/devices/manage-device-identities.md#configure-device-settings).

## Authentication context

Authentication context secures data and actions in applications. These applications include custom applications, line-of-business (LOB) applications, SharePoint, or applications protected by Microsoft Defender for Cloud Apps. It can also be used with Microsoft Entra Privileged Identity Management (PIM) to enforce Conditional Access policies during role activation.

For example, an organization might store files in SharePoint sites like a lunch menu or a secret BBQ sauce recipe. Everyone might access the lunch menu site, but users accessing the secret BBQ sauce recipe site might need to use a managed device and agree to specific terms of use. Similarly, an administrator activating a privileged role through PIM might be required to perform multifactor authentication or use a compliant device.

Authentication context works with users or [workload identities](workload-identity.md), but not in the same Conditional Access policy.

### Configure authentication contexts

Manage authentication contexts by going to **Entra ID** > **Conditional Access** > **Authentication context**.

:::image type="content" source="media/concept-conditional-access-cloud-apps/conditional-access-authentication-context-get-started.png" alt-text="Screenshot showing the management of authentication contexts." lightbox="media/concept-conditional-access-cloud-apps/conditional-access-authentication-context-get-started.png":::

Select **New authentication context** to create an authentication context definition. Organizations can create up to 99 authentication context definitions (**c1-c99**). Configure these attributes:

- **Display name** is the name that is used to identify the authentication context in Microsoft Entra ID and across applications that consume authentication contexts. We recommend names that can be used across resources, like *trusted devices*, to reduce the number of authentication contexts needed. Having a reduced set limits the number of redirects and provides a better end to end-user experience.
- **Description** provides more information about the policies. This information is used by admins and those applying authentication contexts to resources.
- **Publish to apps** checkbox, when selected, advertises the authentication context to apps and makes it available to be assigned. If not selected, the authentication context is unavailable to downstream resources.
- **ID** is read-only and used in tokens and apps for request-specific authentication context definitions. Listed here for troubleshooting and development use cases.

#### Add to Conditional Access policy

Admins can select published authentication contexts in Conditional Access policies by going to **Assignments** > **Cloud apps or actions** and selecting **Authentication context** from the **Select what this policy applies to** menu.

:::image type="content" source="media/concept-conditional-access-cloud-apps/conditional-access-authentication-context-in-policy.png" alt-text="Screenshot showing how to add a Conditional Access authentication context to a policy":::

#### Delete an authentication context

Before deleting an authentication context, ensure no applications use it. Otherwise, access to app data isn't protected. Confirm this by checking sign-in logs for cases where authentication context Conditional Access policies are applied.

To delete an authentication context, ensure it has no assigned Conditional Access policies and isn't published to apps. This prevents accidental deletion of an authentication context still in use.

### Tag resources with authentication contexts

To learn more about using authentication contexts, see the following articles.

- [Use sensitivity labels to protect content in Microsoft Teams, Microsoft 365 groups, and SharePoint sites](/purview/sensitivity-labels-teams-groups-sites)
- [Microsoft Defender for Cloud Apps](/defender-cloud-apps/session-policy-aad?branch=pr-en-us-2082#require-step-up-authentication-authentication-context)
- [Custom applications](~/identity-platform/developer-guide-conditional-access-authentication-context.md)
- [Privileged Identity Management - On activation, require Microsoft Entra Conditional Access authentication context](/entra/id-governance/privileged-identity-management/pim-resource-roles-configure-role-settings#on-activation-require-microsoft-entra-conditional-access-authentication-context)

## Related content

- [Conditional Access: Conditions](concept-conditional-access-conditions.md) – Learn how to configure conditions to refine your policies.  
- [Conditional Access common policies](concept-conditional-access-policy-common.md) – Explore common policy templates to get started quickly.  
- [Client application dependencies](service-dependencies.md) – Understand how dependencies impact Conditional Access policies.
