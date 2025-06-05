---
title: Learn about integrations between Microsoft and Netskope.
description: A comprehensive guide for configuring and testing the integration between Microsoft's and Netskope's Secure Access Service Edge (SASE) solutions.
author: kenwith
ms.author: kenwith
manager: dougeby
ms.topic: concept-article
ms.date: 02/21/2025
ms.service: global-secure-access
ms.subservice: entra-private-access 
ms.reviewer: feperezc
ai-usage: ai-assisted
#customer intent: As a administrator, I want to understand the integration between Microsoft and Netskope SASE solutions so that I can decide on using both and how they will integrate.
---

# Learn about Secure Access Service Edge (SASE) integrations between Microsoft and Netskope (Preview)
The integration between Microsoft and Netskope's Secure Access Service Edge (SASE) solutions enhances security and simplifies network traffic management. By combining Microsoft Entra Internet Access with Netskope Advanced Threat Protection (ATP), administrators can securely and efficiently manage threats for internet traffic. This integration involves several steps: configuring prerequisites, installing and configuring the Global Secure Access client, enabling internet access traffic profiles, setting up Transport Layer Security (TLS) termination, creating and linking Netskope ATP policies to Global Secure Access Security Profiles, and thorough testing and monitoring. The collaboration provides a strong security framework for organizations using Microsoft but want to enjoy Netskope Advance Threat Protection functionality.

> [!NOTE]
> Previews are made available to you under the terms applicable to previews, which are outlined in the overall Microsoft Product Terms for [online services](https://www.microsoft.com/licensing/terms/product/ForOnlineServices/all).
 
## Integration overview
The document provides a guide for integrating Microsoft's Global Secure Access Advanced Threat Protection (ATP) with Netskope. It covers a high level overview of the steps required once you onboard to the Preview. Details are provided as you onboard to the program.

The general steps that you follow as you onboard to the program are:

- **Prerequisites for ATP Preview**:
    - Onboarded Microsoft Entra tenant
    - Associated Azure Subscription
    - Test devices running Windows 10 or 11
    - Trial Microsoft Entra Internet Access licenses

- **Configuring Prerequisites**:
    - Access the Microsoft Entra admin center
    - Ensure appropriate user roles
    - Meet licensing requirements

- **Installing and Configuring Global Secure Access Client**:
    - Use a Windows device joined to Microsoft Entra ID
    - Edit the host file to connect to a specific Microsoft edge IP

- **Enabling Internet Access Traffic Profile**:
    - Enable the profile in the Microsoft Entra admin center
    - Assign it to users
    - Verify Internet traffic routing through Global Secure Access

- **Configuring TLS Termination**:
    - Create a Key Vault
    - Upload a Certificate Authority(CA) certificate
    - Enable TLS termination in the Microsoft Entra admin center

- **Creating and Linking ATP Policies**:
    - Create policies using Netskope threat engines
    - Link policies to a Security Profile
    - Assign policies via Conditional Access

- **Testing ATP Policies**:
    - Use EICAR test malware content
    - Disable the QUIC protocol in browsers

- **Monitoring and Logging**:
    - Check alerts and traffic logs in the Global Secure Access dashboard


## Prerequisites for the ATP Preview
To successfully preview the ATP integration, certain prerequisites must be met. 
These include having an onboarded Microsoft Entra tenant, an associated Azure Subscription, test devices running Windows 10 or 11, and trial Microsoft Entra Internet Access licenses.
You also need a user with the **Global Secure Access Administrator** role and a user with the **Conditional Access Administrator** role.
Ensuring these prerequisites are in place is essential for a smooth and effective integration process.

You can express your interest in joining this preview by filling out this [form](https://aka.ms/GSANetskopeEAP). Then we will follow up to have your tenant onboarded.

## Installing and configuring the Global Secure Access client
Install and configure the Global Secure Access client. To learn how to install the client, see [Global Secure Access clients](concept-clients.md).

For the Preview, you need to configure the client to use a specific IP address. This information is provided as you onboard your tenant to the Preview.

## Enabling the Microsoft Entra Internet Access traffic forwarding profile
The ATP Preview requires the Microsoft Entra Internet Access traffic profile in order to capture traffic. To learn more about traffic forwarding profiles, see [Global Secure Access traffic forwarding profiles](concept-traffic-forwarding.md). To learn how to enable the Internet Access traffic forwarding profile, see [How to manage the Internet Access traffic forwarding profile](how-to-manage-internet-access-profile.md).

## Configuring TLS Termination (Preview)
The TLS termination feature is a standalone feature that is also currently in Preview. A significant percentage of internet traffic is encrypted. By terminating TLS at the edge, the SASE solution can inspect and apply security policies to decrypted traffic which allows for threat detection, content filtering, and granular access controls. Details on setting up TLS termination are included when you onboard your tenant in the Preview program.

> [!NOTE]
> When you sign up for the Netskope ATP preview, you are implicitly signing up for the TLS preview.

## Creating and Linking ATP Policies
To create and link ATP policies, you must first activate the Netskope offer in the Microsoft Entra admin center. Navigate to **Global Secure Access** > **Third-Party Solutions** and select the *Netskope* offer. During the Preview the offer is available for free.

Next you create a threat protection policy, and then you link the threat protection policy to a security profile. Finally, you assign the security profile to users with a Conditional Access policy. Each of these steps is outlined in detail once you sign up for the Preview program.

## Monitoring and Logging
You use Global Secure Access monitoring and logging to monitor and review content that ATP policies block. To learn more about Global Secure Access monitoring and logging, see [Global Secure Access logs and monitoring](concept-global-secure-access-logs-monitoring.md). Details for ATP logging Preview are available when you onboard to the program.

## Related content
- [What is Global Secure Access?](overview-what-is-global-secure-access.md)

