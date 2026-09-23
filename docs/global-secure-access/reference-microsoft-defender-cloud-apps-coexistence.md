---
title: Global Secure Access and Microsoft Defender for Cloud Apps coexistence
description: Learn how to configure Microsoft Entra Internet Access and Microsoft Defender for Cloud Apps side by side without proxying traffic twice.
author: kerensemel
ms.author: kerensemel
ms.service: global-secure-access
ms.topic: reference
ms.date: 07/31/2026
ai-usage: ai-assisted
#customer intent: As a security or identity administrator running both Microsoft Entra Internet Access and Microsoft Defender for Cloud Apps, I want to configure the two products to work together so that traffic isn't proxied more than once and each product's controls stay effective.
---

# Global Secure Access and Microsoft Defender for Cloud Apps coexistence

Microsoft provides both a cloud access security broker in Microsoft Defender for Cloud Apps and a secure web gateway in Microsoft Entra Internet Access. Because both technologies can proxy internet-bound traffic, use this article to configure them side by side and avoid proxying traffic more than once.

## Summary of Microsoft Entra Internet Access

Microsoft Entra Internet Access is a cloud-delivered secure web gateway solution within Global Secure Access. By deploying the Global Secure Access client to your managed devices, you can securely tunnel internet-bound traffic and enforce a range of security capabilities inline. Unlike a cloud access security broker, Internet Access acquires all internet traffic, so you can enforce policy beyond Enterprise Apps integrated with Microsoft Entra ID. For the full capability set, see [Learn about Microsoft Entra Internet Access](/entra/global-secure-access/concept-internet-access).

The Microsoft Entra Internet Access capabilities relevant to Defender for Cloud Apps coexistence are:

| Capability | Reference |
|---|---|
| Web content filtering (category and fully qualified domain name) | [Configure web content filtering](/entra/global-secure-access/how-to-configure-web-content-filtering) |
| Transport Layer Security inspection (enables URL and content-level filtering) | [Enable Transport Layer Security inspection](/entra/global-secure-access/tutorial-internet-access-tls-inspection) |
| Threat intelligence | [Configure threat intelligence](/entra/global-secure-access/how-to-configure-threat-intelligence) |
| Prompt injection protection (Prompt policies), delivered through AI Gateway within Internet Access | [Protect generative AI apps with prompt injection protection](/entra/global-secure-access/how-to-ai-prompt-injection-protection) |
| Network content filtering and data loss prevention (block or allow by MIME type) | [Configure network content filtering](/entra/global-secure-access/how-to-network-content-filtering) |
| Microsoft Purview Data Loss Prevention integration (sensitive information types in file uploads) | [Configure a data loss prevention profile](/entra/global-secure-access/how-to-full-data-loss-protection) |
| Netskope Advanced Threat Protection and data loss prevention integration | [Netskope Advanced Threat Protection and data loss prevention integration](/entra/global-secure-access/concept-netskope-integration) |
| Cloud firewall (non-HTTP traffic; now scoped to Remote Networks branch internet traffic only) | [Configure cloud firewall](/entra/global-secure-access/how-to-configure-cloud-firewall) |

> [!NOTE]
> Internet Access currently acquires TCP traffic only. UDP and QUIC aren't yet supported for Internet Access; traffic to UDP ports 80 and 443 isn't tunneled, and clients fall back to HTTPS over TCP. UDP and QUIC are supported for Private Access and Microsoft 365 workloads, but those are outside the scope of this article.

## Summary of Microsoft Defender for Cloud Apps

While Microsoft Defender for Cloud Apps was initially a standard cloud access security broker solution, it has since expanded significantly to provide holistic SaaS platform security. Its current capabilities span four pillars:

- **Fundamental cloud access security broker functionality** including Shadow IT discovery, visibility into cloud app usage, threat protection, and information protection and compliance assessments.
- **SaaS security posture management** enabling security teams to assess and improve the security configuration of SaaS applications.
- **Advanced threat protection** as part of Microsoft Defender XDR, providing correlation of signals across the full attack kill chain.
- **App-to-app protection** extending threat detection to OAuth-enabled apps that have permissions and privileges to critical data and resources.

The following Microsoft Defender for Cloud Apps capabilities are the focus of this article.

- Application discovery
- Data loss prevention
- Blocking unsanctioned apps
- Threat Protection

Each of these capabilities can be used side-by-side with Microsoft Entra Internet Access, though some have specific configuration requirements.

## Comparing overlapping capabilities

The following sections provide a detailed comparison for each area where Global Secure Access and Microsoft Defender for Cloud Apps have overlapping or complementary capabilities.

### App discovery

Both products provide application discovery, but they approach it differently.

**Microsoft Defender for Cloud Apps** receives traffic logs from solutions that interface directly with user devices' network traffic, such as Microsoft Defender for Endpoint, third-party firewalls, or proxy appliances. From these logs, Defender for Cloud Apps generates a Cloud Discovery report that identifies which cloud applications users are accessing, assigns risk scores from a catalog of over 31,000 cloud apps evaluated against 90+ risk factors, and flags shadow IT. Learn more: [Cloud app catalog and risk scores](/defender-cloud-apps/risk-score).

**Global Secure Access** now provides native application discovery directly from its own traffic data, without requiring a separate log source. Because Internet Access acquires all internet-bound traffic from managed devices, Global Secure Access can identify both cloud and private applications that users connect to. The Insights and Analytics dashboard in Global Secure Access provides visibility into total cloud and private applications discovered, usage distribution and trends over time, per-application drill-down, and a dedicated generative AI apps filter to identify shadow AI usage. Similar per-app risk assessments are available in both Global Secure Access and Defender for Cloud Apps, though the Global Secure Access report is enhanced with detailed usage telemetry and does not require additional log configurations. Learn more: [Application usage analytics](/entra/global-secure-access/overview-application-usage-analytics) and [Discover applications and shadow IT](/entra/global-secure-access/tutorial-internet-access-application-discovery).

**Coexistence considerations:** Application discovery does not impact network performance in either product. On iOS and Android, Global Secure Access uses the Microsoft Defender for Endpoint app as its client, so a single client serves both app discovery and secure web gateway capabilities. On Windows and macOS, the Global Secure Access client and Defender for Endpoint are separate clients; both should be installed if you want discovery from both sources. In practice, organizations benefit from using both: Global Secure Access provides native, real-time application discovery from user traffic, while Microsoft Defender for Cloud Apps provides a broader catalog integration and discovery from traffic sources such as third-party firewalls and other connectors.

### Data loss prevention

Data loss prevention is an area where both products have capabilities, but they operate at different layers and complement each other.

**Microsoft Defender for Cloud Apps** integrates with Microsoft Purview to provide data loss prevention through two mechanisms. First, API-based file policies scan data at rest in connected SaaS applications for sensitive content, and can apply sensitivity labels, quarantine files, or delete them. Second, session policies via Conditional Access App Control can block or protect file downloads and uploads in real time during a user's session with a sanctioned Enterprise App. Session policies can require files to be labeled and encrypted via Microsoft Purview Information Protection rather than blocking outright, and can prevent uploads of unlabeled files.

**Global Secure Access** provides data loss prevention at the network layer through content policies. Basic content policies, which are generally available, can block or allow file uploads and downloads by MIME type across all internet destinations. With Transport Layer Security inspection enabled, Global Secure Access gains full visibility into URLs, request and response content, and file transfers, enabling deeper content inspection. Integration with Microsoft Purview Data Loss Prevention (preview) extends this further: organizations can configure Microsoft Purview Data Loss Prevention policies that scan file content inline for sensitive information types and sensitivity labels before uploads reach unsanctioned destinations. This is particularly valuable for blocking sensitive data from reaching generative AI applications such as ChatGPT, where Microsoft Defender for Cloud Apps session policies do not apply because these are not sanctioned Enterprise Apps.

**Coexistence considerations:** These capabilities are complementary rather than overlapping. Both products integrate with Microsoft Purview as the primary data loss prevention engine. Use Microsoft Defender for Cloud Apps for data loss prevention on sanctioned SaaS apps where you need API-based scanning of data at rest and session-level controls with labeling and encryption. Microsoft Defender for Cloud Apps can also cover access from unmanaged devices where installation of a Global Secure Access client isn't available. Use Global Secure Access for network-wide data loss prevention that covers all internet traffic, particularly for unauthorized apps and generative AI destinations where Microsoft Defender for Cloud Apps has no session-level reach.

### Blocking unsanctioned apps

Both products can block users from accessing cloud applications deemed risky or unapproved, but through different enforcement mechanisms.

**Microsoft Defender for Cloud Apps** allows administrators to mark applications as unsanctioned in the Cloud App Catalog. Enforcement of the block is then handled by an integrated network solution, typically Microsoft Defender for Endpoint or a third-party firewall or proxy appliance that receives block scripts from Defender for Cloud Apps.

**Global Secure Access** blocks unsanctioned apps directly at the network layer through web content filtering policies. Administrators create filtering rules that deny access by fully qualified domain name, URL with Transport Layer Security inspection, or web category. These rules are enforced inline as traffic passes through the Global Secure Access service edge, and they integrate with Conditional Access policies so that blocks can be scoped to specific users, groups, or device states.

**Coexistence considerations:** These enforcement mechanisms are redundant—both block unsanctioned apps, but at different layers. Microsoft Defender for Cloud Apps uses Microsoft Defender for Endpoint to enforce blocks at the device level, while Global Secure Access enforces blocks inline at the network level through web content filtering. Both can be active simultaneously, with Microsoft Defender for Endpoint evaluating traffic first, but running both is unnecessary. Admins should generally pick one. A key difference is that Microsoft Defender for Endpoint policy is assigned per device, whereas Global Secure Access policy is assigned per user, making Global Secure Access generally easier to implement and manage at scale.

### Threat protection

Both products provide threat protection, but they address different parts of the threat landscape.

**Microsoft Defender for Cloud Apps** provides threat protection through API-based file scanning that checks uploads to connected SaaS apps against Microsoft Threat Intelligence for malware signatures. Beyond file scanning, Defender for Cloud Apps provides behavioral analytics within Microsoft Defender XDR that detect anomalies such as impossible travel, credential access from unusual locations, and abnormal download patterns. These signals correlate across the full attack kill chain with other Microsoft Defender products.

**Global Secure Access** Threat Intelligence blocks access to known malicious web destinations and updates continuously as new intelligence signals become available. Global Secure Access also provides unique prompt injection protection for generative AI apps with its prompt policies. This prevents malicious prompts from reaching AI apps without the need for app-side code changes. Global Secure Access has expanded its inline threat protection through the Netskope Advanced Threat Protection integration, which is generally available. This integration provides real-time malware scanning, zero-day vulnerability protection, and data leak prevention for all internet-bound traffic flowing through the Global Secure Access service edge. Unlike Microsoft Defender for Cloud Apps threat protection, which applies only to connected sanctioned apps, Global Secure Access with Netskope Advanced Threat Protection applies to all internet traffic regardless of whether the destination is a sanctioned application. For setup details, see [Global Secure Access integration with Netskope's Advanced Threat Protection and Data Loss Prevention](/entra/global-secure-access/concept-netskope-integration). Global Secure Access does not yet have a Microsoft-native threat protection solution.

**Coexistence considerations:** Use both for defense in depth. Global Secure Access with Netskope provides broad inline threat protection across all internet traffic, while Microsoft Defender for Cloud Apps provides deeper behavioral analytics and Microsoft Defender XDR correlation for sanctioned SaaS applications. There is no conflict between the two, as Global Secure Access operates at the network layer and Microsoft Defender for Cloud Apps operates at the application and API layer. Admins can integrate Global Secure Access traffic logs with Microsoft Sentinel for additional threat signals to improve threat detection and increase security.

### Session controls

Both Global Secure Access and Defender for Cloud Apps provide session controls, but each offers different levels of granularity.

**Microsoft Defender for Cloud Apps** provides granular in-session controls through Conditional Access App Control, delivered via either Edge for Business or the Microsoft Defender for Cloud Apps reverse proxy. These controls include blocking downloads of sensitive documents on unmanaged devices, protecting downloads by requiring files to be labeled and encrypted, blocking uploads of unlabeled or sensitive files, blocking copy-to-clipboard, print, and custom activities, scanning uploads and downloads for malware in real time, requiring step-up authentication when a sensitive action occurs mid-session, and monitoring all session activity for audit and compliance.

**Global Secure Access** provides HTTP and HTTPS session-level controls. Global Secure Access data loss prevention operates inside the HTTPS transport session, providing general file controls such as block, allow, and scan with Microsoft Purview. Global Secure Access is content-aware and identity-aware, but unaware of unique app semantics. Global Secure Access requires additional configuration, such as [installing the Global Secure Access client](/entra/global-secure-access/how-to-install-windows-client) and [configuring Explicit Forward Proxy](/entra/global-secure-access/how-to-configure-explicit-forward-proxy), including the proxy automatic configuration file, to acquire traffic. This configuration might not be feasible for all unmanaged device scenarios. Global Secure Access is best suited for managed devices.

**Coexistence considerations:** Use one or the other for specific session controls to avoid double proxying the traffic.

| If your priority is... | Choose this product | Why |
|---|---|---|
| App-aware controls for sanctioned SaaS apps in a browser session | Microsoft Defender for Cloud Apps | It understands app-specific user actions and supports controls such as block download, protect on download, block copy and print, and step-up authentication during the session. |
| Coverage for unmanaged devices or partner browser access | Microsoft Defender for Cloud Apps | It can enforce browser-based session controls without requiring the Global Secure Access client on the endpoint. |
| Managed-device controls across general internet traffic | Microsoft Entra Internet Access | It applies forward-proxy controls across many destinations and is better suited for network-layer enforcement than app-specific session semantics. |
| Controls for unsanctioned apps, generative AI destinations, or broad web usage categories | Microsoft Entra Internet Access | It can enforce policy across internet-bound traffic even when the destination isn't a sanctioned Enterprise app. |
| A single user needing both experiences | Split by app path | Route sanctioned SaaS browser sessions through Defender for Cloud Apps and keep general web traffic on Internet Access so the same flow isn't proxied twice. |

## Configure Global Secure Access and Microsoft Defender for Cloud Apps side by side

> [!NOTE]
>
> The Global Secure Access procedures in this section require the **Global Secure Access Administrator** role. Creating or editing Conditional Access policies requires the **Conditional Access Administrator** role. For the Microsoft Defender for Cloud Apps steps, use an account with the appropriate Defender for Cloud Apps administrative permissions for your organization.

### Avoid double proxying

When using both products, special considerations should be taken to ensure that traffic is not proxied more than once, for example, proxied through Microsoft Entra Internet Access and then again through Defender for Cloud Apps' reverse proxy.

You can configure the Global Secure Access client to bypass the acquisition of any traffic bound for Defender for Cloud Apps, ensuring mutually exclusive network proxying depending on the intended proxy.

1. Browse to the [Microsoft Entra admin center](https://entra.microsoft.com).
1. Select **Global Secure Access** > **Connect** > **Traffic forwarding**.
1. Select **View** under **Internet access policies**.
1. Expand **Custom Bypass**.
1. Select **Add rule** and enter the following:
    - **Destination Type:** FQDN
    - **Destination:** `*.mcas.ms`
1. Select **Save**.

> [!IMPORTANT]
>
> For each app and user path, decide which product owns the inline session. Use Microsoft Defender for Cloud Apps when you need browser-based reverse proxy controls for sanctioned SaaS apps. Use Microsoft Entra Internet Access when you need forward-proxy controls for general internet traffic. Don't rely on both products to inspect the same browser flow unless you explicitly test the combined behavior.

### App discovery requirements

App discovery doesn't require a special coexistence policy, but it does require the correct telemetry sources on each platform.

- On Windows and macOS, deploy both the Global Secure Access client and Microsoft Defender for Endpoint if you want both native Global Secure Access discovery and Defender for Cloud Apps discovery.
- On iOS and Android, use Microsoft Defender for Endpoint as the client for Global Secure Access so the same mobile client can support both services.
- If you use Defender for Cloud Apps for discovery beyond traffic managed by Global Secure Access, keep your existing third-party firewall or proxy log connectors in place.

### Data loss prevention configuration requirements

Use different enforcement paths for different use cases instead of trying to make one product cover every data loss prevention scenario.

1. For sanctioned SaaS apps where you need session controls such as block download, protect on download, or block unlabeled uploads, configure Microsoft Defender for Cloud Apps Conditional Access App Control.
1. In Microsoft Entra Conditional Access, create a policy for the sanctioned SaaS apps and set **Session** to **Use Conditional Access App Control**.
1. In Microsoft Defender for Cloud Apps, create the access policies and session policies that apply to those apps.
1. If you need to prevent users from bypassing those controls, block native client access and allow browser-based sessions only.
1. For internet-wide data loss prevention on managed devices, enable the Internet access traffic forwarding profile in Global Secure Access and verify that user traffic is routed through the service.
1. If you want URL-level inspection, content inspection, or file inspection over HTTPS, configure and link a Transport Layer Security inspection policy before you enforce data loss prevention policies.
1. For basic network data loss prevention, create the appropriate Internet Access content or data loss prevention policy, link it to a Global Secure Access security profile, and deliver that profile through a Conditional Access policy that targets **All internet resources with Global Secure Access**.
1. For Netskope-backed data loss prevention, activate the Netskope offer, create the policy under **Global Secure Access** > **Third Party Security Solutions** > **Data loss prevention policies**, link it to the security profile, and enforce it through Conditional Access.
1. If you need a custom Netskope data loss prevention profile, create it in the Netskope admin center after opening the linked Netskope workflow from the Microsoft Entra admin center, then return to the Microsoft Entra admin center and complete the policy assignment.

### Blocking unsanctioned apps configuration requirements

Choose one primary enforcement plane for blocking unsanctioned apps.

1. If you want Microsoft Defender for Cloud Apps to drive blocking, first enable **Cloud Protection** and **Network Protection** in Microsoft Defender for Endpoint.
1. Install the Microsoft Defender Browser Protection extension on non-Microsoft browsers used in scope.
1. In Defender for Cloud Apps, mark the app as **Unsanctioned** from **Cloud Discovery** or **Cloud App Catalog**.
1. If you're using the Defender for Endpoint integration, allow time for the unsanctioned app domains to sync to endpoints and be blocked by Network Protection.
1. If you're not using the Defender for Endpoint integration, generate the block script or export the unsanctioned domains and import them into your existing network appliance.
1. If you want Global Secure Access to drive blocking instead, create a web content filtering policy that uses fully qualified domain names, URLs, or web categories for the target apps.
1. Link that web content filtering policy to a Global Secure Access security profile and assign it through Conditional Access.
1. If you need URL-based rules or HTTP method restrictions for HTTPS traffic, enable Transport Layer Security inspection so Internet Access can evaluate more than Server Name Indication.
1. During steady state, avoid maintaining the same deny list in both products unless you are actively migrating enforcement from one product to the other.

### Threat protection configuration requirements

Threat protection coexistence works best when you separate sanctioned SaaS app controls from broad internet controls.

1. Keep Microsoft Defender for Cloud Apps enabled for sanctioned SaaS applications where you want API-based malware scanning and Microsoft Defender XDR behavioral correlation.
1. For Microsoft Entra Internet Access inline threat protection, decide whether built-in threat intelligence is sufficient or whether you also need Netskope Advanced Threat Protection.
1. If you use Netskope Advanced Threat Protection, configure Transport Layer Security inspection first, because the integration requires decrypted HTTPS traffic.
1. Activate the Netskope offer from **Global Secure Access** > **Third Party Security Solutions** > **Marketplace** and validate that the offer is active.
1. Create the Netskope Advanced Threat Protection policy under **Global Secure Access** > **Third Party Security Solutions** > **Threat protection policies**.
1. Link the Netskope Advanced Threat Protection policy, and any required Transport Layer Security inspection policy, to the same Global Secure Access security profile that you deliver through Conditional Access.
1. Validate the Netskope path before broad rollout. A quick functional check is to browse to the Netskope URL lookup page from a managed test device and confirm that Netskope recognizes the traffic.
1. Keep the Defender for Cloud Apps bypass rule for `*.mcas.ms` in place so browser sessions that are intentionally routed through Defender for Cloud Apps aren't forwarded back through Internet Access.

### Session controls configuration requirements

Session controls are the area where coexistence choices matter most, because both products can sit inline.

1. Use Microsoft Defender for Cloud Apps session controls only for apps that are integrated with Microsoft Entra ID and accessed through interactive browser sign-in flows such as SAML or OpenID Connect.
1. In Microsoft Entra Conditional Access, create a policy for the target SaaS apps and set **Session** to **Use Conditional Access App Control**.
1. In Microsoft Defender for Cloud Apps, create the access policies and session policies that enforce the required controls.
1. For browsers other than Microsoft Edge, expect the session to redirect through a Defender for Cloud Apps reverse proxy that uses the `*.mcas.ms` suffix. Keep the Global Secure Access bypass rule so this redirected traffic isn't acquired again.
1. If the business requirement is to prevent bypass, block unsupported native clients and limit access to supported browser sessions.
1. Remember that Defender for Cloud Apps session controls don't apply to every desktop client. For example, Microsoft Teams desktop isn't supported for Conditional Access App Control session controls.
1. Use Global Secure Access session-level controls when you need managed-device forward-proxy enforcement for general internet traffic rather than app-specific reverse-proxy controls.
1. Apply those Global Secure Access controls by linking the required web content filtering, Transport Layer Security inspection, data loss prevention, or threat protection policies to a security profile and assigning that profile through Conditional Access.
1. For a given app and user path, pick one product to own the inline session-control experience and document that decision in your access design.

## Summary of overlapping capabilities

| Capability | Microsoft Defender for Cloud Apps | Microsoft Entra Internet Access |
|---|---|---|
| **App Discovery** | Yes, with a built-in report based on traffic logs from Microsoft Defender for Endpoint or third-party sources | Yes, with native app discovery for internet traffic. IPv6 and UDP traffic isn't acquired or evaluated. |
| **Data loss prevention** | Yes, for integrated Enterprise apps via API connectors and session policies | Basic block or allow controls by file MIME type are generally available. Microsoft Purview Data Loss Prevention scanning for sensitive content in file uploads is in preview. |
| **Block Unsanctioned Apps** | Yes, through integration with Microsoft Defender for Endpoint or a third-party network solution | Yes, through web content filtering with fully qualified domain name and URL-based rules |
| **Threat Protection** | API-based malware scanning for connected apps, behavioral anomaly detection through Microsoft Defender XDR, and session controls that enable malware scanning of uploaded and downloaded files | Threat intelligence and Netskope Advanced Threat Protection integration for inline malware and zero-day protection on internet traffic |
| **Session Controls** | Yes, via Conditional Access App Control (Reverse Proxy) and Edge for Business | Yes (Forward Proxy) |

## Recommendation

Global Secure Access and Microsoft Defender for Cloud Apps are complementary solutions that together provide defense in depth across the network and application layers:

- **Use Microsoft Defender for Cloud Apps** for deep SaaS application security: API-based visibility and control of data in sanctioned apps, session-level policies through Edge for Business or reverse proxy, SaaS security posture management, OAuth app governance, and threat detection integrated with Microsoft Defender XDR.
- **Global Secure Access** completes the picture by securing all internet-bound traffic at the network layer: web content filtering, Transport Layer Security inspection, network data loss prevention for Enterprise and non-Enterprise apps, and cloud firewall controls.
- **Configure the bypass rule** or use Edge for Business to prevent double proxying where both solutions handle inline traffic.

For more information, see [What is Global Secure Access?](/entra/global-secure-access/overview-what-is-global-secure-access) and [Microsoft Defender for Cloud Apps overview](/defender-cloud-apps/what-is-defender-for-cloud-apps).
