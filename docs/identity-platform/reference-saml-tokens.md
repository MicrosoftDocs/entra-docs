---
title: SAML 2.0 token claims reference
description: Claims reference with details on the claims included in SAML 2.0 tokens issued by the Microsoft identity platform, including their JWT equivalents.
author: cilwerner
manager: CelesteDG
ms.author: cwerner
ms.custom: 
ms.date: 01/19/2023
ms.reviewer: alamaral
ms.service: identity-platform

ms.topic: reference
#Customer intent: As a developer integrating with the Microsoft identity platform, I want to understand the format and contents of SAML tokens, so that I can properly handle and validate them in my application.
---

# SAML token claims reference

The Microsoft identity platform emits several types of security tokens in the processing of each authentication flow. This document describes the format, security characteristics, and contents of SAML 2.0 tokens.

## Claims in SAML tokens

> [!div class="mx-codeBreakAll"]
> | Name | Equivalent JWT Claim | Description | Example |
> | --- | --- | --- | ------------|
> |Audience | `aud` |The intended recipient of the token. The application that receives the token must verify that the audience value is correct and reject any tokens intended for a different audience. | `<AudienceRestriction>`<br>`<Audience>`<br>`https://contoso.com`<br>`</Audience>`<br>`</AudienceRestriction>`  |
> | Authentication Instant | |Records the date and time when authentication occurred. | `<AuthnStatement AuthnInstant="2011-12-29T05:35:22.000Z">` |
> |Authentication Method | `amr` |Identifies how the subject of the token was authenticated. | `<AuthnContextClassRef>`<br>`http://schemas.microsoft.com/ws/2008/06/identity/claims/authenticationmethod/password`<br>`</AuthnContextClassRef>` |
> |First Name | `given_name` |Provides the first or "given" name of the user, as set on the Microsoft Entra user object. | `<Attribute Name="http://schemas.xmlsoap.org/ws/2005/05/identity/claims/givenname">`<br>`<AttributeValue>Frank<AttributeValue>`  |
> |Groups | `groups` |Provides object IDs that represent the subject's group memberships. These values are unique (see Object ID) and can be safely used for managing access, such as enforcing authorization to access a resource. The groups included in the groups claim are configured on a per-application basis, through the "groupMembershipClaims" property of the application manifest. A value of null will exclude all groups, a value of "SecurityGroup" will include directory roles and Active Directory Security Group memberships, and a value of "All" will include both Security Groups and Microsoft 365 Distribution Lists. <br><br> **Notes**: <br> If the number of groups the user is in goes over a limit (150 for SAML, 200 for JWT) then an overage claim will be added the claim sources pointing at the Graph endpoint containing the list of groups for the user. | `<Attribute Name="http://schemas.microsoft.com/ws/2008/06/identity/claims/groups">`<br>`<AttributeValueaaaaaaaa-0000-1111-2222-bbbbbbbbbbbb</AttributeValue>` |
> | Groups Overage Indicator | `groups:src1` | For token requests that are not length-limited but still too large for the token, a link to the full groups list for the user will be included. For SAML this is added as a new claim in place of the `groups` claim. <br><br> **Notes**: <br> The Azure AD Graph API is being replaced by the Microsoft Graph API. To learn more about the equivalent endpoint, see [user: getMemberObjects](/graph/api/directoryobject-getmemberobjects). | `<Attribute Name=" http://schemas.microsoft.com/claims/groups.link">`<br>`<AttributeValue>https://graph.windows.net/{tenantID}/users/{userID}/getMemberObjects<AttributeValue>` |
> |Identity Provider | `idp` |Records the identity provider that authenticated the subject of the token. This value is identical to the value of the Issuer claim unless the user account is in a different tenant than the issuer. | `<Attribute Name=" http://schemas.microsoft.com/identity/claims/identityprovider">`<br>`<AttributeValue>https://sts.windows.net/aaaabbbb-0000-cccc-1111-dddd2222eeee/<AttributeValue>` |
> |IssuedAt | `iat` |Stores the time at which the token was issued. It is often used to measure token freshness. | `<Assertion ID="_d5ec7a9b-8d8f-4b44-8c94-9812612142be" IssueInstant="2014-01-06T20:20:23.085Z" Version="2.0" xmlns="urn:oasis:names:tc:SAML:2.0:assertion">` |
> |Issuer | `iss` |Identifies the security token service (STS) that constructs and returns the token. In the tokens that Microsoft Entra ID returns, the issuer is sts.windows.net. The GUID in the Issuer claim value is the tenant ID of the Microsoft Entra directory. The tenant ID is an immutable and reliable identifier of the directory. | `<Issuer>https://sts.windows.net/aaaabbbb-0000-cccc-1111-dddd2222eeee/</Issuer>` |
> |Last Name | `family_name` |Provides the last name, surname, or family name of the user as defined in the Microsoft Entra user object. | `<Attribute Name=" http://schemas.xmlsoap.org/ws/2005/05/identity/claims/surname">`<br>`<AttributeValue>Miller<AttributeValue>` |
> |Name | `unique_name` |Provides a human readable value that identifies the subject of the token. This value is not guaranteed to be unique within a tenant and is designed to be used only for display purposes. | `<Attribute Name="http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name">`<br>`<AttributeValue>frankm@contoso.com<AttributeValue>`|
> |Object ID | `oid` |Contains a unique identifier of an object in Microsoft Entra ID. This value is immutable and cannot be reassigned or reused. Use the object ID to identify an object in queries to Microsoft Entra ID. | `<Attribute Name="http://schemas.microsoft.com/identity/claims/objectidentifier">`<br>`<AttributeValue>bbbbbbbb-1111-2222-3333-cccccccccccc<AttributeValue>` |
> |Roles | `roles` |Represents all application roles that the subject has been granted both directly and indirectly through group membership and can be used to enforce role-based access control. Application roles are defined on a per-application basis, through the `appRoles` property of the application manifest. The `value` property of each application role is the value that appears in the roles claim. | `<Attribute Name="http://schemas.microsoft.com/ws/2008/06/identity/claims/role">`|
> |Subject | `sub` |Identifies the principal about which the token asserts information, such as the user of an application. This value is immutable and cannot be reassigned or reused, so it can be used to perform authorization checks safely. Because the subject is always present in the tokens the Microsoft Entra ID issues, we recommended using this value in a general purpose authorization system. <br> `SubjectConfirmation` is not a claim. It describes how the subject of the token is verified. `Bearer` indicates that the subject is confirmed by their possession of the token. | `<Subject>`<br>`<NameID>S40rgb3XjhFTv6EQTETkEzcgVmToHKRkZUIsJlmLdVc</NameID>`<br>`<SubjectConfirmation Method="urn:oasis:names:tc:SAML:2.0:cm:bearer" />`<br>`</Subject>`|
> |Tenant ID | `tid` |An immutable, non-reusable identifier that identifies the directory tenant that issued the token. You can use this value to access tenant-specific directory resources in a multi-tenant application. For example, you can use this value to identify the tenant in a call to the Graph API. | `<Attribute Name="http://schemas.microsoft.com/identity/claims/tenantid">`<br>`<AttributeValue>aaaabbbb-0000-cccc-1111-dddd2222eeee<AttributeValue>`|
> |Token Lifetime | `nbf`, `exp` |Defines the time interval within which a token is valid. The service that validates the token should verify that the current date is within the token lifetime, else it should reject the token. The service might allow for up to five minutes beyond the token lifetime range to account for any differences in clock time ("time skew") between Microsoft Entra ID and the service. | `<Conditions`<br>`NotBefore="2013-03-18T21:32:51.261Z"`<br>`NotOnOrAfter="2013-03-18T22:32:51.261Z"`<br>`>` <br>|

## Sample SAML Token

This is a sample of a typical SAML token.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<t:RequestSecurityTokenResponse xmlns:t="http://schemas.xmlsoap.org/ws/2005/02/trust">
    <t:Lifetime>
        <wsu:Created xmlns:wsu="https://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd">2014-12-24T05:15:47.060Z</wsu:Created>
        <wsu:Expires xmlns:wsu="https://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd">2014-12-24T06:15:47.060Z</wsu:Expires>
    </t:Lifetime>
    <wsp:AppliesTo xmlns:wsp="http://schemas.xmlsoap.org/ws/2004/09/policy">
        <EndpointReference xmlns="https://www.w3.org/2005/08/addressing">
            <Address>https://contoso.onmicrosoft.com/MyWebApp</Address>
        </EndpointReference>
    </wsp:AppliesTo>
    <t:RequestedSecurityToken>
        <Assertion xmlns="urn:oasis:names:tc:SAML:2.0:assertion" ID="_aaaaaaaa-0b0b-1c1c-2d2d-333333333333" IssueInstant="2014-12-24T05:20:47.060Z" Version="2.0">
            <Issuer>https://sts.windows.net/aaaabbbb-0000-cccc-1111-dddd2222eeee/</Issuer>
            <ds:Signature xmlns:ds="https://www.w3.org/2000/09/xmldsig#">
                <ds:SignedInfo>
                    <ds:CanonicalizationMethod Algorithm="https://www.w3.org/2001/10/xml-exc-c14n#" />
                    <ds:SignatureMethod Algorithm="https://www.w3.org/2001/04/xmldsig-more#rsa-sha256" />
                    <ds:Reference URI="#_aaaaaaaa-0b0b-1c1c-2d2d-333333333333">
                        <ds:Transforms>
                            <ds:Transform Algorithm="https://www.w3.org/2000/09/xmldsig#enveloped-signature" />
                            <ds:Transform Algorithm="https://www.w3.org/2001/10/xml-exc-c14n#" />
                        </ds:Transforms>
                        <ds:DigestMethod Algorithm="https://www.w3.org/2001/04/xmlenc#sha256" />
                        <ds:DigestValue>E3fH4iJ5kL6mN7oP8qR9sT0uV1wX2y/nDY=</ds:DigestValue>
                    </ds:Reference>
                </ds:SignedInfo>
                <ds:SignatureValue>aB1cD2eF3gH4i...J5kL6-mN7oP8qR==</ds:SignatureValue>
                <KeyInfo xmlns="https://www.w3.org/2000/09/xmldsig#">
                    <X509Data>
                        <X509Certificate>C2dE3fH4iJ5kL6mN7oP8qR9sT0uV1w</X509Certificate>
                    </X509Data>
                </KeyInfo>
            </ds:Signature>
            <Subject>
                <NameID Format="urn:oasis:names:tc:SAML:2.0:nameid-format:persistent">m_H3naDei2LNxUmEcWd0BZlNi_jVET1pMLR6iQSuYmo</NameID>
                <SubjectConfirmation Method="urn:oasis:names:tc:SAML:2.0:cm:bearer" />
            </Subject>
            <Conditions NotBefore="2014-12-24T05:15:47.060Z" NotOnOrAfter="2014-12-24T06:15:47.060Z">
                <AudienceRestriction>
                    <Audience>https://contoso.onmicrosoft.com/MyWebApp</Audience>
                </AudienceRestriction>
            </Conditions>
            <AttributeStatement>
                <Attribute Name="http://schemas.microsoft.com/identity/claims/objectidentifier">
                    <AttributeValue>aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb</AttributeValue>
                </Attribute>
                <Attribute Name="http://schemas.microsoft.com/identity/claims/tenantid">
                    <AttributeValue>aaaabbbb-0000-cccc-1111-dddd2222eeee</AttributeValue>
                </Attribute>
                <Attribute Name="http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name">
                    <AttributeValue>sample.admin@contoso.onmicrosoft.com</AttributeValue>
                </Attribute>
                <Attribute Name="http://schemas.xmlsoap.org/ws/2005/05/identity/claims/surname">
                    <AttributeValue>Admin</AttributeValue>
                </Attribute>
                <Attribute Name="http://schemas.xmlsoap.org/ws/2005/05/identity/claims/givenname">
                    <AttributeValue>Sample</AttributeValue>
                </Attribute>
                <Attribute Name="http://schemas.microsoft.com/ws/2008/06/identity/claims/groups">
                    <AttributeValue>5581e43f-6096-41d4-8ffa-04e560bab39d</AttributeValue>
                    <AttributeValue>07dd8a89-bf6d-4e81-8844-230b77145381</AttributeValue>
                    <AttributeValue>0e129f4g-6b0a-4944-982d-f776000632af</AttributeValue>
                    <AttributeValue>3ee07328-52ef-4739-a89b-109708c22fb5</AttributeValue>
                    <AttributeValue>329k14b3-1851-4b94-947f-9a4dacb595f4</AttributeValue>
                    <AttributeValue>6e32c650-9b0a-4491-b429-6c60d2ca9a42</AttributeValue>
                    <AttributeValue>f3a169a7-9a58-4e8f-9d47-b70029v07424</AttributeValue>
                    <AttributeValue>8e2c86b2-b1ad-476d-9574-544d155aa6ff</AttributeValue>
                    <AttributeValue>1bf80264-ff24-4866-b22c-6212e5b9a847</AttributeValue>
                    <AttributeValue>4075f9c3-072d-4c32-b542-03e6bc678f3e</AttributeValue>
                    <AttributeValue>76f80527-f2cd-46f4-8c52-8jvd8bc749b1</AttributeValue>
                    <AttributeValue>0ba31460-44d0-42b5-b90c-47b3fcc48e35</AttributeValue>
                    <AttributeValue>edd41703-8652-4948-94a7-2d917bba7667</AttributeValue>
                </Attribute>
                <Attribute Name="http://schemas.microsoft.com/identity/claims/identityprovider">
                    <AttributeValue>https://sts.windows.net/aaaabbbb-0000-cccc-1111-dddd2222eeee/</AttributeValue>
                </Attribute>
            </AttributeStatement>
            <AuthnStatement AuthnInstant="2014-12-23T18:51:11.000Z">
                <AuthnContext>
                    <AuthnContextClassRef>urn:oasis:names:tc:SAML:2.0:ac:classes:Password</AuthnContextClassRef>
                </AuthnContext>
            </AuthnStatement>
        </Assertion>
    </t:RequestedSecurityToken>
    <t:RequestedAttachedReference>
        <SecurityTokenReference xmlns="https://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd" xmlns:d3p1="https://docs.oasis-open.org/wss/oasis-wss-wssecurity-secext-1.1.xsd" d3p1:TokenType="http://docs.oasis-open.org/wss/oasis-wss-saml-token-profile-1.1#SAMLV2.0">
            <KeyIdentifier ValueType="http://docs.oasis-open.org/wss/oasis-wss-saml-token-profile-1.1#SAMLID">_aaaaaaaa-0b0b-1c1c-2d2d-333333333333</KeyIdentifier>
        </SecurityTokenReference>
    </t:RequestedAttachedReference>
    <t:RequestedUnattachedReference>
        <SecurityTokenReference xmlns="https://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd" xmlns:d3p1="https://docs.oasis-open.org/wss/oasis-wss-wssecurity-secext-1.1.xsd" d3p1:TokenType="http://docs.oasis-open.org/wss/oasis-wss-saml-token-profile-1.1#SAMLV2.0">
            <KeyIdentifier ValueType="http://docs.oasis-open.org/wss/oasis-wss-saml-token-profile-1.1#SAMLID">_aaaaaaaa-0b0b-1c1c-2d2d-333333333333</KeyIdentifier>
        </SecurityTokenReference>
    </t:RequestedUnattachedReference>
    <t:TokenType>http://docs.oasis-open.org/wss/oasis-wss-saml-token-profile-1.1#SAMLV2.0</t:TokenType>
    <t:RequestType>http://schemas.xmlsoap.org/ws/2005/02/trust/Issue</t:RequestType>
    <t:KeyType>http://schemas.xmlsoap.org/ws/2005/05/identity/NoProofKey</t:KeyType>
</t:RequestSecurityTokenResponse>
```

## Next steps

* To learn more about managing token lifetime policy using the Microsoft Graph API, see the [Microsoft Entra policy resource overview](/graph/api/resources/policy-overview).
* Add [custom and optional claims](./optional-claims.md) to the tokens for your application.
* Use [Single Sign-On (SSO) with SAML](single-sign-on-saml-protocol.md).
* Use the [Azure Single Sign-Out SAML protocol](single-sign-out-saml-protocol.md)
