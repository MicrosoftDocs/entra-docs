---
title: Create File Policies for Network Content Filtering
description: "Discover how to configure network content filtering with Global Secure Access to enforce data protection policies and secure sensitive files in real time."
ms.topic: how-to
ms.date: 03/04/2026
ms.author: jayrusso
author: HULKsmashGithub
ms.reviewer: sumeetmittal
ms.custom: sfi-image-nochange
ai-usage: ai-assisted

#customer intent: As an IT admin, I want to configure Global Secure Access settings so that I can enforce network content filtering policies.

---

# Create a file policy to filter network file content

Global Secure Access supports network content filtering through file policies. This feature helps you safeguard against unintended data exposure and prevents inline data leaks to generative AI applications and internet destinations. By extending data protection capabilities to the network layer through Global Secure Access, network content filtering enables your organization to enforce data policies on network traffic in real time. You can discover and protect files shared with unsanctioned destinations, such as generative AI and unmanaged cloud apps, from managed endpoints through browsers, applications, add-ins, APIs, and more.

The network content filtering solution brings together Microsoft Purview's data classification service and the identity-centric network security policies in Global Secure Access. This combination creates an advanced network-layer data security solution, Data Loss Prevention (DLP), that's identity-centric and policy-driven. By combining content inspection with real-time user risk evaluation, you can enforce granular controls over sensitive data movement across the network without compromising user productivity or security posture.

### High-level architecture
:::image type="content" source="media/how-to-network-content-filtering/network-content-filtering-architecture.png" alt-text="Diagram showing the architecture of network content filtering with Global Secure Access and Microsoft Purview." lightbox="media/how-to-network-content-filtering/network-content-filtering-architecture.png":::

This article explains how to create a file policy to filter internet traffic flowing through Global Secure Access.

> [!IMPORTANT]
> The **Scan with Purview** action in file policies is currently in PREVIEW.
> This information relates to a prerelease product that might be substantially modified before release. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.
> Basic file policy (block or allow by file MIME type) is generally available.

## Supported scenarios

Network content filtering supports the following key scenarios and outcomes for HTTP/1.1 traffic:
- Using **Basic file policy**, you can block files based on supported file MIME types.
- Using the **Scan with Purview** action (preview) in file policy, you can audit and block files based on:
    - Microsoft Purview sensitivity labels
    - Sensitive content in the file
    - The user's risk level
- You can generate Data loss prevention (DLP) admin alerts for rule matches.

> [!IMPORTANT]
> Network content filtering supports only files over HTTP/1.1. It doesn't support network content filtering for text.

## Prerequisites

To use the File Policy feature, you need the following prerequisites:
- A valid Microsoft Entra tenant.
- The product requires licensing. For details, see the licensing section of [What is Global Secure Access](overview-what-is-global-secure-access.md). If needed, you can [purchase licenses or get trial licenses](https://aka.ms/azureadlicense).
    - A valid Microsoft Entra Internet Access license.
    - A valid Microsoft Purview license, required for **Scan with Purview** inspection. (You can use basic file policy without a Purview license.)
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
        > Before you continue, test and ensure your client's internet traffic is routed through Global Secure Access. To verify the client configuration, see the steps in the following section.
    1. Select the **Global Secure Access** icon and select the Troubleshooting tab.
    1. Under **Advanced Diagnostics**, select **Run tool**.
    1. In the Global Secure Access Advanced Diagnostics window, select the **Forwarding Profile** tab. 
    1. Verify that **Internet Access** rules are present in the **Rules** section. This configuration might take up to 15 minutes to apply to clients after enabling the Internet Access traffic profile in the Microsoft Entra admin center.
        :::image type="content" source="media/how-to-network-content-filtering/internet-access-rules.png" alt-text="Screenshot of the Global Secure Access Advanced Diagnostics window on the Forwarding Profile tab, showing Internet Access rules in the Rules section." lightbox="media/how-to-network-content-filtering/internet-access-rules.png":::
1. Confirm access to web applications you plan for file policies.

## Configure a file policy

To configure a file policy in Global Secure Access, complete the following steps:
1. [Create a file policy](#create-a-file-policy).
1. [Link the file policy to a security profile](#link-the-file-policy-to-a-security-profile).
1. [Configure a Conditional Access policy](#configure-a-conditional-access-policy).

### Create a file policy

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Secure Access Administrator](/azure/active-directory/roles/permissions-reference#global-secure-access-administrator).
1. Browse to **Global Secure Access** > **Secure** > **File policies**.
    :::image type="content" source="media/how-to-network-content-filtering/file-policies-create.png" alt-text="Screenshot of the File policies page in the Microsoft Entra admin center showing the Create policy button." lightbox="media/how-to-network-content-filtering/file-policies-create.png":::
1. Select **+ Create Policy**. Pick the appropriate options.
1. On the **Basics** tab: 
    1. Enter the policy **Name**. 
    1. Enter the policy **Description**.
    1. Select **Next**.
    :::image type="content" source="media/how-to-network-content-filtering/file-policy-basics-tab.png" alt-text="Screenshot of the Basics tab for a new file policy showing the Policy name and Description fields." lightbox="media/how-to-network-content-filtering/file-policy-basics-tab.png":::
1. On the **Rules** tab:  
    1. Add a new rule.
    1. Enter the **Name**, **Description**, **Priority**, and **Status** as appropriate.
    1. Select the appropriate option for the **Action** menu:
        - To configure a basic data policy, select **Allow** or **Block**.
        - To use data policies configured in Microsoft Purview, select **Scan with Purview** (preview).
            :::image type="content" source="media/how-to-network-content-filtering/scan-with-purview.png" alt-text="Screenshot of the File scan rule screen with the Action menu expanded and the Scan with Purview option selected." lightbox="media/how-to-network-content-filtering/scan-with-purview.png":::
    1. For **Matching conditions**, select the appropriate **Activities** and **File types**.
        :::image type="content" source="media/how-to-network-content-filtering/file-rule-content-types.png" alt-text="Screenshot of the Add File Rule page showing the Matching conditions section with Activities set to Download and Upload, and the Content types dropdown expanded with file type options." lightbox="media/how-to-network-content-filtering/file-rule-content-types.png":::
    1. Select **+ Add destination** and choose an option for the destination.
        :::image type="content" source="media/how-to-network-content-filtering/file-rule-destinations.png" alt-text="Screenshot of the Add File Rule page showing the Destinations section and the Select web categories panel with category options." lightbox="media/how-to-network-content-filtering/file-rule-destinations.png":::
1. Select **Next**.
1. On the **Review** tab, review your settings.
    :::image type="content" source="media/how-to-network-content-filtering/file-policy-review-tab.png" alt-text="Screenshot of the Review tab showing a summary of the file policy settings including policy name, description, and number of rules before creation." lightbox="media/how-to-network-content-filtering/file-policy-review-tab.png":::
1. Select **Create** to create the policy.

> [!IMPORTANT]
> If you select the **Scan with Purview** action in a file policy rule, you must also configure a corresponding data loss prevention (DLP) policy in the Microsoft Purview portal. The file policy in Global Secure Access routes files to Purview for content inspection, but Purview must have a DLP policy configured to classify and act on the content. See [Configure a Purview DLP policy for network data security](#configure-a-purview-dlp-policy-for-network-data-security) for step-by-step guidance.

### Link the file policy to a security profile

1. Browse to **Global Secure Access** > **Secure** > **Security profiles**.
1. Select the security profile you want to modify.
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
1. Configure the **Network**, **Conditions**, and **Grant** sections according to your needs.
1. Under **Session**, select **Use Global Secure Access Security Profile** and select the security profile you created.
1. To create the policy, select **Create**.

For more information, see [Create and link a Conditional Access policy](how-to-configure-web-content-filtering.md#create-and-link-conditional-access-policy).

The file policy is successfully configured. 

## Configure a Purview DLP policy for network data security

If you selected the **Scan with Purview** action in your file policy, you must configure a corresponding data loss prevention (DLP) policy in Microsoft Purview. The DLP policy defines how Purview classifies and acts on files that Global Secure Access routes for inspection.

> [!IMPORTANT]
> The **Scan with Purview** integration for Global Secure Access is currently in PREVIEW.
> This information relates to a prerelease product that might be substantially modified before release. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

### Prerequisites for Purview integration

- Microsoft Purview pay-as-you-go billing configured for your tenant. For network data security DLP scenarios, the pay-as-you-go subscription is all you need. If you use other DLP functionality, per-seat licensing is required. For more information, see [Learn about Microsoft Purview billing models](/purview/purview-billing-models).
- The Global Secure Access integration enabled in the Microsoft Purview portal.

### Enable the Global Secure Access integration in Purview

1. Sign in to the [Microsoft Purview portal](https://purview.microsoft.com).
1. Select **Settings** (gear icon in the upper-right corner) > **Data loss prevention** > **Integrations**.
1. Locate the **Microsoft Entra Internet Access** integration and select **Get started**.
1. Complete the integration steps to connect Global Secure Access with Purview.

> [!NOTE]
> If you don't see **Data loss prevention** under **Settings**, your account might not have the required permissions or your tenant might not have the required licensing. You need a role such as **DLP Compliance Management** or **Information Protection Admin**, and a Microsoft 365 E5/A5 subscription or a Microsoft Purview DLP add-on. For more information, see [Permissions in the Microsoft Purview portal](/purview/purview-permissions).

For detailed steps on SASE provider integration, see [Use Network Data Security to help prevent sharing sensitive information with unmanaged AI -- SASE provider integration](/purview/dlp-create-policy-ai-network-data-security#sase-provider-integration).

### Create a DLP policy for network data security

1. Sign in to the [Microsoft Purview portal](https://purview.microsoft.com).
1. Select **Data loss prevention** > **Policies** > **+ Create policy**.
1. Select **Inline web traffic**.
1. Select **Custom** from the **Categories** list and then select **Custom policy** from the **Regulations** list.
1. Select **Next**.
1. Enter a policy name and description, then select **Next**.
1. Configure the cloud apps to monitor:
    1. Select **+ Add cloud apps**.
    1. On the **Adaptive app scopes** tab, choose the app categories you want to protect against (for example, **All unmanaged AI apps**).
    1. Select **Add**.
1. Select **Next**.
1. On the **Choose where to enforce the policy** page, ensure **Network** is enabled, then select **Next**. You can only select **Network** when pay-as-you-go billing is set up. For more information, see [Learn about Microsoft Purview billing models](/purview/purview-billing-models).
1. Select **Create or customize advanced DLP rules** and select **Next**.
1. Select **+ Create rule** and configure the rule:
    1. Enter a **Name** and optional description.
    1. Under **Conditions**, select **+ Add condition** > **Content contains**.
    1. Add the **sensitive information types** or **sensitivity labels** that match your organization's data protection requirements.
    1. Under **Actions**, select **+ Add an action** > **Restrict browser and network activities**.
    1. Select **File uploaded to or shared with cloud or AI apps** and set the action to **Audit** or **Block** as appropriate.
    1. Configure **Incident reports** and alert settings as needed.
    1. Select **Save**.
1. Review the rule, ensure its status is **On**, and select **Next**.
1. On the **Policy mode** page, choose **Turn the policy on immediately** or run in simulation mode first to test.
1. Select **Next**, review the policy, and select **Submit**.

> [!NOTE]
> Global Secure Access supports file activities only. Text-based activities in the DLP policy apply to other integrated SASE solutions but not to Global Secure Access.

For a detailed walkthrough with example configurations, see [Use Network Data Security to help prevent sharing sensitive information with unmanaged AI](/purview/dlp-create-policy-ai-network-data-security).

## Test the file policy
Test the configuration by attempting to upload or download files that match the file policy conditions. Verify that the policy settings block or allow the actions.

1. Open a test file that contains personal data, such as dlptest.com/sample-data.pdf.
1. Try to share the test file with the destination you configured in the file policy. If the policy is configured properly, the action is blocked.

## Known limitations

- Network content filtering doesn't support text. It only supports files.
- Multipart encoding isn't supported, so file policy doesn't work for such applications (for example, Google Drive uses multipart encoding for file upload).
- Compressed content is detected in zip format (the content isn't decompressed).
- Accuracy of true file type detection might not be 100%.
- Destination applications using WebSocket (such as Copilot) aren't supported.
- Top level and second level domains don't support wildcards (like *, *.com, *contoso.com) while configuring FQDNs.

> [!NOTE]
> Apps might use multiple URLs and FQDNs under the hood when you interact with them. Make sure to configure the correct destination for the file policy to take effect.

## Monitoring and logging

To view traffic logs:
1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Reports Reader](/azure/active-directory/roles/permissions-reference#reports-reader).
1. Select **Global Secure Access** > **Monitor** > **Traffic logs**.

## Related content

- [Learn about Microsoft Purview Network Data Security](/purview/dlp-network-data-security-learn)
- [Use Network Data Security to help prevent sharing sensitive information with unmanaged AI](/purview/dlp-create-policy-ai-network-data-security)
- [How to configure Global Secure Access web content filtering](how-to-configure-web-content-filtering.md)
- [Enable the Internet Access traffic forwarding profile](how-to-manage-internet-access-profile.md) 
- [Configure Transport Layer Security inspection](how-to-transport-layer-security.md)
