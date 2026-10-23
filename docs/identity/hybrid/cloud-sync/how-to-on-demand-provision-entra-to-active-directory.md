---
title: 'On-demand provisioning - Microsoft Entra ID to Active Directory'
description: This article describes how to use on-demand provisioning when provisioning from Microsoft Entra ID to Active Directory.
ms.topic: how-to
ms.date: 08/24/2026
ms.subservice: hybrid-cloud-sync
ms.custom: sfi-image-nochange, msecd-doc-authoring-1023
ai-usage: ai-assisted
---



# On-demand provisioning - Microsoft Entra ID to Active Directory

Microsoft Entra Cloud Sync lets you test configuration changes by applying them to a single user or group before you enable the configuration for all in-scope objects.

Use this test to validate and verify that the changes you made to the configuration were applied properly and that objects are correctly synchronized to Active Directory.

This article covers on-demand provisioning for configurations that provision from Microsoft Entra ID to Active Directory. If you're looking for information about provisioning from Active Directory to Microsoft Entra ID, see [On-demand provisioning - Active Directory to Microsoft Entra ID](how-to-on-demand-provision.md).

The following is true for on-demand group provisioning:
- On-demand provisioning of groups supports updating up to five members at a time.
- On-demand provisioning doesn't support deleting groups that are deleted from Microsoft Entra ID. Those groups don't appear when you search for a group.
- On-demand provisioning doesn't support nested groups that aren't directly assigned to the application.
- The on-demand provisioning request API can only accept a single group with up to five members at a time.


<a name='verify-a-group'></a>

## Verify a user or group

 [!INCLUDE [sign in](../../../includes/cloud-sync-sign-in.md)]

 3. Under **Configuration**, select your configuration.
 4. On the left, select **Provision on demand**.
 5. Select the **Users** or **Groups** tab, depending on which object type you want to test.

    :::image type="content" source="media/how-to-on-demand-provision-entra-to-active-directory/provision-on-demand-users-tab.png" alt-text="Screenshot of the Provision on demand page with the Users and Groups tabs." lightbox="media/how-to-on-demand-provision-entra-to-active-directory/provision-on-demand-users-tab.png":::

Then follow the steps for the object type you selected.

# [Users](#tab/users)

1. In **Select a user**, search for the user by name, and then select the user.

   :::image type="content" source="media/how-to-on-demand-provision-entra-to-active-directory/provision-on-demand-select-user.png" alt-text="Screenshot of a user selected on the Users tab of the Provision on demand page." lightbox="media/how-to-on-demand-provision-entra-to-active-directory/provision-on-demand-select-user.png":::

1. Select **Provision**.

# [Groups](#tab/groups)

1. In **Selected group**, search for the group by name, and then select the group.
1. Under **Selected users**, select **View members only** to choose from the group's current members, or **View all users** to search the whole directory. Then select the members you want to test.

   > [!NOTE]
   > Members aren't provisioned automatically. Select the members you want to test, up to five at a time.

   :::image type="content" source="media/how-to-on-demand-provision-entra-to-active-directory/provision-on-demand-select-group.png" alt-text="Screenshot of a group selected on the Groups tab, with the options for choosing which members to test." lightbox="media/how-to-on-demand-provision-entra-to-active-directory/provision-on-demand-select-group.png":::

1. Select **Provision**.

---

## Review the result

The result lists four steps: importing the object, evaluating it against your scoping filters, matching it against the target system, and performing the action in Active Directory. Select **View details** on any step to see what was evaluated.

A step reports **Success** when it completes, or **Skipped** when there was nothing to do, such as when the object in Active Directory already matches. To run the same test again, select **Retry**. To test a different object, select **Provision another object**.

# [Users](#tab/users)

:::image type="content" source="media/how-to-on-demand-provision-entra-to-active-directory/provision-on-demand-user-result.png" alt-text="Screenshot of the on-demand provisioning result for a user, showing the four steps and their status." lightbox="media/how-to-on-demand-provision-entra-to-active-directory/provision-on-demand-user-result.png":::

# [Groups](#tab/groups)

:::image type="content" source="media/how-to-on-demand-provision-entra-to-active-directory/provision-on-demand-group-result.png" alt-text="Screenshot of the on-demand provisioning result for a group, showing the four steps and their status." lightbox="media/how-to-on-demand-provision-entra-to-active-directory/provision-on-demand-group-result.png":::

---

## Related content

- [Configure Microsoft Entra ID to Active Directory provisioning](how-to-configure-entra-to-active-directory.md)
- [Test and enable provisioning to Active Directory](how-to-test-and-enable-provisioning-entra-to-active-directory.md)
- [Group writeback with Microsoft Entra Cloud Sync](../group-writeback-cloud-sync.md)
- [Govern on-premises Active Directory based apps (Kerberos) using Microsoft Entra ID Governance](govern-on-premises-groups.md)
- [Migrate Microsoft Entra Connect Sync group writeback V2 to Microsoft Entra Cloud Sync](migrate-group-writeback.md)
