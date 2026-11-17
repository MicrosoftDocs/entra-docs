---
title: Migrate Embedded native authentication from V1 to V2
description: Update a V1 integration for response-driven Embedded native authentication, including SDK interfaces, authorization, attributes, errors, and tokens.
ms.topic: how-to
ms.date: 11/13/2026
ms.custom: msecd-doc-authoring-1030
ai-usage: ai-generated
#customer intent: As an application developer, I want to migrate my V1 integration so that my app follows the V2 authentication contract.
---

# Migrate embedded native authentication from V1 to V2

[!INCLUDE [applies-to-external-only](../external-id/includes/applies-to-external-only.md)]

[!INCLUDE [applies-to-authentication-native](../external-id/includes/applies-to-authentication-native.md)]

The Native Authentication API uses service-provided states, actions, and links to drive authentication journeys in Microsoft Entra External ID. This guide helps you migrate an existing V1 integration to that response-driven contract. It covers direct HTTP integration and SDK compatibility. The V1 API reference and linked SDK library references remain available for existing integrations.

[!INCLUDE [native-authentication-public-preview](~/external-id/includes/native-authentication-public-preview.md)]

## Prerequisites

- An existing integration whose behavior you can compare with the [V1 API reference](reference-native-authentication-api-v1.md) and the [SDK library references](reference-native-authentication-api-v1.md#sdk-references) for your installed package.
- A test application and user flow configured according to [Configure an application for native authentication](how-to-native-authentication-configure-app.md).
- Test users for each authentication method and policy your app uses, including password reset and additional authentication where configured.
- The [V2 API contract](reference-native-authentication.md) and a way to inspect request methods, response states, and diagnostic IDs without recording credentials or tokens.

## Identify the integration boundary

Separate native HTTP calls from browser-delegated authentication before changing your app:

1. Inventory calls to `/signup/v1.0/...`, `/resetpassword/v1.0/...`, `/oauth2/v2.0/initiate`, `/oauth2/v2.0/challenge`, `/oauth2/v2.0/introspect`, and V1 registration operations. Also inventory token requests using V1 grant types.
1. If the app uses an SDK, identify its package version and native interfaces. Verify support for each required V2 scenario in that library's documentation. Use the direct API where a V2 wrapper contract is unavailable.
1. Record the user flow, required attributes, API scopes, multifactor authentication (MFA) policies, registration requirements, browser fallback, and custom-header integrations that the app depends on.
1. Compare those dependencies with the shared [method and journey matrix](../external-id/customers/concept-supported-features-customers.md#methods-and-journeys-by-approach). Choose the supported integration for each required capability before migrating it.

The `/oauth2/v2.0` segment identifies the OAuth endpoint used by both V1 and V2. Native V2 routes use `/api/v2.0`. Preserve returned paths, query strings, and opaque method identifiers rather than constructing the next operation.

## Configure the service authority

Use a tenant-verified custom domain for every current API call, including OAuth authorization start, native operations, authorization continuation, and token redemption.

1. Set the service authority to `https://<tenant-verified-custom-domain>/<tenant-GUID>`.
1. Configure that authority through the selected SDK's existing properties:

    - **Android:** Set `authorities[0].type` to `CIAM` and `authorities[0].authority_url` to the full service authority.
    - **iOS and macOS:** Create `MSALCIAMAuthority` with the full URL and pass it to `MSALNativeAuthPublicClientApplicationConfig(clientId:authority:challengeTypes:)`. Don't use the `tenantSubdomain` convenience initializer, which constructs the default login host.
    - **JavaScript:** Set `auth.authority` to the full service authority and `auth.knownAuthorities` to an array containing only the verified hostname.

1. For SDK browser calls, set the required `customAuth.authApiProxyUrl` string to the same full custom-domain authority and configure CORS at that edge. This route doesn't use an application proxy's local transport prefix. Apply the [shared proxy contract](concept-native-authentication-cors.md#proxy-contract) for origins, preflight, SDK headers, and success and error responses.
1. For direct HTTP integration, resolve relative returned links against the service authority. Before sending credentials or continuation tokens, reject an unexpected hostname or tenant path. If your browser integration uses proxy transport mapping, apply it only after validating the service destination.

CORS and proxy configuration apply to cross-origin browser calls from SPAs with Embedded native authentication and BYO UX websites. Android and iOS apps using native HTTP transports call the service authority directly and don't need a CORS proxy.

## SDK compatibility

Use the following Microsoft Authentication Library (MSAL) versions or later for V1-to-V2 migration. See the linked SDK documentation for platform prerequisites and setup instructions.

| Platform | SDK and minimum version | V2 interface |
| --- | --- | --- |
| **Android** | [MSAL for Android](https://github.com/AzureAD/microsoft-authentication-library-for-android) (`com.microsoft.identity.client:msal`) 8.7.0 or later. | `INativeAuthPublicClientApplication.signInV2`, `signUpV2`, and `resetPasswordV2`; unified `NativeAuthResultV2` results. |
| **iOS and macOS** | [MSAL for iOS and macOS](https://github.com/AzureAD/microsoft-authentication-library-for-objc) 2.18.1 or later. | `MSALNativeAuthPublicClientApplication` V2 entry points; scenario-specific parameter types, shared `MSALNativeAuthFlowDelegate`, and typed per-state delegates. |
| **JavaScript and TypeScript** | [MSAL for JavaScript](https://github.com/AzureAD/microsoft-authentication-library-for-js) (`@azure/msal-browser`) 5.29.0 or later. | `ICustomAuthPublicClientApplicationV2` with `signInV2`, `signUpV2`, and `resetPasswordV2`; use the matching V2 input, result, and state types. |

Display only methods returned for the transaction. Use the shared [method and journey matrix](../external-id/customers/concept-supported-features-customers.md#methods-and-journeys-by-approach) for service capabilities, then check the selected SDK implementation:

- **Android:** Email and SMS strong-auth registration, activation-code submission, and resend are implemented. Other enrollment channels aren't implemented.
- **Apple:** Registration, verification, and MFA resend have implementations. Use the returned states to identify the methods available for the current transaction.
- **JavaScript:** The V2 interfaces are experimental and aren't intended for production applications. The package implements method selection, MFA, registration, activation, and resend. Use each returned state to determine the next step.

### Android migration

Keep the existing client factory, but replace V1 parameter objects with `NativeAuthSignInParametersV2`, `NativeAuthSignUpParametersV2`, and `NativeAuthResetPasswordParametersV2`. Pass them to `signInV2`, `signUpV2`, and `resetPasswordV2`. Select V2 through these entry points, not a configuration flag.

The [Android sample](https://github.com/Azure-Samples/ms-identity-ciam-native-auth-android-sample/tree/adacfe21414333128300c722c9031d4663938d7c) demonstrates V1 and V2 journeys.

- Dispatch `NativeAuthResultV2` after every entry point and continuation. Retain the returned `nextState`.
- Classify rejected attributes with `NativeAuthErrorV2.isInvalidAttributes()` and retry `AttributesRequiredStateV2.submitAttributes(...)` on the retained state. Attribute-validation errors don't expose a new state.
- Handle `NativeAuthResultV2.StrongAuthRegistrationRequired` with `nextState.selectAuthMethod(method, verificationContact)`. Handle `StrongAuthVerificationRequired` with `nextState.submitChallenge(code)` or `nextState.resendChallenge()`.
- Handle `SignInAfterSignUpRequired` and `SignInAfterResetPasswordRequired` separately from `Complete`. Call `nextState.signIn()` when sign-in is wanted; only `Complete` represents token acquisition.
- For callback integrations, use `NativeAuthPublicClientApplication.NativeAuthV2Callback` and the V2 state's operation-specific callback. An SDK error can arrive through `onResult`; `onError` isn't the only error path.
- Keep V1 `challenge_types` and `capabilities` when V1 calls still use the client. V2 doesn't send these settings and doesn't use them to select methods or enable enrollment.

<a id="ios-migration"></a>

### iOS and macOS migration

Use `MSALNativeAuthSignInParametersV2`, `MSALNativeAuthSignUpParametersV2`, and `MSALNativeAuthResetPasswordParametersV2` with their respective V2 entry points.

The [Apple sample](https://github.com/Azure-Samples/ms-identity-ciam-native-auth-ios-sample/tree/85ef82afd59572ade876011bad516fd631761dd4) demonstrates V1 and V2 journeys. Follow the sample's setup instructions for its platform requirements.

- Implement `MSALNativeAuthFlowDelegate` and each required per-state protocol. The callback handler needs to conform to the corresponding state protocol.
- Handle `onFlowCompleted(result:scenario:)` and `onFlowError(error:scenario:)`. Missing state-protocol implementation produces `isNotImplemented`.
- Retain separate scenario handlers and prevent concurrent requests. Callbacks run on the main actor; `scenario` isn't a transaction ID.
- Update continuation types and argument labels. For example, V2 code submission uses `submitCode(_:delegate:)`.
- Use `MSALNativeAuthMFAVerificationRequiredState.resendChallenge(delegate:)` for MFA resend. Registration uses `MSALNativeAuthStrongAuthRegistrationRequiredState.selectAuthMethod(_:verificationContact:delegate:)`; its verification state exposes `submitChallenge(_:delegate:)` and `resendChallenge(delegate:)`.
- Keep challenge types and capabilities needed by coexisting V1 calls. V2 ignores those settings.

### JavaScript migration

The factory remains `CustomAuthPublicClientApplication.create(customAuthConfig)` and returns `ICustomAuthPublicClientApplicationV2`. The [unified JavaScript sample](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/tree/49c4e250a1e6eb97e2b813e9fce6670c996a2808/typescript/native-auth/react-nextjs-sample) demonstrates the matching V2 interfaces.

- Replace V1 entry points with `signInV2`, `signUpV2`, and `resetPasswordV2`, passing the intended scopes and claims.
- Check `result.isFailed()` before inspecting state. Then use `result.isState("stateName")` and retain `result.state`.
- Use matching result and state types, such as `SignInStartResultV2`, `PasswordRequiredStateV2`, and `CodeRequiredStateV2`. Don't cast V1 states to V2.
- Submit a password through `PasswordRequiredStateV2.submitPassword(password)`. Use `CodeRequiredStateV2.submitCode(code)` and `resendCode()` for primary verification codes.
- Use `AuthMethodSelectionRequiredStateV2.selectAuthMethod(method)` for method selection and process the returned state. For MFA, use `MFAVerificationRequiredStateV2.submitChallenge(code)` and `resendChallenge()`.
- Register a returned method through `AuthMethodRegistrationRequiredStateV2.selectAuthMethod(method, verificationContact)`. Activate it through `AuthMethodVerificationRequiredStateV2.submitChallenge(code)`, or request another activation code with `resendChallenge()`.
- When sign-up or password reset returns `signInContinuation`, call `result.state.signIn()` without arguments. The SDK retains the original authorization context; don't pass replacement scopes or claims to the continuation.

Follow the [React quickstart](quickstart-native-authentication.md#get-the-sample) to set up the sample, configure the custom-domain edge, and select V2. The sample uses the SDK's default scopes without custom claims; supply any required scopes and claims when starting your own journey.

The SDK leaves absolute HAL links unchanged. Links for the configured custom-domain authority reach the same edge without local remapping. Preserve opaque links and follow the [service authority and proxy transport guidance](concept-native-authentication-cors.md#service-authority-and-proxy-transport), rather than repairing links to another authority.

<a id="roll-out-test-journeys"></a>

### Plan the migration rollout

Choose V1 or V2 in your application when a new journey starts. Keep that choice for all continuation operations and post-sign-up or post-reset sign-in.

1. Keep the existing path available while validating the replacement journeys.
1. Compare safe error categories, completion, and user experience before switching new journeys.
1. To roll back, route new journeys to V1. Finish or explicitly abandon active V2 journeys; don't replay their credentials or operations through V1.

MSAL doesn't automatically switch a failed V2 journey to V1. Keep the existing session and token cache when changing the version used to start new journeys.

## Replace the request and response model

Update your transport layer and orchestration together to implement the V2 request and response model.

1. Add the authorization-challenge operation and V2 native JSON requests.
1. Separate OAuth form encoding from native JSON encoding. Use the latest continuation token with the correct property spelling for the endpoint.
1. Replace constructed next-operation URLs with the links in the latest response. Resolve relative links against the custom-domain service authority, validate the hostname and tenant path, and reject an unexpected destination before sending secrets.
1. Replace V1 challenge-type and capability branching with dispatch on the latest `state` and `action`. Select an available operation through application flow logic or user choice. Handle unknown optional fields and links without interrupting supported operations.

| Integration point | V1 | V2 |
| --- | --- | --- |
| **Authorization start** | Start a journey directly, for example `/signup/v1.0/start` or `/oauth2/v2.0/initiate`. | `POST /{tenant}/oauth2/v2.0/authorize-challenge` with form-encoded inputs. Use the [shared reference](reference-native-authentication.md) for the parameters supported by this request. |
| **Interaction required** | Journey-specific continuation and challenge responses. | Initial HTTP `401` with `InsufficientAuthorization`, `continuation_token`, and enabled `sign_in`, `sign_up`, or `reset_password` links is an interaction response, not necessarily a terminal failure. |
| **Native request encoding** | Form-encoded journey requests. | JSON for `/api/v2.0/...`; request the HAL representation with `Accept: application/hal+json`. OAuth endpoints remain form-encoded. |
| **Continuation field** | `continuation_token`. | `continuationToken` in native JSON; `continuation_token` at the OAuth authorization-challenge boundary. |
| **Next operation** | Endpoint-specific sequences using `challenge_type`, grant types, and suberrors. | `state`, `action`, `_links`, and returned metadata determine the next operation. |
| **Method selection** | V1 challenge declarations and introspection/registration operations. | `_embedded.methods` supplies opaque method IDs, types, hints, and allowed links. |
| **Credential submission** | Password or one-time passcode (OTP) values can be submitted to the V1 token endpoint; the OTP parameter is `oob`. | Submit `password` or `otp` to the advertised method's `verify` link; don't send credentials in the authorization-code exchange. |
| **Finish authentication** | V1 token grant depends on the flow, including `password`, `oob`, `mfa_oob`, or `continuation_token`. | Follow `continue` to resume authorization, obtain a code, then use `grant_type=authorization_code` at the token endpoint. |
| **Native errors** | Flat OAuth-style `error`, `suberror`, and diagnostic fields. | Native errors have an `error` object with `code`, `message`, diagnostic fields, and optional `innerError`; OAuth endpoint errors retain their OAuth shape. |

For browser applications, review edge routes and permitted HTTP methods as well as encoding. V2 password update uses `PUT`; other V2 operations include `POST`. See [Native authentication CORS concepts](concept-native-authentication-cors.md) for the shared requirements. The [local proxy guidance](how-to-native-authentication-cors-local.md) covers custom HTTP clients, not the SDK quickstart's edge route.

## Migrate each journey

Use a response-processing loop across journeys. Your app can expose available actions or use application flow logic to select an allowed operation; the returned requirements determine what needs to be completed.

1. Start authorization and follow an enabled journey link.
1. If a native response returns `state: redirect`, stop native processing. That response can omit `continuationToken`, `action`, and `_links`; it doesn't provide a browser handoff URL.
1. For `state: interactionRequired`, handle the returned action, collecting user input where needed. Use the available methods and attribute requirements when selecting operations and organizing the interface.
1. After each operation, replace the previous token and response with the latest values. Keep the token and allowed links together for the same transaction.
1. For `state: continue`, follow the authorization continuation rather than requesting tokens with a V1 grant. Handle other documented states according to their returned links.

### Sign-in

Follow the returned `sign_in` link and submit `username` with `continuationToken`. Method discovery replaces a hard-coded choice of the V1 challenge endpoint.

- Select an advertised method and follow its `challenge` link.
- Submit the credential to its `verify` link. An OTP request uses `otp`, not V1's `oob`; password verification uses `password`.
- Use the returned `codeLength` and masked `hint` for OTP UI instead of hard-coding a code length or displaying an unmasked identifier.
- Process additional challenge/verification actions when policy requires another factor. A successful first-factor verification isn't proof that token issuance is next.

See the [sign-in reference](reference-native-authentication-sign-in.md) for request and response details.

### Sign-up and attributes

Follow the returned `sign_up` link with `continuationToken`. The user flow selects the sign-up method; don't send a V1 `challenge_type` list to choose it.

| V1 implementation | Migration change |
| --- | --- |
| Attributes are a JSON-formatted string in a form body. | Submit `attributes` as a JSON object with string values through the advertised `submitAttributes` link. |
| Attribute names are selected from configured programmable names. | Use the exact `attributeId` values and the requirements and input metadata returned by the service, including `required`, `hidden`, and `canChange` when present. |
| A password is submitted as a V1 request parameter. | For email-with-password sign-up, submit `password` as an attribute when requested. Email-OTP sign-up doesn't collect a password. |
| The app assumes a single attribute form followed by verification. | Handle repeated `collectAttributes` and `verify` actions. Submit only attributes requested by the current response, then use the next response to determine the next action. |
| The app explicitly starts every email challenge. | When attribute submission returns `action: verify`, the OTP has already been sent. Use the advertised `resend` link only when another code is needed. |

Supply all required attributes before completion. Apply V2's descriptor and collection rules to optional values. See [User attributes](concept-native-authentication-user-attributes.md) and the [sign-up reference](reference-native-authentication-sign-up.md).

### Password reset

Follow the returned `reset_password` link, then use the advertised method operations:

1. Submit `username` and `continuationToken` to start recovery.
1. Challenge an advertised verification method and submit the OTP to its `verify` link.
1. When the response requires password update, follow its `update` link with `PUT`, submitting `newPassword` and the latest `continuationToken`.
1. Follow `poll` with `POST` while the service requests polling. Wait for the current response's `pollInterval` before each request, as described in the password-reset reference.
1. On `state: continue`, resume authorization. Don't interpret the first update response as a completed reset or submit a V1 `continuation_token` token grant.

The V2 flow replaces V1's `/resetpassword/v1.0/submit` and `/poll_completion` plus `status` handling. Use the [password-reset reference](reference-native-authentication-password-reset.md) for the V2 contract.

Recovery can also start within sign-in by following a password method's `recover` link with only the current continuation token. Don't resubmit the username or password or start another authorization transaction. Recovery supports email and SMS one-time passcodes.

### MFA and registration

V1 uses `mfa_required` and `registration_required` capability declarations and token suberrors. V2 uses returned methods and actions for additional authentication.

The direct API supports inline email and SMS registration. The [enrollment contract](reference-native-authentication.md#authentication-method-enrollment) defines `enroll` and `activate`. Phone registration uses `type: phone` with an advertised `sms` channel; an existing SMS verification method uses `type: sms`. Follow the operations advertised for the transaction, and apply the platform-specific SDK limits in [SDK compatibility](#sdk-compatibility).

## Replace token acquisition and failure handling

Complete authorization only after the service indicates that the native journey can continue:

1. Follow `_links.continue` and submit the latest token as form-encoded `continuation_token`. Don't resend initial authorization parameters on this continuation.
1. Read the returned authorization `code`.
1. Exchange it at `/oauth2/v2.0/token` with `client_id`, `grant_type=authorization_code`, and `code`, following the request contract in the shared reference. The code is short-lived and single-use.
1. Use the resulting access token only for its intended resource. Token fields depend on the initial scopes; a refresh token requires `offline_access` on the initial authorization request.
1. Update error handling to distinguish initial `InsufficientAuthorization`, recoverable input errors, invalid/expired transactions, throttling, and browser-required errors. Use stable error codes rather than localized messages.

Handle both native `state: redirect` and the separate OAuth `invalid_grant` / `web_redirect_required` signal. Also handle a required response the app can't interpret. Unknown optional fields alone aren't a reason to fall back. See [Web fallback](concept-native-authentication-web-fallback.md).

Offer a separately configured browser sign-in when your application has a supported integration, or show a clear failure. A new browser sign-in restarts authentication; it doesn't continue native progress.

## Verify the migrated integration

Verify each supported journey against your test tenant before replacing the existing implementation:

1. Prepare the test configuration and implement the V2 operations from the API references, or use the [SDK quickstart](quickstart-native-authentication.md) for the React Next.js sample.
1. Run the cases below for every method and policy the app supports.
1. Check that no migrated journey still submits V1 grant types or calls V1-only journey endpoints.
1. Review redacted diagnostics and the user-visible outcome. Don't record passwords, OTPs, continuation tokens, authorization codes, or security tokens in test output.

| Case | Expected client behavior |
| --- | --- |
| **Initial interaction response** | HTTP `401 InsufficientAuthorization` opens an enabled journey instead of displaying an unconditional authentication failure. |
| **Invalid OTP or password** | No signed-in state or token-dependent operation is shown before verification succeeds. |
| **Resend** | Direct calls follow the latest `resend` link; SDK calls use the selected package's implemented continuation. Both use the newest transaction state. |
| **Required and optional attributes** | Required values are collected; repeated attribute actions and changed verification order don't break the flow. |
| **MFA required** | The app follows the returned method list and completes required factors instead of stopping after first-factor success. |
| **Asynchronous password update** | The app polls only as required and resumes authorization only after the service permits continuation. |
| **Expired or wrong-stage token** | The app reports the failure and restarts the applicable flow, rather than replaying an older continuation token. |
| **Unknown optional metadata** | The app continues with known required fields and links. |
| **Native redirect or browser-required error** | The app stops native processing even when the response has no continuation token or links, then offers only a separately configured browser integration. |
| **Unusable required response** | The app shows a clear failure or offers a supported browser sign-in without promising preservation of native progress. |
| **Throttling or ambiguous network failure** | The app respects retry guidance and doesn't automatically replay credential verification or password updates. |
| **Custom-domain routing** | OAuth start, native operations, authorization continuation, and token redemption use the verified custom domain and tenant GUID. A local proxy prefix remains transport configuration only. |
| **Unexpected link authority** | No credential or continuation token is sent to a different hostname or tenant path. |
| **API access and sign-out** | The intended resource accepts the correctly scoped access token; app-managed credentials and account UI are cleared on sign-out. Native logout doesn't terminate other application or browser sessions. |

## Related content

- [The Native Authentication API reference](reference-native-authentication.md).
- [Native Authentication API V1 reference](reference-native-authentication-api-v1.md).
- [SDK library references for existing V1 integrations](reference-native-authentication-api-v1.md#sdk-references).
