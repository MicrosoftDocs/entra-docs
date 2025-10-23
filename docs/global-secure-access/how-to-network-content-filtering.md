---
title: Network Content Filtering
description: "Learn how to create a file policy to filter internet traffic flowing through Global Secure Access."
ms.service: global-secure-access
ms.topic: how-to
ms.date: 10/22/2025
ms.author: jayrusso
author: HULKsmashGithub
manager: dougeby
ms.reviewer: sumeetmittal
ms.custom: sfi-image-nochange

#customer intent: As a <role>, I want <what> so that <why>.

---

# Create a file policy to filter network content

Global Secure Access supports network content filtering. This feature enables customers to safeguard against unintended data exposure, preventing inline data leaks to generative AI applications and internet destinations. By extending data protection capabilities to the network layer through Global Secure Access, network content filtering enables organizations to enforce data policies on network traffic in real time. Organizations can discover and protect files shared with unsanctioned destinations, such as gen AI and unmanaged cloud apps, from managed endpoints through browsers, applications, add-ins, APIs, and more.

The network content filtering solution brings together Microsoft Purview's data classification service and the identity-centric network security policies in Global Secure Access. This combination creates an advanced network-layer data security solution, Data Loss Prevention (DLP), that is identity-centric and policy-driven. By combining deep content inspection with real-time user risk evaluation, customers can enforce granular controls over sensitive data movement across the network without compromising user productivity or security posture.

> [!IMPORTANT]
> The network content filtering feature is currently in PREVIEW.   
> This information relates to a prerelease product that might be substantially modified before release. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.      

This article explains how to create a file policy to filter internet traffic flowing through Global Secure Access.

## Prerequisites

To use the File Policy feature, you need the following:
- A valid Microsoft Entra tenant.
- The product requires licensing. For details, see the licensing section of [What is Global Secure Access](overview-what-is-global-secure-access.md). If needed, you can [purchase licenses or get trial licenses](https://aka.ms/azureadlicense).
    - A valid Microsoft Entra Internet Access license.
    - A valid Microsoft Purview license, required for advanced content inspection. (You can use basic content inspection without a Purview license.)
- A user with the [Global Secure Access Administrator](../identity/role-based-access-control/permissions-reference.md#global-secure-access-administrator) role in Microsoft Entra ID to configure Global Secure Access settings.
- A [Conditional Access Administrator](../identity/role-based-access-control/permissions-reference.md#conditional-access-administrator) role to configure Conditional Access policies.
- The Global Secure Access client requires a device (or virtual machine) that is either Microsoft Entra ID joined or Entra ID Hybrid joined.

## Initial configuration

To configure file policies, complete the following initial setup steps:
1. [Enable the Internet Access traffic forwarding profile](how-to-manage-internet-access-profile.md#enable-the-internet-access-traffic-forwarding-profile) and ensure correct user assignments.  
1. [Configure the Transport Layer Security (TLS) inspection](how-to-transport-layer-security.md) policy.  
1. Install and configure the Global Secure Access client:
    1. Install the Global Secure Access client on Windows or macOS.
        > [!IMPORTANT]
        > Before continuing, test and ensure your client's internet traffic is being routed through Global Secure Access. See the steps below to verify client configuration.
    1. Select the **Global Secure Access** icon and select the Troubleshooting tab.
    1. Under **Advanced Diagnostics**, select **Run tool**.
    1. In the Global Secure Access Advanced Diagnostics window, select the **Forwarding Profile** tab. 
    1. Verify that **Internet Access** rules are present in the **Rules** section. This configuration might take up to 15 minutes to apply to clients after enabling the Internet Access traffic profile in the Microsoft Entra Portal.
        :::image type="content" source="media/how-to-network-content-filtering/internet-access-rules.png" alt-text="Screenshot of the Global Secure Access client Advanced Diagnostics window, open to the Forwarding Profile tab, with the Internet Access rules highlighted." lightbox="media/how-to-network-content-filtering/internet-access-rules.png":::
1. Confirm access to web applications you plan for file policies.

## Configure a file policy

There are three main steps to configure a file policy in Global Secure Access:
1. [Create a file policy](#create-a-file-policy).
1. [Link the file policy to a security profile](#link-the-file-policy-to-a-security-profile).
1. [Configure a Conditional Access policy](#configure-a-conditional-access-policy).

### Create a file policy

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Secure Access Administrator](/azure/active-directory/roles/permissions-reference#global-secure-access-administrator).
1. Browse to **Global Secure Access** > **Secure** > **File policies**.
1. Select **+ Create Policy**. Pick the appropriate options.
1. On the **Basics** tab: 
    1. Enter the policy **Name**. 
    1. Enter the policy **Description**.
    1. Select **Next**.
1. On the **Rules** tab:  
    1. Add a new rule.
    1. Enter the **Name**, **Description**, **Priority**, and **Status** as appropriate.
    1. If you've configured data policies in Microsoft Purview, select **Scan with Purview** from the **Action** menu.
    1. For **Matching conditions**, select the appropriate **Activities** and **File types**.
    1. Select **+ Add destination** and choose an option for the destination.
1. Select **Next**.
1. On the **Review** tab, review your settings.
1. Select **Create** to create the policy.

### Link the file policy to a security profile

1. Browse to **Global Secure Access** > **Secure** > **Security profiles**.
1. Select the security profile you wish to modify.
1. Switch to the **Link policies** view.
1. Configure the link file policy:
    1. Select **+ Link a policy** > **Existing File policy**.
    1. From the **Policy name** menu, select the file policy you created.
    1. Leave **Position** and **State** set to the defaults.
    1. Select **Add**.
1. Close the security profile. 

### Configure a Conditional Access policy

To enforce the Global Secure Access security profile, create a conditional access policy with the following configuration:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).
1. Browse to **Identity** > **Protection** > **Conditional Access**. 
1. Select **+ Create new policy**.
1. Name the policy.
1. Select the users and groups to apply the policy to.
1. Set the **Target resources** to **All internet resources with Global Secure Access**.
1. Configure the **Network**, **Conditions** and **Grant** sections according to your needs.
1. Under **Session**, select **Use Global Secure Access Security Profile** and select the security profile you created.
1. To create the policy, select **Create**.

For more information, see [Create and link a Conditional Access policy](how-to-configure-web-content-filtering.md#create-and-link-conditional-access-policy).

The file policy is successfully configured. 

## Test the file policy
Test the configuration by attempting to upload or download files that match the file policy conditions. Verify that the actions are blocked or allowed according to the policy settings.

1. Open a test file that contains PCI and PII data, such as dlptest.com/sample-data.pdf.
1. Try to share the test file with the destination you configured in the file policy. If the policy is configured properly, the action is blocked.

## Known limitations

- Multipart encoding is not supported, so file policy will not work for such applications (e.g. Google Drive uses multipart encoding for file upload).
- Compressed content will be detected just as zip (we don't decompress content).
- Accuracy of true file type detection may not be 100%.
- Destination application using WebSocket (such as Copilot) are not supported.

> [!NOTE]
> Apps may use multiple URLs and FQDNs under the hood when you interact with them. Make sure to configure the correct destination for the file policy to take effect.

## Monitoring and logging

To view traffic logs:
1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Reports Reader](/azure/active-directory/roles/permissions-reference#reports-reader).
1. **Global Secure Access** > **Monitor** > **Traffic logs**.

To show all traffic subject to Netskope inspection:
1. Go to the Transactions tab. 
1. Select Add filter.
1. Search for or scroll to find the appropriate filter e.g., Action, policyName 
1. Select Apply.
1. Check the filteringProfileName and policyName to identify the policies responsible for the applied action.

## Related content

* [How to configure Global Secure Access web content filtering](how-to-configure-web-content-filtering.md)



<!-- image syntax

:::image type="content" source="media/how-to-network-content-filtering/[].png" alt-text="Screenshot of []." lightbox="media/how-to-network-content-filtering/[].png":::

-->