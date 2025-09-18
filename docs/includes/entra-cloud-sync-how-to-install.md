---
title: Include file
description: Include file
author: billmath
ms.service: entra-id
ms.topic: include
ms.date: 09/18/2025
ms.author: billmath
ms.custom: include file, sfi-image-nochange
---

1. In the Azure portal, select **Microsoft Entra ID**.
1. On the left pane, select **Microsoft Entra Connect**, and then select **Cloud Sync**.

   :::image type="content" source="media/entra-cloud-sync-how-to-install/new-ux-1.png" alt-text="Screenshot that shows the Get started screen." lightbox="media/entra-cloud-sync-how-to-install/new-ux-1.png":::

1. On the left pane, select **Agents**.
1. Select **Download on-premises agent**, and then select **Accept terms & download**.

   :::image type="content" source="media/entra-cloud-sync-how-to-install/new-ux-2.png" alt-text="Screenshot that shows downloading the agent." lightbox="media/entra-cloud-sync-how-to-install/new-ux-2.png":::

1. After you download the Microsoft Entra Connect Provisioning Agent Package, run the *AADConnectProvisioningAgentSetup.exe* installation file from your downloads folder.

1. On the screen that opens, select the **I agree to the license terms and conditions** checkbox, and then select **Install**.

   :::image type="content" source="media/entra-cloud-sync-how-to-install/azure-ad-cloud-sync-splash-screen.png" alt-text="Screenshot that shows the Microsoft Entra Provisioning Agent Package screen." lightbox="media/entra-cloud-sync-how-to-install/new-ux-2.png":::

1. After the installation finishes, the configuration wizard opens. Select **Next** to start the configuration.

   :::image type="content" source="media/entra-cloud-sync-how-to-install/welcome.png" alt-text="Screenshot that shows the welcome screen." lightbox="media/entra-cloud-sync-how-to-install/welcome.png":::
   
1. Sign in with an account with at least the [Hybrid Identity administrator](/entra/identity/role-based-access-control/permissions-reference#hybrid-identity-administrator) role. If you have Internet Explorer enhanced security enabled, it blocks the sign-in. If so, close the installation, [disable Internet Explorer enhanced security](/troubleshoot/developer/browsers/security-privacy/enhanced-security-configuration-faq), and restart the Microsoft Entra Provisioning Agent Package installation.

   :::image type="content" source="media/entra-cloud-sync-how-to-install/username.png" alt-text="Screenshot that shows the Connect Microsoft Entra ID screen." lightbox="media/entra-cloud-sync-how-to-install/username.png":::

1. If you need to add or remove a domain, enter your credentials again.

   :::image type="content" source="media/entra-cloud-sync-how-to-install/confirm-username.png" alt-text="Screenshot that shows how to enter credentials again." lightbox="media/entra-cloud-sync-how-to-install/confirm-username.png":::

1. On the **Configure Service Account** screen, select a group Managed Service Account (gMSA). This account is used to run the agent service. If a managed service account is already configured in your domain by another agent and you're installing a second agent, select **Create gMSA**. The system detects the existing account and adds the required permissions for the new agent to use the gMSA account. When you're prompted, choose one of two options:

   - **Create gMSA**: Let the agent create the **provAgentgMSA$** managed service account for you. The group managed service account (for example, `CONTOSO\provAgentgMSA$`) is created in the same Active Directory domain where the host server joined. To use this option, enter the Active Directory domain administrator credentials (recommended).
   - **Use custom gMSA**: Provide the name of the managed service account that you manually created for this task.

1. To continue, select **Next**.

1. On the **Connect Active Directory** screen, if your domain name appears under **Configured domains**, skip to the next step. Otherwise, enter your Active Directory domain name, and select **Add directory**.

1. Sign in with your Active Directory domain administrator account. The domain administrator account shouldn't have an expired password. If the password is expired or changes during the agent installation, reconfigure the agent with the new credentials. This operation adds your on-premises directory. Select **OK**, and then select **Next** to continue.

1. Select **Next** to continue.

1. On the **Configuration complete** screen, select **Confirm**. This operation registers and restarts the agent.

1. After the operation finishes, you see a notification that your agent configuration was successfully verified. Select **Exit**.

   :::image type="content" source="media/entra-cloud-sync-how-to-install/finish.png" alt-text="Screenshot that shows the finish screen." lightbox="media/entra-cloud-sync-how-to-install/finish.png":::

1. If you still get the initial screen, select **Close**.
