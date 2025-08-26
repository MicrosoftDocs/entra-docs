---
title: Configure Microsoft Entra Verified ID with VU Security Digital Identity as your Identity Verification Partner
description: Configure Microsoft Entra Verified ID with VU Digital Identity as your Identity Verification Partner.
author: gargi-sinha
manager: martinco
ms.service: entra-verified-id
ms.topic: how-to
ms.date: 06/18/2024
ms.author: gasinh
# Customer intent: As a developer, I'm looking for information about the open standards supported by Microsoft Entra Verified ID.
---

# Configure Microsoft Entra Verified ID with VU Security Digital Identity as your Identity Verification Partner

In this article, learn to integrate [Microsoft Entra Verified ID](decentralized-identifier-overview.md) with [VU Security](https://www.vusecurity.com/) Digital Identity to create secure and frictionless digital experiences. Enhance biometric onboarding and verification scenarios throughout the lifecycle of citizens and organizations.

Digital Identity has flexible onboarding, authentication, and verification processes on devices. It improves user experience and security without affecting business processes.

## Prerequisites

To get started, ensure the following prerequisites are met:

- A tenant [configured](./verifiable-credentials-configure-tenant.md) for Microsoft Entra Verified ID.

  - Use a tenant, or [create an Azure account](https://azure.microsoft.com/free/?WT.mc_id=A261C142F) for free.

- Complete the Digital Identity onboarding process.

- To create an account, go to [VU Security](https://www.vusecurity.com/) and select **Contact**.

   >[!Important]
   >To proceed, use the VU Security-provided URL for users to be issued Verified IDs. 

## Scenario description

Digital Identity is a link between users who need to access an application and applications that require secure access control, regardless of how users access the system.

To enable faster and easier user onboarding, replace some human interactions with verifiable credentials. For a user to create or remotely access an account, enable Verified ID with Digital Identity. Verify identity without using vulnerable or complex passwords, or require users to be on-site.

Learn more about [account onboarding](./plan-verification-solution.md#account-onboarding).

In this account onboarding scenario, Digital Identity plays the Trusted ID proofing issuer role.

   :::image type="content" source="media/partner-vu/vc-solution-architecture-diagram.png" alt-text="Diagram of the verifiable credential solution.":::

## Configure applications to use Digital Identity

Incorporate Digital Identity into your apps.

### Select issuer

As a developer you can share these steps with your tenant administrator to obtain the verification request URL, and body for your application or website to request Verified IDs from your users.

1. Go to the Microsoft Entra admin center - [**Verified ID**](https://entra.microsoft.com/#view/Microsoft_AAD_DecentralizedIdentity/ResourceOverviewBlade)

   >[!TIP]
   >Confirm the tenant configured for Verified ID meets prerequisites.

2. Go to **Quickstart**
3. Select **Verification Request**.
4. Select [**Start**](https://entra.microsoft.com/#view/Microsoft_AAD_DecentralizedIdentity/QuickStartVerifierBlade).
5. Select **Select Issuer**.
6. In Search, in the **Issuers** drop-down, find **VU Security**.

   :::image type="content" source="./media/partner-vu/select-issuers.png" alt-text="Screenshot of the portal section used to choose issuers.":::

7. Compare the **VUIdentityCard** credential with attributes such as firstname, lastname, number, country, region, gender, birth date, nationality. etc.

   >[!NOTE]
   >Number attribute refers to a national ID. For example, the Documento Nacional de Identidad (DNI) in Argentina.

8. Select **Add**.
9. Select **Review**.
10. Download the request body.
11. Copy/paste POST API request URL.

### Update an application or website

With the request URL and body from the tenant administrator, update your application or website.

1. To request Verified IDs from your users, add the request URL and body to your application or website.

   >[!NOTE]
   >If you're using [a sample app](https://aka.ms/vcsample), replace the contents of the `presentation_request_config.json` with the request body obtained in the previous instructions. The sample code overwrites the `trustedIssuers` values with `IssuerAuthority` value from `appsettings.json`.

2. Copy the `trustedIssuers` value from the payload to `IssuerAuthority` in the `appsettings.json` file.
3. Replace the values for **url**, **state**, and **api-key** with your values.
4. To obtain an access token for the Verified ID service request Service Principal, [grant needed permissions](verifiable-credentials-configure-tenant.md#grant-permissions-to-get-access-tokens) for your app.

## Test the user flow

User flow is specific to your application or website. However, with a sample app, see [related documentation](https://aka.ms/vcsample).

## Next steps

- [Verifiable credentials admin API](admin-api.md)
- [Request Service REST API issuance specification](issuance-request-api.md)
