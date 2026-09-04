---
title: Configure HiBob to Active Directory hybrid user provisioning
description: Learn how to configure the Microsoft Active Directory (Hybrid) integration in HiBob to provision and update users in on-premises Active Directory.
ms.service: entra-id
ms.subservice: app-provisioning
ms.topic: how-to
ms.date: 09/03/2026
ai-usage: ai-assisted
---

# Configure HiBob to Active Directory hybrid user provisioning

This article describes how to configure HiBob (Bob) to on-premises Active Directory hybrid user provisioning.

The integration is intended for organizations where on-premises Active Directory is connected to Microsoft Entra ID. HiBob acts as the source for employee lifecycle data, while Microsoft Entra continues to manage identities and access. The integration helps automate user lifecycle management, reduce manual administration, and keep HR and identity data synchronized.

For detailed product-specific guidance, select the **Help docs** link from the [Microsoft Active Directory (Hybrid) integration in the Bob Marketplace](https://www.hibob.com/marketplace/adhybrid/overview).

## Prerequisites

Before you begin, make sure that you have:

- A HiBob tenant and permission to install and configure Bob Marketplace integrations.
- A Microsoft Entra tenant connected to the target Active Directory environment.
- The [Microsoft Entra provisioning agent](../hybrid/cloud-sync/how-to-install.md) installed and configured for the target Active Directory domain.
- The Active Directory domain name and organizational unit (OU) in which HiBob should create or update users.
- A Microsoft Entra account with the [Privileged Role Administrator](../role-based-access-control/permissions-reference.md#privileged-role-administrator) or Global Administrator role to grant consent to the following API permissions:
  - Application.ReadWrite.OwnedBy
  - SynchronizationData-User.Upload.OwnedBy
  - ProvisioningLog.Read.All
- A test employee record that you can use to validate attribute mappings and provisioning behavior.


The following sections provide the high-level steps for configuring the integration in the Bob Marketplace.

> [!NOTE]
> The steps and interface labels in this article describe the configuration experience in the HiBob administration portal. The experience might change as the product is updated.

## How the integration works

The HiBob integration leverages [Microsoft Entra API-driven provisioning](../app-provisioning/inbound-provisioning-api-concepts.md) to provision users to Active Directory. HiBob applies the mappings configured in the integration to create a bulk SCIM payload and sends the payload to the API endpoint of the provisioning job. Microsoft Entra processes the payload by using the provisioning job's scope and attribute mappings, and then the Microsoft Entra provisioning agent writes the changes to Active Directory.

:::image type="content" source="./media/hibob-to-active-directory-user-provisioning-tutorial/hibob-to-active-directory-flow.png" alt-text="Sequence diagram showing end-to-end flow from HiBob to Active Directory." lightbox="./media/hibob-to-active-directory-user-provisioning-tutorial/hibob-to-active-directory-flow.png":::

1. An HR administrator creates an employee profile or updates employee data in HiBob.
1. HiBob applies the attribute mappings configured in the integration and creates a SCIM payload that represents the employee change.
1. HiBob sends the SCIM payload to the API endpoint for the Microsoft Entra API-driven provisioning job.
1. The provisioning job determines whether the employee is in scope and maps the SCIM attributes to the configured Active Directory attributes.
1. The provisioning job sends the create or update operation to the Microsoft Entra provisioning agent.
1. The provisioning agent creates or updates the user account in the configured Active Directory domain and OU.
1. Active Directory returns the result to the provisioning agent.
1. The provisioning agent reports the operation status to the Microsoft Entra provisioning job, where administrators can review it in the provisioning logs.
1. HiBob queries the Microsoft Entra provisioning logs for the status of the submitted request.
1. Microsoft Entra returns the provisioning status, which HiBob makes available in the integration's synchronization records.

## Configuration steps

### Step 1 - Establish the connection

In this step, a HiBob administrator adds the integration, authorizes access to the Microsoft tenant, and specifies the target Active Directory environment.

1. Sign in to HiBob as an administrator.
1. Go to **Marketplace**.
1. Open the **Identity and Access** category, or use the search box to find **Microsoft Active Directory Hybrid**.
1. Open the integration and review its overview and requirements.
1. Select **Connect**, and then select **Add connection**.
1. Enter a descriptive name for the connection.
1. Select **Authorize**.
1. Sign in with a Microsoft Entra account that has the Privileged Role Administrator or Global Administrator role.
1. The *HiBob Hybrid AD Integration* App will request the following permissions. Review and grant the requested permissions.
   - Application.ReadWrite.OwnedBy
   - SynchronizationData-User.Upload.OwnedBy
   - ProvisioningLog.Read.All
1. Wait for HiBob to confirm that the Microsoft tenant connection is established.
1. Enter the target Active Directory domain name.
1. Enter the OU that should contain users managed by the integration.
1. Confirm that the Microsoft Entra provisioning agent is installed and connected to the target Active Directory environment.
1. Select **Next**.

The authorization process securely connects HiBob to the Microsoft tenant. Establishing the connection can take several minutes.

### Step 2 - Configure provisioning scope and attribute mappings

In this step, the administrator defines which employees are in scope and maps HiBob fields to Active Directory attributes. HiBob uses these mappings to transform employee data into the SCIM payload that it sends to the API endpoint for the Microsoft Entra API-driven provisioning job.

1. On the provisioning settings page, configure **Who to provision**.
1. Review the default mappings from HiBob employee fields to Active Directory attributes.
1. For each mapping, verify the HiBob source field and the corresponding Active Directory target attribute.
1. Add mappings for any additional employee data that should flow to Active Directory. 

   > [!NOTE] 
   > To use [Entra ID Governance Lifecycle Workflows](../../id-governance/what-are-lifecycle-workflows.md), send the `Start date` and `End date`/`Termination date` information to Active Directory and [through Entra Connect Sync or Cloud Sync](../../id-governance/how-to-lifecycle-workflow-sync-attributes.md) to Microsoft Entra ID.  

1. Change or remove optional mappings that aren't required by your organization.
1. Review the mappings that HiBob identifies as required for Active Directory synchronization. Required mappings can't be removed, but the source or target might be configurable.
1. Select **Next**.

> [!CAUTION]
> Changing an identifier or other required mapping can affect user matching and updates. Test mapping changes with a limited set of users before enabling broad provisioning.

### Step 3 - Configure synchronization and approval rules

In this step, the administrator decides how automatically HiBob should send employee lifecycle changes to Active Directory.

HiBob provides the following synchronization approaches:

- **Automatic synchronization** - Sends eligible changes directly to Active Directory. Use this option when the organization wants faster processing with minimal administrator involvement.
- **Approval-required synchronization** - Places selected changes in an approval queue before they're sent to Active Directory. Use this option when the organization requires more control over sensitive identity changes.

To configure approval-required synchronization:

1. Choose whether approval is required when a new employee account is created.
1. Select the employee fields whose updates require approval, such as department or another sensitive business attribute.
1. Configure the users or groups that should receive approval notifications.
1. Review the settings, and then save the connection.

Routine updates can remain automated, while higher-risk changes can require review.

### Step 4 - Test user provisioning

After the connection is saved, test the provisioning flow with a test employee before enabling the integration for a broader population.

1. In HiBob, open the test employee record.
1. Create or update an employee value that is included in the attribute mappings.
1. If you're testing approval-required synchronization, update a field that requires approval. For example, change the employee's department and specify the effective date.
1. Return to **Marketplace** and locate the Microsoft Active Directory Hybrid integration.
1. Select **Manage**, and then open the connection that you created.
1. If approval is required, open the approval queue.
1. Review the employee, trigger type, changed field, previous value, new value, and effective date.
1. Select **Approve** to send the change to Active Directory, or select **Decline** to reject it.

Approvers can process changes individually or, when available, approve or decline changes in bulk.

After approving a change, confirm that the user was created or updated in the expected Active Directory domain and OU with the expected attribute values.

### Step 5 - Monitor provisioning

The connection management page provides a central location for reviewing configuration and provisioning activity.

Use the connection page to:

- Review the provisioning settings and attribute mappings configured in the wizard.
- Trigger a manual synchronization when needed.
- Review pending items in the approval queue.
- Review the audit history to identify who approved or declined a change and what action was taken.
- Review synchronization records to determine whether each operation succeeded or failed.
- Filter or export records when those options are available.

If a provisioning operation fails, review the synchronization record for the affected employee. Verify the connection authorization, provisioning-agent status, target domain and OU, provisioning scope, and attribute mappings.

## Troubleshooting

### Connectivity issues between HiBob, Microsoft Entra tenant and Active Directory

Take the following actions:

- Confirm that the Microsoft Entra account used for authorization has the required permissions.
- Retry authorization and complete any consent prompts.
- Confirm that the Microsoft Entra tenant is associated with the target hybrid Active Directory environment.

### Users aren't created or updated

In the HiBob administration portal:

- Verify the Active Directory domain and OU settings.
- Confirm that the employee is included in the **Who to provision** scope.
- Review required and custom attribute mappings.
- Check the synchronization records for a failure entry.

If the HiBob synchronization records don't clearly identify the cause of the failure, review the Microsoft Entra provisioning logs:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).
1. Browse to **Entra ID** > **Enterprise apps**.
1. Find and select the **HiBob to Active Directory user provisioning** app.
1. Confirm that the Microsoft Entra provisioning agent is running and connected.
1. Select **Provisioning logs**.
1. Find the failed provisioning operation and review its status information and error details.

### Custom Active Directory schema attributes don't appear in the mapping list

Let's say you have a custom attribute in your Active Directory and it is not showing up in the mapping drop-down, then add the custom attribute to the target attribute schema of the provisioning app before you configure the mapping in HiBob:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).
1. Browse to **Entra ID** > **Enterprise apps**.
1. Find and select the **HiBob to Active Directory user provisioning** app.
1. Select **Provisioning**, and then select **Edit provisioning**.
1. Expand **Mappings**, and then select the attribute mapping.
1. Select **Edit Active Directory attribute list**.
1. Add the custom Active Directory attribute to the list, and then save your changes.
1. Return to the HiBob configuration screen and confirm that the custom attribute appears in the mapping list.

### A change remains pending

In the HiBob administration portal:

1. Open the integration's approval queue.
1. Confirm that the changed field is configured to require approval.
1. Approve or decline the request.
1. Verify that approval notifications are sent to the intended reviewers.

## Related content

- [Install and configure the Microsoft Entra provisioning agent](../hybrid/cloud-sync/how-to-install.md)
- [Microsoft Entra ID Governance Lifecycle Workflows](../../id-governance/what-are-lifecycle-workflows.md)
- [API-driven inbound provisioning concepts and configuration](../app-provisioning/inbound-provisioning-api-concepts.md)
