---
title:  Add an on-premises application for remote access through application proxy in Microsoft Entra ID.
description:  Microsoft Entra ID has an application proxy service that enables users to access on-premises applications by signing in with their Microsoft Entra account. This tutorial shows you how to prepare your environment for use with application proxy. Then, it uses the Microsoft Entra admin center to add an on-premises application to your Microsoft Entra tenant.
author: kenwith
manager: femila
ms.service: entra-id
ms.subservice: app-proxy
ms.topic: tutorial
ms.date: 05/01/2025
ms.author: kenwith
ms.reviewer: ashishj
ai-usage: ai-assisted
---

# Add an on-premises application for remote access through application proxy in Microsoft Entra ID

Microsoft Entra ID has an application proxy service that enables users to access on-premises applications by signing in with their Microsoft Entra account. To learn more about application proxy, see [What is application proxy?](overview-what-is-app-proxy.md). This tutorial prepares your environment for use with application proxy. Once your environment is ready, use the Microsoft Entra admin center to add an on-premises application to your tenant.

:::image type="content" source="./media/application-proxy-add-on-premises-application/app-proxy-diagram.png" alt-text="Application proxy Overview Diagram" lightbox="./media/application-proxy-add-on-premises-application/app-proxy-diagram.png":::

In this tutorial, you:
- Install and verify the connector on your Windows server, and registers it with application proxy.
- Add an on-premises application to your Microsoft Entra tenant.
- Verify a test user can sign on to the application by using a Microsoft Entra account.


## Prerequisites

To add an on-premises application to Microsoft Entra ID, you need:
- An [Microsoft Entra ID P1 or P2 subscription](https://azure.microsoft.com/pricing/details/active-directory).
- An Application Administrator account.
- A synchronized set of user identities with an on-premises directory. Or create them directly in your Microsoft Entra tenants. Identity synchronization allows Microsoft Entra ID to preauthenticate users before granting them access to application proxy published applications. Synchronization also provides the necessary user identifier information to perform single sign-on (SSO).
- An understanding of application management in Microsoft Entra, see [View enterprise applications in Microsoft Entra](~/identity/enterprise-apps/view-applications-portal.md).
- An understanding of single sign-on (SSO), see [Understand single sign-on](~/identity/enterprise-apps/what-is-single-sign-on.md).

## Install and verify the Microsoft Entra private network connector
Application proxy uses the same connector as Microsoft Entra Private Access. The connector is called Microsoft Entra private network connector. To learn how to install and verify a connector, see [How to configure connectors](../../global-secure-access/how-to-configure-connectors.md).

## General remarks

Public Domain Name System (DNS) records for Microsoft Entra application proxy endpoints are chained CNAME records pointing to an A record. Setting up the records this way ensures fault tolerance and flexibility. The Microsoft Entra private network connector always accesses host names with the domain suffixes `*.msappproxy.net` or `*.servicebus.windows.net`. However, during the name resolution the CNAME records might contain DNS records with different host names and suffixes. Due to the difference, you must ensure that the device (depending on your setup - connector server, firewall, outbound proxy) can resolve all the records in the chain and allows connection to the resolved IP addresses. Since the DNS records in the chain might be changed from time to time, we can't provide you with any list DNS records.

If you install connectors in different regions, you should optimize traffic by selecting the closest application proxy cloud service region with each connector group. To learn more, see [Optimize traffic flow with Microsoft Entra application proxy](application-proxy-network-topology.md).

If your organization uses proxy servers to connect to the internet, you need to configure them for application proxy. For more information, see [Work with existing on-premises proxy servers](application-proxy-configure-connectors-with-proxy-servers.md).


## Add an on-premises app to Microsoft Entra ID

Add on-premises applications to Microsoft Entra ID.
1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Application Administrator](~/identity/role-based-access-control/permissions-reference.md#application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**.
1. Select **New application**.
1. Select **Add an on-premises application** button, which appears about halfway down the page in the **On-premises applications** section. Alternatively, you can select **Create your own application** at the top of the page and then select **Configure application proxy for secure remote access to an on-premises application**.
1. In the **Add your own on-premises application** section, provide the following information about your application:

    | Field  | Description |
    | :--------------------- | :----------------------------------------------------------- |
    | **Name** | The name of the application that appears on My Apps and in the Microsoft Entra admin center. |
    | **Maintenance Mode** | Select if you would like to enable maintenance mode and temporarily disable access for all users to the application. |
    | **Internal URL** | The URL for accessing the application from inside your private network. You can provide a specific path on the backend server to publish, while the rest of the server is unpublished. In this way, you can publish different sites on the same server as different apps, and give each one its own name and access rules.<br><br>If you publish a path, make sure that it includes all the necessary images, scripts, and style sheets for your application. For example, if your app is at `https://yourapp/app` and uses images located at `https://yourapp/media`, then you should publish `https://yourapp/` as the path. This internal URL doesn't have to be the landing page your users see. For more information, see [Set a custom home page for published apps](application-proxy-configure-custom-home-page.md). |
    | **External URL** | The address for users to access the app from outside your network. If you don't want to use the default application proxy domain, read about [custom domains in Microsoft Entra application proxy](./how-to-configure-custom-domain.md). |
    | **Pre Authentication** | How application proxy verifies users before giving them access to your application.<br><br>**Microsoft Entra ID** - Application proxy redirects users to sign in with Microsoft Entra ID, which authenticates their permissions for the directory and application. We recommend keeping this option as the default so that you can take advantage of Microsoft Entra security features like Conditional Access and multifactor authentication. **Microsoft Entra ID** is required for monitoring the application with Microsoft Defender for Cloud Apps.<br><br>**Passthrough** - Users don't have to authenticate against Microsoft Entra ID to access the application. You can still set up authentication requirements on the backend. |
    | **Connector Group** | Connectors process the remote access to your application, and connector groups help you organize connectors and apps by region, network, or purpose. If you don't have any connector groups created yet, your app is assigned to **Default**.<br><br>If your application uses WebSockets to connect, all connectors in the group must be version 1.5.612.0 or later. |

1. If necessary, configure **Additional settings**. For most applications, you should keep these settings in their default states.

    | Field | Description |
    | :------------------------------ | :----------------------------------------------------------- |
    | **Backend Application Timeout** | Set this value to **Long** only if your application is slow to authenticate and connect. At default, the backend application time-out has a length of 85 seconds. When set too long, the backend time out is increased to 180 seconds. |
    | **Use HTTP-Only Cookie** | Select to have application proxy cookies include the HTTPOnly flag in the HTTP response header. If using Remote Desktop Services, keep the option unselected. |
    | **Use Persistent Cookie**| Keep the option unselected. Only use this setting for applications that can't share cookies between processes. For more information about cookie settings, see [Cookie settings for accessing on-premises applications in Microsoft Entra ID](./application-proxy-configure-cookie-settings.md). |
    | **Translate URLs in Headers** | Keep the option selected unless your application required the original host header in the authentication request. |
    | **Translate URLs in Application Body** | Keep the option unselected unless HTML links are hardcoded to other on-premises applications and don't use custom domains. For more information, see [Link translation with application proxy](./application-proxy-configure-hard-coded-link-translation.md).<br><br>Select if you plan to monitor this application with Microsoft Defender for Cloud Apps. For more information, see [Configure real-time application access monitoring with Microsoft Defender for Cloud Apps and Microsoft Entra ID](./application-proxy-integrate-with-microsoft-cloud-application-security.md). |
    | **Validate Backend TLS Certificate** | Select to enable backend Transport Layer Security (TLS) certificate validation for the application. |

1. Select **Add**.

## Test the application

You're ready to test the application is added correctly. In the following steps, you add a user account to the application, and try signing in.

### Add a user for testing

Before adding a user to the application, verify the user account already has permissions to access the application from inside the corporate network.

To add a test user:

1. Select **Enterprise applications**, and then select the application you want to test.
2. Select **Getting started**, and then select **Assign a user for testing**.
3. Under **Users and groups**, select **Add user**.
4. Under **Add assignment**, select **Users and groups**. The **User and groups** section appears.
5. Choose the account you want to add.
6. Choose **Select**, and then select **Assign**.

### Test the sign-on

To test authentication to the application:

1. From the application you want to test, select **application proxy**.
2. At the top of the page, select **Test Application** to run a test on the application and check for any configuration issues.
3. Make sure to first launch the application to test signing into the application, then download the diagnostic report to review the resolution guidance for any detected issues.

For troubleshooting, see [Troubleshoot application proxy problems and error messages](./application-proxy-troubleshoot.md).

## Clean up resources

Don't forget to delete any of the resources you created in this tutorial when you're done.

## Troubleshooting

Learn about common issues and how to troubleshoot them.

### Create the Application/Setting the URLs
Check the error details for information and suggestions for how to fix the application. Most error messages include a suggested fix. To avoid common errors, verify:

- You're an administrator with permission to create an application proxy application
- The internal URL is unique
- The external URL is unique
- The URLs start with http or https, and end with a “/”
- The URL should be a domain name, not an IP address

The error message should display in the top-right corner when you create the application. You can also select the notification icon to see the error messages.


### Upload certificates for custom domains

Custom Domains allow you to specify the domain of your external URLs. To use custom domains, you need to upload the certificate for that domain. For information on using custom domains and certificates, see [Working with custom domains in Microsoft Entra application proxy](how-to-configure-custom-domain.md).

If you're encountering issues uploading your certificate, look for the error messages in the portal for additional information on the problem with the certificate. Common certificate problems include:

- Expired certificate
- Certificate is self-signed
- Certificate is missing the private key

The error message display in the top-right corner as you try to upload the certificate. You can also select the notification icon to see the error messages.

## Next steps

- [What is Global Secure Access?](../../global-secure-access/overview-what-is-global-secure-access.md)
