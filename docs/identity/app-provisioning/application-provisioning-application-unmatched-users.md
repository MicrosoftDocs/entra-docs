---
title: Manage the relationship to user accounts in applications that did not match to users in Microsoft Entra ID | Microsoft Docs
description: When provisioning to an application, Microsoft Entra provisioning service will match users in Microsoft Entra ID with those in already in the application. In some cases, an application may have user accounts which do not match with any in Microsoft Entra ID.
author: markwahl-msft
manager: amycolannino
editor: markwahl-msft
ms.service: entra-id
ms.topic: how-to
ms.date: 04/02/2024
ms.author: mwahl
ms.reviewer: mwahl
---

# Manage the relationship to user accounts in applications that did not match to users in Microsoft Entra ID

When integrating an existing application with Microsoft Entra ID, for provisioning or single-sign on (SSO), there may be users in the application's data store that do not correspond to users in Microsoft Entra ID, or that did not match.

The Microsoft Entra provisioning service relies upon configurable matching rules to determine whether a user in Microsoft Entra ID corresponds to a user in the application, searching the application for a user with the matching property from a Microsoft Entra ID user. For example, suppose the matching rule is to compare a Microsoft Entra ID user's `userPrincipalName` attribute with an application's `userName` property. When a user in Microsoft Entra ID with a `userPrincipalName` value of `alice.smith@contoso.com` is assigned to an application's role,  Microsoft Entra provisioning service will first perform a search of the application using a query such as `userName eq "alice.smith@contoso.com"`. If the application search indicates no users match, then Microsoft Entra provisioning service will create a new user.

If the application does not already have any users, then this process will populate the application's data store with users as they are assigned in Microsoft Entra ID. However, if the application already has users, then two situations may arise. First, there may be people with accounts in the application but the matching fails to locate them - perhaps the user is represented in the application as `asmith@contoso.com` rather than `alice.smith@contoso.com` and so the search Microsoft Entra provisioning service performs does not find them. In that situation, the person may end up with duplicate accounts in the application. Second, there may be people with accounts in the application that have no accounts in Microsoft Entra ID. In this situation, Microsoft Entra provisioning service will not interact with them, however, if the application is configured to rely upon Microsoft Entra ID as its sole identity provider, those users will be unable to sign in: the application will redirect the person to sign in with Microsoft Entra ID but the person does not have a user account there.

These inconsistencies between Microsoft Entra ID and an existing application's data store can happen for a number of reasons, including:

* the application owner creates accounts in the application directly, such as for contractors or vendors, who are not represented in a system of record HR source but did require application access
* identity and attribute changes, such as a person changing their name, were not being sent to either Microsoft Entra ID or the application, and so the representations are out of date in one or the other system, or
* the organization was using an identity management product which independently provisioned Windows Server AD and the application with different communities. For example, store employees needed application access but did not require Exchange mailboxes, so store employees were not represented in Windows Server AD or Microsoft Entra ID.

Before enabling provisioning or SSO to an application with existing users, you should check to ensure that users are matching, and investigate and resolve those that did not match.

## Determining if there are users that did not match

If you have already determined the list of users in the application which do not match those in Microsoft Entra ID, then continue in the next section.

The mechanism to determine which users in the application do not match those in Microsoft Entra ID will depend upon how the application is or will be integrated with Microsoft Entra ID.

* If you are using SAP Cloud Identity Services, then follow the [SAP Cloud Identity Services provisioning tutorial](~/identity/saas-apps/sap-cloud-platform-identity-authentication-provisioning-tutorial.md) through the step to ensure existing SAP Cloud Identity Services users have the necessary matching attributes. In that tutorial, you will export a list of users from SAP Cloud Identity Services to a CSV file, and then use PowerShell to match those users to those in Microsoft Entra ID.

* If your application is using an LDAP directory, then follow the [LDAP directory provisioning tutorial](~/identity/app-provisioning/on-premises-ldap-connector-configure.md) through the step to collect existing users from the LDAP directory.

* For other applications, including those with a SQL database or that have provisioning support in the application gallery, follow the tutorial [govern an application's existing users](~/id-governance/identity-governance-applications-existing-users.md) through the step to confirm Microsoft Entra ID has users that match users from the application.

* For other applications that do not have a provisioning interface, follow the tutorial to [govern the users of an application that does not support provisioning](~/id-governance/identity-governance-applications-not-provisioned-users.md) through the step to confirm Microsoft Entra ID has users that match users from the application.

When the script in those articles finishes, it will indicate an error if any records from the data source weren't located in Microsoft Entra ID. If not all the records for users from the application's data store could be located as users in Microsoft Entra ID, you'll need to investigate which records didn't match and why, and then resolve the match problem using the guidance in the next section.

## Options to ensure users are matched between the application and Microsoft Entra ID

This section provides several options to address the non-matching users in the application. Based on your organization's goals and the data issues between Microsoft Entra ID and the application, select the appropriate option for each user. Note that there may not be a single option that covers all the users in a particular application.

### Delete test account users from the application

There may be test accounts in the application left over from its initial deployment. If there are user accounts that are no longer required, then they could be deleted from the application.

### Delete users from the applications for people who have already left the organization

The user might have already left the organization but is still in the application's data source. If the user is no longer needed, then it could be deleted from the application.

### Update the matching property of users in the application

A user may exist in an application and in Microsoft Entra ID, but the user in the application is either missing a property needed for matching, or the property has the wrong value.

For example, when a SAP administrator creates a user in SAP Cloud Identity Services using its admin console, the user may not have a `userName` property. However, that property may be the one used for matching with users in Microsoft Entra ID. If the `userName` property is the one intended for matching, then you would need the SAP administrator to update those existing SAP Cloud Identity Services users to have a value of the `userName` property.

For another example, the application administrator may have set the user's email address as a property `mail` of the user in the application, when the user was first added to the application. However, subsequently the person's email address and `userPrincipalName` might have been changed in Microsoft Entra ID. However, if the application did not require the email address, or the email system had a redirect that allowed the old email address to keep forwarding, then the application administrator may have been unaware that there was a need for `mail` property being updated in the application's data source. Resolving this can be done by either the application owner changing the `mail` property on the application's users to have a current value, or changing the matching rule as described in the following sections.

### Update users in the application with a new property

Add a new property to the application and change the matching rule.

### Update the matching attribute of users in Microsoft Entra ID

Update properties already used for matching.

May need to change in AD, or in the upstream source.

### Update users in Microsoft Entra ID with a new attribute

Add a new property to the Microsoft Entra ID schema, populate users from the application, and change the matching rule.

### Change matching rules

May have another property already in use.

### Configure inbound provisioning from an HR source to Microsoft Entra

If the matching rule is an attribute from an authoritative source, but Microsoft Entra ID has not previously been connected to that authoritative source.
Configure inbound from SuccessFactors, Workday or other source. Wait for the users in Microsoft Entra ID to be updated with new attributes.

### Create users in Windows Server AD

If there are users from the application that do not correspond to a person in a authoritative HR source, but will require access to both Windows Server AD-based applications and Microsoft Entra ID-integrated applications in the future, and your organization is using Microsoft Entra Connect Sync or Microsoft Entra Cloud Sync to provision users from Windows Server AD to Microsoft Entra ID, then you can create a user in Windows Server AD. 

If the users will not require access to Windows Server AD-based applications, then create the users in Microsoft Entra ID, as described in the next section.

### Create users in Microsoft Entra ID

If there are users from the application that do not correspond to a person in a authoritative HR source, but will need continued access and be governed from Microsoft Entra, you will create Microsoft Entra users for them. You can create users in bulk by using either:

   - A CSV file, as described in [Bulk create users in the Microsoft Entra admin center](~/identity/users/users-bulk-add.md)
   - The [New-MgUser](/powershell/module/microsoft.graph.users/new-mguser?view=graph-powershell-1.0#examples&preserve-view=true) cmdlet  

   Ensure that these new users are populated with the attributes required for Microsoft Entra ID to later match them to the existing users in the application, and the attributes required by Microsoft Entra ID, including `userPrincipalName`, `mailNickname` and `displayName`. The `userPrincipalName` must be unique among all the users in the directory.

   For example, you might have users in a database where the value in the column named `EMail` is the value you want to use as the Microsoft Entra user principal Name, the value in the column `Alias` contains the Microsoft Entra ID mail nickname, and the value in the column `Full name` contains the user's display name:

   ```powershell
   $db_display_name_column_name = "Full name"
   $db_user_principal_name_column_name = "Email"
   $db_mail_nickname_column_name = "Alias"
   ```

   Then you can use this script to create Microsoft Entra users for those in SAP Cloud Identity Services, the database, or directory that didn't match with users in Microsoft Entra ID. Note that you may need to modify this script to add additional Microsoft Entra attributes needed in your organization, or if the `$azuread_match_attr_name` is neither `mailNickname` nor `userPrincipalName`, in order to supply that Microsoft Entra attribute.

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

### Maintain separate user accounts

There might be a super-admin account in the application's data source that does not correspond to any specific person in Microsoft Entra ID. If you do not create Microsoft Entra users for them, then they will not be able to be managed from Microsoft Entra ID or Microsoft Entra ID Governance. As those users will not be able to sign in with Microsoft Entra ID, so if you are configuring the application to use Microsoft Entra ID as an identity provider, ensure that those users are out of scope of using Microsoft Entra ID for authentication.

## Assign users to application roles and enable provisioning

After making updates to Microsoft Entra users, users in the application, or the Microsoft Entra application matching rules, you should re-export and perform the matching procedure for your application again, to ensure all user accounts are correlated.  Once you have completed this process and confirm all users match, then you should assign the users in Microsoft Entra ID who need access to the application to the Microsoft Entra application app role, and then enable provisioning to the 

## Next steps

- [Integrating applications with Microsoft Entra ID and establishing a baseline of reviewed access](~/id-governance/identity-governance-applications-integrate.md)
- [Govern an application's existing users in Microsoft Entra ID with Microsoft PowerShell](~/id-governance/identity-governance-applications-existing-users.md)
- [Prepare for an access review of users' access to an application](~/id-governance/access-reviews-application-preparation.md)
