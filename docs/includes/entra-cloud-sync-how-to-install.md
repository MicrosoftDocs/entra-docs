---
title: include file
description: include file

author: billmath
ms.service: entra-id
ms.topic: include
ms.date: 11/11/2022
ms.author: billmath
ms.custom: include file
---

 1.  In the Azure portal, select **Microsoft Entra ID**.
 2.  On the left, select **Microsoft Entra Connect**.
 3.  On the left, select **Cloud sync**.
 
 :::image type="content" source="media/entra-cloud-sync-how-to-install/new-ux-1.png" alt-text="Screenshot of new UX screen." lightbox="media/entra-cloud-sync-how-to-install/new-ux-1.png":::

 4. On the left, select **Agent**.
 5. Select **Download on-premises agent**, and select **Accept terms & download**.
 
 :::image type="content" source="media/entra-cloud-sync-how-to-install/new-ux-2.png" alt-text="Screenshot of download agent." lightbox="media/entra-cloud-sync-how-to-install/new-ux-2.png":::

 6. Once the **Microsoft Entra Connect Provisioning Agent Package** is downloaded, run the *AADConnectProvisioningAgentSetup.exe* installation file from your downloads folder.
   >[!NOTE]
   >When installing for the US Government Cloud use:  
   >*AADConnectProvisioningAgentSetup.exe ENVIRONMENTNAME=AzureUSGovernment*  
   >See "[Install an agent in the US government cloud](~/identity/hybrid/cloud-sync/how-to-install.md#install-an-agent-in-the-us-government-cloud)" for more information.

 7. On the splash screen, select **I agree to the license and conditions**, and then select **Install**.

 :::image type="content" source="media/entra-cloud-sync-how-to-install/azure-ad-cloud-sync-splash-screen.png" alt-text="Screenshot that shows the Microsoft Entra Connect Provisioning Agent Package splash screen." lightbox="media/entra-cloud-sync-how-to-install/new-ux-2.png":::
 

 8. Once the installation operation completes, the configuration wizard launches. Select **Next** to start the configuration.
 :::image type="content" source="media/entra-cloud-sync-how-to-install/new-ux-3.png" alt-text="Screenshot of the welcome screen." lightbox="media/entra-cloud-sync-how-to-install/new-ux-3.png":::
 9. On the **Select Extension** screen, select **HR-driven provisioning (Workday and SuccessFactors) / Microsoft Entra Connect cloud sync** and select **Next**.
 :::image type="content" source="media/entra-cloud-sync-how-to-install/new-ux-5.png" alt-text="Screenshot of the select extensions screen." lightbox="media/entra-cloud-sync-how-to-install/new-ux-5.png":::

 >[!NOTE]
 >If you are installing the provisioning agent for use with [on-premsise app provisioning](~/identity/app-provisioning/on-premises-application-provisioning-architecture.md) then select On-premises application provisioning (Microsoft Entra ID to application).

 10. Sign in with an account with at least the [Hybrid Identity Administrator](/entra/identity/role-based-access-control/permissions-reference#hybrid-identity-administrator) role. If you have Internet Explorer enhanced security enabled, it blocks the sign-in. If so, close the installation, [disable Internet Explorer enhanced security](/troubleshoot/developer/browsers/security-privacy/enhanced-security-configuration-faq), and restart the **Microsoft Entra Connect Provisioning Agent Package**  installation.

 :::image type="content" source="media/entra-cloud-sync-how-to-install/azure-ad-cloud-sync-sign-in-to-azure.png" alt-text="Screenshot of the Connect Microsoft Entra ID screen."  lightbox="media/entra-cloud-sync-how-to-install/azure-ad-cloud-sync-sign-in-to-azure.png":::


 11. On the **Configure Service Account** screen, select a group Managed Service Account (gMSA). This account is used to run the agent service. If a managed service account is already configured in your domain by another agent and you're installing a second agent, select **Create gMSA** because the system detects the existing account and adds the required permissions for the new agent to use the gMSA account. When prompted, choose either:

   - **Create gMSA** which lets the agent create the **provAgentgMSA$** managed service account for you. The group managed service account (for example, CONTOSO\provAgentgMSA$) will be created in the same Active Directory domain where the host server has joined. To use this option, enter the Active Directory domain administrator credentials (recommended).
  - **Use custom gMSA** and provide the name of the managed service account that you have manually created for this task.

  To continue, select **Next**.

 :::image type="content" source="media/entra-cloud-sync-how-to-install/azure-ad-cloud-sync-configure-service-account.png" alt-text="Screenshot of the Configure Service Account screen." lightbox="media/entra-cloud-sync-how-to-install/azure-ad-cloud-sync-configure-service-account.png":::

 12. On the **Connect Active Directory** screen, if your domain name appears under **Configured domains**, skip to the next step. Otherwise, type your Active Directory domain name, and select **Add directory**.  



 13. Sign in with your Active Directory domain administrator account. The domain administrator account shouldn't have an expired password. In case the password is expired or changes during the agent installation, you need to reconfigure the agent with the new credentials. This operation adds your on-premises directory. Select **OK**, then select **Next** to continue. 

 :::image type="content" source="media/entra-cloud-sync-how-to-install/azure-ad-cloud-sync-sign-in-to-entra.png" alt-text="Screenshot that shows how to enter the domain admin credentials."  lightbox="media/entra-cloud-sync-how-to-install/azure-ad-cloud-sync-sign-in-to-entra.png":::

 14. The following screenshot shows an example of contoso.com configured domain. Select **Next** to continue.

 :::image type="content" source="media/entra-cloud-sync-how-to-install/azure-ad-cloud-sync-configured-domains.png" alt-text="Screenshot of the Connect Active Directory screen."  lightbox="media/entra-cloud-sync-how-to-install/azure-ad-cloud-sync-configured-domains.png":::

 15. On the **Configuration complete** screen, select **Confirm**. This operation registers and restarts the agent.
 
 16. Once this operation completes, you should be notified that **Your agent configuration was successfully verified.**  You can select **Exit**.

 :::image type="content" source="media/entra-cloud-sync-how-to-install/azure-ad-cloud-sync-confirm-screen.png" alt-text="Screenshot that shows the finish screen."  lightbox="media/entra-cloud-sync-how-to-install/azure-ad-cloud-sync-confirm-screen.png":::
 
 17. If you still get the initial splash screen, select **Close**.
