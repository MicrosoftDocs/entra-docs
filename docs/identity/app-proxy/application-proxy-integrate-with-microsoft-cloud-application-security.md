---
title: Use application proxy to integrate on-premises apps with Defender for Cloud Apps
description: Use Microsoft Defender for Cloud Apps with on-premises applications in Microsoft Entra ID. Use the Defender for Cloud Apps Conditional Access App Control to monitor and control sessions in real-time based on Conditional Access policies. You apply these policies to on-premises applications that use application proxy in Microsoft Entra ID.
author: kenwith
manager: dougeby 
ms.service: entra-id
ms.subservice: app-proxy
ms.topic: how-to
ms.date: 05/01/2025
ms.author: kenwith
ms.reviewer: ashishj
ai-usage: ai-assisted
---

# Configure real-time application access monitoring with Microsoft Defender for Cloud Apps and Microsoft Entra ID
Use Microsoft Defender for Cloud Apps for real-time monitoring with on-premises application in Microsoft Entra ID. Defender for Cloud Apps uses Conditional Access App Control to monitor and control sessions in real-time based on Conditional Access policies. Apply these policies to on-premises applications that use application proxy in Microsoft Entra ID.

Some examples of the policies you create with Defender for Cloud Apps include:

- Block or protect the download of sensitive documents on unmanaged devices.
- Monitor when high-risk users sign on to applications, and then log their actions from within the session. With this information, you can analyze user behavior to determine how to apply session policies.
- Use client certificates or device compliance to block access to specific applications from unmanaged devices.
- Restrict user sessions from noncorporate networks. You can give restricted access to users accessing an application from outside your corporate network. For example, this restricted access can block the user from downloading sensitive documents.

For more information, see [Protect apps with Microsoft Defender for Cloud Apps Conditional Access App Control](/defender-cloud-apps/proxy-intro-aad).

## Requirements

EMS E5 license, or Microsoft Entra ID P1 and Defender for Cloud Apps Standalone.

The on-premises application must use Kerberos Constrained Delegation (KCD).

Configure Microsoft Entra ID to use application proxy. Configuring application proxy includes preparing your environment and installing the private network connector. For a tutorial, see [Add an on-premises applications for remote access through application proxy in Microsoft Entra ID](~/identity/app-proxy/application-proxy-add-on-premises-application.md). 

<a name='add-on-premises-application-to-azure-ad'></a>

## Add on-premises application to Microsoft Entra ID

Add an on-premises application to Microsoft Entra ID. For a quickstart, see [Add an on-premises app to Microsoft Entra ID](~/identity/app-proxy/application-proxy-add-on-premises-application.md). When adding the application, be sure to set two settings in the **Add your on-premises application** page so it works with Defender for Cloud Apps:

- **Pre Authentication**: Enter **Microsoft Entra ID**.
- **Translate URLs in Application Body**: Choose **Yes**.

## Test the on-premises application

After adding your application to Microsoft Entra ID, use the steps in [Test the application](~/identity/app-proxy/application-proxy-add-on-premises-application.md#test-the-application) to add a user for testing, and test the sign-on. 

## Deploy Conditional Access App Control

To configure your application with the Conditional Access Application Control, follow the instructions in [Deploy Conditional Access Application Control for Microsoft Entra apps](/defender-cloud-apps/proxy-deployment-aad).


## Test Conditional Access App Control

To test the deployment of Microsoft Entra applications with Conditional Access Application Control, follow the instructions in [Test the deployment for Microsoft Entra apps](/defender-cloud-apps/proxy-deployment-aad).
