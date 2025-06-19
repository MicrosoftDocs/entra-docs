---
title: Integrate Darwinbox HR With Microsoft Entra ID
description: Learn how to integrate Darwinbox HR with Microsoft Entra ID to automate user provisioning, manage lifecycle workflows, and streamline HR-driven processes. 
author: jenniferf-skc
manager: pmwongera
ms.reviewer: cmmdesai
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 06/19/2025
ms.author: jfields
ms.custom: ai-gen-description
ai-usage: ai-assisted

#customer intent: As an IT admin, I want to integrate Darwinbox HR with Microsoft Entra ID so that I can automate user provisioning and lifecycle workflows.
---


# Integrate Darwinbox HR with Microsoft Entra ID

The document provides a step-by-step guide for integrating Darwinbox with Microsoft Entra ID. The steps include establishing a connection, configuring attribute mapping, testing account provisioning, configuring account access rules, and monitoring provisioning. Use this integration to configure cloud-native users directly in Microsoft Entra ID. This integration allows IT admins to automate business processes using Microsoft Entra ID Governance Lifecycle Workflows.

For detailed guidance on how to integrate your Darwinbox environment, reference the Darwinbox guide [here](https://help.darwinbox.com/r/Integration-Templates/Darwinbox-Microsoft-Entra-ID-Connector). 

Follow these high-level steps for configuring the app integration with Microsoft Entra ID in the Darwinbox Portal.


## Create single-tenant app registration

In this step, you'll create a single-tenant application in Microsoft Entra ID and assign it the required permissions. This allows Darwinbox to use the application's client credentials to create a provisioning job and securely send user data to your Microsoft Entra ID tenant.

Go to the Microsoft Entra admin center, select **App Registrations**, and then select **New registration**. Create a single-tenant app as shown below.

:::image type="content" border="true" source="./media/darwinbox-entra-integration-tutorial/entra-darwinbox-register.png" alt-text="Screenshot of Microsoft Entra ID Register an application page." lightbox="media/darwinbox-entra-integration-tutorial/entra-darwinbox-register.png":::

Add the following three Microsoft Graph application permissions to let Darwinbox create the provisioning job: `Application.ReadWrite.OwnedBy`, send user data `SyncrhonizationData-User.Upload.OwnedBy`, and review the provisioning logs `ProvisioningLog.Read.All`.

:::image type="content" border="true" source="./media/darwinbox-entra-integration-tutorial/entra-darwinbox-sync.png" alt-text="Screenshot of Microsoft Entra ID Darwinbox Sync page for API permissions." lightbox="media/darwinbox-entra-integration-tutorial/entra-darwinbox-sync.png":::

Create a client secret and provide the credentials to Darwinbox as specified in their guide.

## Configure connectors in Darwinbox Studio

1. Open Darwinbox studio and navigate to **Connector Library**. 
1. Search for **Microsoft**. Install the **Microsoft** parent app connector and the **Microsoft Entra** child app connector.

:::image type="content" border="true" source="./media/darwinbox-entra-integration-tutorial/darwinbox-studio.png" alt-text="Screenshot of the Darwinbox Studio." lightbox="media/darwinbox-entra-integration-tutorial/darwinbox-studio.png":::

1. Open the **Microsoft** app and configure connection parameters obtained from step 1. Provide **Client ID**,  **Client Secret** and **OAuth Token endpoint** details. The connectivity information specified here will be used by Darwinbox to create a provisioning app in your Microsoft Entra ID tenant.  
:::image type="content" border="true" source="./media/darwinbox-entra-integration-tutorial/microsoft-app-connectivity.png" alt-text="Screenshot of Creating a connection for Microsoft." lightbox="media/darwinbox-entra-integration-tutorial/microsoft-app-connectivity.png":::
1. Manually trigger the recipe task **Configure application and Job in Microsoft Entra SCIM**. This creates the API-driven provisioning job that Darwinbox uses to send user information.  
:::image type="content" border="true" source="./media/darwinbox-entra-integration-tutorial/configure-app-and-job-entra.png" alt-text="Screenshot of configuring the application and job in Entra." lightbox="media/darwinbox-entra-integration-tutorial/configure-app-and-job-entra.png":::
1. In Microsoft Entra admin center, browse to **Enterprise Applications** and open the provisioning app created by Darwinbox. Copy the **Service Principal Id/Object ID** from the Overview blade. Open the Provisioning blade of this app, go to the Overview section’s **View technical information** and copy the **Provisioning Job ID**.
1. In Darwinbox Studio, open the **Microsoft Entra** app and configure connection details, specifically entering the **ServicePrincipalID** and **Provisioning Job ID**.  
:::image type="content" border="true" source="./media/darwinbox-entra-integration-tutorial/microsoft-app-connectivity.png" alt-text="Screenshot of editing a connection for Microsoft Entra." lightbox="media/darwinbox-entra-integration-tutorial/microsoft-app-connectivity.png":::

## Configure attribute mapping in Entra and upload mapping to Darwinbox

### Map Darwinbox attributes to Entra ID SCIM attributes

Refer to the Darwinbox integration guide and create the following three CSV files that will be used as input in the Darwinbox recipes.
- CSV file that maps Darwinbox attributes to Entra ID SCIM attributes. This file is used as input in the Darwinbox recipes. 
:::image type="content" border="true" source="./media/darwinbox-entra-integration-tutorial/darwinbox-key-entra-key.png" alt-text="Screenshot of example CSV file for Darwinbox to Entra keys." lightbox="media/darwinbox-entra-integration-tutorial/darwinbox-key-entra-key.png":::
- CSV file that instructs which domain should be used for email ID creation based on either group company name or department.
- CSV file that instructs how groups and licenses should be assigned (Optional).

### Add Darwinbox custom attributes to Entra provisioning job

Refer to the steps documented [here](/docs/identity/app-provisioning/inbound-provisioning-api-custom-attributes.md#step-1---extend-the-provisioning-app-schema#) to introduce the following custom Darwinbox SCIM attributes in the Entra provisioning job. 
- urn:ietf:params:scim:schemas:extension:Darwinbox:1.0:User:UsageLocation 
- urn:ietf:params:scim:schemas:extension:Darwinbox:1.0:User:EmployeeType 
- urn:ietf:params:scim:schemas:extension:Darwinbox:1.0:User:HireDate 
- urn:ietf:params:scim:schemas:extension:Darwinbox:1.0:User:TerminationDate 

Review and update the Microsoft Entra ID API-driven provisioning job attribute mapping. Ensure that you’re mapping includes ```employeeHireDate``` and ```employeeLeaveDateTime``` attributes so you can configure Joiner-Mover-Leaver Lifecycle Workflows.  
:::image type="content" border="true" source="./media/darwinbox-entra-integration-tutorial/entra-attribute-mapping.png" alt-text="Screenshot of the Attribute Mapping screen." lightbox="media/darwinbox-entra-integration-tutorial/entra-attribute-mapping.png":::

### Set up Darwinbox automations for user provisioning

Once you’ve configured the connector, Darwinbox has multiple recipes in place to manage the Joiner, Mover, Leaver lifecycle of your employees. 

:::image type="content" border="true" source="./media/darwinbox-entra-integration-tutorial/darwinbox-connector-library-recipes.png" alt-text="Screenshot of Darwinbox's featured recipes for Microsoft Entra." lightbox="media/darwinbox-entra-integration-tutorial/darwinbox-connector-library-recipes.png":::

Configure the recipes based on your needs to enable the creation, updating, and deletion of user accounts in your Microsoft Entra ID tenant. 

### Monitor provisioning

To monitor the status of your provisioning events, go to the provisioning logs or use the provisioning workbook.

-	[User provisioning logs in Microsoft Entra ID](~/identity/monitoring-health/concept-provisioning-logs.md)
-	[How to analyze the Microsoft Entra provisioning logs](~/identity/monitoring-health/howto-analyze-provisioning-logs.md)
-	[Quickstart for API-driven inbound provisioning with cURL](~/identity/app-provisioning/inbound-provisioning-api-curl-tutorial.md#verify-processing-of-the-bulk-request-payload)

### Manage Joiner-Mover-Leaver lifecycle workflows

Extend your HR-driven provisioning process to automate business processes and security controls for new hires, employment changes, and termination. With [Microsoft Entra ID Governance Lifecycle Workflows](~/id-governance/what-are-lifecycle-workflows.md), configure Joiner-Mover-Leaver workflows such as the following:

-	“X” days before the new hire joins, send an email to the manager, add the user to groups, and generate a temporary access pass for first-time login.
-	When there's a change in the user’s department, job title, or group membership, launch a custom task.
-	On the last day of work, send an email to the manager, and remove the user from groups and license assignments.
-	“X” days after termination, delete user from Microsoft Entra ID.


## Related content

To learn how to monitor the status of your provisioning events, see [User provisioning logs in Microsoft Entra ID](~/identity/monitoring-health/concept-provisioning-logs.md).
