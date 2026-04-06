---
title: "Tutorial: Configure threat intelligence policies"
description: Learn how to configure threat intelligence policies to automatically block known malicious sites in Global Secure Access.
ms.topic: tutorial
ms.date: 03/07/2026
ms.subservice: entra-internet-access
ms.reviewer: jebley
ai-usage: ai-assisted
ms.custom: sfi-image-nochange
---

# Tutorial: Configure threat intelligence policies

Microsoft defines high-severity threats as domains or URLs associated with active malware distribution, phishing campaigns, command-and-control (C2) infrastructure, and other threats. These threats are identified by Microsoft and third-party threat intelligence feeds with high confidence. By configuring threat intelligence, you can automatically block these known malicious web destinations.

In this tutorial, you learn how to:
> [!div class="checklist"]
> - Create a threat intelligence policy to block known malicious sites.
> - Configure an allow list for false positives or business-critical sites.
> - Link a threat intelligence policy to a security profile.
> - Verify end-user policy enforcement.

## Key concepts

> [!TIP]
> **What is threat intelligence?**
>
> Threat intelligence is curated data about known malicious domains, URLs, and IP addresses. This list is continuously updated as Microsoft aggregates intelligence from multiple sources, for example:
>
> | Source | Description |
> |--------|-------------|
> | **Microsoft Defender Threat Intelligence** | Data from Microsoft's security products protecting billions of endpoints. |
> | **Microsoft Security Research** | Findings from Microsoft's dedicated threat research teams. |
> | **Third-party feeds** | Intelligence from trusted security vendors and CERTs. |
> | **Community intelligence** | Shared indicators from the global security community. |
>
> **Examples of threats blocked ([full list](/entra/global-secure-access/reference-threat-intelligence-threat-types)):**
> - **MaliciousUrl** - URL that's serving malware.
> - **Phishing** - Indicators relating to a phishing campaign.
> - **C2** - Command and control node of a botnet.
> - **Malware** - Indicator describing a malicious file or files.
> - **CryptoMining** - Traffic involving crypto mining or resource abuse.
>
> **How threat intelligence differs from web content filtering:**
> - Web content filtering blocks by **category** (gambling, adult content).
> - Threat intelligence blocks **known bad actors** regardless of category.
> - A legitimate-looking news site that's been compromised would be blocked by threat intelligence, not web content filtering.
> - If TLS inspection is not enabled, Threat Intelligence will not protect against malicious URLs. The remaining detection types will still be detected and blocked.

## Objective

In this tutorial, you create a threat intelligence policy to block known malicious sites. You optionally configure an allow list for false positives or business-critical sites. You then link the policy to a security profile and verify end-user policy enforcement.

## Sample walkthrough videos

The following video demonstrates how to configure a threat intelligence policy:

> [!VIDEO https://www.youtube.com/embed/RBYb6ydXZ1A]

The following video demonstrates how to test a threat intelligence policy:

> [!VIDEO https://www.youtube.com/embed/fNL-3ZwDSaQ]

## Step 1: Create a threat intelligence policy

1. From the Microsoft Entra admin center, browse to **Global Secure Access > Secure > Threat intelligence policies**.
1. Select **Create policy**.
1. Enter a **name** and **description** for the policy, then select **Next**.
1. Keep the **Default Action** as **Allow**.

   > [!NOTE]
   > The default action for threat intelligence is "Allow." This means that if traffic doesn't match a rule in the threat intelligence policy (that is, no threat is detected), the policy engine allows the traffic. However, the traffic might still be evaluated and blocked by another policy type such as web content filtering.

1. Select **Next** and review your new threat intelligence policy.
1. Select **Create**.

## Step 2: Configure your allow list (optional)

If you're aware of sites that might be business-critical or are labeled as false positives, you can configure rules that allow these sites.

> [!WARNING]
> Bypassing a domain from threat intelligence is risky. Only do this if you're sure the destination is safe.

1. Under **Global Secure Access > Secure > Threat intelligence policies**, select your chosen threat intelligence policy.
1. Select **Rules**.
1. Select **Add rule**.
1. Enter a **name**, **description**, **priority**, and **status** for the rule.
1. Edit **Destination FQDNs** and select the list of domains for your allow list.

   > [!NOTE]
   > You can enter these FQDNs as comma-separated domains.

1. Select **Add**.

## Step 3: Link threat intelligence policy to security profile

1. Browse to **Global Secure Access > Secure > Security profiles**.
1. Select the security profile you created in the TLS inspection tutorial.
1. Go to the **Link policies** blade.
1. Select **Link a policy**, then select **Existing threat intelligence policy**.
1. Select the threat intelligence policy you created, then select **Add**.

> [!NOTE]
> Verify that the security profile is assigned to a Conditional Access policy.

## Step 4: Verify policy enforcement

> [!NOTE]
> After configuring a threat intelligence policy, you might need to clear your browser cache to verify policy enforcement.

1. To test, navigate to one of the following sites:
   - `entratestthreat.com`
   - `smartscreentestratings2.net`

   > [!NOTE]
   > These are test sites to validate whether security policies work, but they're benign and safe to use.

1. Verify that access to the site is blocked. Expand **More info** and verify that the ThreatType is **MaliciousUrl**.

   ![Threat intelligence block page showing MaliciousUrl threat type.](media/tutorial-internet-access-threat-intelligence/threat-intelligence-block-page.png)

1. You can also view the traffic logs and review the **Threat Type** field.

> [!NOTE]
> If blocked by Windows Defender or SmartScreen, override and access the site to test the Global Secure Access block message. You can do this by choosing **Continue to the unsafe site (not recommended)** under **More information**. Only perform this step in a lab or proof-of-concept environment, not in production.

## What you learned

In this tutorial, you accomplished the following:

1. **Enabled automated threat protection** - Your organization is now protected against thousands of known malicious sites without manually maintaining block lists. Microsoft continuously updates this threat list based on its intelligence signals.

1. **Understood the "default allow" model** - Threat intelligence policies only block traffic that matches a known threat. All other traffic passes through to be evaluated by other policies.

1. **Configured exception rules** - You learned how to bypass specific domains if needed for business reasons, though this should be done sparingly.

1. **Observed threat type classification** - The block page shows the specific threat type (MaliciousUrl, Phishing, C2, and others), helping you understand why traffic was blocked.

### Defense-in-depth strategy

```
┌─────────────────────────────────────────────────────────┐
│                 SECURITY LAYERS                         │
├─────────────────────────────────────────────────────────┤
│ Layer 1: Web Content Filtering                          │
│   • Blocks unwanted categories (gambling, adult, etc.)  │
├─────────────────────────────────────────────────────────┤
│ Layer 2: Threat Intelligence                            │
│   • Blocks known malicious destinations                 │
├─────────────────────────────────────────────────────────┤
│ Layer 3: File Controls                                  │
│   • Prevents data exfiltration via file uploads         │
├─────────────────────────────────────────────────────────┤
│ Layer 4: Microsoft Defender for Endpoint                │
│   • Last line of defense on the endpoint                │
└─────────────────────────────────────────────────────────┘
```

**Why multiple layers?**

- Threat intelligence is reactive — it only knows about threats that have been discovered.
- New malware and phishing sites are created constantly.
- Each layer catches threats the others might miss.

## Next steps

> [!div class="nextstepaction"]
> [Configure application discovery](tutorial-internet-access-application-discovery.md)
