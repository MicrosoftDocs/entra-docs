---
title: Introduction to Microsoft Entra ID Governance deployment guide
description: Learn how to deploy Microsoft Entra ID Governance.
author: gargi-sinha
manager: martinco
ms.service: entra-id-governance
ms.topic: concept-article
ms.date: 03/25/2025
ms.author: gasinh

#customer intent: I want to deploy and test Microsoft Entra ID Governance in my production or test environment. 
---

# Introduction to Microsoft Entra ID Governance deployment guide

[Microsoft Entra ID Governance](../id-governance/identity-governance-overview.md) is an identity governance solution to improve productivity, strengthen security, and meet compliance and regulatory requirements. Ensure the right people have the right access to the right resources. Enable identity and access process automation, delegation to business groups, and increased visibility. Mitigate identity and access risk, protect, monitor, and audit access to your assets. Learn more about Microsoft Entra ID Governance [use cases](../id-governance/scenarios/identity-governance-use-cases.md) and [documentation](../id-governance/identity-governance-overview.md).

## Deployment approach

To ensure a comprehensive approach to identity governance, there are phases aligned with the identity lifecycle. **Lifecycle automation** is the automated processes for user onboarding, role transitions, and offboarding. To **assign users to resources** entails allocating the right resources to users, integrating entitlements and roles. **Secure privileged access** helps you protect and manage privileged accounts with access controls and monitoring mechanisms. 

In alignment with the approach, the guide has this introduction and four scenarios. Use the links to see each scenario.

* Introduction
* [Scenario 1: Employee lifecycle automation](governance-deployment-employee-lifecycle.md)
* [Scenario 2: Assign employee access to resources](governance-deployment-employee-access.md)
* [Scenario 3: Govern guest and partner access](governance-deployment-guest-access.md)
* [Scenario 4: Govern privileged identities and their access](governance-deployment-privileged-identities.md)

While most services are in General Availability (GA), some features or services might be in Public Preview, or other states before GA. GA indicates a product or service is publicly available to all customers and backed by service-level agreement (SLA) guarantees. See the following section for licensing information. 

### Licensing

Microsoft Entra ID Governance is a feature in Microsoft Entra ID. To enable the deployment, review the following prerequisites.  

* To use Microsoft Entra ID to govern app access, have one of the following license combinations in your tenant:  '
  * Microsoft Entra ID Governance and its prerequisite, Microsoft Entra ID P1
  * Microsoft Entra ID Governance Step Up for Microsoft Entra ID P2 and its prerequisite, Microsoft Entra ID P2, or Enterprise Mobility + Security (EMS) E5
  * In the tenant, ensure there’s a license for each governed user (nonguest). Include the users that request access to apps, approve access, or review app access.
* To govern guest access to the application, link the Microsoft Entra tenant to a subscription for monthly active user (MAU) billing 

For more information, see [Microsoft Entra ID Governance licensing fundamentals](../id-governance/licensing-fundamentals.md).

Learn about [prerequisites before you configure Microsoft Entra ID and Microsoft Entra ID Governance](../id-governance/identity-governance-applications-prepare.md).

### Participation model

The recommended participation model for roles to complete tasks and deliverables: **responsible, accountable, consulted, and informed (RACI)**. Use the model to ensure the involved roles understand responsibilities and goals.  

* **Responsible** - Completes the task 
  * Assign at least one Responsible role, although they can delegate
* **Accountable** - Assumes responsibility for correctness and completion of work that Responsible delivers
  * The Accountable role delegates tasks and ensures task prerequisites are met
  * Assign one Accountable role for each task or deliverable
* **Consulted** - Provides guidance from personal expertise, a subject matter expert (SME)
* **Informed** - Receives regular updates on task or deliverable completion 

### Stakeholders

Stakeholders have an interest in, and influence, project success. The following table has example Microsoft Entra ID Governance deployment stakeholder roles and responsibilities. 

|Role|Expertise|Responsibilities|
|---|---|---|
|IT Administrator|System administration|Manage user accounts, maintain system health, troubleshoot technical issues|
|Business Analyst|Requirements and analysis|Gather business requirements, analyze workflows, ensure solutions meet organizational needs|
|End user|System usage|Use the system as intended, provide feedback on performance and usability|

### Communications plan

A communications plan helps you proactively interact with your stakeholders and manage expectations. 

* Define the purpose and frequency of communications to stakeholders
* Determine who creates and distributes communications with mechanisms to share information
* Provide relevant information about deployment plans and status
* Explain upcoming changes in the user experience and how users get support 

### Schedule

A project is a success when you achieve the expected outcomes within budget and time constraints. Therefore, identify result goals by date, quarter, or year. Work with stakeholders for agreement on milestones that define result goals. Clarify success for each goal. Because Microsoft Entra ID Governance and other Microsoft services are in continuous development, map requirements to feature development stages. Set realistic expectations with contingency plans to meet key milestones: 

* Proof-of-concept (PoC)
* Pilot date
* Launch date
* Dates that affect delivery
* Dependencies

Learn more about [Microsoft Entra ID Governance](../id-governance/identity-governance-overview.md).  

In your project schedule:

* Work breakdown structure with dates, dependencies, critical path, based on subsequent waves of deployment:
  * Maximum number of users for each deployment wave, based on expected support load
  * Time frame for each deployment wave, such as a wave each Monday
  * User groups in each wave and don’t exceed the maximum
  * Apps that users require
* Team members assigned to tasks 

### Testing and roll-back

Unanticipated or untested scenarios can negatively affect your users. Create processes to: 

* Test scenarios
* Enable users to report issues
* Roll back the deployment
* Evaluate what went wrong:
  * Identify remediation
  * Communicate to stakeholders
* Test new configurations 

### Assessment and discovery

Assessment and discovery establish an understanding of the current state of identity governance, before you deploy Microsoft Entra ID Governance. Create an inventory of current identity governance solutions. Identify gaps and inefficiencies. 

* **Identify current state** - Document identity governance integrations, policies, workflows, data flows, and apps. Determine edge cases or custom workflows​.
* **Understand the solution** - Study and understand Microsoft Entra ID Governance architecture
* **Maintain stakeholder alignment** - Identify and align with stakeholders across teams. Ensure agreement on objectives and timelines.

For more information about assessment and discovery, see [best practices for securely deploying Microsoft Entra ID Governance](../id-governance/best-practices-secure-id-governance.md)

### Data collection

Collect current identity governance configuration data to establish an accurate baseline.   

* **User provisioning workflows** - Provisioning rules, connectors, business processes, or use cases
* **Joiner, Mover, Leaver** - Onboarding for joiners, processes for movers, and leaver offboarding
* **Entitlements and roles** - Current resources, entitlements, roles, their structure, and assignments
* **[Access reviews](../id-governance/access-reviews-overview.md)** - Plan access review scenarios for users, groups, and levels for apps, access packages, or groups
* **[Privileged Identity Management (PIM)](../id-governance/privileged-identity-management/pim-configure.md)** - Replicate activation rules, approval workflows, and role eligibility
* **Critical apps and integrations** - Apps and systems integrated with the current solution
  * Document migration priorities, based on organizational needs and risks 

## Lifecycle automation: Identity source of record

Identify the HR system, or source of records (source of truth) for user provisioning. Most organizations use a cloud HR solution: 

* Workday
* SAP SuccessFactors
* Oracle HCM
* Rippling
* Others with API-driven provisioning 

Confirm the user provisioning target and a need for writeback to the HR cloud app:   

* **Provision users to Active Directory** - Provision user sets from a cloud HR app to an Active Directory domain
* **Provision cloud-only users to Microsoft Entra ID** - If Active Directory isn't used, provision users from the cloud HR app to Microsoft Entra ID
* **Write back to the cloud HR app** - Write the email addresses and username attributes from Microsoft Entra to the cloud HR app 

You can use on-premises Active Directory Domain Services (AD DS) connectors and Microsoft Entra ID connectors. Topologies depend on mapping and requirements. 

Learn more about the [Microsoft Entra Connect provisioning agent](../identity/hybrid/cloud-sync/what-is-provisioning-agent.md). 

You can [plan cloud HR application to Microsoft Entra user provisioning](../identity/app-provisioning/plan-cloud-hr-provision.md).

## Define provisioning

Active Directory topology, if applicable: 

* **Evaluate the directory structure** - Understand the organizational units, forests, and domains in your Active Directory environment
* **Plan for synchronization** - Synchronize specific organizational units, or the directory. Consider scalability, redundancy, and replication latency.
* **Review hybrid scenarios and ensure Microsoft Entra Connect is optimized** - For forests with separate trusts, evaluate use of [Microsoft Entra Cloud Sync](../identity/hybrid/cloud-sync/reference-cloud-sync-faq.yml) 

### Pre-provisioning tasks

If an organization has **multiple inbound sources**, identify user data sources:  

* HR systems
* Identity stores
* In-house identity repositories 

Ensure sources have accurate information. Before migration, you can perform an audit or evaluation to determine if data clean up is needed.   

Choose an attribute that identifies and links user records with corresponding accounts in the target system. The default **matching attribute** is **EmployeeID**, commonly used across organizations. However, you decide what attribute is used.  

For provisioning, define the **scope of source objects**. To enhance performance, you can provision users in waves and exclude unnecessary data. 

Plan for **attribute calculation**. Handle long strings, special characters, or choose a unique username. Do calculations with expressions. 

For more information, see [writing expressions for attribute mappings in Microsoft Entra app provisioning](../identity/app-provisioning/functions-for-customizing-application-data.md)

### Configure provisioning

You can use guidance on cloud HR system integration, such as Workday, SuccessFactors, Oracle Human Capital Management (HCM), and Rippling. Another option is to use API-driven provisioning. Use the following table for guidance.

|HR source|Integration guidance|
|---|---|
|Workday|[Microsoft Entra ID and Workday integration](../identity/app-provisioning/workday-integration-reference.md)|
|SAP SuccessFactors|[Microsoft Entra ID and SAP SuccessFactors integration](../identity/app-provisioning/sap-successfactors-integration-reference.md)|
|Oracle HCM|[Microsoft Entra ID integration with Oracle HCM](../identity/saas-apps/oracle-hcm-provisioning-tutorial.md)|
|Rippling|[Sync identities from Rippling to Microsoft Entra ID](https://techcommunity.microsoft.com/blog/identity/sync-identities-from-rippling-to-microsoft-entra-id/4279690)|
|Other API-driven sources|[API-driven inbound provisioning concepts](../identity/app-provisioning/inbound-provisioning-api-concepts.md)|

### API-driven provisioning

When planning for API-driven inbound provisioning, consider your use cases and approach. To learn more, see the following video:</br></br>

> [!VIDEO aadc0d22-9bd4-4808-b6c4-ce51069a8d8f]

**API endpoint**

The **/bulkUpload** API endpoint expands the number of ways that you can manage users in Microsoft Entra ID. Determine if the **/bulkUpload** API endpoint is right for your integration scenario. 

Discover more about the [API-driven inbound learning path](../identity/app-provisioning/inbound-provisioning-api-concepts.md). 

## Joiner, Mover, Leaver workflows

For user provisioning to Microsoft Entra ID, document onboarding requirements such as credential provisioning, first-time sign-in, user moves, terminations, and more. Ensure processes comply with organizational policies and regulations.  

Microsoft Entra ID lifecycle workflows, entitlement management, and access reviews address multiple requirements:  

* Correct access for each user
* User actions with the access
* Access management controls
* Verifiable controls by auditors
* Environment readiness for users
* Timely access removal, as needed 

Some workflows trigger on a time value like **employeeHireDate** and **employeeLeaveDateTime**. 

You can [synchronize attributes for lifecycle workflows](../id-governance/how-to-lifecycle-workflow-sync-attributes.md).

The following list shows pre-defined lifecycle workflow tasks. You can enable others. 

* Determine the scenario
* Determine for whom and when
* Review and add tasks
* Create the workflow
* Conduct a pilot, run, and test 

Learn how to [plan a lifecycle workflow deployment](../id-governance/lifecycle-workflows-deployment.md).

### Provision and onboard apps

Determination of other target systems requires user provisioning, for instance IT Service Management (ITSM), private/on-premises apps, software-as-a-service (SaaS) apps. Use the guidance in the following table. 

|Target system|Approach|Guidance|
|---|---|---|
|ITSM|- Automated app user provisioning </br> - Lifecycle workflows custom extensions: APIs, private/on-premises systems </br>|- [Automated app user provisioning](../identity/app-provisioning/user-provisioning.md) </br> - [Workflow extensibility](../id-governance/lifecycle-workflow-extensibility.md)|
|Private/on-premises apps|- Extensible Connectivity Management Agent (ECMA) host </br> - Lifecycle workflows custom extensions </br>|- [Microsoft Entra on-premises app provisioning architecture]()</br> - [Workflow extensibility](../id-governance/lifecycle-workflow-extensibility.md)|
|Software-as-a-Service (SaaS) apps integrated with Microsoft Entra ID |Automated app user provisioning|[Automated app user provisioning](../identity/app-provisioning/user-provisioning.md)|

### Common tasks

Review the common tasks to automate for user onboarding, such as notification emails, and users added to teams. For many tasks, you can use lifecycle workflows tasks. A task set handles resource assignment and authorization with lifecycle workflows. 

**First user sign-in**

Define a process for credential provisioning and distribution. Use lifecycle workflows to generate a temporary access pass (TAP) at a trigger time, aligned with security policies.  

For example, on an employee hire date, generate a TAP and send it to the user manager. The manager shares the TAP, and the new-hire can set up passwordless authentication methods, such as FIDO2 and passwordless phone sign-in. You can use [Microsoft Authenticator](../identity/authentication/concept-authentication-authenticator-app.md) to enable sign-in without a password. 

TAP users navigate setup on Windows 10 and 11 for device join and to configure Windows Hello for Business. Use of [TAP](../identity/authentication/howto-authentication-temporary-access-pass.md) to set up [Windows Hello for Business](/windows/security/identity-protection/hello-for-business/) varies based on device joined state. 

Also, you can create a custom task extension to deliver the initial credentials. Common built-in onboarding tasks: 

* Add users from selected groups
* Add users from selected teams
*Enable user accounts
* Remove user access package assignments
* Send manager notification emails
* Run custom task extensions 

### Mover scenarios

Automate Mover job profile changes with lifecycle workflows. For example, a Mover scenario runs a scheduled workflow to notify managers by email and adds a user to groups. 

Trigger tasks by making changes in user attributes or group memberships. 

### Leaver scenario: user offboarding

Offboarding and ending access are important security tasks you can automate. Use lifecycle workflows to remove access with **employeeLeaveDateTime**. Trigger tasks, such as: 

* Remove users from selected groups
* Remove users from teams
* Disable user accounts
* Remove users from groups
* Remove user licenses
* Delete user accounts
* End access package assignments 

Learn more about [lifecycle workflows tasks and definitions](../id-governance/lifecycle-workflow-tasks.md).

### Ongoing operations

The following list has links to documentation about common operational tasks including maintenance, troubleshooting, and reporting: 

* [Run a workflow on demand](../id-governance/on-demand-workflow.md)
* [Customize emails from workflow tasks](../id-governance/customize-workflow-email.md)
* [Download workflow history reports](../id-governance/download-workflow-history.md)
* [Check lifecycle workflow status](../id-governance/check-status-workflow.md)
* [Customize workflow schedules](../id-governance/customize-workflow-schedule.md)
* [Manage users synchronized from Active Directory Domain Services (AD DS) with lifecycle workflows](../id-governance/manage-workflow-on-premises.md)
* [Check workflow execution with Workflow Insights](../id-governance/manage-workflow-insights.md)
* [Use custom security attributes to scope workflows](../id-governance/manage-workflow-custom-security-attribute.md)

## Best practices and recommendations

A best practice is a tested method or technique that helps deliver higher quality results, over time.

* Follow security protocols and guidelines when you assign resource access
* Enable Group Provisioning to AD to control access to on-premises AD group applications and resources
  * [Govern on-premises Active Directory (Kerberos) application access with groups from the cloud](../identity/hybrid/cloud-sync/govern-on-premises-groups.md)
* Use autoassignment policies to streamline assignments and their removal
  * Ensure alignment with Microsoft Entra entitlement management rules and governance [service limits](../id-governance/governance-service-limits.md)
* To manage permissions, request user access package assignment. For approval processes, select **Enforce policy approval** for administrator direct assignments. 
* To reflect user role changes, evaluate and update access packages
  * See [Create an access review of an access package in entitlement management](../id-governance/entitlement-management-access-reviews-create.md)
* Automate common tasks for lifecycle workflows: send notification emails, add users to teams.
  * Built-in tasks enhance user onboarding efficiency and accuracy, resource assignment, and authorization processes
* Use passwordless credentials when onboarding users
* Consider two options for Microsoft Entra ID Governance:
  * **Big Bang**: Load all users at once. Organizational size and object count affect processing times. This process can take several days.
  * **Phased**: Deploy the users in waves. Complexity and criticality affect processing duration. While considered safer, this process can take longer. 

  ## Next steps

  Microsoft Entra ID Governance deployment guide:

  * Introduction to Microsoft Entra ID Governance deployment guide
  * [Scenario 1: Employee lifecycle automation](governance-deployment-employee-lifecycle.md)
  * [Scenario 2: Assign employee access to resources](governance-deployment-employee-access.md)
  * [Scenario 3: Govern guest and partner access](governance-deployment-guest-access.md)
  * [Scenario 4: Govern privileged identities and their access](governance-deployment-privileged-identities.md)
