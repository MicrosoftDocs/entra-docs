---
title: Security best practices for application properties
description: Learn about the best practices and general guidance for security related application properties in Microsoft Entra ID.
author: OwenRichards1
manager: CelesteDG
ms.author: owenrichards
ms.date: 01/06/2023
ms.reviewer: 
ms.service: identity-platform
ms.topic: concept-article
ms.custom: template-concept, sfi-ropc-nochange, sfi-image-nochange
#Customer intent: As an application developer, I want to follow security best practices for application properties in Microsoft Entra ID, so that I can ensure the security and health of my applications and protect them from compromise or downtime.
---

# Security best practices for application properties in Microsoft Entra ID

Security is an important concept when registering an application in Microsoft Entra ID and is a critical part of its business use in the organization. Any misconfiguration of an application can result in downtime or compromise. Depending on the permissions added to an application, there can be organization-wide effects.

Because secure applications are essential to the organization, any downtime to them because of security issues can affect the business or some critical service that the business depends upon. So, it's important to allocate time and resources to ensure applications always stay in a healthy and secure state. Conduct a periodic security and health assessment of applications, much like a Security Threat Model assessment for code. For a broader perspective on security for organizations, see the [security development lifecycle (SDL)](https://www.microsoft.com/securityengineering/sdl).

This article describes security best practices for the following application properties and scenarios:

- Identity type
- Credentials
- Redirect URIs
- Implicit flow configuration
- Application ID URI (also known as identifier URI)
- Access token version
- Application instance lock
- Application ownership

## Identity type

You're likely here to learn about security best practices for [Microsoft Entra applications](./how-applications-are-added.md) - also referred to as app registrations or app objects. However, there's another identity type that can be used to access Entra-protected resources, called [managed identities for Azure resources](../identity/managed-identities-azure-resources/overview.md).

Azure managed identities are secure by default and require little to no ongoing maintenance or overhead. Consider using a managed identity instead of a Microsoft Entra application for your app identity if all of the following are true:

- The service runs in the Azure cloud
- The app doesn't need to sign in users
- The app doesn't need to act as the resource in a token flow (isn't a web API)
- The app doesn't need to operate in multiple tenants

Note that managed identities **can** be used to access resources outside of Azure - including [Microsoft Graph](https://learn.microsoft.com/graph/overview).

The rest of this article covers security best practices for properties of Entra app registrations.

## Credentials (including certificates and secrets)

Credentials are a vital part of an application when it's used as a confidential client. Under the **Certificates and secrets** page for the application in the Azure portal, credentials can be added or removed.

:::image type="content" source="./media/application-registration-best-practices/credentials.png" alt-text="Screenshot that shows where the certificates and secrets are located.":::

Consider the following guidance related to certificates and secrets:

- Use a [managed identity](../identity/managed-identities-azure-resources/overview.md) as a credential whenever possible. This is strongly recommended, as managed identities are both the most secure option and don't require any ongoing credential management. Follow [this guidance](../workload-id/workload-identity-federation-config-app-trust-managed-identity.md) to configure a managed identity as a credential. However, this option may only be possible if the service the app is used in runs on Azure.
- If the service the app is used in doesn't run on Azure, but does run on another platform that offers automated credential management, consider [using an identity from that platform as a credential](../workload-id/workload-identity-federation-create-trust.md). For example, a [GitHub actions workflow can be configured as a credential](../workload-id/workload-identity-federation-create-trust.md#github-actions), eliminating the need to manage and secure credentials for the GitHub actions pipeline. Use caution with this approach and only configure federated credentials from platforms you trust. An app is only as secure as the identity platform it has configured as a credential.
- If using a managed identity or other secure external identity provider isn't possible, use [certificate credentials](./certificate-credentials.md). **Don't use password credentials, also known as *secrets***. While it's convenient to use password secrets as a credential, password credentials are often mismanaged and can be easily compromised.
- If a certificate must be used instead of a managed identity, store that certificate in a secure key vault, like [Azure Key Vault](https://azure.microsoft.com/products/key-vault).
- If a certificate must be used instead of a managed identity, use a certificate from a trusted certificate authority (CA) instead of a self-signed certificate. [Configure a policy](https://devblogs.microsoft.com/identity/app-management-policy/) to enforce that certificates come from trusted issuers. However, if using a trusted CA isn't possible, self-signed certificates are still preferred over passwords.
- Configure [application management policies](/graph/api/resources/applicationauthenticationmethodpolicy) to govern the use of secrets by limiting their lifetimes or blocking their use altogether.
- If an application is used only as a public or installed client (for example, mobile or desktop apps that are installed on the end user machine), make sure that there are no credentials specified on the application object.
- Review the credentials used in applications for freshness of use and their expiration. An unused credential on an application can result in a security breach. Rollover credentials frequently and don't share credentials across applications. Don't have many credentials on one application.
- Monitor your production pipelines to prevent credentials of any kind from being committed into code repositories. [Credential Scanner](/previous-versions/azure/security/develop/security-code-analysis-overview#credential-scanner) is a static analysis tool that can be used to detect credentials (and other sensitive content) in source code and build output.

## Redirect URIs

It's important to keep Redirect URIs of your application up to date. Under **Authentication** for the application in the Azure portal, a platform must be selected for the application and then the **Redirect URI** property can be defined.

:::image type="content" source="./media/application-registration-best-practices/redirect-uri.png" alt-text="Screenshot that shows where the redirect U R I property is located.":::

Consider the following guidance for redirect URIs:

- Maintain ownership of all URIs. A lapse in the ownership of one of the redirect URIs can lead to application compromise.
- Make sure all DNS records are updated and monitored periodically for changes.
- Don't use wildcard reply URLs or insecure URI schemes such as http, or URN.
- Keep the list small. Trim any unnecessary URIs. If possible, update URLs from Http to Https.

## Implicit flow configuration

Scenarios that required **implicit flow** can now use **Auth code flow** to reduce the risk of compromise associated with implicit flow misuse. Under **Authentication** for the application in the Azure portal, a platform must be selected for the application and then the **Access tokens (used for implicit flows)** property can be set.

:::image type="content" source="./media/application-registration-best-practices/implict-grant-flow.png" alt-text="Screenshot that shows where the implicit flow property is located.":::

Consider the following guidance related to implicit flow:

- Understand if [implicit flow is required](./v2-oauth2-implicit-grant-flow.md#suitable-scenarios-for-the-oauth2-implicit-grant). Don't use implicit flow unless explicitly required.
- If the application was configured to receive access tokens using implicit flow, but doesn't actively use them, turn off the setting to protect from misuse.
- Use separate applications for valid implicit flow scenarios.

## Application ID URI (also known as Identifier URI)

The **Application ID URI** property of the application specifies the globally unique URI used to identify the web API. It's the prefix for the scope value in requests to Microsoft Entra. It's also the value of the audience (`aud`) claim in v1.0 access tokens. For multitenant applications, the value must also be globally unique. It's also referred to as an **Identifier URI**. Under **Expose an API** for the application in the Azure portal, the **Application ID URI** property can be defined.

:::image type="content" source="./media/application-registration-best-practices/app-id-uri.png" alt-text="Screenshot that shows where the Application I D U R I is located.":::

Best practices for defining the Application ID URI change depending on if the app is issued v1.0 or v2.0 access tokens. If you're unsure whether an app is issued v1.0 access tokens, check the `requestedAccessTokenVersion` of the [app manifest](reference-microsoft-graph-app-manifest.md). A value of `null` or `1` indicates that the app receives v1.0 access tokens. A value of `2` indicates that the app receives v2.0 access tokens.

For applications that are issued v1.0 access tokens, only the default URIs should be used. The default URIs are `api://<appId>` and `api://<tenantId>/<appId>`.   - Configure the `nonDefaultUriAddition` restriction in [application management policies](/graph/api/resources/applicationauthenticationmethodpolicy?view=graph-rest-beta&preserve-view=true) to enforce this best practice for future updates to applications in your organization.

For applications that are issued v2.0 access tokens, use the following guidelines when defining the App ID URI: 
- The `api` or `https` URI schemes are recommended. Set the property in the supported formats to avoid URI collisions in your organization. Don't use wildcards.
- Use a verified domain of your organization.
- Keep an inventory of the URIs in your organization to help maintain security.

[!INCLUDE [active-directory-identifierUri](~/includes/entra-identifier-uri-patterns.md)]

## Access token version

This section is only applicable to resource applications - meaning applications that act as the audience in access tokens. Resource applications are typically web APIs. If an application only acts as a client (meaning it acquires tokens to send to resources like Microsoft Graph), then this section doesn't apply.

Resource applications that have configured custom [identifier URIs](#application-id-uri-also-known-as-identifier-uri) should use the v2.0 access token format. To check if an app should use v2.0 access tokens, look at the `identifierUris` property in the [App registrations manifest page](https://aka.ms/ra/prod) for the app. 

  :::image type="content" source="media/identifier-uri-restrictions/screenshot-identifier-uri-manifest-configuration-cropped.png" alt-text="Screenshot of identifier URI modification experience in the manifest editor." lightbox="media/identifier-uri-restrictions/screenshot-identifier-uri-manifest-configuration.png":::

 If there are any values configured there not in the format `api://{appId}` or `api://{tenantId}/{appId}`, then the app should use v2.0 access tokens.

 To upgrade to v2.0 access tokens, first ensure the app can handle [v2.0 token claims](../identity-platform/access-token-claims-reference.md). Then, update the access token version the application is issued using the manifest editor.

  :::image type="content" source="media/identifier-uri-restrictions/update-access-token-version-cropped.png" alt-text="Screenshot of update token version experience." lightbox="media/identifier-uri-restrictions/update-access-token-version.png":::

After the application configuration has been updated to use v2.0 tokens, ensure the application's audience validation logic is modified to **only** accept its `appId`.

## Application instance property lock

When an application has a service principal provisioned into a tenant,  that service principal can be customized by a tenant admin. This is true regardless of whether that tenant is the application's home tenant or a foreign tenant. Those customization abilities can allow for modifications that the app owner didn't expect, leading to security risks. For example, credentials can be added to the service principal, even though credentials should typically be owned and controlled by the app developer and owner.

To reduce this risk, applications should [configure app instance lock](../identity-platform/howto-configure-app-instance-property-locks.md). When configuring app instance lock, always lock every sensitive property available. Configuring this property is especially critical for multitenant applications - meaning applications used in multiple tenants or organizations - but can and should be set by all applications.

## Permissions

Your application may need to be granted permissions to access protected resources or APIs. When requesting permissions, always ensure the following:

- Follow [least privilege](../identity-platform/secure-least-privileged-access.md) principles. Only request the permission that grants the least permissive access required to perform the action the app needs to take.   If calling Microsoft Graph, use the [API documentation](https://learn.microsoft.com/graph/api/overview) to identify the least permissive permission for a given API call. Periodically review your app's permissions to check if a less privileged option is available. If an app no longer needs a permission, remove it.
- Whenever possible, use [delegated access](../identity-platform/delegated-access-primer.md) instead of [app-only access](../identity-platform/app-only-access-primer.md). 
- Review the [permissions and consent](../identity-platform/permissions-consent-overview.md) documentation to ensure you understand permission fundamentals.

## App ownership configuration

Owners can manage all aspects of a registered application. It's important to regularly review the ownership of all applications in the organization. For more information, see [Microsoft Entra access reviews](~/id-governance/access-reviews-overview.md). Under **Owners** for the application in the Azure portal, the owners of the application can be managed.

:::image type="content" source="./media/application-registration-best-practices/app-ownership.png" alt-text="Screenshot that shows where owners of the application are managed.":::

Consider the following guidance related to specifying application owners:

- Application ownership should be kept to a minimal set of people within the organization.
- An administrator should review the owners list once every few months to make sure that owners are still part of the organization and should still own an application.


## Check Entra recommendations

The [Microsoft Entra recommendations](../identity/monitoring-health/overview-recommendations.md) feature helps monitor the status of your tenant so you don't have to. These recommendations help ensure your tenant is in a secure and healthy state while also helping you maximize the value of the features available in Microsoft Entra ID. Periodically review any active Microsoft Entra recommendations that pertain to app properties or app configuration to keep your app ecosystem in a healthy state.

