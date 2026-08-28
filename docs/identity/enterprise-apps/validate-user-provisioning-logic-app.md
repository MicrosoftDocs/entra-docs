---
title: Set up the validation Logic App in the Azure portal (preview)
description: Create the ISV Onboarding app and deploy the Azure Logic Apps validation template to test your SCIM provisioning integration for Microsoft Entra App Gallery.
author: hsaini
manager: msteele
ms.service: entra-id
ms.subservice: enterprise-apps
ms.topic: how-to
ms.date: 08/26/2026
ms.author: hsaini
ms.reviewer: hsaini
ms.custom: enterprise-apps-article, msecd-doc-authoring-1023
ai-usage: ai-generated

# Customer intent: As an ISV application developer, I want to deploy the validation Logic App in the Azure portal so that I can test my SCIM provisioning integration without using the SCIM onboarding agent.
---

# Set up the validation Logic App in the Azure portal (preview)
The Azure Logic Apps validation template tests your System for Cross-Domain Identity Management (SCIM) provisioning integration against the Microsoft Entra provisioning service. This article shows you how to create the resources and deploy the template yourself, so you keep full control over every step.

As an independent software vendor (ISV), you first create an ISV Onboarding app in the Microsoft Entra admin center and start a provisioning job against your SCIM endpoint. Then you deploy the Logic App, grant it the permissions it needs, set its run parameters, and run the tests.

If you'd rather automate this setup, the SCIM onboarding agent creates the same resources through a conversation in about half the time. For a comparison of both approaches, see [Validate user provisioning for Microsoft Entra App Gallery](validate-user-provisioning-app-gallery.md).

## Prerequisites

- Completion of the prerequisites in [Validate user provisioning for Microsoft Entra App Gallery](validate-user-provisioning-app-gallery.md#prerequisites).
- A verified domain in your Microsoft Entra tenant. The template creates test users in this domain and provisions them to your SCIM endpoint.
- [Azure PowerShell](/powershell/azure/install-azure-powershell) or the [Azure CLI](https://aka.ms/installazurecli), used to deploy the workflows and assign permissions.

## Create the ISV Onboarding app

The Logic App runs its tests through a provisioning job, so you need a working ISV Onboarding app before you deploy the template.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).

1. Browse to **Enterprise applications** > **New application**, and then search for **Entra Gallery Provisioning Test App**.

    :::image type="content" source="media/validate-user-provisioning-logic-app/search-gallery-provisioning-test-app.png" alt-text="Screenshot of the Microsoft Entra App Gallery search results showing the Entra Gallery Provisioning Test App." lightbox="media/validate-user-provisioning-logic-app/search-gallery-provisioning-test-app.png":::

1. Enter a name for your application, and then select **Create**.

1. On the application's **Overview** page, copy the **Object ID**. This value is the `servicePrincipalId` parameter for the Logic App.

    :::image type="content" source="media/validate-user-provisioning-logic-app/service-principal-object-id.png" alt-text="Screenshot of the enterprise application Overview page with the Object ID highlighted." lightbox="media/validate-user-provisioning-logic-app/service-principal-object-id.png":::

1. Select **Provisioning**, set **Provisioning Mode** to **Automatic**, select **New Configuration**, enter your OAuth client credentials, and then select **Test Connection**.

1. Browse to **Provisioning** > **Mappings** > **Provision Users** to create the provisioning job and set up your schema.

    :::image type="content" source="media/validate-user-provisioning-logic-app/provisioning-mappings.png" alt-text="Screenshot of the Provisioning Mappings pane showing the Provision Users mapping." lightbox="media/validate-user-provisioning-logic-app/provisioning-mappings.png":::

1. Prune the schema so it contains only the attributes your SCIM endpoint supports. Select **Show advanced options**, select **Edit attribute list**, and then update or delete attributes to match your endpoint.

    :::image type="content" source="media/validate-user-provisioning-logic-app/edit-attribute-list.png" alt-text="Screenshot of the attribute list editor showing the SCIM attributes that the application supports." lightbox="media/validate-user-provisioning-logic-app/edit-attribute-list.png":::

    Attributes that your endpoint doesn't support cause the `Schema_Discoverability_Test` to fail, so keep the list tight. To export the schema, select **Review your schema here**, and then select **Download** in the schema editor. For more information about mappings, see [Customize attribute mappings](~/identity/app-provisioning/customize-application-attributes.md).

1. On the **Overview** page, select **Start provisioning**. When the job starts without errors, you're ready to deploy the Logic App.

    :::image type="content" source="media/validate-user-provisioning-logic-app/start-provisioning.png" alt-text="Screenshot of the provisioning Overview page with the Start provisioning command highlighted." lightbox="media/validate-user-provisioning-logic-app/start-provisioning.png":::

## Create the Logic App

Create the Logic App in the same tenant as your ISV Onboarding app.

1. Sign in to the [Azure portal](https://portal.azure.com).

1. Search for **Subscriptions**, select the subscription you want to use, and then create a resource group for the Logic App.

1. Search for **Logic apps**, and then select **Add** > **Workflow Service Plan (Standard)**.

    :::image type="content" source="media/validate-user-provisioning-logic-app/create-workflow-service-plan.png" alt-text="Screenshot of the Logic apps creation pane with the Workflow Service Plan Standard option selected." lightbox="media/validate-user-provisioning-logic-app/create-workflow-service-plan.png":::

1. Enter a name and select the resource group you created.

1. On the **Storage** tab, set **Blob service diagnostics settings** to configure now, and then select the default workspace.

1. Leave the remaining settings at their defaults, and then select **Review + create**.

1. When deployment finishes, open the Logic App.

## Deploy the validation workflows

The template ships as a set of workflow definitions in the SCIMReferenceCode repository. You upload them to your Logic App and deploy them with a provided script.

1. Download every file from the [StandardLogicApp folder](https://github.com/AzureAD/SCIMReferenceCode/tree/master/Microsoft.SCIM.LogicAppValidationTemplate/StandardLogicApp) and keep them together in one folder.

1. In your Logic App, select **Development Tools** > **Logic app code view**, paste the contents of `logicAppTemplate.json`, and then select **Save**.

    :::image type="content" source="media/validate-user-provisioning-logic-app/logic-app-code-view.png" alt-text="Screenshot of the Logic app code view pane showing the workflow definition JSON." lightbox="media/validate-user-provisioning-logic-app/logic-app-code-view.png":::

1. Open Azure Cloud Shell or a local terminal, and then upload the downloaded files.

1. On the Logic App **Overview** page, copy the subscription ID, resource group, and Logic App name.

    :::image type="content" source="media/validate-user-provisioning-logic-app/logic-app-overview.png" alt-text="Screenshot of the Logic App Overview page showing the subscription, resource group, and name." lightbox="media/validate-user-provisioning-logic-app/logic-app-overview.png":::

1. Run the deployment script.

    ```azurepowershell
    .\Deploy-LogicAppWorkflows.ps1 `
      -SubscriptionId $subscriptionId `
      -ResourceGroup $resourceGroupName `
      -LogicAppName $LogicAppName
    ```

1. Confirm that all five workflows deployed.

    :::image type="content" source="media/validate-user-provisioning-logic-app/deployed-workflows.png" alt-text="Screenshot of the Logic App Workflows pane listing the deployed validation workflows." lightbox="media/validate-user-provisioning-logic-app/deployed-workflows.png":::

The template uses a nested workflow architecture. `Orchestrator_Workflow` is the entry point and calls the others as child workflows. `Initialization_Workflow` prepares the test run, and `UserTests_Workflow`, `GroupTests_Workflow`, and `SCIMTests_Workflow` hold the tests. The final section of `Orchestrator_Workflow` evaluates the results.

## Grant permissions to the Logic App

The Logic App calls Microsoft Graph to create, update, and delete test users and groups, and to read provisioning logs. Give it a managed identity and assign the roles those calls require.

1. In your Logic App, select **Settings** > **Identity**.

1. On the **System assigned** tab, set **Status** to **On**, select **Yes** in the confirmation dialog, and then select **Save**.

    :::image type="content" source="media/validate-user-provisioning-logic-app/enable-managed-identity.png" alt-text="Screenshot of the Identity pane with the system assigned managed identity status set to On." lightbox="media/validate-user-provisioning-logic-app/enable-managed-identity.png":::

1. Copy the **Object ID** of the managed identity. The permissions script needs this value.

    :::image type="content" source="media/validate-user-provisioning-logic-app/managed-identity-object-id.png" alt-text="Screenshot of the system assigned managed identity showing its object ID." lightbox="media/validate-user-provisioning-logic-app/managed-identity-object-id.png":::

1. Select **Azure role assignments** > **Add role assignment**, and then assign the **Owner** role.

    :::image type="content" source="media/validate-user-provisioning-logic-app/add-owner-role-assignment.png" alt-text="Screenshot of the Add role assignment pane with the Owner role selected." lightbox="media/validate-user-provisioning-logic-app/add-owner-role-assignment.png":::

1. Download [AssignRolesTOManagedIdentity-LogicApps 1.ps1](https://github.com/AzureAD/SCIMReferenceCode/blob/master/Microsoft.SCIM.LogicAppValidationTemplate/AssignRolesTOManagedIdentity-LogicApps%201.ps1), set the `$miObjId` variable to the object ID you copied, and then run the script.

    In Azure Cloud Shell, upload the file first, and then run it from the shell.

When the script finishes, the managed identity holds every role the tests need.

## Set the run parameters

Open `Orchestrator_Workflow` in the designer and select **Parameters**. Save the Logic App after you update the values.

:::image type="content" source="media/validate-user-provisioning-logic-app/orchestrator-parameters.png" alt-text="Screenshot of the Orchestrator Workflow designer with the Parameters command highlighted." lightbox="media/validate-user-provisioning-logic-app/orchestrator-parameters.png":::

| Parameter | Value |
|---|---|
| `servicePrincipalId` | The object ID of the ISV Onboarding app you created. |
| `scimEndpoint` | Your SCIM endpoint URL. Don't include feature flags such as `aadOptscim062020`, even when your ISV Onboarding app uses them. Configure flags only in the **Tenant URL** field of the provisioning configuration. |
| `scimBearerToken` | A bearer token that stays valid for at least 24 hours. |
| `testUserDomain` | A verified domain in your tenant. The tests create users in this domain. |
| `defaultUserProperties` | One or more sets of user property values. The template picks one set at random to create a user and another to update it, so provide at least two sets. |
| `EnabledTests` | A single value that controls which tests run. Use `All` to run everything, or `UserTests`, `GroupTests`, or `SCIMTests` to run one workflow. You can also name an individual test, such as `Create_User_Test`. |
| `scimClientId` | Your OAuth client ID. |
| `scimClientSecret` | Your OAuth client secret. |
| `scimTokenEndpoint` | Your OAuth token endpoint. |

A run that completes all tests cleans up the test users it created. If a run fails partway through or you cancel it, test user stubs can remain in your tenant. Delete them before you run the tests again.

## Run the tests

1. Browse to **Workflows** > **Orchestrator_Workflow**.

1. In the designer, select **Run**.

    :::image type="content" source="media/validate-user-provisioning-logic-app/run-orchestrator-workflow.png" alt-text="Screenshot of the Orchestrator Workflow designer with the Run command highlighted." lightbox="media/validate-user-provisioning-logic-app/run-orchestrator-workflow.png":::

1. Track progress in **Run history**. A full run takes 60–90 minutes.

    :::image type="content" source="media/validate-user-provisioning-logic-app/run-history.png" alt-text="Screenshot of the Orchestrator Workflow run history showing run status and duration." lightbox="media/validate-user-provisioning-logic-app/run-history.png":::

1. Select a run, select the `Final_TestResults` action, and then select **Show raw outputs** to see which tests passed.

To interpret the output and understand which failures block onboarding, see [Validate user provisioning for Microsoft Entra App Gallery](validate-user-provisioning-app-gallery.md#review-your-validation-results). If a test fails, see [Troubleshoot user provisioning validation](troubleshoot-user-provisioning-validation.md).

You can also check a run from the command line with [ValidateLogicAppRun-Standard.ps1](https://github.com/AzureAD/SCIMReferenceCode/blob/master/Microsoft.SCIM.LogicAppValidationTemplate/StandardLogicApp/ValidateLogicAppRun-Standard.ps1).

## Clean up resources

If you no longer need the validation resources, delete the resource group that contains the Logic App. Deleting the resource group removes the Logic App and its workflows, which stops any further cost.

Keep the resources until Microsoft finishes reviewing your submission. Also delete any test users left behind by an incomplete run, and stop the provisioning job on your ISV Onboarding app when you're done testing.

## Next step

> [!div class="nextstepaction"]
> [Submit your validation results](validate-user-provisioning-app-gallery.md#submit-your-validation-results)
