---
title: "Add and manage app credentials in Microsoft Entra ID"
description: Learn to configure certificates, client secrets, and federated credentials in Microsoft Entra for secure app authentication.
author: cilwerner
manager: CelesteDG
ms.author: cwerner
ms.custom: mode-other
ms.date: 03/26/2025
ms.service: identity-platform
ms.topic: how-to
#Customer intent: As developer, I want to know how to register my application in Microsoft Entra tenant. I want to understand the additional configurations to help make my application secure. 
---

# Add and manage application credentials in Microsoft Entra ID

When building confidential client applications, managing credentials effectively is critical. This article explains how to add client certificates, federated identity credentials, or client secrets to your app registration in Microsoft Entra. These credentials enable your application to authenticate itself securely and access web APIs without user interaction.

## Prerequisites

[Quickstart: Register an app in Microsoft Entra ID](quickstart-register-app.md).

## Add a credential to your application

[!INCLUDE [client-credential-advice](./includes/register-app/client-credential-advice.md)]

To learn more about client secret vulnerabilities, refer to [Migrate applications away from secret-based authentication](/entra/identity/enterprise-apps/migrate-applications-from-secrets).

### [Add a certificate](#tab/certificate)

Sometimes called a *public key*, a certificate is the recommended credential type because they're considered more secure than client secrets. 

1. In the Microsoft Entra admin center, in **App registrations**, select your application.
1. Select **Certificates & secrets** > **Certificates** > **Upload certificate**.
1. Select the file you want to upload. It must be one of the following file types: *.cer*, *.pem*, *.crt*.
1. Select **Add**.
1. Record the certificate **Thumbprint** for use in your client application code. 

    :::image type="content" source="./media/quickstart-register-app/add-client-certificate.png" alt-text="Screenshot of the Microsoft Entra admin center, showing the Certificates tab in the Certificates and secrets pane in an app registration." lightbox="./media/quickstart-register-app/add-client-certificate.png":::


### [Add a client secret](#tab/client-secret)

Sometimes called an *application password*, a client secret is a string value your app can use in place of a certificate to identify itself.

Client secrets are less secure than certificate or federated credentials and therefore should **not be used** in production environments. While they may be convenient for local app development, it's imperative to use certificate or federated credentials for any applications running in production to ensure higher security.

1. In the Microsoft Entra admin center, in **App registrations**, select your application.
1. Select **Certificates & secrets** > **Client secrets** > **New client secret**.
1. Add a description for your client secret.
1. Select an expiration for the secret or specify a custom lifetime.
    - Client secret lifetime is limited to two years (24 months) or less. You can't specify a custom lifetime longer than 24 months.
    - Microsoft recommends that you set an expiration value of less than 12 months.
1. Select **Add**.
1. Record the client secret **Value** for use in your client application code. This secret value is *never displayed again* after you leave this page.

    :::image type="content" source="./media/quickstart-register-app/add-client-secret.png" alt-text="Screenshot of the Microsoft Entra admin center, showing the Client secrets tab in the Certificates and secrets pane in an app registration." lightbox="./media/quickstart-register-app/add-client-secret.png":::

> [!NOTE]
> If you're using an Azure DevOps service connection that automatically creates a service principal, you need to update the client secret from the Azure DevOps portal site instead of directly updating the client secret. Refer to this document on how to update the client secret from the Azure DevOps portal site:
> [Troubleshoot Azure Resource Manager service connections](/azure/devops/pipelines/release/azure-rm-endpoint#service-principals-token-expired).

### [Add a federated credential](#tab/federated-credential)

Federated identity credentials are a type of credential that allows workloads, such as GitHub Actions, workloads running on Kubernetes, or workloads running in compute platforms outside of Azure access Microsoft Entra protected resources without needing to manage secrets using [workload identity federation](~/workload-id/workload-identity-federation.md).

To add a federated credential, follow these steps:

1. In the Microsoft Entra admin center, in **App registrations**, select your application.
1. Select **Certificates & secrets** > **Federated credentials** > **Add credential**.

    :::image type="content" source="./media/quickstart-register-app/add-federated-credential.png" alt-text="Screenshot of the Microsoft Entra admin center, showing the Certificates and secrets pane in an app registration." lightbox="./media/quickstart-register-app/add-federated-credential.png":::

1. In the **Federated credential scenario** drop-down box, select one of the supported scenarios, and follow the corresponding guidance to complete the configuration.

    - **Customer managed keys** for encrypting data in your tenant using Azure Key Vault in another tenant.
    - **GitHub actions deploying Azure resources** to [configure a GitHub workflow](~/workload-id/workload-identity-federation-create-trust.md#github-actions) to get tokens for your application and deploy assets to Azure.
    - **Kubernetes accessing Azure resources** to configure a [Kubernetes service account](~/workload-id/workload-identity-federation-create-trust.md#kubernetes) to get tokens for your application and access Azure resources.
    - **Other issuer** to configure the application to [trust a managed identity](~/workload-id/workload-identity-federation-config-app-trust-managed-identity.md) or an identity managed by an external [OpenID Connect provider](~/workload-id/workload-identity-federation-create-trust.md#other-identity-providers) to get tokens for your application and access Azure resources.

For more information on how to get an access token with a federated credential, see [Microsoft identity platform and the OAuth 2.0 client credentials flow](./v2-oauth2-client-creds-grant-flow.md#third-case-access-token-request-with-a-federated-credential).

---

## Related content

- [Microsoft identity platform application authentication certificate credentials](./certificate-credentials.md)
- [Configure an application to trust a managed identity](/entra/workload-id/workload-identity-federation-config-app-trust-managed-identity?tabs=microsoft-entra-admin-center)
- [Public client and confidential client applications](./msal-client-applications.md)
- [Create a sign-up and sign-in user flow for an external tenant app](../external-id/customers/how-to-user-flow-sign-up-sign-in-customers.md)
- [Add your application to a user flow](/entra/external-id/customers/how-to-user-flow-add-application)
