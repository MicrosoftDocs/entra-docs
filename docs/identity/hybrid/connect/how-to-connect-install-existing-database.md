---
title: 'Install Microsoft Entra Connect by using an existing ADSync database'
description: This topic describes how to use an existing ADSync database.

author: billmath
manager: femila
ms.reviewer: cychua
ms.service: entra-id
ms.tgt_pltfrm: na
ms.topic: how-to
ms.date: 04/09/2025
ms.subservice: hybrid-connect
ms.author: billmath

---

# Install Microsoft Entra Connect using an existing ADSync database
Microsoft Entra Connect requires a SQL Server database to store data. You can either use the default SQL Server 2019 Express LocalDB installed with Microsoft Entra Connect or use your own full version of SQL. Previously, when you installed Microsoft Entra Connect, a new database named ADSync was always created. With Microsoft Entra Connect version 1.1.613.0 (or later), you can install Microsoft Entra Connect by linking it to an existing ADSync database.

## Benefits of using an existing ADSync database
By pointing to an existing ADSync database:

- Except for credentials information, the synchronization configuration stored in the ADSync database is automatically recovered and used during installation. This includes custom synchronization rules, connectors, filtering, and optional features configuration.
- All the identity data (associated with connector spaces and metaverse) and synchronization cookies stored in the ADSync database are also recovered. The newly installed Microsoft Entra Connect server can continue to synchronize from where the previous Microsoft Entra Connect server left off, instead of having the need to perform a full sync.

## Scenarios where using an existing ADSync database is beneficial
These benefits are useful in the following scenarios:


- You have an existing Microsoft Entra Connect deployment. Your existing Microsoft Entra Connect server is no longer working but the SQL server containing the ADSync database is still functioning. You can install a new Microsoft Entra Connect server and point it to the existing ADSync database. 
- You have an existing Microsoft Entra Connect deployment. Your SQL server containing the ADSync database is no longer functioning. However, you have a recent backup of the database. You can restore the ADSync database to a new SQL server first. After which, you can install a new Microsoft Entra Connect server and point it to the restored ADSync database.
- You have an existing Microsoft Entra Connect deployment that is using LocalDB. Due to the 10-GB limit imposed by LocalDB, you would like to migrate to full SQL. You can back up the ADSync database from LocalDB and restore it to a SQL server. After which, you can reinstall a new Microsoft Entra Connect server and point it to the restored ADSync database.
- You are trying to set up a staging server and wants to make sure its configuration matches that of the current active server. You can back up the ADSync database and restore it to another SQL server. After which, you can reinstall a new Microsoft Entra Connect server and point it to the restored ADSync database.

## Prerequisite information

Important notes to take note of before you proceed:

- Make sure to review the pre-requisites for installing Microsoft Entra Connect at Hardware and prerequisites, and account and permissions required for installing Microsoft Entra Connect. The permissions required for installing Microsoft Entra Connect using “use existing database” mode is the same as “custom” installation.
- Deploying Microsoft Entra Connect against an existing ADSync database is only supported with full SQL. It isn't supported with SQL Express LocalDB. If you have an existing ADSync database in LocalDB that you wish to use, you must first back up the ADSync database (LocalDB). Then, restore it to full SQL. Next, you can deploy Microsoft Entra Connect against the restored database using this method.
- The version of the Microsoft Entra Connect used for installation must satisfy the following criteria:
	- 1.1.613.0 or higher, AND
	- Same or higher than the version of the Microsoft Entra Connect last used with the ADSync database. If the Microsoft Entra Connect version used for installation is higher than the version last used with the ADSync database, then a full sync may be required. Full sync is required if there are schema or sync rule changes between the two versions. 
- The ADSync database used should contain a synchronization state that is relatively recent. The last synchronization activity with the existing ADSync database should be within the last three weeks, otherwise a full import from Microsoft Entra ID is required to update the directory watermark.
- When installing Microsoft Entra Connect using “use existing database” method, sign-in method configured on the previous Microsoft Entra Connect server isn't preserved. Further, you can't configure sign-in method during installation. You can only configure sign-in method after installation is complete.
- You can't have multiple Microsoft Entra Connect servers share the same ADSync database. The “use existing database” method allows you to reuse an existing ADSync database with a new Microsoft Entra Connect server. It doesn't support sharing.

<a name='steps-to-install-azure-ad-connect-with-use-existing-database-mode'></a>

## Steps to install Microsoft Entra Connect with “use existing database” mode
1. Download Microsoft Entra Connect installer (AzureADConnect.MSI) to the Windows server. Double-select the Microsoft Entra Connect installer to start installing Microsoft Entra Connect.
2. Once the MSI installation completes, the Microsoft Entra Connect wizard starts with the Express mode setup. Close the screen by selecting the Exit icon.
![Screenshot that shows the "Welcome to Microsoft Entra Connect" page, with "Express Settings" in the left-side menu highlighted.](./media/how-to-connect-install-existing-database/db1.png)
3. Start a new command prompt or PowerShell session. Navigate to folder "C:\Program Files\Microsoft Azure Active Directory Connect". Run command .\AzureADConnect.exe /useexistingdatabase to start the Microsoft Entra Connect wizard in “Use existing database” setup mode.

> [!NOTE]
> Use the switch **/UseExistingDatabase** only when the database already contains data from an earlier Microsoft Entra Connect installation. For instance, when you are moving from a local database to a full SQL Server database or when the Microsoft Entra Connect server was rebuilt and you restored a SQL backup of the ADSync database from an earlier installation of Microsoft Entra Connect. If the database is empty, that is, it doesn't contain any data from a previous Microsoft Entra Connect installation, skip this step.

![PowerShell](./media/how-to-connect-install-existing-database/db2.png)
1. You are greeted with the Welcome to Microsoft Entra Connect screen. Once you agree to the license terms and privacy notice, select **Continue**.
   ![Screenshot that shows the "Welcome to Microsoft Entra Connect" page](./media/how-to-connect-install-existing-database/db3.png)
1. On the **Install required components** screen, the **Use an existing SQL Server** option is enabled. Specify the name of the SQL server that is hosting the ADSync database. If the SQL engine instance used to host the ADSync database isn't the default instance on the SQL server, you must specify the SQL engine instance name. Further, if SQL browsing isn't enabled, you must also specify the SQL engine instance port number. For example:         
   ![Screenshot that shows the "Install required components" page.](./media/how-to-connect-install-existing-database/db4.png)           

1. On the **Connect to Microsoft Entra ID** screen, you must provide the credentials of a Hybrid Identity Administrator of your Microsoft Entra directory. The recommendation is to use an account in the default onmicrosoft.com domain. This account is only used to create a service account in Microsoft Entra ID and isn't used after the wizard completes.
   ![Connect](./media/how-to-connect-install-existing-database/db5.png)
 
1. On the **Connect your directories** screen, the existing AD forest configured for directory synchronization is listed with a red cross icon beside it. To synchronize changes from an on-premises AD forest, an AD DS account is required. The Microsoft Entra Connect wizard is unable to retrieve the credentials of the AD DS account stored in the ADSync database. This is because the credentials are encrypted and can only be decrypted by the previous Microsoft Entra Connect server. Select **Change Credentials** to specify the AD DS account for the AD forest.
   ![Directories](./media/how-to-connect-install-existing-database/db6.png)
 
1. In the pop-up dialog, you can either (i) provide an Enterprise Admin credential and let Microsoft Entra Connect create the AD DS account for you, or (ii) create the AD DS account yourself and provide its credential to Microsoft Entra Connect. Once you've selected an option and provide the necessary credentials, select **OK** to close the pop-up dialog.
   ![Screenshot that shows the pop-up dialog "A D forest account" with "Create new A D account" selected.](./media/how-to-connect-install-existing-database/db7.png)
 
1. Once the credentials are provided, the red cross icon is replaced with a green tick icon. Select **Next**.
   ![Screenshot that shows the "Connect your directories" page.](./media/how-to-connect-install-existing-database/db8.png)
 
1. On the **Ready to configure** screen, select **Install**.
   ![Welcome](./media/how-to-connect-install-existing-database/db9.png)
 
1. Once installation completes, the Microsoft Entra Connect server is automatically enabled for Staging Mode. It's recommended that you review the server configuration and pending exports for unexpected changes before disabling Staging Mode. 

## Post installation tasks
When restoring a database backup created by a version of Microsoft Entra Connect prior to 1.2.65.0, the staging server automatically selects a sign-in method of **Do Not Configure**. While your password hash sync and password writeback preferences are restored, you must subsequently change the sign-in method to match the other policies in effect for your active synchronization server. Failure to complete these steps may prevent users from signing in should this server becomes active.  

Use the following table to verify any additional steps that are required.

|Feature|Steps|
|-----|-----|
|Password Hash Synchronization| the Password Hash Synchronization and Password writeback settings are fully restored for versions of Microsoft Entra Connect starting with 1.2.65.0. If restoring using an older version of Microsoft Entra Connect, review the synchronization option settings for these features to ensure they match your active synchronization server. No other configuration steps should be necessary.|
|Federation with AD FS|Azure authentications continues to use the AD FS policy configured for your active synchronization server. If you use Microsoft Entra Connect to manage your AD FS farm, you can optionally change the sign-in method to AD FS federation. This prepares your standby server to become the active synchronization instance. If device options are enabled on the active synchronization server, configure those options on this server by running the "Configure device options" task.|
|Pass-through authentication and Desktop Single Sign-On|Update the sign in method to match the configuration on your active synchronization server. If you do not follow this procedure before promoting the server to primary, pass-through authentication and Seamless Single Sign-On will be disabled. Additionally, your tenant might be locked out if you do not have password hash sync as a backup sign-in option. When you enable pass-through authentication in staging mode, a new authentication agent will be installed, registered and will run as a high-availability agent which will accept sign in requests.|
|Federation with PingFederate|Azure authentications continues to use the PingFederate policy configured for your active synchronization server. You may optionally change the sign-in method to PingFederate in preparation for your standby server becoming the active synchronization instance. This step may be deferred until you need to federate additional domains with PingFederate.|

## Next steps

- Now that you have Microsoft Entra Connect installed you can [verify the installation and assign licenses](how-to-connect-post-installation.md).
- Learn more about these features, which were enabled with the installation: [Prevent accidental deletes](how-to-connect-sync-feature-prevent-accidental-deletes.md) and [Microsoft Entra Connect Health](how-to-connect-health-sync.md).
- Learn more about these common topics: [scheduler and how to trigger sync](how-to-connect-sync-feature-scheduler.md).
- Learn more about [Integrating your on-premises identities with Microsoft Entra ID](../whatis-hybrid-identity.md).
