---
title: Microsoft Entra ID multifactor authentication (MFA) SAML/WSFed assertions
description: Explains Microsoft Entra ID multifactor authentication (MFA) SAML/WSFed assertions.

ms.service: entra-id
ms.subservice: authentication
ms.topic: conceptual
ms.date: 12/04/2024

author: brozbab
ms.author: justinha
manager: amycolannino
ms.reviewer: bozbayburtlu
---
# Microsoft Entra ID multifactor authentication (MFA) SAML/WSFed assertions

This document outlines the assertions Microsoft Entra ID requires from a [federated Identity Provider (IdP)](~/identity/hybrid/connect/whatis-fed.md) to honor configured [federatedIdpMfaBehaviour](/graph/api/domain-post-federationconfiguration#federatedidpmfabehavior-values) values of acceptIfMfaDoneByFederatedIdp and enforceMfaByFederatedIdp for SAMLP and ws-federation [internalDomainFederations](/graph/api/resources/internaldomainfederation).

## WSFed/SAML1.1   
When an internal domain federation is configured using ws-federation Entra will redirect to IdP for authentication and expect a response in the form of a Request Security Token Response (RSTR) containing a SAML 1.1 assertion. If configured to do so, Entra will honor MFA done by the Identity Provider if one of the following two claims are present:

- `http://schemas.microsoft.com/claims/multipleauthn`
- `http://schemas.microsoft.com/claims/wiaormultiauthn`

They can be included in the assertion as part of the AuthenticationStatement element. For example: 

```xml
 <saml:AuthenticationStatement
    AuthenticationMethod="http://schemas.microsoft.com/claims/multipleauthn" ..>
    <saml:Subject> ... </saml:Subject>
</saml:AuthenticationStatement>
```

Or they can be included in the assertion as part of the AttributeStatement elements. For example:

```xml
<saml:AttributeStatement>
  <saml:Attribute AttributeName="authenticationmethod" AttributeNamespace="http://schemas.microsoft.com/ws/2008/06/identity/claims">
       <saml:AttributeValue>...</saml:AttributeValue> 
      <saml:AttributeValue>http://schemas.microsoft.com/claims/multipleauthn</saml:AttributeValue>
  </saml:Attribute>
</saml:AttributeStatement>
```

### Using sign-in frequency and session control Conditional Access policies with WSFed/SAML 1.1

Sign-in frequency uses UserAuthenticationInstant (SAML assertion `http://schemas.microsoft.com/ws/2008/06/identity/claims/authenticationinstant`), which is AuthInstant of first factor authentication using password for SAML1.1/WS-Fed. 

## SAML 2 

When an internal domain federation is configured using SAMLP/SAML2.0 federation, Microsoft Entra will redirect to IdP for authentication and expect a response that contains a SAML 2.0 assertion.

### Actual (confirmed by BvT)

```xml
<AuthnStatement AuthnInstant="2024-11-22T18:48:07.547Z">
    <AuthnContext>
        <AuthnContextClassRef>http://schemas.microsoft.com/claims/multipleauthn</AuthnContextClassRef>
    </AuthnContext>
</AuthnStatement>
```

As a result, for inbound MFA assertions to be processed by Microsoft Entra, they **must** be present in the AuthnContext element of the AuthnStatement. A potentially unwanted side effect of this is that only one method can be presented in this manner. 

### Using sign-in frequency and session control Conditional Access policies with SAML 2.0

Sign-in frequency uses AuthInstant of either MFA or First Factor auth provided in AuthnStatement. Any assertions shared in the AttributeReference section of the payload will be ignored, including `http://schemas.microsoft.com/ws/2017/04/identity/claims/multifactorauthenticationinstant`. 

Impact of the current behaviour:

- Customers using SAML 2.0 IdPs federated using internalDomainFederation may face issues if they're unable to send multipleauthn as part of the AuthnStatement. Doing this is not typical and we know that some IdPs like Okta don't support this for SAML 2.0. Mileage may vary.
- Missing granularity around authentication methods. Our current implementation is limited to only a single Authentication method when using SAML 2.0 without attribute statements. The protocol doesn't permit multiple AuthnContextClassRef or AuthnContext elements in the Authentication statement.
- Conditional Access policies will be unable to target assertions shared in the Attribute Statement of a SAML response as they don’t make it to the corresponding downstream STS types.

## Related content

[federatedIdpMfaBehaviour](/graph/api/domain-post-federationconfiguration#federatedidpmfabehavior-values)







