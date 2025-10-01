---
title: 'Microsoft Entra Connect Sync: Get started by using express settings'
description: Learn how to download, install, and run the setup wizard for Microsoft Entra Connect Sync.
author: omondiatieno
manager: mwongerapk
ms.service: entra-id
ms.tgt_pltfrm: na
ms.topic: how-to
ms.date: 04/09/2025
ms.subservice: hybrid-connect
ms.author: jomondi
ms.custom: sfi-image-nochange
---
# Get started with Microsoft Entra Connect Sync by using express settings

If you have a single-forest topology and use [password hash sync](how-to-connect-password-hash-synchronization.md) for authentication, express settings are a good option to use when you install Microsoft Entra Connect Sync. Express settings  the default option to install Microsoft Entra Connect Sync, and it's used for the most commonly deployed scenario. It's only a few short steps to extend your on-premises directory to the cloud.

Before you start installing Microsoft Entra Connect Sync, [download Microsoft Entra Connect Sync](https://go.microsoft.com/fwlink/?LinkId=615771), and be sure to complete the prerequisite steps in [Microsoft Entra Connect: Hardware and prerequisites](how-to-connect-install-prerequisites.md).

If the express settings installation doesn't match your topology, see [Related articles](#related-articles) for information about other scenarios.



## TLS 1.2 enforcement for Microsoft Entra Connect Sync

Transport Layer Security (TLS) protocol version 1.2 is a cryptography protocol that is designed to provide  secure communications. The TLS protocol aims primarily to provide privacy and data integrity. TLS has gone through many iterations, with version 1.2 being defined in [RFC 5246](https://tools.ietf.org/html/rfc5246). The latest version of Microsoft Entra Connect Sync fully supports using only TLS 1.2 for communications with Microsoft Entra ID. Before installing the latest versions of Microsoft Entra Connect Sync, be sure to enable TLS 1.2.  

:::image type="content" source="media/how-to-connect-install-express/install-10.png" alt-text="Screenshot of TLS warning screen." lightbox="media/how-to-connect-install-express/install-10.png":::

For more information see [TLS 1.2 enforcement for Microsoft Entra Connect Sync](reference-connect-tls-enforcement.md)

<a name='express-installation-of-azure-ad-connect'></a>

## Express installation of Microsoft Entra Connect Sync

 1. Sign in as Local Administrator on the server you want to install Microsoft Entra Connect on. The server you sign in on will be the sync server.
 2. Go to *AzureADConnect.msi* and double-click to open the installation file.
 3. In **Welcome**, select the checkbox to agree to the licensing terms, and then select **Continue**.

   :::image type="content" source="media/how-to-connect-install-express/install-3.png" alt-text="Screenshot that shows the welcome page in the Microsoft Entra Connect Sync installation wizard." lightbox="media/how-to-connect-install-express/install-3.png":::
 
 4. In **Express settings**, select **Use express settings**.

   :::image type="content" source="media/how-to-connect-install-express/install-4.png" alt-text="Screenshot of Express settings." lightbox="media/how-to-connect-install-express/install-4.png":::

 5. In **Connect to Microsoft Entra ID**, enter the username and password of the Hybrid Identity Administrator account, and then select **Next**.
 
  :::image type="content" source="media/how-to-connect-install-express/install-5.png" alt-text="Screenshot that shows the Connect to Microsoft Entra ID page in the installation wizard." lightbox="media/how-to-connect-install-express/install-5.png":::

 6. In **Connect to AD DS**, enter the username and password for an Enterprise Admin account. You can enter the domain part in either NetBIOS or FQDN format, like `FABRIKAM\administrator` or `fabrikam.com\administrator`. Select **Next**.

  :::image type="content" source="media/how-to-connect-install-express/install-6.png" alt-text="Screenshot that shows the Connect to AD DS page in the installation wizard." lightbox="media/how-to-connect-install-express/install-6.png":::

 7. The [Microsoft Entra ID sign-in configuration](plan-connect-user-signin.md#azure-ad-sign-in-configuration) page appears only if you didn't complete the step to [verify your domains](~/fundamentals/add-custom-domain.md) in the [prerequisites](how-to-connect-install-prerequisites.md).

  :::image type="content" source="media/how-to-connect-install-express/install-7.png" alt-text="Screenshot that shows examples of unverified domains in the installation wizard." lightbox="media/how-to-connect-install-express/install-7.png":::

 If you see this page, review each domain that's marked **Not Added** or **Not Verified**. Make sure that those domains have been verified in Microsoft Entra ID. When you've verified your domains, select the **Refresh** icon.

 8. In **Ready to configure**, select **Install**.

   - Optionally in **Ready to configure**, you can clear the **Start the synchronization process as soon as configuration completes** checkbox. You should clear this checkbox if you want to do more configurations, such as to add [filtering](how-to-connect-sync-configure-filtering.md). If you clear this option, the wizard configures sync but leaves the scheduler disabled. The scheduler doesn't run until you enable it manually by [rerunning the installation wizard](how-to-connect-installation-wizard.md).
   - If you leave the **Start the synchronization process when configuration completes** checkbox selected, a full sync of all users, groups, and contacts to Microsoft Entra ID begins immediately.
   - If you have Exchange in your instance of Windows Server Active Directory, you also have the option to enable [Exchange Hybrid deployment](/exchange/exchange-hybrid). Enable this option if you plan to have Exchange mailboxes both in the cloud and on-premises at the same time.

     :::image type="content" source="media/how-to-connect-install-express/install-8.png" alt-text="Screenshot that shows the Ready to configure Microsoft Entra Connect Sync page in the wizard." lightbox="media/how-to-connect-install-express/install-8.png":::

 9. When the installation is finished, select **Exit**.

   :::image type="content" source="media/how-to-connect-install-express/install-9.png" alt-text="Screenshot that shows installation was successful." lightbox="media/how-to-connect-install-express/install-9.png":::

 10. Before you use Synchronization Service Manager or Synchronization Rule Editor, sign out, and then sign in again.

## Related articles

For more information about Microsoft Entra Connect Sync, see these articles:

| Topic | Link |
| --- | --- |
| Microsoft Entra Connect Sync overview | [Integrate your on-premises directories with Microsoft Entra ID](../whatis-hybrid-identity.md) |
| Install by using customized settings | [Custom installation of Microsoft Entra Connect Sync](how-to-connect-install-custom.md) |
| Upgrade from DirSync | [Upgrade from Azure AD Sync tool (DirSync)](how-to-dirsync-upgrade-get-started.md)|
| Accounts used for installation | [More about Microsoft Entra Connect Sync credentials and permissions](reference-connect-accounts-permissions.md) |

## Next steps

- Now that you have Microsoft Entra Connect Sync installed, you can [verify the installation and assign licenses](how-to-connect-post-installation.md).
- Learn more about these features, which were enabled with the installation: [Automatic upgrade](how-to-connect-install-automatic-upgrade.md), [prevent accidental deletes](how-to-connect-sync-feature-prevent-accidental-deletes.md), and [Microsoft Entra Connect Sync Health](how-to-connect-health-sync.md).
- Learn more about the [scheduler and how to trigger sync](how-to-connect-sync-feature-scheduler.md).
- Learn more about [integrating your on-premises identities with Microsoft Entra ID](../whatis-hybrid-identity.md).
