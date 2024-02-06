---
title: Microsoft Entra ID WAM API Reference
description: Documentation for Microsoft Entra ID WAM API
services: 
author: OwenRichards1
manager: CelesteDG

ms.service: active-directory
ms.subservice: develop 
ms.topic: how-to
ms.workload: identity
ms.date: 02/06/2024
ms.author: owenrichards
ms.reviewer: 
ms.custom: 
#Customer intent: 
---

# Microsoft Entra ID WAM API

This page provides documentation for the Microsoft Entra ID WAM API. It includes a list of available APIs, their parameters, and notes. Use this reference guide to understand and utilize the functionality provided by these APIs.

## Microsoft Entra ID WAM API Reference

| Parameter | Value | Notes |
| --------- | ----- | ----- |
| `authority` | Either `organizations` or a specific token issuer URL. <br/> For example, `https://login.partner.microsoftonline.cn` is the token issuer URL for the Mooncake cloud environment. | The `authority` parameter specifies the identity provider and the cloud environment for your API. |
| `resource` | The URL for which the developer is acquiring a token, such as `https://www.sharepoint.com` | The `resource` parameter specifies the target URL for which the authentication token is being obtained. |
| `redirect_uri` | Uri | **Note**: The `redirect uri` is only allowed for medium IL. It doesn't work for UWP (Universal Windows Platform) applications. |
| `correlationId` | A GUID to track the request | **Note**: The `correlationId` is a legacy parameter. It has been replaced with a property in the WAM API itself. |
| `validateAuthority` | Either  `yes` or `no`. | The Microsoft Entra ID plugin performs authority validation by default. If an application needs to disable this validation, it should send a value of `no` for `validateAuthority`. This can be useful in on-premises scenarios. |
| `certificateUsage` | `vpn` | This parameter is used to request a certificate token type. The only allowed value is `vpn`. Currently, this is only applicable for VPN scenarios. |
| `certificateUIName` | Any string that is displayed in the certificate selection UI for the VPN certificate. | The `certificateUIName` parameter specifies the string that is shown in the certificate selection user interface when choosing a VPN certificate. |
| `certificateUIDescription` | Any string that is displayed in the certificate selection UI for the VPN certificate. | The `certificateUIDescription` parameter specifies the string that is shown in the certificate selection user interface as a description when choosing a VPN certificate. |
| `UserPictureEnabled` | Either `True` or `False`. | Indicates whether the application wants to receive the user’s picture as part of the token response. |
| `Username` | User name | Represents the Microsoft Entra ID user name |
| `Password` | Password | Represents the Password for the Microsoft Entra ID user |
| `SamlAssertion` | SAML token | SAML token sent as authentication artifact from a third-party IDP to Microsoft Entra ID |
| `SamlAssertionType` | Either `"urn:ietf:params:oauth:grant-type:saml1_1-bearer"` or `"urn:ietf:params:oauth:grant-type:saml2-bearer"` | Specifies the type of SAML token used for authentication. |
| `LoginHint` | User name hint (upn) | Provides a hint for the user name during the sign-in process. |
| `msafed` | Either `0` or `1`. | Determines whether to allow MSA user federation in the flow. A value of `1` enables federation, while `0` disables it. |
| `discover` | `Home` | The `discover` parameter indicates that the token request is executed in the context of the user’s home cloud, not the cloud to which the device is joined. |
| `domain_hint` | The relevant Domain. For example, `contoso.com` | Microsoft Entra ID uses the hint to locate the domain in directory  <br/> **Note**: domain hint is being given priority over fallback domain in case both are passed as parameters by ADAL |
| `fallback_domain` | A domain, such as `contoso.com` | The `fallback_domain` parameter is a hint that Microsoft Entra ID uses to locate the domain in the directory. It’s primarily used for nonroutable user domains that are part of the user’s UPN. |
| `client_TokenType` | `DeviceAuth` | The `client_TokenType` parameter is used exclusively for requesting device-only tokens. The caller needs to have Medium IL permissions. |
| `IsFeatureSupported` | `CrossCloudB2B`, <br/> `redirect_uri`, <br/> `TokenBinding`. | Used to check if a feature is supported |
| `prompt` | Either `no_select` or `select_account` |The prompt parameter controls the behavior of the prompt window. `no_select` means no prompt behavior control is appended to the prompt window. `select_account` displays the account picker. This parameter is passed through to ests to control account selection behavior. |
| `minimum_token_lifetime` | Time in milliseconds. | This is the time before which a fresh token needs to be requested and cache token needs to be discarded |
| `telemetry` | `MATS` | Used by first party applications that are requesting telemetry data points |
| `enclave` | `sw` indicates software keys, <br/> `hw` indicates hardware keys, <br/> `kg` indicates keyguard keys. <br/> | The `enclave` parameter specifies the type of keys to be used. |
| `token_type` | `pop` indicates proof of possession tokens <br/> `shr` indicates signed HTTP request tokens | The `token_type` parameter specifies the type of tokens to be used. |
| `req_cnf` |       | The `req_cnf` parameter is used when the `token_type` is `pop`. This field contains information about the key that the client would like to bind to the access token for proof-of-possession. |
| `refresh_binding` |       | The `refresh_binding` parameter is part of an upcoming token binding feature. It's yet to be released. |