---
title: 'On-demand provisioning - Microsoft Entra ID to Active Directory'
description: This article describes how to use on-demand provisioning when provisioning from Microsoft Entra ID to Active Directory.
author: billmath
manager: femila
ms.service: entra-id
ms.topic: how-to
ms.date: 04/09/2025
ms.subservice: hybrid-cloud-sync
ms.author: billmath
ms.custom: sfi-image-nochange
---



# On-demand provisioning - Microsoft Entra ID to Active Directory
Microsoft Entra Connect cloud sync allows you to test configuration changes, by applying these changes to a group. 

You can use this test to validate and verify that the changes made to the configuration were applied properly and are being correctly synchronized to Microsoft Entra ID. 

The following document guides you through on-demand provisioning with Microsoft Entra Cloud Sync for provisioning from Active Directory to Microsoft Entra ID. If you're looking for information on provisioning from Microsoft Entra ID to AD, see [ On-demand provisioning - Active Directory to Microsoft Entra ID](how-to-on-demand-provision-entra-to-active-directory.md)

The following is true for on-demand group provisioning:
- On-demand provisioning of groups supports updating up to five members at a time.
- On-demand provisioning doesn't support deleting groups that are deleted from Microsoft Entra ID. Those groups don't appear when you search for a group.
- On-demand provisioning doesn't support nested groups that aren't directly assigned to the application.
- The on-demand provisioning request API can only accept a single group with up to five members at a time.


## Verify a group
To use on-demand provisioning, follow these steps:

>[!NOTE]
>When using on-demand provisioning, members aren't automatically provisioned. You need to select which members you wish to test on and there's a five member limit.

 [!INCLUDE [sign in](../../../includes/cloud-sync-sign-in.md)]

 3. Under **Configuration**, select your configuration.
 4. On the left, select **Provision on demand**.
 5. Enter the name of the group in the **Selected group** box
 6. From the **Selected users** section, select some users to test.
 
   :::image type="content" source="media/how-to-configure-entra-to-active-directory/entra-to-ad-10.png" alt-text="Screenshot of adding members." lightbox="media/how-to-configure-entra-to-active-directory/entra-to-ad-10.png":::

 7. Select **Provision**.
 8. You should see the group provisioned.
 
   :::image type="content" source="media/how-to-configure-entra-to-active-directory/entra-to-ad-11.png" alt-text="Screenshot of successful provisioning on demand." lightbox="media/how-to-configure-entra-to-active-directory/entra-to-ad-11.png":::


For more information, see [on-demand provisioning](how-to-on-demand-provision.md).

## Next steps 
- [Group writeback with Microsoft Entra Cloud Sync ](../group-writeback-cloud-sync.md)
- [Govern on-premises Active Directory based apps (Kerberos) using Microsoft Entra ID Governance](govern-on-premises-groups.md)
- [Migrate Microsoft Entra Connect Sync group writeback V2 to Microsoft Entra Cloud Sync](migrate-group-writeback.md)
