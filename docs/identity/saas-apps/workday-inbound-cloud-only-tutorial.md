---
title: Configure Workday inbound provisioning in Microsoft Entra ID
description: Learn how to configure inbound provisioning from Workday to Microsoft Entra ID

author: cmmdesai
manager: femila
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 05/06/2024
ms.author: chmutali

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Workday to Microsoft Entra ID so that I can streamline the user management process and ensure that users have the appropriate access to Workday to Microsoft Entra ID.
---
# Configure Workday to Microsoft Entra user provisioning
The objective of this article is to show the steps you need to perform to provision worker data from Workday into Microsoft Entra ID. 

>[!NOTE]
>Use this article if the users you want to provision from Workday are cloud-only users who don't need an on-premises AD account. If the users require only on-premises AD account or both AD and Microsoft Entra account, then please refer to the article on [configure Workday to Active Directory](workday-inbound-tutorial.md) user provisioning. 

The following video provides a quick overview of the steps involved when planning your provisioning integration with Workday. 

> [!VIDEO https://www.youtube-nocookie.com/embed/TfndXBlhlII]

[!INCLUDE [governance-workday-to-entra.md](~/includes/governance/governance-workday-to-entra.md)]

## Related content

* [Learn more about Microsoft Entra ID and Workday integration scenarios and web service calls](~/identity/app-provisioning/workday-integration-reference.md)
* [Learn more about supported Workday Attributes for inbound provisioning](~/identity/app-provisioning/workday-attribute-reference.md)
* [Learn how to configure Workday Writeback](workday-writeback-tutorial.md)
* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)
* [Learn how to configure single sign-on between Workday and Microsoft Entra ID](workday-tutorial.md)
* [Learn how to export and import your provisioning configurations](~/identity/app-provisioning/export-import-provisioning-configuration.md)
