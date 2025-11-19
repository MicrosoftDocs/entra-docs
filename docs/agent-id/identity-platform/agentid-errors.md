---
title: Microsoft Agent ID error codes
description: Learn about the Agent ID, Agent Blueprint, and Agent Identity error codes.
author: ryankbr
manager: nagdeepk
ms.author: ryankabir
ms.custom: 
ms.date: 11/12/2025
ms.reviewer: 
ms.service: "entra-applications"

ms.topic: error-reference
#Customer intent: As a developer troubleshooting errors, I want to understand the meaning and possible resolutions for the Agent ID error codes, so that I can effectively debug and fix issues in my application.
---

# Agent ID Error Codes

Looking for info about the Agent ID error codes? Read this document to find Agent ID, Agent Blueprint, and Agent Identity error descriptions and suggested workarounds.

## Handling error codes in your application

The [OAuth2.0 spec](https://tools.ietf.org/html/rfc6749#section-5.2) provides guidance on how to handle errors during authentication using the `error` portion of the error response. 

Here's a sample error response:

```json
{
  "error": "invalid_scope",
  "error_description": "AADSTS70011: The provided value for the input parameter 'scope' isn't valid. The scope [https://example.contoso.com/activity.read](https://example.contoso.com/activity.read) isn't valid.\r\nTrace ID: 0000aaaa-11bb-cccc-dd22-eeeeee333333\r\nCorrelation ID: aaaa0000-bb11-2222-33cc-444444dddddd\r\nTimestamp: 2016-01-09 02:02:12Z",
  "error_codes": [
    70011
  ],
  "timestamp": "2016-01-09 02:02:12Z",
  "trace_id": "0000aaaa-11bb-cccc-dd22-eeeeee333333",
  "correlation_id": "aaaa0000-bb11-2222-33cc-444444dddddd", 
  "error_uri":"[https://login.microsoftonline.com/error?code=70011](https://login.microsoftonline.com/error?code=70011)"
}
```

| Parameter         | Description    |
|-------------------|----------------|
| `error`       | An error code string that can be used to classify types of errors that occur, and should be used to react to errors. |
| `error_description` | A specific error message that can help a developer identify the root cause of an authentication error. Never use this field to react to an error in your code. |
| `error_codes` | A list of STS-specific error codes that can help in diagnostics.  |
| `timestamp`   | This returns the time at which the error occurred. |
| `trace_id`    | A unique identifier for the request that can help in diagnostics. |
| `correlation_id` | A unique identifier for the request that can help in diagnostics across components. |
| `error_uri` |  A link to the error lookup page with additional information about the error. This link is for developer usage only; don't present it to users. It's only present when the error lookup system has additional information about the error, and this info isn't provided for all errors.|

The `error` field has several possible values - review the protocol documentation links and OAuth 2.0 specs to learn more about specific errors (for example, `authorization_pending` in the [device code flow](/azure/active-directory/develop/v2-oauth2-device-code)) and how to react to them. Some common ones are listed here:

| Error Code         | Description        | Client Action    |
|--------------------|--------------------|------------------|
| `invalid_request`  | Protocol error, such as a missing required parameter. | Fix and resubmit the request.|
| `invalid_grant`    | Some of the authentication material (auth code, refresh token, access token, PKCE challenge) was invalid, unparseable, missing, or otherwise unusable | Try a new request to the `/authorize` endpoint to get a new authorization code. Consider reviewing and validating that app's use of the protocols. |
| `unauthorized_client` | The authenticated client isn't authorized to use this authorization grant type. | This error usually occurs when the client application isn't registered in Microsoft Entra ID or isn't added to the user's Microsoft Entra tenant. The application can prompt the user with instruction for installing the application and adding it to Microsoft Entra ID. |
| `invalid_client` | Client authentication failed.  | The client credentials aren't valid. To fix, the Application Administrator updates the credentials.   |
| `unsupported_grant_type` | The authorization server doesn't support the authorization grant type. | Change the grant type in the request. This type of error should occur only during development and be detected during initial testing. |
| `invalid_resource` | The target resource is invalid because it doesn't exist, Microsoft Entra ID can't find it, or it isn't configured correctly. | This error indicates the resource, if it exists, isn't configured in the tenant. The application can prompt the user with instruction for installing the application and adding it to Microsoft Entra ID. During development, this usually indicates an incorrectly set up test tenant or a typo in the name of the scope being requested. |
| `interaction_required` | The request requires user interaction. For example, another authentication step is required. | Retry the request with the same resource, interactively, so that the user can complete any challenges required.  |
| `temporarily_unavailable` | The server is temporarily too busy to handle the request. | Retry the request. The client application might explain to the user that its response is delayed because of a temporary condition. |

## Agent ID, Blueprint, and Identity Error Codes

The following table describes the error codes specific to the Agent ID platform.

| Error | Description |
|---|---|
| `AgentBlueprint_NotSupportedOnApiVersion` | Agent Blueprints aren't supported on the API version used in this request. |
| `AgentBlueprint_IncompatibleProperty` | A property specified in the request is incompatible with Agent Blueprints and can't be set. |
| `AgentBlueprint_IncompatibleProperty_NullPropertyName` | A property in the request is incompatible with Agent Blueprints and can't be set. |
| `AgentBlueprintPrincipal_AgentIdentity_IncompatibleProperty` | A property specified in the request is incompatible with Agent Identity and can't be set. |
| `AgentBlueprintPrincipal_IncompatibleProperty` | A property specified in the request is incompatible with Agent Blueprint Principals and can't be set. |
| `AgentBlueprintPrincipal_requireAgentBlueprint` | Agent Blueprint Principals can only be created for Agent Blueprints. |
| `AgentBlueprint_LimitExceeded` | You've reached the maximum number of Agent Blueprints allowed (including active and soft-deleted items). To create more, you must permanently delete unneeded blueprints. |
| `AgentIdentity_LimitExceeded` | You've reached the maximum number of Agent Identities allowed (including active and soft-deleted entries). To add more, you must permanently delete unneeded Agent Identities. |
| `AgentIdentity_AgentBlueprintPrincipalDoesNotExist` | The required Agent Blueprint Principal doesn't exist for the specified Agent Identity Blueprint ID. |
| `AgentIdentity_InompatibleParentType` | The specified Application (AppId) isn't an Agent Blueprint. The AgentIdentityBlueprintId must be set to the AppId of a valid Agent Blueprint. |
| `Error_AgentIdentitiesCreatingAgentIdentitiesNotAllowed` | Agent Identities can't create other Agent Identities. To create an Agent Identity, use the associated Agent Blueprint Principal or nonagent Blueprint Service Principal with the required permissions. |
| `Error_AgentBlueprintCannotCreateAssociatedIdentity` | Agent Blueprints can't create Agent Identities that are associated with another Agent Blueprint. To create this Agent Identity, either use the Agent Blueprint that's associated with the Agent Identity, or perform the operation with a different principal that has the required roles/permissions to create Agent Identities. |
| `Error_AgentIdentitySelfCreateRequired` | Applications can only create Agent Identities under themselves. The provided AgentIdentityBlueprintId doesn't match the calling application's AppId. |
| `AgentBlueprintPrincipal_NotSupportedOnApiVersion` | Agent Blueprint Principals aren't supported on the API version used in this request. |
| `AgentIdentity_NotSupportedOnApiVersion` | Agent Identities aren't supported on the API version used in this request. |

## Next steps

  * Have a question or can't find what you're looking for? Create a GitHub issue or see [Support and help options for developers](/entra/identity-platform/developer-support-help-options) to learn about other ways you can get help and support.