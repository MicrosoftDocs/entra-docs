---
title: Manage mappings and users in applications that did not match to users in Microsoft Entra ID | Microsoft Docs
description: The Microsoft Entra provisioning service matches users in Microsoft Entra ID with users already in an application. In some cases, an application may have users that do not match with any in Microsoft Entra ID.
author: markwahl-msft
manager: amycolannino
editor: markwahl-msft
ms.service: entra-id
ms.topic: how-to
ms.date: 04/02/2024
ms.author: mwahl
ms.reviewer: mwahl
---

# Manage mappings and users in applications that did not match to users in Microsoft Entra ID

When you are integrating an existing application with Microsoft Entra ID, for provisioning or single-sign on (SSO), you may determine there are users in the application's data store that do not correspond to users in Microsoft Entra ID, or that did not match to any users in Microsoft Entra ID.

The Microsoft Entra provisioning service relies upon configurable matching rules to determine whether a user in Microsoft Entra ID corresponds to a user in the application, searching the application for a user with the matching property from a Microsoft Entra ID user. For example, suppose the matching rule is to compare a Microsoft Entra ID user's `userPrincipalName` attribute with an application's `userName` property. When a user in Microsoft Entra ID with a `userPrincipalName` value of `alice.smith@contoso.com` is assigned to an application's role,  Microsoft Entra provisioning service performs a search of the application, with a query such as `userName eq "alice.smith@contoso.com"`. If the application search indicates no users match, then Microsoft Entra provisioning service creates a new user in the application.

If the application does not already have any users, then this process populates the application's data store with users as they are assigned in Microsoft Entra ID. However, if the application already has users, then two situations may arise. First, there may be people with user accounts in the application but the matching fails to locate them - perhaps the user is represented in the application as `asmith@contoso.com` rather than `alice.smith@contoso.com` and so the search Microsoft Entra provisioning service performs does not find them. In that situation, the person may end up with duplicate users in the application. Second, there may be people with user accounts in the application that have no user in Microsoft Entra ID. In this situation, Microsoft Entra provisioning service does not interact with those users in the application, however, if the application is configured to rely upon Microsoft Entra ID as its sole identity provider, those users won't be unable to sign in any longer: the application will redirect the person to sign in with Microsoft Entra ID, but the person does not have a user in Microsoft Entra ID.

These inconsistencies between Microsoft Entra ID and an existing application's data store can happen for many reasons, including:

* the application administrator creates users in the application directly, such as for contractors or vendors, who are not represented in a system of record HR source but did require application access,
* identity and attribute changes, such as a person changing their name, were not being sent to either Microsoft Entra ID or the application, and so the representations are out of date in one or the other system, or
* the organization was using an identity management product which independently provisioned Windows Server AD and the application with different communities. For example, store employees needed application access but did not require Exchange mailboxes, so store employees were not represented in Windows Server AD or Microsoft Entra ID.

Before enabling provisioning or SSO to an application with existing users, you should check to ensure that users are matching, and investigate and resolve those users from the application that did not match. This article outlines options for how to resolve for different situations that a user could not be matched.

## Determine if there are users in the application that did not match

If you already determined the list of users in the application that do not match users in Microsoft Entra ID, then continue in the next section.

The procedure to determine which users in the application do not match users in Microsoft Entra ID depends upon how the application is or will be integrated with Microsoft Entra ID.

* If you are using SAP Cloud Identity Services, then follow the [SAP Cloud Identity Services provisioning tutorial](~/identity/saas-apps/sap-cloud-platform-identity-authentication-provisioning-tutorial.md) through the step to ensure existing SAP Cloud Identity Services users have the necessary matching attributes. In that tutorial, you export a list of users from SAP Cloud Identity Services to a CSV file, and then use PowerShell to match those users to users in Microsoft Entra ID.

* If your application is using an LDAP directory, then follow the [LDAP directory provisioning tutorial](~/identity/app-provisioning/on-premises-ldap-connector-configure.md) through the step to collect existing users from the LDAP directory. In that tutorial, use PowerShell to match those users with users in Microsoft Entra ID.

* For other applications, including those applications with a SQL database or that have provisioning support in the application gallery, follow the tutorial to [govern an application's existing users](~/id-governance/identity-governance-applications-existing-users.md) through the step to confirm Microsoft Entra ID has users that match users from the application.

* For other applications that do not have a provisioning interface, follow the tutorial to [govern the users of an application that does not support provisioning](~/id-governance/identity-governance-applications-not-provisioned-users.md) through the step to confirm Microsoft Entra ID has users that match users from the application.

When the PowerShell script provided in those tutorials complete, it displays an error if any records from the application weren't located in Microsoft Entra ID. If not all the records for users from the application's data store could be located as users in Microsoft Entra ID, you'll need to investigate which records didn't match and why, and then resolve the match problem using one of the options in the next section.

## Options to ensure users are matched between the application and Microsoft Entra ID

This section provides several options to address the non-matching users in the application. Based on your organization's goals and the data issues between Microsoft Entra ID and the application, select the appropriate option for each user. There may not be a single option that covers all the users in a particular application.

|Option|Updates needed before provisioning|
|:--|--|
|[Delete test users from the application](#delete-test-users-from-the-application)|Users in application|
|[Delete users from the applications for people who no longer part of the organization](#delete-users-from-the-applications-for-people-who-are-no-longer-part-of-the-organization)|Users in application |
|[Delete users from the application and have them be re-created from Microsoft Entra ID](#delete-users-from-the-application-and-have-them-be-re-created-from-microsoft-entra-id)|Users in application|
|[Update the matching property of users in the application](#update-the-matching-property-of-users-in-the-application)| Users in application|
|[Update users in the application with a new property](#update-users-in-the-application-with-a-new-property)|Users in application |
|[Change matching rules or properties when email address does not match user principal name](#change-matching-rules-or-properties-when-email-address-does-not-match-user-principal-name)|Users in application or Microsoft Entra application matching rule |
|[Update the matching attribute of users in Microsoft Entra ID](#update-the-matching-attribute-of-users-in-microsoft-entra-id) |Users in Microsoft Entra ID |
|[Update the Microsoft Entra Connect sync or Cloud Sync provisioning rules to synchronize necessary users and attributes](#update-the-microsoft-entra-connect-sync-or-cloud-sync-provisioning-rules-to-synchronize-necessary-users-and-attributes) |Microsoft Entra Connect Sync or Microsoft Entra cloud Sync, which will update users in Microsoft Entra ID |
|[Update users in Microsoft Entra ID with a new attribute](#update-users-in-microsoft-entra-id-with-a-new-attribute) | Users in Microsoft Entra ID|
|[Change matching rules to a different attribute already populated in Microsoft Entra ID](#change-matching-rules-to-a-different-attribute-already-populated-in-microsoft-entra-id) | Microsoft Entra application matching rule|
|[Create users in Windows Server AD for users in the application who need continued application access](#create-users-in-windows-server-ad-for-users-in-the-application-who-need-continued-application-access) | Users in Windows Server AD, which will update users Microsoft Entra ID|
|[Create users in Microsoft Entra ID for users in the application who need continued application access](#create-users-in-microsoft-entra-id-for-users-in-the-application-who-need-continued-application-access) | Users in Microsoft Entra ID|
|[Maintain separate and unmatched users in the application and Microsoft Entra ID](#maintain-separate-and-unmatched-users-in-the-application-and-microsoft-entra-id) |None |

### Delete test users from the application

There may be test users in the application left over from its initial deployment. If there are users that are no longer required, then they can be deleted from the application.

### Delete users from the applications for people who are no longer part of the organization

The user might no longer be affiliated with the organization, and no longer needs access to the application, but is still a user in the application's data source. This can happen if the application administrator omitted to remove the user, or was not informed that the change was required. If the user is no longer needed, then it can be deleted from the application.

### Delete users from the application and have them be re-created from Microsoft Entra ID

If the application is not currently in wide use, or does not maintain any per-user state, then another option is to delete users from the application so that there are no longer any non-matching users. Then, as users request or are assigned the application in Microsoft Entra ID, they will be provisioned access.

### Update the matching property of users in the application

A user may exist in an application and in Microsoft Entra ID, but the user in the application is either missing a property needed for matching, or the property has the wrong value.

For example, when a SAP administrator creates a user in SAP Cloud Identity Services using its admin console, the user may not have a `userName` property. However, that property may be the one used for matching with users in Microsoft Entra ID. If the `userName` property is the one intended for matching, then you would need the SAP administrator to update those existing SAP Cloud Identity Services users to have a value of the `userName` property.

For another example, the application administrator has set the user's email address as a property `mail` of the user in the application, when the user was first added to the application. However, later the person's email address and `userPrincipalName` is changed in Microsoft Entra ID. However, if the application did not require the email address, or the email provider had a redirect that allowed the old email address to keep forwarding, then the application administrator might have missed that there was a need for `mail` property being updated in the application's data source. This inconsistency can be resolved by either the application administrator changing the `mail` property on the application's users to have a current value, or by changing the matching rule, as described in the following sections.

### Update users in the application with a new property

An organization's previous identity management system may have created users in the application as local users. If the organization did not have a single identity provider at the time, those users in the application did not need any properties to be correlated with any other system. For example, a previous identity management product created users in an application based on an authoritative HR source. That identity management system maintained the correlation between the users it created in the application with the HR source, and did not provide any of the HR source identifiers to the application. Later, when attempting to connect the application to a Microsoft Entra ID tenant populated from that same HR source, Microsoft Entra ID might have users for all the same people as are in the application, but the matching fails for all the users because there is no property in common.

In order to resolve this matching issue, perform the following steps.

 1. Select an existing unused property of users in the application, or add a new property to the user schema in the application.
 1. Populate that property on all the users in the application with data from an authoritative source, such as an employee ID number or email address, that is already present on users in Microsoft Entra ID.
 1. Update the [Microsoft Entra application provisioning attribute-mappings configuration](~/identity/app-provisioning/customize-application-attributes.md) for the application so that this property is included in the matching rule.

### Change matching rules or properties when email address does not match user principal name

By default, some of the Microsoft Entra provisioning service mappings for applications send the `userPrincipalName` attribute to match with an application email address property. Some organizations have primary email addresses for their users that are distinct from their user principal name. If the application is storing the email address as a property of the user, and not the `userPrincipalName`, then you need to either change the users in the application, or the matching rule.

 * If you plan to use single-sign on from Microsoft Entra ID to the application, then you may wish to change the application to add a property on the user to hold the userPrincipalName. Then, populate that property on each user in the application with the user's userPrincipalName from Microsoft Entra ID, and update the Microsoft Entra application provisioning configuration so that this property is included in the matching rule.
 * If you do not plan to use single-sign on from Microsoft Entra ID, then an alternative is to update the [Microsoft Entra application provisioning attribute-mappings configuration](~/identity/app-provisioning/customize-application-attributes.md), to match an email address attribute of the Microsoft Entra user in the matching rule.

### Update the matching attribute of users in Microsoft Entra ID

In some situations, the attribute used for matching has a value in the Microsoft Entra ID user that is out of date. For example, a person has changed their name, but the name change was not made in the Microsoft Entra ID user.

If the user was created and maintained solely in Microsoft Entra ID, then you should update the user to have the correct attributes. If the user attribute originates in an upstream system, such as Windows Server AD or an HR source, then you need to change the value in the upstream source, and wait for the change to become visible in Microsoft Entra ID.

### Update the Microsoft Entra Connect sync or Cloud Sync provisioning rules to synchronize necessary users and attributes

In some situations, a previous identity management system has populated Windows Server AD users with an appropriate attribute that can function as a matching attribute with another application. For example, if the previous identity management system was connected to an HR source, then the AD user have an `employeeId` attribute populated by that previous identity management system with the user's employee ID. For another example, the previous identity management system has written the application unique user ID as an extension attribute in the Windows Server AD schema. However, if neither of those attributes were selected for synchronization into Microsoft Entra ID, or the users were out of scope of synchronization into Microsoft Entra ID, then the Microsoft Entra ID representation of the user community may be incomplete.

To resolve this issue, you need to change your Microsoft Entra Connect sync or Microsoft Entra cloud sync configuration to ensure all appropriate users in Windows Server AD that are also in the application are in scope for being provisioned to Microsoft Entra ID, and that the synchronized attributes of those users include the attributes that will be used for matching purposes. If you are using Microsoft Entra Connect sync, see [Microsoft Entra Connect Sync: Configure filtering](~/identity/hybrid/connect/how-to-connect-sync-configure-filtering.md) and [Microsoft Entra Connect Sync: Directory extensions](~/identity/hybrid/connect/how-to-connect-sync-feature-directory-extensions.md). If you are using Microsoft Entra cloud sync, see [Attribute mapping in Microsoft Entra Cloud Sync](~/identity/hybrid/cloud-sync/how-to-attribute-mapping.md) and [Cloud sync directory extensions and custom attribute mapping](~/identity/hybrid/cloud-sync/custom-attribute-mapping.md).

### Update users in Microsoft Entra ID with a new attribute

In some situations, the application may hold a unique identifier for the user that is not currently stored in the Microsoft Entra ID schema for the user. For example, if you are using SAP Cloud Identity Services, you may wish to have the SAP user ID be the matching attribute, or if you are using a Linux system, you may wish to have the Linux user ID be the matching attribute. However, those properties are not part of the Microsoft Entra ID user schema, and so are likely not present on any of the users in Microsoft Entra ID.

To use a new attribute for matching, perform the following steps.

 1. Select an existing unused extension attribute in Microsoft Entra ID, or extend the Microsoft Entra user schema with a new attribute.
 1. Populate that attribute on all the users in Microsoft Entra ID with data from an authoritative source, such as the application or an HR system. If the users are synchronized from Windows Server AD or provisioned from an HR system, you may need to make that change in that upstream source.
 1. Update the [Microsoft Entra application provisioning attribute-mappings configuration](~/identity/app-provisioning/customize-application-attributes.md) and include this attribute in the matching rule.

### Change matching rules to a different attribute already populated in Microsoft Entra ID

The default matching rules for applications in the application gallery rely upon attributes that are commonly present on all Microsoft Entra ID users in all Microsoft customers, such as `userPrincipalName`. These rules are suitable for general-purpose testing or for provisioning into a new application that currently has no users. However many organizations may have already populated Microsoft Entra ID users with other attributes relevant to their organization, such as an employee ID. If there is another attribute suitable for matching, then update the [Microsoft Entra application provisioning attribute-mappings configuration](~/identity/app-provisioning/customize-application-attributes.md) and include this attribute in the matching rule.

### Configure inbound provisioning from an HR source to Microsoft Entra ID

Ideally organizations that have been provisioning users into multiple applications independently, should rely upon common identifiers for users derived from an authoritative source such as an HR system. Many HR systems have properties that function well as identifiers, such as `employeeId` that can be treated as unique so that no two people have the same employee ID. If you have an HR source, such as Workday or SuccessFactors, then bringing in attributes such as an employeeId from that source can often make a suitable matching rule.

To use an attribute with values obtained from an authoritative source for matching, perform the following steps.

1. Select an appropriate Microsoft Entra ID user schema attribute, or extend the Microsoft Entra user schema with a new attribute, whose values correspond to an equivalent property of a user in the application.
1. Ensure that property is also present in an HR source for all people who have users in Microsoft Entra ID and the application.
1. Configure inbound provisioning from that HR source to Microsoft Entra ID.
1. Wait for the users in Microsoft Entra ID to be updated with new attributes.
1. Update the [Microsoft Entra application provisioning attribute-mappings configuration](~/identity/app-provisioning/customize-application-attributes.md) and include this attribute in the matching rule.

### Create users in Windows Server AD for users in the application who need continued application access

If there are users from the application that do not correspond to a person in an authoritative HR source, but will require access to both Windows Server AD-based applications and Microsoft Entra ID-integrated applications in the future, and your organization is using Microsoft Entra Connect Sync or Microsoft Entra Cloud Sync to provision users from Windows Server AD to Microsoft Entra ID, then you can create a user in Windows Server AD for each of those users that were not already present.

If the users will not require access to Windows Server AD-based applications, then create the users in Microsoft Entra ID, as described in the next section.

### Create users in Microsoft Entra ID for users in the application who need continued application access

If there are users from the application that do not correspond to a person in an authoritative HR source, but will need continued access and be governed from Microsoft Entra, you can create Microsoft Entra users for them. You can create users in bulk by using either:

   - A CSV file, as described in [Bulk create users in the Microsoft Entra admin center](~/identity/users/users-bulk-add.md)
   - The [New-MgUser](/powershell/module/microsoft.graph.users/new-mguser?view=graph-powershell-1.0#examples&preserve-view=true) cmdlet  

Ensure that these new users are populated with the attributes required for Microsoft Entra ID to later match them to the existing users in the application, and the attributes required by Microsoft Entra ID, including `userPrincipalName`, `mailNickname`, and `displayName`. The `userPrincipalName` must be unique among all the users in the directory.

#### Creating users in bulk using PowerShell

This section shows how to interact with Microsoft Entra ID by using [Microsoft Graph PowerShell](https://www.powershellgallery.com/packages/Microsoft.Graph) cmdlets. 

The first time your organization uses these cmdlets for this scenario, you need to be in a Global Administrator role to allow Microsoft Graph PowerShell to be used in your tenant. Subsequent interactions can use a lower-privileged role, such as User Administrator.

1. If you already have a PowerShell session where you identified the users in the application that were not in Microsoft Entra ID, then continue at step 6 below. Otherwise, open PowerShell.
1. If you don't have the [Microsoft Graph PowerShell modules](https://www.powershellgallery.com/packages/Microsoft.Graph) already installed, install the `Microsoft.Graph.Users` module and others by using this command:

   ```powershell
   Install-Module Microsoft.Graph
   ```

   If you already have the modules installed, ensure that you're using a recent version: 

   ```powershell
   Update-Module microsoft.graph.users,microsoft.graph.identity.governance,microsoft.graph.applications
   ```

1. Connect to Microsoft Entra ID:

   ```powershell
   $msg = Connect-MgGraph -ContextScope Process -Scopes "User.ReadWrite.All"
   ```

1. If this is the first time you used this command, you will need to consent to allow the Microsoft Graph Command Line tools to have these permissions.

1. Bring into your PowerShell environment an array of the users from the application, that also has the fields that are Microsoft Entra ID required attributes - the user principal name, the mail nickname, and the user's full name. This script assumes the array `$dbu_not_matched_list` contains the users from the application that were not matched.

   ```powershell
   $filename = ".\Users-to-create.csv"
   $bu_not_matched_list = Import-Csv -Path $filename -Encoding UTF8
   ```

1. Specify in your PowerShell session which columns in the array of users to be created correspond to the Microsoft Entra ID required properties. For example, you might have users in a database where the value in the column named `EMail` is the value you want to use as the Microsoft Entra user principal Name, the value in the column `Alias` contains the Microsoft Entra ID mail nickname, and the value in the column `Full name` contains the user's display name:

   ```powershell
   $db_display_name_column_name = "Full name"
   $db_user_principal_name_column_name = "Email"
   $db_mail_nickname_column_name = "Alias"
   ```

1. Open the following script in a text editor. You may need to modify this script to add the Microsoft Entra attributes needed by your application, or if the `$azuread_match_attr_name` is not `mailNickname` or `userPrincipalName`, in order to supply that Microsoft Entra attribute.

   ```powershell
   $dbu_missing_columns_list = @()
   $dbu_creation_failed_list = @()
   foreach ($dbu in $dbu_not_matched_list) {
      if (($null -ne $dbu.$db_display_name_column_name -and $dbu.$db_display_name_column_name.Length -gt 0) -and
          ($null -ne $dbu.$db_user_principal_name_column_name -and $dbu.$db_user_principal_name_column_name.Length -gt 0) -and
          ($null -ne $dbu.$db_mail_nickname_column_name -and $dbu.$db_mail_nickname_column_name.Length -gt 0)) {
         $params = @{
            accountEnabled = $false
            displayName = $dbu.$db_display_name_column_name
            mailNickname = $dbu.$db_mail_nickname_column_name
            userPrincipalName = $dbu.$db_user_principal_name_column_name
            passwordProfile = @{
              Password = -join (((48..90) + (96..122)) * 16 | Get-Random -Count 16 | % {[char]$_})
            }
         }
         try {
           New-MgUser -BodyParameter $params
         } catch { $dbu_creation_failed_list += $dbu; throw }
      } else {
         $dbu_missing_columns_list += $dbu
      }
   }
   ```

1. Paste the resulting script from your text editor into your PowerShell session. If any errors occur, you must correct them before proceeding.

### Maintain separate and unmatched users in the application and Microsoft Entra ID

There might be a super-admin user in the application's data source that does not correspond to any specific person in Microsoft Entra ID. If you do not create Microsoft Entra users for them, then those users will not be able to be managed from Microsoft Entra ID or Microsoft Entra ID Governance. As those users will not be able to sign in with Microsoft Entra ID, so if you are configuring the application to use Microsoft Entra ID as an identity provider, ensure that those users are out of scope of using Microsoft Entra ID for authentication.

## Re-export users

After making updates to Microsoft Entra users, users in the application, or the Microsoft Entra application matching rules, you should re-export and perform the matching procedure for your application again, to ensure all users are correlated.

* If you are using SAP Cloud Identity Services, then follow the [SAP Cloud Identity Services provisioning tutorial](~/identity/saas-apps/sap-cloud-platform-identity-authentication-provisioning-tutorial.md#ensure-existing-sap-cloud-identity-services-users-have-the-necessary-matching-attributes) starting at the step to ensure existing SAP Cloud Identity Services users have the necessary matching attributes. In that tutorial, you export a list of users from SAP Cloud Identity Services to a CSV file, and then use PowerShell to match those users to users in Microsoft Entra ID.

* If your application is using an LDAP directory, then follow the [LDAP directory provisioning tutorial](~/identity/app-provisioning/on-premises-ldap-connector-configure.md#collect-existing-users-from-the-ldap-directory) starting at the step to collect existing users from the LDAP directory.

* For other applications, including those applications with a SQL database or that have provisioning support in the application gallery, follow the tutorial to [govern an application's existing users](~/id-governance/identity-governance-applications-existing-users.md#collect-existing-users-from-an-application) starting at the step to collect existing users from the application.

## Assign users to application roles and enable provisioning

Once you have completed the necessary updates and confirm all users from the application match users in Microsoft Entra ID, then you should assign the users in Microsoft Entra ID who need access to the application to the Microsoft Entra application app role, and then enable provisioning to the application.

* If you are using SAP Cloud Identity Services, then continue the [SAP Cloud Identity Services provisioning tutorial](~/identity/saas-apps/sap-cloud-platform-identity-authentication-provisioning-tutorial.md#ensure-existing-microsoft-entra-users-have-the-necessary-attributes) starting at the step to ensure existing Microsoft Entra users have the necessary attributes.

## Next steps

- [Integrating applications with Microsoft Entra ID and establishing a baseline of reviewed access](~/id-governance/identity-governance-applications-integrate.md)
- [Govern an application's existing users in Microsoft Entra ID with Microsoft PowerShell](~/id-governance/identity-governance-applications-existing-users.md)
- [Prepare for an access review of users' access to an application](~/id-governance/access-reviews-application-preparation.md)
