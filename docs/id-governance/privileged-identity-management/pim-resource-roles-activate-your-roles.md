---
title: Activate Azure resource roles in PIM
description: Learn how to activate eligible Azure resource roles with Microsoft Entra Privileged Identity Management (PIM) to manage Azure resources.
ms.author: tamimsangrar
ms.date: 11/16/2026
ms.topic: how-to
ai-usage: ai-assisted
ms.custom:
  - pim
  - sfi-image-nochange
  - msecd-doc-authoring-1031
zone_pivot_groups: pim-azure-role-activation-portals
#customer intent: As a user with eligible Azure resource role assignments, I want to activate my roles so that I can manage Azure subscriptions and resources when needed.
---

# Activate my Azure resource roles in Privileged Identity Management

Use Microsoft Entra Privileged Identity Management (PIM) to allow eligible role members for Azure resources to schedule activation for a future date and time. They can also select a specific activation duration within the maximum (configured by administrators).

This article is for members who need to activate their Azure resource role in Privileged Identity Management.

> [!NOTE]
> Agents and agent identities can receive and activate eligible Azure resource role assignments in preview. Each agent or agent identity requires an E7 license. See [agent preview requirements](pim-resource-roles-assign-roles.md#eligible-assignments-for-agents-preview). For activation, see [Agent identity API activation (preview)](pim-resource-roles-activate-your-roles.md?pivots=api#activate-an-agent-identity-with-azure-resource-manager-api-preview).

Choose the method you will use to activate your Azure role assignment.

>[!IMPORTANT]
>When a role is activated, Microsoft Entra PIM temporarily adds active assignment for the role. Microsoft Entra PIM creates active assignment (assigns user to a role) within seconds. When deactivation (manual or through activation time expiration) happens, Microsoft Entra PIM removes the active assignment within seconds as well.
>
>Application may provide access based on the role the user has. In some situations, application access may not immediately reflect the fact that user got role assigned or removed. If application previously cached the fact that user does not have a role – when user tries to access application again, access may not be provided. Similarly, if application previously cached the fact that user has a role – when role is deactivated, user may still get access. Specific situation depends on the application’s architecture. For some applications, signing out and signing back in may help get access added or removed.

::: zone pivot="entra-admin-center"

<a name="activate-a-role"></a>

## Activate a role in the Microsoft Entra admin center

When you need to take on an Azure resource role, you can request activation by using the **My roles** navigation option in Privileged Identity Management.

>[!NOTE]
> PIM is now available in the Azure mobile app (iOS | Android) for Microsoft Entra ID and Azure resource roles. Easily activate eligible assignments, request renewals for ones that are expiring, or check the status of pending requests. [Activate roles with the Azure mobile app](pim-resource-roles-activate-your-roles.md?pivots=azure-mobile-app#activate-pim-roles-using-the-azure-mobile-app)

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).

1. Browse to **Identity Governance** > **Privileged Identity Management** > **My roles**.

    [![Screenshot of my roles page showing roles you can activate.](./media/pim-resource-roles-activate-your-roles/resources-my-roles.png)](./media/pim-resource-roles-activate-your-roles/resources-my-roles.png#lightbox)

1. Select **Azure resources** to see a list of your eligible Azure resource roles.

      ![Screenshot of my roles - Azure resource roles page.](./media/pim-resource-roles-activate-your-roles/resources-my-roles-azure-resources.png)

1. In the **Azure resource roles** list, find the role you want to activate.

    [![Screenshot of azure resource roles - My eligible roles list.](./media/pim-resource-roles-activate-your-roles/resources-my-roles-activate.png)](./media/pim-resource-roles-activate-your-roles/resources-my-roles-activate.png#lightbox)

1. Select **Activate** to open the Activate page.

      ![Screenshot of the opened Activate pane with scope, start time, duration, and reason.](./media/pim-resource-roles-activate-your-roles/azure-role-eligible-activate.png)

1. If your role requires multifactor authentication, select **Verify your identity before proceeding**. You only have to authenticate once per session.

1. Select **Verify my identity** and follow the instructions to provide additional security verification.

      ![Screenshot of screen to provide security verification such as a PIN code.](./media/pim-resource-roles-activate-your-roles/resources-mfa-enter-code.png)

1. It's a best practice to only request access to the resources you need. If you want to specify a reduced scope.

    1. Go to the **Scope** tab.
    1. Click **Select scope** to select the scope.

        :::image type="content" source="./media/pim-resource-roles-activate-your-roles/activate-billing-reader-select-scope.png" alt-text="Screenshot of the Scope tab in the Activate - Billing Reader pane, showing the 'Select scope' button and a management group listed under Selected resources. This helps users identify where to click to begin scoping their activation request.":::

    1. Use the dropdown provided to scope the search to a specific resource.
    1. The reduced scoped resources are shown in **Selected resources** before activation and should be selected from the grid provided. The dropdown selection does not define the reduced scope.

        :::image type="content" source="./media/pim-resource-roles-activate-your-roles/active-billing-reader-set-scope.png" alt-text="Screenshot showing the process of setting the scope for activation, with a management group selected in the grid. This image demonstrates how to confirm the correct resource is selected before proceeding with activation.":::

        >[!NOTE]
        >If your eligibility is at the management group level, the dropdown will show all direct child resources (management group and subscription). You can select either a management group or subscription from the grid shown, or further scope down the search by selecting the appropriate management group or subscription.

        ![Screenshot of activate - Resource filter pane to specify scope.](./media/pim-resource-roles-activate-your-roles/resources-my-roles-resource-filter.png)

1. If necessary, specify a custom activation start time. The member would be activated after the selected time.

1. In the **Reason** box, enter the reason for the activation request.

1. Optional: If your administrator enabled [Allow least-privilege role activation](pim-resource-roles-configure-role-settings.md#allow-least-privilege-role-activation) on the policy for your eligible role, select the **Role** tab. In the **Role** dropdown, choose an available lower-privileged role whose permissions are sufficient for your task.

    The eligible role's policy governs approval, authentication, justification, and activation maximum duration, including selection of a lower-privileged role.

    :::image type="content" source="media/pim-resource-roles-activate-your-roles/entra-manual-role-selection.png" alt-text="Screenshot of the Role tab in the Microsoft Entra admin center activation pane, showing the Role dropdown for manual role selection." lightbox="media/pim-resource-roles-activate-your-roles/entra-manual-role-selection.png":::

1. Optional: To request a Microsoft Security Copilot recommendation, select the **Activate** tab and review the task description in the **Reason** box. Select **Copilot can recommend a lower-privileged role**.

    This option requires **Allow least-privilege role activation** to be enabled and access to Microsoft Security Copilot in your tenant. A default Security Copilot workspace must be available for the Microsoft Entra integration, and you must have access to it. Recommendations consume security compute units (SCUs). You can select a role manually without Copilot when **Allow least-privilege role activation** is enabled.

    :::image type="content" source="media/pim-resource-roles-activate-your-roles/entra-copilot-request.png" alt-text="Screenshot of the Activate tab with the Reason box and the Copilot can recommend a lower-privileged role button." lightbox="media/pim-resource-roles-activate-your-roles/entra-copilot-request.png":::

    Review the recommended role and its suitability for your task. To use it, select **Switch to the recommended role**. Copilot doesn't create eligible role assignments or activate a role on your behalf. The eligible role's policy requirements still apply.

    :::image type="content" source="media/pim-resource-roles-activate-your-roles/entra-copilot-recommendation.png" alt-text="Screenshot of a Copilot role recommendation with the Switch to the recommended role button and a separate Activate button." lightbox="media/pim-resource-roles-activate-your-roles/entra-copilot-recommendation.png":::

1. Select **Activate**.

      >[!NOTE]
      >If the [role requires approval](pim-resource-roles-approval-workflow.md) to activate, a notification will appear in the upper right corner of your browser informing you the request is pending approval.

::: zone-end

::: zone pivot="azure-portal"

<a name="activate-with-azure-portal"></a>

## Activate a role in the Azure portal

Privileged Identity Management role activation is integrated into the Billing and Access Control (AD) extensions within the Azure portal. Shortcuts to Subscriptions (billing) and Access Control (AD) allow you to activate PIM roles directly from these blades.

From the Subscriptions blade, select “View eligible subscriptions” in the horizontal command menu to check your eligible, active, and expired assignments. From there, you can activate an eligible assignment in the same pane.

  ![Screenshot of view eligible subscriptions on the Subscriptions page.](./media/pim-resource-roles-activate-your-roles/view-subscriptions-1.png)

  ![Screenshot of view eligible subscriptions on the Cost Management: Integration Service page.](./media/pim-resource-roles-activate-your-roles/view-subscriptions-2.png)

In Access control (IAM) for a resource, you can now select “View my access” to see your currently active and eligible role assignments and activate directly.

  ![Screenshot of current role assignments on the Measurement page.](./media/pim-resource-roles-activate-your-roles/view-my-access.png)

By integrating PIM capabilities into different Azure portal blades, this new feature allows you to gain temporary access to view or edit subscriptions and resources more easily.

::: zone-end

::: zone pivot="entra-admin-center"

## View the status of your requests

You can view the status of your pending requests to activate.

1. Open Microsoft Entra Privileged Identity Management.

1. Select **My requests** to see a list of your Microsoft Entra role and Azure resource role requests.

    [![Screenshot of my requests - Azure resource page showing your pending requests.](./media/pim-resource-roles-activate-your-roles/resources-my-requests.png)](./media/pim-resource-roles-activate-your-roles/resources-my-requests.png#lightbox)

1. Scroll to the right to view the **Request Status** column.

## Cancel a pending request

If you don't require activation of a role that requires approval, you can cancel a pending request at any time.

1. Open Microsoft Entra Privileged Identity Management.

1. Select **My requests**.

1. For the role that you want to cancel, select the **Cancel** link.

    When you select Cancel, the request will be canceled. To activate the role again, you will have to submit a new request for activation.

      ![Screenshot of my request list with Cancel action highlighted.](./media/pim-resource-roles-activate-your-roles/resources-my-requests-cancel.png)

::: zone-end

::: zone pivot="my-access"

<a name="activate-an-azure-resource-role-in-my-access"></a>
<a name="activate-an-azure-resource-role-in-my"></a>
<a name="activate-an-azure-resource-role-in-my-portal"></a>

<a name="activate-an-azure-resource-role-in-my-access-portal"></a>

## Activate an Azure resource role in My Access portal (Preview)

Use [**Roles**](https://aka.ms/pim/roles) under **My Access** in the [My Access portal](../my-access-portal-overview.md) to activate an eligible Azure resource role assignment.

Azure resource role assignment activation through the My Access portal is in preview. Activation uses an existing eligible role assignment to give your signed-in identity temporary access.

1. Sign in to the [My Access portal](https://myaccess.microsoft.com) in the tenant where you have an eligible role assignment.

1. Under **My Access**, select [**Roles**](https://aka.ms/pim/roles), and then select **Azure Roles**.

1. Find the role assignments and select **Activate**.

    :::image type="content" source="media/pim-resource-roles-activate-your-roles/my-access-azure-roles.png" alt-text="Screenshot of My Access Azure roles showing eligible role assignments and their Activate actions." lightbox="media/pim-resource-roles-activate-your-roles/my-access-azure-roles.png":::

1. Review the role assignment, start time, and duration. Enter a **Justification** that describes the task you need to complete.

    :::image type="content" source="media/pim-resource-roles-activate-your-roles/my-access-role-activation.png" alt-text="Screenshot of the Role Activation dialog showing role details, justification, and the Customize action." lightbox="media/pim-resource-roles-activate-your-roles/my-access-role-activation.png":::

1. Optional: If your administrator enabled [Allow least-privilege role activation](pim-resource-roles-configure-role-settings.md#allow-least-privilege-role-activation) on the policy for your eligible role, select **Customize**. Choose an available lower-privileged role from the **Role** dropdown whose permissions are sufficient for your task.

    The eligible role's policy governs approval, authentication, justification, and activation maximum duration, including selection of a lower-privileged role.

    :::image type="content" source="media/pim-resource-roles-activate-your-roles/my-access-customize-role.png" alt-text="Screenshot of the customized Role Activation dialog with the Role dropdown open and alternative roles available." lightbox="media/pim-resource-roles-activate-your-roles/my-access-customize-role.png":::

1. Optional: To request a Microsoft Security Copilot recommendation, follow [Get a role recommendation](#get-a-role-recommendation-with-microsoft-security-copilot), and then return to the final activation step.

1. Review the selected role assignment and role activation details, complete the requirements from the eligible role's policy, and select **Activate** to submit your role assignment activation request.

    If approval is required, wait for approval before using the role.

## Get a role recommendation with Microsoft Security Copilot

Microsoft Security Copilot can recommend an available lower-privileged Azure resource role based on your activation justification. It doesn't create eligible role assignments or activate a role on your behalf.

This step requires **Allow least-privilege role activation** to be enabled and access to Microsoft Security Copilot in your tenant. A default Security Copilot workspace must be available for the Microsoft Entra integration, and you must have access to it. Recommendations consume security compute units (SCUs). If these workspace requirements aren't met, the recommendation control will not be shown to you. You can still select a role manually when **Allow least-privilege role activation** is enabled.

1. Open the Azure resource role activation dialog in the [My Access portal](../my-access-portal-overview.md) and enter a **Justification** that describes your task.

1. Under **Suggest a least-privileged role**, select **Suggest**.

1. Review the recommended role. Select **Apply suggestion** to use it, or **Dismiss** to keep your current selection.

    :::image type="content" source="media/pim-resource-roles-activate-your-roles/my-access-copilot-recommendation.png" alt-text="Screenshot of a Copilot role recommendation showing Virtual Machine User Login with Apply suggestion and Dismiss actions." lightbox="media/pim-resource-roles-activate-your-roles/my-access-copilot-recommendation.png":::

    :::image type="content" source="media/pim-resource-roles-activate-your-roles/my-access-copilot-role-selected.png" alt-text="Screenshot of the Role Activation dialog with Virtual Machine User Login selected before submitting the activation request." lightbox="media/pim-resource-roles-activate-your-roles/my-access-copilot-role-selected.png":::

Return to the final step of [Activate an Azure resource role in My Access portal](#activate-an-azure-resource-role-in-my-access) to submit the role assignment activation request.

## View and cancel a pending request in My Access

If you no longer need a pending role assignment activation request, cancel it in the My Access portal.

1. Under **My Access**, select [**Roles**](https://aka.ms/pim/roles), and then select **Azure Roles**.
1. In the **Assignment status** dropdown, select **Pending**.
1. Find the request you no longer need, and select **Cancel**.

::: zone-end

::: zone pivot="api"

## Activate a role with Azure Resource Manager API

Privileged Identity Management supports Azure Resource Manager API commands to manage Azure resource roles, as documented in the [PIM ARM API reference](/rest/api/authorization/role-eligibility-schedule-requests). For the permissions required to use the PIM API, see [Understand the Privileged Identity Management APIs](pim-apis.md).

To activate an eligible Azure role assignment and gain activated access, use the [Role Assignment Schedule Requests - Create REST API](/rest/api/authorization/role-assignment-schedule-requests/create?tabs=HTTP) to create a new request and specify the security principal, role definition, requestType = SelfActivate and scope. To call this API, you must have an eligible role assignment on the scope.

Use a GUID tool to generate a unique identifier for the role assignment identifier. The identifier has the format: 00000000-0000-0000-0000-000000000000.

Replace {roleAssignmentScheduleRequestName} in the PUT request with the GUID identifier of the role assignment.

For more information about eligible roles for Azure resources management, see [PIM ARM API tutorial](/rest/api/authorization/privileged-role-assignment-rest-sample?source=docs#activate-an-eligible-role-assignment).

This is a sample HTTP request to activate an eligible assignment for an Azure role.

### Request

````HTTP
PUT https://management.azure.com/providers/Microsoft.Subscription/subscriptions/aaaa0a0a-bb1b-cc2c-dd3d-eeeeee4e4e4e/providers/Microsoft.Authorization/roleAssignmentScheduleRequests/{roleAssignmentScheduleRequestName}?api-version=2020-10-01
````

### Request body

````JSON
{ 
"properties": { 
  "principalId": "aaaaaaaa-bbbb-cccc-1111-222222222222", 
  "roleDefinitionId": "/subscriptions/aaaa0a0a-bb1b-cc2c-dd3d-eeeeee4e4e4e/providers/Microsoft.Authorization/roleDefinitions/c8d4ff99-41c3-41a8-9f60-21dfdad59608", 
  "requestType": "SelfActivate", 
  "linkedRoleEligibilityScheduleId": "b1477448-2cc6-4ceb-93b4-54a202a89413", 
  "scheduleInfo": { 
      "startDateTime": "2020-09-09T21:35:27.91Z", 
      "expiration": { 
          "type": "AfterDuration", 
          "endDateTime": null, 
          "duration": "PT8H" 
      } 
  }, 
  "condition": "@Resource[Microsoft.Storage/storageAccounts/blobServices/containers:ContainerName] StringEqualsIgnoreCase 'foo_storage_container'", 
  "conditionVersion": "1.0" 
} 
} 
````

### Response

Status code: 201

````HTTP
{ 
  "properties": { 
    "targetRoleAssignmentScheduleId": "c9e264ff-3133-4776-a81a-ebc7c33c8ec6", 
    "targetRoleAssignmentScheduleInstanceId": null, 
    "scope": "/subscriptions/aaaa0a0a-bb1b-cc2c-dd3d-eeeeee4e4e4e", 
    "roleDefinitionId": "/subscriptions/aaaa0a0a-bb1b-cc2c-dd3d-eeeeee4e4e4e/providers/Microsoft.Authorization/roleDefinitions/c8d4ff99-41c3-41a8-9f60-21dfdad59608", 
    "principalId": "aaaaaaaa-bbbb-cccc-1111-222222222222", 
    "principalType": "User", 
    "requestType": "SelfActivate", 
    "status": "Provisioned", 
    "approvalId": null, 
    "scheduleInfo": { 
      "startDateTime": "2020-09-09T21:35:27.91Z", 
      "expiration": { 
        "type": "AfterDuration", 
        "endDateTime": null, 
        "duration": "PT8H" 
      } 
    }, 
    "ticketInfo": { 
      "ticketNumber": null, 
      "ticketSystem": null 
    }, 
    "justification": null, 
    "requestorId": "a3bb8764-cb92-4276-9d2a-ca1e895e55ea", 
    "createdOn": "2020-09-09T21:35:27.91Z", 
    "condition": "@Resource[Microsoft.Storage/storageAccounts/blobServices/containers:ContainerName] StringEqualsIgnoreCase 'foo_storage_container'", 
    "conditionVersion": "1.0", 
    "expandedProperties": { 
      "scope": { 
        "id": "/subscriptions/aaaa0a0a-bb1b-cc2c-dd3d-eeeeee4e4e4e", 
        "displayName": "Pay-As-You-Go", 
        "type": "subscription" 
      }, 
      "roleDefinition": { 
        "id": "/subscriptions/aaaa0a0a-bb1b-cc2c-dd3d-eeeeee4e4e4e/providers/Microsoft.Authorization/roleDefinitions/c8d4ff99-41c3-41a8-9f60-21dfdad59608", 
        "displayName": "Contributor", 
        "type": "BuiltInRole" 
      }, 
      "principal": { 
        "id": "a3bb8764-cb92-4276-9d2a-ca1e895e55ea", 
        "displayName": "User Account", 
        "email": "user@my-tenant.com", 
        "type": "User" 
      } 
    } 
  }, 
  "name": "fea7a502-9a96-4806-a26f-eee560e52045", 
  "id": "/subscriptions/aaaa0a0a-bb1b-cc2c-dd3d-eeeeee4e4e4e/providers/Microsoft.Authorization/RoleAssignmentScheduleRequests/fea7a502-9a96-4806-a26f-eee560e52045", 
  "type": "Microsoft.Authorization/RoleAssignmentScheduleRequests" 
} 
````

## Activate an agent identity with Azure Resource Manager API (preview)

Use the Azure Resource Manager API to activate an eligible Azure resource role assignment for an agent identity. The agent identity requires an E7 license and an existing eligible assignment.

The following example assumes an access token is already available in `$TOKEN`.

1. Gather the following values for the eligible assignment:

    - Assignment scope.
    - Agent identity object ID.
    - Role definition ID.
    - Eligibility schedule ID.

1. Generate a unique GUID for `{new-guid}`. Use `uuidgen` in Bash, or generate the GUID in PowerShell with `[guid]::NewGuid()`.
1. Replace the brace-delimited placeholders in the example with your assignment values. Run the curl command in Bash to submit a `PUT` request to `roleAssignmentScheduleRequests` at the assignment scope. Use camelCase for all property names, as shown in the example.

    The request uses `SelfActivate`, links to the existing eligibility schedule, and requests a ten-minute activation with `PT10M`. The example duration isn't a product default or maximum.

    ```bash
    curl --request PUT \
      --url "https://management.azure.com/{scope}/providers/Microsoft.Authorization/roleAssignmentScheduleRequests/{new-guid}?api-version=2020-10-01" \
      --header "Authorization: Bearer $TOKEN" \
      --header "Content-Type: application/json" \
      --data '{
        "properties": {
          "principalId": "{sp-object-id}",
          "roleDefinitionId": "{scope}/providers/Microsoft.Authorization/roleDefinitions/{role-definition-id}",
          "requestType": "SelfActivate",
          "linkedRoleEligibilityScheduleId": "{eligibility-schedule-guid}",
          "justification": "Testing PIM SP activation",
          "scheduleInfo": {
            "startDateTime": null,
            "expiration": { "duration": "PT10M", "type": "AfterDuration" }
          },
          "ticketInfo": { "ticketNumber": "", "ticketSystem": "" }
        }
      }'
    ```

1. Check the response. A `status` value of `Provisioned` confirms activation. Don't treat request submission alone as completed activation.

::: zone-end

::: zone pivot="azure-mobile-app"

## Activate PIM roles using the Azure mobile app

PIM is now available in the Microsoft Entra ID and Azure resource roles mobile apps in both iOS and Android.

1. To activate an eligible Microsoft Entra role assignment, start by downloading the Azure mobile app ([iOS](https://apps.apple.com/us/app/microsoft-azure/id1219013620) | [Android](https://play.google.com/store/apps/details?id=com.microsoft.azure)). You can also download the app by selecting **Open in mobile**  from Privileged Identity Management > My roles > Microsoft Entra roles.

      :::image type="content" source="./media/pim-resource-roles-activate-your-roles/download-mobile-app.png" alt-text="Screenshot shows how to download the mobile app." lightbox="./media/pim-resource-roles-activate-your-roles/download-mobile-app.png":::

1. Open the Azure mobile app and sign in. Click on the ‘Privileged Identity Management’ card and select **My Azure Resource roles** to view your eligible and active role assignments.

    :::image type="content" source="./media/pim-resource-roles-activate-your-roles/mobile-select-role.png" alt-text="Screenshot of the mobile app showing privileged identity management and the user's roles." lightbox="./media/pim-resource-roles-activate-your-roles/mobile-select-role.png":::

1. Select the role assignment and click on **Action > Activate** under the role assignment details. Complete the activation steps and fill in any required details before clicking **Activate** at the bottom.

      :::image type="content" source="./media/pim-resource-roles-activate-your-roles/mobile-activate-role.png" alt-text="Screenshot of the mobile app showing the validation process has completed. The image shows an Activate button." lightbox="./media/pim-resource-roles-activate-your-roles/mobile-activate-role.png":::

1. View the status of your activation requests and your role assignments under ‘My Azure Resource roles’.

      :::image type="content" source="./media/pim-resource-roles-activate-your-roles/mobile-activation-processing.png" alt-text="Screenshot of the mobile app showing the activation in progress message." lightbox="./media/pim-resource-roles-activate-your-roles/mobile-activation-processing.png":::

::: zone-end

## Deactivate a role assignment

When a role assignment is activated, you see a **Deactivate** option in the PIM portal for the role assignment. Also, you can't deactivate a role assignment within five minutes after activation.

To deactivate your active role assignment by using the Azure Resource Manager API, create a role assignment schedule request with `properties.requestType` set to `SelfDeactivate`. For the request format and authorization details, see [Role Assignment Schedule Requests - Create](/rest/api/authorization/role-assignment-schedule-requests/create).

## Related content

- [Extend or renew Azure resource roles in Privileged Identity Management](pim-resource-roles-renew-extend.md)
- [Activate my Microsoft Entra roles in Privileged Identity Management](pim-how-to-activate-role.md)
