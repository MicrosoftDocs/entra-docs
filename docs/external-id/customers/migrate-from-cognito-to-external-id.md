---
title: Migrate from Amazon Cognito to Microsoft Entra External ID
description: Learn to migrate from Amazon Cognito to Microsoft Entra External ID with step-by-step guidance, feature mapping, and validation strategies.
author: raffaeu
ms.author: rgarofalo
ms.reviewer: rhackenberg
ms.date: 06/29/2026
ms.service: entra-external-id
ms.collection: 
  - migration
  - aws-to-azure
ms.topic: how-to
---

# Migrate from Amazon Cognito to Microsoft Entra External ID

If you're currently using Amazon Cognito with social sign-in and plan to migrate your workload to Azure, this guide can help you understand feature mappings, the migration process, and best practices.

This guide is for developers and architects who are migrating a consumer-facing application from Amazon Cognito to Microsoft Entra External ID. It covers the end-to-end migration of social sign-in, token issuance, group-based authorization, custom claims, and Lambda trigger equivalents.

## What you will accomplish

You'll learn how to:

- Migrate your Cognito user base into an External ID tenant, including users linked to social identity providers.
- Keep your existing social identity providers, such as Facebook or Google, and configure them as identity providers in External ID.
- Move the application from AWS Amplify Auth (or the Cognito SDK) to Microsoft Authentication Library (MSAL).
- Replace Cognito-issued access tokens with External ID-issued tokens in your API calls. External ID uses the OAuth 2.0 authorization code flow with Proof Key for Code Exchange (PKCE).
- Preserve your authorization logic by mapping Cognito claims to External ID equivalents, including the distinction between directory storage attributes and emitted token claims.
- Validate that users can sign in with their social accounts and that the API still works on behalf of the user.

The guide takes a five-phase approach:

> [!div class="checklist"]
> * [Plan](#step-1-plan)
> * [Prepare](#step-2-prepare)
> * [Execute](#step-3-execute)
> * [Evaluate](#step-4-evaluate)
> * [Decommission](#step-5-decommission)

## Example scenario: consumer app with social sign-in and API access

The following scenario is the basis for the migration steps in this guide. If your scenario is different, the high-level approach is the same, but some details might differ.

You have a consumer-facing web application (for example, a content platform or a marketplace). The front end uses Amplify Auth to redirect users to the Cognito-hosted UI for sign-in. Users sign in with Google or Facebook. Cognito creates a user in the user pool on first sign-in. Before tokens are issued, a Lambda trigger runs to add a custom claim that's based on the user's profile or a lookup in another system. Cognito then issues the access token and ID token, and the front end stores them. When the web app calls the back-end API, it sends the Cognito access token in the request. The API validates the token and checks the `cognito:groups` claim to determine what the user can do. The target state for this scenario uses External ID-managed sign-in with the same upstream social identity providers.

> [!NOTE]
> This guide covers a single Cognito user pool with social sign-in (Google, Facebook) and one consumer-facing web application with a back-end API. Multi-pool architectures, identity pools (federated identities for AWS resource access), Cognito-hosted UI customizations beyond branding, and server-to-server (machine-to-machine) flows are out of scope.

The goal is to move the app's entire identity stack to External ID without requiring users to create new accounts or reset their social sign-in.

### Architectural overview

The following diagram compares the authentication flow before and after migration. The key changes: Amplify Auth becomes MSAL, Cognito becomes External ID managed sign-in, and the API switches from validating `cognito:groups` to reading `roles` (or `groups` for group-based authorization).

:::image type="complex" source="./media/migrate-from-cognito-to-external-id/cognito-entra-architecture-comparison.png" alt-text="Before and after architecture, showing the Cognito flow on the left and the External ID flow on the right." lightbox="./media/migrate-from-cognito-to-external-id/cognito-entra-architecture-comparison.png" border="false":::
The diagram compares authentication architecture before and after migration from AWS to Azure. Before migration, a client app uses Amazon Cognito to authenticate users, federate with external identity providers, and call a back-end API with a Cognito access token. After migration, the same flow uses Microsoft Entra External ID instead of Amazon Cognito, but it keeps the client app, back-end API, and federation with Facebook or Google.
:::image-end:::

### Prerequisites

- An active External ID tenant.
- Access to the source Cognito environment via the AWS Console, AWS CLI, or an AWS SDK. The IAM user or role needs the `AmazonCognitoReadOnly` managed policy (or equivalent read permissions on the user pool, clients, identity providers, users, and groups).
- OAuth client credentials (client ID and secret) for each social identity provider that you plan to migrate (Facebook and Google).
- A development or test environment where you can validate the migration before production. Use a separate External ID tenant for testing rather than running test traffic through your production tenant. This approach avoids polluting your production directory with test users and lets you delete and re-create the test tenant without risk.
- An account with the **Application Administrator** and **User Administrator** roles assigned in the External ID tenant.
- An Azure subscription.
- Microsoft Graph API permissions for bulk user provisioning. The migration application needs at least `User.ReadWrite.All` application permission with admin consent.

## Step 1: Plan

In this step, you build the source-of-truth inventory for the migration. The assessment should capture the current Cognito configuration, the application dependencies on Cognito tokens and claims, and the operational systems that must continue to work after Cognito is removed.

### Assess your Amazon Cognito environment

Before you start the migration, review and document everything you currently have configured in Cognito. You also need to understand how your application and back-end API currently use Cognito. You need a complete inventory to plan the migration.

Review the Cognito user pool, your application code, and your API authorization logic, and record the following information:

- **User pool settings:** User pool ID, region, sign-in aliases (email, phone, username), required attributes, password policy, multifactor authentication (MFA) configuration.
- **App clients:** Client IDs, client secrets (if any), allowed OAuth flows, callback URLs, sign-out URLs, allowed OAuth scopes, identity providers assigned to the client.
- **Identity providers:** Which social or enterprise providers are configured, the OAuth client ID and secret used for each, and the attribute mapping.
- **Custom attributes:** The list of `custom:*` attributes defined in the user pool and which apps consume them.
- **Groups:** All Cognito groups, their precedence values, and any IAM role associated with them.
- **Lambda triggers:** Which triggers are configured (Pre Sign-up, Pre Authentication, Post Confirmation, Pre Token Generation, Custom Message, Post Authentication, User Migration, Define/Create/Verify Auth Challenge) and what each one does. Custom Email Sender and Custom SMS Sender triggers. (Both require AWS Key Management Service (KMS) for encryption.) If you use these triggers to send messages through a third-party provider (for example, SendGrid, Twilio), note the provider, the KMS key, and the message templates.
- **Hosted UI settings:** Branding customizations, CSS overrides, logo.
- **User count and growth rate:** How many users are active, monthly active users, peak sign-in rates.
- **Downstream event consumers:** CloudWatch alarms on Cognito events, EventBridge rules triggered by Cognito, third-party analytics receiving webhook data, and any Simple Notification Service (SNS)/Simple Queue Service (SQS) notifications tied to the user pool. These all break silently when Cognito is decommissioned.

Use the AWS CLI to extract most of this information. For example:

```bash
aws cognito-idp describe-user-pool --user-pool-id <pool-id>
aws cognito-idp list-user-pool-clients --user-pool-id <pool-id>
aws cognito-idp list-identity-providers --user-pool-id <pool-id>
aws cognito-idp list-groups --user-pool-id <pool-id>
aws cognito-idp list-users --user-pool-id <pool-id>
```

These commands return JSON that describes your pool configuration, registered apps, federated providers, group definitions, and user records. Use this output as the source inventory for planning your External ID tenant.

### Understand what Cognito owns beyond social sign-in

Even if every user signs in through Facebook or Google, Cognito still handles a lot of work:

- Cognito acts as the authorization server. It issues the tokens that your app and API consume.
- Cognito stores the user's profile, custom attributes, and group memberships.
- Cognito runs Lambda triggers, including any logic that you use to enrich tokens.
- Cognito controls token lifetime, claim contents, and the shape of the `cognito:groups` claim.
- Cognito signs the tokens. Your API trusts the Cognito JWKS endpoint.

Moving to External ID involves moving all the functionality that Cognito currently provides for your users, not just swapping out the social identity providers. Plan the migration so that it covers the sign-in, users, groups, custom claims, and Lambda logic.

### Direct capability mapping

This table maps core Cognito concepts to their equivalents in Microsoft Entra ID.

| Cognito         |  External ID                             |
| ------------------| -------------------------------------------------------------------------------- |
| User pool                          | [External tenant](concept-planning-your-solution.md)                                                          |
| App Client                                                 | [App registration](/entra/identity-platform/quickstart-register-app)                                          |
| Identity providers (Facebook or Google)            | [Social identity providers in External ID](how-to-google-federation-customers.md)                             |
| SAML/OIDC federation                                       | [SAML](/entra/external-id/direct-federation-overview) or [custom OIDC identity provider](how-to-custom-oidc-federation-customers.md) |
| Cognito groups                                             | [App roles](/entra/identity-platform/howto-add-app-roles-in-apps) (for non-employee logins)                  |
| Custom attributes (`custom:*`)                             | [Directory extension attributes](/graph/extensibility-overview)                                               |
| Hosted UI                                                  | [Managed sign-in with company branding](how-to-customize-branding-customers.md); use a custom app-hosted UI if you need full custom CSS or pixel-level parity |
| Lambda triggers                                            | [Custom authentication extensions](concept-custom-extensions.md)                                              |
| Authorization code grant with PKCE                         | [OAuth 2.0 authorization code flow with PKCE](/entra/identity-platform/v2-oauth2-auth-code-flow)            |
| Cognito access token                                       | [External ID access token](/entra/identity-platform/access-tokens)                                                 |
| `cognito:groups` claim                                     | [`roles`](/entra/identity-platform/howto-add-app-roles-in-apps) for app-defined authorization, or [`groups`](/entra/identity-platform/optional-claims) when direct group-based authorization is required |
| `sub` (Cognito user ID)                                    | [`oid` (Microsoft Entra object ID)](/entra/identity-platform/id-token-claims-reference)                                |
| Resource servers and scopes                                | [Expose an API and API permissions](/entra/identity-platform/quickstart-configure-app-expose-web-apis)         |
| Device tracking / remember device                          | [Conditional Access-compliant device policies](/entra/identity/conditional-access/concept-conditional-access-grant) or ["remember MFA" session lifetime setting](/entra/identity/authentication/concepts-azure-multi-factor-authentication-prompts-session-lifetime) (requires Microsoft Entra ID P1) |

### Capability mismatches and alternative strategies

Some Cognito features have no direct equivalent in External ID. The following sections explain what each feature does, why it doesn't map one-to-one, and what to use instead.

#### Identity pools

Cognito identity pools don't have a direct Azure equivalent. Identity pools are used to exchange a federated token for short-lived AWS Security Token Service (STS) credentials that are bound to an IAM role. You need to make design decisions for the following mappings:

- **Service-to-service access:** Use [managed identities](/entra/identity/managed-identities-azure-resources/overview) instead of temporary credentials.
- **User-scoped resource access:** Use Azure role-based access control (RBAC) assignments or shared access signature tokens scoped to the user's identity.
- **Direct resource access from client apps:** For direct client-to-resource access, acquire an access token for the target resource directly from the client. Use the [On-Behalf-Of (OBO) flow](/entra/identity-platform/v2-oauth2-on-behalf-of-flow) only in a middle-tier confidential API that exchanges the user's access token to call a downstream API.
- If your application uses identity pools, plan this replacement as a separate workstream. It requires architecture changes beyond the Cognito-to-External ID user pool migration that's covered in this guide.

#### Social identity providers

In Cognito, you register the social identity provider (IdP) once at the user pool level and enable it per app client. In External ID, you register the provider once at the tenant level and add it to each user flow that should accept it. You can reuse the existing Facebook or Google OAuth client credentials, but you need to add the new External ID redirect URI to the allowed list in the Google and Facebook developer consoles.

#### Hosted UI vs managed sign-in

In Cognito, the hosted UI can include branding such as logo, colors, and CSS customizations at the user pool level, but callback URLs, OAuth flows, scopes, and enabled identity providers are configured per app client. In External ID, this scenario uses managed sign-in to keep the migration pattern similar: the app redirects users to a Microsoft-hosted sign-in experience, and you configure sign-in options such as Google and Facebook on the app registration. Managed sign-in supports company branding, but it isn't a one-to-one migration target for every Cognito-hosted UI CSS customization. If your current hosted UI depends on custom CSS or pixel-level control, you have two options:

- Adapt the experience to managed sign-in branding capabilities.
- Host the sign-in entry experience in your own application and use MSAL to start the External ID authorization flow.

#### Groups and authorization

Cognito groups look like External ID groups, but for app-level authorization, in External ID they usually map more cleanly to [app roles](/entra/identity-platform/howto-add-app-roles-in-apps). App roles keep the authorization model inside the app registration, are emitted in the `roles` claim, avoid tenant-wide group bloat, and don't hit the groups overage limit (covered in Step 3). If the app has a small and stable set of permissions (admin, editor, viewer), use app roles as the primary authorization model. You can still assign security groups to app roles in the enterprise application to simplify administration. Use direct group-based authorization only when the app must reason over group membership. By default, External ID `groups` claims contain group object IDs, not portable business labels such as `admin` or `viewer`. For more information, see [Access token claims](/entra/identity-platform/access-token-claims-reference), [Optional claims](/entra/identity-platform/optional-claims), and [Group claims configuration](/entra/identity/hybrid/connect/how-to-connect-fed-group-claims).

#### Custom attributes

Each `custom:*` attribute in Cognito maps to an External ID customer user attribute, which is stored as a directory extension attribute on the user object. In Microsoft Graph, these attributes use the storage naming pattern `extension_<appid>_<name>`. The token claim name can be different. For example, a custom authentication extension might read `extension_<appid>_tier` from the directory and emit a business-friendly token claim named `tier`. Configure the extension attribute on the app registration and include it in issued tokens by using either a user flow or a custom authentication extension. A custom authentication extension allows you to extend authentication flows with your own business logic at specific points within the authentication flow. When activated, it makes an HTTP call to a REST API endpoint where you define a workflow action. Don't assume the TokenIssuanceStart request payload contains all roles, groups, or custom attributes needed for enrichment. If claim enrichment depends on those values, design either a deterministic mapping that doesn't need external lookup, or a Microsoft Graph lookup that uses managed identity or confidential client credentials with least-privilege application permissions. For details, see [External ID user attributes](/entra/external-id/customers/concept-user-attributes), [Define custom attributes](/entra/external-id/customers/how-to-define-custom-attributes), and [Add custom user attributes to tokens](/entra/external-id/customers/how-to-add-attributes-to-token).

#### Token lifetime

Cognito lets you set access token, ID token, and refresh token lifetimes per app client. External ID supports configurable lifetimes for access and ID tokens through lifetime policies. Refresh token lifetimes are [not configurable in External ID](/entra/identity-platform/configurable-token-lifetimes). If your Cognito app clients have a short refresh token lifetime as a deliberate security control, use [Conditional Access sign-in frequency](/entra/identity/conditional-access/howto-conditional-access-session-lifetime) instead. For access and ID tokens, match your Cognito per-app-client values where possible to minimize behavioral change at cutover.

#### Event mapping: Lambda triggers to custom authentication extensions

Cognito Lambda triggers become External ID custom authentication extensions, which call an Azure function (or any HTTPS endpoint) during the authentication flow. Not every trigger has a one-to-one equivalent. The mappings in this section describe supported product patterns.

| Cognito Lambda trigger                  | External ID equivalent                             | Notes                                                                                                               |
| ----------------------------------------- | ---------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------- |
| Pre sign-up                             | [Attribute collection start](/entra/identity-platform/custom-extension-overview#attribute-collection-start) and [attribute collection submit](/entra/identity-platform/custom-extension-overview#attribute-collection-submit)  | Validate input, block sign-ups, auto-confirm.                                                                       |
| Pre authentication                      | Custom authentication extension on password submit       | Used for just-in-time (JIT) password migration: validates the password against Cognito's API on first sign-in and writes it to External ID if successful. Only relevant if you have local accounts (email and password) and choose JIT migration instead of forced password reset. |
| Post confirmation                       | No direct event trigger                                  | Use Microsoft Graph change notifications or a logic app that reacts to user creation.                               |
| Pre token generation                    | [Token issuance start](/entra/identity-platform/custom-claims-provider-overview#token-issuance-start-event-listener)  | Enrich tokens with extra claims.                                                                                    |
| Post authentication                     | No direct equivalent                                     | Use sign-in logs and Azure Monitor to trigger downstream actions.                                                   |
| Custom message                          | No direct event trigger                                  | External ID uses configurable email providers and branding. Fully custom message logic isn't supported as an event. Not relevant for social sign-in users because sign-in messages are handled by the social provider (Google, Facebook). Only applies to local accounts that use email one-time passcode (OTP) or password reset flows. |
| User migration                          | [Custom authentication extension on password submit (JIT)](/entra/external-id/customers/how-to-migrate-passwords-just-in-time) | Validates the password against Cognito on first sign-in and migrates it to External ID. Only relevant for local accounts (email and password). Not applicable to social sign-in users because they don't have a password to migrate. |
| Define / Create / Verify auth challenge | [Custom authentication extensions](concept-custom-extensions.md)                         | Used for fully custom authentication flows in Cognito (for example, SMS-based passwordless or security questions). Not a one-to-one mapping. You need to rebuild the flow by using the External ID custom authentication extension model. Not relevant for social sign-in users because they authenticate via Google or Facebook and bypass custom challenge flows. |

> [!TIP]
> The post confirmation, post authentication, and custom message triggers don't have direct event-based equivalents in External ID. If your current Cognito setup relies on any of these triggers, plan an alternative. For post confirmation actions, reacting to Microsoft Graph change notifications is the typical workaround. For custom email content, the External ID branding and language customization is the closest option.
>
> For product details, see [Custom authentication extensions overview](/entra/identity-platform/custom-extension-overview), [Custom authentication extension resource types](/graph/api/resources/customauthenticationextension), [Token issuance start configuration](/entra/identity-platform/custom-extension-tokenissuancestart-configuration), [Attribute collection extensions](/entra/identity-platform/custom-extension-attribute-collection), and [Custom email provider for one-time passcode](/entra/identity-platform/custom-extension-email-otp-get-started).

#### External ID authorization code flow endpoints

External ID exposes OIDC and OAuth 2.0 endpoints on a dedicated domain, following this pattern:

- Authorization: `https://<tenant-name>.ciamlogin.com/<tenant-id>/oauth2/v2.0/authorize`
- Token: `https://<tenant-name>.ciamlogin.com/<tenant-id>/oauth2/v2.0/token`

You can find the exact URLs in the Microsoft Entra admin center under **App registrations** > **Endpoints**, or from the OpenID Connect discovery document at `https://<tenant-name>.ciamlogin.com/<tenant-id>/v2.0/.well-known/openid-configuration`. For external tenants, the issuer value that's returned by metadata uses the tenant ID in the host and path: `https://<tenant-id>.ciamlogin.com/<tenant-id>/v2.0`. Validate tokens against the issuer value from the metadata document, not a manually constructed value.

Cognito and External ID support the same flow.

**What changes:**

- **Authorization endpoint:** Moves from `https://<cognito-domain>/oauth2/authorize` to the External ID authorize endpoint for your tenant.
- **Token endpoint:** Moves from `https://<cognito-domain>/oauth2/token` to the External ID token endpoint.
- **Scopes:** Cognito scopes are formatted `<resource-server-identifier>/<scope>`, while External ID scopes are formatted `<application-id-uri>/<scope>`, where the application ID URI is typically `api://<api-client-id>`. In External ID, you define the API with **Expose an API**, declare scopes there, and grant them to the client app as **API permissions**. The client requests these scopes when it calls the API.
- **Audience:** Validate the runtime audience value that appears in the access token. In Microsoft identity platform v2.0 access tokens, `aud` is typically the API application's client ID (GUID). In v1.0 tokens, it can be the Application ID URI. Cognito access tokens identify the app client with `client_id`. An `aud` claim appears only when the app requests a Cognito resource binding for an API. Your API's JSON Web Token (JWT) validator must update its expected `aud`, expected `iss`, and JWKS URI based on the token version and provider behavior. For more information, see [Access token claims](/entra/identity-platform/access-token-claims-reference), [Claims validation](/entra/identity-platform/claims-validation#validate-the-audience), and [Cognito access token claims](https://docs.aws.amazon.com/cognito/latest/developerguide/amazon-cognito-user-pools-using-the-access-token.html).

The Microsoft identity platform documentation on the [authorization code flow](/entra/identity-platform/v2-oauth2-auth-code-flow) is the reference for the exact request and response format.

:::image type="complex" source="./media/migrate-from-cognito-to-external-id/authorization-code-flow-pkce-external-id.png" alt-text="Diagram that shows OAuth 2.0 authorization code flow with PKCE. It shows the client, External ID, and back-end API." lightbox="./media/migrate-from-cognito-to-external-id/authorization-code-flow-pkce-external-id.png" border="false":::
The diagram shows that the client app uses OAuth 2.0 authorization code flow with PKCE to sign in users through Microsoft Entra External ID. The app redirects the user to sign in, exchanges the authorization code for tokens, and receives an access token and ID token. The app calls the back-end API with the access token, and the API validates the token before returning a response.
:::image-end:::

### Choose a cutover approach

Choose between the following two cutover approaches:

- **Phased.** One user segment at a time.
- **Big bang.** One cutover window, everyone at once.

**Choose phased cutover if you can.** For a customer-facing app with social sign-in, a phased cutover causes the least disruption and gives you time to find any problems before they affect every user. A big bang cutover is only appropriate when:

- The migration can be staged end-to-end in a nonproduction environment with high confidence.
- The legacy Cognito user pool can stay available read-only for a defined fallback period.
- You have a short and well-defined maintenance window. (Most consumer-facing apps don't.)
- Your user base is small enough that a rollback is inexpensive.

Here's what a phased cutover looks like for this scenario:

1. **Pre-migrate users to External ID.** Use Microsoft Graph to bulk-create user accounts in External ID. For social-linked users, set the `identities` property on each user object so that External ID knows which Google or Facebook account maps to which user. This step happens before any cutover.

1. **Route a small percentage of sign-ins to External ID.** Your app chooses which identity provider starts the OAuth flow based on a feature flag or configuration setting. Start with 5% of traffic. Users signing in through External ID authenticate via the new tenant, and because their federated identity was pre-linked in step 1, they match to the existing user account without being asked to register again.

1. **Monitor and expand.** Watch sign-in success rates, token validation, and API authorization outcomes for the External ID group. If everything looks good, increase the percentage. If problems appear, roll back the feature flag and fix them before expanding. For mobile apps that have embedded SDKs, rollback requires a new app release through store review rather than a config change, so plan mobile waves conservatively.

1. **Backfill inactive users.** For users who didn't sign in during the migration window (inactive or abandoned accounts), you have two options:

    - Pre-migrate them in step 1 so they're ready if they ever return.
    - Leave them in Cognito and migrate them on-demand if they sign in after the cutover. (Use a lightweight JIT pattern where the app detects a Cognito-only user and migrates them to External ID on first sign-in.)

    Most organizations pre-migrate everyone to avoid the complexity of JIT detection.

A big bang cutover is only appropriate when you have a short and well-defined maintenance window, a small user base, or can't run dual identity providers in parallel.

### Further considerations

Use these planning considerations to decide whether the migration approach is viable before you start configuring the target tenant. They help you estimate operational impact, define readiness criteria, and keep rollback practical during each migration wave.

#### Licensing

External ID includes a certain number of monthly active users (MAU) at no charge. After that limit, pricing is per authentication. Conditional Access policies require at least Microsoft Entra ID P1 licensing. Microsoft Entra ID Protection (risk-based sign-in, compromised credential detection) requires Microsoft Entra ID P2 licensing. Review the [External ID pricing page](/entra/external-id/external-identities-pricing) and the [Microsoft Entra ID licensing guide](/entra/fundamentals/licensing) to estimate costs for your user base.

#### Success criteria

Set clear success criteria: 

- Sign-in success rate within *X*% of the pre-migration baseline
- Median latency within *Y* ms of the Cognito baseline
- Zero regressions in API authorization outcomes

Use the success criteria in Step 4, where you evaluate to sign off on a successful migration.

#### Rollback plan

1. Keep Cognito fully operational until you complete validation for each migration wave.
1. Keep both the Cognito and External ID redirect URIs active in the social provider consoles during the transition.
1. If a wave fails validation, revert the app configuration to point back to Cognito. (Update the MSAL authority back to the Cognito domain, or redeploy the Amplify Auth version.)
1. Be sure that each wave has a go/no-go checkpoint that's based on the validation checklist in Step 4: Evaluate.
1. Only remove the Cognito redirect URIs and disable the user pool after the final wave passes validation and you observe zero traffic to Cognito for at least 72 hours.
1. If users signed up or changed their profile in External ID before rollback, those changes exist only in the External ID directory. Document a reconciliation process: export any new External ID users or profile changes, then decide whether to re-create them in Cognito or carry them forward in the next migration attempt.

### Migration runbook

Create a migration runbook for your team before you start any production changes. The runbook is the step-by-step operational document that your team follows during the Execute phase (Step 3). Define it during planning so that your team agrees on the sequence, responsibilities, communication checkpoints, and decision criteria before cutover begins. The following numbered steps provide the outline for your runbook. Adapt them to your team's tooling and communication channels.

A **migration wave** is a defined user cohort that you move from Cognito to External ID together. You can define a cohort by traffic percentage, app version, geography, or customer segment. Run the same ordered process for each wave, and only expand to the next wave after the current one passes validation.

Your runbook should cover the following steps for each migration wave:

1. Confirm go/no-go criteria: pilot validation passed, monitoring is active, rollback is ready, migration scripts are tested, and support teams know the wave scope.
1. Deploy the final prepared application code if it isn't already deployed behind a feature flag or configuration switch.
1. Apply only final External ID configuration changes that were already validated in the pilot, such as enabling a prepared custom authentication extension or confirming app role assignments.
1. Run the prepared user migration scripts for the wave and reconcile the output.
1. Validate migrated users before routing production traffic for the wave.
1. Start the cutover window for the wave and route the selected users to External ID.
1. Run both systems in parallel and monitor sign-in, token issuance, API authorization, custom extension health, and support signals.
1. Roll back the wave if failure thresholds are exceeded, or expand to the next wave when validation passes.

### Plan MFA method transition

Cognito MFA settings don't carry over automatically. External ID customer tenants support email one-time passcode and SMS-based authentication (as an [add-on](/entra/external-id/customers/concept-multifactor-authentication-customers)) as second-factor methods. Passkey (FIDO2) isn't available as a second factor for external identity provider users. Authenticator app registration from Cognito isn't a supported migration target.

For users who used Cognito authenticator app MFA, plan a transition to a supported External ID method before the migration wave. Communicate the change before cutover so users understand which second factor they'll be prompted to use.

MFA users have a different migration experience than non-MFA users. Consider migrating non-MFA users first to validate the core flow, then migrate MFA users as a separate wave, and provide targeted communication.

### Choose a password migration strategy

For users with local Cognito accounts (email and password), Cognito doesn't export password hashes. Choose one of three options and communicate it to users before cutover:

- **Forced password reset (recommended):** Migrate the user account without a password, mark the account for password reset on first sign-in, and let the user set a new password by using the External ID self-service flow. This option is the simplest and most reliable path. It aligns the user with the External ID password policy from first sign-in. Provide proactive communication via email a few days before cutover so users aren't surprised.
- **Just-in-time (JIT) password migration:** A custom authentication extension validates the password against Cognito's `AdminInitiateAuth` API on first sign-in, then writes the password to External ID. The user doesn't notice the migration. This option requires more implementation and operational effort. It requires Cognito to stay reachable during the JIT window and should be tracked as its own implementation and validation workstream.
- **Transition to passwordless:** Switch local accounts to email one-time passcode and remove the password entirely.

Use forced password reset as the default. Use JIT only if the business requires no password reset. A full migration with a clean password reset is more predictable and fails in fewer places than a JIT flow that depends on the legacy system staying online.

## Step 2: Prepare

You now have a documented inventory of your Cognito environment, a cutover approach, and a migration runbook. Next, build the target environment and validate it end to end in a pilot.

In this step, prepare the target environment and the migration assets before you move users or switch production traffic. Complete these activities in a pilot environment first, then repeat the validated configuration in production.

### Prepare a pilot environment

Before you configure anything in the production External ID tenant, set up a separate pilot tenant where you can validate the migration end to end with a small group of test users. Configure the pilot first, including app registrations, managed sign-in, social identity providers, API permissions, app roles, monitoring, code configuration, and migration scripts. After the pilot passes validation, repeat the same configuration in the production tenant.

Define the acceptance criteria up front:

- Users can sign in by using your configured social identity providers, such as Facebook or Google.
- New sign-ups create a user in the directory.
- Returning users who were migrated from Cognito sign in without being asked to register again.
- The API receives an External ID access token and authorizes the user based on app roles, or group claims if you explicitly configured group-based authorization. If you use app roles, confirm that the roles are defined and assigned on the API app registration / service principal so they appear in the API access token.
- Monitoring captures sign-in failures, API authorization failures, and custom extension failures during pilot validation.
- The migration scripts can export a pilot user set from Cognito and create or update the corresponding users in External ID without manual changes.

If any of these criteria fail in the pilot, fix the configuration, code, or migration scripts in the pilot environment before you apply the corrected setup to production.

### Confirm privileged access for preparation

Before you configure the pilot or production tenant, confirm that the operators performing this phase have the privileges needed to complete each task. Creating app registrations, exposing API scopes, configuring managed sign-in, assigning app roles, creating users through Microsoft Graph, and configuring monitoring exports can require different administrative roles or Microsoft Graph permissions. At a minimum, plan for the **Application Administrator** and **User Administrator** roles in the External ID tenant, and confirm any additional privileges needed for Log Analytics, Azure Monitor, Azure Functions, managed identities, or CI/CD secrets before the pilot begins.

### Create and configure the external tenant

If you don't already have a pilot External ID tenant, create one in the Microsoft Entra admin center before you create or change the production tenant. To keep data residency consistent, select the geographic location that matches the location of your Cognito user pool. External ID stores user profile data, credentials, and authentication metadata in the geographic region that you select when you create the tenant. This selection is permanent and can't be changed after creation. For workloads that have strict data residency requirements, review [Where Microsoft Entra ID stores identity data](/entra/fundamentals/data-residency) before you proceed, and use the [Go-Local add-on](/entra/fundamentals/data-residency#go-local-add-on).

If you already have an External ID tenant for another app, you can reuse it. Each tenant supports multiple app registrations, user flows, and social IdP configurations.

### Register applications and configure user flows

For each Cognito app client, create a matching app registration in External ID:

1. Register the client app (the web app that users sign in to). Set the redirect URI to the callback that your app uses after migration. Enable the authorization code flow with PKCE.
1. Register the back-end API as a separate app registration. In **Expose an API**, set the application ID URI and declare the scopes that you need (the equivalent of your Cognito resource server scopes).
1. In the client app registration, add the API scopes under **API permissions**.
1. If your API authorizes by app roles, define the roles on the back-end API app registration, then assign users or security groups to those roles on the API enterprise application. Roles defined only on the client app don't appear in the API access token.
1. Create a user flow (sign-up and sign-in) in External ID. Configure the identity providers, attributes to collect during sign-up, and authentication methods.
1. Associate the client app with the user flow and confirm that the redirect URI, post sign-out redirect URI, scopes, and API permissions match the pilot app configuration.

### Plan the migration from hosted UI to managed sign-in

If your Cognito hosted UI uses custom branding, document what users currently see before you configure managed sign-in. Capture logos, colors, text, custom domain usage, language behavior, sign-in and sign-up screens, password reset entry points, and any custom CSS-dependent behavior.

In External ID, configure the closest managed sign-in experience in the pilot tenant first. Validate whether company branding meets your user experience requirements. If it doesn't, don't defer the decision to cutover day. Decide during preparation whether to accept the managed sign-in differences, update user communications, or move the user-facing entry experience into your application while MSAL handles the standards-based authorization flow with External ID.

### Configure social identity providers

Add the same upstream social identity providers that you currently use, such as Facebook or Google, to the External ID tenant. The migration changes the broker and token issuer from Cognito to External ID. It doesn't replace the upstream social provider accounts.

Before you change the social provider developer-console configuration, confirm the current Cognito callback and sign-out URLs from the assessment inventory. You can reuse the existing Google and Facebook OAuth client credentials that you already configured for Cognito. Go to the Google Cloud Console and the Meta for Developers portal and add the External ID redirect URIs to the authorized list beside the Cognito redirect URIs. Copy the exact redirect URI from the Microsoft Entra admin center for each provider rather than constructing it manually. (The format varies by provider, for example `/federation/oauth2` for custom OIDC, or a provider-specific path for Google and Facebook.) Don't remove the Cognito redirect URIs yet. Both sets must be active during the transition.

Then, in the External ID admin center, add [Google](/entra/external-id/customers/how-to-google-federation-customers) and [Facebook](/entra/external-id/customers/how-to-facebook-federation-customers) as identity providers, paste the OAuth client ID and secret, and add them as sign-in options to managed sign-in.

Custom OIDC providers follow the [custom OIDC federation flow](/entra/external-id/customers/how-to-custom-oidc-federation-customers). You'll need the provider's well-known discovery endpoint, client ID, and client secret. Unlike non-custom providers, claims mapping (`sub`, `email`, `name`, and so on) must be configured explicitly to match what you have in Cognito.

### Migrate custom domains (if applicable)

If your Cognito environment uses a custom domain (for example, `auth.example.com`), plan the DNS migration. You can't point the same domain to both Cognito and External ID simultaneously. Here are some options:

- Use a different subdomain for External ID during dual-run. (For example, use `login.example.com` for External ID while keeping `auth.example.com` pointing to Cognito.) After cutover, you can optionally switch the original domain to External ID.
- To use a custom domain with External ID, you need Azure Front Door as a reverse proxy in front of the External ID tenant. Follow the documented process in [Use a custom URL domain](how-to-custom-url-domain.md), which includes creating an Azure Front Door instance, configuring custom routing rules, and adding the custom domain with a Canonical Name (CNAME) record. Set your DNS time to live (TTL) to a low value (for example, 300 seconds) before cutover so that the switch takes effect quickly.

### Confirm pilot readiness before production configuration

Before you repeat configuration in production, confirm that the pilot environment from the beginning of this step passed the acceptance criteria. If any criteria fail, fix the configuration, code, monitoring, or migration scripts in the pilot before applying the setup to production.

### Set up monitoring

Set up monitoring before pilot validation and before production cutover. Monitoring is part of migration readiness, not a follow-up task. Match or exceed the visibility you had in Cognito by reviewing the monitoring baseline you documented in Step 1: Plan (Cognito CloudWatch metrics for sign-in success rates, token issuance latency, Lambda trigger execution, and failure rates). Replicate the same metrics in Azure.

- **Sign-in logs:** External ID sign-in logs show every authentication attempt. Filter by application and failure reason to catch configuration problems. This replaces Cognito's sign-in CloudWatch metrics.
- **Azure Monitor:** Export sign-in and audit logs to a Log Analytics workspace. Set alerts on failure rate spikes and custom extension timeouts. Configure the same alert thresholds you had in Cognito so you catch regressions immediately.
- **Custom extension metrics:** Custom authentication extensions have a [default timeout of 1 second](/graph/api/resources/customextensionclientconfiguration), configurable to a maximum of 2 seconds. Cold starts on Azure Functions often exceed this limit. Detailed latency data is located at the compute layer, and External ID only logs that the extension call failed. Set an alert on your extension compute for any P99 latency that approaches the timeout threshold. Compare this to your Lambda trigger CloudWatch metrics. When a custom extension times out or returns an error, External ID proceeds without the extension's claims. Decide in advance whether missing claims should block sign-in (fail-closed) or allow it with reduced functionality (fail-open), and implement that logic in your API middleware.
- **User activity dashboards:** External ID includes built-in dashboards for sign-ups, sign-ins, and MFA usage. Use these dashboards to validate that user behavior matches your pre-migration baseline.

### Create and test migration scripts

Create the migration scripts or runbooks during the Prepare phase. The scripts should read users from Cognito, transform the data into the External ID target shape, and create or update users through Microsoft Graph. Test the scripts against the pilot tenant with a small user set before you run them in production.

The export phase of the script should use the `ListUsers` and `AdminGetUser` APIs, handle pagination, and capture the fields needed for the target External ID user objects:

- Username or email
- Email verified and phone verified flags
- Federated identity details (provider, external subject ID) for each linked social sign-in account
- Custom attributes
- Group memberships from `AdminListGroupsForUser`
- MFA configuration, if applicable

Cognito doesn't expose password hashes. For social-only users, this design is fine because there's nothing to migrate. For local-account users, plan either forced password reset or [JIT password migration](/entra/external-id/customers/how-to-migrate-passwords-just-in-time).

The import phase should create users through the Microsoft Graph `/users` endpoint. For social-linked users, the script should add each federated identity on the user object. When the user next signs in through a Facebook or Google account, External ID matches on `issuer` and `issuerAssignedId` and reuses the pre-created account instead of creating a new one. The populated `identities` collection must exist before first sign-in.

| Provider | `issuer` value | `issuerAssignedId` value |
|----------|---------------|--------------------------|
| Google | `google.com` | The user's Google `sub` (from Cognito's `identities` attribute) |
| Facebook | `facebook.com` | The user's Facebook user ID (from Cognito's `identities` attribute) |

Here's an example Microsoft Graph API call for a Google-linked user:

```json
POST /users
{
  "displayName": "Jane Doe",
  "accountEnabled": true,
  "userPrincipalName": "janedoe_google.com#EXT#@<tenant>.onmicrosoft.com",
  "identities": [
    {
      "signInType": "federated",
      "issuer": "google.com",
      "issuerAssignedId": "110169484474386276334"
    }
  ]
}
```

If the `issuer` or `issuerAssignedId` is wrong, External ID treats the next social sign-in as a new user and creates a duplicate account. Pull the provider subject ID from the `identities` JSON attribute on the Cognito user object (returned by `AdminGetUser`).

Map Cognito groups primarily to app roles when they represent application permissions. If you need direct group-based authorization, map them to External ID groups and document that emitted `groups` values are group object IDs by default. Apply the same mapping to each user's memberships or role assignments.

Use the migration extension property pattern to flag which users are migrated and which aren't. This flag is useful for tracking migration progress and for identifying users during a phased cutover, regardless of whether they sign in with social providers or local accounts.

#### Large user base

If you're migrating a large number of users, Microsoft Graph throttling will cause this step to take a significant amount of time. Use [Microsoft Graph batching](/graph/json-batching) to reduce request count and implement back-off logic that respects the `Retry-After` header returned on 429/503 responses to avoid repeatedly reaching [throttling limits](/graph/throttling-limits).

Write `identities` and custom attributes in the initial `POST` call rather than in follow-up `PATCH` calls.

For a reference implementation that includes batching, retry, and throttling logic, see the [B2C-to-External-ID migration tool](https://github.com/microsoft/b2c-to-meeid-migration-tool/) on GitHub. Adapt its patterns for your Cognito source.

You'll run these scripts in Step 3.

### Prepare custom logic migration

Rebuild and test each Lambda trigger replacement before the migration window. For the social sign-in scenario, the most common pattern is **Pre token generation > `OnTokenIssuanceStart`**. If your Lambda adds a custom claim based on user attributes or a back-end lookup, rebuild that logic as an Azure function or another HTTPS endpoint that returns the expected External ID response format. Validate the extension in the pilot tenant, including timeout behavior, rollback, signing-key requirements, and monitoring alerts.

For triggers that don't have a direct External ID event equivalent, such as post confirmation or post authentication, prepare the replacement workflow before cutover. For example, use Microsoft Graph change notifications, Logic Apps, sign-in logs, or Azure Monitor depending, on the business requirement.

For an end-to-end example of implementing `OnTokenIssuanceStart`, see [Get started with custom authentication extensions](/entra/identity-platform/custom-extension-tokenissuancestart-setup).

### Prepare token validation, claim mapping, and identity keys

Complete token and claim mapping before migration day. Update back-end API validation settings for the External ID issuer, JWKS metadata endpoint, expected audience, and accepted token version. Update authorization code to use the target claim model, such as `roles` for app roles, or `groups` only when you deliberately use direct group claims.

Use the following table to map Cognito claims to their External ID equivalents. This table expands on the capability mapping in Step 1 by providing the exact claim names that your code needs to handle.

| Concept                  | Cognito claim                                          | External ID claim                                                                                                             |
| ------------------------ | -------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------- |
| User identifier          | `sub`                                                  | `oid` - ensure that External ID tokens include a `sub` claim, but it's pairwise. Use `oid` as the stable identifier across applications. |
| Issuer                   | `https://cognito-idp.<region>.amazonaws.com/<pool-id>` | `https://<tenant-id>.ciamlogin.com/<tenant-id>/v2.0` - validate against the issuer that's returned by the External ID metadata document.   |
| Audience (ID token)      | `aud` = App client ID                                  | `aud` = Application (client) ID                                                                                                     |
| Audience (access token)  | `client_id` = app client ID; `aud` is present only when the app requests a Cognito resource binding for an API | `aud` = API client ID GUID for v2.0 access tokens. v1.0 tokens can use the Application ID URI.                                       |
| Authorization membership | `cognito:groups`                                      | `roles` for app roles; `groups` for direct group claims, emitted as group object IDs by default.                                     |
| Username (ID token)      | `cognito:username`                                     | `preferred_username`                                                                                                                |
| Custom attributes       | `custom:<name>`                                        | Directory storage: `extension_<appid>_<name>`; emitted token claim can use a configured or extension-produced name, such as `tier`.  |
| Token expiration         | `exp`                                                  | `exp`                                                                                                                               |
| Scopes                   | `scope`                                                | `scp` (access token)                                                                                                                |

If your database or downstream systems store the Cognito `sub` as the user identifier, prepare the data migration or lookup strategy before cutover. After migration, use the External ID `oid` as the stable user object identifier. Validate that authorization checks, ownership checks, audit logs, and support tooling can resolve migrated users correctly before the first production wave.

If you use group-based authorization, prepare the group overage strategy before cutover. Cognito embeds every group that the user belongs to directly in the `cognito:groups` claim (up to 100 groups per user). Microsoft Entra ID works differently. By default, `groups` contains group object IDs, not friendly group names. If the user is a member of more than 200 groups, Microsoft Entra ID doesn't emit the `groups` claim in JWT tokens. Instead, it emits an overage indicator, as described in the [access token claims reference](/entra/identity-platform/access-token-claims-reference):

```json
"_claim_names": { "groups": "src1" },
"_claim_sources": {
  "src1": {
    "endpoint": "https://graph.microsoft.com/v1.0/users/{id}/getMemberObjects"
  }
}
```

When your API sees `_claim_names` with a groups entry, it calls the [getMemberObjects](/graph/api/directoryobject-getmemberobjects) endpoint with a POST body of `{"securityEnabledOnly": false}` to get the actual group list. For SAML tokens, the overage limit is 150. Implicit flow tokens behave differently: External ID emits `hasgroups: true` (a Boolean) instead of the `_claim_names`/`_claim_sources` pattern, and the app must call Microsoft Graph directly with no endpoint hint from the token. The overage limit for implicit flow tokens is five.

If users typically belong to a small number of groups, this distinction doesn't apply. If you have any users in a large number of groups, handle it in one of the following ways:

- Configure group claims to include only groups assigned to the application, which reduces the size of the claim.
- Use app roles instead of groups. App roles aren't subject to the overage limit and are the recommended pattern for app-level authorization.
- Handle the overage claim in the API by calling Microsoft Graph when you see `_claim_names` (or `hasgroups` for implicit flow tokens).

For most migrations from Cognito, moving to app roles is the cleanest approach. Use security groups assigned to app roles if you need group-based administration while keeping stable app-defined values in the `roles` claim.

**Other claims to double-check.** The default set of claims in an External ID token is smaller than some teams expect. If your API reads a claim that isn't in the default set (for example, `email`, `family name`, `given_name`), add it as an optional claim on the app registration so it's included in the token.

### Prepare application code changes

Prepare the application changes before you execute the migration or switch traffic. In the pilot branch or environment, update the front-end authentication configuration to use MSAL with the External ID authority, client ID, redirect URI, and API scopes. Update back-end API validation settings for the External ID issuer, JWKS metadata, and expected audience. Update authorization code to read the target claims, such as `roles` for app roles or `groups` if you deliberately use group claims.

If you're using a phased cutover (see [Choose a cutover approach](#choose-a-cutover-approach)), prepare the feature flag or configuration switch that chooses Cognito or External ID for a user cohort. If the API must accept both token issuers during the transition, prepare and test issuer-specific token validation before the first wave. Keep these code changes ready for deployment in Step 3.

For mobile apps, prepare the platform-specific MSAL libraries:

**iOS:** Use [MSAL for iOS](/entra/identity-platform/quickstart-mobile-app-ios-sign-in). Tokens are cached in the iOS Keychain. Register a redirect URI in the format `msauth.<bundle-id>://auth`. If you use Microsoft Authenticator as a broker, add the broker redirect URI.

**Android:** Use [MSAL for Android](/entra/identity-platform/quickstart-mobile-app-android-sign-in). Tokens are cached in `EncryptedSharedPreferences`. Register a redirect URI with your app's signature hash. The Authenticator app acts as a broker for single sign-on (SSO) across apps.

### Prepare dual-run token validation

During the migration, your API might receive access tokens from both Cognito and External ID. Configure token validation per issuer. For each issuer, validate the signature by using the correct metadata or JWKS endpoint, and enforce the expected issuer and audience. Don't treat issuer allow-listing alone as sufficient validation.

**ASP.NET:** Use separate JWT bearer schemes, or a policy scheme, so each issuer has its own authority, metadata, signing keys, and validation settings. If you use `Microsoft.Identity.Web`, configure each scheme explicitly for the token source that it trusts.

**Node.js:** Use `express-jwt` or `jose` with issuer-aware key selection so that the token issuer determines which JWKS endpoint is used for signature verification. Also validate the expected `aud` for each token source.

During dual-run, update your API's Cross-Origin Resource Sharing (CORS) policy only if the web application origin that calls the API changes. CORS applies to browser requests from your web app's origin to the API. The Cognito-hosted UI domain and External ID sign-in domain normally aren't the origins that call your API.

If your application uses AWS API Gateway with a Cognito authorizer, the Azure equivalent depends on your architecture:

- With Azure API Management, configure the [validate-jwt policy](/azure/api-management/validate-jwt-policy) to validate External ID tokens, setting the `openid-config` URL to your tenant's metadata endpoint.
- Without API Management, validate tokens in your application middleware by using [Microsoft.Identity.Web](/entra/msidweb/overview) (.NET).

### Prepare session cutover behavior

If you plan to shorten the Cognito refresh token lifetime before cutover, do it during preparation, not during the migration window. Existing refresh tokens can remain valid until their configured lifetime expires, so make the change early enough for previously issued tokens to age out before the cutover wave. Use your current Cognito refresh token lifetime to decide when to apply this setting.

Schedule cutover during a low-traffic window. Check your Cognito CloudWatch metrics to find the quietest period.

Also prepare user communications for reauthentication. When users are moved from Cognito to External ID, active Cognito sessions might fail on their next token refresh and users might need to sign in again. If your user base is sensitive to forced re-authentication (for example, financial or healthcare apps), communicate proactively before the wave.

### Run pre-production load and resilience tests

Run pre-production load testing in the pilot or staging environment before the production migration. Drive a realistic sign-in rate through External ID and the application, including token issuance, API calls, and custom authentication extension calls. Use the results to validate throttling behavior, custom extension timeout margins, monitoring alerts, and rollback criteria before Step 3.

## Step 3: Execute

Your pilot environment is validated, your code is ready, and your migration scripts are tested. Now execute the phased cutover. Follow your runbook closely and communicate with stakeholders throughout the process.

Execute the runbook that you created in Step 1 for each wave. The following sections provide operational details for each step.

### Run user migration scripts for the wave

Run the migration scripts that you created and tested in Step 2 for this wave's user cohort. Reconcile the output logs: confirm created users, review skipped or failed writes, and resolve duplicate identities before you proceed.

### Migrate credentials and social-linked accounts

**Social identity provider only:** For users who sign in by using only social identity providers, there's no password to migrate. The migration process links the External ID user to the same Facebook or Google subject, so the next sign-in works without re-registration. If you set the federated identity correctly, the migration is complete for these users.

**Local accounts:** Execute the password strategy that you chose in Step 2 (forced reset, JIT, or passwordless).

Some Cognito users have both a social provider link and a local password. When you encounter these users, migrate both identities. Add the federated identity (Google, Facebook) to the user object through the `identities` collection in Microsoft Graph, and set a temporary password for the local credential. The social identity takes precedence for sign-in when the user chooses that provider. If the user signs in with email and password instead, the password path depends on which migration option you chose: the JIT extension validates the password against Cognito, or the user completes a self-service password reset. This approach preserves both sign-in paths without requiring the user to choose.

If you choose JIT, follow the guidance in the existing just-in-time password migration article in the External ID documentation. The implementation pattern is the same for Cognito as for any other legacy IdP. In addition, plan for these failure modes:

- **Cognito unreachable:** The user can't sign in at all during the outage. Consider a fallback to forced password reset for users who aren't migrated within a set window.
- **Microsoft Graph write fails after Cognito validates:** The password isn't saved. Next sign-in hits Cognito again, which works until decommission. Log these failures and retry the Microsoft Graph write asynchronously.
- **Rate limiting:** Cognito's `AdminInitiateAuth` API has throttling limits. If you're using JIT for thousands of users simultaneously, implement exponential backoff.

### Validate MFA transition for the wave

**SMS MFA:** If the user's phone number is migrated to External ID from the Cognito user export, SMS MFA can work without re-enrollment, but you must enable SMS as an MFA method in the External ID tenant and link the required subscription. Verify that the phone numbers in Cognito are in E.164 format, which External ID requires.

Before including MFA users in a production wave, validate the supported External ID MFA methods that you plan to use, such as email one-time passcode or SMS, along with phone-number formatting, recovery paths, and successful MFA challenge completion for migrated users.

### Enable prepared custom logic

Enable only the custom authentication extensions and replacement workflows that you prepared and validated in Step 2. Step 3 isn't the time to design or rebuild Lambda trigger replacements.

For the social sign-in scenario, validate the prepared runtime behavior:

- **Pre token generation > `OnTokenIssuanceStart`:** Confirm that the prepared extension is deployed, enabled, returning expected claims, and meeting the latency budget.
- **Post confirmation replacement workflows:** Confirm that Microsoft Graph change notifications, Logic Apps, sign-in log processing, or other prepared alternatives are running.
- **Pre sign-up replacement workflows:** Confirm that prepared attribute collection extensions validate input or block sign-ups as expected.

Keep the business logic identical when you enable it for the wave. If a failure occurs, use the rollback path you prepared in Step 2 rather than debugging new logic during the cutover window.

### Verify token and claim behavior

Verify that the token validation and claim mapping you prepared in Step 2 works correctly for this wave. Use the claim mapping table in Step 2 as your reference. Confirm that:

- The API accepts External ID tokens with the correct issuer and audience.
- `oid` resolves to the correct user in downstream systems.
- `roles` or `groups` claims produce the expected authorization decisions.
- Optional claims (`email`, `given_name`, and so on) are present if your API needs them.
- Groups overage handling works if any users belong to more than 200 groups.
- Downstream systems (databases, audit logs, support tooling) resolve migrated user identifiers correctly.

After you complete the final cutover wave and confirm zero Cognito traffic, remove the Cognito issuer from your validation configuration immediately. Leaving both issuers active after migration creates an unnecessary attack surface.

### Deploy application changes

Deploy the application changes that you prepared in Step 2. The front end should move from Amplify Auth, the Cognito SDK, or an OIDC client library to MSAL as part of the migration wave.

Use the deployment strategy that you validated in the pilot. A clean MSAL implementation is cheaper to maintain and easier to reason about, but a phased cutover might require a temporary configuration switch so selected cohorts use External ID while others continue through Cognito.

Verify that the deployed code uses the prepared MSAL implementation for sign-in redirect, account selection, token acquisition, token cache, logout, and API token requests. For browser-based apps, use the MSAL Browser and MSAL React documentation for [login](/entra/msal/javascript/browser/login-user), [token acquisition](/entra/msal/javascript/browser/acquire-token), [accounts](/entra/msal/javascript/browser/accounts), [logout](/entra/msal/javascript/browser/logout), and [React hooks](/entra/msal/javascript/react/hooks). If your previous app used a generic OIDC client rather than Amplify Auth, verify that the External ID authority, client ID, redirect URI, scopes, and token handling code match the MSAL configuration validated in the pilot.

**Confirm the deployed configuration:**

Confirm that:

- The OAuth client ID and authority URL in the MSAL config point to External ID.
- The redirect URI matches the one registered in External ID.
- The API calls request the new External ID scopes.
- Any code that parses the ID token or access token uses the prepared claim mapping.

### Cutover procedure

Use this checklist for each migration wave:

1. Run the pre-cutover validation checks for the wave (a subset of the full validation in Step 4):
    - Sign in with each configured social identity provider by using a migrated user.
    - Confirm that a token is issued.
    - Confirm that the user isn't prompted to register again.
    - Complete a new sign-up.
    - Confirm that the access token includes expected roles or group claims.
    - Confirm that required custom claims are present.
    - Confirm that custom authentication extensions complete within timeout.
    - Confirm that the application can call the back-end API.
1. Verify that custom authentication extensions are deployed and returning healthy responses.
1. If custom claims provider or custom token issuance logic is enabled, verify that the application-specific signing key is configured, active, and not expired before enabling the flow in production.
1. If users encounter `AADSTS50146` or `invalid_request` immediately after enabling the extension, disable the extension or claims provider as the rollback step, restore sign-in, and then correct the signing-key configuration before retrying.
1. Confirm that social IdP redirect URIs are working on the External ID side. (Test a sign-in with each provider in the pilot environment.)
1. Confirm that Cognito refresh token lifetime was already reduced during Step 2, if that was part of your cutover design.
1. Wait for active Cognito sessions to expire, or invalidate them by revoking refresh tokens via the `AdminUserGlobalSignOut` API.
1. Deploy the application update that switches from Amplify Auth / Cognito SDK to MSAL with the External ID authority.
1. Monitor sign-in logs for the first 15 minutes. Watch for failures, custom extension timeouts, and unexpected claim values.
1. Run through the post-migration validation checklist (Step 4).
1. If failures exceed your threshold, roll back: redeploy the previous app version that points at Cognito. Both redirect URIs are still active, so rollback is a configuration change.

> [!NOTE]
> In-flight authorization codes issued by Cognito before cutover can't be exchanged at the External ID token endpoint. Users who are in the middle of sign-in during the switch see a one-time error and must restart the sign-in. Keep the cutover window short to minimize this.

## Step 4: Evaluate

Each wave's cutover is complete. Confirm that it worked before expanding or decommissioning.

Validate the migration with end-to-end testing before considering it complete.

### Post-migration validation checklist

Complete the following checks after each migration wave and after final cutover to validate the migration end to end. This checklist covers all items from the pre-cutover check in Step 3 and adds post-migration scenarios.

Sign in with each social identity provider configured for your application by using a migrated user. Confirm that:

- A token is issued.
- The user isn't prompted to register again.

Complete a new sign-up with each social identity provider. Confirm that:

- The user is created in External ID with the expected attributes.
- A returning user who set a password (for example, after a forced password reset) can sign in by using the new password.
- The access token includes the expected groups or roles claim.
- The access token includes any custom claims required by the API.
- The custom authentication extension runs and completes within the configured timeout.
- The application can successfully call the back-end API by using the External ID access token.
- API authorization decisions match the behavior observed in Cognito for the same user.

### Verify authentication flows and API authorization

In addition to running through the checklist, run these scenarios before production cutover:

- **Happy-path social sign-in > token issuance > API call:** End-to-end, through the same code paths production uses.
- **Account linking:** A user who already exists in External ID (a migrated user) signs in with the same Google account. Make sure they're matched to the existing user, not a new one.
- **MFA challenge:** If MFA is enabled, run a separate MFA validation pass for the supported External ID methods you configured, such as email one-time passcode or SMS. Verify challenge delivery, phone-number format for SMS, recovery behavior, and successful sign-in for migrated users.
- **Password reset (for local accounts, if you used forced reset):** User runs through the self-service password reset (SSPR) flow and signs back in.
- **Token expiration and refresh:** Let an access token expire and verify that the refresh token flow works through MSAL.
- **API authorization boundaries:** Re-run the same authorization tests that you used with Cognito, this time by using External ID-issued access tokens. Verify that the read-only test identity is denied write operations, and that the elevated test identity can perform both read and write operations, according to your app's configured roles or groups.

If you're migrating in waves, use the checklist after each wave.

### Check monitoring

Verify that the monitoring you configured in Step 2, Prepare, is producing data. Review the sign-in logs and custom extension metrics dashboards.

Measure results against the success criteria that you defined in Step 1, Plan.

Review the pre-production load test results from Step 2 as part of nonfunctional validation. After each wave, compare production telemetry with the pilot load-test baseline and watch for throttling, custom extension timeouts, and tail latency.

### Verify traffic cutover

Before you decommission, confirm that no traffic is hitting Cognito:

- Check Cognito CloudWatch metrics for sign-in and token requests. For the user pool clients being decommissioned, metrics such as `SignInSuccesses`, `FederationSuccesses`, and `TokenRefreshSuccesses` should remain at zero during your observation window.
- Check application logs for any call to a Cognito endpoint.
- Check the social identity provider's developer consoles for any remaining use of the Cognito redirect URIs.

Observe the metrics for a few days before you remove anything.

For mobile apps, check app store analytics to confirm adoption of the new version (the one using MSAL). Keep Cognito alive (with no new sign-ups allowed) until the old app version drops below your acceptable threshold (for example, less than 1% of active users). You can't force-update mobile apps. Decommissioning Cognito while old versions are in use locks those users out.

## Step 5: Decommission

All waves passed validation and you confirmed zero Cognito traffic in Step 4. Remove the legacy infrastructure.

### Archive data, remove resources, and notify stakeholders

When you're confident that no traffic is going to Cognito:

1. **Archive what you need to keep for compliance:** Export user data, audit logs, and CloudTrail events. Store them according to your retention policy.
1. **Ensure audit log continuity:** Start exporting External ID sign-in and audit logs to your security information and event management (SIEM) system *before* cutover, so there's overlap between the Cognito CloudTrail events and the External ID logs. Doing so provides continuous audit coverage for compliance.
1. **Validate downstream event consumers:** Confirm that CloudWatch alarms on Cognito events, EventBridge rules, third-party webhooks, SNS/SQS notifications, and other user-pool event consumers are migrated or retired. Validate the replacement sources before deleting Cognito so that downstream workflows don't break silently.
1. **Remove the Cognito redirect URIs from Google and Facebook developer consoles:** This step prevents any stale configuration from sending traffic back.
1. **Disable or delete Cognito app clients:** After the rollback window ends, disable or delete the Cognito app clients and remove any client secrets that are tied to them. If you're deleting the user pool, app clients are removed as part of that cleanup.
1. **Disable sign-ins:** Disable sign-ins on the Cognito app clients before deletion so that you can catch any traffic that slipped through.
1. **Delete the user pool and identity pool:** If you were using a user or identity pool, delete them to avoid any accidental use and to stop any associated costs.
1. **Clean up:** Clean up Lambda triggers, IAM roles, and API Gateway authorizers that referenced the user pool.
1. **Notify stakeholders:** Notify the operations team, the support team, and any internal owners who had visibility into Cognito. If the user experience changed in a noticeable way, notify end users through an email or an in-app message before cutover, not after.

### Conclusion

At this point, your users sign in through External ID, your back-end APIs validate External ID tokens, and Cognito is fully decommissioned. If you experience problems after cutover, check the External ID sign-in logs first. Many post-migration problems come from claim mapping mismatches or custom extension timeouts.

## Related content

**Planning**
- [Planning for customer identity and access management](/entra/external-id/customers/concept-planning-your-solution)
- [Service limits and restrictions](/entra/external-id/customers/reference-service-limits)

 **User migration**
- [Migrate users and credentials to Microsoft Entra External ID](/entra/external-id/customers/how-to-migrate-users)
- [Just-in-time password migration to Microsoft Entra External ID](/entra/external-id/customers/how-to-migrate-passwords-just-in-time)

**Tokens and claims**
- [Microsoft identity platform and OAuth 2.0 authorization code flow](/entra/identity-platform/v2-oauth2-auth-code-flow)
- [Access token claims reference](/entra/identity-platform/access-token-claims-reference)
- [ID token claims reference](/entra/identity-platform/id-token-claims-reference)
- [Configure group claims for applications](/entra/identity/hybrid/connect/how-to-connect-fed-group-claims)

**Developer resources and custom logic**
- [Microsoft Entra External ID Developer Center](https://aka.ms/ciam/dev)
- [Custom authentication extensions](/entra/external-id/customers/concept-custom-extensions)