---
title: Microsoft Entra ID multifactor authentication (MFA) SAML/WSFed assertions
description: Explains Microsoft Entra ID multifactor authentication (MFA) SAML/WSFed assertions.

ms.service: entra-id
ms.subservice: authentication
ms.topic: conceptual
ms.date: 12/05/2024

author: brozbab
ms.author: justinha
manager: amycolannino
ms.reviewer: bozbayburtlu
---
# Microsoft Entra ID multifactor authentication (MFA) SAML/WSFed assertions

This document outlines the assertions Microsoft Entra ID requires from a [federated identity provider (IdP)](~/identity/hybrid/connect/whatis-fed.md) to honor configured [federatedIdpMfaBehaviour](/graph/api/domain-post-federationconfiguration#federatedidpmfabehavior-values) values of acceptIfMfaDoneByFederatedIdp and enforceMfaByFederatedIdp for Security Assertions Markup Language (SAML) and WS-Fed federation.

## WSFed/SAML1.1   
When an admin optionally configures their Entra ID tenant to use a [federated IdP](~/identity/hybrid/connect/whatis-fed.md) using WS-Fed federation, Microsoft Entra redirects to IdP for authentication and expect a response in the form of a Request Security Token Response (RSTR) containing a SAML 1.1 assertion. If configured to do so, Microsoft Entra honors MFA done by the IdP if one of the following two claims is present:

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

### Using sign-in frequency and session control Conditional Access policies with WSFed/SAML 1.1

[Sign-in frequency](~/identity/conditional-access/concept-conditional-access-session.md#sign-in-frequency) uses UserAuthenticationInstant (SAML assertion `http://schemas.microsoft.com/ws/2008/06/identity/claims/authenticationinstant`), which is AuthInstant of first factor authentication using password for SAML1.1/WS-Fed. 

## SAML 2 

When an admin optionally configures their Entra ID tenant to use a [federated IdP](~/identity/hybrid/connect/whatis-fed.md) using SAMLP/SAML2.0 federation, Microsoft Entra will redirect to IdP for authentication and expect a response that contains a SAML 2.0 assertion.

### Actual (confirmed by BvT)

When an admin optionally configures their Entra ID tenant to use a [federated IdP](~/identity/hybrid/connect/whatis-fed.md) using SAMLP/SAML2.0 federation, Microsoft Entra will redirect to the IdP for authentication, and expect a response that contains a SAML 2.0 assertion. The inbound MFA assertions must be present in the `AuthnContext` element of the `AuthnStatement`.

```xml
<AuthnStatement AuthnInstant="2024-11-22T18:48:07.547Z">
    <AuthnContext>
        <AuthnContextClassRef>http://schemas.microsoft.com/claims/multipleauthn</AuthnContextClassRef>
    </AuthnContext>
</AuthnStatement>
```

As a result, for inbound MFA assertions to be processed by Microsoft Entra, they **must** be present in the AuthnContext element of the AuthnStatement. A potentially unwanted side effect of this is that only one method can be presented in this manner. 

### Using sign-in frequency and session control Conditional Access policies with SAML 2.0

[Sign-in frequency](~/identity/conditional-access/concept-conditional-access-session.md#sign-in-frequency) uses AuthInstant of either MFA or First Factor auth provided in AuthnStatement. Any assertions shared in the AttributeReference section of the payload will be ignored, including `http://schemas.microsoft.com/ws/2017/04/identity/claims/multifactorauthenticationinstant`. 

## Related content

[federatedIdpMfaBehaviour](/graph/api/domain-post-federationconfiguration#federatedidpmfabehavior-values)







