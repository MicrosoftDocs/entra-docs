---
title: Federate a SPIFFE/SPIRE workload identity
description: Configure workload identity federation so a SPIFFE/SPIRE workload can exchange its JWT-SVID for a Microsoft Entra token and reach Azure resources without secrets.
ms.topic: tutorial
ms.date: 08/12/2026
ms.reviewer: hosamsh
ms.custom: aaddev
ai-usage: ai-assisted
#Customer intent: As a platform engineer, I want to federate a SPIFFE/SPIRE workload identity with Microsoft Entra ID so that my Kubernetes workloads can access Microsoft Entra protected resources without storing secrets.
---

# Tutorial: Federate a SPIFFE/SPIRE workload identity with Microsoft Entra ID

SPIFFE (Secure Production Identity Framework for Everyone) is a set of open-source standards that give software workloads a platform-agnostic identity, called a SPIFFE ID. A workload proves that identity by presenting a short-lived credential called an SVID. SPIRE is the reference implementation of the SPIFFE standards.

A workload that runs outside Azure normally authenticates with a stored secret or certificate that you must protect and rotate, and that can cause an outage if it expires before you replace it. Workload identity federation removes that stored credential: instead of holding a secret, the workload presents its existing SPIFFE identity and exchanges it for a Microsoft Entra token.

In this tutorial, you set up SPIRE in a Kubernetes cluster, give a sample workload a SPIFFE ID, and federate that identity with Microsoft Entra ID. After the trust relationship is in place, the workload exchanges its SPIFFE JWT-SVID for a Microsoft Entra access token and calls an Azure resource, such as Azure Blob Storage, without storing any secrets or certificates.

The tutorial has four sequential parts that build to one completed scenario. Each part depends on the output of the part before it.

In this tutorial, you:

> [!div class="checklist"]
> * Deploy SPIRE with JWT-SVID and OIDC discovery support in a Kubernetes cluster.
> * Deploy a sample workload and assign it a SPIFFE ID.
> * Configure a Microsoft Entra application to trust the SPIFFE ID.
> * Exchange a SPIFFE JWT-SVID for a Microsoft Entra access token and access an Azure resource.

The following diagram shows the workload identity federation flow: a workload gets a token from an external identity provider, exchanges it with the Microsoft identity platform for an access token, and uses that access token to reach an Azure resource. In this tutorial, the external identity provider is SPIRE and the token is a SPIFFE JWT-SVID.

:::image type="content" source="media/workload-identity-federation/workflow.svg" alt-text="Diagram of the workload identity federation flow: a workload exchanges an external token with Microsoft identity platform for Azure access." border="false":::

## Prerequisites

- A Microsoft Entra tenant and an Azure subscription. If you don't have an Azure subscription, create a [free account](https://azure.microsoft.com/pricing/purchase-options/azure-account?cid=msft_learn) before you begin.
- A Kubernetes cluster that can host the SPIRE server, the SPIRE agents, and the OIDC discovery provider. The cluster must expose a service through an external IP address.
- A registered domain name that you control for the OIDC discovery endpoint, and the ability to manage its DNS records. This tutorial uses the placeholder `oidc.contoso.com` for the OIDC discovery domain.
- A container registry to hold your sample workload image. This tutorial uses the placeholder `<your-registry>` for the registry name.
- The `kubectl`, `docker`, and Azure CLI (`az`) command-line tools installed and configured to reach your cluster, registry, and tenant.
- Permission to add a federated identity credential to an app registration or managed identity. To add a federated credential to an app registration, your account must be an owner of the app or hold one of the [Application Administrator](~/identity/role-based-access-control/permissions-reference.md#application-administrator), [Application Developer](~/identity/role-based-access-control/permissions-reference.md#application-developer), or [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator) roles, or have the `microsoft.directory/applications/credentials/update` permission.

This tutorial uses the SPIFFE trust domain `example.org`. `example.org` is the example trust domain used throughout the official SPIRE quickstarts; replace it with your own trust domain in a real deployment. The SPIRE configuration files referenced in the following steps (`server-configmap-oidc.yaml`, `agent-configmap.yaml`, and so on) come from your SPIRE deployment manifests. Base your SPIRE server, agent, and OIDC discovery provider configuration on the current official [SPIRE documentation](https://spiffe.io/docs/latest/) and Kubernetes quickstart so that your node attestor and image versions stay current.

## Part 1: Deploy SPIRE with JWT and OIDC discovery support

In this part, you deploy the SPIRE server, the SPIRE agents, and the OIDC discovery provider. The OIDC discovery provider publishes a standard OpenID Connect discovery document and a JWKS endpoint so that Microsoft Entra ID can validate SPIFFE JWT-SVIDs.

1. Customize the SPIRE configuration files for your environment:

   - `server-configmap-oidc.yaml`: set the OIDC discovery domain FQDN (for example, `oidc.contoso.com`) and your cluster name.
   - `agent-configmap.yaml`: set your cluster name.
   - `oidc-ingress.yaml`: set the OIDC discovery FQDN.
   - `oidc-dp-configmap.yaml`: set the OIDC discovery FQDN, a contact email, and `set_key_use = true`.

   > [!IMPORTANT]
   > The SPIRE OIDC discovery provider can add the `"use": "sig"` parameter to the published signing keys when you set `set_key_use = true` in `oidc-dp-configmap.yaml`. Enable it, because Microsoft Entra ID expects this parameter on the signing keys in the OIDC discovery document's JWKS.

   > [!IMPORTANT]
   > Microsoft Entra ID supports external issuers whose tokens are signed with the RS256 algorithm. SPIRE issues JWT-SVIDs signed with EC (ES256) by default, so configure the SPIRE server certificate authority to issue RS256-signed JWT-SVIDs (for example, by setting the server CA `jwt_key_type` to an RSA key type) so that the Microsoft identity platform accepts the tokens. For more information, see the supported signing algorithms and issuers guidance in [Important considerations and restrictions for federated identity credentials](workload-identity-federation-considerations.md).

1. Deploy the SPIRE server:

   ```bash
   kubectl apply -f spire-namespace.yaml
   kubectl apply -f server-account.yaml -f spire-bundle-configmap.yaml -f server-cluster-role.yaml
   kubectl apply -f server-configmap-oidc.yaml -f server-statefulset.yaml -f server-service.yaml
   ```

1. Deploy the SPIRE agents:

   ```bash
   kubectl apply -f agent-account.yaml -f agent-cluster-role.yaml
   kubectl apply -f agent-configmap.yaml -f agent-daemonset.yaml
   ```

1. Verify that the SPIRE pods are running. Expect a `spire-server-0` pod and one `spire-agent-*` pod per node, all in the `Running` state.

   ```bash
   kubectl get pods -n spire
   ```

1. Register the agent node identity so the SPIRE server trusts the agents. Replace `<your-cluster-name>` with your cluster name.

   ```bash
   kubectl exec -n spire spire-server-0 -- /opt/spire/bin/spire-server entry create \
     -spiffeID spiffe://example.org/ns/spire/sa/spire-agent \
     -selector k8s_sat:cluster:<your-cluster-name> \
     -selector k8s_sat:agent_ns:spire \
     -selector k8s_sat:agent_sa:spire-agent -node
   ```

1. Deploy the SPIRE OIDC discovery provider. Use a current provider image that supports the `set_key_use` option so the published keys include `"use": "sig"`, per the official [SPIRE OIDC discovery provider documentation](https://github.com/spiffe/spire/tree/main/support/oidc-discovery-provider).

   ```bash
   kubectl apply -f oidc-account.yaml -f oidc-dp-configmap.yaml
   kubectl apply -f oidc-ingress.yaml -f oidc-service.yaml
   kubectl apply -f oidc-deployment.yaml
   ```

1. Register the OIDC provider identity:

   ```bash
   kubectl exec -n spire spire-server-0 -- /opt/spire/bin/spire-server entry create \
     -spiffeID spiffe://example.org/oidc-discovery \
     -parentID spiffe://example.org/ns/spire/sa/spire-agent \
     -selector k8s:ns:spire -selector k8s:sa:spire-oidc
   ```

1. The OIDC discovery service runs as a `LoadBalancer` with an external IP address. Point your OIDC discovery domain's DNS `A` record at that external IP address.

1. Verify that the discovery endpoints resolve. The discovery document lists the `issuer`, `jwks_uri`, and `id_token_signing_alg_values_supported` values, and the JWKS lists the signing keys.

   - `https://oidc.contoso.com/.well-known/openid-configuration`
   - `https://oidc.contoso.com/keys`

   Confirm that each key in the JWKS at `/keys` includes `"use": "sig"`. Microsoft Entra ID expects this parameter on the signing keys.

## Part 2: Deploy a sample workload and assign it a SPIFFE ID

In this part, you build and deploy your sample workload, then assign it a SPIFFE ID based on its Kubernetes namespace and service account.

1. Build your sample workload container image and push it to your registry. Replace `<your-registry>` with your registry name.

   ```bash
   docker build -f deployment/docker/dockerfile -t spiffe-demo .
   docker tag spiffe-demo <your-registry>.azurecr.io/spiffe-demo:v1
   az acr login -n <your-registry>.azurecr.io
   docker push <your-registry>.azurecr.io/spiffe-demo:v1
   ```

1. Edit `deployment.yaml` to reference your image (for example, `<your-registry>.azurecr.io/spiffe-demo:v1`), then deploy the workload:

   ```bash
   kubectl apply -f demo-namespace.yaml
   kubectl apply -f serviceaccount.yaml
   kubectl apply -f deployment.yaml
   kubectl apply -f service.yaml
   ```

1. Assign the workload a SPIFFE ID based on its namespace and service account:

   ```bash
   kubectl exec -n spire spire-server-0 -- /opt/spire/bin/spire-server entry create \
     -spiffeID spiffe://example.org/ns/demo-spiffe/sa/demo-sa \
     -parentID spiffe://example.org/ns/spire/sa/spire-agent \
     -selector k8s:ns:demo-spiffe -selector k8s:sa:demo-sa
   ```

The workload now has the SPIFFE ID `spiffe://example.org/ns/demo-spiffe/sa/demo-sa`. You use this value as the subject of the federated identity credential in Part 3, where you configure the Microsoft Entra application.

## Part 3: Configure a Microsoft Entra application to trust the SPIFFE ID

In this part, you add a federated identity credential to a Microsoft Entra app registration so that Microsoft Entra ID trusts tokens issued for your workload's SPIFFE ID. A federated identity credential needs three inputs:

- **issuer**: the OIDC discovery URL, for example `https://oidc.contoso.com`.
- **subject**: the workload's SPIFFE ID, `spiffe://example.org/ns/demo-spiffe/sa/demo-sa`.
- **audiences**: `["api://AzureADTokenExchange"]`.

1. Create a file named `credential.json` with the following content. Replace the issuer and subject values with your own.

   ```json
   {
     "name": "AccessUsingSpiffe",
     "issuer": "https://oidc.contoso.com",
     "subject": "spiffe://example.org/ns/demo-spiffe/sa/demo-sa",
     "audiences": ["api://AzureADTokenExchange"],
     "description": "Federated credential for SPIFFE workload"
   }
   ```

1. Add the federated identity credential to your app registration. Replace `<your-app-id>` with the object ID of your app.

   ```azurecli
   az ad app federated-credential create --id <your-app-id> --parameters credential.json
   ```

You can also add the federated credential in the Microsoft Entra admin center by selecting the **Other issuer** scenario and supplying the OIDC discovery URL as the issuer and the SPIFFE ID as the subject. For the detailed steps, see [Configure an app to trust an external identity provider](workload-identity-federation-create-trust.md). To configure the credential on a user-assigned managed identity instead of an app registration, see [Configure a user-assigned managed identity to trust an external identity provider](workload-identity-federation-create-trust-user-assigned-managed-identity.md).

Grant your app or managed identity access to the Azure resources that your workload calls, such as a role assignment on your storage account.

## Part 4: Exchange a JWT-SVID for a Microsoft Entra access token

In this part, your workload fetches a SPIFFE JWT-SVID and exchanges it for a Microsoft Entra access token, which it uses to call an Azure resource.

SPIFFE defines a Workload API that a workload uses to fetch its SVIDs from the local SPIRE agent. To identify to Microsoft Entra ID, the workload fetches a JWT-SVID with the audience `api://AzureADTokenExchange`. This audience must match the audience on the federated identity credential you configured on the Microsoft Entra app registration in Part 3.

1. Fetch a JWT-SVID from the SPIFFE Workload API. The following illustrative snippet requests a JWT-SVID for the `api://AzureADTokenExchange` audience and returns the SVID string. The concept is the same in any language that has a SPIFFE Workload API client.

   ```javascript
   async function getSpiffeJwt() {
     const svid = await workloadApiClient.fetchJwtSvid({
       audience: ["api://AzureADTokenExchange"],
     });
     return svid.token;
   }
   ```

1. Exchange the JWT-SVID for a Microsoft Entra token by using `ClientAssertionCredential` from the Azure Identity SDK. `ClientAssertionCredential` takes a callback that returns the federated assertion — in this case, the JWT-SVID.

   ```javascript
   import { ClientAssertionCredential } from "@azure/identity";

   const credential = new ClientAssertionCredential(tenantId, clientId, getSpiffeJwt);
   ```

1. Use the credential with any Azure SDK client. For example, to call Azure Blob Storage:

   ```javascript
   const { BlobServiceClient } = require("@azure/storage-blob");

   const blobClient = new BlobServiceClient(blobUrl, credential);
   ```

When the client needs a token, it invokes the callback to fetch a fresh JWT-SVID, exchanges the JWT-SVID with Microsoft identity platform for an access token, and caches the resulting access token. Because `ClientAssertionCredential` supplies the federated assertion through a callback, your workload never stores a secret.

`ClientAssertionCredential` is available across the Azure Identity SDKs, including .NET, Java, JavaScript, Python, and Go. The MSAL libraries also support client assertions if you need lower-level control over the token exchange.

Your SPIFFE/SPIRE workload can now access Microsoft Entra protected resources with no stored secrets.

## Clean up resources

If you no longer need the resources you created in this tutorial, remove them to avoid ongoing charges:

- Delete the SPIRE and demo workloads from your cluster:

  ```bash
  kubectl delete namespace demo-spiffe
  kubectl delete namespace spire
  ```

- Remove the DNS `A` record you created for your OIDC discovery domain.
- Delete the container image from your registry, and delete the cluster if you created it only for this tutorial.
- Delete the federated identity credential from your app registration:

  ```azurecli
  az ad app federated-credential delete --id <your-app-id> --federated-credential-id AccessUsingSpiffe
  ```

## Related content

- [Workload identity federation](workload-identity-federation.md)
- [Configure an app to trust an external identity provider](workload-identity-federation-create-trust.md)
- [Configure a user-assigned managed identity to trust an external identity provider](workload-identity-federation-create-trust-user-assigned-managed-identity.md)
- [Important considerations and restrictions for federated identity credentials](workload-identity-federation-considerations.md)
- [Create a federatedIdentityCredential (Microsoft Graph)](/graph/api/application-post-federatedidentitycredentials)
- [SPIFFE (Secure Production Identity Framework for Everyone)](https://spiffe.io/)
