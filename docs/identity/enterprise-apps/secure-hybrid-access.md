---
title: Secure hybrid access, protect legacy apps with Microsoft Entra ID
description: Find partner solutions to integrate your legacy on-premises, public cloud, or private cloud applications with Microsoft Entra ID.

author: gargi-sinha
manager: martinco
ms.service: entra-id
ms.subservice: enterprise-apps
ms.topic: how-to

ms.date: 01/17/2023
ms.author: gasinh
ms.collection: M365-identity-device-management
ms.custom: not-enterprise-apps

#customer intent: As an IT admin responsible for securing legacy authentication applications, I want to learn how to protect these applications by connecting them to Microsoft Entra ID, so that I can ensure the security of both on-premises and cloud applications.
---
# Secure hybrid access: Protect legacy apps with Microsoft Entra ID

In this article, learn to protect your on-premises and cloud legacy authentication applications by connecting them to Microsoft Entra ID.

* **[Application Proxy](#secure-hybrid-access-with-application-proxy)**:
  * [Remote access to on-premises applications through Microsoft Entra application proxy](/entra/identity/app-proxy)
  * Protect users, apps, and data in the cloud and on-premises 
  * [Use it to publish on-premises web applications externally](~/identity/app-proxy/overview-what-is-app-proxy.md)
  
* **[Secure hybrid access through Microsoft Entra ID partner integrations](#partner-integrations-for-apps-on-premises-and-legacy-authentication)**:

  * [Pre-built solutions](#secure-hybrid-access-through-azure-ad-partner-integrations)
  * [Apply Conditional Access policies per application](secure-hybrid-access-integrations.md#apply-conditional-access-policies)
 
In addition to Application Proxy, you can strengthen your security posture with [Microsoft Entra Conditional Access](~/identity/conditional-access/overview.md) and [Microsoft Entra ID Protection](~/id-protection/overview-identity-protection.md). 

<a name='single-sign-on-and-multi-factor-authentication'></a>

## Single sign-on and multifactor authentication

With Microsoft Entra ID as an identity provider (IdP), you can use modern authentication and authorization methods like [single sign-on (SSO)](what-is-single-sign-on.md) and [Microsoft Entra multifactor authentication](~/identity/authentication/concept-mfa-howitworks.md) to secure legacy, on-premises applications.

## Secure hybrid access with Application Proxy

Use Application Proxy to protect users, apps, and data in the cloud, and on premises. Use this tool for secure remote access to on-premises web applications. Users don’t need to use a virtual private network (VPN); they connect to applications from devices with SSO. 

Learn more:

* [Remote access to on-premises applications through Microsoft Entra application proxy](/entra/identity/app-proxy)
* [Tutorial: Add an on-premises application for remote access through Application Proxy in Microsoft Entra ID](~/identity/app-proxy/application-proxy-add-on-premises-application.md)
* [How to configure SSO to an Application Proxy application](~/identity/app-proxy/how-to-configure-sso.md)
* [Using Microsoft Entra application proxy to publish on-premises apps for remote users](~/identity/app-proxy/overview-what-is-app-proxy.md)

### Application publishing and access management

Use Application Proxy remote access as a service to publish applications to users outside the corporate network. Help improve your cloud access management without requiring modification to your on-premises applications. Plan a [Microsoft Entra application proxy deployment](~/identity/app-proxy/conceptual-deployment-plan.md).

## Partner integrations for apps: on-premises and legacy authentication

Microsoft partners with various companies that deliver pre-built solutions for on-premises applications, and applications that use legacy authentication. The following diagram illustrates a user flow from sign-in to secure access to apps and data.

   ![Diagram of secure hybrid access integrations and Application Proxy providing user access.](./media/secure-hybrid-access/secure-hybrid-access.png)

<a name='secure-hybrid-access-through-azure-ad-partner-integrations'></a>

<a name='secure-hybrid-access-through-microsoft-entra-partner-integrations'></a>

### Secure hybrid access through Microsoft Entra ID partner integrations


The following partners offer solutions to support [Conditional Access policies per application](secure-hybrid-access-integrations.md#apply-conditional-access-policies). Use the tables in the following sections to learn about the partners and Microsoft Entra integration documentation.

|Partner|Integration documentation|
|---|---|
|Akamai Technologies|[Tutorial: Microsoft Entra SSO integration with Akamai](~/identity/saas-apps/akamai-tutorial.md)|
|Citrix Systems, Inc.|[Tutorial: Microsoft Entra SSO integration with Citrix ADC SAML Connector for Microsoft Entra ID (Kerberos-based authentication)](~/identity/saas-apps/citrix-netscaler-tutorial.md)|
|Cloudflare, Inc.|[Tutorial: Configure Cloudflare with Microsoft Entra ID for secure hybrid access](cloudflare-integration.md)|
|Datawiza|[Tutorial: Configure Secure Hybrid Access with Microsoft Entra ID and Datawiza](./datawiza-configure-sha.md)|
|F5, Inc.|[Integrate F5 BIG-IP with Microsoft Entra ID](f5-integration.md)</br>[Tutorial: Configure F5 BIG-IP SSL-VPN for Microsoft Entra SSO](f5-passwordless-vpn.md)|
|Progress Software Corporation, Progress Kemp|[Tutorial: Microsoft Entra SSO integration with Kemp LoadMaster Microsoft Entra integration](~/identity/saas-apps/kemp-tutorial.md)|
|Perimeter 81 Ltd.|[Tutorial: Microsoft Entra SSO integration with Perimeter 81](~/identity/saas-apps/perimeter-81-tutorial.md)|
|Silverfort|[Tutorial: Configure Secure Hybrid Access with Microsoft Entra ID and Silverfort](silverfort-integration.md)|
|Strata Identity, Inc.|[Integrate Microsoft Entra SSO with Maverics Identity Orchestrator SAML Connector](~/identity/saas-apps/maverics-identity-orchestrator-saml-connector-tutorial.md)|

#### Partners with pre-built solutions and integration documentation

|Partner|Integration documentation|
|---|---|
|Amazon Web Service, Inc.|[Tutorial: Microsoft Entra SSO integration with AWS ClientVPN](~/identity/saas-apps/aws-clientvpn-tutorial.md)|
|Check Point Software Technologies Ltd.|[Tutorial: Microsoft Entra single SSO integration with Check Point Remote Secure Access VPN](~/identity/saas-apps/check-point-remote-access-vpn-tutorial.md)|
|Cisco Systems, Inc.|[Tutorial: Microsoft Entra SSO integration with Cisco Secure Firewall - Secure Client](~/identity/saas-apps/cisco-secure-firewall-secure-client.md)|
|Fortinet, Inc.|[Tutorial: Microsoft Entra SSO integration with FortiGate SSL VPN](~/identity/saas-apps/fortigate-ssl-vpn-tutorial.md)|
|Palo Alto Networks|[Tutorial: Microsoft Entra SSO integration with Palo Alto Networks Admin UI](~/identity/saas-apps/paloaltoadmin-tutorial.md)|
|Pulse Secure|[Tutorial: Microsoft Entra SSO integration with Pulse Connect Secure (PCS)](~/identity/saas-apps/pulse-secure-pcs-tutorial.md)</br>[Tutorial: Microsoft Entra SSO integration with Pulse Secure Virtual Traffic Manager](~/identity/saas-apps/pulse-secure-virtual-traffic-manager-tutorial.md)|
|Zscaler, Inc.|[Tutorial: Integrate Zscaler Private Access with Microsoft Entra ID](~/identity/saas-apps/zscalerprivateaccess-tutorial.md)|

## Next steps 
Select a partner in the tables mentioned to learn how to integrate their solution with Microsoft Entra ID.
