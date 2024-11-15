---
title: Learn about Universal Continuous Evaluation (Preview)
description: Learn about Universal Continuous Evaluation concepts
ms.service: global-secure-access
ms.topic: conceptual
ms.date: 11/11/2024
ms.author: alexpav
author: idmdev
manager: sineado
ms.reviewer: dhruvinshah
---
# Universal Continuous Evaluation (Preview)

Universal CAE is a platform feature of Global Secure Access that works together with Entra ID to ensure that access to the GSA service is validated every time a connection to a new application resource is established. Universal CAE protects tunnel access tokens from theft and replay and allows for network access to be revoked and re-validated in near real-time when Entra ID detects changes to the identity. Traditional Entra ID CAE requires each workload to adopt special libraries and is limited to first-party applications only.  GSA Universal CAE extends benefits of CAE to any application accessed with Global Secure Access, without requiring the application to be CAE aware.

## Benefits of Universal CAE

Here are some examples of how Universal CAE benefits your organization when Entra ID detects an identity change and triggers CAE in near real-time:

* Private Access - user's session via Remote Desktop, access to file servers, and access to all private resources protected by Private Access is interrupted, reducing the risk of data exfiltration by a departing employee or malicious insider activity.
* Internet Access - user's access to all Internet resources, including services that may hold company data, such as third-party file sharing services and company collaboration tools is interrupted, reducing the risk of data exfiltration by a departing employee. 
* Microsoft Services - while many Microsoft services already use CAE natively, there are some applications that don't. With Universal CAE, user's access to Microsoft applications is interrupted, regardless of the application's awareness of CAE.
*  You can require that your users are on specific networks before they are allowed to connect to services with GSA, preventing the move to a different network even after the initial tunnel authentication. In this scenario, when the user changes networks, network access via GSA is re-authenticated and location-based Conditional Access policies are re-evaluated.
* Optional Strict Enforcement mode, configured in Conditional Access, protects from token theft/replay of GSA access tokens. If the token replay is attempted from a different IP address than the original IP address used during authentication, network access will be blocked.

## How it works

Global Secure Access relies on Entra ID access tokens to authenticate to the service tunnels (Microsoft traffic, Internet Access, and Private Access traffic forwarding profiles). Access tokens are valid between 60 and 90 minutes. Prior to expiration, the GSA client uses the Entra ID refresh token to obtain a new access token.

As per the OATH2 specification, access tokens are valid until expired. For example, when the user account is disabled, the refresh tokens are invalidated, but it takes up to 90 minutes for the access tokens of that user to become invalid and rejected by the GSA service.

With Universal CAE, changes to user identity are communicated to Global Secure Access in near real time. Even though the access token is still valid, Global Secure Access sends a special claims challenge back to the end user, requiring the user to re-authenticate. If the user is unable to complete Entra ID re-authentication challenge, network access through GSA is blocked. Universal CAE shortens the time window between Entra ID account state change and requiring the user to re-authenticate, reducing the risk of data exfiltration by a departing employee.

## Entra ID signals that trigger Universal CAE reauthentication

Global Secure Access is enabled to receive signals from Entra ID in near real-time for the following events:

* User Account is deleted or disabled
* Password for a user is changed or reset
* Multifactor authentication is enabled for the user
* Administrator explicitly revokes all refresh tokens for a user
* High user risk detected by Microsoft Entra ID Protection

Upon receiving the security event, Global Secure Access client will prompt the user to re-authenticate. If the re-authentication is successful, user's network connectivity to resources protected by Global Secure Access is restored.

## Strict Enforcement mode
Strict enforcement mode provides additional protection for Universal CAE, immediately stopping access if the IP address detected by the resource provider isn't allowed by Conditional Access policy. This option is the highest security modality of CAE location enforcement, and requires that administrators understand the routing of authentication and access requests in their network environment. When strict enforcement is enabled, access to the Global Secure Access services is only possible when your users are 

## Disabling Universal CAE

Entra ID Conditional Access can be used to control CAE behavior in your tenant. By default, CAE is on for all applications that support it. You can disable CAE in your Entra ID tenant, which will disable CAE for all services, including Global Secure Access. To disable CAE in your tenant, please follow the steps in the [Conditional Access documentation](/entra/identity/conditional-access/concept-conditional-access-session#customize-continuous-access-evaluation)

> [!Note]
> Universal CAE is opportunistic unless the optional Strict Enforcement mode is enabled in Conditional Access and applied to the GSA workload identities. By default, supported Global Secure Access clients will attempt to obtain a CAE access token from Entra ID. If the CAE token cannot be obtained from Entra ID (for example, due to the unsupported client version), a regular access token will be issued. With the fallback behavior, there should not be a need for you to disable Universal CAE. 

## Known limitations

* Only Windows versions of Global Secure Access client, starting with version 1.8.239.0, are aware of Universal CAE. Other clients use regular access tokens.
* Entra ID issues short lived tokens for Global Secure Access. Universal CAE access token lifetime is between 60 and 90 minutes, with support for near real-time revocation.
* It takes approximately 2 to 5 minutes for the Entra ID signal to be received by the Global Secure Access client and prompt the user to re-authenticate
* The user has a grace period of 2 minutes after receiving a CAE event to complete re-authentication. After 2 minutes, existing network flows through GSA are interrupted until the user successfully signs in to the GSA client.

## Related content

- [Continuous access evaluation in Microsoft Entra](/docs/identity/conditional-access/concept-continuous-access-evaluation.md)
- [Session controls in Conditional Access policy](/docs/identity/conditional-access/concept-conditional-access-session.md)
- [Continuous access evaluation strict location enforcement in Microsoft Entra ID](/docs/identity/conditional-access/concept-continuous-access-evaluation-strict-enforcement.md)
- [Global Secure Access client for Windows](how-to-install-windows-client.md)