---
title: Microsoft Entra ID Governance deployment guide for employee lifecycle automation
description: Learn how to deploy employee lifecycle automation in Microsoft Entra ID Governance.
author: gargi-sinha
manager: martinco
ms.service: entra-id-governance
ms.topic: concept-article
ms.date: 04/17/2025
ms.author: gasinh

#customer intent: My goal is to deploy Microsoft Entra ID Governance in my test and production environments.
---

# Microsoft Entra ID Governance deployment guide for employee lifecycle automation

Deployment scenarios are guidance on how to combine and test Microsoft Security products and services. You can discover how capabilities work together to improve productivity, strengthen security, and more easily meet compliance and regulatory requirements. 

The following products and services appear in this guide: 

* [Microsoft Entra ID Governance](../id-governance/identity-governance-overview.md)
* [Lifecycle workflows](../id-governance/what-are-lifecycle-workflows.md)
* [Microsoft Entra](../fundamentals/what-is-entra.md)
* [Microsoft Entra ID](../fundamentals/whatis.md)
* [Microsoft Entra Connect](../identity/hybrid/connect/whatis-azure-ad-connect.md)
* [Microsoft Entra Cloud Sync](../identity/hybrid/cloud-sync/what-is-cloud-sync.md)
* [Azure Logic Apps](/azure/logic-apps/logic-apps-overview)
* [Microsoft Graph](/graph/overview)

Use this scenario to help determine the need for Microsoft Entra ID Governance to create and grant access for your organization. Learn how you can provision your users effectively, securely, and consistently with employee lifecycle automation.

## Timelines

Timelines show approximate delivery stage duration and are based on scenario complexity. Times are estimations and vary depending on the environment. 

1. HR provisioning - 3 hours
2. Software-as-a-Service (SaaS) app provisioning - 1 hour
3. Lifecycle workflows - 3 hours 

## Employee lifecycle automation

To streamline employee identity management, organizations are adopting modern solutions and automation. With identity management systems and technologies, IT staff can overcome limited manual procedures and instead enhance efficiency.  

### Microsoft Entra ID Governance

With the Microsoft Entra ID Governance solution, organizations improve productivity, strengthen security, and meet compliance and regulatory requirements. Use Microsoft Entra ID Governance to ensure the right people have the right access to the right resources at the right time. Learn more about Microsoft Entra ID Governance [use cases](../id-governance/scenarios/identity-governance-use-cases.md) and [documentation](../id-governance/identity-governance-overview.md). 

Learn more about [Microsoft Entra ID](../fundamentals/whatis.md). 

## HR-driven provisioning

HR-driven provisioning creates digital identities based on a human resources (HR) system, which becomes the source of authority. This juncture is the starting point for numerous provisioning processes. 

Learn more in the video about [HR-driven provisioning with Microsoft Entra ID](https://youtu.be/HsdBt40xEHs). 

### Cloud HR to Microsoft Entra ID

Users are created in Microsoft Entra ID, and other SaaS apps that support user provisioning. When employee records are updated in cloud HR, the user account is updated in Microsoft Entra ID and supporting SaaS apps.  

## Deploy Workday to Microsoft Entra ID

1. [Select cloud HR provisioning connector apps](/azure/active-directory/app-provisioning/plan-cloud-hr-provision).
2. [Design provisioning topology](/azure/active-directory/app-provisioning/plan-cloud-hr-provision).
3. [Configure integration system user in Workday](/azure/active-directory/saas-apps/workday-inbound-tutorial).
4. [Enable Workday provisioning connector](/azure/active-directory/saas-apps/workday-inbound-cloud-only-tutorial).
5. [Start Workday and Microsoft Entra ID attribute mapping](/azure/active-directory/saas-apps/workday-inbound-cloud-only-tutorial).
6. [(**Optional**) Configure Workday writeback in Azure AD](/azure/active-directory/saas-apps/workday-writeback-tutorial).
7. [Enable and launch provisioning](/azure/active-directory/saas-apps/workday-writeback-tutorial).

Learn more in the video about [HR-driven user provisioning with Workday](https://youtu.be/TfndXBlhlII).

## Deploy SuccessFactors to Microsoft Entra ID

1. [Select cloud HR provisioning connector apps](/azure/active-directory/app-provisioning/plan-cloud-hr-provision).
2. [Design provisioning topology](/azure/active-directory/app-provisioning/plan-cloud-hr-provision).
3. [Create API user account in SuccessFactors](/azure/active-directory/saas-apps/sap-successfactors-inbound-provisioning-cloud-only-tutorial).
4. [Create API permissions in SuccessFactors](/azure/active-directory/saas-apps/sap-successfactors-inbound-provisioning-cloud-only-tutorial).
5. [Add SuccessFactors inbound connector app](/azure/active-directory/saas-apps/sap-successfactors-inbound-provisioning-cloud-only-tutorial).
6. [Configure SuccessFactors attribute mappings](/azure/active-directory/saas-apps/sap-successfactors-inbound-provisioning-cloud-only-tutorial).
7. [(**Optional**) Configure attribute write-back from Entra ID to SAP SuccessFactors](/azure/active-directory/saas-apps/sap-successfactors-writeback-tutorial).
8. [Enable and Launch provisioning](/azure/active-directory/saas-apps/sap-successfactors-writeback-tutorial).

Learn more in the video about [HR-driven user provisioning with SuccessFactors](https://www.youtube.com/watch?v=66v2FR2-QrY). 

## Cloud HR to Active Directory

Use the following video to learn about API-driven inbound provisioning for on-premises Active Directory.</br></br>

> [!VIDEO fa17234c-ecc7-4c87-82e9-6609270e1744]


## Deploy Workday to Active Directory

1. [Select cloud HR provisioning connector apps](/azure/active-directory/app-provisioning/plan-cloud-hr-provision).
2. [Design provisioning topology](/azure/active-directory/app-provisioning/plan-cloud-hr-provision).
3. [Configure integration system user in Workday](/azure/active-directory/saas-apps/workday-inbound-tutorial).
4. [Provisioning connector app and Provisioning Agent](/azure/active-directory/saas-apps/workday-inbound-tutorial).
5. [Install and configure on-premises agents](/azure/active-directory/saas-apps/workday-inbound-tutorial).
6. [Configure connectivity to Workday and Active Directory](/azure/active-directory/saas-apps/workday-inbound-tutorial).
7. [Configure attribute mappings](/azure/active-directory/saas-apps/workday-inbound-tutorial).
8. [Enable and launch user provisioning](/azure/active-directory/saas-apps/workday-inbound-tutorial).

## Deploy SuccessFactors to Active Directory

1. [Select cloud HR provisioning connector apps](/azure/active-directory/app-provisioning/plan-cloud-hr-provision).
2. [Design provisioning topology](/azure/active-directory/app-provisioning/plan-cloud-hr-provision).
3. [Configure integration system user in Workday](/azure/active-directory/saas-apps/workday-inbound-tutorial).
4. [SuccessFactors inbound provisioning app and agent](/azure/active-directory/saas-apps/sap-successfactors-inbound-provisioning-tutorial).
5. [Install on-premises agents](/azure/active-directory/saas-apps/sap-successfactors-inbound-provisioning-tutorial).
6. [Configure app connectivity to AD](/azure/active-directory/saas-apps/sap-successfactors-inbound-provisioning-tutorial).
7. [Configure attribute mappings](/azure/active-directory/saas-apps/sap-successfactors-inbound-provisioning-tutorial).
8. [Enable and launch user provisioning](/azure/active-directory/saas-apps/sap-successfactors-inbound-provisioning-tutorial).

## API-driven provisioning

Identity data in Microsoft Entra ID is kept in sync with workforce data managed in systems of record: an HR app, a payroll app, a spreadsheet, SQL tables in a database on-premises, or in the cloud. With application programming interface [(API)-driven inbound provisioning](../identity/app-provisioning/inbound-provisioning-api-concepts.md), the Microsoft Entra provisioning service supports integration with systems of record. 

Learn more:

* [FAQ: API-driven inbound provisioning](/azure/active-directory/app-provisioning/inbound-provisioning-api-faqs)
* [Grant access to the inbound provisioning API](https://youtu.be/RnY9T7k1BL0)
* [Learn to test provisioning API with Graph Explorer](https://youtu.be/GvEdWPgQJps)

### API-driven provisioning scenarios

IT teams import data extracts with automation. Independent software vendors (ISVs) integrate with Microsoft Entra ID. System integrators build connectors to systems of record. This process is commonly used for sources like flat files, CSV files, SQL staging tables. Integrate automation tools: [PowerShell](/windows-server/administration/windows-commands/powershell) scripts, [Azure Logic Apps](/azure/logic-apps/logic-apps-overview), and workflows using HTTP calls.  

## Configure API-driven provisioning

You can learn to configure [API-driven inbound provisioning](../identity/app-provisioning/inbound-provisioning-api-concepts.md).  

## Comparison: Inbound provisioning /bulkUpload API and Microsoft Graph Users API 

We recommend noting the differences between the provisioning **/bulkUpload** API and the Microsoft Graph Users API endpoint: Payload format, operation result, and IT administrators retain control. 

In an FAQ, learn how [the new inbound provisioning API differs from Graph Users API](../identity/app-provisioning/inbound-provisioning-api-faqs.md).

## Deploy API-driven inbound provisioning

1. [Create an API-driven provisioning app](/azure/active-directory/app-provisioning/inbound-provisioning-api-configure-app).
2. For **Active Directory**, [configure API-driven inbound provisioning app](/azure/active-directory/app-provisioning/inbound-provisioning-api-configure-app). For **Microsoft Entra ID**, [configure API-driven inbound provisioning app](/azure/active-directory/app-provisioning/inbound-provisioning-api-configure-app).
3. [Grant access to inbound provisioning API](/azure/active-directory/app-provisioning/inbound-provisioning-api-grant-access)
4. [Customize user provisioning attribute mappings](/azure/active-directory/app-provisioning/customize-application-attributes)
5. [Sync custom attributes](/azure/active-directory/app-provisioning/inbound-provisioning-api-custom-attributes)

To learn more, see the following Quickstart guides about API-driven inbound provisioning with: 

* [cURL](/azure/active-directory/app-provisioning/inbound-provisioning-api-curl-tutorial)
* [Postman](/azure/active-directory/app-provisioning/inbound-provisioning-api-postman)
* [Graph Explorer](/azure/active-directory/app-provisioning/inbound-provisioning-api-graph-explorer)
* [PowerShell](/azure/active-directory/app-provisioning/inbound-provisioning-api-powershell)
* [Azure Logic Apps](/azure/active-directory/app-provisioning/inbound-provisioning-api-logic-apps)

### Outbound app provisioning

You can provision to Software-as-a-Service (SaaS) apps, using a System for Cross-Domain Identity Management (SCIM). 

Discover more about [SCIM synchronization with Microsoft Entra ID](sync-scim.md). 

### Configure provisioning with a SCIM endpoint

SCIM 2.0 is a standardized definition of two endpoints **/Users** and **/Groups**. 

See more details in the tutorial, [develop, and plan provisioning for a SCIM endpoint in Microsoft Entra ID](../identity/app-provisioning/use-scim-to-provision-users-and-groups.md). 

## Deploy SaaS sample-app provisioning

The [Microsoft Entra ID application gallery](../identity/saas-apps/tutorial-list.md) displays available apps for user provisioning. Select up to four apps for your environment, or choose from these popular apps to enable automatic user provisioning:


* [ServiceNow](/azure/active-directory/saas-apps/servicenow-provisioning-tutorial)
* [Salesforce](/azure/active-directory/saas-apps/salesforce-provisioning-tutorial)
* [Box](/azure/active-directory/saas-apps/box-userprovisioning-tutorial)
* [Cisco Webex](/azure/active-directory/saas-apps/cisco-webex-provisioning-tutorial)
* [Workplace by Facebook](/azure/active-directory/saas-apps/workplace-by-facebook-provisioning-tutorial)
* [Zoom](/azure/active-directory/saas-apps/zoom-provisioning-tutorial)

### (Optional) Provision to on-premises apps

Users and schema defined in the cloud support provisioning from custom schema extensions to app-specific properties. 

To learn more, go to [app provisioning samples for SCIM-enabled apps](/azure/active-directory/app-provisioning/on-premises-scim-provisioning). 

## Lifecycle workflows

Lifecycle workflows are an identity governance feature to manage Microsoft Entra users by automating Joiner, Mover, and Leaver events for employees. Use the feature to schedule tasks for before, during, or after an event. Workflows can run on demand. With built-in tasks, you can generate temporary credentials, send emails, update user attributes, and memberships, and remove licenses.  

Learn more in the [overview of lifecycle workflow APIs](/graph/api/resources/identitygovernance-lifecycleworkflows-overview?view=graph-rest-1.0&preserve-view=true). 

### Joiner

A Joiner is an individual who needs access. When you onboard new employees, use templates and workflows to make processes more efficient and faster.  

### Mover

A Mover is an individual moving between boundaries in an organization, for instance, the employee goes from a role in Sales to one in Marketing. The movement might require more, or different, access, and authorization.  

### Leaver

The Leaver no longer needs access, such as terminated or retiring employees. Effective Leaver workflows reduce the risk of unauthorized data access, after termination. Therefore, handle Leaver personal information in compliance with regulations and policies. Use customizable workflow templates for timely, reliable, and graceful resource-access removal. 

**Remove application access**

Microsoft Entra ID provisioning service keeps source and target systems in sync. Deprovision an account when user access must end.  

1. Unassign the user from one or more applications.
2. Delete the account from Microsoft Entra ID.
3. Set the **AccountEnabled** property to **False**. 

   > [!NOTE]
   > If an application supports the process, you can soft-delete users by default. 

### Lifecycle workflows custom extensions

Use custom extensions to create workflows using tools like Azure Logic Apps. For workflows, you can enable custom task extensions to call out to external systems. For example, a Joiner workflow with a custom task extension assigns a Microsoft Teams number. Or, when a user becomes a Leaver, a separate workflow grants access to an email account for their manager. You can learn to [trigger Logic Apps based on custom task extensions](../id-governance/trigger-custom-task.md).

   > [!NOTE]
   > To create a logic app resource for hosting, select **Consumption**. A consumption logic app has one workflow that runs in multitenant Azure Logic Apps. 

To learn more, see the [App Service Environment overview](/azure/app-service/environment/overview) and [Azure Logic Apps documentation](/azure/logic-apps/logic-apps-overview).  

## Deploy lifecycle workflows

1. [Synchronize attributes](/azure/active-directory/governance/how-to-lifecycle-workflow-sync-attributes)
2. [Prepare user accounts](/azure/active-directory/governance/tutorial-prepare-user-accounts)
2. [Automate prehire tasks for employees](/azure/active-directory/governance/tutorial-onboard-custom-workflow-portal)
4. [Automate onboarding new employees](/azure/active-directory/governance/lifecycle-workflow-templates)
5. [Automate post-onboarding](/azure/active-directory/governance/lifecycle-workflow-templates)
6. [Real-time employee change](/azure/active-directory/governance/lifecycle-workflow-templates)
7. [Real-time employee termination](/azure/active-directory/governance/tutorial-offboard-custom-workflow-portal)
8. [Employee group membership changes](../id-governance/lifecycle-workflow-templates.md)
9. [Employee job profile change](../id-governance/lifecycle-workflow-templates.md)
10. [Automate preoffboarding](/azure/active-directory/governance/lifecycle-workflow-templates)
11. [Automate offboarding](/azure/active-directory/governance/tutorial-scheduled-leaver-portal)
12. [Automate post-affboarding](/azure/active-directory/governance/lifecycle-workflow-templates)
13. [Trigger Logic Apps with custom extensions](/azure/active-directory/governance/trigger-custom-task)

### Supported tasks and workflows

The table lists tasks and workflow according to Joiner, Mover, Leaver status.  

|Category|Tasks and workflows|
|---|---|
|Joiner|[Send welcome email to new-hire](/azure/active-directory/governance/lifecycle-workflow-tasks)|
|Joiner|[Send onboarding reminder email](/azure/active-directory/governance/lifecycle-workflow-tasks)|
|Joiner|[Generate temporary access pass (TAP) and send it by email to the new-hire's manager](/azure/active-directory/governance/lifecycle-workflow-tasks)|
|Mover|[Send notification email to manager about a user move](/azure/active-directory/governance/lifecycle-workflow-tasks)|
|Joiner, Mover|[Request user access package assignment](/azure/active-directory/governance/lifecycle-workflow-tasks)|
|Joiner, Mover, Leaver|[Add user to groups](/azure/active-directory/governance/lifecycle-workflow-tasks)|
|Joiner, Mover, Leaver|[Add user to teams](/azure/active-directory/governance/lifecycle-workflow-tasks)|
|Joiner, Leaver|[Enable user account](/azure/active-directory/governance/lifecycle-workflow-tasks)|
|Joiner, Mover, Leaver|[Run a custom task extension](/azure/active-directory/governance/lifecycle-workflow-tasks)|
|Leaver|[Disable user account](/azure/active-directory/governance/lifecycle-workflow-tasks)|
|Joiner, Mover, Leaver|[Remove user from groups](/azure/active-directory/governance/lifecycle-workflow-tasks)|
|Leaver|[Remove user from all groups](/azure/active-directory/governance/lifecycle-workflow-tasks)|
|Leaver|[Remove user from teams](/azure/active-directory/governance/lifecycle-workflow-tasks)|
|Leaver|[Remove user from all teams](/azure/active-directory/governance/lifecycle-workflow-tasks)|
|Leaver, Mover|[Remove user access package assignments](/azure/active-directory/governance/lifecycle-workflow-tasks)|
|Leaver|[Remove all user access package assignments](/azure/active-directory/governance/lifecycle-workflow-tasks)|
|Leaver|[Cancel all pending user access package assignment requests](/azure/active-directory/governance/lifecycle-workflow-tasks)|
|Leaver|[Remove all user license assignments](/azure/active-directory/governance/lifecycle-workflow-tasks)|
|Leaver|[Delete user](/azure/active-directory/governance/lifecycle-workflow-tasks)|
|Leaver|[Send email to user's manager before before last day](/azure/active-directory/governance/lifecycle-workflow-tasks)|
|Leaver|[Send email to user's manager on last day](/azure/active-directory/governance/lifecycle-workflow-tasks)|
|Leaver|[Send email to user's manager after last day](/azure/active-directory/governance/lifecycle-workflow-tasks)|

## Next steps

  * [Introduction to Microsoft Entra ID Governance deployment guide](governance-deployment-intro.md)
  * Scenario 1: Employee lifecycle automation
  * [Scenario 2: Assign employee access to resources](governance-deployment-employee-access.md)
  * [Scenario 3: Govern guest and partner access](governance-deployment-guest-access.md)
  * [Scenario 4: Govern privileged identities and their access](governance-deployment-privileged-identities.md)
