---
title: Supported objects and recoverable properties in Microsoft Entra Backup
description: Learn which Microsoft Entra object types and properties are supported for backup and recovery, and understand current limitations.
ms.date: 03/05/2026
ms.service: entra-id
ms.topic: concept-article
ai-usage: ai-assisted
---

# Supported objects and recoverable properties in Microsoft Entra Backup (Preview)

Microsoft Entra Backup and Recovery supports recovery for a defined set of tenant object types and selected properties on those objects.

> [!NOTE]
> The set of supported objects and properties expands over time. Recovery applies only to supported properties listed in this article and doesn't imply full object rollback.

## User

Recovery for user objects supports the following properties:

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

Recovery for group objects supports the following properties:

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
> Group ownership changes aren't in scope. Dynamic groups can be restored or soft-deleted during recovery, but dynamic group rule and membership changes aren't in scope.

For reference, you can view the full set of group properties in the [Microsoft Graph group resource type](/graph/api/resources/group#properties).

## Conditional access policy

All properties of conditional access policies are in scope. View all conditional access policy properties in the [Microsoft Graph conditionalAccessPolicy resource type](/graph/api/resources/conditionalaccesspolicy#properties).

## Named location policy

All properties of named location policies are in scope. View all named location policy properties in the [Microsoft Graph namedLocation resource type](/graph/api/resources/namedlocation#properties).

## Authorization policy

Recovery for authorization policy objects supports the following properties:

- `allowEmailVerifiedUsersToJoinOrganization`
- `allowInvitesFrom`
- `allowedToSignUpEmailBasedSubscriptions`
- `allowedToUseSSPR`
- `PermissionGrantPolicyIdsAssignedToDefaultUserRole`

For reference, you can view the full set of authorization policy properties in the [Microsoft Graph authorizationPolicy resource type](/graph/api/resources/authorizationpolicy#properties).

## Authentication methods policy

Recovery supports the following authentication method policies:

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

Recovery for **application** objects supports the following properties:

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

### Recovery for **service principal** objects supports the following properties:

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

OAuth2 permission grant represents the delegated permissions that have been granted to an application's service principal. Delegated permission grants can be created as a result of a user consenting an application's request to access an API, or created directly. All properties of oAuth2 permission grant are in scope. View all oAuth2 (delegated) permission grant properties in the [Microsoft Graph oauth2PermissionGrant resource type](/graph/api/resources/oauth2permissiongrant#properties)

OAuth2 permission grant is available as a filter for both difference report creation and recovery jobs to allow more granular recovery. If you need to view all the changes for Service principals, please apply the filter of OAuth2 permission grant as well. 

### App role assignment

App role assignment is used to record when a user, group, or service principal is assigned an app role for an app. All properties of app role assignment are in scope. View all app role assignment details and properties in the [Microsoft Graph appRoleAssignment resource type](/graph/api/resources/approleassignment).

App role assignment is available as a filter for both difference report creation and recovery jobs to allow more granular recovery. If you need to view all the changes for Service principals, please apply the filter of app role assignment as well. 

## Organization

Recovery for the organization object supports the following properties:

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

When a backup is accessed for the first time, either through creating a difference report or recovery, the recovery service loads the backup data, which takes a fixed amount of time regardless of your tenant size. Loaded data is reused across operations that reference the same backup. As a result, operations that reuse previously loaded data typically complete faster than those that require loading data for the first time. Creating a difference report not only helps you preview changes before recovery, but can also reduce recovery time and subsequent report creation time by eliminating repeated data loading for the same backup.

Once data loading is complete, the operation moves into processing. For difference reports, processing identifies changes between the backup and the current tenant. For recovery, processing applies the required changes to restore the backup state. Processing time varies based on the number of objects, the scope of the operation, and the number of changes involved.

### Hard-deleted objects

Microsoft Entra Backup and Recovery doesn't support the recovery or re-creation of hard-deleted objects. Only soft-deleted or modified objects can be restored.

### Objects managed in AD DS

Any changes made to on-premises synced objects appear in difference reports, but are automatically excluded from recovery. Organizations that use hybrid identity with Microsoft Entra ID can use difference reports to identify changes to objects synchronized from Active Directory Domain Services (AD DS). For certain object types, such as groups, the source of authority can be moved from AD DS to the cloud, making all Microsoft Entra Backup and Recovery functionality available for those converted objects. Backup and recovery of objects managed in AD DS should be handled using an alternative solution.

### Broader recoverability

Microsoft Entra Backup and Recovery should be used as part of a broader approach to recoverability that helps your organization be more resilient. To minimize the occurrence and impact of malicious and accidental directory data loss, follow [recoverability best practices in Microsoft Entra ID](/entra/architecture/recover-from-deletions), including establishment of preventative operational security measures, regular documentation of known good state using Microsoft Graph APIs, and preparatory processes needed to recover from deletion and misconfiguration.
