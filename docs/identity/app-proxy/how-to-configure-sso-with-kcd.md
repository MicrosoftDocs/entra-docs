---
title: Kerberos-based single sign-on (SSO) in Microsoft Entra ID with application proxy
description: Covers how to provide single sign-on using Microsoft Entra application proxy.
author: kenwith
manager: femila
ms.service: entra-id
ms.subservice: app-proxy
ms.topic: how-to
ms.date: 05/01/2025
ms.author: kenwith
ms.reviewer: ashishj
ai-usage: ai-assisted
ms.custom: sfi-image-nochange
---

# Kerberos Constrained Delegation for single sign-on (SSO) to your apps with application proxy

You can provide single sign-on for on-premises applications published through application proxy that are secured with integrated Windows authentication. These applications require a Kerberos ticket for access. Application proxy uses Kerberos Constrained Delegation (KCD) to support these applications.

To learn more about single sign-on (SSO), see [What is single sign-on?](~/identity/enterprise-apps/what-is-single-sign-on.md).

You can enable single sign-on to your applications using integrated Windows authentication (IWA) by giving private network connectors permission in Active Directory to impersonate users. The connectors use this permission to send and receive tokens on their behalf.

## How single sign-on with KCD works
The diagram explains the flow when a user attempts to access an on-premises application that uses IWA.

![Microsoft Entra authentication flow diagram](./media/application-proxy-configure-single-sign-on-with-kcd/authdiagram.png)

1. The user enters the URL to access the on-premises application through application proxy.
2. Application proxy redirects the request to Microsoft Entra authentication services to preauthenticate. At this point, Microsoft Entra ID applies any applicable authentication and authorization policies, such as multifactor authentication. If the user is validated, Microsoft Entra ID creates a token and sends it to the user.
3. The user passes the token to application proxy.
4. Application proxy validates the token and retrieves the User Principal Name (UPN) from it, and then the Connector pulls the UPN, and the Service Principal Name (SPN) through a dually authenticated secure channel.
5. The Connector performs Kerberos Constrained Delegation (KCD) negotiation with the on-premises AD, impersonating the user to get a Kerberos token to the application.
6. Active Directory sends the Kerberos token for the application to the Connector.
7. The Connector sends the original request to the application server, using the Kerberos token it received from AD.
8. The application sends the response to the Connector, which is then returned to the application proxy service and finally to the user.

## Prerequisites
Before you get started with single sign-on for IWA applications, make sure your environment is ready with the following settings and configurations:

* Your apps, like SharePoint Web apps, are set to use integrated Windows authentication. For more information, see [Enable Support for Kerberos Authentication](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd759186(v=ws.11)), or for SharePoint see [Plan for Kerberos authentication in SharePoint 2013](/SharePoint/security-for-sharepoint-server/kerberos-authentication-planning).
* All your apps have [Service Principal Names](/windows/win32/ad/service-principal-names).
* The server running the Connector and the server running the app are domain joined and part of the same domain or trusting domains. For more information on domain join, see [Join a Computer to a Domain](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dd807102(v=ws.11)).
* Ensure the Connector server can read the `TokenGroupsGlobalAndUniversal` attribute for users. Security hardening might restrict this access. Enable the connector servers by adding them to the *Windows Authorization Access* group.

### Configure Active Directory
The Active Directory configuration varies, depending on whether your private network connector and the application server are in the same domain or not.

#### Connector and application server in the same domain
1. In Active Directory, go to **Tools** > **Users and Computers**.
2. Select the server running the connector.
3. Right-click and select **Properties** > **Delegation**.
4. Select **Trust this computer for delegation to specified services only**. 
5. Select **Use any authentication protocol**.
6. Under **Services to which this account can present delegated credentials** add the value for the SPN identity of the application server. The setting enables the private network connector to impersonate users in AD against the applications defined in the list.

   ![Connector-SVR Properties window screenshot](./media/application-proxy-configure-single-sign-on-with-kcd/properties.jpg)

#### Connector and application server in different domains
1. For a list of prerequisites for working with KCD across domains, see [Kerberos Constrained Delegation across domains](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831477(v=ws.11)).
2. To enable Kerberos authentication delegation from the application proxy (connector), use the `PrincipalsAllowedToDelegateTo` property of the web application's service account (`webserviceaccount`). The application server runs under `webserviceaccount`, and the delegating server is `connectorcomputeraccount`. Run the following commands on a Domain Controller (Windows Server 2012 R2 or later) in the same domain as `webserviceaccount`. Use flat names (non-UPN) for both accounts.

   If the `webserviceaccount` is a computer account, use these commands:

   ```powershell
   $connector= Get-ADComputer -Identity connectorcomputeraccount -server dc.connectordomain.com

   Set-ADComputer -Identity webserviceaccount -PrincipalsAllowedToDelegateToAccount $connector

   Get-ADComputer webserviceaccount -Properties PrincipalsAllowedToDelegateToAccount
   ```

   If the `webserviceaccount` is a user account, use these commands:

   ```powershell
   $connector= Get-ADComputer -Identity connectorcomputeraccount -server dc.connectordomain.com

   Set-ADUser -Identity webserviceaccount -PrincipalsAllowedToDelegateToAccount $connector

   Get-ADUser webserviceaccount -Properties PrincipalsAllowedToDelegateToAccount
   ```

## Configure single sign-on 
1. Publish your application according to the instructions described in [Publish applications with application proxy](~/identity/app-proxy/application-proxy-add-on-premises-application.md). Make sure to select **Microsoft Entra ID** as the **Preauthentication Method**.
2. After your application appears in the list of enterprise applications, select it and select **Single sign-on**.
3. Set the single sign-on mode to **Integrated Windows authentication**.  
4. Enter the **Internal Application SPN** of the application server. In this example, the SPN for our published application is `http/www.contoso.com`. The SPN needs to be in the list of services to which the connector can present delegated credentials.
5. Choose the **Delegated Login Identity** for the connector to use on behalf of your users. For more information, see [Working with different on-premises and cloud identities](#working-with-different-on-premises-and-cloud-identities).

   ![Advanced Application Configuration](./media/application-proxy-configure-single-sign-on-with-kcd/cwap_auth2.png)  

## SSO for non-Windows apps

The Kerberos delegation flow in Microsoft Entra application proxy starts when Microsoft Entra authenticates the user in the cloud. Once the request arrives on-premises, the Microsoft Entra private network connector issues a Kerberos ticket on behalf of the user by interacting with the local Active Directory. The process is referred to as Kerberos Constrained Delegation (KCD). 

In the next phase, a request is sent to the backend application with this Kerberos ticket. 

There are several mechanisms that define how to send the Kerberos ticket in such requests. Most non-Windows servers expect to receive it in form of SPNEGO token. The mechanism is supported on Microsoft Entra application proxy, but is disabled by default. A connector can be configured for SPNEGO or standard Kerberos token, but not both.

If you configure a connector machine for SPNEGO, make sure that all other connectors in that Connector group are also configured with SPNEGO. Applications expecting standard Kerberos token should be routed through other connectors that aren't configured for SPNEGO. Some web applications accept both formats without requiring any change in configuration. 
 

To enable SPNEGO:

1. Open a command prompt that runs as administrator.
2. Run the following commands on the connector servers that need SPNEGO.

    ```
    REG ADD "HKLM\SOFTWARE\Microsoft\Microsoft Entra private network connector" /v UseSpnegoAuthentication /t REG_DWORD /d 1
    net stop WAPCSvc & net start WAPCSvc
    ```

Non-Windows apps typically user usernames or SAM account names instead of domain email addresses. If that situation applies to your applications, you need to configure the delegated sign-in identity field to connect your cloud identities to your application identities. 

## Working with different on-premises and cloud identities
Application proxy assumes users have the same identity in the cloud and on-premises. However, some organizations need to use alternate IDs for sign-in due to corporate policies or application requirements. You can still enable KCD for single sign-on by configuring a **Delegated login identity** for each application. This setting specifies which identity to use for single sign-on.

This feature allows organizations to enable SSO from the cloud to on-premises apps without requiring users to manage different usernames and passwords. Common scenarios include:

* Using multiple internal domains (for example, joe@us.contoso.com, joe@eu.contoso.com) with a single cloud domain (for example, joe@contoso.com).
* Having nonroutable internal domain names (for example, joe@contoso.usa) while using valid domain names in the cloud.
* Operating without internal domain names (for example, joe).
* Assigning different aliases for users on-premises and in the cloud (for example, joe-johns@contoso.com vs. joej@contoso.com).

With application proxy, you can choose the identity used to obtain the Kerberos ticket. This setting is configured per application and supports systems that require nonemail formats or alternative sign-in methods.

![Delegated login identity parameter screenshot](./media/application-proxy-configure-single-sign-on-with-kcd/app_proxy_sso_diff_id_upn.png)

If delegated sign-in identity is used, the value might not be unique across all the domains or forests in your organization. You can avoid this issue by publishing these applications twice using two different Connector groups. Since each application has a different user audience, you can join its Connectors to a different domain.

If **On-premises SAM account name** is used for the sign-in identity, the computer hosting the connector must be added to the domain in which the user account is located.

### Configure SSO for different identities
1. Configure Microsoft Entra Connect settings so the main identity is the email address (mail). The configuration is done as part of the customize process, by changing the **User Principal Name** field in the sync settings. These settings also determine how users sign in to Microsoft 365, Windows computers, and other applications that use Microsoft Entra ID as their identity store.  
   ![Identifying users screenshot - User Principal Name dropdown](./media/application-proxy-configure-single-sign-on-with-kcd/app_proxy_sso_diff_id_connect_settings.png)  
2. In the Application Configuration settings for the application you would like to modify, select the **Delegated Login Identity** to be used:

   * User Principal Name (for example, `joe@contoso.com`)
   * Alternate User Principal Name (for example, `joed@contoso.local`)
   * Username part of User Principal Name (for example, `joe`)
   * Username part of Alternate User Principal Name (for example, `joed`)
   * On-premises SAM account name (depends on the domain controller configuration)

### Troubleshooting SSO for different identities
If the backend application responds with unexpected HTTP replies, start troubleshooting by checking event 24029 in the application proxy session event sign-in the connector machine. The "user" field in the event details shows the identity used for delegation. To enable session logs, go to the Event Viewer, open the **View** menu, and select **Show analytic and debug logs**.

## Next steps

* [How to configure an application proxy application to use Kerberos Constrained Delegation](application-proxy-back-end-kerberos-constrained-delegation-how-to.md)
* [Troubleshoot issues you're having with application proxy](application-proxy-troubleshoot.md)
