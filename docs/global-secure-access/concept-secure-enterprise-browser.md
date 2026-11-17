---
title: Secure Enterprise Browser Overview (Preview)
description: Learn how secure enterprise browser combines Microsoft Edge and Global Secure Access for private web apps and protected internet and Microsoft 365 browsing.
ms.topic: concept-article
ms.date: 11/13/2026
ms.custom: msecd-doc-authoring-1026
ai-usage: ai-generated
ms.author: alexpav
# Customer intent: As an IT administrator, I want to understand secure enterprise browser capabilities so that I can plan browser-only access for employees and protect browsing on company-owned kiosks and VDI devices.
---

# Secure enterprise browser overview (preview)

Secure enterprise browser integrates Microsoft Edge with Global Secure Access (GSA) for browser-based access to private web applications. It also protects internet and Microsoft 365 traffic without installing the Global Secure Access client. Microsoft Entra Conditional Access steers users to sign in to Microsoft Edge using their work account. Edge Management Service (EMS) delivers the GSA policy to Edge. Edge uses the traffic forwarding policy calculated from your Global Secure Access traffic forwarding profiles.

This article explains the supported scenarios, how traffic forwarding works, and the limitations of the preview. The preview supports Microsoft Edge on Windows and macOS.

## Browser-only access scenarios

You can use secure enterprise browser when you want to allow access to private web applications and when you want to protect user's browsing activities using Global Secure Access policies, without deploying the GSA client software or requiring a managed device.

- **Limited browser-only access for your users with Entra ID work accounts.** Give employees access to selected private web applications through Edge, rather than deploying a client for access from other applications. Use Global Secure Access traffic forwarding profiles and application assignments to define the resources available to those users.
- **Company-owned kiosks.** Protect internet access on Windows kiosks where employees use Edge with their work accounts.
- **Virtual desktop infrastructure (VDI).** Provide employees with access to private web applications and protect their internet access in Edge on Windows VDI devices without installing the Global Secure Access client.

> [!NOTE]
> These scenarios require users to sign in to Edge with a work account in your tenant. Business-to-business (B2B) guest accounts aren't supported because users can't sign in to Edge with a B2B guest account.

## Traffic forwarding and policy

Global Secure Access calculates the user's traffic forwarding policy from traffic forwarding profiles, just as it does for the Global Secure Access client. Edge retrieves that policy and uses it to forward browser traffic to the service.

There are three configuration elements for secure enterprise browser connectivity:

- **Global Secure Access Microsoft Edge Configuration** determines which traffic types are enabled for Edge and which forwarding profiles and rules apply to the user. Here, you can selectively enable Internet Access (which includes Microsoft 365), Private Access, or both.
- **Global Secure Access Traffic Forwarding Configuration** determines the resulting traffic forwarding policy for the signed-in user.
- **Edge Management Experience (EMX) policy** enables the integration in Edge - it instructs Edge to follow the traffic forwarding policy for the signed-in user.

For background on profile configuration, see [Global Secure Access traffic forwarding profiles](concept-traffic-forwarding.md).

## Supported traffic profiles

You can enable Internet Access and Private Access for Microsoft Edge independently. Microsoft 365 traffic is enabled together with Internet Access in the browser enablement configuration.

| Traffic profile | Preview support |
| --- | --- |
| **Internet** | Supported. Global Secure Access applies Microsoft Entra Internet Access policies, including Transport Layer Security (TLS) inspection and bypass policies. |
| **Microsoft 365** | Supported. Enabled together with Internet Access for Edge. The Microsoft traffic forwarding profile determines how Microsoft 365 traffic is forwarded. No TLS inspection, no web filtering policies. |
| **Private Access** | Supported for private web applications configured by fully qualified domain name (FQDN). |
| **Microsoft Entra** | Not supported. |

Global Secure Access delivers TLS inspection certificate trust automatically to Edge. You don't need to deploy the TLS inspection certificate to user's devices or to Microsoft Edge profiles. You still configure the certificate and TLS inspection policies in Global Secure Access.

## Preview requirements and limitations

Plan your deployment around these preview boundaries:

- **Platforms:** Microsoft Edge on Windows and macOS.
- **Global Secure Access client coexistence:** On Windows, running the Global Secure Access client while Microsoft Edge is configured for Global Secure Access is supported. On macOS, this coexistence isn't supported. Enabling the client while Edge is configured for Global Secure Access results in unexpected mutual TLS (mTLS) certificate prompts presented to the user.
- **Minimum Edge version:** 157.0.4341.46.
- **Browser configuration:** EMS policy is the only supported configuration method. Intune app policies aren't supported for enabling this integration in the preview.
- **Identity:** Users sign in to Edge with a work account in the tenant configured for Global Secure Access. B2B guest accounts aren't supported.
- **Microsoft Entra ID traffic:** The Microsoft Entra traffic profile isn't supported. Compliant network checks and universal tenant restrictions for Microsoft Entra ID aren't supported by this preview.
- **Private name resolution:** Private DNS isn't supported. Configure private web applications by FQDN rather than relying on IP-only application definitions to provide private name resolution.

## Next step

> [!div class="nextstepaction"]
> [Configure Global Secure Access secure enterprise browser settings](how-to-configure-global-secure-access-browser-settings.md)

## Related content

- [Global Secure Access traffic forwarding profiles](concept-traffic-forwarding.md)
- [Explicit Forward Proxy overview](concept-explicit-forward-proxy.md)
- [Global Secure Access traffic logs](how-to-view-traffic-logs.md)
