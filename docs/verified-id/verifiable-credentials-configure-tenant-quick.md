---
title: Tutorial - Quick setup of your tenant for Microsoft Entra Verified ID
description: In this tutorial, you learn how to quickly configure your tenant to support the Verified ID service. 
ms.service: entra-verified-id

author: barclayn
manager: amycolannino
ms.author: barclayn
ms.topic: tutorial
ms.date: 10/06/2023
# Customer intent: As an enterprise, we want to enable customers to manage information about themselves by using verifiable credentials.

---

# Quick Microsoft Entra Verified ID setup

  
Quick Verified ID setup removes several configuration steps an admin needs to complete with a single click on a `Get started` button. The quick setup  takes care of signing keys, registering your decentralized ID and verify your domain ownership. It also creates a Verified Workplace Credential for you.

In this tutorial, you learn how to use the quick setup to configure your Microsoft Entra tenant to use the verifiable credentials service.

Specifically, you learn how to:

> [!div class="checklist"]
> - Configure your the Verified ID service using the quick setup.
> - Controlling how issuances of Verified Workplace Credentials in MyAccount

## Prerequisites

- Ensure that you have the [Global Administrator](~/identity/role-based-access-control/permissions-reference.md#global-administrator) or the [authentication policy administrator](~/identity/role-based-access-control/permissions-reference.md#authentication-policy-administrator) permission for the directory you want to configure. If you're not the Global Administrator, you need the [application administrator](~/identity/role-based-access-control/permissions-reference.md#application-administrator) permission to complete the app registration including granting admin consent.
- Ensure that you have a [custom domain registered](~/identity/users/domains-manage.md) for the Microsoft Entra tenant. If you don't have one registered, the setup defaults to the advanced setup experience.

> [!NOTE]
> The Quick setup method is currently not supported in EDU Entra tenants.

## How Quick Verified ID setup works

- A shared signing key, managed by Microsoft, is used across multiple tenants within a given region. It's no longer required to deploy Azure Key Vault.
- There is a 2 RPS per tenant limit for issuance and verifications. 
- Since it's a shared key, the validityInterval of issued credentials is limited to a maximum of six months.
- The [custom domain registered](~/identity/users/domains-manage.md) for your Microsoft Entra tenant is used for domain verification. It's no longer required to upload your DID configuration JSON to verify your domain. If you don't have a custom domain registered for your tenant, you can't set up Verified ID using the quick setup method.
- If you have customized your [tenant's branding](~/fundamentals/how-to-customize-branding.md#before-you-begin), the VerifiedEmployee default credential will pick up logo and background color from there. If you haven't or prefer other values, you can edit this after setup is complete.
- The Decentralized identifier (DID) gets a name like `did:web:verifiedid.entra.microsoft.com:tenantid:authority-id` and the DID document is discoverable following [did:web specification](https://w3c-ccg.github.io/did-method-web/#create-register).

> [!NOTE]
> If the quick setup doesn't meet your requirements, use the [Advanced setup](verifiable-credentials-configure-tenant.md).

## Set up Verified ID

If you have a custom domain registered for your Microsoft Entra tenant, you see this `Get started` option. If you don't have a custom domain registered, either register it before setting up Verified ID or continue using the [advanced setup](verifiable-credentials-configure-tenant.md).

:::image type="content" source="media/verifiable-credentials-configure-tenant-quick/verifiable-credentials-getting-started.png" alt-text="Screenshot that shows how to set up Verifiable Credentials.":::

To set up Verified ID, follow these steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Administrator](~/identity/role-based-access-control/permissions-reference.md#global-administrator).

1. Select **Verified ID**.

1. From the left menu, select **Setup**.

1. Click the **Get started** button.

1. If you have multiple domains registered for your Microsoft Entra tenant, select the one you would like to use for Verified ID.

    :::image type="content" source="media/verifiable-credentials-configure-tenant-quick/verifiable-credentials-select-domain.png" alt-text="Screenshot that shows how to select domain.":::

When the setup process is complete, you see a default workplace credential available to edit and offer to employees of your tenant on their MyAccount page.

:::image type="content" source="media/verifiable-credentials-configure-tenant-quick/verifiable-credentials-setup-complete.png" alt-text="Screenshot that shows how to set up is completed.":::

## MyAccount available now to simplify issuance of Workplace Credentials
Issuing Verified Workplace Credentials is now available via [myaccount.microsoft.com](https://myaccount.microsoft.com/). Users can sign in to myaccount using their Microsoft Entra credentials and issue themselves a Verified Workplace Credential via the `Get my Verified ID` option.  

:::image type="content" source="media/verifiable-credentials-configure-tenant-quick/verifiable-credentials-my-account-issue.png" alt-text="Screenshot that shows issuance via myaccount.":::

As an admin, you can either remove the option in MyAccount and create your custom application for issuing Verified Workplace Credentials. You can also select specific groups of users that are allowed to be issued credentials from MyAccount.

:::image type="content" source="media/verifiable-credentials-configure-tenant-quick/verifiable-credentials-setup-groups.png" alt-text="Screenshot that shows controlling issuance via myaccount.":::

> [!NOTE]
> When you have made a configuration change for issuing credentials through My Account, expect some minutes of delay before the change takes effect.

## Register an application in Microsoft Entra ID

If you're planning to use custom credentials or set up your own application for issuing or verification Verified ID, you need to register an application and grant the appropriate permissions for it. Follow this section in the advanced setup to [register an application](verifiable-credentials-configure-tenant.md#register-an-application-in-microsoft-entra-id)

## Next steps

- [Learn how to issue Microsoft Entra Verified ID credentials from a web application](verifiable-credentials-configure-issuer.md).
- [Learn how to verify Microsoft Entra Verified ID credentials](verifiable-credentials-configure-verifier.md).
