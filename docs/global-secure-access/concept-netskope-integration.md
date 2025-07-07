---
title: "Global Secure Access: Advanced Threat Protection (Preview)"
description: "Learn how to protect your organization with Global Secure Access Advanced Threat Protection (ATP) and Data Loss Prevention (DLP) policies powered by Netskope."
author: HULKsmashGithub
ms.author: jayrusso
ms.service: global-secure-access
ms.topic: how-to   
ms.date: 07/07/2025
manager: dougeby
ms.reviewer: abhijeetsinha
ai-usage: ai-assisted

#customer intent: As an IT administrator, I want to configure Advanced Threat Protection and Data Loss Prevention policies so that I can protect my organization from malware and data leaks.
---
# Protect your organization with Global Secure Access Advanced Threat Protection (preview)

In today's evolving threat landscape, organizations face challenges protecting sensitive data and systems from cyberattacks. Global Secure Access Advanced Threat Protection (ATP) combines Microsoft Security Service Edge (SSE) with Netskope's advanced threat detection and data loss prevention (DLP) capabilities to deliver a comprehensive security solution. This integration offers real-time protection against malware, zero-day vulnerabilities, and data leaks, and simplifies management through a unified platform.

This guide provides step-by-step instructions for configuring ATP and DLP policies to safeguard your organization. By following these steps, IT administrators can apply the power of Microsoft SSE and Netskope to enhance their organization's security posture and streamline threat management.

> [!IMPORTANT]
> Global Secure Access Advanced Threat Protection is currently in PREVIEW.
> This information relates to a prerelease product that might be substantially modified before its release. Microsoft makes no warranties, expressed or implied, with respect to the information provided here. 

**High-level architecture**
:::image type="content" source="media/concept-netskope-integration/high-level-architecture.png" alt-text="Diagram that shows how data is routed and analyzed between Microsoft Entra, Global Secure Access, and Netskope.":::

## Prerequisites
To complete these steps, make sure you have the following prerequisites:
- A Global Secure Access Administrator role in Microsoft Entra ID to configure Global Secure Access settings.   
- A tenant configured with a Transport Layer Security (TLS) inspection policy as described in [Configure Transport Layer Security Inspection](how-to-transport-layer-security.md). 
- Test devices or virtual machines running Windows 10 or Windows 11 that are joined or hybrid joined to a Microsoft Entra ID.   
- Test devices with the Global Secure Access client installed. See [Global Secure Access client for Microsoft Windows](how-to-install-windows-client.md) for requirements and installation instructions.   
- A Conditional Access Administrator role to configure Conditional Access policies.    
- Trial Microsoft Entra Internet Access licenses. For licensing details, see the Global Secure Access [Licensing overview](overview-what-is-global-secure-access.md#licensing-overview). You can purchase licenses or get trial licenses. To activate an Internet Access trial, browse to [aka.ms/InternetAccessTrial](https://aka.ms/InternetAccessTrial).     

> [!IMPORTANT]
> Complete and verify the configuration steps marked **Important** before proceeding.

### Enable the Internet access traffic profile 
1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).
1. Browse to **Global Secure Access** > **Connect** > **Traffic forwarding** and enable the Internet access profile.  
1. Under **Internet access profile** > **User and Group assignments**, select **View** to choose the participating users. 

For more information, see [How to manage the Internet Access traffic forwarding profile](how-to-manage-internet-access-profile.md). 

> [!IMPORTANT]
> Before continuing, check that your client's internet traffic is routed through the Global Secure Access service. 

4. On your test device, right-click the Global Secure Access icon in the system tray and select **Advanced diagnostics**. 
1. On the **Forwarding Profile** tab, verify **Internet Access rules** are present in the **Rules** section. This configuration can take up to 15 minutes to apply to clients after you enable the Internet access traffic profile.

:::image type="content" source="media/concept-netskope-integration/internet-access-rules.png" alt-text="Screenshot of the Forwarding Profile tab with the Internet access rules highlighted.":::

### Enable TLS inspection 
A large percentage of internet traffic is encrypted. Terminating TLS at the edge lets Global Secure Access inspect and apply security policies to decrypted traffic. This process enables threat detection, content filtering, and granular access controls.

To enable TLS inspection, follow the steps in [Configure Transport Layer Security Inspection](how-to-transport-layer-security.md).

> [!CAUTION]
> You must configure TLS inspection on your tenant before purchasing Netskope from the marketplace. 

## Enable and test ATP and DLP policies 
You can create ATP and DLP policies powered by Netskope engines directly from the Microsoft Entra admin center by completing the following high-level steps. Details for each step follow. 
1. [Activate the Netskope offer through the Global Secure Access marketplace](#activate-a-netskope-offer-through-the-global-secure-access-marketplace) 
1. [Create an ATP policy](#create-an-atp-policy)
1. [Create a DLP policy](#create-a-dlp-policy)  
1. [Link an ATP, DLP, or TLS inspection policy to the security profile](#link-an-atp-dlp-or-tls-inspection-policy-to-the-security-profile)  
1. [Create a conditional access policy to enforce ATP, DLP, and TLS inspection policies](#create-a-conditional-access-policy-to-enforce-atp-dlp-and-tls-inspection-policies)
1. [Test ATP policies](#test-atp-policies)   
1. [Test DLP Policies](#test-dlp-policies)   

### Activate a Netskope offer through the Global Secure Access marketplace 
To activate the Netskope offer for your tenant:   
1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Secure Access Administrator](../identity/role-based-access-control/permissions-reference.md#global-secure-access-administrator). 
1. Browse to **Global Secure Access** > **Third Party Security Solutions** > **Marketplace**. 
1. Select the Netskope **Get it Now** button and follow the steps to activate the offer.  

> [!NOTE]
> While in preview, Netskope's functionality is provided at no cost.   
 
4. Once the offer is provisioned, the Offers page lists the Netskope status as **Active**.

:::image type="content" source="media/concept-netskope-integration/offers-active.png" alt-text="Screenshot of the Offers page with the Netskope status of Active highlighted.":::

### Create an ATP policy 
1. Browse to **Global Secure Access** > **Secure** > **Threat Protection policies**. 
1. Select **+ Create policy**. 
1. On the **Basics** tab:
    1. Set the **Security provider** to **Netskope**.  
    1. Enter a **Policy name**.   
    1. Select the policy **Position**. 
        - The position sets the policy priority when Netskope processes multiple ATP and DLP policies. 
        - Netskope's ATP and DLP policies share a common ordering list. The position you specify applies to both ATP and DLP policies in Netskope. For example, Netskope_ATP_Policy_1 might have a position of 1, followed by Netskope_DLP_Policy_1 with a position of 2, and Netskope_ATP_Policy_2 with a position of 3.
        - If you assign a position that is already in use by another Netskope ATP or DLP policy, then the positions of the lower policies automatically shift down by one. 
    1. Set the **State** to **enabled**. 
    1. Select **Next**. 
1. On the **Policy** tab:
    1. Select the **Select destination** link. 
    1. For **Destination type**, select **category** or **application**. 
    1. Search for and select the desired categories or applications. To determine which Netskope web category to select, refer to the [Netskope URL categorization lookup](https://www.netskope.com/url-lookup).
    1. Select **Apply**. 
    1. Select the type of **Activity** that triggers the policy: **upload** (data flowing from the user to the internet), **download** (data flowing from the internet to the user), or **upload download**.     
    1. For **Action**, select the **Select action** link and set the action for **Low**-, **Medium**-, and **High**-level threat severities. These settings direct the threat engine on which action to take for each threat severity.   
    1. Select **Apply**. 
    1. The **Advanced settings** allow you to select the **Patient zero** option, which signals the threat engine to run more diagnostics on the threat and blocks the user from uploading or downloading until the threat engine reaches a verdict. These diagnostics can take up to 15 minutes.  

       > [!NOTE]
       > Leave the **Patient zero** check box unchecked unless you explicitly understand and want to include the feature behavior. When Patient zero is enabled, the policy matches *only* binary and executable file types. The implications for Patient zero are:
          >- If the file type is binary and executable, and the Netskope threat engine has a verdict, the threat engine takes the action that matches the policy.
          >- If the file type is binary and executable, and the Netskope threat engine doesn't have a verdict, the threat engine blocks the activity.
          >- If the file type isn't binary and executable, the file doesn't match the policy. 

   For ATP policy recommendations from Netskope, refer to the [FAQ section](#frequently-asked-questions-faq) of this document.   

1. Select **Next**.   
1. Review the details and select **Submit**. 

### Create a DLP policy 
1. Browse to **Global Secure Access** > **Secure** > **Data Loss Prevention policies**. 
1. Select **+ Create policy** > **Netskope policies**.  
1. On the **Basics** tab:   
    1. Enter a **Name** and **Description** (optional) for the policy.   
    1. Select the policy **Position**. The position sets the policy priority when Netskope is processing multiple ATP and DLP policies.   
    1. Set the **State** to **Enabled**. 
    1. Select **Next**. 
1. On the **Policy** tab:   
    1. Select the **Select destinations** link. 
    1. For **Destination type**, select **Categories** or **Applications**. 
    1. Search for and select the desired categories or applications.
    1. Select **Apply**. 
    1. Choose the type of **Activity** that should be subject to this policy. Select both **Upload** and **Download**. The activities available vary according to the categories and applications you select. In addition to **Upload** and **Download**, Netskope offers granular support for a wide range of activities for various applications and application categories. These categories allow customers to apply comprehensive data loss prevention policies to secure data in their business-critical applications and application categories.   
    1. To choose from and configure DLP profiles, select the **Select profiles** link. You can choose from DLP profiles that cover predefined data identifiers and personal identifiers such as financial data, medical data, biodata, inappropriate terms, and industry focused information. 
    1. Select the DLP profiles that match your required information types and select the action to enforce for each. (For initial testing purposes, select **DLP-PCI** and **DLP-PII**.)      
    1. Select **Apply**.   
    1. Optionally, select the **Select advanced settings** link and select **Continue policy evaluation**. The Continue Policy evaluation option ensures DLP policy evaluation doesn't stop after a DLP policy match. Every DLP match raises an alert and policy evaluation continues for each of the remaining DLP policies. Alternatively, if you prefer to stop policy evaluation after the first DLP match and *not* continue with the rest of the DLP policies, don't select the **Continue policy evaluation** option.   
    1. Select **Apply**.   
    1. Select **Next**.   
1. Review the details and select **Submit**. 

### Link an ATP, DLP, or TLS inspection policy to the security profile 
Use **Security profiles** and **Conditional Access** to assign ATP and DLP policies to users.   
1. Browse to **Global Secure Access** > **Secure** > **Security profiles**.   
1. Select the security profile you wish to modify.
1. Switch to the **Link policies** view.
1. Link an ATP policy:    
    1. Select **+ Link a policy** > **Existing Threat Protection policy**. 
    1. From the **Policy name** menu, choose the Threat Protection policy you created.   
    1. Leave **Position** and **State** set to the defaults.   
    1. Select **Add**.   
1. Link a DLP policy:   
    1. Select **+ Link a policy** > **Existing Netskope DLP policy**. 
    1. From the **Policy name** menu, choose the DLP policy you created.
    1. Leave **Position** and **State** set to the defaults.   
    1. Select **Add**.      
1. Link a TLS inspection policy:   
    1. Select **+ Link a policy** > **Existing TLS inspection policy**. 
    1. From the **Policy name** menu, choose the TLS inspection policy you created.   
    1. Leave **Priority** and **State** set to the defaults.
    1. Select **Add**. 
1. Close the Security Profile.   

To prevent confusion between Microsoft and Netskope policies, Netskope policies include **NS** in their priority listing. The platform evaluates Microsoft security policies first. The traffic then goes to Netskope, which applies ATP and DLP policies before sending the traffic to its destination.

:::image type="content" source="media/concept-netskope-integration/link-policies.png" alt-text="Screenshot of the Link policies view showing the NS marker that identifies Netskope ATP and DLP policies.":::

> [!NOTE]
> Don't use the baseline security profile to enforce ATP and DLP policies, as the baseline security profile isn't supported during this preview.

### Create a conditional access policy to enforce ATP, DLP, and TLS inspection policies 
To enforce the Global Secure Access security profile and TLS inspection policy, create a conditional access policy using the following details. For more information, see [Create and link Conditional Access policy](how-to-configure-web-content-filtering.md#create-and-link-conditional-access-policy).  

|**Policy detail**   | **Description**   |
|--------------------|-------------------|
|**Users**   | Select your test users.   |
|**Target resources**   | All internet resources with Global Secure Access.   |
|**Session**   | Use the Global Secure Access security profile you created.   |

### Validate your configuration 
Due to token life validity on the Global Secure Access client, changes to the Security Profile policy or the ATP policy can take up to one hour to apply. 

To ensure that TLS inspection works as expected, be sure to disable QUIC protocol support for your browsers. To disable QUIC, see [QUIC not supported for Internet Access](troubleshoot-global-secure-access-client-diagnostics-health-check.md#quic-not-supported-for-internet-access). For more detail, see the troubleshooting section [TLS inspection only works on some sites](#tls-inspection-only-works-on-some-sites).   

> [!IMPORTANT]
> Before proceeding, validate your configuration settings.   
 
To validate your configuration settings:
1. Validate that the client device has the Global Secure Access client installed.
1. Validate that the corresponding Security Profile using Conditional Access is enforced.
1. Browse to [netskope.com/url-lookup](https://www.netskope.com/url-lookup).   

**Success**: If you see a search field and **Search** button, Netskope is analyzing your traffic and the policies are in effect.
:::image type="content" source="media/concept-netskope-integration/lookup-success.png" alt-text="Netskope URL Lookup Success":::

**Failure**: If you see the message, "The URL Lookup is only available for Netskope customers. Use a Netskope steering method to access this service.", the test failed. Check the [Troubleshooting section](#troubleshooting) for guidance.   
:::image type="content" source="media/concept-netskope-integration/lookup-fail.png" alt-text="Screenshot showing Netskope URL Lookup failure message"::: 

### Test ATP policies   
To test your ATP policies, we recommend using the European Institute for Computer Antivirus Research (EICAR) anti-malware test file. Feel free to engage your security or red teams for more advanced testing. For the EICAR test:
1. Sign in to the test device using a test user targeted by the Conditional Access policy you created. 
1. Download the [EICAR test file](http://secure.eicar.org/eicar_com.zip). If Microsoft Defender SmartScreen blocks the download, select **More actions**, and then select **Keep**.
1. Disable QUIC protocol support for your browsers. To disable QUIC, see [QUIC not supported for Internet Access](troubleshoot-global-secure-access-client-diagnostics-health-check.md#quic-not-supported-for-internet-access).    
   
### Test DLP policies 
To test the DLP policy:
1. Validate **DLP-PCI** and **DLP-PII** DLP profiles as suggested in the [Create a DLP policy](#create-a-dlp-policy) section.
1. Open a test file that contains PCI and PII data, such as [dlptest.com/sample-data.pdf](https://dlptest.com/sample-data.pdf).      
1. If the policy is configured properly, the action is blocked with the following message:   

'**Non-compliant action**. The current operation is blocked by your IT administrator.'

## Monitoring and logging    
Check alerts by going to **Global Secure Access** > **Dashboard**. 

### Threat alerts   
To view threat alerts, go to **Global Secure Access** > **Alerts**. 
:::image type="content" source="media/concept-netskope-integration/threat-alerts-dashboard.png" alt-text="Screenshot of the Alerts dashboard showing a list of detected alerts.":::   

More reporting might be available depending on the type of threat, such as **Malware detected** or **Data loss prevention**. Select the alert **Description** to inspect the alert type and view more details. 
1. Expand the **Entities** section.
1. Switch to the **File hash** tab.   
1. To download the Structured Threat Information eXpression threat report, select **Download malware STIX report**.   
1. To download detonation images, if available, select **Download additional malware details**.   
:::image type="content" source="media/concept-netskope-integration/file-hash-links.png" alt-text="Screenshot of the Entities section with malware download links highlighted.":::   
1. To view the threat URL, switch to the **URL** tab.

### Traffic logs   
To view traffic logs, go to **Global Secure Access** > **Monitor** > **Traffic logs**.

To show all traffic subject to Netskope inspection:
1. Go to the **Transactions** tab.
1. Select **Add filter**.
1. Search for or scroll to find the **Vendor names** filter.
1. Enter `Netskope` in the field to show only Netskope traffic.
1. Select **Apply**.      
:::image type="content" source="media/concept-netskope-integration/traffic-logs-filter.png" alt-text="Screenshot of the Traffic logs with the Vendor names contains Netskope filter highlighted.":::   

This sample shows an event triggered by an ATP policy with blocked content. Check the **filteringProfileName** and **policyName** to identify the policies responsible for the applied action.     

```json
{
    "action": "Block",
    "agentVersion": "1.7.669",
    "connectionId": "0000000000000000.0.0",
    "createdDateTime": "07/25/2024, 05:00 PM",
    "destinationFQDN": "secure.eicar.org",
    "destinationIp": "172.16.0.0",
    "destinationPort": "0000",
    "destinationWebCategory/displayName": "General,IllegalSoftware",
    "deviceCategory": "Client",
    "deviceId": "00001111-aaaa-2222-bbbb-3333cccc4444",
    "deviceOperatingSystem": "Windows 10 Pro",
    "deviceOperatingSystemVersion": "10.0.19045",
    "filteringProfileId": "11112222-bbbb-3333-cccc-4444dddd5555",
    "filteringProfileName": "ATP Profile",
    "headers/origin": "secure.eicar.org",
    "headers/referrer": "secure.eicar.org/text.html",
    "headers/xForwardedFor": "10.0.0.0",
    "initiatingProcessName": "chrome.exe",
    "networkProtocol": "IPv4",
    "policyId": "22223333-cccc-4444-dddd-5555eeee6666",
    "policyName": "Block Malware",
    "policyRuleId": "33334444-dddd-5555-eeee-6666ffff7777",
    "policyRuleName": "*",
    "receivedBytes": "14.78 KB",
    "resourceTenantId": "",
    "sentBytes": "0 bytes",
    "sessionId": "",
    "sourceIp": "clipped",
    "sourcePort": "00000",
    "tenantId": "44445555-eeee-6666-ffff-7777aaaa8888",
    "trafficType": "Internet",
    "transactionId": "55556666-ffff-7777-aaaa-8888bbbb9999",
    "transportProtocol": "TCP",
    "userId": "66667777-aaaa-8888-bbbb-9999cccc0000",
    "userPrincipalName": "user@contoso.com",
    "vendorNames": "Netskope"
}
```

## Troubleshooting 
Try the following recommendations if you experience issues while configuring or using the Global Secure Access Advanced Threat Protection (ATP) and DLP integration with Netskope.

### I can't create a Netskope ATP or DLP policy   
Check if you have an active Netskope offer. 

### I can't purchase a Netskope offer, or the status shows as failed 

> [!IMPORTANT]
> You must set up TLS inspection before purchasing Netskope offer from the marketplace.

To enable TLS inspection, follow the steps in [Configure Transport Layer Security Inspection](how-to-transport-layer-security.md).    

### I configured TLS inspection and now get errors browsing the internet 
If you see errors like "Your connection isn't private" or other certificate errors, check that
- You imported the Certificate Authority certificate used to sign the TLS inspection certificate to the device.
- You placed the Certificate Authority certificate in the correct certificate store, **Trusted Root Certificate Authorities**.   

### Check that TLS inspection is working correctly 
To check if TLS inspection is working correctly, go to the website you'd like to check, select the **View site information** icon, and then select **Connection is secure**. Select the **Show certificate** icon and validate the issuer of the certificate is **Microsoft Global Secure Access Intermediate**. The presence of this certificate issuer indicates Microsoft intercepted the TLS session.   
:::image type="content" source="media/concept-netskope-integration/certificate-viewer.png" alt-text="Screenshot of the Certificate Viewer dialog showing the issuer of the certificate is Microsoft Global Secure Access Intermediate.":::      
 
If you configured TLS inspection correctly, waited at least 10 minutes after configuring it, and still don't see TLS sessions issued by Microsoft Global Secure Access Intermediate, check the configuration of your host file. 
   
### TLS inspection only works on some sites 
The Global Secure Access client doesn't currently intercept requests using the QUIC protocol. The Global Secure Access client has a check for QUIC status within **Advanced diagnostics** > **Health check**. To disable QUIC in your browser, see [QUIC not supported for Internet Access](troubleshoot-global-secure-access-client-diagnostics-health-check.md#quic-not-supported-for-internet-access). 

### Check which Netskope web category a URL maps to 
To ensure Netskope policies are set to the correct web or application categories, refer to the Netskope URL categorization lookup: [www.netskope.com/url-lookup](https://www.netskope.com/url-lookup). To successfully access the lookup tool, the request must go through Netskope proxies, which requires at least one Netskope policy to be configured and linked to the security profile in use. **Note**: web categories Education, Government, Finance, and Health and Medicine aren't inspected by default. 

### Check if Netskope ATP is analyzing your traffic 
To test if Netskope's ATP engine is analyzing traffic, check the test machine's egress IP address by going to [iplocation.net](https://iplocation.net). Check the ISP field to confirm whether traffic is routed through Netskope's ATP engine.   
:::image type="content" source="media/concept-netskope-integration/ip-location.png" alt-text="Screenshot of the IP Location website with the ISP field showing that the traffic is routed through Netskope.":::    
 
> [!NOTE]
> If you can't access either of the lookup websites on the test machine with Netskope ATP policy active, and the policy has a **default** action set to block, the block might be due to policy rules.    

## Known limitations
Known limitations for Advanced Threat Protection include:
- The baseline security profile doesn't support enforcing ATP or DLP policies in this preview. Use Security Profiles and Conditional Access to assign threat protection policies to users.
- Firefox isn't supported. 

## Frequently asked questions (FAQ) 
### What threat efficacy does Netskope ATP provide?
Netskope ATP provides Fast Scan and Deep Scan options.   
* Fast Scan is the default option. It provides real-time (T+0) scans using Netskope's standard threat protection.
* Deep Scan provides more thorough T+1-hour scans using Netskope's advanced threat protection.
 
### Are there any recommended threat protection policies?  
Yes, Netskope recommends creating these two category-based policies for threat protection:

|Policy  |Destination categories  |Activities  |Severity-based action  |Patient Zero  |
|---------|---------|---------|---------|---------|
|Policy 1 (without Patient Zero)  |All (Select all the categories in the destinations list)  |Upload and Download  |'Block' for all  |Not enabled  |
|Policy 2 (with Patient Zero)  |Newly registered domains, Newly observed domains, Parked Domains, Uncategorized, Web Proxies/Anonymizers  |Upload and Download  |'Block' for all  |Enabled  |

> [!NOTE]
> For the Netskope advanced threat protection policy, the patient zero setting only applies to binary and executable files (for more detail, see [Supported File Types for Detection](https://docs.netskope.com/en/supported-file-types-for-detection/)). When the patient zero setting is enabled, only binary and executable files are sent for threat scanning. The threat engine blocks new files until it reaches a verdict. Because of the default blocking nature, it's a good practice to enable the threat protection policies in the preceding table.   
 
### What is the pricing of Microsoft products and Netskope functionality? 
Microsoft Entra Internet Access and Microsoft Entra Private Access are part of the Microsoft Entra Suite. For details, see [Microsoft Entra plans and pricing](https://www.microsoft.com/en-us/security/business/microsoft-entra-pricing). You can purchase the Netskope offer through the Microsoft Entra in-product marketplace. The offer is free during preview and follows per-user pricing when the functionality is generally available. 
 
### What activities do Netskope threat engines support? 
Netskope threat engines support three activities: **Upload**, **Download**, and **Browse**.     

By default, Netskope scans traffic categorized as 'Browse,' so you don't need to configure a policy. You can configure 'Upload' and 'Download' via policies that match your requirements. For more information on Netskope web activities and policy usage, see Netskope's documentation on [Real-time Protection Policies](https://docs.netskope.com/en/inline-policies/).  

### How can I customize or modify DLP profiles to suit organizational policies?  
The current phase of this integration offers customers out-of-the-box DLP profiles. These profiles cover predefined data identifiers and personal identifiers, including financial data, medical data, biodata, inappropriate terms, and industry-specific information. These predefined profiles can't be customized. Customizable DLP entities like data identifiers and DLP profiles are planned for future versions of this integration.  

Learn more about Netskope Threat Protection in these articles:  
- [Netskope Threat Protection overview](https://www.netskope.com/netskope-one/threat-protection)  
- [Netskope Threat Protection documentation](https://docs.netskope.com/en/threat-protection/)  
- [Netskope Data Loss Prevention](https://www.netskope.com/products/data-loss-prevention)

## Related content

- [Learn about Security Service Edge (SSE) coexistence with Microsoft and Netskope](concept-netskope-coexistence.md)
- [Configure Transport Layer Security inspection](how-to-transport-layer-security.md)   
