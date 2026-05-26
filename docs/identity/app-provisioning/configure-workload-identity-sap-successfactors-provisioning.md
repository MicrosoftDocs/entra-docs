---
title: Configure workload identity-based authentication for SAP SuccessFactors provisioning (Preview)
description: Learn how to replace basic authentication with short-lived, federated OpenID Connect tokens for Microsoft Entra provisioning to SAP SuccessFactors.
author: jenniferf-skc
ms.author: jfields
manager: pmwongera
ms.service: entra-id
ms.subservice: app-provisioning
ms.topic: how-to
ms.date: 05/26/2026
ms.reviewer: cmmdesai
ms.custom: sap-successfactors, workload-identity, provisioning
---

# Configure workload identity-based authentication for SAP SuccessFactors provisioning (Preview)

This article shows you how to configure workload identity-based authentication for the Microsoft Entra SAP SuccessFactors provisioning integrations. Workload identity-based authentication replaces the long-lived basic authentication credential used by the provisioning service with short-lived, federated OpenID Connect (OIDC) tokens issued by your Microsoft Entra tenant and trusted by your SAP Cloud Identity Service (SAP IAS) instance.

> [!NOTE]
> We make public previews available to our customers under the terms applicable to previews. These terms are outlined in the overall Microsoft product terms for [online services](https://www.microsoft.com/licensing/terms/product/ForOnlineServices/all).

This change helps customers transition to a more secure authentication model in preparation for SAP's plan to [deprecate basic authentication for SuccessFactors APIs by November 20, 2026](https://help.sap.com/docs/successfactors-release-information/8e0d540f96474717bbf18df51e54e522/fcc05a902b4140e585d968c2fe4a96bc.html).

Applies to the following provisioning integrations:

- SuccessFactors to on-premises Active Directory user provisioning
- SuccessFactors to Microsoft Entra ID user provisioning
- SuccessFactors Writeback

> [!NOTE]
> Workload identity authentication is currently enabled for the **SuccessFactors Writeback** and **SuccessFactors to Microsoft Entra ID user provisioning** scenarios. Support for the **SuccessFactors to on-premises Active Directory user provisioning** scenario will be enabled soon.

## Why workload identity-based authentication

Workload identity-based authentication strengthens your security posture by removing static credentials and replacing them with tokens that expire in minutes rather than never.

| Benefit | What changes |
| --- | --- |
| **No static credentials** | Stored passwords and long-lived secrets are replaced with OIDC-issued tokens that expire in minutes. |
| **Federated by design** | A federated identity credential links your Microsoft Entra tenant to SAP Cloud Identity Service through OIDC trust rules that you control. |
| **Least-privilege access** | The short-lived access token is scoped to the SAP SuccessFactors OData API and bound to a role-based technical/API user. |
| **Fully revocable** | Trust can be revoked from Microsoft Entra at any time without rotating shared secrets in SAP. |

## How the flow works

Microsoft Entra provisioning service authenticates to SAP SuccessFactors using short-lived OIDC tokens issued by your Microsoft Entra tenant and trusted by your SAP Cloud Identity Service instance. The flow has three steps:

1. **Microsoft Entra acquires a signed JWT.** Microsoft Entra provisioning service uses a federated identity credential linked to your SuccessFactors provisioning app to acquire a signed JWT from your Microsoft Entra tenant.
2. **SAP Cloud Identity Service exchanges the JWT for an access token.** The signed JWT is presented to SAP Cloud Identity Service, which is trusted by SAP SuccessFactors. SAP Cloud Identity Service validates the JWT against the trust rules you configure in the SAP Cloud Identity Service admin console and returns a short-lived access token that can only be used to query the SAP SuccessFactors OData API.
3. **The provisioning service calls the OData API.** Microsoft Entra provisioning service uses the short-lived access token to query the SAP SuccessFactors OData API. The access token includes a client ID that's mapped to a technical/API user in SAP SuccessFactors with role-based permission to access SAP SuccessFactors entities.

:::image type="content" source="./media/configure-workload-identity-sap-successfactors-provisioning/entra-sap-workload-identity-detailed-flow.png" alt-text="Detailed runtime flow showing AT1 acquisition from Microsoft Entra, exchange for AT2 at SAP Cloud Identity Service, and the OData API call to SAP SuccessFactors." lightbox="./media/configure-workload-identity-sap-successfactors-provisioning/entra-sap-workload-identity-detailed-flow.png":::

### Token exchange sequence diagram

The runtime exchange involves three cloud services (Microsoft Entra ID, SAP IAS and SAP SuccessFactors) and two access tokens (AT):

- **AT1** — A JWT issued by Microsoft Entra ID through the federated identity credential.
- **AT2** — A short-lived access token issued by SAP Cloud Identity Service after it validates AT1 through Trust-by-Issuer.

The following swim-lane shows who calls whom, in order, at runtime.

:::image type="content" source="./media/configure-workload-identity-sap-successfactors-provisioning/token-exchange-sequence-diagram.png" alt-text="Sequence diagram of the runtime token exchange between Microsoft Entra provisioning service, the customer's Entra ID tenant, SAP Cloud Identity Service, and SAP SuccessFactors." lightbox="./media/configure-workload-identity-sap-successfactors-provisioning/token-exchange-sequence-diagram.png":::

### Token claim reference

| Token | Claim | Value |
| --- | --- | --- |
| **AT1** (Microsoft Entra–issued JWT) | `sub` | `<workload-identity-app-object-id>` |
| | `aud` | `<workload-identity-app-client-id>` |
| | `iss` | `https://login.microsoftonline.com/<tenantId>/v2.0` |
| **AT2** (SAP IAS access token) | `sub` | `<sap-ias-app-client-id>` |
| | `iss` | `https://<sap-ias-server>` |
| | `ias_apis` | `sf_technical_access` |
| | `client_assertion_type` | `urn:ietf:params:oauth:client-assertion-type:jwt-bearer` |

## Prerequisites

Before you start, make sure that you have the following in place:

- **SAP SuccessFactors provisioning app** configured from the Microsoft Entra enterprise application gallery.
- **SAP Cloud Identity Service (SAP IAS)** available and [configured as the authentication service for SAP SuccessFactors](https://help.sap.com/docs/successfactors-platform/setting-up-sap-successfactors-with-identity-authentication-and-identity-provisioning-services/checking-to-see-if-you-aready-have-identity-authentication-enabled).
- **Administrator access** to the Microsoft Entra admin center (App Admin role), the SAP Cloud Identity Service admin console, and the SAP SuccessFactors admin console to configure the following:
  - In Microsoft Entra admin center, you need access to register an app with **Federated identity credential** and update the authentication mechanism for your SuccessFactors provisioning app to use this workload identity.
  - In SAP Cloud Identity Service (SAP IAS) admin console, you need access to configure **JWT Trust-by-Issuer** trust relationship that allows SAP Cloud Identity Service to trust Microsoft Entra–issued tokens for your tenant.
  - In SAP SuccessFactors admin console, you need access to configure the **OIDC OAuth client mapping** that binds the SAP IAS client ID to a SuccessFactors technical/API user with role-based permissions.

## Planning the upgrade

Switching to workload identity-based authentication involves coordination across three admin teams — the teams that administer Microsoft Entra, SAP Cloud Identity Service, and SAP SuccessFactors. Share this article with all relevant stakeholders before you begin so that everyone has a clear understanding of the end-to-end flow.

Consider the following approach:

- **Coordinate across teams.** Set up a working session with representation from each service team (Microsoft Entra, SAP IAS, and SAP SuccessFactors administration) so that all required configuration steps can be completed without waiting for handoffs.
- **Test in a nonproduction environment first.** Complete the end-to-end configuration in a QA or development environment before applying the change in production. This approach lets you validate the token exchange flow and provisioning behavior with no risk to production users.
- **Replicate after the first app is validated.** After your team is comfortable with the process for one SuccessFactors provisioning app, you can apply the same steps quickly to other provisioning apps in your tenant.
- **Use a test app if you can't change the production app directly.** If there are organizational or change-management constraints that prevent you from modifying the production provisioning app directly, you can create a new SAP SuccessFactors provisioning app in your production tenant. Use that test app to validate end-to-end connectivity and targeted user flows with **Provision on demand** before applying the change to the production app.
- **Reuse the existing API user account.** When you configure the OIDC OAuth Client Application mapping in SAP SuccessFactors (Step 4), bind the SAP IAS Client ID to the same [SuccessFactors API user account](./configure-successfactors-api-user.md) that was previously used with basic authentication. This binding ensures that the role-based permissions governing which SuccessFactors Employee Central entities are accessible remain identical before and after the switch, so there are no unexpected changes in the data fetched by the provisioning job.
- **Use a recommended sequence if you have multiple SuccessFactors provisioning apps.** If your tenant has more than one SAP SuccessFactors provisioning app, upgrade them in the following order: (1) **SuccessFactors Writeback**, (2) **SuccessFactors to Microsoft Entra ID user provisioning**, and (3) **SuccessFactors to on-premises Active Directory user provisioning**. This sequence ensures that write-back operations are validated first before inbound provisioning flows are switched over.

> [!NOTE]
> Switching the authentication method doesn't trigger a full sync or restart the provisioning job. When making this change in a production environment, first select **Pause provisioning** to suspend the active sync cycles, then switch the authentication method to workload identity-based authentication, and then select **Start provisioning** to resume. When you pause provisioning, the existing sync state and watermarks are preserved. Incremental provisioning cycles continue from the point where they were paused after you start provisioning again.

## Configuration steps

The configuration is a one-time setup that spans three admin consoles. The Microsoft Entra admin center walks you through the flow as a guided experience and exchanges parameters with the SAP Cloud Identity Service admin console along the way. The high-level sequence is:

1. In **Microsoft Entra**, switch the SuccessFactors provisioning app's authentication method and create (or reuse) a workload identity application with a federated identity credential.
1. In the **SAP Cloud Identity Service admin console**, configure JWT Trust-by-Issuer using the token issuer, JWKS URI, subject, and audience values that Microsoft Entra provides.
1. Back in **Microsoft Entra**, paste the values returned by SAP Cloud Identity Service (including the app dependency name), run **Test connection**, and activate workload identity-based authentication.
1. In the **SAP SuccessFactors admin console**, confirm the OIDC OAuth client-to-technical-user mapping.
1. Validate by running provisioning on demand for a known user.

### Step 1: Open the SAP SuccessFactors provisioning app and switch the authentication method

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an **Application Administrator** of the tenant that hosts the SAP SuccessFactors provisioning app.
1. Open the **SAP SuccessFactors** provisioning app (the gallery app for inbound user provisioning or for write-back, depending on the integration you're upgrading).
1. Select **Provisioning** blade. In the **Overview** section, select **Pause provisioning** to suspend provisioning cycles until the upgrade is complete.
   > [!NOTE]
   > When you select **Pause provisioning**, the existing sync state and watermarks are preserved. After you switch the authentication method from basic authentication to workload identity, you can select **Start provisioning** and incremental provisioning cycles continue from the state where you paused provisioning.
1. Select **Provisioning** and locate the **Connectivity** section. While basic authentication remains active, you see the **Admin password** and **Tenant URL** fields and a banner indicating that SAP is deprecating basic authentication by **November 2026** and that you should upgrade to workload identity-based authentication before that date.
1. In the **Select authentication method** dropdown, select **Workload identity-based authentication** to start the guided configuration experience.
  :::image type="content" source="./media/configure-workload-identity-sap-successfactors-provisioning/switch-to-workload-identity-authentication.png" alt-text="Screenshot showing how to switch to workload identity-based authentication" lightbox="./media/configure-workload-identity-sap-successfactors-provisioning/switch-to-workload-identity-authentication.png":::

### Step 2: Create or select the workload identity application

The guided experience prompts you to register a workload identity application. This application is the identity that Microsoft Entra provisioning service impersonates when it requests AT1.

1. Select **Select workload identity**. In the side-panel, choose one of the following:
   - **Register** to let the guided experience create a fresh workload identity app registration. You can optionally rename the default **App registration name**.
   - **Select existing** if you already configured a workload identity application that talks to SAP Cloud Identity Service (for example, if you have multiple SAP SuccessFactors provisioning apps and you want to reuse an existing workload identity app).
     :::image type="content" source="./media/configure-workload-identity-sap-successfactors-provisioning/select-or-register-workload-identity-app.png" alt-text="Screenshot showing the register and select options." lightbox="./media/configure-workload-identity-sap-successfactors-provisioning/select-or-register-workload-identity-app.png":::
1. When you register a new workload identity app, the guided experience automatically creates a new app registration and attaches a **federated identity credential** to the workload identity application so the Microsoft Entra provisioning service (Sync Fabric) can impersonate the application running in your tenant and request the short-lived access token from SAP SuccessFactors.
   > [!TIP]
   > You can select the app registration link to open the app and inspect the federated identity credential on the workload identity application's **Certificates & secrets** > **Federated credentials** blade. Don't remove or rename it — Microsoft Entra provisioning service relies on this credential to acquire AT1 at runtime.
1. After you select the workload identity application, Microsoft Entra displays the values that SAP Cloud Identity Service needs to trust tokens issued by your tenant. Keep this panel open and switch to the SAP Cloud Identity Service admin console.
   
   :::image type="content" source="./media/configure-workload-identity-sap-successfactors-provisioning/workload-identity-setup-parameters.png" alt-text="Screenshot showing the workload identity setup parameters." lightbox="./media/configure-workload-identity-sap-successfactors-provisioning/workload-identity-setup-parameters.png":::

### Step 3: Copy the Microsoft Entra trust parameters into SAP Cloud Identity Service

1. Sign in as administrator to the **SAP Cloud Identity Service admin console** associated with your SAP SuccessFactors instance.
1. From the **Applications & Resources** menu, select **Applications** and select **Create** to create a new **OpenID Connect** application. 
   
   :::image type="content" source="./media/configure-workload-identity-sap-successfactors-provisioning/sap-ias-create-app.png" alt-text="Screenshot showing SAP IAS app creation options." lightbox="./media/configure-workload-identity-sap-successfactors-provisioning/sap-ias-create-app.png":::
2. In the **Trust** tab, under **Application APIs**, select **Dependencies**. Add a new dependency so that this app can consume the APIs of your SAP SuccessFactors. From the **Application** dropdown, select your SAP SuccessFactors instance and from the **API** dropdown select `sf_technical_access`. Note down the **Dependency name** because you use it in step 5.
   :::image type="content" source="./media/configure-workload-identity-sap-successfactors-provisioning/configure-successfactors-dependency.png" alt-text="Screenshot showing SAP IAS to SuccessFactors dependency configuration." lightbox="./media/configure-workload-identity-sap-successfactors-provisioning/configure-successfactors-dependency.png":::
3. In the **Trust** tab, under **Application APIs**, select **Client Authentication**. Go to the **JSON Web Tokens > Configure Trust By Issuer** section and select **Add** to configure SAP IAS to trust Microsoft Entra issued tokens. From the Microsoft Entra panel, copy the following values into the corresponding fields in SAP Cloud Identity Service:

   | Microsoft Entra field | SAP Cloud Identity Service field |
   | --- | --- |
   | **Token issuer** | Issuer |
   | **JWKS URI** | JSON Web Key Set URI |
   | **Subject** | Subject |
   | **Audience** | Audience |

   :::image type="content" source="./media/configure-workload-identity-sap-successfactors-provisioning/configure-json-web-token-issuer-trust.png" alt-text="Screenshot showing which values to copy from Microsoft Entra provisioning app to SAP IAS app" lightbox="./media/configure-workload-identity-sap-successfactors-provisioning/configure-json-web-token-issuer-trust.png":::
4. Save the trust configuration in SAP Cloud Identity Service. The configured trust enables SAP Cloud Identity Service to validate AT1 — verify the signature against the JWKS URI and confirm the subject and audience match — and issue AT2 (the SAP IAS access token with the `sf_technical_access` scope).

### Step 4: Configure OIDC OAuth Client Application mapping in SAP SuccessFactors

The SAP IAS client ID that's now part of the trust configuration must be mapped to a SAP SuccessFactors **technical/API user** that has role-based permission to read the SuccessFactors entities used by the provisioning job.

> [!NOTE]
> If you're configuring a SAP SuccessFactors provisioning app for the first time in your Microsoft Entra tenant and there are no SAP SuccessFactors provisioning apps using basic authentication, see [Configure SuccessFactors API user account](./configure-successfactors-api-user.md) to first configure an API user in SAP SuccessFactors and then follow the steps provided here.

1. Sign in to the **SAP SuccessFactors** admin console.
1. Go to **Admin Center > Security Center > Manage OIDC OAuth Client Application**.
1. Open the **Application Type** tab and select **Register** to register `Entra-Provisioning` as a new application type.
    :::image type="content" source="./media/configure-workload-identity-sap-successfactors-provisioning/register-new-app-type-in-successfactors.png" alt-text="Screenshot showing registering new application type in SAP SuccessFactors" lightbox="./media/configure-workload-identity-sap-successfactors-provisioning/register-new-app-type-in-successfactors.png":::
1. Open the **Application Map** tab and select **Register** to bind the SAP IAS `Client ID` from step 3 to an existing technical/API user in SAP SuccessFactors.
    :::image type="content" source="./media/configure-workload-identity-sap-successfactors-provisioning/sap-ias-to-successfactors-oidc-mapping.png" alt-text="Screenshot showing how to map SAP IAS client id to SuccessFactors technical/API user" lightbox="./media/configure-workload-identity-sap-successfactors-provisioning/sap-ias-to-successfactors-oidc-mapping.png":::
1. In the mapping, ensure that:
   - **Client ID** matches the SAP IAS client ID from the trust configuration in Step 3.
   - **User ID** is the SuccessFactors API user (for example, `entra.sap.admin`) whose **role-based permission group** grants OData API access to the Employee Central entities your provisioning job consumes. If you're switching from basic authentication to workload identity-based authentication, you can map the **Client ID** to the same API user that you configured for use with basic authentication.

### Step 5: Copy the SAP Cloud Identity Service parameters back into Microsoft Entra

SAP Cloud Identity Service generates one or more values that Microsoft Entra needs to complete the configuration — most notably the **Client ID** and **App dependency name** that ties the trust configuration to the SAP SuccessFactors OData endpoint.

1. In the SAP Cloud Identity Service admin console, open the OIDC application configured in Step 3. Go to **Trust > Dependencies** panel and copy the **Dependency Name**. Prepend the string `urn:sap:identity:application:provider:name:`. For example: if your **Dependency Name** is `SF-EC-TA`, then set the value of **App Dependency Name** in your SuccessFactors provisioning app to `urn:sap:identity:application:provider:name:SF-EC-TA`.
1. Copy your SAP IAS OIDC application's **Client ID** to the **Client identifier** parameter.
1. Set the `OAuth token endpoint` parameter to your SAP IAS authorization server's token endpoint. Example: `https://<ias-server>.accounts.ondemand.com/oauth2/token`
1. Set the `Application API URL` parameter to your [SAP SuccessFactors OData API server](https://help.sap.com/docs/successfactors-platform/sap-successfactors-api-reference-guide-odata-v2/list-of-sap-successfactors-api-servers). Example: `https://apisalesdemo8.successfactors.com`.
1. After you fill in all connectivity parameters, your configuration matches the layout shown in this screenshot.
    :::image type="content" source="./media/sap-successfactors-workload-identity/workload-identity-all-parameters-configured.png" alt-text="Screenshot showing all workload identity connectivity parameters configured" lightbox="./media/sap-successfactors-workload-identity/workload-identity-all-parameters-configured.png":::

### Step 6: Test the connection and activate workload identity-based authentication

Back in the Microsoft Entra admin center, validate the end-to-end token exchange and activate the new method.

1. In the workload identity configuration panel, select **Test connection**. Microsoft Entra performs the full runtime flow — acquire AT1 from the federated identity credential, exchange it for AT2 at SAP Cloud Identity Service, and call the SAP SuccessFactors OData API.
1. Confirm that the test connection returns **successful**. If it fails, see the [Troubleshooting](#troubleshooting) section.
1. Select **Save and activate**. Workload identity-based authentication becomes the active method for the SuccessFactors provisioning app.
    :::image type="content" source="./media/configure-workload-identity-sap-successfactors-provisioning/workload-identity-as-active-auth-method.png" alt-text="Screenshot showing workload identity as the active authentication method." lightbox="./media/configure-workload-identity-sap-successfactors-provisioning/workload-identity-as-active-auth-method.png":::

> [!NOTE]
> Until November 2026, you can switch back to basic authentication at any time from the same **Authentication method** dropdown. After SAP retires basic authentication, only workload identity-based authentication is available.

### Step 7: Validate provisioning end-to-end

Before turning provisioning on at full scale, validate the upgraded configuration with a small group of test users.

1. From the SuccessFactors provisioning app, select **Overview**.
1. Run **Provision on demand** for a known user, or scope provisioning to a small test population using a provisioning scope filter.
1. Validate full sync and incremental sync cycle in a test or nonproduction environment before enabling it in production.

## Use logs to verify the configuration

After you complete the steps, use service logs to troubleshoot and verify the setup:

- **Microsoft Entra sign-in logs** — You can view sign-in events associated with the workload identity app in the Microsoft Entra admin portal under **Monitoring & health > Sign-in logs** in the **Service principal sign-ins** tab. You can filter by **Client credential type** == "Federated identity credential".
    :::image type="content" source="./media/configure-workload-identity-sap-successfactors-provisioning/service-principal-sign-in-events.png" alt-text="Screenshot showing Microsoft Entra sign-in event logs of federated identity credential type." lightbox="./media/configure-workload-identity-sap-successfactors-provisioning/service-principal-sign-in-events.png":::
- **SAP Cloud Identity Service troubleshooting logs** — In the SAP Cloud Identity Service admin portal access **Monitoring & reporting > Troubleshooting logs** to view actions of type `login` and `issueJwtToken` for the SAP IAS client identifier configured in Microsoft Entra.
    :::image type="content" source="./media/configure-workload-identity-sap-successfactors-provisioning/sap-ias-troubleshooting-logs.png" alt-text="Screenshot showing SAP Cloud Identity Service troubleshooting logs." lightbox="./media/configure-workload-identity-sap-successfactors-provisioning/sap-ias-troubleshooting-logs.png":::
- **SAP SuccessFactors OData audit logs** — In the SAP SuccessFactors Admin center, access the **OData API Audit Log** and filter by the API User Login ID, to retrieve API call records.
    :::image type="content" source="./media/configure-workload-identity-sap-successfactors-provisioning/successfactors-odata-api-audit-log.png" alt-text="Screenshot showing the SAP SuccessFactors OData API audit log." lightbox="./media/configure-workload-identity-sap-successfactors-provisioning/successfactors-odata-api-audit-log.png":::
  You can observe that before the change, the **HTTP Message** column in the logs had the string `authorization: Basic **********`. After switching to workload identity-based authentication, the **HTTP Message** column in the logs displays the string `authorization: Bearer **********`.

## Roll back

If you need to roll back, you can re-enable basic authentication in the SuccessFactors provisioning app's admin credentials. Rollback is supported only until the basic authentication deprecation date of November 20, 2026 announced by SAP.

## Troubleshooting

| Symptom | Likely cause | Action |
| --- | --- | --- |
| `invalid_client_assertion` from SAP IAS | AT1 subject or audience doesn't match the SAP IAS Trust-by-Issuer rule. | Verify the `sub` and `aud` values configured on the federated identity credential against the trust rule in SAP IAS. |
| `unauthorized_client` from SAP IAS | JWKS URI is unreachable or signature validation failed. | Confirm the Microsoft Entra OIDC discovery endpoint is reachable from SAP IAS and that the tenant ID in the issuer claim matches. |
| OData call returns 403 | SAP IAS client ID is not mapped to the right API User ID, or the API user lacks appropriate role-based permissions. | Re-verify the OIDC OAuth client mapping in SAP SuccessFactors and the permission group on the API user. |

## Contact support

If the troubleshooting steps don't resolve your issue and you still need help, open a support request from the Microsoft Entra admin center:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).
2. Select **New support request**.
3. Fill in the support request form using the following values:

   | Field | Value |
   | --- | --- |
   | **Service type** | Microsoft Entra User Provisioning and Synchronization |
   | **Summary** | SuccessFactors provisioning - Workload identity authentication issue |
   | **Problem type** | Provisioning from Cloud HR to AD or Microsoft Entra ID |
   | **Problem subtype** | Problem configuring the provisioning service |
4. Complete the remaining fields and submit the request.

## Related content

- [Microsoft Entra ID and SAP SuccessFactors integration reference](sap-successfactors-integration-reference.md)
- [Workload identity federation in Microsoft Entra ID](../../workload-id/workload-identity-federation.md)
- [Federated identity credentials](../../workload-id/workload-identity-federation-create-trust.md)
