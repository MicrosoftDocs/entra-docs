---
title: Microsoft Global Secure Access deployment guide for Microsoft Traffic
description: Deploy and verify Microsoft Global Secure Access for Microsoft Traffic
customer intent: As a Microsoft Partner, I want to deploy Microsoft Traffic as a Proof of Concept in my production or test environment.
author: jricketts
manager: martinco
ms.service: global-secure-access
ms.topic: conceptual
ms.date: 01/06/2025
ms.author: jricketts
---
# Microsoft Global Secure Access deployment guide for Microsoft Traffic

[Microsoft Global Secure Access](../global-secure-access/overview-what-is-global-secure-access.md) converges network, identity, and endpoint access controls for secure access to any app or resource from any location, device, or identity. It enables and orchestrates access policy management for corporate employees. You can continuously monitor and adjust, in real time, user access to your private apps, Software-as-a-Service (SaaS) apps, and Microsoft endpoints. Continuous monitoring and adjusting helps you to appropriately respond to permission and risk level changes as they occur.

The Microsoft traffic forwarding profile enables you to control and manage internet traffic that is specific to Microsoft endpoints even when users work from remote locations. It helps you to:

- Protect against data exfiltration.
- Reduce risk of token theft and replay attacks.
- Correlate device source IP address with activity logs to improve threat hunting efficiencies.
- Ease access policy management without a list of egress IP addresses.

The guidance in this article helps you to test and deploy the Microsoft traffic profile in your production environment. [Microsoft Global Secure Access deployment guide introduction](gsa-deployment-guide-intro.md) provides guidance on how to initiate, plan, execute, monitor, and close your Global Secure Access deployment project.

## Identify and plan for key use cases

Before you enable Microsoft Entra Secure Access Essentials, determine what you want it to do for you. Understand your use cases to decide which features to deploy. The following table recommends configurations based on use cases.

|Use case|Recommended configuration|
|---|---|
|Prevent users and groups from using your organization's devices to sign in to unauthorized Entra ID tenants.|Configure universal tenant restrictions.|
|Ensure users connect and authenticate only with the Global Secure Access secure network tunnel to reduce risk of token theft/replay for Microsoft 365 and all Enterprise applications.|Configure compliant network check in Conditional Access policies.|
|Maximize threat hunting success and efficiencies.|Configure Source IP restoration (Preview) and [Use enriched Microsoft 365 logs](../global-secure-access/how-to-view-enriched-logs.md).|

After you determine which capabilities you require for your use cases, include feature deployment in your implementation.

## Test and deploy Microsoft traffic profile

At this point, you completed the initiate and plan stages of your Global Secure Access deployment project. You understand what you need to implement for whom. You defined the users to enable in each wave. You have a schedule for each wave's deployment. You have met [licensing requirements](../global-secure-access/overview-what-is-global-secure-access.md#licensing-overview). You're ready to enable Microsoft traffic profile.

1. Create end user communications to set expectations and provide an escalation path.
1. Create a roll-back plan that defines the circumstances and procedures for when you remove Global Secure Access client from a user device or disable the traffic forwarding profile.
1. [Create a Microsoft Entra group](../fundamentals/how-to-manage-groups.yml) that includes your pilot users.
1. Send end user communications.
1. Enable the [Microsoft traffic forwarding profile](../global-secure-access/how-to-manage-microsoft-profile.md) and assign your pilot group to it.
1. If you plan to maximize your threat hunting success and efficiency, configure [Source IP restoration](../global-secure-access/how-to-source-ip-restoration.md).
1. Create Conditional Access policies that require [compliant network](../global-secure-access/how-to-compliant-network.md) checks to your pilot group if it's a planned use case.
1. Configure [universal tenant restrictions](../global-secure-access/how-to-universal-tenant-restrictions.md) if it's a planned use case.
1. Deploy the [Global Secure Access client for Windows](../global-secure-access/how-to-install-windows-client.md) on devices for your pilot group to test.
1. Have your pilot users test your configuration.
1. View sign-in logs to ensure that pilot users are connecting to Microsoft endpoints using Global Secure Access.
1. Verify compliant network check by pausing Global Secure Access agent and then attempting to access SharePoint.
1. Verify tenant restrictions by attempting to sign into a different tenant.
1. Verify Source IP restoration by comparing the IP address in the sign-in log of a successful connection to SharePoint Online when connecting with Global Secure Access agent running vs. disabled to ensure they're the same.
   >[!NOTE]
   >You must disable any Conditional Access policy that enforces the compliant network check for this verification.

Update your configuration to address any issues. Repeat the test. Implement roll-back plans if needed. Iterate changes to your end user communications and deployment plan if needed.

After you complete your pilot, you have a repeatable process to proceed with each wave of users in your production deployment.

1. Identify the groups that contain your wave's users.
1. Notify your support team of the wave's schedule and its included users.
1. Send the wave's end user communications.
1. Assign the wave's groups to the Microsoft traffic forwarding profile.
1. Deploy the Global Secure Access Client on the wave's users' devices.
1. Create or update Conditional Access policies to enforce your use case requirements on the wave's relevant groups.
1. As needed, iterate changes to your end user communications and deployment plan.

## Next steps

- Learn how to accelerate your transition to a Zero Trust security model with [Microsoft Entra Suite and Microsoft's unified security operations platform](https://www.microsoft.com/security/blog/2024/07/11/simplified-zero-trust-security-with-the-microsoft-entra-suite-and-unified-security-operations-platform-now-generally-available/)
- [Introduction to Microsoft Global Secure Access Deployment Guide](gsa-deployment-guide-intro.md)
- [Microsoft Global Secure Access Deployment Guide for Microsoft Entra Private Access](gsa-deployment-guide-private-access.md)
- [Microsoft Global Secure Access Deployment Guide for Microsoft Entra Internet Access](gsa-deployment-guide-internet-access.md)
- [Simulate remote network connectivity using Azure Virtual Network Gateway - Global Secure Access](../global-secure-access/how-to-simulate-remote-network.md)
- [Simulate remote network connectivity using Azure vWAN - Global Secure Access](../global-secure-access/how-to-create-remote-network-vwan.md)
- [Introduction to Global Secure Access Proof of Concept Guidance](gsa-poc-guidance-intro.md)](gsa-poc-guidance-intro.md)
- [Global Secure Access Proof of Concept Guidance - Configure Microsoft Entra Private Access](gsa-poc-private-access.md)
- [Global Secure Access Proof of Concept Guidance - Configure Microsoft Entra Internet Access](gsa-poc-internet-access.md)
