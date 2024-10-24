---
title: 'External guest - new project'
description: Describes overview of getting started with a new external guest project.
author: billmath
manager: amycolannino
ms.service: entra-id-governance
ms.topic: overview
ms.date: 10/15/2024
zone_pivot_groups: identity-governance-guest-new-project
ms.author: billmath
---


# New guest lifecycle project with Microsoft Entra ID Governance

The following documentation will guide you through creating and deploying guest access scenarios.



:::zone pivot="identity-governance-guest-overview"

## Overview:  An overview of guest scenarios
Guest Scenarios or external access scenarios are specific use cases where business guests (External individuals like contractors, consultants, vendors, or partners who need access to the organization’s resources) interact with the organization’s resources. 

:::image type="content" source="media/external-guest-new/govern-access-1.png" alt-text="Conceputal drawing of governing access to your resources." lightbox="media/external-guest-new/govern-access-1.png":::

Understanding these scenarios helps in designing appropriate access controls and ensuring smooth collaboration with external individuals.  Some examples of guest scenarios include:

 - If you’re an organization or a developer creating consumer apps, and you need add authentication and customer identity and access management (CIAM) to your application to allow extrnal guests access.  For more information, see [External ID overview](../../external-id/external-identities-overview.md)

 - If you want to enable your employees to collaborate with business partners and guests and allow secure access through invitation or self-service sign-up. Determine the level of access guests have to the Microsoft Entra tenant that contains your employees and organizational resources, which is a tenant in a workforce configuration.  For more information, see [Overview: B2B collaboration with external guests for your workforce](../../external-id/what-is-b2b.md)

## License Requirements 

Using some of the below features mentioned requires Microsoft Entra ID Governance or Microsoft Entra Suite licenses. To find the right license for your requirements, see [Microsoft Entra ID Governance licensing fundamentals](../licensing-fundamentals.md)

:::zone-end

:::zone pivot="identity-governance-guest-secure"


## Security posture: Determine your security posture for guest access

As you consider the governance of external access, assess your organization's security and collaboration needs, by scenario. You can start with the level of control the IT team has over the day-to-day collaboration of end users. Organizations in highly regulated industries might require more IT team control. 

For example:

 - Defense contractors can have a requirement to positively identify and document external users, their access, and access removal.
 - Consulting agencies can use certain features to allow end users to determine the external users they collaborate with.
 - A contractor at a bank may require more control than a contractor at a software company

  ![Bar graph of the span from full IT team control, to end-user self service.](../../architecture/media/secure-external-access/1-overall-control.png)

   > [!NOTE]
   > A high degree of control over collaboration can lead to higher IT budgets, reduced productivity, and delayed business outcomes. When official collaboration channels are perceived as onerous, end users tend to evade official channels. An example is end users sending unsecured documents by email.

### Scenario-based planning

IT teams can delegate partner access to empower employees to collaborate with partners. This delegation can occur while maintaining sufficient security to protect intellectual property.

Compile and assess your organizations scenarios to help assess employee versus business partner access to resources. Financial institutions might have compliance standards that restrict employee access to resources such as account information. Conversely, the same institutions can enable delegated partner access for projects such as marketing campaigns.

   ![Diagram of a balance of IT team goverened access to partner self-service.](../../architecture/media/secure-external-access/1-scenarios.png)

#### Scenario considerations

Use the following list to help measure the level of access control.

- Information sensitivity, and associated risk of its exposure
- Partner access to information about other end users
- The cost of a breach versus the overhead of centralized control and end-user friction

Organizations can start with highly managed controls to meet compliance targets, and then delegate some control to end users, over time. There can be simultaneous access-management models in an organization.

You should start with reviewing the documentation for [Secure external Collaboration](../../architecture/1-secure-access-posture.md) and [Plan a Microsoft Entra B2B collaboration deployment](../../architecture/secure-external-access-resources.md).  Reviewing this documentation will allow you to devise and create a security plan that can be used with your guest scenarios.

:::zone-end


:::zone pivot="identity-governance-guest-discover"

## Discovery: Identify current lifecycle and governance processes for external identities 
Identify your current lifecycle and governance processes for external identities.  This exercise will help you to determine applicable scenarios, feasibility and scope.  

Review the [Govern the employee and guest lifecycle with Microsoft Entra ID Governance](govern-the-employee-lifecycle.md) with emphasis on external identities.  The processes covered here are also needed for guest users, suppliers and other guests, to enable them to collaborate or have access to resources. This document covers actions you can take to discover your governance processes.


You can also use the following table as a guide for additional areas to consider while evaluating your current state.

|Process|Description|
|-----|-----|
|Determine who initiates external collaboration|Generally, users seeking external collaboration know the applications to use, and when access ends. Therefore, determine users with delegated permissions to invite external users, create access packages, and complete access reviews.|
|Enumerate guest users and organizations|External users might be Microsoft Entra B2B users with partner-managed credentials, or external users with locally provisioned credentials. Typically, these users are the Guest UserType.|
|Discover email domains and companyName property|You can determine external organizations with the domain names of external user email addresses.|
|Use allowlist, blocklist, and entitlement management|Use the allowlist or blocklist to enable your organization to collaborate with, or block, organizations at the tenant level.|
|Determine external user access|With an inventory of external users and organizations, determine the access to grant to the users.|
|Enumerate application permissions|Investigate access to your sensitive apps for awareness about external access.|
|Detect informal sharing|If your email and network plans are enabled, you can investigate content sharing through email or unauthorized software as a service (SaaS) apps.|

For more information, see [Discover the current state of external collaboration in your organization](../../architecture/2-secure-access-current-state.md)




### Example - Identify current lifecycle and governance processes
Your the IT admin at a bustling tech company, Contoso, and often face the challenge of efficiently and securely onboarding business guests like consultants, vendors, and partners. The current onboarding process is fragmented and inconsistent, leading to security vulnerabilities and inefficiencies. To tackle this, you embark on a discovery phase to identify key requirements and understand how you could leverage Microsoft Entra.

:::image type="content" source="media/external-guest-new/discover-1.png" alt-text="Conceputal drawing of an organization." lightbox="media/external-guest-new/discover-1.png":::

Some of your key requirements include,  

 - Diverse guest onboarding needs with different departments requiring unique levels of access.  
 - Ensuring that guest users have the least privilege necessary to perform their tasks is critical and needs robust conditional access policies and multi-factor authentication to protect sensitive data. 
 - Seamless and use friendly onboarding process for both you as an IT admin, and your business guests. Guests should be able to quickly and easily access the resources they require without unnecessary delays.  
 - Integration with existing collaboration tools like Microsoft Teams and SharePoint, along with the option for Self-Service Sign-Up (SSSU) 
 - Capability to govern guest by regularly monitoring guest user activity, set an expiration on access and periodic access reviews ensure that guest access remains appropriate over time. For more information, see [Govern the employee and guest lifecycle with Microsoft Entra ID Governance](govern-the-employee-lifecycle.md) and [Discover the current state of external collaboration in your organization](../../architecture/2-secure-access-current-state.md)

With these key requirements in mind, here are two things to consider:
 - onboarding the guest to the tenant
 - getting the guest access to resources

There are different options depending on the business case. Let’s deep dive into onboarding of the guests and the options that are available.


:::zone-end

::: zone pivot="identity-governance-guest-onboard"  

## Onboarding of Business Guests
Onboarding for guest accounts can be broken down in to 2 main parts when considering developing a process.  These are:

1.  Develop an onboarding process to get guests into the system.  How are we going to get guests into our systems?
2.  Enable the guest users to access the systems.  How will the guests access these systems?

The following sections cover both of these parts so that you can create a comprehensive onboarding process.

### Develop a comprehensive onboarding process for business guests 
Onboarding, with regard to guest or external identities, is the process or processes of getting these identities set up in your organizations systems.  Depending on the systems they will be added to or allowed to access, these processes may differ.

Onboarding guest identities can be done in several ways.

[Provisioning a user using Entitlement Management (Recommended)](#example---provisioning-a-user-using-entitlement-management) - External user onboarding processes often involve collecting information about the users to guide decisions about whether to grant access, or how to set up their account properly for the apps and resources they use. Collecting information about the users to guide decisions about: 
 
 - whether to grant access 
 - how to set up their account properly for the apps and resources they use.

 This process could include determining their role in their organization, so the approver knows whether the team is right for them. 
 You could need to set the location attribute for external users.  Using Entitlement management’s features automatically provide your approvers and apps with the information they need.   For more information, see [Tutorial - Onboard external users to Microsoft Entra ID through an approval process](../entitlement-management-onboard-external-user.md)

[End User Driven Collaboration](#example---end-user-driven-collaboration) - External collaboration settings let you specify what roles in your organization can invite external users for B2B collaboration. These settings also include options for allowing or blocking specific domains, and options for restricting what external guest users can see in your Microsoft Entra directory. 

#### Additional onboarding options 

[Self-Service sign up](../../external-id/what-is-b2b.md#allow-self-service-sign-up) - With a self-service sign-up user flow, you can create a sign-up experience for guests who want to access your apps. As part of the sign-up flow, you can provide options for different social or enterprise identity providers, and collect information about the user. 

[Bulk invite](../../external-id/tutorial-bulk-invite.md#invite-guest-users-in-bulk)  - If you use Microsoft Entra B2B collaboration to work with external partners, you can invite multiple guest users to your organization at the same time.

### Enable guest users to securely access an organization’s resources by accepting an invitation  
Now that we have discussed the various ways that guest users can be onboarded into your organizations systems, we should cover the second part of the process.  Guest user acceptance or redemption.  There are several different ways a guest user can redeem an invitation.  The table below provides an overview of these ways.

|Process|Description|
|-----|-----|
|Invitation email|When you add a guest user to your directory by using the Microsoft Entra admin center, an invitation email is sent to the guest in the process.|
|Direct link|You can give a guest a direct link to your app or portal.|
|Common endpoint|Guest users can now sign in to your multitenant or Microsoft first-party apps through a common endpoint (URL), for example `https://myapps.microsoft.com`.| 

For more information, see [B2B collaboration invitation redemption](../../external-id/redemption-experience.md)

#### Additional guest enablement considerations
Many of the tasks that will allow guest users to sign-in and get started, can be automated using lifecycle workflows.  For more information on how you can automate these and additional tasks, see [Automate employee and guest onboarding tasks](../tutorial-onboard-custom-workflow-portal.md)


### Iterate additional resources via direct assignment
Now you may have additional requirements that need to be assigned to guest users.  This can be done through the use of Access packages and entitlement management.  

For instance, you may have an access package that is assigned to your regular users and you want a similar package assigned to guest users.  You can use entitlement management to assign the guest users to these access packages.  See [View, add, and remove assignments for an access package in entitlement management](../entitlement-management-access-package-assignments.md)

You may opt to create a new package, not touching your exisiting one, and assign guest users to that package.  For more information see:
 - [Creating an access package](../entitlement-management-access-package-create.md)
 - [Configure an automatic assignment policy for an access package in entitlement management](../entitlement-management-access-package-auto-assignment-policy.md)
 - [Change lifecycle settings for an access package in entitlement management](../entitlement-management-access-package-lifecycle-policy.md)

The sections below provide examples of various ways that you can onboard guest users



### Example - Provisioning a user using Entitlement Management:
As an IT admin, you have identified a project that requires onboarding external consultants from Fabrikam to collaborate. It's important to have automated access management, approval workflows, and lifecycle management.
Using Microsoft Entra’s Entitlement Management, you create an access package that allows you to bundle multiple resources (like groups, applications, and SharePoint sites), include approval workflows ensuring that access requests are reviewed and approved by the appropriate individuals before access is granted and set time period for the access. 

You send out the invitations to the consultants, who receive emails with links to accept the access package. John, one of the consultants, follows the link, verifies his identity, and gains access to the necessary resources within minutes. The onboarding process is smooth and secure, allowing the consultants to start collaborating immediately. The project kicks off without delays, ensuring a productive partnership between Contoso and Fabrikam. 

:::image type="content" source="media/external-guest-new/user-1.png" alt-text="Conceputal drawing of invite using entitlement management." lightbox="media/external-guest-new/user-1.png":::

For more information, see:

- [Onboard external users with entitlement management](../entitlement-management-onboard.md)
- [Configure an automatic assignment policy for an access package in entitlement management](../entitlement-management-access-package-auto-assignment-policy.md)
- [Tutorial - Onboard external users to Microsoft Entra ID through an approval process](../entitlement-management-onboard-external-user.md)
- [Microsoft Entra deployment scenario - Workforce and guest onboarding, identity, and access lifecycle governance across all your apps](../../architecture/deployment-scenario-workforce-guest.md)


### Example - End User Driven Collaboration:  
For another design project, the design team manager asked you as the IT admin to add John Doe from Global Solutions to collaborate. The primary goal is to invite the user to join your directory and collaborate. You invite external user John as a guest user by using his email. The email invite is simple and flexible and allows you to invite users from various domains and identity providers, including social identities like Gmail or Microsoft accounts. 
John uses his own credentials to sign in securely eliminating the need for password maintenance or account lifecycle management that simplifies the onboarding process.  

:::image type="content" source="media/external-guest-new/user-2.png" alt-text="Conceputal drawing of invite using B2B." lightbox="media/external-guest-new/user-2.png":::

For more information, see [Add B2B collaboration users in the Microsoft Entra admin center](../../external-id/add-users-administrator.yml) and [Configure external collaboration settings](../../external-id/external-collaboration-settings-configure.md)

### Example - Redemption via invitation email: 
John, a guest user, receives an email invitation from Contoso to access their internal portal. He clicks on the link provided in the email, which takes him to the Contoso’s sign-in page. Here, John is presented with the company’s privacy terms and conditions, which he reads through and accepts. He then signs-in using his existing email account. With the sign-in process complete, John is granted access to the Contoso portal, where he can now seamlessly collaborate with internal users. For more information, see [Redemption process through the invitation email](../../external-id/redemption-experience.md#redemption-process-through-the-invitation-email)

### Example - Redemption via direct link: 
In another instance, Jane, another guest user, receives a direct link to the Contoso Ltd. application from her contact at the company. She clicks on the link, which directs her to the sign-in page. Jane reviews and accepts the privacy terms and conditions before signing in with her existing email account. Once authenticated, she gains access to the application and can start working with her Contoso Ltd. colleagues. For more information, see [Redemption process through a direct link](../../external-id/redemption-experience.md#redemption-process-through-a-direct-link)

### Example - Redemption via common endpoint URL: 
Meanwhile, Alex, a guest user, navigates to the common endpoint URL, myapps.microsoft.com. He selects the option to sign-in to an organization and enters the domain name of Contoso Ltd. After reviewing and accepting the privacy terms and conditions, Alex signs in using his existing email account. Successfully authenticated, Alex can now access the resources provided by Contoso Ltd., ready to collaborate and contribute.  For more information, see [Redemption process and sign-in through a common endpoint](../../external-id/redemption-experience.md#redemption-process-and-sign-in-through-a-common-endpoint)

### Example - Iterate additional resources via direct assignment
Now you as an IT administrator have a requirement to bypass access requests and directly assign specific users to an access package, granting the external team instant access. you'll create the first access package assignment policy in the access package. You review the access package’s policies to confirm that it permits external users to be added directly. 

With everything in place, Emma moved to the assignments tab. She entered the email addresses of the external team members, ensuring they were correctly listed. After a final review, she clicked the “Assign” button. 

Almost immediately, the external partners received their invitations. They joined the directory seamlessly and gained access to the necessary resources without any delays. This efficient setup allowed both teams to start their collaborative work right away, fostering a productive and innovative environment. For more information see:
 - [Creating an access package](../entitlement-management-access-package-create.md)
 - [Configure an automatic assignment policy for an access package in entitlement management](../entitlement-management-access-package-auto-assignment-policy.md)
 - [Change lifecycle settings for an access package in entitlement management](../entitlement-management-access-package-lifecycle-policy.md)

::: zone-end  


::: zone pivot="identity-governance-guest-monitor"  

## Monitor your active and inactive account assignments 
As your organization collaborates with external partners, it’s possible that many guest accounts get created in Microsoft Entra tenants over time.  While collaboration is occuring and when it ends, it is a good security practice to review access.  This helps to monitor active and inactive accounts.  

### Manage inactive accounts
Inactive accounts are user accounts that aren't required anymore by members of your organization to gain access to your resources.  These accounts, even though they are no longer needed, may still have access to important and proprietary resources. Learn more about [how to manage inactive user accounts in Microsoft Entra ID](~/identity/monitoring-health/howto-manage-inactive-user-accounts.md).

There are a few recommended patterns that are effective at monitoring and cleaning up stale guest accounts:

1. Monitor guest accounts at scale with intelligent insights into inactive guests in your organization using inactive guest report. Customize the inactivity threshold depending on your organization’s needs, narrow down the scope of guest users you want to monitor and identify the guest users that may be inactive.

2. Create a multi-stage review whereby guests self-attest whether they still need access. A second-stage reviewer assesses results and makes a final decision. Guests with denied access are disabled and later deleted.

3. Create a review to remove inactive external guests. Admins define inactive as period of days. They disable and later delete guests that don’t sign in to the tenant within that time frame. By default, this doesn't affect recently created users. [Learn more about how to identify inactive accounts](~/identity/monitoring-health/howto-manage-inactive-user-accounts.md#how-to-detect-inactive-user-accounts).

When collaboration ends and the users no longer access your tenant, the guest accounts may become stale. Administrators can monitor guest accounts at scale using inactive guest insights. Administrators can also use Access Reviews to automatically review inactive guest users, block them from signing in, and, delete them from the directory.

For more information, see [Monitor and clean up stale guest accounts using access reviews](../../identity/users/clean-up-stale-guest-accounts.md)

### Review guest account access
With access reviews, you can easily ensure that users or guests have appropriate access. You can ask the users themselves or a decision maker to participate in an access review and recertify (or attest) to users' access.  When an access review is finished, you can then make changes and remove access from users who no longer need it.  For more information, see [Manage user and guest user access with access reviews](../manage-access-review.md)


### Example - Monitoring your organization's access
As the company grew, so did the complexity of managing who had access to what. You consistently monitor the consultant’s access, ensuring compliance with security policies. You make sure all guests have their access set to expire automatically at the end of the project duration by maintaining these details in access package lifecycle settings . With automated review process the system sent out review requests to managers and resource owners. They could approve or deny access with just a few clicks. This not only saved time but also reduced the risk of human error.  
 
You  also uses the dashboard to monitor and clean up any inactive accounts. By regularly conducting access reviews and utilizing the inactive guest user dashboard, he ensures that only active and necessary guest users retain access to the company’s resources. This helps maintain security, reduce risks, and streamline user management. 
 
As the months passed, Contoso saw a significant improvement in their security posture. Unauthorized access incidents dropped, and compliance audits became a breeze. The detailed reports generated by Entra Access Reviews provided clear insights into access patterns and potential risks. For more information see:
 - [Creating an access package](../entitlement-management-access-package-create.md)
 - [Monitor and clean up stale guest accounts using access reviews](../../identity/users/clean-up-stale-guest-accounts.md)
 - [Change lifecycle settings for an access package in entitlement management](../entitlement-management-access-package-lifecycle-policy.md)
 - [Manage user and guest user access with access reviews](../manage-access-review.md)

::: zone-end  


::: zone pivot="identity-governance-guest-offboard"  

## Offboarding: Seamlessly secure your environment by efficiently offboarding guest users.   
Offboarding of guest users is a critical aspect of identity and access management, helping to maintain security, compliance, and operational efficiency within your organization.  Offboarding for guest accounts can be broken down in to 2 main parts when considering developing a process.  These are:

1.  Develop an offboarding process to get guests out of your systems. 
2.  Perform reviews to ensure that guest accounts no longer have access. 

### Develop an offboarding process

In Entitlement Management, an access package can have multiple policies, and each policy establishes how users get an assignment to the access package, and for how long.  You can establish a policy for automatic assignments that Entitlement Management follows to create and remove assignments automatically.  In order to accomplish this, it's imperative to have auto-access management start the offboarding process automatically when an access package expires.  

When an access package expires, the offboarding process should include the following:

- access to all resources associated with the expired package are revoked
- user is removed from any group that they're a member of
- account is removed from the guest user directory
- regularly check the status of access packages for guest users in the Microsoft Entra admin portal
- regularly conduct access reviews to ensure all guests status 
- use audit logs for compliance
- notifications are sent confirming successful offboarding

For more information, see [Manage user and guest user access with access reviews](../manage-access-review.md) and 
[Automate employee offboarding tasks after their last day of work with the Microsoft Entra admin center](../tutorial-scheduled-leaver-portal.md)

### Perform reviews to ensure guests no longer have access
In most organizations, end-users initiate the process of inviting business partners and vendors for collaboration. The need to collaborate drives organizations to provide resource owners and end users with a way to evaluate and attest external users regularly. Often the process of onboarding new collaboration partners is planned and accounted for, but with many collaborations not having a clear end date, it isn't always obvious when a user no longer needs access. 

Organizations need to balance, enabling collaboration and meeting security and governance requirements. Part of these efforts should include evaluating and cleaning out external users when they are no longer needed.  For more information, see [Use Microsoft Entra ID Governance to review and remove external users who no longer have resource access](../access-reviews-external-users.md)

With access reviews, you can easily ensure that users or guests have appropriate access. You can ask the users themselves or a decision maker to participate in an access review and recertify (or attest) to users' access.  When an access review is finished, you can then make changes and remove access from users who no longer need it.  For more information, see [Manage user and guest user access with access reviews](../manage-access-review.md)

### Example - Offboarding guest accounts
John is a guest whose access package has expired.  The system then revokes John's access to all resources linked to that package. John is removed from any group that he's a part of. Once his last active package expires, John's account is removed from the guest user directory. 

When the access package has expired and the above actions are taken, you also review John's status in the Microsoft Entra admin portal. During your next access review, you verify users such as John, whose packages have expired since the last review. 

You use detailed audit logs capture every step, providing a clear trail for compliance and notifications are sent to stakeholders, confirming the successful offboarding!

For more information, see [Manage user and guest user access with access reviews](../manage-access-review.md) and 
[Automate employee offboarding tasks after their last day of work with the Microsoft Entra admin center](../tutorial-scheduled-leaver-portal.md)

::: zone-end  




