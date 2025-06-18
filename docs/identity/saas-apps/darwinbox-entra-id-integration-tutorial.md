---
title: Integrate Darwinbox HR With Microsoft Entra ID
description: Learn how to integrate Darwinbox HR with Microsoft Entra ID to automate user provisioning, manage lifecycle workflows, and streamline HR-driven processes. 
author: jenniferf-skc
manager: pmwongera
ms.reviewer: cmmdesai
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 06/18/2025
ms.author: jfields
ms.custom: ai-gen-description
ai-usage: ai-assisted

#customer intent: As an IT admin, I want to integrate Darwinbox HR with Microsoft Entra ID so that I can automate user provisioning and lifecycle workflows.
---


# Darwinbox HR integration with Microsoft Entra ID

The document provides a step-by-step guide for integrating Darwinbox with Microsoft Entra ID. The steps include establishing a connection, configuring attribute mapping, testing account provisioning, configuring account access rules, and monitoring provisioning. Use this integration to configure cloud-native users directly in Microsoft Entra ID. This integration allows IT admins to automate business processes using Microsoft Entra ID Governance Lifecycle Workflows.

For detailed guidance on how to integrate your Darwinbox environment, reference the Darwinbox guide [here](https://help.darwinbox.com/r/Integration-Templates/Darwinbox-Microsoft-Entra-ID-Connector). 

Follow these high-level steps for configuring the app integration with Microsoft Entra ID in the Darwinbox Portal.


## Install connectors in Darwinbox Studio
Open Darwinbox studio and navigate to **Connector Library**. Search for and install the **Microsoft** and **Microsoft Entra** connectors 

:::image type="content" border="true" source="./media/darwinbox-hr-integration-tutorial/darwinbox-studio.png" alt-text="Screenshot of the Darwinbox Studio.":::

## Create single-tenant app registration
Next, create a single-tenant app registration and provide the credentials to Darwinbox so they can perform actions such as creating the provisioning job and sending user data to your Entra tenant.

Go to the Entra portal, select **App Registrations**, and then select **New registration**. Create a single-tenant app as shown below.

:::image type="content" border="true" source="./media/darwinbox-hr-integration-tutorial/entra-id-darwinbox-register.png" alt-text="Screenshot of Microsoft Entra ID Register an application page.":::

Add the following three Microsoft Graph application permissions to let Darwinbox create the provisioning job: `Application.ReadWrite.OwnedBy`, send user data `SyncrhonizationData-User.Upload.OwnedBy`, and review the provisioning logs `ProvisioningLog.Read.All`.

:::image type="content" border="true" source="./media/darwinbox-hr-integration-tutorial/entra-id-darwinbox-sync.png" alt-text="Screenshot of Microsoft Entra ID registering with Darwinbox.":::

Create a client secret and provide the credentials to Darwinbox as specified in their guide.

## Create  provisioning job and set up app connections in Darwinbox

Follow the Darwinbox guidance to set up the necessary app connections in Darwinbox studio. These connections let Darwinbox authenticate with your tenant and grant the permissions needed to create a provisioning job and provision users into your tenant.

### Configure attribute mapping in Entra and upload mapping to Darwinbox

To sync custom attributes from Darwinbox to Entra, update the attribute mapping for the provisioning job in the Entra portal. 

:::image type="content" border="true" source="./media/darwinbox-hr-integration-tutorial/entra-id-attribute-mapping.png" alt-text="Screenshot of Microsoft Entra ID mapping page.":::

Upload a CSV file with these mappings to Darwinbox.

:::image type="content" border="true" source="./media/darwinbox-hr-integration-tutorial/darwinbox-key-entra-key.png" alt-text="Image of CSV file showing key mapping from Entra ID to Darwinbox.":::

The Darwinbox connector documentation provides guidance and templates on how to update attribute mappings.

### Setup Darwinbox automations for user provisioning

Once you’ve configured the connector, Darwinbox has multiple recipes in place to manage the Joiner, Mover, Leaver lifecycle of your employees. 

:::image type="content" border="true" source="./media/darwinbox-hr-integration-tutorial/darwinbox-connector-library-recipes.png" alt-text="Microsoft Entra ID registering with Darwinbox.":::

Configure the recipes based on your needs to enable the creation, updating, and deletion of user accounts in your Microsoft Entra ID tenant. 

### Monitoring provisioning

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

> To learn how to monitor the status of your provisioning events, see [User provisioning logs in Microsoft Entra ID](~/identity/monitoring-health/concept-provisioning-logs.md).
