---
title: Automate User provisioning into SAP S/4HANA with Microsoft Entra ID
description: Learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to SAP S/4HANA using SAP Cloud Identity Services.

author: jeevansd
manager: TeeEarls
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 10/01/2024
ms.author: jeedes

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to SAP S/4HANA.
---

# Configure Microsoft Entra ID and SAP Cloud Identity Services for automatic user provisioning into SAP S/4HANA

This article describes the steps you need to perform in SAP Cloud Identity Services and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and deprovisions users to SAP S/4HANA using the Microsoft Entra provisioning service and SAP Cloud Identity Services. For important details on what Microsoft Entra provisioning does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md).

## Capabilities supported
> [!div class="checklist"]
> * Create users in SAP S/4HANA to enable single sign-on to SAP S/4HANA
> * Remove users in SAP S/4HANA when they don't require access anymore
> * Keep user attributes synchronized between Microsoft Entra ID and SAP S/4HANA

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* SAP S/4HANA Cloud, private edition, SAP S/4HANA Cloud, public edition, or SAP S/4HANA On-Premise
* SAP Cloud Identity Services tenant
* A user account on SAP Identity Provisioning admin console with Admin permissions. Make sure you have access to the proxy systems in the Identity Provisioning admin console. If you don't see the **Proxy Systems** tile, create an incident for component **BC-IAM-IPS** to request access to this tile.

## Step 1: Plan your provisioning deployment

Microsoft Entra has connectors to SAP ECC, SAP Cloud Identity Services, and SAP SuccessFactors. Provisioning into SAP S/4HANA or other applications requires the users to first be present in Microsoft Entra ID. Once you have users in Microsoft Entra ID, you can provision those users from Microsoft Entra ID to SAP Cloud Identity Services. SAP Cloud Identity Services then provisions the users originating from Microsoft Entra ID that are in the SAP Cloud Identity Directory into the downstream SAP applications, including [`SAP S/4HANA Cloud`](https://help.sap.com/docs/identity-provisioning/identity-provisioning/target-sap-s-4hana-cloud), [`SAP S/4HANA On-Premise`](https://help.sap.com/docs/identity-provisioning/identity-provisioning/target-sap-s-4hana-on-premise) through the SAP cloud connector, and others.

  :::image type="content" source="~/identity/app-provisioning/media/plan-sap-user-source-and-target/end-to-end-integrations.png" alt-text="Diagram showing Microsoft and SAP technologies relevant to provisioning identities from Microsoft Entra ID." lightbox="~/identity/app-provisioning/media/plan-sap-user-source-and-target/end-to-end-integrations.png":::

## Step 2: Ensure you have the right users in Microsoft Entra ID

You can use HR inbound from sources such as SuccessFactors to keep the list of users in Microsoft Entra ID up to date as employees join, move, and leave. If plan to use groups or application role assignments to scope who can access SAP S/4HANA or what roles they will have, and your tenant has a license for Microsoft Entra ID Governance, you can also [automate changes to the application role assignments](~/identity/app-provisioning/plan-sap-user-source-and-target.md#assign-users-the-necessary-application-access-rights-in-microsoft-entra) in Microsoft Entra ID for applications representing SAP Cloud Identity Services or SAP S/4HANA. For more information on performing separation of duties and other compliance checks prior to provisioning, see [migrate access lifecycle management scenarios](~/id-governance/scenarios/migrate-from-sap-idm.md#migrate-access-lifecycle-management-scenarios).

For step-by-step guidance on the identity lifecycle with SAP applications as the target, see [Plan deploying Microsoft Entra for user provisioning with SAP source and target applications](~/identity/app-provisioning/plan-sap-user-source-and-target.md).

## Step 3: Configure provisioning from Microsoft Entra ID to SAP Cloud Identity Services

To prepare for provisioning users into SAP S/4HANA or other SAP applications integrated with SAP Cloud Identity Services, confirm the SAP Cloud Identity Services have the necessary schema mappings for those applications. Then, configure [provisioning of users from Microsoft Entra ID to SAP Cloud Identity Services](~/identity/app-provisioning/plan-sap-user-source-and-target.md#provision-users-to-sap-cloud-identity-services). SAP Cloud Identity Services will subsequently provision users into the downstream SAP applications as necessary. 

There are two ways to provision users from Microsoft Entra into SAP Cloud Identity Services.

* If you be using groups from Microsoft Entra ID, such as to assign users to roles in SAP S/4HANA cloud, then use SAP Cloud Identity Services provisioning. First, create Microsoft Entra groups for your SAP business roles used in SAP Analytics Cloud. Then, in SAP Cloud Identity Services provisioning, [configure Microsoft Entra ID as a source](https://help.sap.com/docs/identity-provisioning/identity-provisioning/microsoft-azure-active-directory) to bring users and groups from Microsoft Entra ID to SAP Cloud Identity Services and map the created groups to your SAP business roles. For more information, see [SAP documentation on how to provision users from Microsoft Azure AD to SAP Cloud Identity Services - Identity Authentication](https://blogs.sap.com/2022/02/04/provision-users-from-microsoft-azure-ad-to-sap-cloud-identity-services-identity-authentication/).

* Alternatively, if you don't need to use groups in Microsoft Entra ID, then you can use the Microsoft Entra provisioning service. In this scenario, create an application representing SAP S/4HANA, and assign users who need access to SAP S/4HANA to that application. Then, configure [automatic user provisioning with Microsoft Entra ID to SAP Cloud Identity Services for](sap-cloud-platform-identity-authentication-provisioning-tutorial.md). Wait for those users to be provisioned into SAP Cloud Identity Services, and verify they have the attributes necessary for your SAP S/4HANA target.

> [!NOTE]
> Start small. Test with a small set of users and groups before rolling out to everyone. Check the users have the right access in SAP downstream targets and when they sign in, they have the right roles.

## Step 4: Configure provisioning from SAP Cloud Identity Services to SAP S/4HANA

At this step, use SAP Cloud Identity Services Identity Provisioning to configure SAP S/4HANA as a target system, where you can provision users and group members. For SAP S/4HANA Cloud, see the [SAP documentation on provisioning to SAP S/4HANA cloud](https://help.sap.com/docs/identity-provisioning/identity-provisioning/target-sap-s-4hana-cloud). For SAP S/4HANA on-premise and SAP S/4HANA Cloud, private edition, see [SAP S/4HANA On-Premise](https://help.sap.com/docs/identity-provisioning/identity-provisioning/target-sap-s-4hana-on-premise).

## Step 5: Configure single sign-on

After you configure provisioning for users into your SAP applications, you should enable Single sign-on for them. Microsoft Entra ID can serve as the identity provider and authentication authority for your SAP applications. If you have not already done so, then configure [Microsoft Entra single sign-on (SSO) integration with SAP Cloud Identity Services](sap-hana-cloud-platform-identity-authentication-tutorial.md).

For more information on how to configure single sign-on to SAP SaaS and modern apps, see [enable SSO](~/id-governance/sap.md#enable-sso).

## Related content

* [Configure SAP Cloud Identity Services for automatic user provisioning with Microsoft Entra ID](sap-cloud-platform-identity-authentication-provisioning-tutorial.md)
