---
title: Supported objects and recoverable properties in Microsoft Entra Backup
description: Learn which Microsoft Entra object types and properties are supported for backup and recovery, and understand current limitations.
ms.date: 03/02/2026
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
> Group ownership changes aren't in scope.

## Conditional access policy

All properties of conditional access policies are in scope.

## Named location policy

All properties of named location policies are in scope.

## Authorization policy

Recovery for authorization policy objects supports the following properties:

- `allowEmailVerifiedUsersToJoinOrganization`
- `allowInvitesFrom`
- `allowedToSignUpEmailBasedSubscriptions`
- `allowedToUseSSPR`
- `PermissionGrantPolicyIdsAssignedToDefaultUserRole`

## Authentication method policy

Recovery supports the following authentication method policies:

- Email OTP
- FIDO2 passkey
- Authenticator app
- Voice call
- SMS OTP
- Third-party software OATH
- Temporary Access Pass
- Certificate-based authentication

## Application objects

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

## Service principal objects

Recovery for **service principal** objects supports the following properties:

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

## Company (tenant) object

Recovery for the **company** object supports the following properties:

- `StrongAuthenticationDetails`
- `StrongAuthenticationPolicy`

## Limitations

### Job completion time

Completion time for difference reports and recovery depends on **data loading** and **processing**.

When a backup is accessed for the first time, either through creating a difference report or recovery, the recovery service loads the backup data, which takes a fixed amount of time regardless of your tenant size. Loaded data is reused across operations that reference the same backup. As a result, operations that reuse previously loaded data typically complete faster than those that require loading data for the first time. Creating a difference report not only helps you preview changes before recovery, but can also reduce recovery time and subsequent report creation time by eliminating repeated data loading for the same backup.

Once data loading is complete, the operation moves into processing. For difference reports, processing identifies changes between the backup and the current tenant. For recovery, processing applies the required changes to restore the backup state. Processing time varies based on the number of objects, the scope of the operation, and the number of changes involved.

### Hard-deleted objects

Microsoft Entra Backup and Recovery doesn't support the recovery or re-creation of hard-deleted objects. Only soft-deleted or modified objects can be restored.

### Objects synced from on-premises

Any changes made to on-premises synced objects appear in difference reports, but are automatically excluded from recovery. Organizations that use hybrid identity with Microsoft Entra ID can use difference reports to identify changes to objects synchronized from Active Directory Domain Services (AD DS). For certain object types, such as groups, the source of authority can be moved from AD DS to the cloud, making all Microsoft Entra Backup and Recovery functionality available for those converted objects. Backup and recovery of objects managed in AD DS should be handled using an alternative solution.

### Broader recoverability

Microsoft Entra Backup and Recovery should be used as part of a broader approach to recoverability that helps your organization be more resilient. To minimize the occurrence and impact of malicious and accidental directory data loss, follow [recoverability best practices in Microsoft Entra ID](/entra/architecture/recover-from-deletions), including establishment of preventative operational security measures, regular documentation of known good state using Microsoft Graph APIs, and preparatory processes needed to recover from deletion and misconfiguration.

### Dynamic groups

If your recovery scope includes dynamic groups, changes to dynamic membership rules are recovered, but membership itself is reevaluated by the dynamic group engine after recovery completes.
