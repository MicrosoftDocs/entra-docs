---
author: markwahl-msft
ms.service: entra-id
ms.topic: include
ms.date: 12/22/2022
ms.author: mwahl
---

<a name='retrieve-the-ids-of-the-users-in-azure-ad'></a>

### Retrieve the IDs of the users in Microsoft Entra ID

This section shows how to interact with Microsoft Entra ID by using [Microsoft Graph PowerShell](https://www.powershellgallery.com/packages/Microsoft.Graph) cmdlets. 

The first time your organization uses these cmdlets for this scenario, you need to be in a Global Administrator role to allow Microsoft Graph PowerShell to be used in your tenant. Subsequent interactions can use a lower-privileged role, such as:

- User Administrator, if you anticipate creating new users.
- Application Administrator or [Identity Governance Administrator](~/identity/role-based-access-control/permissions-reference.md#identity-governance-administrator), if you're just managing application role assignments.

1. Open PowerShell.
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
   $msg = Connect-MgGraph -ContextScope Process -Scopes "User.ReadWrite.All,Application.ReadWrite.All,AppRoleAssignment.ReadWrite.All,EntitlementManagement.ReadWrite.All"
   ```

1. If this is the first time you have used this command, you may need to consent to allow the Microsoft Graph Command Line tools to have these permissions.


1. Read the list of users obtained from the application's data store into the PowerShell session. If the list of users was in a CSV file, you can use the PowerShell cmdlet `Import-Csv` and provide the name of the file from the previous section as an argument. 

   For example, if the file obtained from SAP Cloud Identity Services is named *Users-exported-from-sap.csv* and is located in the current directory, enter this command.

   ```powershell
   $filename = ".\Users-exported-from-sap.csv"
   $dbusers = Import-Csv -Path $filename -Encoding UTF8
   ```

   For another example if you are using a database or directory, if the file is named *users.csv* and located in the current directory, enter this command:

   ```powershell
   $filename = ".\users.csv"
   $dbusers = Import-Csv -Path $filename -Encoding UTF8
   ```

1. Choose the column of the *users.csv* file that will match with an attribute of a user in Microsoft Entra ID.

   If you are using SAP Cloud Identity Services, then the default mapping is the SAP SCIM attribute `userName` with the Microsoft Entra ID attribute `userPrincipalName`:

   ```powershell
   $db_match_column_name = "userName"
   $azuread_match_attr_name = "userPrincipalName"
   ```

   For another example if you are using a database or directory, you might have users in a database where the value in the column named `EMail` is the same value as in the Microsoft Entra attribute `userPrincipalName`:

   ```powershell
   $db_match_column_name = "EMail"
   $azuread_match_attr_name = "userPrincipalName"
   ```

1. Retrieve the IDs of those users in Microsoft Entra ID.

   The following PowerShell script uses the `$dbusers`, `$db_match_column_name`, and `$azuread_match_attr_name` values specified earlier. It will query Microsoft Entra ID to locate a user that has an attribute with a matching value for each record in the source file. If there are many users in the file obtained from the source SAP Cloud Identity Services, database, or directory, this script might take several minutes to finish. If you don't have an attribute in Microsoft Entra ID that has the value, and need to use a `contains` or other filter expression, then you will need to customize this script and that in step 11 below to use a different filter expression.

   ```powershell
   $dbu_not_queried_list = @()
   $dbu_not_matched_list = @()
   $dbu_match_ambiguous_list = @()
   $dbu_query_failed_list = @()
   $azuread_match_id_list = @()
   $azuread_not_enabled_list = @()
   $dbu_values = @()
   $dbu_duplicate_list = @()

   foreach ($dbu in $dbusers) { 
      if ($null -ne $dbu.$db_match_column_name -and $dbu.$db_match_column_name.Length -gt 0) { 
         $val = $dbu.$db_match_column_name
         $escval = $val -replace "'","''"
         if ($dbu_values -contains $escval) { $dbu_duplicate_list += $dbu; continue } else { $dbu_values += $escval }
         $filter = $azuread_match_attr_name + " eq '" + $escval + "'"
         try {
            $ul = @(Get-MgUser -Filter $filter -All -Property Id,accountEnabled -ErrorAction Stop)
            if ($ul.length -eq 0) { $dbu_not_matched_list += $dbu; } elseif ($ul.length -gt 1) {$dbu_match_ambiguous_list += $dbu } else {
               $id = $ul[0].id; 
               $azuread_match_id_list += $id;
               if ($ul[0].accountEnabled -eq $false) {$azuread_not_enabled_list += $id }
            } 
         } catch { $dbu_query_failed_list += $dbu } 
       } else { $dbu_not_queried_list += $dbu }
   }

   ```

1. View the results of the previous queries. See if any of the users in SAP Cloud Identity Services, the database, or directory couldn't be located in Microsoft Entra ID, because of errors or missing matches.

   The following PowerShell script will display the counts of records that weren't located:

   ```powershell
   $dbu_not_queried_count = $dbu_not_queried_list.Count
   if ($dbu_not_queried_count -ne 0) {
     Write-Error "Unable to query for $dbu_not_queried_count records as rows lacked values for $db_match_column_name."
   }
   $dbu_duplicate_count = $dbu_duplicate_list.Count
   if ($dbu_duplicate_count -ne 0) {
     Write-Error "Unable to locate Microsoft Entra ID users for $dbu_duplicate_count rows as multiple rows have the same value"
   }
   $dbu_not_matched_count = $dbu_not_matched_list.Count
   if ($dbu_not_matched_count -ne 0) {
     Write-Error "Unable to locate $dbu_not_matched_count records in Microsoft Entra ID by querying for $db_match_column_name values in $azuread_match_attr_name."
   }
   $dbu_match_ambiguous_count = $dbu_match_ambiguous_list.Count
   if ($dbu_match_ambiguous_count -ne 0) {
     Write-Error "Unable to locate $dbu_match_ambiguous_count records in Microsoft Entra ID as attribute match ambiguous."
   }
   $dbu_query_failed_count = $dbu_query_failed_list.Count
   if ($dbu_query_failed_count -ne 0) {
     Write-Error "Unable to locate $dbu_query_failed_count records in Microsoft Entra ID as queries returned errors."
   }
   $azuread_not_enabled_count = $azuread_not_enabled_list.Count
   if ($azuread_not_enabled_count -ne 0) {
    Write-Error "$azuread_not_enabled_count users in Microsoft Entra ID are blocked from sign-in."
   }
   if ($dbu_not_queried_count -ne 0 -or $dbu_duplicate_count -ne 0 -or $dbu_not_matched_count -ne 0 -or $dbu_match_ambiguous_count -ne 0 -or $dbu_query_failed_count -ne 0 -or $azuread_not_enabled_count) {
    Write-Output "You will need to resolve those issues before access of all existing users can be reviewed."
   }
   $azuread_match_count = $azuread_match_id_list.Count
   Write-Output "Users corresponding to $azuread_match_count records were located in Microsoft Entra ID." 
   ```

1. When the script finishes, it will indicate an error if any records from the data source weren't located in Microsoft Entra ID. If not all the records for users from the application's data store could be located as users in Microsoft Entra ID, you'll need to investigate which records didn't match and why.  

   For example, someone's email address and userPrincipalName might have been changed in Microsoft Entra ID without their corresponding `mail` property being updated in the application's data source. Or, the user might have already left the organization but is still in the application's data source. Or there might be a vendor or super-admin account in the application's data source that does not correspond to any specific person in Microsoft Entra ID.

1. If there were users who couldn't be located in Microsoft Entra ID, or weren't active and able to sign in, but you want to have their access reviewed or their attributes updated in SAP Cloud Identity Services, the database, or directory, you'll need to update the application, the matching rule, or update or create Microsoft Entra users for them. For more information on which change to make, see [manage mappings and user accounts in applications that did not match to users in Microsoft Entra ID](~/identity/app-provisioning/application-provisioning-application-unmatched-users.md).

   If you choose the option of creating users in Microsoft Entra ID, you can create users in bulk by using either:

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

1. After you add any missing users to Microsoft Entra ID, run the script from step 7 again. Then run the script from step 8. Check that no errors are reported.

   ```powershell
   $dbu_not_queried_list = @()
   $dbu_not_matched_list = @()
   $dbu_match_ambiguous_list = @()
   $dbu_query_failed_list = @()
   $azuread_match_id_list = @()
   $azuread_not_enabled_list = @()
   $dbu_values = @()
   $dbu_duplicate_list = @()

   foreach ($dbu in $dbusers) { 
      if ($null -ne $dbu.$db_match_column_name -and $dbu.$db_match_column_name.Length -gt 0) { 
         $val = $dbu.$db_match_column_name
         $escval = $val -replace "'","''"
         if ($dbu_values -contains $escval) { $dbu_duplicate_list += $dbu; continue } else { $dbu_values += $escval }
         $filter = $azuread_match_attr_name + " eq '" + $escval + "'"
         try {
            $ul = @(Get-MgUser -Filter $filter -All -Property Id,accountEnabled -ErrorAction Stop)
            if ($ul.length -eq 0) { $dbu_not_matched_list += $dbu; } elseif ($ul.length -gt 1) {$dbu_match_ambiguous_list += $dbu } else {
               $id = $ul[0].id; 
               $azuread_match_id_list += $id;
               if ($ul[0].accountEnabled -eq $false) {$azuread_not_enabled_list += $id }
            } 
         } catch { $dbu_query_failed_list += $dbu } 
       } else { $dbu_not_queried_list += $dbu }
   }

   $dbu_not_queried_count = $dbu_not_queried_list.Count
   if ($dbu_not_queried_count -ne 0) {
     Write-Error "Unable to query for $dbu_not_queried_count records as rows lacked values for $db_match_column_name."
   }
   $dbu_duplicate_count = $dbu_duplicate_list.Count
   if ($dbu_duplicate_count -ne 0) {
     Write-Error "Unable to locate Microsoft Entra ID users for $dbu_duplicate_count rows as multiple rows have the same value"
   }
   $dbu_not_matched_count = $dbu_not_matched_list.Count
   if ($dbu_not_matched_count -ne 0) {
     Write-Error "Unable to locate $dbu_not_matched_count records in Microsoft Entra ID by querying for $db_match_column_name values in $azuread_match_attr_name."
   }
   $dbu_match_ambiguous_count = $dbu_match_ambiguous_list.Count
   if ($dbu_match_ambiguous_count -ne 0) {
     Write-Error "Unable to locate $dbu_match_ambiguous_count records in Microsoft Entra ID as attribute match ambiguous."
   }
   $dbu_query_failed_count = $dbu_query_failed_list.Count
   if ($dbu_query_failed_count -ne 0) {
     Write-Error "Unable to locate $dbu_query_failed_count records in Microsoft Entra ID as queries returned errors."
   }
   $azuread_not_enabled_count = $azuread_not_enabled_list.Count
   if ($azuread_not_enabled_count -ne 0) {
    Write-Warning "$azuread_not_enabled_count users in Microsoft Entra ID are blocked from sign-in."
   }
   if ($dbu_not_queried_count -ne 0 -or $dbu_duplicate_count -ne 0 -or $dbu_not_matched_count -ne 0 -or $dbu_match_ambiguous_count -ne 0 -or $dbu_query_failed_count -ne 0 -or $azuread_not_enabled_count -ne 0) {
    Write-Output "You will need to resolve those issues before access of all existing users can be reviewed."
   }
   $azuread_match_count = $azuread_match_id_list.Count
   Write-Output "Users corresponding to $azuread_match_count records were located in Microsoft Entra ID." 
   ```
