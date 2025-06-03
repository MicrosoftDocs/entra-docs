---
title: Customize claims using Microsoft Graph Custom Claims Policy (preview)
description: This article demonstrates how to customize claims in Microsoft Entra ID using the Custom Claims Policy.
documentationcenter: .net
author: cilwerner
ms.service: identity-platform
ms.topic: how-to
ms.date: 06/11/2024
ms.author: cwerner
ms.reviewer: 
ms.custom: 
#Customer intent: As an identity admin, I want to customize the claims emitted in tokens.
---

# Customize claims using Microsoft Graph Custom Claims Policy (preview)

A claim is information that an identity provider states about a user inside the token they issue for that user. Claims customization is used by tenant admins to customize the claims emitted in tokens for a specific application in their tenant. Claims customization supports configuring claims for applications using SAML, OAuth, and OpenID Connect protocols. You can use claims customization to:

- Select which claims are included in tokens.
- Create claim types that don't already exist.
- Choose or change the source of data emitted in specific claims.

In this how-to guide, we cover a few common scenarios that can help you understand how to use the [Custom Claims policy](/graph/api/resources/customclaimspolicy). 

## Prerequisites

- A [Microsoft Entra tenant](~/external-id/customers/quickstart-tenant-setup.md).
- An [Enterprise Application](/entra/identity/enterprise-apps/add-application-portal) configured in the Microsoft Entra admin center.
- For PowerShell users, download the latest [Microsoft Graph PowerShell SDK](/powershell/microsoftgraph/installation). This step is optional.

## Claims customization in Microsoft Entra ID

Microsoft Entra ID supports two ways to customize claims using Microsoft Graph/PowerShell for your applications:
- Using [Custom Claims Policy (Preview)](/graph/api/resources/customclaimspolicy)
- Using [Claims Mapping Policy](/graph/api/resources/claimsmappingpolicy)

In the following examples, you create, update, and replace policies for service principals. Custom claims policies are always linked to [service principal](/graph/api/resources/serviceprincipal) objects. Be sure that you've configured your Enterprise Application as part of the prerequisites before creating a Custom Claims policy for the application/service principal.

Open Microsoft Graph Explorer in your browser sign in to Microsoft Graph Explorer as at least an [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator), choose one of the following scenarios.

- [Omit the basic claims from tokens](#omit-the-basic-claims-from-tokens)
- [Include the EmployeeID and TenantCountry as claims in tokens](#include-the-employeeid-and-tenantcountry-as-claims-in-tokens)
- [Use a claims transformation in tokens](#use-a-claims-transformation-in-tokens)

After creating a Custom Claims policy, you should configure your application to acknowledge that the tokens contain the customized claims. For more information, refer to [Security considerations](jwt-claims-customization.md#security-considerations).

### Omit the basic claims from tokens

In this example, you create a custom claims policy that removes the [basic claim set](reference-claims-customization.md#claim-sets) from tokens issued to the linked service principal.

1. In Microsoft Graph Explorer, identify the application you want to configure the custom claims policy for using the [service principal API](/graph/api/resources/serviceprincipal).
1. Create the Custom Claims policy by running the following API. This policy, linked to a service principal, omits the basic claims from the tokens.

    ```http
    PUT https://graph.microsoft.com/beta/servicePrincipals/<servicePrincipal-id>/claimsPolicy
    ```
    Request Body:
    ```json
    {
        "includeBasicClaimSet": false
    }
    ```

1.	To see your new policy, run the following command

    ```http
    GET https://graph.microsoft.com/beta/servicePrincipals/<servicePrincipal-id>/claimsPolicy
    ```

    Response:
    ```json
    HTTP/1.1 200 OK
    Content-type: application/json
    
    {
        "@odata.context": "…",
        "id": "aaaaaaaa-bbbb-cccc-1111-222222222222.",
        "includeBasicClaimSet": false,
        "includeApplicationIdInIssuer": false,
        "audienceOverride": null,
        "groupFilter": null,
        "claims": []
    }
    ```


### Include the `EmployeeID` and `TenantCountry` as claims in tokens

In this example, you create a customization to the claims that adds the `EmployeeID` and `TenantCountry` to tokens. In this example, we also include the basic claims set in the tokens.
1.	 In Microsoft Graph Explorer, identify the application you want to configure the custom claims policy for using the [service principal API](/graph/api/resources/serviceprincipal).
1. Create the Custom Claims policy by running the following API. This policy, linked to a service principal, adds the EmployeeID and TenantCountry claims to tokens.

    ```http
    PUT https://graph.microsoft.com/beta/servicePrincipals/<servicePrincipal-id>/claimsPolicy
    ```
    Request Body:
    ```json
    {
        "includeBasicClaimSet": true,
        "claims": [
            {
                "@odata.type": "#microsoft.graph.customClaim",
                "name": "employeeId",
                "namespace": null,
                "tokenFormat": [
                    "jwt"
                ],
                "samlAttributeNameFormat": null,
                "configurations": [
                    {
                        "condition": null,
                        "attribute": {
                            "@odata.type": "#microsoft.graph.sourcedAttribute",
                            "id": " employeeId",
                            "source": "user",
                            "isExtensionAttribute": false
                        },
                        "transformations": []
                    }
                ]
            },
            {
                "@odata.type": "#microsoft.graph.customClaim",
                "name": "country",
                "namespace": null,
                "tokenFormat": [
                    "jwt"
                ],
                "samlAttributeNameFormat": null,
                "configurations": [
                    {
                        "condition": null,
                        "attribute": {
                            "@odata.type": "#microsoft.graph.sourcedAttribute",
                            "id": " tenantcountry",
                            "source": "user",
                            "isExtensionAttribute": false
                        },
                        "transformations": []
                    }
                ]
            }
        ]
    }
    ```
    
1.	To see your new policy, run the following command:

    ```http
    GET https://graph.microsoft.com/beta/servicePrincipals/<servicePrincipal-id>/claimsPolicy
    ```
    
    Response:
    ```json
    {
        "@odata.context": "…",
        "id": "aaaaaaaa-bbbb-cccc-1111-222222222222",
        "includeBasicClaimSet": true,
        "includeApplicationIdInIssuer": false,
        "audienceOverride": null,
        "groupFilter": null,
        "claims": [...]
    }
    ```

### Use a claims transformation in tokens

In this example, you update a policy to emit a custom claim "JoinedData" to JWTs issued to linked service principals. This claim contains a value created by joining the data stored in the extensionattribute1 attribute on the user object with "-ext". In this example, we exclude the basic claims set in the tokens.
1.	In Microsoft Graph Explorer, identify the application you want to configure the custom claims policy for using the [service principal API](/graph/api/resources/serviceprincipal).
1.	Create the custom claims policy by running the following API. This policy emits a custom claim `JoinedData` to tokens.
    ```http
    PATCH https://graph.microsoft.com/beta/servicePrincipals/<servicePrincipal-id>/claimsPolicy
    ```
    
    Request Body:
    ```json
    {
        "includeBasicClaimSet": true,
        "claims": 
        [
            {
                "@odata.type": "#microsoft.graph.customClaim",
                "name": "JoinedData",
                "namespace": null,
                "tokenFormat": [
                    "jwt"
                ],
                "samlAttributeNameFormat": null,
                "configurations": 
                [
                    {
                        "condition": null,
                        "attribute": null,
                        "transformations": 
                        [
                            {
                                "@odata.type": "#microsoft.graph.joinTransformation",
                                "separator": "-",
                                "input": 
                                {
                                    "treatAsMultiValue": false,
                                    "attribute": 
                                    {
                                        "@odata.type": "#microsoft.graph.sourcedAttribute",
                                        "id": "extensionattribute1",
                                        "source": "user",
                                        "isExtensionAttribute": false
                                    }
                                },
                                "input2": 
                                {
                                    "treatAsMultiValue": false,
                                    "attribute": 
                                    {
                                        "@odata.type":"#microsoft.graph.valueBasedAttribute",
                                        "value": "ext"
                                     }
                                }
                            }
                        ]
                    }
                ]
            }
        ]
    }
    ```

    > [!NOTE]
    > Custom Claims Policy is a strongly typed policy and each transformation uses a different `@odata.type` value.

1.	To see your new policy, and to get the policy `ObjectId`, run the following command:

    ```http
    GET https://graph.microsoft.com/beta/servicePrincipals/<servicePrincipal-id>/claimsPolicy
    ```
    Response:
    ```json
    {
        "@odata.context": "…",
        "id": "aaaaaaaa-bbbb-cccc-1111-222222222222",
        "includeBasicClaimSet": true,
        "includeApplicationIdInIssuer": false,
        "audienceOverride": null,
        "groupFilter": null,
        "claims": [...]
    }
    ```

## Related content

- Learn more about the differences between policies in [Claims customization using a policy](reference-claims-customization.md#claims-customization-using-a-policy)
- [Microsoft Graph identity sign-ins](/powershell/module/microsoft.graph.identity.signins)
