---
title: Configure workload identity for SAP SuccessFactors provisioning
description: Learn how to replace basic authentication with short-lived, federated OpenID Connect tokens for Microsoft Entra provisioning to SAP SuccessFactors.
manager: pmwongera
ms.service: entra-id
ms.subservice: app-provisioning
ms.topic: how-to
ms.date: 09/10/2026
ms.reviewer: cmmdesai
ms.custom: sap-successfactors, workload-identity, provisioning, msecd-doc-authoring-1026
ai-usage: ai-assisted
#customer intent: As an administrator, I want to configure workload identity-based authentication for SAP SuccessFactors provisioning so that I can replace long-lived basic authentication credentials with short-lived tokens.
---

# Configure workload identity-based authentication for SAP SuccessFactors provisioning (Preview)

This article is for administrators who configure Microsoft Entra provisioning integrations with SAP SuccessFactors. It explains how to replace the provisioning service's long-lived basic authentication credential with short-lived OpenID Connect (OIDC) tokens issued by your Microsoft Entra tenant. SAP Cloud Identity Services (SAP IAS) validates these tokens and exchanges them for access tokens used to call SAP SuccessFactors APIs. Before you begin, make sure you have a configured SAP SuccessFactors provisioning app and access to Microsoft Entra, SAP IAS, and SAP SuccessFactors administration.

> [!NOTE]
> We make public previews available to our customers under the terms applicable to previews. These terms are outlined in the overall Microsoft product terms for [online services](https://www.microsoft.com/licensing/terms/product/ForOnlineServices/all).

Workload identity-based authentication provides a more secure authentication model in preparation for SAP's plan to [deprecate basic authentication for SuccessFactors APIs](https://help.sap.com/docs/successfactors-release-information/8e0d540f96474717bbf18df51e54e522/fcc05a902b4140e585d968c2fe4a96bc.html).

This article applies to the following provisioning integrations:

- SuccessFactors to on-premises Active Directory user provisioning
- SuccessFactors to Microsoft Entra ID user provisioning
- SuccessFactors Writeback

## Prerequisites

Before you start, make sure that you have the following in place:

- **SAP SuccessFactors provisioning app** configured from the Microsoft Entra enterprise application gallery.
- **SAP Cloud Identity Services (SAP IAS)** available and [configured as the authentication service for SAP SuccessFactors](https://help.sap.com/docs/successfactors-platform/setting-up-sap-successfactors-with-identity-authentication-and-identity-provisioning-services/checking-to-see-if-you-aready-have-identity-authentication-enabled).
- The [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator) role in Microsoft Entra ID to register or select a workload identity application and update the authentication method for your SuccessFactors provisioning app.
- Access in the SAP Cloud Identity Services admin console that permits you to create an OpenID Connect application, add an application API dependency, and configure **JWT Trust-by-Issuer** client authentication.
- Access in the SAP SuccessFactors admin console that permits you to manage OIDC OAuth client applications and map a client to a technical/API user with the required role-based permissions.

## Why workload identity-based authentication

Workload identity-based authentication strengthens your security posture by removing static credentials and replacing them with tokens that expire in minutes rather than never.

| Benefit | What changes |
| --- | --- |
| **No static credentials** | Stored passwords and long-lived secrets are replaced with OIDC-issued tokens that expire in minutes. |
| **Federated by design** | SAP IAS validates Microsoft Entra-issued tokens through tenant-specific OIDC trust rules that you control. |
| **Least-privilege access** | The short-lived access token is scoped to the SAP SuccessFactors Open Data Protocol (OData) API and bound to a role-based technical/API user. |
| **Fully revocable** | You can revoke the trust by removing or disabling the Trust-by-Issuer configuration in SAP IAS without rotating shared secrets. |

## How the flow works

Microsoft Entra provisioning service authenticates to SAP SuccessFactors through SAP IAS. Microsoft Entra issues a short-lived OIDC token that identifies the tenant-local SyncFabric service principal and is scoped to the customer workload identity application. SAP IAS validates this token and exchanges it for an access token used with SAP SuccessFactors. The flow has three steps:

> [!NOTE]
> In this article, **SyncFabric** refers to the Microsoft Entra provisioning service. The **SyncFabric Workload Identity ISV Integration Client** service principal represents this service as the subject (`sub`) of the Microsoft Entra-issued JSON Web Token (JWT). AT1 also includes the authorized party (`azp`) claim set to the application (client) ID of the **SyncFabric Workload Identity ISV Integration Client**.

1. **The provisioning service obtains a signed JWT.** Microsoft Entra issues a JWT in which the issuer (`iss`) identifies your tenant, the subject (`sub`) identifies the tenant-local SyncFabric first-party service principal, and the audience (`aud`) identifies the customer workload identity application.
1. **SAP IAS exchanges the JWT for an access token.** The signed JWT is presented to SAP IAS, which is trusted by SAP SuccessFactors. SAP IAS validates the token signature, issuer, subject, and audience against the Trust-by-Issuer configuration and returns a short-lived access token that can only be used to query the SAP SuccessFactors OData API.
1. **The provisioning service calls the OData API.** Microsoft Entra provisioning service uses the short-lived access token to query the SAP SuccessFactors OData API. The access token includes a client ID that's mapped to a technical/API user in SAP SuccessFactors with role-based permission to access SAP SuccessFactors entities.

:::image type="content" source="./media/configure-workload-identity-sap-successfactors-provisioning/entra-sap-workload-identity-detailed-flow.png" alt-text="Diagram of OIDC token acquisition, SAP IAS token exchange, and SAP SuccessFactors OData API access." lightbox="./media/configure-workload-identity-sap-successfactors-provisioning/entra-sap-workload-identity-detailed-flow.png":::

### Token exchange sequence diagram

The runtime exchange involves three cloud services (Microsoft Entra ID, SAP IAS and SAP SuccessFactors) and two access tokens (AT):

- **AT1** — A JWT issued by Microsoft Entra ID. The token is bound to the SyncFabric first-party service principal and scoped to the customer workload identity application.
- **AT2** — A short-lived access token issued by SAP IAS after it validates AT1 through Trust-by-Issuer.

The following swim-lane shows who calls whom, in order, at runtime.

:::image type="content" source="./media/configure-workload-identity-sap-successfactors-provisioning/token-exchange-sequence-diagram.png" alt-text="Sequence diagram of token exchange between Microsoft Entra provisioning, SAP IAS, and SAP SuccessFactors." lightbox="./media/configure-workload-identity-sap-successfactors-provisioning/token-exchange-sequence-diagram.png":::

### Token claim reference

| Token | Claim | Value |
| --- | --- | --- |
| **AT1** (Microsoft Entra–issued JWT) | `sub` | Object ID of the **SyncFabric Workload Identity ISV Integration Client** service principal |
| | `aud` | Application (client) ID of the customer workload identity application |
| | `iss` | `https://login.microsoftonline.com/<tenantId>/v2.0` |
| | `azp` | Application (client) ID of the **SyncFabric Workload Identity ISV Integration Client** |
| **AT2** (SAP IAS access token) | `sub` | `<sap-ias-app-client-id>` |
| | `iss` | `https://<sap-ias-server>` |
| | `ias_apis` | `sf_technical_access` |
| | `client_assertion_type` | `urn:ietf:params:oauth:client-assertion-type:jwt-bearer` |

## Planning the upgrade

Switching to workload identity-based authentication involves coordination across three admin teams — the teams that administer Microsoft Entra, SAP Cloud Identity Services, and SAP SuccessFactors. Share this article with all relevant stakeholders before you begin so that everyone has a clear understanding of the end-to-end flow.

Consider the following approach:

- **Coordinate across teams.** Set up a working session with representation from each service team (Microsoft Entra, SAP IAS, and SAP SuccessFactors administration) so that all required configuration steps can be completed without waiting for handoffs.
- **Test in a nonproduction environment first.** Complete the end-to-end configuration in a quality assurance (QA) or development environment before applying the change in production. This approach lets you validate the token exchange flow and provisioning behavior with no risk to production users.
- **Replicate after the first app is validated.** After your team is comfortable with the process for one SuccessFactors provisioning app, you can apply the same steps quickly to other provisioning apps in your tenant.
- **Use a test app if you can't change the production app directly.** If there are organizational or change-management constraints that prevent you from modifying the production provisioning app directly, you can create a new SAP SuccessFactors provisioning app in your production tenant. Use that test app to validate end-to-end connectivity and targeted user flows with **Provision on demand** before applying the change to the production app.
- **Reuse the existing API user account.** When you configure the OIDC OAuth Client Application mapping in SAP SuccessFactors, bind the SAP IAS Client ID to the same [SuccessFactors API user account](./configure-successfactors-api-user.md) that was previously used with basic authentication. This binding ensures that the role-based permissions governing which SuccessFactors Employee Central entities are accessible remain identical before and after the switch, so there are no unexpected changes in the data fetched by the provisioning job.
- **Use a recommended sequence if you have multiple SuccessFactors provisioning apps.** If your tenant has more than one SAP SuccessFactors provisioning app, upgrade them in the following order: (1) **SuccessFactors Writeback**, (2) **SuccessFactors to Microsoft Entra ID user provisioning**, and (3) **SuccessFactors to on-premises Active Directory user provisioning**. This sequence ensures that write-back operations are validated first before inbound provisioning flows are switched over.

> [!NOTE]
> Switching the authentication method doesn't trigger a full sync or restart the provisioning job. When making this change in a production environment, first select **Pause provisioning** to suspend the active sync cycles, then switch the authentication method to workload identity-based authentication, and then select **Start provisioning** to resume. When you pause provisioning, the existing sync state and watermarks are preserved. Incremental provisioning cycles continue from the point where they were paused after you start provisioning again.

## Configuration steps

The configuration is a one-time setup that spans three admin consoles. The Microsoft Entra admin center walks you through the flow as a guided experience and exchanges parameters with the SAP Cloud Identity Services admin console along the way. The high-level sequence is:

1. In **Microsoft Entra**, switch the SuccessFactors provisioning app's authentication method and create or reuse a workload identity application.
1. In the **SAP Cloud Identity Services admin console**, configure JWT Trust-by-Issuer using the token issuer, JSON Web Key Set (JWKS) URI, subject, and audience values that Microsoft Entra provides.
1. Back in **Microsoft Entra**, paste the values returned by SAP Cloud Identity Services (including the app dependency name), run **Test connection**, and activate workload identity-based authentication.
1. In the **SAP SuccessFactors admin console**, confirm the OIDC OAuth client-to-technical-user mapping.
1. Validate by running provisioning on demand for a known user.

### Step 1: Open the SAP SuccessFactors provisioning app and switch the authentication method

Use the guided experience to pause provisioning and select workload identity-based authentication:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an **Application Administrator** of the tenant that hosts the SAP SuccessFactors provisioning app.
1. Open the **SAP SuccessFactors** provisioning app (the gallery app for inbound user provisioning or for write-back, depending on the integration you're upgrading).
1. Select the **Provisioning** blade. In the **Overview** section, select **Pause provisioning** to suspend provisioning cycles until the upgrade is complete.
   > [!NOTE]
   > When you select **Pause provisioning**, the existing sync state and watermarks are preserved. After you switch the authentication method from basic authentication to workload identity, you can select **Start provisioning** and incremental provisioning cycles continue from the state where you paused provisioning.
1. Select **Provisioning** and locate the **Connectivity** section. While basic authentication remains active, you see the **Admin password** and **Tenant URL** fields and a banner recommending that you upgrade to workload identity-based authentication.
1. In the **Select authentication method** list, select **Workload identity-based authentication** to start the guided configuration experience.
    :::image type="content" source="./media/configure-workload-identity-sap-successfactors-provisioning/switch-to-workload-identity-authentication.png" alt-text="Screenshot showing how to switch to workload identity-based authentication." lightbox="./media/configure-workload-identity-sap-successfactors-provisioning/switch-to-workload-identity-authentication.png":::

### Step 2: Create or select the workload identity application

The guided experience prompts you to register or select a workload identity application. The application's client ID is used as the audience (`aud`) of AT1 and scopes the trust that you configure in SAP IAS.

1. Select **Select workload identity**. In the side-panel, choose one of the following:
    - **Register** to let the guided experience create a fresh workload identity app registration. You can optionally rename the default **App registration name**.
    - **Select existing** if you already configured a workload identity application that talks to SAP Cloud Identity Services (for example, if you have multiple SAP SuccessFactors provisioning apps and you want to reuse an existing workload identity app).
      :::image type="content" source="./media/configure-workload-identity-sap-successfactors-provisioning/select-or-register-workload-identity-app.png" alt-text="Screenshot showing the register and select options." lightbox="./media/configure-workload-identity-sap-successfactors-provisioning/select-or-register-workload-identity-app.png":::
1. When you select **Register**, the guided experience creates the workload identity app registration in your tenant.

    > [!NOTE]
    > The first time you configure workload identity-based authentication, the integration automatically creates the Microsoft first-party service principal **SyncFabric Workload Identity ISV Integration Client** in your tenant. Its object ID, which is unique to your tenant, is used as the `sub` claim in the Microsoft Entra-issued JWT sent to SAP IAS. The workload identity application's client ID is used separately as the JWT `aud` claim.

1. After you select the workload identity application, Microsoft Entra displays the values that SAP Cloud Identity Services needs to trust tokens issued by your tenant. Keep this panel open and switch to the SAP Cloud Identity Services admin console.
   
   :::image type="content" source="./media/configure-workload-identity-sap-successfactors-provisioning/workload-identity-setup-parameters.png" alt-text="Screenshot showing the workload identity setup parameters." lightbox="./media/configure-workload-identity-sap-successfactors-provisioning/workload-identity-setup-parameters.png":::

<a name='step-3-copy-the-microsoft-entra-trust-parameters-into-sap-cloud-identity-service'></a>

### Step 3: Copy the Microsoft Entra trust parameters into SAP Cloud Identity Services

Create an OIDC application and copy the Microsoft Entra trust parameters into SAP Cloud Identity Services:

1. Sign in as administrator to the **SAP Cloud Identity Services admin console** associated with your SAP SuccessFactors instance.
1. From the **Applications & Resources** menu, select **Applications** and select **Create** to create a new **OpenID Connect** application. 
   
   :::image type="content" source="./media/configure-workload-identity-sap-successfactors-provisioning/sap-ias-create-app.png" alt-text="Screenshot showing SAP IAS app creation options." lightbox="./media/configure-workload-identity-sap-successfactors-provisioning/sap-ias-create-app.png":::
1. In the **Trust** tab, under **Application APIs**, select **Dependencies**. Add a new dependency so that this app can consume the APIs of your SAP SuccessFactors. From the **Application** list, select your SAP SuccessFactors instance, and from the **API** list, select `sf_technical_access`. Record the **Dependency name** to use when you copy the SAP Cloud Identity Services parameters back into Microsoft Entra.
   :::image type="content" source="./media/configure-workload-identity-sap-successfactors-provisioning/configure-successfactors-dependency.png" alt-text="Screenshot showing SAP IAS to SuccessFactors dependency configuration." lightbox="./media/configure-workload-identity-sap-successfactors-provisioning/configure-successfactors-dependency.png":::
1. In the **Trust** tab, under **Application APIs**, select **Client Authentication**. Go to the **JSON Web Tokens > Configure Trust By Issuer** section and select **Add** to configure SAP IAS to trust Microsoft Entra-issued tokens. From the Microsoft Entra panel, copy the following values into the corresponding fields in SAP Cloud Identity Services:

    | Microsoft Entra field | SAP Cloud Identity Services field |
    | --- | --- |
    | **Token issuer** | Issuer |
    | **JWKS URI** | JSON Web Key Set URI |
    | **Subject** | Subject |
    | **Audience** | Audience |

   :::image type="content" source="./media/configure-workload-identity-sap-successfactors-provisioning/configure-json-web-token-issuer-trust.png" alt-text="Screenshot showing which values to copy from Microsoft Entra provisioning app to SAP IAS app." lightbox="./media/configure-workload-identity-sap-successfactors-provisioning/configure-json-web-token-issuer-trust.png":::
1. Save the trust configuration in SAP Cloud Identity Services. The configured trust enables SAP IAS to validate the signature, issuer, subject, and audience of AT1 and issue AT2 (the SAP IAS access token with the `sf_technical_access` scope).

### Step 4: Configure OIDC OAuth Client Application mapping in SAP SuccessFactors

The SAP IAS client ID that's now part of the trust configuration must be mapped to a SAP SuccessFactors **technical/API user** that has role-based permission to read the SuccessFactors entities used by the provisioning job.

> [!NOTE]
> If you're configuring a SAP SuccessFactors provisioning app for the first time in your Microsoft Entra tenant and there are no SAP SuccessFactors provisioning apps using basic authentication, see [Configure SuccessFactors API user account](./configure-successfactors-api-user.md) to first configure an API user in SAP SuccessFactors and then follow the steps provided here.

1. Sign in to the **SAP SuccessFactors** admin console.
1. Go to **Admin Center > Security Center > Manage OIDC OAuth Client Application**.
1. Open the **Application Type** tab and select **Register** to register `Entra-Provisioning` as a new application type.
    :::image type="content" source="./media/configure-workload-identity-sap-successfactors-provisioning/register-new-app-type-in-successfactors.png" alt-text="Screenshot showing registering new application type in SAP SuccessFactors." lightbox="./media/configure-workload-identity-sap-successfactors-provisioning/register-new-app-type-in-successfactors.png":::
1. Open the **Application Map** tab and select **Register** to bind the SAP IAS `Client ID` from the SAP Cloud Identity Services trust configuration to an existing technical/API user in SAP SuccessFactors.
    :::image type="content" source="./media/configure-workload-identity-sap-successfactors-provisioning/sap-ias-to-successfactors-oidc-mapping.png" alt-text="Screenshot showing how to map an SAP IAS client ID to a SuccessFactors technical/API user." lightbox="./media/configure-workload-identity-sap-successfactors-provisioning/sap-ias-to-successfactors-oidc-mapping.png":::
1. In the mapping, ensure that:
    - **Client ID** matches the SAP IAS client ID from the SAP Cloud Identity Services trust configuration.
    - **User ID** is the SuccessFactors API user (for example, `entra.sap.admin`) whose **role-based permission group** grants OData API access to the Employee Central entities your provisioning job consumes. If you're switching from basic authentication to workload identity-based authentication, you can map the **Client ID** to the same API user that you configured for use with basic authentication.

<a name='step-5-copy-the-sap-cloud-identity-service-parameters-back-into-microsoft-entra'></a>

### Step 5: Copy the SAP Cloud Identity Services parameters back into Microsoft Entra

SAP Cloud Identity Services generates one or more values that Microsoft Entra needs to complete the configuration — most notably the **Client ID** and **App dependency name** that ties the trust configuration to the SAP SuccessFactors OData endpoint.

1. In the SAP Cloud Identity Services admin console, open the OIDC application where you configured the Microsoft Entra trust parameters. Go to the **Trust > Dependencies** panel and copy the **Dependency Name**. Prepend the string `urn:sap:identity:application:provider:name:`. For example: if your **Dependency Name** is `SF-EC-TA`, then set the value of **App Dependency Name** in your SuccessFactors provisioning app to `urn:sap:identity:application:provider:name:SF-EC-TA`.
1. Copy your SAP IAS OIDC application's **Client ID** to the **Client identifier** parameter.
1. Set the `OAuth token endpoint` parameter to your SAP IAS authorization server's token endpoint. Example: `https://<ias-server>.accounts.ondemand.com/oauth2/token`
1. Set the `Application API URL` parameter to your [SAP SuccessFactors OData API server](https://help.sap.com/docs/successfactors-platform/sap-successfactors-api-reference-guide-odata-v2/list-of-sap-successfactors-api-servers). Example: `https://apisalesdemo8.successfactors.com`.
1. After you fill in all connectivity parameters, your configuration matches the layout shown in this screenshot.
    :::image type="content" source="./media/configure-workload-identity-sap-successfactors-provisioning/workload-identity-all-parameters-configured.png" alt-text="Screenshot showing all workload identity connectivity parameters configured." lightbox="./media/configure-workload-identity-sap-successfactors-provisioning/workload-identity-all-parameters-configured.png":::

### Step 6: Test the connection and activate workload identity-based authentication

Back in the Microsoft Entra admin center, validate the end-to-end token exchange and activate the new method.

1. In the workload identity configuration panel, select **Test connection**. Microsoft Entra performs the full runtime flow: obtain an AT1 token bound to the SyncFabric service principal and scoped to the customer workload identity application, exchange it for AT2 at SAP IAS, and call the SAP SuccessFactors OData API.
1. Confirm that the test connection returns **successful**. If it fails, see the [Troubleshooting](#troubleshooting) section.
1. Select **Save and activate**. Workload identity-based authentication becomes the active method for the SuccessFactors provisioning app.
    :::image type="content" source="./media/configure-workload-identity-sap-successfactors-provisioning/workload-identity-as-active-auth-method.png" alt-text="Screenshot showing workload identity as the active authentication method." lightbox="./media/configure-workload-identity-sap-successfactors-provisioning/workload-identity-as-active-auth-method.png":::

> [!NOTE]
> While SAP supports basic authentication, you can switch back to it at any time from the same **Authentication method** dropdown. Use workload identity-based authentication whenever possible because it is more secure and doesn't require storing long-lived credentials.

### Step 7: Validate provisioning end-to-end

Before turning provisioning on at full scale, validate the upgraded configuration with a small group of test users.

1. From the SuccessFactors provisioning app, select **Overview**.
1. Run **Provision on demand** for a known user, or scope provisioning to a small test population using a provisioning scope filter.
1. Validate full sync and incremental sync cycle in a test or nonproduction environment before enabling it in production.

## Use logs to verify the configuration

After you complete the steps, use service logs to troubleshoot and verify the setup:

- **SAP Cloud Identity Services troubleshooting logs** — In the SAP Cloud Identity Services admin portal, access **Monitoring & reporting > Troubleshooting logs** to view actions of type `login` and `issueJwtToken`. Search the logs by using the client ID of the SAP IAS application associated with the integration.
    :::image type="content" source="./media/configure-workload-identity-sap-successfactors-provisioning/sap-ias-troubleshooting-logs.png" alt-text="Screenshot showing SAP Cloud Identity Services troubleshooting logs." lightbox="./media/configure-workload-identity-sap-successfactors-provisioning/sap-ias-troubleshooting-logs.png":::
- **SAP SuccessFactors OData audit logs** — In the SAP SuccessFactors Admin center, access the **OData API Audit Log** and filter by the API User Login ID, to retrieve API call records.
    :::image type="content" source="./media/configure-workload-identity-sap-successfactors-provisioning/successfactors-odata-api-audit-log.png" alt-text="Screenshot showing the SAP SuccessFactors OData API audit log." lightbox="./media/configure-workload-identity-sap-successfactors-provisioning/successfactors-odata-api-audit-log.png":::
  You can observe that before the change, the **HTTP Message** column in the logs had the string `authorization: Basic **********`. After switching to workload identity-based authentication, the **HTTP Message** column in the logs displays the string `authorization: Bearer **********`.

## Roll back

If you need to roll back while SAP supports basic authentication, you can re-enable it in the SuccessFactors provisioning app's admin credentials. Use workload identity-based authentication whenever possible because it is more secure and doesn't require storing long-lived credentials.

## Troubleshooting

| Symptom | Likely cause | Action |
| --- | --- | --- |
| `invalid_client_assertion` from SAP IAS | AT1 subject or audience doesn't match the SAP IAS Trust-by-Issuer rule. | Compare the **Subject** and **Audience** values provided by Microsoft Entra with the corresponding values in the SAP IAS trust rule. |
| `unauthorized_client` from SAP IAS | JWKS URI is unreachable or signature validation failed. | Confirm the Microsoft Entra OIDC discovery endpoint is reachable from SAP IAS and that the tenant ID in the issuer claim matches. |
| OData call returns 403 | SAP IAS client ID is not mapped to the right API User ID, or the API user lacks appropriate role-based permissions. | Re-verify the OIDC OAuth client mapping in SAP SuccessFactors and the permission group on the API user. |

## Contact support

If the troubleshooting steps don't resolve your issue and you still need help, open a support request from the Microsoft Entra admin center:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).
1. Select **New support request**.
1. Fill in the support request form using the following values:

   | Field | Value |
   | --- | --- |
   | **Service type** | Microsoft Entra User Provisioning and Synchronization |
   | **Summary** | SuccessFactors provisioning - Workload identity authentication issue |
   | **Problem type** | Provisioning from Cloud HR to AD or Microsoft Entra ID |
   | **Problem subtype** | Problem configuring the provisioning service |

1. Complete the remaining fields and submit the request.

## Related content

- [Microsoft Entra ID and SAP SuccessFactors integration reference](sap-successfactors-integration-reference.md)
- [Workload identity federation in Microsoft Entra ID](../../workload-id/workload-identity-federation.md)
