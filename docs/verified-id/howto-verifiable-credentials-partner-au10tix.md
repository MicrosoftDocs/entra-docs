---
title: Configure Verified ID by AU10TIX as your Identity Verification Partner 
description: This article shows you the steps you need to follow to configure AU10TIX as your identity verification partner.
author: barclayn
manager: femila
ms.service: entra-verified-id
ms.topic: how-to
ms.date: 01/17/2025
ms.author: barclayn
# Customer intent: As a developer, I'm looking for information about the open standards that are supported by Microsoft Entra Verified ID.
---

# Configure Verified ID by AU10TIX as your Identity Verification Partner

In this article, we cover the steps needed to integrate Microsoft Entra Verified ID with [AU10TIX](https://www.au10tix.com/). AU10TIX is an automated solution for the verification of ID documents + biometrics. AU10TIX supports the verification of documents in over 190 regions reading documents in their regional languages.

To learn more about AU10TIX and its complete set of solutions, visit https://www.au10tix.com/.

## Prerequisites

 You need to meet the following requirements before you can continue with the steps in this article:

- A tenant [configured](verifiable-credentials-configure-tenant.md) for Microsoft Entra Verified ID service.
    - If you don't have an existing tenant, you can [create an Azure account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
- You first need to complete the onboarding process with Au10tix.
    - To create a AU10TIX account, submit the form on this [page](https://www.au10tix.com/solutions/verifiable-credentials/).


>[!IMPORTANT]
> Before you proceed, you must have a URL from Au10Tix for users to be issued Verified IDs. If you don't have it, follow up with Au10Tix before you attempt to follow the steps in this article.

## Scenario description

When onboarding users you can remove the need for error prone manual onboarding steps by using Verified ID with A10TIX account onboarding. Verified IDs can be used to digitally onboard employees, students, citizens, or others to securely access resources and services. For example, rather than an employee needing to go to a central office to activate an employee badge, they can use a Verified ID to verify their identity to activate a badge that is delivered to them remotely. Rather than a citizen receiving a code they must redeem to access governmental services, they can use a Verified ID to prove their identity and gain access. Learn more about [account onboarding](./plan-verification-solution.md#account-onboarding).



:::image type="content" source="media/verified-id-partner-au10tix/vc-solution-architecture-diagram.png" alt-text="Diagram of the verifiable credential solution.":::


## Configure your Application to use AU10TIX Verified ID

For incorporating identity verification into your Apps, using AU10TIX  "Government Issued ID - Global" Verified ID follow these steps:

### Part 1

As a developer you can share these steps with your tenant administrator to obtain the verification request URL, and body for your application or website to request Verified IDs from your users.

1. Go to [Microsoft Entra admin center -> Verified ID](https://entra.microsoft.com/#view/Microsoft_AAD_DecentralizedIdentity/ResourceOverviewBlade). 

   >[!NOTE]
   > Make sure this tenant is the one where you set up Verified ID per the prerequisites.

1. Select QuickStart > Verification Request > [Start](https://entra.microsoft.com/#view/Microsoft_AAD_DecentralizedIdentity/QuickStartVerifierBlade)
1. Choose **Select Issuer**.
1. Look for AU10TIX in the **Search/select issuers** drop-down.

   :::image type="content" source="./media/verified-id-partner-au10tix/select-issuers.png" alt-text="Screenshot of the portal section used to choose issuers.":::

1. Check the **Government Issued ID – Global** or other credential type.
1. Select **Add** and then select **Review**.
1. Download the request body and Copy/paste POST API request URL.

### Part 2

As a developer you now have the request URL and body from your tenant admin, follow these steps to update your application or website:

1. To request Verified IDs from your users, include the request URL and body in your application or website. 
   >[!Note]
   >If you are using [one of the sample apps](https://aka.ms/vcsample), you'll need to replace the contents of the `presentation_request_config.json` with the request body obtained in [Part 1](#part-1). The sample code overwrites the `trustedIssuers` values with `IssuerAuthority` value from `appsettings.json`. Copy the `trustedIssuers` value from the payload to `IssuerAuthority` in `appsettings.json` file.
1. Be sure to replace the values for the **URL**, **state**, and **api-key** with your respective values.
1. [Grant permissions](verifiable-credentials-configure-tenant.md#grant-permissions-to-get-access-tokens) to your app to obtain access token for the Verified ID service request service principal.

## Test the user flow

User flow is specific to your application or website. However if you use one of the sample apps follow the steps outlined as part of the [sample app's documentation](https://aka.ms/vcsample).

## Next steps

- [Verifiable credentials admin API](admin-api.md)
- [Request Service REST API issuance specification](issuance-request-api.md)
