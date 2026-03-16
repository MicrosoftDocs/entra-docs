---
title: Supported objects and recoverable properties in Microsoft Entra Backup and Recovery
description: Learn which Microsoft Entra Backup and Recovery object types and properties are supported for backup and recovery, and understand current limitations.
ms.date: 03/05/2026
ms.service: entra-id
ms.topic: concept-article
ai-usage: ai-assisted
---

# Supported objects and recoverable properties in Microsoft Entra Backup and Recovery (Preview)

> [!IMPORTANT]
> Microsoft Entra Backup and Recovery is currently in public preview. See the [Supplemental Terms of Use for Microsoft Azure Previews](https://azure.microsoft.com/support/legal/preview-supplemental-terms/) for legal terms that apply to Azure features that are in beta, preview, or otherwise not yet released into general availability.

Microsoft Entra Backup and Recovery supports recovery for a defined set of tenant object types and selected properties on those objects.

> [!NOTE]
> The set of supported objects and properties expands over time. Recovery applies only to supported properties listed in this article and doesn't imply full object rollback.

## User

Recovery for user objects supports these properties:

- `AccountEnabled`
- `AgeGroup`
- `City`
- `CompanyName`
- `ConsentProvidedForMinor`
- `Country`
- `Department`
- `DisplayName`
- `EmployeeHireDate`
- `EmployeeId`
- `EmployeeLeaveDate`
- `EmployeeOrgData`
- `EmployeeType`
- `FacsimileTelephoneNumber`
- `GivenName`
- `JobTitle`
- `Mail`
- `MailNickname`
- `Mobile`
- `OtherMail`
- `PasswordPolicies`
- `PerUserMfaState`
- `PhysicalDeliveryOfficeName`
- `PostalCode`
- `PreferredDataLocation`
- `PreferredLanguage`
- `State`
- `StreetAddress`
- `Surname`
- `TelephoneNumber`
- `UsageLocation`
- `UserPrincipalName`

> [!NOTE]
> Manager and sponsor changes aren't in scope.

For reference, you can view the full set of user properties in the [Microsoft Graph user resource type](/graph/api/resources/user#properties).

## Group

Recovery for group objects supports these properties:

- `Classification`
- `Description`
- `DisplayName`
- `GroupType`
- `IsPublic`
- `Mail`
- `MailEnabled`
- `MailNickname`
- `PreferredDataLocation`
- `PreferredLanguage`
- `SecurityEnabled`
- `Theme`

> [!NOTE]
> Group ownership changes aren't in scope. Dynamic groups can be restored or soft-deleted during recovery, but dynamic group rule changes aren't in scope.

For reference, you can view the full set of group properties in the [Microsoft Graph group resource type](/graph/api/resources/group#properties).

## Conditional access policy

All properties of conditional access policies are in scope. View all conditional access policy properties in the [Microsoft Graph conditionalAccessPolicy resource type](/graph/api/resources/conditionalaccesspolicy#properties).

## Named location policy

All properties of named location policies are in scope. View all named location policy properties in the [Microsoft Graph namedLocation resource type](/graph/api/resources/namedlocation#properties).

## Authorization policy

Recovery for authorization policy objects supports these properties:

- `blockMsolPowerShell`
- `guestUserRoleId`

Here is a mapping of guest user role Ids with guest user permission levels: 
- Guest users have the same access as members (Member User): a0b1b346-4d3e-4e8b-98f8-753987be4970
- Guest users have limited access to properties and memberships of directory objects (Guest User): 10dae51f-b6af-4016-8d66-8c2a99b929b3
- Guest uesr access is restricted to properties and memberships of their own directory objects (Restricted Guest User): 2af84b1e-32c8-42b7-82bc-daa82404023b

For reference, you can view the full set of authorization policy properties in the [Microsoft Graph authorizationPolicy resource type](/graph/api/resources/authorizationpolicy#properties).

## Authentication methods policy

Recovery supports these authentication method policies:

- Email OTP
- FIDO2 passkey
- Authenticator app
- Voice call
- SMS OTP
- Third-party software OATH
- Temporary Access Pass
- Certificate-based authentication

For reference, you can view the full set of authentication methods policy properties in the [Microsoft Graph authenticationMethodConfiguration resource type](/graph/api/resources/authenticationmethodconfiguration).

## Application

Recovery for **application** objects supports these properties:

- `DisplayName`
- `Description`
- `Notes`
- `ApplicationTag`
- `AppIdentifierUri`
- `AppCreatedDateTime`
- `PublicClient`
- `PublisherDomain`
- `IsDeviceOnlyAuthSupported`
- `ServiceManagementReference`
- `RequiredResourceAccess`
- `NativeAuthenticationApisEnabled`
- `SignInAudience`
- `GroupMembershipClaims`
- `OptionalClaims`
- `IsDisabled`
- `AddIns`
- `ServicePrincipalLockConfiguration`
- `AppInformationalUrl`

For reference, you can view the full set of application properties in the [Microsoft Graph application resource type](/graph/api/resources/application#properties).

## Service principal

Recovery for **service principal** objects supports these properties:

- `AccountEnabled`
- `AlternativeNames`
- `ExplicitAccessGrantRequired`
- `Description`
- `LoginUrl`
- `Notes`
- `NotificationEmailAddresses`
- `PreferredTokenSigningKeyThumbprint`
- `ServicePrincipalTag`
- `ServicePrincipalType`
- `PreferredSingleSignOnMode`
- `PublisherName`
- `SamlSingleSignOnSettings`
- `ServicePrincipalName`

For reference, you can view the full set of service principal properties in the [Microsoft Graph servicePrincipal resource type](/graph/api/resources/serviceprincipal#properties).

### OAuth2 (delegated) permission grant

OAuth2 permission grant represents the delegated permissions that have been granted to an application's service principal. Delegated permission grants can be created as a result of a user consenting an application's request to access an API, or granted by an administrator on behalf of all users. Permission grants created by an admin on behalf of all users is in scope. These permission grants can be identified as "consentType" = "AllPrincipals" and "principalId" = null. Permission grant created as a result of user consent is currently not supported. View oAuth2 (delegated) permission grant properties in the [Microsoft Graph oauth2PermissionGrant resource type](/graph/api/resources/oauth2permissiongrant#properties)

OAuth2 permission grant is available as a filter for both difference report creation and recovery jobs to allow more granular recovery. If you need to view all the changes for Service principals, please apply the filter of OAuth2 permission grant as well. 

### App role assignment

App role assignment is used to record when a user, group, or service principal is assigned an app role for an app. All properties of app role assignment are in scope. View all app role assignment details and properties in the [Microsoft Graph appRoleAssignment resource type](/graph/api/resources/approleassignment).

App role assignment is available as a filter for both difference report creation and recovery jobs to allow more granular recovery. If you need to view all the changes for Service principals, please apply the filter of app role assignment as well. 

In Entra portal, Service principals, OAuth2 permission grants and app role assignments are grouped as one filter to show all the changes that have happened to service principals. 

## Organization

Recovery for the organization object supports these properties:

**Tenant-level per-user MFA settings:**

- StrongAuthenticationDetails
  - `availableMFAMethods`

    :::image type="content" source="media/scope-supported-objects-limitations/organization-available-mfa-methods.png" alt-text="Screenshot showing the availableMFAMethods property under StrongAuthenticationDetails.":::

  - `IsApplicationPasswordBlocked`

    :::image type="content" source="media/scope-supported-objects-limitations/organization-app-password-blocked.png" alt-text="Screenshot showing the IsApplicationPasswordBlocked property under StrongAuthenticationDetails.":::

  - `IsRememberDevicesEnabled`

    :::image type="content" source="media/scope-supported-objects-limitations/organization-remember-devices-enabled.png" alt-text="Screenshot showing the IsRememberDevicesEnabled property under StrongAuthenticationDetails.":::

  - `rememberDevicesDurationInDays`

    :::image type="content" source="media/scope-supported-objects-limitations/organization-remember-devices-duration.png" alt-text="Screenshot showing the rememberDevicesDurationInDays property under StrongAuthenticationDetails.":::

- StrongAuthenticationPolicy
  - `enabled`

    :::image type="content" source="media/scope-supported-objects-limitations/organization-strong-authentication-policy-enabled.png" alt-text="Screenshot showing the enabled property under StrongAuthenticationPolicy.":::

  - `ipAllowList`

    :::image type="content" source="media/scope-supported-objects-limitations/organization-strong-authentication-policy-allowed-list.png" alt-text="Screenshot showing the ipAllowList property under StrongAuthenticationPolicy.":::

## Limitations

### Job completion time

Completion time for difference reports and recovery depends on **data loading** and **processing**.

When a backup is accessed for the first time, either through creating a difference report or recovery, the recovery service loads the backup data, which takes a fixed amount of time even when tenant size is small. Loaded data is reused across operations that reference the same backup. As a result, operations that reuse previously loaded data typically complete faster than those that require loading data for the first time. Creating a difference report not only helps you preview changes before recovery, but can also reduce recovery time and subsequent report creation time by eliminating data loading for the same backup.

After data loading is complete, the operation moves into processing. For difference reports, processing identifies changes between the backup and the current tenant. For recovery, processing applies the required changes to restore the backup state. Processing time varies based on the number of objects, the scope of the operation, and the number of changes involved.

### Hard-deleted objects

Microsoft Entra Backup and Recovery doesn't support the recovery or re-creation of hard-deleted objects. Only soft-deleted or modified objects can be restored.

### Objects managed in on-premises Active Directory Domain Services

Any changes made to on-premises synced objects appear in difference reports, but are automatically excluded from recovery. Organizations that use hybrid identity with Microsoft Entra ID can use difference reports to identify changes to objects synchronized from on-premises. For certain object types, such as users and groups, the source of authority can be moved from on-premises to the cloud, making all Microsoft Entra Backup and Recovery functionality available for those converted objects. Backup and recovery of objects managed in on-premises should be handled using an alternative solution. 

When a user or groups is converted to the cloud to be Entra managded after the backup state and if that specific backup is used to recover the user or group, its source of authority will not be converted to be on-premises Active Directory. Other supported changed attributes will be recovered. 

### Broader recoverability

Microsoft Entra Backup and Recovery should be used as part of a broader approach to recoverability that helps your organization be more resilient. To minimize the occurrence and impact of malicious and accidental directory data loss, follow [recoverability best practices in Microsoft Entra ID](/entra/architecture/recover-from-deletions), including establishment of preventative operational security measures, regular documentation of known good state using Microsoft Graph APIs, and preparatory processes needed to recover from deletion and misconfiguration.
