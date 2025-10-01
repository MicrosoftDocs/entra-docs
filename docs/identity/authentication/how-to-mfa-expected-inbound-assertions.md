---
title: Satisfy Microsoft Entra ID multifactor authentication (MFA) controls with MFA claims from a federated IdP
description: Explains Microsoft Entra ID multifactor authentication (MFA) SAML/WSFed assertions.

ms.service: entra-id
ms.subservice: authentication
ms.topic: how-to
ms.date: 03/04/2025

author: brozbab
ms.author: justinha
manager: dougeby
ms.reviewer: bozbayburtlu
---
# Satisfy Microsoft Entra ID multifactor authentication (MFA) controls with MFA claims from a federated IdP

This document outlines the assertions Microsoft Entra ID requires from a [federated identity provider (IdP)](~/identity/hybrid/connect/whatis-fed.md) to honor configured [federatedIdpMfaBehaviour](/graph/api/domain-post-federationconfiguration#federatedidpmfabehavior-values) values of acceptIfMfaDoneByFederatedIdp and enforceMfaByFederatedIdp for Security Assertions Markup Language (SAML) and WS-Fed federation.

   > [!TIP]
   > Configuring Microsoft Entra ID with a federated IdP is **optional**. Microsoft Entra recommends [authentication methods](~/identity/authentication/concept-authentication-methods.md) available in Microsoft Entra ID.
   > 
   > - Microsoft Entra ID includes support for authentication methods previously only available via a federated IdP such as certificate/smartcards with [Entra Certificate Based Authentication](~/identity/authentication/concept-certificate-based-authentication.md)
   > - Microsoft Entra ID includes support for integrating 3rd party MFA providers with [External Authentication Methods](~/identity/authentication/how-to-authentication-external-method-manage.md) 
   > - Applications integrated with a federated IdP can be [integrated directly with Microsoft Entra ID](/entra/architecture/migration-best-practices)


## Using WS-Fed or SAML 1.1 federated IdP 
When an admin optionally configures their Microsoft Entra ID tenant to use a [federated IdP](~/identity/hybrid/connect/whatis-fed.md) using WS-Fed federation, Microsoft Entra redirects to IdP for authentication and expect a response in the form of a Request Security Token Response (RSTR) containing a SAML 1.1 assertion. If configured to do so, Microsoft Entra honors MFA done by the IdP if one of the following two claims is present:

- `http://schemas.microsoft.com/claims/multipleauthn`
- `http://schemas.microsoft.com/claims/wiaormultiauthn`

They can be included in the assertion as part of the `AuthenticationStatement` element. For example: 

```xml
 <saml:AuthenticationStatement
    AuthenticationMethod="http://schemas.microsoft.com/claims/multipleauthn" ..>
    <saml:Subject> ... </saml:Subject>
</saml:AuthenticationStatement>
```

Or they can be included in the assertion as part of the `AttributeStatement` elements. For example:

```xml
<saml:AttributeStatement>
  <saml:Attribute AttributeName="authenticationmethod" AttributeNamespace="http://schemas.microsoft.com/ws/2008/06/identity/claims">
       <saml:AttributeValue>...</saml:AttributeValue> 
      <saml:AttributeValue>http://schemas.microsoft.com/claims/multipleauthn</saml:AttributeValue>
  </saml:Attribute>
</saml:AttributeStatement>
```

### Using sign-in frequency and session control Conditional Access policies with WS-Fed or SAML 1.1

[Sign-in frequency](~/identity/conditional-access/concept-conditional-access-session.md#sign-in-frequency) uses UserAuthenticationInstant (SAML assertion `http://schemas.microsoft.com/ws/2008/06/identity/claims/authenticationinstant`), which is AuthInstant of first factor authentication using password for SAML1.1/WS-Fed. 

## Using SAML 2.0 federated IdP 

When an admin optionally configures their Microsoft Entra ID tenant to use a [federated IdP](~/identity/hybrid/connect/whatis-fed.md) using [SAMLP/SAML 2.0](~/identity/hybrid/connect/how-to-connect-fed-saml-idp.md) federation, Microsoft Entra will redirect to the IdP for authentication, and expect a response that contains a SAML 2.0 assertion. The inbound MFA assertions must be present in the `AuthnContext` element of the `AuthnStatement`.

```xml
<AuthnStatement AuthnInstant="2024-11-22T18:48:07.547Z">
    <AuthnContext>
        <AuthnContextClassRef>http://schemas.microsoft.com/claims/multipleauthn</AuthnContextClassRef>
    </AuthnContext>
</AuthnStatement>
```

As a result, for inbound MFA assertions to be processed by Microsoft Entra, they **must** be present in the `AuthnContext` element of the `AuthnStatement`. Only one method can be presented in this manner.

### Using sign-in frequency and session control Conditional Access policies with SAML 2.0

[Sign-in frequency](~/identity/conditional-access/concept-conditional-access-session.md#sign-in-frequency) uses AuthInstant of either MFA or First Factor auth provided in the `AuthnStatement`. Any assertions shared in the `AttributeReference` section of the payload are ignored, including `http://schemas.microsoft.com/ws/2017/04/identity/claims/multifactorauthenticationinstant`. 

## Related content

[federatedIdpMfaBehaviour](/graph/api/domain-post-federationconfiguration#federatedidpmfabehavior-values)







