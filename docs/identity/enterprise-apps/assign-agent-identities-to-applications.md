---
title: Manage assignment of agent identities to an application (Preview)
description: Discover how to configure agent identities for enterprise applications in Microsoft Entra ID. Assign roles, manage permissions, and streamline app interactions.

author: omondiatieno
manager: mwongerapk
ms.service: entra-id
ms.subservice: enterprise-apps

ms.topic: how-to
ms.date: 11/19/2025
ms.author: jomondi
ms.reviewer: mwahl

#customer intent: As an IT admin, I want to assign agent identities to enterprise applications so that agents can interact with those applications securely.
---

# Manage assignment of agent identities to an application (Preview)

In this article, you learn how to assign agent identities to an enterprise application in Microsoft Entra ID for agents that plan to interact with an application. The Microsoft Entra configuration steps depend on the capabilities of the agent and the enterprise application.

Organizations can control which of their employee and business guest users in their Microsoft Entra tenant can interact with the organization's enterprise applications, by configuring each application to rely upon Microsoft Entra for single-sign on or provisioning, and requiring those users to be assigned to the application. If an application exposes multiple app roles, you can also assign a specific app role to each user. For more information, see [Manage users and groups assignment to an application](assign-user-or-group-access-portal.md).

When an AI agent has a tool (or might be referred to in its platform as a skill or connector) to communicate with an enterprise application in your tenant, you can assign that tool's identity to the application. The tool might use a service principal, agent identity, or an agent user for authentication. By assigning these identities to the enterprise application's roles and permissions, you allow agent-supporting applications to recognize the agent identity and enable the agent to obtain appropriate tokens from Microsoft Entra ID for application access.

This article outlines how to select across three options, based on the application's capabilities.

|Application capabilities|Section|
|--|--|
| Application exposes APIs with OAuth2 permission scopes| [consent the agent identity or service principal to an application permission scope](#consenting-to-an-application-permission-scope)|
| Application recognizes role claims for service principals| [assign an agent identity or service principal to an application role](#assigning-an-agent-identity-to-an-application-role)|
|Application only supports SAML for users | [assign an agent user to an application role for use with SCIM](#assigning-to-saml-based-applications)|

## Consenting to an application permission scope

Applications using the Microsoft Entra identity platform can [expose APIs for other client applications to call](../../identity-platform/quickstart-configure-app-expose-web-apis.md#register-the-web-api). The application with the API can expose OAuth scopes for those API calls. The tool's service principal can be consented permission to those scopes, allowing it to call the APIs.

:::image type="content" source="../../identity-platform/media/quickstart-configure-app-access-web-apis/diagram-01-app-permission-to-api-scopes.svg" alt-text="Line diagram showing a web API with exposed scopes on the right and a client app on the left with those scopes selected as permissions." border="false":::

For more information on consenting an agent identity or service principal, see [admin consent for application permissions](grant-admin-consent.md#grant-admin-consent-for-application-permissions-using-microsoft-graph-api).

## Assigning an agent identity to an application role

For applications that recognize role claims on service principals, you can assign an agent's service principal or agent identity to an application's app role. When you assign to app roles, this results in application permissions. Application permissions are typically used by daemon apps, back-end services or autonomous agents, that need to authenticate and make authorized API call as themselves, without the interaction of a user. For more information, see [Add app roles to your application and receive them in the token](../../identity-platform/howto-add-app-roles-in-apps.md).

> [!NOTE]
> Microsoft Entra SCIM outbound provisioning supports users and groups only; Service principals and agent identities assigned to app roles directly or as members of groups aren't provisioned to applications.

First, confirm that app role in the application's manifest has an `allowedMemberTypes` of `Application`, indicating that the role is available for other applications. If the role only allows users, then agent identities and service principals aren't supported by the application for that role.
Then, you can assign an app role to an agent identity or service principal, by using the Microsoft Entra admin center, Microsoft Graph or Microsoft Graph PowerShell.

* If you're using the Microsoft Entra admin center, follow the instructions in how to [assign to application app roles](../../identity-platform/howto-add-app-roles-in-apps.md#assign-app-roles-to-applications).

* If you're using Microsoft Graph or Microsoft Graph PowerShell, then assigning an agent identity or service principal to an application role is similar to [assigning users and groups to an application](assign-user-or-group-access-portal.md#assign-users-and-groups-to-an-application-using-microsoft-graph-api). You can use [list app role assignment](/graph/api/serviceprincipal-list-approleassignedto) to check if the agent identity or service principal already has a role assignment, and use [add app role assignment](/graph/api/serviceprincipal-post-approleassignedto) to create a new app role assignment. For example, to create an application role assignment for an agent identity using PowerShell, set `$PrincipalId` to the `id` of the agent identity, `$ResourceId` to the `id` of the target application service principal, and `$AppRoleId` to the ID of the app role of the target application app role. Then, construct a payload for adding an application role assignment:

  ```powershell

  $Body = @{
    principalId = $PrincipalId
    resourceId = $ResourceId
    appRoleId = $AppRoleId
  } | ConvertTo-Json

  Invoke-MgGraphRequest -Method POST -Uri "https://graph.microsoft.com/v1.0/servicePrincipals/$ResourceId/appRoleAssignedTo" -Body $Body
  ```

## Assigning to SAML-based applications

If you have applications that only support SAML for a user to obtain a token, and you want your agent to be able to autonomously interact with its agent identity with that application, then you can augment the agent's identity with agent users. Then, once you add support for SAML and agent users to your agent, your agent can obtain a token for the application. Unlike agent identities, agent users can optionally also be provisioned into those applications via SCIM, if required by the application.

> [!NOTE]
> Confirm with the application developer whether the application supports the agent interaction pattern.

Enabling an agent to interact with an application that accepts SAML assertions requires there to be an extra application registration to participate in the flow for [Microsoft Entra ID to provide a SAML assertion in response to an on-behalf-flow](../../identity-platform/v2-oauth2-on-behalf-of-flow.md#saml-assertions-obtained-with-an-oauth20-obo-flow). In addition to the agent itself and the application, you need to create a SAML helper application registration for any SAML-based applications in the tenant. If you're developing the agent in-house, this helper could be part of the agent.

In the Microsoft Entra tenant, the following artifacts need to exist:

* the agent identity blueprint and agent identity blueprint principal
* the SAML helper application registration
* the enterprise application as the target resource
* an `OAuth2PermissionGrant`, with
  * the SAML helper application registration as the client
  * the enterprise application as the resource
  * the scope value of the concatenation of the enterprise application's entity ID with `/.default` appended

Then, for each agent identity of the agent, you create:

* an agent user
* an application role assignment, for the agent user, to one of the roles of the enterprise application
* an `OAuth2PermissionGrant`, for the agent identity, with
  * the agent identity as the client
  * the SAML helper application registration as the resource
  * the scope value of the concatenation of `api://'`, the SAML helper application's application ID, and `/.default`

:::image type="content" source="media/assign-agent-identities-to-applications/agent-saml.png" alt-text="Diagram of relationships between Microsoft Entra artifacts needed for SAML token issuance.":::

If the agent has multiple agent identities, then permission inheritance can be used to grant consent once at the agent identity blueprint and inherit it for the agent identities.

Once these applications, users, role assignments, and grants are in place in the tenant, then an agent that needs a SAML assertion for authenticating to the enterprise application can:

- Get a token as the agent identity blueprint.
- Use that token to make a token request to `https://login.microsoftonline.com/<tenantid>/oauth2/v2.0/token` endpoint, and get a federated identity credential (FIC) token as the agent identity. 
   
   In that request, the `client_id` is the agent identity ID, the `scope` is `api://AzureADTokenExchange/.default`, the `grant_type` is `client_credentials`, the `client_assertion_type` is `urn:ietf:params:oauth:client-assertion-type:jwt-bearer`, and the `client_assertion` is the agent identity blueprint token from step 1.

- Use those two tokens to make a token request for a token as the agent user with the scope of the helper application. 
   
   In this request, the `client_id` is the agent identity ID, the `scope` is the concatenation of `api://'`, the SAML helper application's application ID, and `/.default`, the `grant_type` is `user_fic`, the `client_assertion_type` is `urn:ietf:params:oauth:client-assertion-type:jwt-bearer`, the `client_assertion` is the agent identity blueprint token, the `user_id` is the agent user object ID, and the `user_federated_identity_credential` is the agent identity token.

- Make the on-behalf-of-call token request to `https://login.microsoftonline.com/<tenantid>/oauth2/v2.0/token` to [obtain a SAML token](../../identity-platform/v2-oauth2-on-behalf-of-flow.md#obtain-a-saml-token-by-using-an-obo-request-with-a-shared-secret). 

   In this request, provide the credentials of the SAML helper application registration, the token returned by `user_fic` as the assertion, the grant type `urn:ietf:params:oauth:grant-type:jwt-bearer`, scope of the enterprise application's app ID with `/.default` appended, the `requested_token_use` of `on_behalf_of` and the `requested_token_type` of `urn:ietf:params:oauth:token-type:saml2`. The [response](../../identity-platform/v2-oauth2-on-behalf-of-flow.md#response-with-saml-assertion) contains a SAML assertion encoded in Base64URL.


## Related content

- [Assign users and groups to application roles](assign-user-or-group-access-portal.md)