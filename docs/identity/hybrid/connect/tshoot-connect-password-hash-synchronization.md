---
title: Troubleshoot password hash synchronization with Microsoft Entra Connect Sync
description: This article provides information about how to troubleshoot password hash synchronization problems.
author: omondiatieno
manager: mwongerapk
ms.service: entra-id
ms.tgt_pltfrm: na
ms.topic: troubleshooting
ms.date: 04/09/2025
ms.subservice: hybrid-connect
ms.author: jomondi
ms.custom: sfi-image-nochange
---
# Troubleshoot password hash synchronization with Microsoft Entra Connect Sync

This topic provides steps for how to troubleshoot issues with password hash synchronization. If passwords aren't synchronizing as expected, it can be either for a subset of users or for all users.

For Microsoft Entra Connect deployment with version 1.1.614.0 or after, use the troubleshooting task in the wizard to troubleshoot password hash synchronization issues:

* If you have an issue where no passwords are synchronized, refer to the [No passwords are synchronized: troubleshoot by using the troubleshooting task](#no-passwords-are-synchronized-troubleshoot-by-using-the-troubleshooting-task) section.

* If you have an issue with individual objects, refer to the [One object is not synchronizing passwords: troubleshoot by using the troubleshooting task](#one-object-isnt-synchronizing-passwords-troubleshoot-by-using-the-troubleshooting-task) section.

For deployment with version 1.1.524.0 or later, there's a diagnostic cmdlet that you can use to troubleshoot password hash synchronization issues:

* If you have an issue where no passwords are synchronized, refer to the [No passwords are synchronized: troubleshoot by using the diagnostic cmdlet](#no-passwords-are-synchronized-troubleshoot-by-using-the-diagnostic-cmdlet) section.

* If you have an issue with individual objects, refer to the [One object is not synchronizing passwords: troubleshoot by using the diagnostic cmdlet](#one-object-isnt-synchronizing-passwords-troubleshoot-by-using-the-diagnostic-cmdlet) section.

For older versions of Microsoft Entra Connect deployment:

* If you have an issue where no passwords are synchronized, refer to the [No passwords are synchronized: manual troubleshooting steps](#no-passwords-are-synchronized-manual-troubleshooting-steps) section.

* If you have an issue with individual objects, refer to the [One object is not synchronizing passwords: manual troubleshooting steps](#one-object-isnt-synchronizing-passwords-manual-troubleshooting-steps) section.



## No passwords are synchronized: troubleshoot by using the troubleshooting task

You can use the troubleshooting task to figure out why no passwords are synchronized.

> [!NOTE]
> The troubleshooting task is available only for Microsoft Entra Connect version 1.1.614.0 or later.

### Run the troubleshooting task

To troubleshoot issues where no passwords are synchronized:

1. Open a new Windows PowerShell session on your Microsoft Entra Connect server with the **Run as Administrator** option.

2. Run `Set-ExecutionPolicy RemoteSigned` or `Set-ExecutionPolicy Unrestricted`.

3. Start the Microsoft Entra Connect wizard.

4. Navigate to the **Additional Tasks** page, select **Troubleshoot**, and select **Next**.

5. On the Troubleshooting page, select **Launch** to start the troubleshooting menu in PowerShell.

6. In the main menu, select **Troubleshoot password hash synchronization**.

7. In the sub menu, select **Password hash synchronization does not work at all**.

### Understand the results of the troubleshooting task

The troubleshooting task performs the following checks:

* Validates that the password hash synchronization feature is enabled for your Microsoft Entra tenant.

* Validates that the Microsoft Entra Connect server isn't in staging mode.

* For each existing on-premises Active Directory connector (which corresponds to an existing Active Directory forest):

   * Validates that the password hash synchronization feature is enabled.
   
   * Searches for password hash synchronization heartbeat events in the Windows Application Event logs.

   * For each Active Directory domain under the on-premises Active Directory connector:

      * Validates that the domain is reachable from the Microsoft Entra Connect server.

      * Validates that the Active Directory Domain Services (AD DS) accounts used by the on-premises Active Directory connector has the correct username, password, and permissions required for password hash synchronization.

The following diagram illustrates the results of the cmdlet for a single-domain, on-premises Active Directory topology:

![Diagnostic output for password hash synchronization](./media/tshoot-connect-password-hash-synchronization/phsglobalgeneral.png)

The rest of this section describes specific results that are returned by the task and corresponding issues.

#### Password hash synchronization feature isn't enabled

If you haven't enabled password hash synchronization by using the Microsoft Entra Connect wizard, the following error is returned:

![password hash synchronization isn't enabled](./media/tshoot-connect-password-hash-synchronization/phsglobaldisabled.png)

<a name='azure-ad-connect-server-is-in-staging-mode'></a>

#### Microsoft Entra Connect server is in staging mode

If the Microsoft Entra Connect server is in staging mode, password hash synchronization is temporarily disabled, and the following error is returned:

![Microsoft Entra Connect server is in staging mode](./media/tshoot-connect-password-hash-synchronization/phsglobalstaging.png)

#### No password hash synchronization heartbeat events

Each on-premises Active Directory connector has its own password hash synchronization channel. When the password hash synchronization channel is established and there aren't any password changes to be synchronized, a heartbeat event (EventId 654) is generated once every 30 minutes under the Windows Application Event Log. For each on-premises Active Directory connector, the cmdlet searches for corresponding heartbeat events in the past three hours. If no heartbeat event is found, the following error is returned:

![No password hash synchronization heart beat event](./media/tshoot-connect-password-hash-synchronization/phsglobalnoheartbeat.png)

#### AD DS account does not have correct permissions

If the AD DS account that's used by the on-premises Active Directory connector to synchronize password hashes does not have the appropriate permissions, the following error is returned:

![Screenshot that shows the error that's returned when the AD DS account has an incorrect username or password.](./media/tshoot-connect-password-hash-synchronization/phsglobalaccountincorrectpermission.png)

#### Incorrect AD DS account username or password

If the AD DS account used by the on-premises Active Directory connector to synchronize password hashes has an incorrect username or password, the following error is returned:

![Incorrect credential](./media/tshoot-connect-password-hash-synchronization/phsglobalaccountincorrectcredential.png)



## One object isn't synchronizing passwords: troubleshoot by using the troubleshooting task

You can use the troubleshooting task to determine why one object isn't synchronizing passwords.

> [!NOTE]
> The troubleshooting task is available only for Microsoft Entra Connect version 1.1.614.0 or later.

### Run the diagnostics cmdlet

To troubleshoot issues for a specific user object:

1. Open a new Windows PowerShell session on your Microsoft Entra Connect server with the **Run as Administrator** option.

2. Run `Set-ExecutionPolicy RemoteSigned` or `Set-ExecutionPolicy Unrestricted`.

3. Start the Microsoft Entra Connect wizard.

4. Navigate to the **Additional Tasks** page, select **Troubleshoot**, and select **Next**.

5. On the Troubleshooting page, select **Launch** to start the troubleshooting menu in PowerShell.

6. In the main menu, select **Troubleshoot password hash synchronization**.

7. In the sub menu, select **Password isn't synchronized for a specific user account**.

### Understand the results of the troubleshooting task

The troubleshooting task performs the following checks:

* Examines the state of the Active Directory object in the Active Directory connector space, Metaverse, and Microsoft Entra connector space.

* Validates that there are synchronization rules with password hash synchronization enabled and applied to the Active Directory object.

* Attempts to retrieve and display the results of the last attempt to synchronize the password for the object.

The following diagram illustrates the results of the cmdlet when troubleshooting password hash synchronization for a single object:

![Diagnostic output for password hash synchronization - single object](./media/tshoot-connect-password-hash-synchronization/phssingleobjectgeneral.png)

The rest of this section describes specific results returned by the cmdlet and corresponding issues.

<a name='the-active-directory-object-isnt-exported-to-azure-ad'></a>

#### The Active Directory object isn't exported to Microsoft Entra ID

password hash synchronization for this on-premises Active Directory account fails because there's no corresponding object in the Microsoft Entra tenant. The following error is returned:

![Microsoft Entra object is missing](./media/tshoot-connect-password-hash-synchronization/phssingleobjectnotexported.png)

#### User has a temporary password

Older versions of Microsoft Entra Connect did not support synchronizing temporary passwords with Microsoft Entra ID. A password is considered to be temporary if the **Change password at next logon** option is set on the on-premises Active Directory user. The following error is returned with these older versions:

![Temporary password isn't exported](./media/tshoot-connect-password-hash-synchronization/phssingleobjecttemporarypassword.png)

To enable synchronizations of temporary passwords you must have Microsoft Entra Connect version 2.0.3.0 or higher installed and the feature [ForcePasswordChangeOnLogon](../connect/how-to-connect-password-hash-synchronization.md#synchronizing-temporary-passwords-and-force-password-change-on-next-logon) must be enabled.

#### Results of last attempt to synchronize password aren't available

By default, Microsoft Entra Connect stores the results of password hash synchronization attempts for seven days. If there are no results available for the selected Active Directory object, the following warning is returned:

![Diagnostic output for single object - no password sync history](./media/tshoot-connect-password-hash-synchronization/phssingleobjectnohistory.png)



## No passwords are synchronized: troubleshoot by using the diagnostic cmdlet

You can use the `Invoke-ADSyncDiagnostics` cmdlet to figure out why no passwords are synchronized.

> [!NOTE]
> The `Invoke-ADSyncDiagnostics` cmdlet is available only for Microsoft Entra Connect version 1.1.524.0 or later.

### Run the diagnostics cmdlet

To troubleshoot issues where no passwords are synchronized:

1. Open a new Windows PowerShell session on your Microsoft Entra Connect server with the **Run as Administrator** option.

2. Run `Set-ExecutionPolicy RemoteSigned` or `Set-ExecutionPolicy Unrestricted`.

3. Run `Import-Module ADSyncDiagnostics`.

4. Run `Invoke-ADSyncDiagnostics -PasswordSync`.



## One object isn't synchronizing passwords: troubleshoot by using the diagnostic cmdlet

You can use the `Invoke-ADSyncDiagnostics` cmdlet to determine why one object isn't synchronizing passwords.

> [!NOTE]
> The `Invoke-ADSyncDiagnostics` cmdlet is available only for Microsoft Entra Connect version 1.1.524.0 or later.

### Run the diagnostics cmdlet

To troubleshoot issues where no passwords are synchronized for a user:

1. Open a new Windows PowerShell session on your Microsoft Entra Connect server with the **Run as Administrator** option.

2. Run `Set-ExecutionPolicy RemoteSigned` or `Set-ExecutionPolicy Unrestricted`.

3. Run `Import-Module ADSyncDiagnostics`.

4. Run the following cmdlet:

   ```
   Invoke-ADSyncDiagnostics -PasswordSync -ADConnectorName <Name-of-AD-Connector> -DistinguishedName <DistinguishedName-of-AD-object>
   ```

   For example:

   ```powershell
   Invoke-ADSyncDiagnostics -PasswordSync -ADConnectorName "contoso.com" -DistinguishedName "CN=TestUserCN=Users,DC=contoso,DC=com"
   ```



## No passwords are synchronized: manual troubleshooting steps

Follow these steps to determine why no passwords are synchronized:

1. Is the Connect server in [staging mode](how-to-connect-sync-staging-server.md)? A server in staging mode does not synchronize any passwords.

1. Run the script in the [Get the status of password sync settings](#get-the-status-of-password-sync-settings) section. It gives you an overview of the password sync configuration.  

    ![PowerShell script output from password sync settings](./media/tshoot-connect-password-hash-synchronization/psverifyconfig.png)  
   
3. If the feature isn't enabled in Microsoft Entra ID or if the sync channel status isn't enabled, run the Connect installation wizard. Select **Customize synchronization options**, and unselect password sync. This change temporarily disables the feature. Then run the wizard again and re-enable password sync. Run the script again to verify that the configuration is correct.

4. Look in the event log for errors. Look for the following events, which would indicate a problem:
    
    Source: "Directory synchronization"  
    ID: 0, 611, 652, 655

    If you see these events, you have a connectivity problem. The event log message contains forest information where you have a problem.

5. If you see no heartbeat or if nothing else worked, run [Trigger a full sync of all passwords](#trigger-a-full-sync-of-all-passwords). Run the script only once.

6. See the Troubleshoot one object that isn't synchronizing passwords section.

### Connectivity problems

Do you have connectivity with Microsoft Entra ID?

Does the account have required permissions to read the password hashes in all domains? If you installed Connect by using Express settings, the permissions should already be correct. 

If you used custom installation, set the permissions manually by doing the following:
    
1. To find the account used by the Active Directory connector, start **Synchronization Service Manager**. 
 
2. Go to **Connectors**, and then search for the on-premises Active Directory forest you are troubleshooting. 
 
3. Select the connector, and then select **Properties**. 
 
1. Go to **Connect to Active Directory Forest**.  

    ![Account used by Active Directory connector](./media/tshoot-connect-password-hash-synchronization/connectoraccount.png)  
       Note the username and the domain where the account is located.
 
5. Start **Active Directory Users and Computers**, and then verify that the account you found earlier has the following permissions set at the root of all domains in your forest:
    * Replicate Directory Changes
    * Replicate Directory Changes All

1. Are the domain controllers reachable by Microsoft Entra Connect? If the Connect server cannot connect to all domain controllers, configure **Only use preferred domain controller**.  

    ![Domain controller used by Active Directory connector](./media/tshoot-connect-password-hash-synchronization/preferreddc.png)  
   
7. Go back to **Synchronization Service Manager** and **Configure Directory Partition**. 
 
8. Select your domain in **Select directory partitions**, select the **Only use preferred domain controllers** check box, and then select **Configure**. 

9. In the list, enter the domain controllers that Connect should use for password sync. The same list is used for import and export as well. Do these steps for all your domains.

> [!NOTE]
> To apply these changes, restart the **Microsoft Entra ID Sync** (ADSync) service.

10. If the script shows that there's no heartbeat, run the script in [Trigger a full sync of all passwords](#trigger-a-full-sync-of-all-passwords).

## One object isn't synchronizing passwords: manual troubleshooting steps

You can easily troubleshoot password hash synchronization issues by reviewing the status of an object.

1. In **Active Directory Users and Computers**, search for the user, and then verify that the **User must change password at next logon** check box is cleared.  

    ![Active Directory productive passwords](./media/tshoot-connect-password-hash-synchronization/adprodpassword.png)  
   
       If the check box is selected, ask the user to sign in and change the password. Temporary passwords aren't synchronized with Microsoft Entra ID.

1. If the password looks correct in Active Directory, follow the user in the sync engine. By following the user from on-premises Active Directory to Microsoft Entra ID, you can see whether there's a descriptive error on the object.

    a. Start the [Synchronization Service Manager](how-to-connect-sync-service-manager-ui.md).

    b. Select **Connectors**.

    c. Select the **Active Directory Connector** where the user is located.

    d. Select **Search Connector Space**.

    e. In the **Scope** box, select **DN or Anchor**, and then enter the full DN of the user you are troubleshooting.

    ![Search for user in connector space with DN](./media/tshoot-connect-password-hash-synchronization/searchcs.png)  
   
       f. Locate the user you are looking for, and then select **Properties** to see all the attributes. If the user isn't in the search result, verify your [filtering rules](how-to-connect-sync-configure-filtering.md) and make sure that you run [Apply and verify changes](how-to-connect-sync-configure-filtering.md#apply-and-verify-changes) for the user to appear in Connect.

       g. To see the password sync details of the object for the past week, select **Log**.  

    ![Object log details](./media/tshoot-connect-password-hash-synchronization/csobjectlog.png)  
   
       If the object log is empty, Microsoft Entra Connect has been unable to read the password hash from Active Directory. Continue your troubleshooting with Connectivity Errors. If you see any other value than **success**, refer to the table in [Password sync log](#password-sync-log).

       h. Select the **lineage** tab, and make sure that at least one sync rule in the **PasswordSync** column is **True**. In the default configuration, the name of the sync rule is **In from AD - User AccountEnabled**.  

    ![Lineage information about a user](./media/tshoot-connect-password-hash-synchronization/cspasswordsync.png)  
   
       i. Select **Metaverse Object Properties** to display a list of user attributes.  

    ![Screenshot that shows the list of user attributes for the Metaverse Object Properties.](./media/tshoot-connect-password-hash-synchronization/mvpasswordsync.png)  
   
       Verify that there's no **cloudFiltered** attribute present. Make sure that the domain attributes (domainFQDN and domainNetBios) have the expected values.

       j. Select the **Connectors** tab. Make sure that you see connectors to both on-premises Active Directory and Microsoft Entra ID.

    ![Metaverse information](./media/tshoot-connect-password-hash-synchronization/mvconnectors.png)  
   
       k. Select the row that represents Microsoft Entra ID, select **Properties**, and then select the **Lineage** tab. The connector space object should have an outbound rule in the **PasswordSync** column set to **True**. In the default configuration, the name of the sync rule is **Out to Microsoft Entra ID - User Join**.  

    ![Connector Space Object Properties dialog box](./media/tshoot-connect-password-hash-synchronization/cspasswordsync2.png)  
   
### Password Hash Sync log

The status column can have the following values:

| Status | Description |
| --- | --- |
| Success |Password has been successfully synchronized. |
| FilteredByTarget |Password is set to **User must change password at next logon**. Password hasn't been synchronized. |
| NoTargetConnection |No object in the metaverse or in the Microsoft Entra connector space. |
| SourceConnectorNotPresent |No object found in the on-premises Active Directory connector space. |
| TargetNotExportedToDirectory |The object in the Microsoft Entra connector space hasn't yet been exported. |
| MigratedCheckDetailsForMoreInfo |Log entry was created before build 1.0.9125.0 and is shown in its legacy state. |
| Error |Service returned an unknown error. |
| Unknown |An error occurred while trying to process a batch of password hashes.  |
| MissingAttribute |Specific attributes (for example, Kerberos hash) required by Microsoft Entra Domain Services aren't available. |
| RetryRequestedByTarget |Specific attributes (for example, Kerberos hash) required by Microsoft Entra Domain Services weren't available previously. An attempt to resynchronize the user's password hash is made. |

## Windows Event Viewer Logs for Password Hash Sync

The Password Hash Synchronization feature generates a comprehensive set of application events in the Windows Event Viewer, capturing most of its operational activity.

For effective troubleshooting, consider increasing the size of the Application log. Without this adjustment, PHS events may be overwritten, making it difficult to track synchronization status and diagnose issues.


| Event ID | Description                                                                                                            |
| -------- | ---------------------------------------------------------------------------------------------------------------------- |
| 601      | Event id used when password synchronization manager is starting.                                                       |
| 602      | Event id used when password synchronization is stopping.                                                               |
| 603      | Event id used when an unexpected error occurs.                                                                         |
| 604      | Event id used when an task error occurs.                                                                               |
| 605      | Event id used when an items are added to the retry queue.                                                              |
| 606      | Event id used when an items are removed from the retry queue.                                                          |
| 607      | Event id used when password sync is not able to start.                                                                 |
| 609      | Event id used when password sync has stopped.                                                                          |
| 610      | Event id used when password sync cannot stop.                                                                          |
| 611      | Event id used when error synchronizing a domain.                                                                       |
| 612      | Event id used when error initializing a synchronization context.                                                       |
| 613      | Event identifier used to notify that password sync agent has paused because directory full sync has not yet completed. |
| 614      | Event id used when password sync start is called when not shutdown.                                                    |
| 615      | Event id used when password sync worker thread throws an exception.                                                    |
| 616      | Event id used when connection to preferred DC fails.                                                                   |
| 617      | Event id used when full password synchronization started for forest.                                                   |
| 618      | Event id used when full password synchronization started for a domain.                                                 |
| 619      | Event id used to indicate the progress of the password synchronization for a domain.                                   |
| 620      | Event id used when the no-retry password sync objects are reported.                                                    |
| 621      | Event id used when an attempt to full password synchronization fails.                                                  |
| 622      | Event id used when full password synchronization completed for a domain.                                               |
| 623      | Event id used when full password synchronization completed for a forest.                                               |
| 650      | Start of Password Sync batch.                                                                                          |
| 651      | End of Password Sync batch.                                                                                            |
| 652      | Error during Password Sync.                                                                                            |
| 653      | Start of Password Sync ping.                                                                                           |
| 654      | End of Password Sync ping.                                                                                             |
| 655      | Error during Password Sync ping.                                                                                       |
| 656      | Password sync request message.                                                                                         |
| 657      | Password sync response message.                                                                                        |
| 658      | DCaaS sync event log message.                                                                                          |
| 659      | Password policy sync event log message.                                                                                |
| 660      | Event Id for start of self-healing the password hash sync company feature.                                             |
| 661      | Event Id for end of self-healing the password hash sync company feature.                                               |
| 662      | Event Id used when password sync health task fails during ping operation.                                              |
| 663      | Event Id used to indicate that password sync manager is alive and running.                                             |
| 664      | Event Id used to indicate that single object password sync failed.                                                     |
| 665      | Event Id used to indicate that storing password hash sync cycle state for a domain failed.                             |
| 666      | Event id used to indicate that password hash sync failed for a domain due to sql deadlock.                             |
| 667      | Event Id used to indicate that generating MD5 decryption key has failed.                                               |
| 668      | Event id used to show the number of objects in password batch that only have PwdLastSet changed.                       |


## Scripts to help troubleshooting

### Get the status of password sync settings

```powershell
Import-Module ADSync
$connectors = Get-ADSyncConnector
$aadConnectors = $connectors | Where-Object {$_.SubType -eq "Windows Azure Active Directory (Microsoft)"}
$adConnectors = $connectors | Where-Object {$_.ConnectorTypeName -eq "AD"}
if ($aadConnectors -ne $null -and $adConnectors -ne $null)
{
    if ($aadConnectors.Count -eq 1)
    {
        $features = Get-ADSyncAADCompanyFeature
        Write-Host
        Write-Host "Password sync feature enabled in your Azure AD directory: "  $features.PasswordHashSync
        foreach ($adConnector in $adConnectors)
        {
            Write-Host
            Write-Host "Password sync channel status BEGIN ------------------------------------------------------- "
            Write-Host
            Get-ADSyncAADPasswordSyncConfiguration -SourceConnector $adConnector.Name
            Write-Host
            $pingEvents =
                Get-EventLog -LogName "Application" -Source "Directory Synchronization" -InstanceId 654  -After (Get-Date).AddHours(-3) |
                    Where-Object { $_.Message.ToUpperInvariant().Contains($adConnector.Identifier.ToString("D").ToUpperInvariant()) } |
                    Sort-Object { $_.Time } -Descending
            if ($pingEvents -ne $null)
            {
                Write-Host "Latest heart beat event (within last 3 hours). Time " $pingEvents[0].TimeWritten
            }
            else
            {
                Write-Warning "No ping event found within last 3 hours."
            }
            Write-Host
            Write-Host "Password sync channel status END ------------------------------------------------------- "
            Write-Host
        }
    }
    else
    {
        Write-Warning "More than one Azure AD Connectors found. Please update the script to use the appropriate Connector."
    }
}
Write-Host
if ($aadConnectors -eq $null)
{
    Write-Warning "No Azure AD Connector was found."
}
if ($adConnectors -eq $null)
{
    Write-Warning "No AD DS Connector was found."
}
Write-Host
```

#### Trigger a full sync of all passwords

> [!NOTE]
> Run this script only once. If you need to run it more than once, something else is the problem. To troubleshoot the problem, contact Microsoft support.

You can trigger a full sync of all passwords by using the following script:

1. Assign the local Active Directory **$adConnector** value
   
    ```$adConnector = "<CASE SENSITIVE AD CONNECTOR NAME>"```

2. Assign the AzureAD **$aadConnector** value
   
    ```$aadConnector = "<CASE SENSITIVE AAD CONNECTOR NAME>"```

3. Install the AzureAD Sync Module
   
   ```Import-Module adsync```

4. Create a new Force Full Password Sync configuration parameter object
   
    ```$c = Get-ADSyncConnector -Name $adConnector```

5. Update the existing connector with the following new configurations. Run each line separately
   
   a.  ```$p = New-Object Microsoft.IdentityManagement.PowerShell.ObjectModel.ConfigurationParameter "Microsoft.Synchronize.ForceFullPasswordSync", String, ConnectorGlobal, $null,   $null, $null```

    b. ```$p.Value = 1```
  
    c. ```$c.GlobalParameters.Remove($p.Name)```

    d. ```$c.GlobalParameters.Add($p)```

    e. ```$c = Add-ADSyncConnector -Connector $c```

6. Disable Entra ID Connect
    
    ```Set-ADSyncAADPasswordSyncConfiguration -SourceConnector $adConnector -TargetConnector $aadConnector -Enable $false```

7. Enable Entra ID Connect to force full password synchronization

     ```Set-ADSyncAADPasswordSyncConfiguration -SourceConnector $adConnector -TargetConnector $aadConnector -Enable $true```

## Next steps

* [Implementing password hash synchronization with Microsoft Entra Connect Sync](how-to-connect-password-hash-synchronization.md)
* [Microsoft Entra Connect Sync: Customizing synchronization options](how-to-connect-sync-whatis.md)
* [Integrating your on-premises identities with Microsoft Entra ID](../whatis-hybrid-identity.md)
