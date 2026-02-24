---
title: Integrate third-party account takeover protection with native authentication API
description: Learn how to integrate third-party Account Takeover (ATO) protection providers with Native API authentication in Microsoft Entra External ID using a Web Application Firewall (WAF).
ms.topic: tutorial
ms.date: 02/24/2026
ai-usage: ai-assisted

#CustomerIntent: As a developer, I want to integrate third-party ATO protection with Native API authentication in Microsoft Entra External ID so that I can protect my apps from automated attacks and account compromise.
---
# Tutorial: Integrate third-party account takeover protection with native authentication API

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

This tutorial guides you through integrating third-party Account Takeover (ATO) protection providers with Native API authentication in Microsoft Entra External ID. By using a Web Application Firewall (WAF) to intercept authentication requests, you can implement risk-based MFA challenges during sign-in to protect against automated attacks and account compromise.

> [!NOTE]
> This tutorial assumes you manually make raw HTTP requests to execute the authentication flow. When possible, use a Microsoft-built and supported authentication SDK. See [Tutorial: Prepare your Android mobile app for native authentication](tutorial-native-authentication-prepare-android-app.md) and [Tutorial: Prepare your iOS/macOS mobile app for native authentication](tutorial-native-authentication-prepare-ios-macos-app.md).

## Prerequisites

- An [external tenant](how-to-create-external-tenant-portal.md). If you don't already have one, create an external tenant.
- A [registered application](/entra/identity-platform/quickstart-register-app) in the Microsoft Entra admin center with the following configuration:
    - Application (client) ID and Directory (tenant) ID recorded.
    - [Admin consent granted](/entra/identity-platform/quickstart-register-app#grant-admin-consent-external-tenants-only).
    - [Public client and native authentication flows enabled](/entra/identity-platform/concept-native-authentication#how-to-enable-native-authentication).
- A [user flow](how-to-user-flow-sign-up-sign-in-customers.md) created in the Microsoft Entra admin center and [associated with your application](how-to-user-flow-add-application.md).
- A test customer user [registered in your tenant](how-to-manage-customer-accounts.md#create-a-customer-account) for sign-in flow testing.
- An account with at least an [Authentication Extensibility Administrator](/entra/identity/role-based-access-control/permissions-reference#authentication-extensibility-administrator) or [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator) role in the external tenant.
- A [custom domain](how-to-custom-url-domain.md) associated with your external tenant.
- A third-party ATO protection provider account (this tutorial uses LexisNexis Risk Solutions as an example) with the following configuration values:
    - Session query API credentials.
    - Update API access.
    - SDK integration details.
- A WAF platform account (this tutorial uses Cloudflare) with domain administrator privileges.

## How ATO protection works

When a user attempts to sign in using Native Authentication, the authentication request flows through a Web Application Firewall (WAF) that intercepts the /token endpoint. The WAF evaluates the request with your third-party ATO provider using their risk assessment APIs. If the request is flagged as suspicious based on device fingerprinting, behavioral analysis, or other risk signals, the WAF triggers a Conditional Access policy with an authentication context that requires MFA. The user must then complete the MFA challenge before authentication proceeds.

This approach allows you to apply risk-based protections during the native sign-in flow without requiring browser-based redirects, maintaining the native app user experience while protecting against account takeover attacks.

## Architecture components

This integration involves several key components working together to provide risk-based authentication:

- **External tenant:** A dedicated Microsoft Entra ID instance for managing external identities and customer access.
- **Native application:** A mobile or desktop application that uses Microsoft Entra External ID (native authentication) to sign users up and sign them in.
- **Native APIs:** Service endpoints that enable mobile and desktop apps to perform sign-up, sign-in, and self-service password reset (SSPR) flows in-app, without a browser redirect.
- **Web Application Firewall (WAF):** A firewall that inspects incoming and outgoing HTTP traffic, intercepts authentication requests, and coordinates with the third-party provider for risk evaluation.
- **Third-party ATO provider:** A third-party provider that delivers bot detection, device fingerprinting, and risk-assessment services.
- **Conditional Access (CA) policy:** A policy that specifies which users, apps, and conditions are in scope and the controls required to grant access, triggered by authentication context.
- **Authentication context:** A Conditional Access feature that allows applying granular policies to specific actions or scenarios rather than at the app level.

## Configuration steps

1. Create a sign-in flow for an external tenant.
1. Create a WAF configuration.
1. Enable MFA for the tenant.
1. Set up the Conditional Access authentication context.
1. Create a Conditional Access policy using authentication context.
1. Update the WAF layer to intercept specific API requests during sign-in flow.
1. Update the native app sign-in API call flow to introduce MFA.

## Configure basic sign-in flow for your external tenant

1. If you don't already have one, [create an external tenant](how-to-create-external-tenant-portal.md).

1. If you haven't already, [register an application in the Microsoft Entra admin center](/entra/identity-platform/quickstart-register-app). Make sure to:

    - Record the **Application (client) ID** and **Directory (tenant) ID** for later use.
    - [Grant admin consent](/entra/identity-platform/quickstart-register-app#grant-admin-consent-external-tenants-only) to the application.
    - [Enable public client and native authentication flows](/entra/identity-platform/concept-native-authentication#how-to-enable-native-authentication).

1. If you haven't already, [create a user flow in the Microsoft Entra admin center](how-to-user-flow-sign-up-sign-in-customers.md#to-add-a-new-user-flow). When you create the user flow, take note of the user attributes you configure as required. These attributes are the ones that Microsoft Entra expects your app to submit.

1. [Associate your app registration with the user flow](how-to-user-flow-add-application.md).

1. For sign-in flow, [register a customer user](how-to-manage-customer-accounts.md#create-a-customer-account) to use for testing. Alternatively, you can get this test user after you run the sign-up flow.

## Create a WAF configuration

A WAF configuration is required to intercept the authentication requests for risk evaluation. This tutorial uses Cloudflare as an example, but you can use any WAF that supports request interception and custom logic execution.

> [!IMPORTANT]
> A custom domain must be associated with your external tenant before you configure the WAF. Without a custom domain, the WAF can't intercept authentication requests.

For detailed Cloudflare WAF setup instructions, see [Configure Cloudflare WAF with Microsoft Entra External ID](how-to-configure-waf-integration.md).

## Enable multifactor authentication (MFA) for the tenant

To enforce MFA challenges when suspicious sign-in attempts are detected, first enable MFA for your tenant. This tutorial uses email OTP as the second factor authentication method for users during risky sign-ins.

For detailed setup instructions, see [Enable Microsoft Entra multifactor authentication](/entra/identity/authentication/tutorial-enable-azure-mfa).

> [!NOTE]
> Currently, risk-based MFA for native authentication can only be applied for the "Email with Password" sign-in flow. The user must have email configured as a strong authentication method.

## Set up the Conditional Access authentication context

[Conditional Access authentication context](/entra/identity-platform/developer-guide-conditional-access-authentication-context) (auth context) allows you to apply Conditional Access policies at a granular level based on specific actions or data sensitivity, rather than just at the application level. In this scenario, you use authentication context to trigger MFA only when the WAF determines that a sign-in attempt is risky, rather than requiring MFA for all sign-in attempts.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/).

1. In the **Conditional Access** section, select **Authentication contexts**, then select **New authentication context**.

   :::image type="content" source="media/tutorial-third-party-account-take-over-protection-native-api/conditional-access-authentication-contexts.png" alt-text="Screenshot showing the Conditional Access authentication contexts page." lightbox="media/tutorial-third-party-account-take-over-protection-native-api/conditional-access-authentication-contexts.png":::

   :::image type="content" source="media/tutorial-third-party-account-take-over-protection-native-api/add-authentication-context-form.png" alt-text="Screenshot showing the new authentication context creation form." lightbox="media/tutorial-third-party-account-take-over-protection-native-api/add-authentication-context-form.png":::

1. Add a **Name** (required) and a **Description** (optional).

1. Select an **ID** for your auth context. The IDs range from c1 to c99. For this example, select **c3**.

1. Select **Create**.

> [!TIP]
> The authentication context ID is used in the /token endpoint to indicate that the user is using a specific authentication context. Make note of the ID you selected (for example, c3) as you need it when configuring the WAF worker.

## Create a Conditional Access policy using authentication context

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/) as at least a [Conditional Access Administrator](/entra/identity/role-based-access-control/permissions-reference#conditional-access-administrator).

1. Browse to **Entra ID** > **Conditional Access** > **Policies**, then select **+ New policy**.

   :::image type="content" source="media/tutorial-third-party-account-take-over-protection-native-api/conditional-access-policies-page.png" alt-text="Screenshot showing the Conditional Access policies page with the new policy option." lightbox="media/tutorial-third-party-account-take-over-protection-native-api/conditional-access-policies-page.png":::

1. Enter a **Name** for the policy and select the specific **user or user group** (or all users) that the policy affects. The user needs to have email as a strong authentication method if you want to enforce email MFA with native authentication APIs.

   :::image type="content" source="media/tutorial-third-party-account-take-over-protection-native-api/conditional-access-policy-users.png" alt-text="Screenshot showing the policy name and user assignment options." lightbox="media/tutorial-third-party-account-take-over-protection-native-api/conditional-access-policy-users.png":::

   :::image type="content" source="media/tutorial-third-party-account-take-over-protection-native-api/conditional-access-authentication-context.png" alt-text="Screenshot showing the user selection for the Conditional Access policy.":::

1. In **Target resources**, select **Authentication context** in the dropdown, then select the authentication context that you created earlier.

1. For **Grant**, select the action to enforce for the user (for example, require multifactor authentication). Select **Select**, set **Enable policy** to **On**, then select **Create**.

   :::image type="content" source="media/tutorial-third-party-account-take-over-protection-native-api/conditional-access-grant-settings.png" alt-text="Screenshot showing the grant controls and policy enablement settings.":::

At this point, you have a Conditional Access policy configured to require MFA for the selected user when they sign in to any of the tenant apps.

## Configure WAF worker for risk evaluation

This section describes how to configure the WAF to intercept /token requests and perform risk evaluation with your third-party ATO provider.

### Update the WAF layer to intercept specific API requests during sign-in flow

This tutorial uses a Cloudflare WAF. The Cloudflare WAF setup instructions are provided in the [Create a WAF configuration](#create-a-waf-configuration) section of this tutorial.

1. Sign in to the **Cloudflare account** for the external domain (mentioned in the Create a WAF configuration step) associated with the external tenant with at least **Domain Administrator** privilege.

1. Go to **Workers Routes**, then select **Create application**.

   :::image type="content" source="media/tutorial-third-party-account-take-over-protection-native-api/cloudflare-workers-routes-page.png" alt-text="Screenshot showing the Cloudflare Workers Routes page.":::

   :::image type="content" source="media/tutorial-third-party-account-take-over-protection-native-api/cloudflare-workers-create-application.png" alt-text="Screenshot showing the Create application option in Cloudflare.":::

3.  Select **Start with Hello World**.
    :::image type="content" source="media/tutorial-third-party-account-take-over-protection-native-api/ship-something-new-cloudflare.png" alt-text="Screenshot of Cloudflare application creation options showing GitHub, GitLab, Hello World, template, and static file upload buttons." lightbox="media/tutorial-third-party-account-take-over-protection-native-api/ship-something-new-cloudflare.png":::

4.  Name the worker and select **Deploy**.
    :::image type="content" source="media/tutorial-third-party-account-take-over-protection-native-api/deploy-hello-world-worker.png" alt-text="Screenshot of Cloudflare Workers deployment screen showing worker name, code preview, and Deploy button for Hello World setup." lightbox="media/tutorial-third-party-account-take-over-protection-native-api/deploy-hello-world-worker.png":::

5.  Once the worker is deployed, select the Settings tab. Select **+Add** in **Domains & Routes**.

    :::image type="content" source="media/tutorial-third-party-account-take-over-protection-native-api/domains-routes-settings.png" alt-text="Screenshot of the Settings tab with Domains & Routes section and a visible +Add link for adding routes." lightbox="media/tutorial-third-party-account-take-over-protection-native-api/domains-routes-settings.png":::

6.  Select **Route.**
    :::image type="content" source="media/tutorial-third-party-account-take-over-protection-native-api/domains-routes-settings.png" alt-text="Screenshot of Domains & Routes settings with Custom domain and Route options for mapping a Worker endpoint." lightbox="media/tutorial-third-party-account-take-over-protection-native-api/domains-routes-settings.png":::

1. Select the domain from **Zone**. Add the following value in the **Route** field:

   `*<custom_domain>/<external_tenant_id(guid)>/oauth2/v2.0/token*`

   Select **Fail Closed** for failure mode.

   :::image type="content" source="media/tutorial-third-party-account-take-over-protection-native-api/route-configuration-failure-mode.png" alt-text="Screenshot showing the route configuration with zone and failure mode settings." lightbox="media/tutorial-third-party-account-take-over-protection-native-api/route-configuration-failure-mode.png":::

1. Select **Add Route**.

If the WAF setup is configured properly, all requests to the external tenant /token endpoint are intercepted by the worker. Configure the worker logic to determine which requests to challenge by MFA and to do the risk evaluation with the third-party risk provider.

### Configure worker logic for risk evaluation

Configure the worker logic to:

1. Extract relevant information from the authentication request (device fingerprint, IP address, behavioral data).
1. Send this data to your third-party ATO provider's risk assessment API.
1. Evaluate the risk score returned by the provider.
1. If the risk score exceeds your threshold, modify the request to include the authentication context that triggers MFA.
1. Forward the request to the Microsoft Entra /token endpoint.

> [!NOTE]
> Contact Microsoft if you need a code sample for the worker logic.

### Third-party provider integration

This tutorial uses [LexisNexis Risk Solutions](https://risk.lexisnexis.com/) as the third-party ATO provider. The session query API provided by LexisNexis is used for risk evaluation. Refer to the following LexisNexis documentation:

- [Session Query API](https://portal.threatmetrix.com/kb-en/Implementation_Guides/APIs/Session_Query_API.htm)
- [Update API](https://portal.threatmetrix.com/kb-en/Implementation_Guides/APIs/update_api.htm)
- SDK documentation: [Introduction to ThreatMetrix SDK and FAQ](https://portal.threatmetrix.com/kb-en/Implementation_Guides/ThreatMetrix%20SDK/introduction_to_threatmetrix_sdk_and_faq.htm)

## Update the native app sign-in API call flow to support MFA

The standard sign-in flow using native API endpoints is described in the [Native authentication API reference documentation](/entra/identity-platform/reference-native-authentication-api?tabs=emailOtp#api-reference-for-sign-in-flow). This flow doesn't invoke MFA by default. This section describes how to update your native app to support risk-based MFA.

In this tutorial, you invoke risk-based MFA using the auth context configured in the previous steps.

> [!NOTE]
> Currently, risk-based MFA can only be applied for the "Email with Password" flow.

The following flow uses the WAF as the layer to evaluate the risk for the /token calls.

### Logical flow to initiate MFA

1. Invoke /token with the auth context defined for the MFA flow.

1. The /initiate endpoint continues to use a CredentialToken as state object for the first factor authentication flow.

1. The /challenge endpoint continues to use a CredentialToken as state object for the first factor authentication flow.

1. On /token, risk is evaluated in WAF layer. If the WAF layer decides to review the request with a challenge, a new /token call is made with the AuthContext configured for the MFA flow ("c3" in this example).

1. The /introspect endpoint reads methods from CredentialVerificationInputState and returns them to the user.

1. The /challenge endpoint picks the strong auth method used for challenging, by reading the strong auth methods from CredentialVerificationInputState and comparing them against the request's challenge_types. When a method is selected and passed to EC UCV for challenge operation, the ID and type of the selected method are written to CredentialVerificationIntermediateState.

1. The /token endpoint reads the strong auth method ID and type from CredentialVerificationIntermediateState, and passes this to EC UCV verify operation, along with the oob value from the request. When EC UCV returns successfully, the /token handler pops and merges CredentialVerificationIntermediateState onto CredentialToken. By doing so, the FlowToken in StsRequest is updated with MFA details. StsRequest runs through the pipeline to complete the authentication flow.

> [!TIP]
> Your native app must be prepared to handle the MFA flow when triggered. Ensure your app can call the /introspect endpoint, handle the /challenge for email OTP, and submit the OTP value in the final /token call.

## Next steps

Now that you've integrated ATO protection with native authentication, explore these related resources:

- [Native authentication API reference](/entra/identity-platform/reference-native-authentication-api)
- [Tutorial: Prepare your Android mobile app for native authentication](tutorial-native-authentication-prepare-android-app.md)
- [Tutorial: Prepare your iOS/macOS mobile app for native authentication](tutorial-native-authentication-prepare-ios-macos-app.md)
- [Configure Conditional Access policies](/entra/identity/conditional-access/concept-conditional-access-policies)
- [Authentication context in Conditional Access](/entra/identity-platform/developer-guide-conditional-access-authentication-context)
- [Configure custom domains for external tenants](how-to-custom-url-domain.md)
- [Enable Microsoft Entra multifactor authentication](/entra/identity/authentication/tutorial-enable-azure-mfa)
- [Configure Cloudflare WAF with Microsoft Entra External ID](how-to-configure-waf-integration.md)

## Appendix

### POST /{tenant}/oauth2/v2.0/introspect

This endpoint returns the list of registered strong-auth methods of the user. Currently, only email OTP is supported as a strong-auth method. Even if a user has multiple registered strong-auth methods, the endpoint only returns "email". The endpoint is included at this stage to help developers build it into their flow so they're familiar with it when more methods are supported.

Request

| Property            | Required  | Type    | Description                     |
|---------------------|-----------|---------|---------------------------------|
| client_id           | Yes       | string  | The client id.                  |
| continuation_token  | Yes       | string  | The opaque transport artifact.  |



Response

| Property  | Type  | Description  |
|----|----|----|
| continuation_token  | string  | Opaque state transport artifact the caller should save to send in the next request.  |
| methods  | Array\<AuthenticationMethod\>  | The list of registered strong authentication methods  |

Type: AuthenticationMethod

| Property | Type | Description |
|---|---|---|
| id | string | Key of the method. This will be an auto generated id and should be used when calling challenge endpoint. |
| challenge_type | string | The challenge type of the method. Current supported types: oob |
| challenge_channel | string | The channel to which the auth method should be sent. Current supported channels: email |
| login_hint | string | The hint for the authentication method. Currently only email is supported, and this would be the obfuscated user email. |

#### Error responses

The following errors are common between other endpoints within the Native Authentication APIs and also apply to this API.

There are no unique errors specific to this API.

| Scenario | Error \| Status code | Message |
|---|---|---|
| The continuation token is expired. | expired_token \| 400 | The continuation token is expired. |
| The caller did not pass in the correct parameters. | invalid_request \| 400 | The request body must contain the following parameter: '{name}'. |
| The caller passed in an incorrect parameter. | invalid_request \| 400 | {name} parameter is empty or not valid. |
| The caller passed in an incorrect parameter value. | invalid_request \| 400 | Invalid request. The {name} request parameter value '{value}' is invalid. |
| The continuation token is in an invalid state. | invalid_request \| 400 | The continuation_token provided is not valid for this endpoint. |
| Something went wrong with the request. | server_error \| 500 | Non-retryable error has occurred. |
| eSTS throttles the request. | temporarily_unavailable \| 429 | The server has terminated the request due to excessive request rate. Please wait a few seconds and try again. |

Modifications to existing APIs

There will be no changes to initiate endpoint.

Challenge Endpoint

POST /{tenant}/oauth2/v2.0/challenge

- Existing Responsibility:

<!-- -->

- The /challenge endpoint currently has the responsibility of sending the OTP to the user’s email when the user is using email OTP as the first factor authentication. This functionality will remain unchanged.

<!-- -->

- The /challenge endpoint can be used to re-send OTP to user strong-auth method (email), this is existing functionality for first factor and will be re-used as is.

<!-- -->

- Additional Responsibility:

<!-- -->

- The challenge endpoint will now also be responsible for sending the OTP to the user’s email when the user is using email OTP as the second factor authentication method.

Request:

| Property | Required | Type | Description | Changes |
|---|---|---|---|---|
| client_id | Yes | string | The client id. | No changes |
| continuation_token | Yes | string | The opaque transport artifact. | No changes |
| id | Yes | String | The id of the Auth Method returned in the Introspect response | New Parameter. This will present the Id of the auth method returned in the introspect API. |

Response:

No changes in current response implementation.

Error Responses:

The same error response for invalid parameter will be used when id contains invalid values:

| The caller passed in an incorrect parameter.   | invalid_request \| 400  | {name} parameter is empty or not valid.  |
|----|----|----|



#### Token endpoint

`POST /{tenant}/oauth2/token`

**Existing responsibility:**

- The /token endpoint verifies the user's first factor authentication and, if successful, returns an access token.

**Additional responsibility:**

- The /token endpoint is now also responsible for verifying the user's second factor authentication, in this case the email OTP value.

Request:

| Property  | Required  | Type  | Description  | Changes  |
|----|----|----|----|----|
| grant_type  | Yes  | String  | The grant type of the request. Currently can be “oob” or “password”.  | When making a second factor request to /token, grant type “mfa_oob” should be used.  |

Error Responses:

New error response:

| The user needs to perform second factor authentication. | error: invalid_grant \| 400 suberror: mfa_required | Strong Authentication is required. |
|---|---|---|
