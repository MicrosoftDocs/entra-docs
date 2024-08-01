---
title: 'Tutorial: Configure Workday for automatic user provisioning with on-premises Active Directory'
description: Learn how to configure Microsoft Entra ID to automatically provision and de-provision user accounts to Workday.

author: cmmdesai
manager: amycolannino
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: tutorial
ms.date: 05/22/2024
ms.author: chmutali

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Workday to Active Directory so that I can streamline the user management process and ensure that users have the appropriate access to Workday to Active Directory.
---
# Tutorial: Configure Workday for automatic user provisioning

The objective of this tutorial is to show the steps you need to perform to provision worker profiles from Workday into on-premises Active Directory (AD).

>[!NOTE]
>Use this tutorial, if the users you want to provision from Workday need an on-premises AD account and a Microsoft Entra account. 
>* If the users from Workday only need Microsoft Entra account (cloud-only users), then please refer to the tutorial on [configure Workday to Microsoft Entra ID](workday-inbound-cloud-only-tutorial.md) user provisioning. 
>* To configure writeback of attributes such as email address, username and phone number from Microsoft Entra ID to Workday, please refer to the tutorial on [configure Workday writeback](workday-writeback-tutorial.md).

The following video provides a quick overview of the steps involved when planning your provisioning integration with Workday. 

> [!VIDEO https://www.youtube-nocookie.com/embed/TfndXBlhlII]

[!INCLUDE [governance-workday-to-active-directory.md](~/includes/governance/governance-workday-to-active-directory.md)]

## Next steps

* [Learn more about Microsoft Entra ID and Workday integration scenarios and web service calls](~/identity/app-provisioning/workday-integration-reference.md)
* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)
* [Learn how to configure single sign-on between Workday and Microsoft Entra ID](workday-tutorial.md)
* [Learn how to configure Workday Writeback](workday-writeback-tutorial.md)
* [Learn how to use Microsoft Graph APIs to manage provisioning configurations](/graph/api/resources/synchronization-overview)
