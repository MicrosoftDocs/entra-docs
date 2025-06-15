---
title: Externally determine the approval requirements for an access package using custom extensions (Preview)
description: A how-to guide on dynamically determining the approval requirements for an access package externally using a custom extension.
author: owinfreyATL
manager: dougeby
ms.author: owinfrey
ms.service: entra-id-governance
ms.subservice: entitlement-management
ms.topic: how-to 
ms.date: 04/12/2025

#CustomerIntent: As an IT admin, I want to create custom extensions so that I can determine approvers of an access package externally. 
---


# Externally determine the approval requirements for an access package using custom extensions (Preview)

In entitlement management, approvers for access package requests can either be directly assigned, or determined dynamically. Entitlement management natively supports approvers when they are the requestors manager, their second-level manager, or a sponsor from a connected organization:

:::image type="content" source="media/entitlement-management-dynamic-approval/native-support-diagram.png" alt-text="Screenshot of native support of approvers in Entitlement management." lightbox="media/entitlement-management-dynamic-approval/native-support-diagram.png":::
 
With the inclusion of [custom extensions](entitlement-management-logic-apps-integration.md) calling out to [Azure Logic Apps](/azure/logic-apps/logic-apps-overview), you're able to determine approval based on each of the [ApprovalStage properties](/graph/api/resources/approvalstage?view=graph-rest-beta#properties). For example, if the user requesting an access package is in a department where leadership has recently changed, dynamic approvals can query the system and assign the new department head as the approver.

:::image type="content" source="media/entitlement-management-dynamic-approval/dynamic-extensibility-diagram.png" alt-text="Screenshot of example of determining approvers using custom extensions." lightbox="media/entitlement-management-dynamic-approval/dynamic-extensibility-diagram.png":::

This article walks you through making a custom extension, its underlying Azure Logic App, setting its system-assigned identity and role in the catalog, editing the logic app action to perform business logic, and testing to see if it runs successfully.


## License requirements

[!INCLUDE [active-directory-entra-governance-license.md](~/includes/entra-entra-governance-license.md)]

## Prerequisites

- At least the [Entitlement Management Catalog owner](../id-governance/entitlement-management-delegate.md#entitlement-management-roles) role of the catalog where the custom extension will be created or exists.
- At least the [Azure built-in role](/azure/role-based-access-control/built-in-roles) of [Logic App Contributor](/azure/role-based-access-control/built-in-roles/integration#logic-app-contributor) on the Logic App itself, the resource group, subscription, or management group that the logic app is in. 

## Create the custom extension and Azure Logic App

To create a custom extension, and its underlying Azure Logic App, you'd do the following steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Catalog owner](../id-governance/entitlement-management-delegate.md#entitlement-management-roles) of the catalog where the custom extension will be located.

1. Browse to **ID Governance** > **Entitlement management** > **Catalogs**.

1. On the Catalogs overview page, select an existing catalog where your custom extension will be located, or create a new catalog.

1. On the specific catalog page where you want to create your custom extension, select **Custom extensions**.
    :::image type="content" source="media/entitlement-management-dynamic-approval/extensibility-catalog-screen.png" alt-text="Screenshot of catalog page where custom extension is being added.":::
1. Select **Add a custom extension** to add a name and description for the custom extension. When finished, select **Next**.
    :::image type="content" source="media/entitlement-management-dynamic-approval/custom-extension-basics.png" alt-text="Screenshot of custom extension basics.":::
1. On the **Extension Type** page, select **Request workflow (triggered when an access package is request, approved, granted, or removed)** and select **Next**.
    :::image type="content" source="media/entitlement-management-dynamic-approval/extension-type.png" alt-text="Screenshot of selecting the extension type for a custom extension.":::
1. On the **Extension Configuration** page, for Behavior select **Launch and wait**, for Response data select **Approval Stage (Preview)**, and then select **Next**.

1. On the **Details** page, choose a subscription, resource group, and name for the logic app being created. Once you've entered this information, select **Create a logic app**. Once the logic app is created, select **Next**.

1. On the **Review + create** page, make sure all your details are correct, then select **Create**. 


## Reference the custom extension in an access package assignment policy

Once you've created the custom extension and logic app, you can reference the custom extension in an access package assignment policy by doing the following steps:

1. Select the catalog where the custom extension was created.

1. On the catalog page, select **Access packages**, and select the access package for the policy you want to update.

1. On the access package overview page, select **Policies**, and select the policy to edit.
    :::image type="content" source="media/entitlement-management-dynamic-approval/access-package-policies-list.png" alt-text="Screenshot of the policies list for an access package.":::
1.  On the **Edit policy** page under **Requests**, set the **Require approval** box to yes, and you're able to add your custom extension as an approver. The example here shows the custom extension being used as the first approver.
  :::image type="content" source="media/entitlement-management-dynamic-approval/custom-extension-approver.png" alt-text="Screenshot of the custom extension as first approver in access package policy.":::  
1. Select **Update**.

Once updated, you can go to the edited policy, and confirm the change by selecting **Approval stage details**.
:::image type="content" source="media/entitlement-management-dynamic-approval/access-package-approval-stage-details.png" alt-text="Screenshot of edited approval stage details.":::  

## Set logic app assigned identity and assign its role

With the Azure logic app created, you must enable its system-assigned identity, and give it the proper role by doing the following steps:


1. Sign in to the Azure portal and go to the logic app with the [Azure built-in role](/azure/role-based-access-control/built-in-roles) of at least [Logic App Contributor](/azure/role-based-access-control/built-in-roles/integration#logic-app-contributor).

1. On the logic app overview page, go to **Settings** > **Identity**.

1. On the Identity page, enable the system assigned managed identity
    :::image type="content" source="media/entitlement-management-dynamic-approval/enable-logic-app-identity.png" alt-text="Screenshot of enabling logic app system assigned managed identity.":::
1. Select **Save**.

1. Back in the Microsoft Entra admin center as at least the role of [Catalog owner](../id-governance/entitlement-management-delegate.md#entitlement-management-roles), go to the catalog where you created the custom extension, and select **Roles and administrators**.   

1. On the roles and administrators page, select **Add access package assignment manager**, and select the logic app you created.
    :::image type="content" source="media/entitlement-management-dynamic-approval/add-logic-app-role.png" alt-text="Screenshot of adding logic app as access package assignment manager for a catalog.":::
  

## Configure the logic app and corresponding business logic

With the Azure Logic App given the access package assignment manager role for the catalog, you must now go to logic app to edit it to communicate with Microsoft Entra. To do this, you'd do the following steps:

1. On the logic app created, go to **Development Tools** > **Logic app designer**.

1. On the designer page, remove everything under the **manual** trigger, and select the **Add an action** button.
    :::image type="content" source="media/entitlement-management-dynamic-approval/logic-app-add-action.png" alt-text="Screenshot of  adding action in logic app designer.":::
1. On the Add an Action pane, select **HTTP**.

1. On the **HTTP** pane under Parameters, enter the following parameters:
    - URI: `https://graph.microsoft.com/v1.0@{triggerBody()?['CallbackUriPath']}`
    - Method: POST
    - Authentication Type: Managed identity
    - Managed Identity: System-assigned managed identity
    - Audience: https://graph.microsoft.com
1. Under HTTP Settings, disable **Asynchronous Pattern**. 
    :::image type="content" source="media/entitlement-management-dynamic-approval/disable-asynchronous-pattern.png" alt-text="Screenshot of disabling asynchronous pattern in a logic app http call.":::
1. After you've made changes to the HTTP trigger, select **Save**. 

## Add business logic to the logic app

With the logic app configured for communication with Microsoft Entra, you can now add what you want the app to do. Logic app actions are added to the body of the **HTTP** section you configured for the logic app. To edit this, you do the following:

1. On the logic app created, go to **Development Tools** > **Logic app designer**.

1. On the logic app designer page, select **HTTP**.

1. On the HTTP pane under **Parameters**, scroll down to **Body** and enter your logic data based on the parameters you want to query for. For more information, see: [Call external HTTP or HTTPS endpoints from workflows in Azure Logic Apps](/azure/connectors/connectors-native-http?tabs=standard).
    :::image type="content" source="media/entitlement-management-dynamic-approval/logic-app-business-logic.png" alt-text="Screenshot of adding business logic to logic app.":::
    > [!NOTE]
    > For an example of the body action see: [HTTP action example](entitlement-management-dynamic-approval.md#http-action-example).
1. When finished adding your business logic, select **save**.


## Verify the extension worked

To verify that the custom extension works, you can request access to the access package, and view the request details via **Requests** on the access package page by following these steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Catalog owner](../id-governance/entitlement-management-delegate.md#entitlement-management-roles) of the catalog where the custom extension is located.
    > [!TIP]
    > Other least privilege roles that can complete this task include the Access package manager, Access package assignment manager, and Identity Governance Administrator.
1. Browse to **ID Governance** > **Entitlement management** > **Access package**.

1. On the Access packages page, open the access package you want to view requests of.

1. Select **Requests**.

1. On the requests page, select the request you want to view details of and confirm that the access package was successfully delivered.
    :::image type="content" source="media/entitlement-management-dynamic-approval/access-package-request-details.png" alt-text="viewing the details of the request for the access package.":::
    

## HTTP action example

The following example of an action that can be placed in the HTTP body is a logic app that identifies the primary approver. [You have to pass your own variable](/azure/logic-apps/logic-apps-create-variables-store-values?tabs=consumption) into this code where prompted:

```
{
  "data": {
    "@@odata.type": "microsoft.graph.assignmentRequestApprovalStageCallbackData",
    "approvalStage": {
      "durationBeforeAutomaticDenial": "P2D",
      "escalationApprovers": [],
      "fallbackEscalationApprovers": [],
      "fallbackPrimaryApprovers": [],
      "isApproverJustificationRequired": false,
      "isEscalationEnabled": false,
      "primaryApprovers": [
        {
          "@@odata.type": "#microsoft.graph.singleUser",
          "description": "This is the primary approver for the access package requested by the user.",
          "id": "<Dynamically assigned variable>",
          "isBackup": false
        }
      ]
    },
    "customExtensionStageInstanceDetail": "A approval stage from Logic Apps",
    "customExtensionStageInstanceId": "@{triggerBody()?['CustomExtensionStageInstanceId']}",
    "stage": "assignmentRequestDeterminingApprovalRequirements"
  },
  "source": "Entra",
  "type": "microsoft.graph.accessPackageCustomExtensionStage.assignmentRequestCreated"
}
```

Although the example uses a user ID, the primaryApprovers and escalationApprovers section can contain any valid [subjectSet](/graph/api/resources/subjectset). The approval section of the code must follow the parameters as shown here: [accessPackageApprovalStage](/graph/api/resources/accesspackageapprovalstage).

> [!NOTE]
> While the Logic App is being called against the Beta version of the API, the parameters are using the v1.0 endpoint.

## Related content

- [Trigger Logic Apps with custom extensions in entitlement management](entitlement-management-logic-apps-integration.md)
- [Tutorial: Integrating Microsoft Entra Entitlement Management with Microsoft Teams using Custom Extensibility and Logic Apps](entitlement-management-custom-teams-extension.md)
