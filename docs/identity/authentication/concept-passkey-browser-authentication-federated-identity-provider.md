---
title: Browser authentication for external identity providers in Microsoft Entra ID
description: Learn how browser authentication for external identity providers moves federated sign-in from an embedded WebView to the system browser.
author:      ploegert # GitHub alias
ms.author:   jploegert # Microsoft alias
ms.service:  entra-id
ms.topic:    concept-article
ms.date:     08/21/2026
---
# Passkey and security key browser authentication for third-party federated identity providers on Android, iOS, and macOS

Browser authentication for external identity providers (IdPs) moves the external federated identity provider authentication step from an embedded WebView to the system browser. This change enables authentication experiences that depend on browser capabilities, including FIDO2 security keys, passkeys, WebAuthn, and existing browser single sign-on.

This capability unlocks three scenarios embedded WebViews cannot support:

- Third-party FIDO2 credentials and passkeys issued by an external identity provider.
- Single sign-on from brokered Microsoft apps to the system browser for the external IdP authentication step.
- IdPs that reject embedded WebView user agents can use the system browser.

## What it enables

- **External IdP passkeys work**: Users with external IdP-issued passkeys or FIDO2 credentials can sign in to Microsoft 365.
- **SSO to the system browser**: Brokered apps can provide SSO to the system browser for the external IdP authentication step.
- **WebView-blocking IdPs succeed**: IdPs that block embedded WebViews work because authentication runs in the system browser.
- **Fewer prompts**: Users see fewer redundant password prompts across the flow.

> [!IMPORTANT]
> This capability doesn't mean the Microsoft identity broker directly supports third-party FIDO2 security keys. It means the external IdP authentication step can run in the system browser, where passkeys, FIDO-capable IdP flows, browser SSO cookies, and IdPs that block WebView all work more reliably.

## Supported scope and requirements

Browser authentication for external IdPs is generally available in the Microsoft Entra public cloud. In national clouds, this capability remains in preview while known issues are resolved.

The generally available experience supports only brokered authentication. A supported broker must be installed on the device. Browser authentication for external IdPs supports domains federated through WS-Fed or SAML 2.0. The applicable broker depends on the initiating app scenario.

| Platform or scenario | Required browser | Broker or component minimum | Notes |
| --- | --- | --- | --- |
| Android | Chrome configured as the default browser | Microsoft Authenticator `6.2510.6857` or later; Link to Windows `1.25102.138.0` or later; Company Portal `5.0.6768.0` or later when applicable; broker library `14.0.2` or later | Broker applicability varies by app scenario. |
| Android Shared Device Mode | Chrome | Supported Android broker meeting the applicable minimum | Chrome is required for this scenario. |
| iOS functional minimum | Safari | Microsoft Authenticator `6.8.29` or later | This is the functional minimum. |
| iOS with current known fixes | Safari | Microsoft Authenticator `6.8.37` or later | This version is recommended for the current known fixes. |
| Managed macOS | Safari | Company Portal `5.2511` or later | The device must be managed. |

### Supported Microsoft apps

The following Microsoft apps have been tested and are supported for the generally available brokered experience:

- Outlook
- Teams
- OneDrive
- Word, Excel, and PowerPoint
- Microsoft To Do

Other brokered apps might work with this capability but remain in preview until they're officially listed as supported. A supported broker is required for both generally available and preview app experiences.

The following scenarios are unsupported:

- Linux.
- Unmanaged macOS.
- OAuth2/OIDC social IdPs.

Direct sign-in to Android Company Portal remains in an embedded WebView and is not a supported system-browser scenario. Company Portal can still act as the broker for other supported Android app scenarios when the applicable requirements are met.

> [!Note]
> In Windows, third-party FIDO is already supported natively and doesn't use the same mechanism as this feature to provide browser authentication for external IdPs.

## Authentication experience

1. The user starts sign-in in a supported brokered app.
2. The broker hands the external IdP authentication step to the supported system browser.
3. The user completes authentication at the external IdP, which is a separate authentication boundary.
4. A redirect deep link returns control to the broker.
5. The broker resumes the originating app flow.

The browser handoff and return are externally observable. This documentation does not make claims about how Microsoft or the external IdP handles credentials, passkey material, authentication responses, sessions, logs, storage, or retention.

## Configuration

The feature is off by default and is only enabled when a tenant admin enables it through the `systemBrowserEnabledOn` property on `InternalDomainFederation` (a space-separated or comma-separated platform list).

### Microsoft Graph API

#### List internalDomainFederations (API)

Retrieve a list of internal federated domains.

> [!Note]
> Use the `"id"` value, which is the configuration ID of the federated domain, to enable passkey and security key browser authentication.

```http
GET /domains/{federated_domain_name}/federationConfiguration
```

#### Enable (API)

A Global Administrator issues a `PATCH` call against the configuration ID of the federated domain, specifying the platforms that support passkey and security key browser authentication.

**Permissions**: InternalFederation.ReadWrite.All, Domain.ReadWrite.All

Supported platform values are `Ios`, `Android`, `Macos`. Multiple values can be supplied together, for example: `Android`, `Ios`. Setting this to `none` turns the capability off.

```http
PATCH /domains/contoso.com/federationConfiguration/{configuration id}
```

#### Request body
```json
{
   "systemBrowserEnabledOn": "Android, Ios"
}
```

#### Query configuration (API)

```http
GET /domains/contoso.com/federationConfiguration/{configuration id}
```

**Sample Result**

```json
{
    "@odata.type": "#microsoft.graph.internalDomainFederation",
    "displayName": "Auth0 IdP",
    "issuerUri": "urn:login.contoso.com",
    "signingCertificate": "{signing cert value}",
    "passiveSignInUri": "[https://login.contoso.com/samlp/AbCdEfg1234567](https://login.contoso.com/samlp/AbCdEfg1234567)",
    "preferredAuthenticationProtocol": "saml",
    "systemBrowserEnabledOn": "Android, Ios"
}
```

### Microsoft Graph PowerShell

#### List internalDomainFederations (PowerShell)

```powershell
Connect-MgGraph -Scope "Domain-InternalFederation.ReadWrite.All"
Update-MgDomainFederationConfiguration -DomainId 'contoso.com'
```

#### Enable (PowerShell)

```powershell
Connect-MgGraph -Scope "Domain-InternalFederation.ReadWrite.All"
Update-MgDomainFederationConfiguration -DomainId 'contoso.com' -InternalDomainFederationId '<guid>' -SystemBrowserEnabledOn "Android iOS"
```

#### Query configuration (PowerShell)

```powershell
Connect-MgGraph -Scope "Domain-InternalFederation.ReadWrite.All"
Update-MgDomainFederationConfiguration -DomainId 'contoso.com' -InternalDomainFederationId '<guid>'
```

Related [InternalDomainFederation properties](/graph/api/resources/internaldomainfederation#properties):

- `displayName`
- `issuerUri`
- `metadataExchangeUri`
- `passiveSignInUri`
- `activeSignInUri`
- `preferredAuthenticationProtocol`
- `federatedIdpMfaBehavior`
- `promptLoginBehavior`
- `systemBrowserEnabledOn`

Currently supported federation protocols: **WS-Fed** and **SAML 2.0**.

## Validate the experience

1. Confirm that the federation protocol, platform, browser, and broker are eligible according to the support matrix.
2. Confirm that the configured browser and installed broker or component versions meet the listed requirements.
3. Start sign-in from a supported brokered app.
4. Observe that the system browser opens for the external IdP authentication step.
5. Complete authentication at the external IdP.
6. Verify that control returns to the originating app flow.

Validation should remain observational and local. Do not capture, record, upload, attach, retain, or share authentication or diagnostic evidence.

## Troubleshoot the experience

| Symptom | Check |
| --- | --- |
| Sign-in remains in an embedded WebView | Confirm that the scenario uses WS-Fed or SAML 2.0, is enabled for the applicable federation configuration and platform, and meets the platform and broker requirements. Direct sign-in to Android Company Portal remains in an embedded WebView and is not a supported system-browser scenario. |
| The expected browser does not open on Android | Confirm that Chrome is configured as the default browser. |
| The browser opens but does not return to the app | Confirm that the app and broker use a registered redirect deep link, and that the installed component versions meet the support matrix. |
| The experience is unavailable on iOS | Confirm that Safari and Microsoft Authenticator `6.8.29` or later are installed; `6.8.37` or later is recommended for the current known fixes. |
| The experience is unavailable on macOS | Confirm that the device is managed and uses Safari with Company Portal `5.2511` or later. |

## Security and privacy considerations

- Tokens, proof artifacts, broker-flow state, tenant IDs, user or device identifiers, and other sensitive authentication or personal data must not be placed in URLs, diagnostic logs, telemetry, or support notes.
- If troubleshooting data is handled through an approved process, require data minimization and approved privacy and retention handling.
- Treat the external IdP as a separate authentication boundary and evaluate its security and privacy practices independently.

## Terminology

- A **broker** is a trusted platform component that coordinates authentication between an app, Microsoft Entra ID, and the system browser.
- The **system browser** is the device's default or platform browser opened outside the initiating app.
- An **embedded WebView** is a browser surface displayed inside an app or broker.
- An **external or federated identity provider (IdP)** is a separate authentication boundary that authenticates the user for a domain federated with Microsoft Entra ID.
- A **FIDO2 security key** is a physical authenticator that uses FIDO2 standards for phishing-resistant authentication.
- A **passkey** is a FIDO credential used to sign in without a password.
- **WebAuthn** is the web standard browsers use to request public-key authentication with security keys, passkeys, or other compatible authenticators.
- **Shared Device Mode** is an Android device mode designed for shared, organization-managed devices and supported account transitions between participating apps.

## Related content

- [internalDomainFederation resource type](/graph/api/resources/internaldomainfederation)
