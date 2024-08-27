---
title: 'Best practices for securing the custom extension extensibility to Azure Logic Apps'
description: This is a reference guide on best practices when securing custom extension extensibility to Azure Logic Apps
author: owinfreyATL
ms.author: owinfrey
ms.service: entra-id-governance
ms.topic: best-practice
ms.date: 08/14/2024

#CustomerIntent: As an administrator I want to learn the best practices for securing custom extension extensibility to Azure Logic Apps.
---


# Best practices for securing the custom extension extensibility to Azure Logic Apps

This article describes the best practices for securing the Microsoft Entra ID Governance custom extension extensibility to Azure Logic Apps. The guidance is specific to [Entitlement Management](../id-governance/entitlement-management-logic-apps-integration.md) and [Lifecycle Workflows](../id-governance/lifecycle-workflow-extensibility.md) and complementary to the [general security guidance](/azure/logic-apps/logic-apps-securing-a-logic-app?tabs=azure-portal) published for Azure Logic Apps.

The best practices described in this article include:

-	Secure administrative access to the subscription
-	Disable shared access signature (SAS)
-	Use managed identities for authentication
-	Authorize with least privileged permissions
-	Ensure Proof-of-Possession (PoP) usage

## Secure administrative access to the subscription

The administrative access to the Azure Subscriptions hosting your Logic Apps should be secured. We recommend following the Cloud Adoption Framework, and if possible, placing the Logic Apps in the Identity Subscription. For more information, see:[What is an Azure landing zone?](/azure/cloud-adoption-framework/ready/landing-zone/#azure-landing-zone-architecture)


## Disable shared access signature (SAS)

Inbound calls to Logic Apps can use only one authorization scheme, [Microsoft Entra ID access tokens](/azure/logic-apps/logic-apps-securing-a-logic-app?tabs=azure-portal#enable-microsoft-entra-id-open-authentication-microsoft-entra-id-oauth), or [shared access signature (SAS)](/azure/logic-apps/logic-apps-securing-a-logic-app?tabs=azure-portal#sas). Using one scheme, however, doesn't disable the other scheme. Calls from Microsoft Entra ID Governance to Logic Apps are authorized via the Microsoft Entra ID access token authorization scheme. 

**We highly recommend you disable the shared access signature (SAS) authorization scheme on your Logic Apps as it is not required by Microsoft Entra ID Governance.** Disabling the shared access signature (SAS) authorization scheme eliminates the risk of the signature being exposed, or subject, to unauthorized access.

All Logic Apps created via the Microsoft Entra ID Governance custom extensions user interfaces after April 29, 2024 have the shared access signature (SAS) authorization scheme disabled by default.

If you created a Logic App via the Microsoft Entra ID Governance custom extensions user interfaces on, or before, April 29, 2024,  follow the guidance to disable the shared access signature (SAS) authorization scheme located here: [Disable shared access signature (SAS) authentication (Consumption only)](/azure/logic-apps/logic-apps-securing-a-logic-app?tabs=azure-portal#disable-shared-access-signature-sas-authentication-consumption-only).



## Use managed identities for authentication 

The management of secrets, credentials, certificates, and keys used to secure communication between services is a common challenge and [managed identities](../identity/managed-identities-azure-resources/overview.md) eliminate the need to manage these credentials. If you're using the custom extension "launch and wait" pattern([entitlement management reference](entitlement-management-logic-apps-integration.md#configuring-custom-extensions-that-pause-entitlement-management-processes); [Lifecycle Workflow reference](lifecycle-workflow-extensibility.md#custom-task-extension-deployment-scenarios)), we highly recommend you enable the Azure Logic Apps managed identity to authenticate the resume calls([taskProcessingResult: resume](/graph/api/identitygovernance-taskprocessingresult-resume); [accessPackageAssignmentRequest: resume](/graph/api/accesspackageassignmentrequest-resume)) to Microsoft Entra ID Governance. If your scenario requires the Logic App to call other Microsoft Graph endpoints, or even other Microsoft Entra integrated services, you can also use the managed identity to authenticate calls against these services.


**Entitlement Management**: You'll have to enable the managed identity yourself. For information on this process, see: [Enable system-assigned identity in the Azure portal](/azure/logic-apps/authenticate-with-managed-identity?tabs=consumption#enable-system-assigned-identity-in-the-azure-portal) and then [authorize it](custom-extension-security.md#assigning-least-privileged-permissions-with-entitlement-management).

**Lifecycle Workflows**: The managed identity is automatically enabled and authorized for "launch and wait" custom extensions. If your Logic App needs to call other services, you can use and authorize the same managed identity. For ‘*launch and continue*’ custom extensions, you'll have to enable the managed identity yourself.

For steps on how to use the managed identity with a Logic Apps action, see: [Authenticate access with managed identity.](/azure/logic-apps/authenticate-with-managed-identity?tabs=consumption#authenticate-access-with-managed-identity).


## Authorize with least privileged permissions

The resume calls from Logic Apps to Microsoft Entra ID Governance can be authorized directly within Lifecycle Workflows and Entitlement Management. When authorized directly, you're **NOT** required to assign the managed identity application permissions such as LifecycleWorkflows.ReadWrite.All or Entitlement Management.ReadWrite.All. 

Guidance for assigning the least privileged permissions:

### Assigning least privileged permissions with entitlement management

Assign the managed identity the ‘**access package assignment manager**’ role for a given catalog to authorize the resume call. For more general guidance on how to assign roles for a catalog, see: [As a catalog owner, delegate to an access package manager](entitlement-management-delegate-managers.md#as-a-catalog-owner-delegate-to-an-access-package-manager). 


### Assigning least privileged permissions with lifecycle workflows

The managed identity can be directly authorized for the resume call within the custom extension settings. Lifecycle workflows automatically set this up for you during the custom extension creation process. For more information, see: [Response authorization](lifecycle-workflow-extensibility.md#response-authorization).

### Assigning least privileged permissions with other services and scenarios

If you need to authorize the Logic App to call other services integrated with Microsoft Entra, such as other Microsoft Graph APIs, consider that the managed identity can also get privileges through role assignments in various role-based access control systems, which often allow you to follow the principle of least privilege. Nonexhaustive list of examples include:

- If your Entitlement Management custom extension needs to query additional information from Entitlement Management you can assign the Logic App one of the [roles](entitlement-management-delegate.md) in Entitlement Management, such as catalog reader, for a given catalog. This allows you to reduce the permissions and scope compared to the tenant-wide EntitlementManagement.Read.All and/or EntitlementManagement.ReadWrite.All application permissions. 
- If you want to use a Lifecycle Workflow custom extension to generate a temporary access pass opposed to the [built-in task](lifecycle-workflow-tasks.md#generate-temporary-access-pass-and-send-via-email-to-users-manager), you can assign the managed identity the authentication administrators Microsoft Entra built-in role scoped to an administrative unit, opposed to assigning it the UserAuthenticationMethod.ReadWrite.All application permissions, which would drastically increase the blast radius if the Logic App would get compromised.

For more information regarding Microsoft Graph authorization, see: [Get access without a user](/graph/auth-v2-service).

## Ensure Proof-of-Possession (PoP) usage

Logic Apps supports either the [bearer](../identity-platform/v2-protocols.md#tokens), or [proof-of-possession](/entra/msal/dotnet/advanced/proof-of-possession-tokens), type access tokens for the [Microsoft Entra ID access token](/azure/logic-apps/logic-apps-securing-a-logic-app?tabs=azure-portal#enable-microsoft-entra-id-open-authentication-microsoft-entra-id-oauth) authorization scheme. At the beginning of the Microsoft Entra ID Governance custom extensions public preview, bearer, opposed to Proof-of-Possession (PoP), access tokens were used to authorize the calls from Microsoft Entra ID Governance to Logic Apps.

Since moving to general availability, all custom extensions created via Microsoft Entra ID Governance user interfaces, and Microsoft Graph v1.0 endpoints, are by default using the [proof-of-possession](/entra/msal/dotnet/advanced/proof-of-possession-tokens) access tokens authorization scheme.

**If your environment still contains custom extensions relying on bearer type access tokens, we recommend switching to proof-of-possession type access tokens.**

To determine the authorization scheme currently used by your custom extensions, refer to the token security column shown in the Microsoft Entra admin center:

:::image type="content" source="media/custom-extension-security/custom-extension-check-token.png" alt-text="Screenshot of task list with token section visible.":::


|Access token type  |Microsoft Entra admin center token security column  |
|---------|---------|
|Bearer     |  Regular        |
|Proof-of-Possession (PoP)     |  Proof-of-possession       |

Lifecycle Workflows custom extensions can't be migrated from bearer to proof-of-possession type access tokens. You have to create new custom extensions and configure them in the corresponding workflows.

For a subset of Entitlement Management custom extensions, you can use the ‘Update to new extension type’ option available via the Entitlement Management user interface. To complete this you'd do the following:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Identity Governance Administrator](../identity/role-based-access-control/permissions-reference.md#identity-governance-administrator).

1. Browse to **Identity governance** > **Entitlement management** > **Catalogs**. 

1. Select the catalog with the custom extension you want to update.

1. On the catalog overview page, select **Custom extensions**.

1. On the custom extensions page, find a custom extension whose token security says *Regular* and select the three lines next to it.
    :::image type="content" source="media/custom-extension-security/update-to-new-type.png" alt-text="Screenshot of the update to new type of token security.":::
1. Select **Update to new extension type**.  

> [!NOTE]
> If the update function fails, a new custom extension must be created and configured in the corresponding access package assignment policies.

## Related content

- [Lifecycle Workflows custom task extension](lifecycle-workflow-extensibility.md)
- [Trigger Logic Apps with custom extensions in entitlement management](entitlement-management-logic-apps-integration.md)
