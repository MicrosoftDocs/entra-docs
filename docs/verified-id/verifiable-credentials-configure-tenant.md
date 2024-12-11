---
title: Tutorial - Advanced Microsoft Entra Verified ID setup
description: In this tutorial, you learn how to manually configure your tenant to support the Verified ID service. 
ms.service: entra-verified-id

author: barclayn
manager: amycolannino
ms.author: barclayn
ms.topic: tutorial
ms.date: 09/15/2023
# Customer intent: As an enterprise, we want to enable customers to manage information about themselves by using verifiable credentials.

---

# Advanced Microsoft Entra Verified ID setup

Advanced Verified ID setup is the classic way of setting up Verified ID where you as an admin have to configure Azure KeyVault, take care of registering your decentralized ID and verifying your domain.

In this tutorial, you learn how to use the advanced setup to configure your Microsoft Entra tenant to use the verifiable credentials service.

Specifically, you learn how to:

> [!div class="checklist"]
> - Create an Azure Key Vault instance.
> - Configure your the Verified ID service using the advanced setup.
> - Register an application in Microsoft Entra ID.

The following diagram illustrates the Verified ID architecture and the component you configure.

:::image type="content" source="media/verifiable-credentials-configure-tenant/verifiable-credentials-architecture.png" alt-text="Diagram that illustrates the Microsoft Entra Verified ID architecture." border="false":::

## Prerequisites

- You need an Azure tenant with an active subscription. If you don't have an Azure subscription, [create one for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
- Ensure that you have the [Global Administrator](~/identity/role-based-access-control/permissions-reference.md#global-administrator) or the [authentication policy administrator](~/identity/role-based-access-control/permissions-reference.md#authentication-policy-administrator) permission for the directory you want to configure. If you're not the Global Administrator, you need the [application administrator](~/identity/role-based-access-control/permissions-reference.md#application-administrator) permission to complete the app registration including granting admin consent.
- Ensure that you have the [contributor](/azure/role-based-access-control/built-in-roles#contributor) role for the Azure subscription or the resource group where you are deploying Azure Key Vault.
- Ensure that you provide access permissions for Key Vault. For more information, see [Provide access to Key Vault keys, certificates, and secrets with an Azure role-based access control](/azure/key-vault/general/rbac-guide).

## Create a key vault
>[!NOTE]
>The Azure Key Vault that you use to setup the Verified ID service must have [Key Vault Access Policy](/azure/key-vault/general/assign-access-policy) for its Permission model. There is currently a limitation if the Key Vault has Azure role-based access control

[Azure Key Vault](/azure/key-vault/general/basic-concepts) is a cloud service that enables the secure storage and access management of secrets and keys. The Verified ID service stores public and private keys in Azure Key Vault. These keys are used to sign and verify credentials.

If you don't have an Azure Key Vault instance available, follow [these steps](/azure/key-vault/general/quick-create-portal) to create a key vault using the Azure portal, The Azure Key Vault that you use to setup the Verified ID service must have [Key Vault Access Policy](/azure/key-vault/general/assign-access-policy) for its Permission model instead of Azure role-based access control that is currently the default when creating an Azure Key Vault. 

>[!NOTE]
>By default, the account that creates a vault is the only one with access. The Verified ID service needs access to the key vault. You must [authenticate your key vault](/azure/key-vault/general/basic-concepts), allowing the account used during configuration to create and delete keys. The account used during configuration also requires permissions to sign so that it can create the domain binding for Verified ID. If you use the same account while testing, modify the default policy to grant the account sign permission, in addition to the default permissions granted to vault creators.

### Manage access to the key vault

Before you can set up Verified ID, you need to provide Key Vault [access](/azure/key-vault/general/rbac-guide). This defines whether a specified admin can perform operations on Key Vault secrets and keys. Provide access permissions to your key vault for both the Verified ID administrator account, and for the Request Service API principal that you created.

After you create your key vault, Verifiable Credentials generates a set of keys used to provide message security. These keys are stored in Key Vault. You use a key set for signing verifiable credentials.

## Set up Verified ID

:::image type="content" source="media/verifiable-credentials-configure-tenant/verifiable-credentials-setup-advanced-1-2-3.png" alt-text="Screenshot that shows how to set up Verifiable Credentials.":::

To set up Verified ID, follow these steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Administrator](~/identity/role-based-access-control/permissions-reference.md#global-administrator).

1. From the left menu, select **Overview** under **Verified ID**.

1. From the middle menu, select **Setup** tab and then select **Advanced Setup**.

1. Select **Configure organization settings**

1. Set up your organization by providing the following information:

    1. **Organization name**: Enter a name to reference your business within Verified IDs. Your customers don't see this name.

    1. **Trusted domain**: Enter a domain that's added to a service endpoint in your decentralized identity (DID) document. The domain is what binds your DID to something tangible that the user might know about your business. Microsoft Authenticator and other digital wallets use this information to validate that your DID is linked to your domain. If the wallet can verify the DID, it displays a verified symbol. If the wallet can't verify the DID, it informs the user that the credential was issued by an organization it couldn't validate.

        >[!IMPORTANT]
        > The domain can't be a redirect. Otherwise, the DID and domain can't be linked. Make sure to use HTTPS for the domain. For example: `https://did.woodgrove.com`.
        > Please also ensure that the Key Vault's Permission Model is set to Vault Access Policy.

    1. **Key vault**: Select the key vault that you created earlier.

1. Select **Save**.  

    :::image type="content" source="media/verifiable-credentials-configure-tenant/verifiable-credentials-advanced-setup-save.png" alt-text="Screenshot that shows how to set up Verifiable Credentials first step.":::

## Register an application in Microsoft Entra ID

Your application needs to get access tokens when it wants to call into Microsoft Entra Verified ID so it can issue or verify credentials. To get access tokens, you have to register an application and grant API permission for the Verified ID Request Service. For example, use the following steps for a web application:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Administrator](~/identity/role-based-access-control/permissions-reference.md#global-administrator).
1. Select Microsoft Entra ID.

1. Under **Applications**, select **App registrations** > **New registration**.  

    :::image type="content" source="media/verifiable-credentials-configure-tenant/register-app.png" alt-text="Screenshot that shows how to select a new application registration.":::

1. Enter a display name for your application. For example: *verifiable-credentials-app*.

1. For **Supported account types**, select **Accounts in this organizational directory only (Default Directory only - Single tenant)**.

1. Select **Register** to create the application.

    :::image type="content" source="media/verifiable-credentials-configure-tenant/register-app-properties.png" alt-text="Screenshot that shows how to register the verifiable credentials app.":::

### Grant permissions to get access tokens

In this step, you grant permissions to the **Verifiable Credentials Service Request** Service principal.

To add the required permissions, follow these steps:

1. Stay in the **verifiable-credentials-app** application details page. Select **API permissions** > **Add a permission**.

    :::image type="content"  source="media/verifiable-credentials-configure-tenant/add-app-api-permissions.png" alt-text="Screenshot that shows how to add permissions to the verifiable credentials app.":::

1. Select **APIs my organization uses**.

1. Search for the **Verifiable Credentials Service Request** service principal and select it.

    :::image type="content" source="media/verifiable-credentials-configure-tenant/add-app-api-permissions-select-service-principal.png" alt-text="Screenshot that shows how to select the service principal.":::

1. Choose **Application Permission**, and expand **VerifiableCredential.Create.All**.

    :::image type="content" source="media/verifiable-credentials-configure-tenant/add-app-api-permissions-verifiable-credentials.png" alt-text="Screenshot that shows how to select the required permissions.":::

1. Select **Add permissions**.

1. Select **Grant admin consent for \<your tenant name\>**.

You can choose to grant issuance and presentation permissions separately if you prefer to segregate the scopes to different applications.

:::image type="content" source="media/verifiable-credentials-configure-tenant/granular-app-permissions.png" alt-text="Screenshot that shows how to select granular permissions for issuance or presentation.":::

## Register decentralized ID and verify domain ownership

After Azure Key Vault is setup, and the service have a signing key, you must complete step 2 and 3 in the setup.

:::image type="content" source="media/verifiable-credentials-configure-tenant/verifiable-credentials-getting-started-step-2-3.png" alt-text="Screenshot that shows how to set up Verifiable Credentials step 2 and 3.":::

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Administrator](~/identity/role-based-access-control/permissions-reference.md#global-administrator).
1. Select **Verified ID**.
1. From the left menu, select **Overview**.
1. From the middle menu, select **Register decentralized ID** to register your DID document, as per instructions in article [How to register your decentralized ID for did:web](how-to-register-didwebsite.md). You must complete this step before you can continue to verify your domain.
1. From the middle menu, select **Verify domain ownership** to verify your domain, as per instructions in article [Verify domain ownership to your Decentralized Identifier (DID)](how-to-dnsbind.md)

Once that you have successfully completed the verification steps, and have green checkmarks on all three steps, you are ready to continue to the next tutorial.

## Next steps

- [Learn how to issue Microsoft Entra Verified ID credentials from a web application](verifiable-credentials-configure-issuer.md).
- [Learn how to verify Microsoft Entra Verified ID credentials](verifiable-credentials-configure-verifier.md).
