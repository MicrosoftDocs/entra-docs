---
title: Recommendation to renew expiring application credentials
description: Learn how the Microsoft Entra recommendation to renew expiring application credentials works and why it's important.
author: shlipsey3
manager: femila
ms.service: entra-id
ms.topic: how-to
ms.subservice: monitoring-health
ms.date: 04/09/2025
ms.author: sarahlipsey
ms.reviewer: saumadan
ms.custom: sfi-image-nochange
#Customer intent: As an IT Admin I need to know when application credentials are expiring so I can renew them to prevent downtime.
---
# Microsoft Entra recommendation: Renew expiring application credentials (preview)

[Microsoft Entra recommendations](overview-recommendations.md) is a feature that provides you with personalized insights and actionable guidance to align your tenant with recommended best practices.

This article covers the recommendation to renew expiring application credentials. This recommendation is called `applicationCredentialExpiry` in the recommendations API in Microsoft Graph. 

## Prerequisites

[!INCLUDE [Recommendations roles](../../includes/recommendations-roles.md)]

## Description

Application credentials can include certificates and other types of secrets that need to be registered with that application. These credentials are used to prove the identity of the application.

This recommendation shows up if your tenant has application credentials that will expire soon.

An application credential is expiring if:

- It's on an application registration AND is expiring within the next 30 days.

The following credentials are exempted from this recommendation:

- Credentials that were identified as expiring but have since been removed from the app registration
- Credentials whose expiration date has lapsed show as **completed** in the list of **Impacted resources**.

## Value

Renewing an application’s credentials prior to their expiry date is crucial for maintaining uninterrupted operations and minimizing the risk of any downtime resulting from outdated credentials.

## Action plan

This recommendation is available in the Microsoft Entra admin center and using the Microsoft Graph API.

### [Microsoft Entra admin center](#tab/microsoft-entra-admin-center)

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Security Administrator](../role-based-access-control/permissions-reference.md#search-administrator).

1. Browse to **Entra ID** > **Overview**.

1. Select the **Recommendations** tab and select the **Renew expiring application credentials** recommendation.

1. Take note of the following details from the **Impacted resources** table.
    - The **Resource** column displays the application name
    - The **ID** column displays the application ID

        :::image type="content" source="media/recommendation-renew-expiring-application-credential/recommendation-renew-expiring-app-credentials.png" alt-text="Screenshot of the recommendation with the More details options highlighted." lightbox="media/recommendation-renew-expiring-application-credential/recommendation-renew-expiring-app-credentials-expanded.png":::

1. Select **More Details** from the **Actions** column.

1. From the panel that opens, select **Update Credential** to navigate directly to the **Certificates & secrets** area of the app registration to renew the expiring credential.
    1. Alternatively, browse to **Entra ID** > **App registrations** and locate the application for which the credential needs to be rotated.

      :::image type="content" source="media/recommendation-renew-expiring-application-credential/app-registrations-list.png" alt-text="Screenshot of the Microsoft Entra app registration page." lightbox="media/recommendation-renew-expiring-application-credential/app-registrations-list-expanded.png":::

    1. Navigate to the **Certificates & Secrets** section of the app registration.

1. Pick the credential type that you want to rotate and navigate to either **Certificates** or **Client Secret** tab and follow the prompts.

    :::image type="content" source="media/recommendation-renew-expiring-application-credential/app-certificates-secrets.png" alt-text="Screenshot of the Certificates and secrets section of Microsoft Entra ID." lightbox="media/recommendation-renew-expiring-application-credential/app-certificates-secrets-expanded.png":::

1. Once the certificate or secret is successfully added, update the service code to ensure it works with the new credential and doesn't negatively affect customers.

1. Use the Microsoft Entra sign-in logs to validate that the Key ID of the credential matches the one that was recently added.

1. After validating the new credential, navigate back to **App registrations** > **Certificates and Secrets** for the app and remove the old credential.

### [Microsoft Graph API](#tab/microsoft-graph-api)

The following requests can be used to retrieve the recommendation and the impacted resources using the Microsoft Graph API. To use the Microsoft Graph API, you need the `DirectoryRecommendations.Read.All` and `DirectoryRecommendations.ReadWrite.All` permissions. For more information, see [How to use Identity Recommendations](howto-use-recommendations.md).

1. Sign in to [Graph Explorer](https://developer.microsoft.com/graph/graph-explorer).
1. Select **GET** as the HTTP method from the dropdown.

To retrieve all recommendations for your tenant:

```http
GET https://graph.microsoft.com/beta/directory/recommendations
```

From the response, find the ID of the recommendation that matches the following pattern: `{tenantId}_ApplicationCredentialExpiry`.

To identify impacted resources:

```http
GET https://graph.microsoft.com/beta/directory/recommendations/{tenantId}_ApplicationCredentialExpiry
```

To filter the resources based on their status (for example, *active* resources):

```http
GET https://graph.microsoft.com/beta/directory/recommendations/536279f6-15cc-45f2-be2d-61e352b51eef_ ApplicationCredentialExpiry’/impactedResources?$filter=status eq Microsoft.Graph.recommendationStatus'active'
```

Take note of the `AppId`, `CredentialId`, and `Origin` of the credential you want to remove. To remove the credential, use the following Microsoft Graph guidance:

- [addPassword](/graph/api/application-addpassword?view=graph-rest-1.0&preserve-view=true)
- [addKey](/graph/api/application-addkey?view=graph-rest-1.0&preserve-view=true)
- [removePassword](/graph/api/application-removepassword?view=graph-rest-1.0&preserve-view=true)
- [removeKey](/graph/api/application-removekey?view=graph-rest-1.0&preserve-view=true)

#### Sample response

```json
 {
  "id": "aaaabbbb-6666-cccc-7777-dddd8888eeee_ApplicationCredentialExpiry",
  "recommendationType": "applicationCredentialExpiry",
  "createdDateTime": "2022-06-08T00:08:01Z",
  "impactStartDateTime": "2022-06-08T00:08:01Z",
  "postponeUntilDateTime": null,
  "lastModifiedDateTime": "2024-07-29T12:03:16Z",
  "lastModifiedBy": "System",
  "displayName": "Renew expiring application credentials",
  "featureAreas": [
    "applications"
  ],
  "insights": "Your tenant has applications with credentials that will expire soon.",
  "benefits": "Renewing the app credential(s) before its expiration ensures the application continues to function and reduces the possibility of downtime due to an expired credential.",
  "category": "identityBestPractice",
  "status": "active",
  "priority": "high",
  "requiredLicenses": "microsoftEntraWorkloadId",
  "impactType": "apps",
  "actionSteps": [
    {
      "stepNumber": 1,
      "text": "1. Navigate to the App registration section and locate the application for which the credential needs to be rotated."
    },
    {
      "stepNumber": 2,
      "text": "2. Navigate to the “Certificates & Secrets” blade of the app registration."
    },
    {
      "stepNumber": 3,
      "text": "3. Pick the credential type that you want to rotate and navigate to either “Certificates” or “Client Secret” tab and follow the prompts.",
      "actionUrl": null
    },
    {
      "stepNumber": 4,
      "text": "4. Once the certificate or secret is successfully added, update the service code to ensure it works with the new credential and has no negative customer impact. You should use Microsoft Entra ID’s sign-in logs to validate that the thumbprint of the certificate matches the one that was just uploaded.",
      "actionUrl": null
    },
    {
      "stepNumber": 5,
      "text": "5. After validating the new credential, navigate back to the Certificates and Secrets blade for the app and remove the old credential.",
      "actionUrl": null
    }
  ]
}
```

---

## Related content

- [Review the Microsoft Entra recommendations overview](overview-recommendations.md)
- [Learn how to use Microsoft Entra recommendations](howto-use-recommendations.md)
- [Explore the Microsoft Graph API properties for recommendations](/graph/api/resources/recommendation)
- [Learn about app and service principal objects in Microsoft Entra ID](../../identity-platform/app-objects-and-service-principals.md)