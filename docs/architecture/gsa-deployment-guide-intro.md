---
title: Introduction to Microsoft Global Secure Access Deployment Guide
description: Learn how to deploy Microsoft Global Secure Access for Microsoft Entra Private Access, Microsoft Entra Internet Access, and Microsoft Traffic
customer intent: As a Microsoft Partner, I want to deploy Microsoft Global Secure Access for Microsoft Entra Private Access, Microsoft Entra Internet Access, and Microsoft Traffic as a Proof of Concept in my production or test environment.
author: jricketts
manager: martinco
ms.service: global-secure-access
ms.topic: article
ms.date: 01/06/2025
ms.author: jricketts
---
# Introduction to Microsoft Global Secure Access Deployment Guide

[Microsoft Global Secure Access](../global-secure-access/overview-what-is-global-secure-access.md) is a key component of a successful [Secure Access Service Edge](https://www.microsoft.com/security/business/security-101/what-is-sase) (SASE) strategy. It features [Microsoft Entra Internet Access](../global-secure-access/concept-internet-access.md), [Microsoft Entra Private Access](../global-secure-access/concept-private-access.md), and [Microsoft Traffic](../global-secure-access/concept-microsoft-traffic-profile.md). It uses Microsoft's vast private wide area network and your investment in Conditional Access policies to help you to secure your corporate data at the network level.

Here are key Global Secure Access deployment scenarios:

- Replace existing VPN solutions with a [Zero Trust Network Access](/security/zero-trust/deploy/networks) (ZTNA) approach that provides secure connectivity from endpoint to application.
- Secure and monitor Microsoft Traffic for on-site and remote employees.
- Secure and monitor internet traffic for on-site and remote employees.

This Deployment Guide helps you to plan and deploy Microsoft Global Secure Access. See [Global Secure Access licensing overview](../global-secure-access/overview-what-is-global-secure-access.md#licensing-overview) for licensing information. While most of the services are generally available (GA), some parts of the service are in public preview. ​See [425 Show: Plan and Implement your Global Secure Access deployment](https://youtu.be/px6dd9ZJ7R0) for a video walk through detailing deployment planning and implementation recommendations.

## Perform a Proof of Concept

Perform a [Proof of Concept](gsa-poc-guidance-intro.md) (PoC) to ensure that the solution you choose provides the features and connectivity that you require.

Depending on which capabilities you plan to deploy in a PoC for Microsoft Global Secure Access, you need up to seven hours. Ensure you have met the [licensing requirements](../global-secure-access/overview-what-is-global-secure-access.md#licensing-overview).

- Configure prerequisites: One hour
- Configure initial product: 20 minutes
- Configure remote network: 1 to 2 hours
- Deploy and test Microsoft Traffic profile: One hour
- Deploy and test Microsoft Entra Internet Access: One hour
- Deploy and test Microsoft Entra Private Access: One hour
- Close PoC: 30 minutes

See [425 Show: Global Secure Access Proof of Concept Deep Dive](https://youtu.be/BKLvA0p_v1g) for a video walk-through detailing proof of concept procedures.

## Initiate your Global Secure Access project

Project initiation is the first step in any successful project. At the start of project initiation, you decided to implement Microsoft Global Secure Access. Project success depends on you to understand requirements, define success criteria, and ensure appropriate communications. Be sure to manage expectations, outcomes, and responsibilities.

### Identify business requirements, outcomes, and success criteria

Identify business requirements, outcomes, and success criteria to clarify exactly what you need to accomplish with success criteria. For example:

- What is the key result that you need this project to achieve?
- How do you plan to replace your VPN?
- How do you plan to secure your Microsoft Traffic?
- How do you plan to secure your internet traffic?

After you identify the primary scenarios, dive into the details:

- Which applications do your users need to access?
- Which web sites need access control?
- What is mandatory and what is optional?

During this stage, create an inventory that describes in-scope users, devices, and key applications. For VPN replacement, start with Quick Access to identify the private applications that your users need to access so that you can define them in Microsoft Entra Private Access.

### Define the schedule

Your project is a success after you achieve desired results within budget and time constraints. Identify result goals by date, quarter, or year. Work with your stakeholders to understand specific milestones that define result goals. Define review requirements and success criteria for each goal. Because Microsoft Global Secure Access is in continuous development, map requirements to feature development stages.

### Identify stakeholders

Identify and document stakeholders, roles, responsibilities for people who play a role in your ZTNA project. Titles and roles can differ from one organization to another; however, the ownership areas are similar. Consider the roles and responsibilities in the following table and identify corresponding stakeholders. Distribute such a table to leadership, stakeholders, and your team.

|Role|Responsibility|
|---|---|
|Sponsor|Enterprise senior leader with authority to approve and/or assign budget and resources. Connects managers and executive teams. Technical decision maker for product and feature implementation.|
|End users|People for whom you implement the service. Can participate in a pilot program.|
|IT support manager|Provides input on proposed change supportability.|
|Identity architect|Defines how the change aligns with identity management infrastructure. Understands current environment.|
|Application business owner|Owns affected applications that might include access management. Provides input on the user experience.|
|Security owners|Confirms that the change plan meets security requirements.|
|Network manager|Oversees network functionality, performance, security, and accessibility.|
|Compliance Manager|Ensures compliance with corporate, industry, and governmental requirements.|
|Technical program manager|Oversees the project, manages requirements, coordinates work streams, and ensures adherence to schedule and budget. Facilitates communication plan and reports.|
|SOC/CERT team|Confirms threat hunting log and report requirements.|
|Tenant administrator|Coordinates IT owners and technical resources responsible for Microsoft Entra tenant changes throughout project.|
|Deployment team|Performs deployment and configuration tasks.|

### Create a RACI chart

Responsible, Accountable, Consulted, Informed (RACI) refers to role and responsibility definitions. For project and cross-functional or departmental projects and processes, define and clarify roles and responsibilities in a RACI chart.

1. Download the [Global Secure Access Deployment Guide RACI template](https://download.microsoft.com/download/1/4/E/14E6151E-C40A-42FB-9F66-D8D374D13B40/gsa-deployment-guide-raci-template.xlsx) as a starting point.
1. Map the Responsible, Accountable, Consulted, Informed roles and responsibilities to project workstreams.
1.  Distribute the RACI chart to stakeholders and ensure that they understand assignments.

### Create communications plan

A communications plan helps you to appropriately, proactively, and regularly interact with your stakeholders.

- Provide relevant information about deployment plans and project status.
- Define the purpose and frequency of communications to each stakeholder in the RACI chart.
- Determine who creates and distributes communications along with mechanisms to share information. For example, the communications manager keeps end users up to date on pending and current changes with email and on a designated website.
- Include information about changes in user experience and how users can get support. Refer to sample end user communication templates:
  - [Microsoft Entra Private Access End User announcement](https://download.microsoft.com/download/1/4/E/14E6151E-C40A-42FB-9F66-D8D374D13B40/Microsoft%20Entra%20Private%20Access%20End%20User%20announcement.docx)
  - [Microsoft Entra Internet Access End User announcement](https://download.microsoft.com/download/1/4/E/14E6151E-C40A-42FB-9F66-D8D374D13B40/Microsoft%20Entra%20Internet%20Access%20End%20User%20announcement.docx)
 
### Create change control plan

Plans are subject to change as the project team gathers information and details. Create a change control plan to describe to stakeholders:

- change request processes and procedures.
- how to understand change impact.
- responsibilities for review and approval.
- what happens when a change requires more time or funds.

A good control plan ensures that teams know what to do when changes are necessary.

### Create project closure plan

Every project closure requires a post-project review. Identify the metrics and information to include in this review so that you can regularly collect the correct data throughout the project lifetime. A project closure plan helps you to efficiently generate your Lessons Learned Summary.

### Get stakeholder consensus

After you complete your project initiation tasks, work with each stakeholder to ensure plans meet their specific needs. Prevent misunderstandings and surprises with an official approval process that documents consensus and written approvals. Hold a kick-off meeting that covers the scope and details in reference documentation.

## Plan your Global Secure Access project

### Create detailed project schedule

Create a detailed project schedule with the milestones that you identified in project initiation. Set realistic expectations with contingency plans to meet key milestones:

- Proof of Concept (PoC)
- Pilot date
- Launch date
- Dates that affect delivery
- Dependencies

Include this information in your project schedule:

- Detailed work breakdown structure with dates, dependencies, and critical path

  - Maximum number of users to be cut over in each wave based on expected support load
  - Time frame for each deployment wave (such as cut over a wave each Monday)
  - Specific groups of users in each deployment wave (not to exceed the maximum number)
  - Apps that users require (or use Quick Access)

- Team members assigned to each task

### Create risk management plan

Create a risk management plan to prepare for contingencies that could impact dates and budget.

- Identify critical path and mandatory key results.
- Understand work stream risks.
- Document backup plans to stay on track when contingencies occur.

### Define performance success criteria

Define acceptable performance metrics to objectively test and ensure that your deployment is successful and your user experience is within parameters. Consider including the following metrics.

#### Microsoft Entra Private Access

- Is the network performance within your defined parameters?

  - The [Global Secure Access dashboard](../global-secure-access/concept-traffic-dashboard.md) provides you with visualizations of network traffic that Microsoft Entra Private and Microsoft Entra Internet Access acquire. It compiles data from network configurations including devices, users, and tenants.
  - Use [Network Monitoring in Azure Monitor logs](/azure/networking/network-monitoring-overview) to monitor and analyze network connectivity, ExpressRoute circuit health, and cloud network traffic.

- Did you notice latency increase during the pilot? Do you have app-specific latency requirements?
- Is Single Sign On (SSO) to your key applications working correctly?
- Consider running user satisfaction and user acceptance surveys.

#### Microsoft traffic

- Is the network performance within your defined parameters?

  - The [Global Secure Access dashboard](../global-secure-access/concept-traffic-dashboard.md) provides you with visualizations of network traffic that Microsoft Entra Private and Microsoft Entra Internet Access acquire. It compiles data from network configurations including devices, users, and tenants.
  - Use the [Microsoft 365 network assessment](/microsoft-365/enterprise/office-365-network-mac-perf-score) to distill an aggregate of network performance metrics into a snapshot of your enterprise network perimeter health.
  - Use the [Microsoft 365 network connectivity test](https://connectivity.office.com/) to measure the connectivity between your device and the internet, and from there to Microsoft's network.

- Did you notice any latency increase during the pilot?
- Consider running a user satisfaction survey.
- Consider running a user acceptance survey.

#### Microsoft Entra Internet Access

- Is the network performance within your defined parameters?

  - Use [Network Monitoring in Azure Monitor logs](/azure/networking/network-monitoring-overview) to monitor network connectivity, the health of ExpressRoute circuits, and analyze network traffic in the cloud.
  - Use [Speedtest by Ookla - The Global Broadband Speed Test](https://www.speedtest.net/).
  - Use [Internet Speed Test - Measure Network Performance \| Cloudflare](https://speed.cloudflare.com/).

- Does traffic blocking and filtering work as you expect?
- Consider running user satisfaction and user acceptance surveys.

### Plan for roll-back scenarios

As you work through your production deployment and actively increase the number of users with Microsoft's Security Service Edge, you might discover unanticipated or untested scenarios that negatively impact end users. Plan for negative impact:

- Define a process for end users to report issues.
- Define a procedure to roll back the deployment for specific users or groups or disable the traffic profile.
- Define a procedure to evaluate what went wrong, identify remediation steps, and communicate to stakeholders.
- Prepare to test new configurations before production deployment continues to subsequent waves of users.

## Execute your project plan

### Obtain permissions

Ensure that administrators who interact with [Global Secure Access](../global-secure-access/overview-what-is-global-secure-access.md) have the [correct roles assigned](../global-secure-access/reference-role-based-permissions.md#role-based-permissions).

### Prepare your IT Support team

Determine how users get support when they have questions or connectivity issues. Develop self-service documentation to reduce pressure on your IT Support team. Ensure that your IT Support team receives training for deployment readiness. Include them in end user communications so that they know phased migration schedules, impacted teams, and in-scope applications. To prevent confusion in the user base or within IT Support, establish a process to handle and escalate user support requests.

### Perform a pilot deployment

Given the users, devices, and applications in scope for your production deployment, start with a small, initial test group. Fine tune the process of communications, deployment, testing, and support for your phased roll-out. Before you begin, review and confirm you have all [prerequisites](../global-secure-access/quickstart-access-admin-center.md#prerequisites) in place.

Ensure device registration in your tenant. Follow the guidelines in [Plan your Microsoft Entra device deployment](../identity/devices/plan-device-deployment.md). If your organization uses Intune, follow the guidelines in [Manage and secure devices in Intune](/mem/intune/fundamentals/manage-devices#use-your-existing-devices-and-use-new-devices).

### Recommendations for optional requirements 

The resources in the following table provide detailed planning and execution tasks for each optional requirement.

|Optional requirement|Resource|
|---|---|
|Secure access to your Microsoft Traffic.|[Microsoft traffic deployment plan](gsa-deployment-guide-microsoft-traffic.md)|
|Replace your VPN with a Zero Trust solution to protect on-premises resources with the Private Access traffic profile.|[Microsoft Entra Private Access deployment plan](gsa-deployment-guide-private-access.md)|
|Secure your internet traffic with the Microsoft Entra Internet Access traffic profile.|[Microsoft Entra Internet Access deployment plan](gsa-deployment-guide-internet-access.md)|

Your pilot should encompass a few users (fewer than 20) that can test required in-scope devices and applications. After you identify pilot users, assign them to the traffic profiles either individually or as a group (recommended). Follow detailed guidance in [Assign users and groups to traffic forwarding profiles](../global-secure-access/how-to-manage-users-groups-assignment.md).

Systematically work through each identified in-scope application. Ensure that users can connect as expected on in-scope devices. Observe and document performance success criteria metrics. Test communications plans and processes. Fine tune and iterate as necessary.

After the pilot completes and meets success criteria, ensure that the support team is ready for next phases. Finalize processes and communications. Proceed to production deployment.

### Deploy to production

After you complete all plans and tests, deployment should be a repeatable process with expected results.

For more information, see the relevant guidance:

- [Microsoft Global Secure Access deployment guide for Microsoft Traffic](gsa-deployment-guide-microsoft-traffic.md)
- [Microsoft Global Secure Access deployment guide for Microsoft Entra Internet Access](gsa-deployment-guide-internet-access.md)
- [Microsoft Global Secure Access deployment guide for Microsoft Entra Private Access](gsa-deployment-guide-private-access.md)

Repeat wave deployments until you cut over all users to Microsoft Global Secure Access. If you're using Microsoft Entra Private access, it disables Quick Access and forwards all traffic through Global Secure Access applications.

### Plan for emergency access

When Global Secure Access is down, users can't access resources that the Global Secure Access-compliant network check secures. The `GsaBreakglassEnforcement` [script](../global-secure-access/scripts/powershell-break-glass.md) allows enterprise administrators to switch enabled compliant network Conditional Access policies to report-only mode. The script temporarily allows users to access those resources without Global Secure Access.

After Global Secure Access is back, use the `GsaBreakglassRecovery` [script](../global-secure-access/scripts/powershell-break-glass-recovery.md) to turn on all affected policies.

### Additional considerations

- Follow guidance in [Assign users and groups to traffic forwarding profiles](../global-secure-access/how-to-manage-users-groups-assignment.md) to unassign users from the traffic profiles.
- Follow guidance in [How to enable and manage Microsoft traffic](../global-secure-access/how-to-manage-microsoft-profile.md) to disable problematic traffic profiles.
- Follow guidance in [How to configure Per-app Access using Global Secure Access applications](../global-secure-access/how-to-configure-per-app-access.md#assign-users-and-groups) to unassign Users and Groups from problematic app segments and their respective Conditional Access policies.

## Monitor and control your Global Secure Access project

Monitor and control your project to manage risks and identify issues that might require deviation from your plan. Keep your project on track and ensure accurate and timely communications to stakeholders. Always complete requirements accurately, on time, and within budget.

Key objectives of this phase:

- **Progress monitoring.** Did tasks complete as scheduled? If not, why not? How do you get back on track?
- **Issues discovery.** Did issues crop up (such as unplanned resource availability or other unforeseen challenges)? Did required changes necessitate change orders?
- **Efficiency monitoring.** Did you identify inherent inefficiencies in defined processes? When monitoring reveals inefficiencies, how do you fine tune your project approach?
- **Communications confirmation.** Were stakeholders happy with your communication frequency and level of detail? If not, how do you adjust?

Establish weekly schedule and project detail review. Pay close attention to critical milestones. Generate appropriate communications to all stakeholders and capture data for project closure reports.

## Close your Global Secure Access project

Congratulations! You completed your Microsoft Global Secure Access deployment. Tie up loose ends and close the project:

- Collect feedback from stakeholders to understand whether the team met expectations and needs.
- Use the data that you collected throughout the execution phase (as defined during project initiation) to develop required close-out assets. For example, project assessment, lessons learned, and post-mortem presentations.
- Archive project details for reference on similar future projects.

## Next steps

- [425 Show: Plan and Implement your Global Secure Access deployment](https://youtu.be/px6dd9ZJ7R0).
- Learn how to accelerate your transition to a Zero Trust security model with [Microsoft Entra Suite and Microsoft's unified security operations platform](https://www.microsoft.com/security/blog/2024/07/11/simplified-zero-trust-security-with-the-microsoft-entra-suite-and-unified-security-operations-platform-now-generally-available/)
- [Microsoft Global Secure Access deployment guide for Microsoft Traffic](gsa-deployment-guide-microsoft-traffic.md)
- [Microsoft Global Secure Access Deployment Guide for Microsoft Entra Internet Access](gsa-deployment-guide-internet-access.md)
- [Microsoft Global Secure Access Deployment Guide for Microsoft Entra Private Access](gsa-deployment-guide-private-access.md)
- [Simulate remote network connectivity using Azure Virtual Network Gateway - Global Secure Access](../global-secure-access/how-to-simulate-remote-network.md)
- [Simulate remote network connectivity using Azure vWAN - Global Secure Access](../global-secure-access/how-to-create-remote-network-vwan.md)
- [Introduction to Global Secure Access Proof of Concept Guidance](gsa-poc-guidance-intro.md)
- [Video - 425 Show: Global Secure Access Proof of Concept Deep Dive](https://youtu.be/BKLvA0p_v1g)
- [Global Secure Access Proof of Concept Guidance - Configure Microsoft Entra Private Access](gsa-poc-private-access.md)
- [Global Secure Access Proof of Concept Guidance - Configure Microsoft Entra Internet Access](gsa-poc-internet-access.md)
