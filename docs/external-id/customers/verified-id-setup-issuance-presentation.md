---
title: Set up Microsoft Entra Verified ID
description: Configure Microsoft Entra Verified ID in an external tenant, issue credentials, and verify presented credentials in an application.
author: rogulati
ms.author: rogulati
ms.service: entra-external-id
ms.topic: how-to
ms.custom: msecd-doc-authoring-1026
ms.date: 09/08/2026
ai-usage: ai-generated

#customer intent: As an External ID tenant administrator or developer, I want to configure Verified ID, issue credentials, and verify presented credentials so that my applications can use verified claims.
---

# Configure Microsoft Entra Verified ID in an external tenant

If you're an External ID tenant administrator or developer, use this article to configure Microsoft Entra Verified ID in an external tenant. Before you start, review the prerequisites for Quick setup and the sample application. When you finish, you can create a credential type, issue a credential to a user, and configure an application to request and verify the credential.

Quick setup is the supported setup method for external tenants. It configures signing keys, registers a decentralized identifier (DID), verifies domain ownership, and creates a default Verified Workplace credential.

> [!IMPORTANT]
> Advanced setup and Face Check aren't available in external tenants. Quick setup uses a Microsoft-managed shared signing key, supports two issuance and verification requests per second per tenant, and limits credential validity to six months.

## Prerequisites

- A Microsoft Entra External ID tenant with a [registered custom domain](/entra/identity/users/domains-manage). Without a registered custom domain, there isn't a supported Verified ID setup path for an external tenant.
- The [Authentication Policy Administrator](/entra/identity/role-based-access-control/permissions-reference#authentication-policy-administrator) role to configure Verified ID.
- The [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator) role if you need to register an application.
- A mobile device with the latest version of Microsoft Authenticator.
- For the .NET sample application, [Git](https://git-scm.com/downloads), [Visual Studio Code](https://code.visualstudio.com/Download) or a similar code editor, [.NET 8.0](https://dotnet.microsoft.com/download/dotnet/8.0), and an [ngrok](https://ngrok.com/) account.

## Set up Verified ID

Use Quick setup to configure Verified ID without deploying Azure Key Vault or managing signing keys.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) with the Authentication Policy Administrator role.
1. Select **Verified ID**.
1. On the left menu, select **Setup**.
1. Select **Get started**.
1. If your tenant has multiple registered domains, select the domain to use for Verified ID.
1. Wait for setup to finish, and verify that the default workplace credential appears.

Quick setup creates a DID in the format `did:web:verifiedid.entra.microsoft.com:<tenant-id>:<authority-id>`. For more information about Quick setup and the default credential, see [Quick Microsoft Entra Verified ID setup](/entra/verified-id/verifiable-credentials-configure-tenant-quick).

## Register an application

Register an application so it can get access tokens to call the Verified ID Request Service for issuance and presentation.

1. In the Microsoft Entra admin center, select **Microsoft Entra ID**.
1. Select **Applications** > **App registrations** > **New registration**.
1. Enter a display name for the application.
1. For **Supported account types**, select **Accounts in this organizational directory only**.
1. Select **Register**.
1. On the application page, select **API permissions** > **Add a permission**.
1. Select **APIs my organization uses**.
1. Search for and select **Verifiable Credentials Service Request**.
1. Select **Application permissions**, expand **VerifiableCredential.Create.All**, and select **Add permissions**.
1. Select **Grant admin consent for \<your tenant name\>**.

You can grant issuance and presentation permissions to separate applications if you need to separate those responsibilities. For the complete registration procedure, see [Register an application in Microsoft Entra ID](/entra/verified-id/verifiable-credentials-configure-tenant#register-an-application-in-microsoft-entra-id).

## Create a credential type

Create a custom credential with display and rules definitions for the claims that your application issues.

1. Under **Verified ID**, select **Credentials**.
1. Select **Add a credential**.
1. Select **Custom Credential**, and then select **Next**.
1. Enter a credential name.
1. Add the display definition for the credential.
1. Add the rules definition that maps the input claims from your application to the output claims in the credential.
1. Select **Create**.
1. Select **Issue credential** for the credential that you created.
1. Record the authority DID, manifest URL, and tenant ID. You use these values to configure the issuing application.

For a sample display definition, rules definition, and credential, see [Issue Microsoft Entra Verified ID credentials from an application](/entra/verified-id/verifiable-credentials-configure-issuer).

## Issue a credential

Configure an issuing application to request a credential for a user and add it to the user's Microsoft Authenticator wallet.

1. Download or clone the [.NET sample application](https://github.com/Azure-Samples/active-directory-verifiable-credentials-dotnet).
1. Configure the sample application with the tenant ID, application client ID, application credential, authority DID, and credential manifest URL that you recorded.
1. Run the sample application and make its callback endpoint available.
1. In the sample application, select **Get Credential**.
1. Scan the QR code with Microsoft Authenticator.
1. Follow the prompts in Microsoft Authenticator to add the credential.
1. Return to the sample application, and verify that it reports a successful issuance.

For the sample configuration and complete testing procedure, see [Issue Microsoft Entra Verified ID credentials from an application](/entra/verified-id/verifiable-credentials-configure-issuer).

## Configure credential presentation

Configure a relying-party application to request a credential and process the verified claims returned in the callback.

1. In the Microsoft Entra admin center, select **Verified ID** > **Organization settings**.
1. Record the tenant identifier and DID for the verifying organization.
1. Configure the verifier application with its tenant ID, application client ID, application credential, DID authority, and the credential type to request.
1. Create a presentation request for the credential type.
1. Configure the application to receive the authenticated callback and use the verified claims to make its access decision.

The issuer and verifier can use the same tenant or separate organizations and tenants. When they're separate, configure the verifier with its own tenant identifier and DID. For the complete sample configuration, see [Configure Microsoft Entra Verified ID verifier](/entra/verified-id/verifiable-credentials-configure-verifier).

## Present and verify a credential

Test the presentation request with the credential in Microsoft Authenticator.

1. Run the verifier application and make its callback endpoint available.
1. In the verifier application, select **Verify Credential**.
1. Scan the QR code with Microsoft Authenticator.
1. Review the presentation request, and select **Allow**.
1. Return to the verifier application, and verify that it received the presentation.
1. Confirm that the application uses the verified claims to make the expected access decision.

## Related content

- [Quick Microsoft Entra Verified ID setup](/entra/verified-id/verifiable-credentials-configure-tenant-quick)
- [Issue Microsoft Entra Verified ID credentials from an application](/entra/verified-id/verifiable-credentials-configure-issuer)
- [Configure Microsoft Entra Verified ID verifier](/entra/verified-id/verifiable-credentials-configure-verifier)
