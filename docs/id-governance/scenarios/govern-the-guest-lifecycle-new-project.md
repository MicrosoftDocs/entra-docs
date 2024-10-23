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

:::image type="content" source="media/external-guest-new/govern-access.png" alt-text="Conceputal drawing of governing access to your resources." lightbox="media/external-guest-new/govern-access.png":::

Understanding these scenarios helps in designing appropriate access controls and ensuring smooth collaboration with external individuals.  Some examples of guest scenarios include:

 - If you’re an organization or a developer creating consumer apps, and you need add authentication and customer identity and access management (CIAM) to your application to allow extrnal guests access.  For more information, see [External ID overview](../../external-id/external-identities-overview.md)

 - If you want to enable your employees to collaborate with business partners and guests and allow secure access through invitation or self-service sign-up. Determine the level of access guests have to the Microsoft Entra tenant that contains your employees and organizational resources, which is a tenant in a workforce configuration.  For more information, see[https://learn.microsoft.com/en-us/entra/external-id/what-is-b2b](../../external-id/what-is-b2b.md)

## License Requirements 

Using some of the below features mentioned requires Microsoft Entra ID Governance or Microsoft Entra Suite licenses. To find the right license for your requirements, see [Microsoft Entra ID Governance licensing fundamentals](../licensing-fundamentals.md)

:::zone-end

:::zone pivot="identity-governance-guest-secure"


## Security posture: Determine your security posture for guest access

As you consider the governance of external access, assess your organization's security and collaboration needs, by scenario. You can start with the level of control the IT team has over the day-to-day collaboration of end users. Organizations in highly regulated industries might require more IT team control. For example, defense contractors can have a requirement to positively identify and document external users, their access, and access removal: all access, scenario-based, or workloads. Consulting agencies can use certain features to allow end users to determine the external users they collaborate with.

  ![Bar graph of the span from full IT team control, to end-user self service.](../../architecture/media/secure-external-access/1-overall-control.png)

   > [!NOTE]
   > A high degree of control over collaboration can lead to higher IT budgets, reduced productivity, and delayed business outcomes. When official collaboration channels are perceived as onerous, end users tend to evade official channels. An example is end users sending unsecured documents by email.

You should start with reviewing the documentation for [Secure external Collaboration](../../architecture/1-secure-access-posture.md).  Reviewing this documentation will allow you to devise and create a security plan that can be used with your guest scenarios.

:::zone-end

















:::zone pivot="identity-governance-guest-discover"

## Discovery: Identify current lifecycle and governance processes for external identities 
Identify your current lifecycle and governance processes for external identities.  This exercise will help you to determine applicable scenarios, feasibility and scope.  

Review the [Govern the employee and guest lifecycle with Microsoft Entra ID Governance](govern-the-employee-lifecycle.md) with emphasis on external identities.  The processes covered here are also needed for guest users, suppliers and other guests, to enable them to collaborate or have access to resources. This document covers actions you can take to discover your governance processes.

### Example discovery
Consider you are the IT admin at a bustling tech company, Contoso, and often face the challenge of efficiently and securely onboarding business guests like consultants, vendors, and partners. The current onboarding process is fragmented and inconsistent, leading to security vulnerabilities and inefficiencies. To tackle this, you embark on a discovery phase to identify key requirements and understand how you could leverage Microsoft Entra.

Some of your key requirements include,  

 - Diverse guest onboarding needs with different departments requiring unique levels of access.  
 - Ensuring that guest users have the least privilege necessary to perform their tasks is critical and needs robust conditional access policies and multi-factor authentication to protect sensitive data. 
 - Seamless and use friendly onboarding process for both you as an IT admin, and your business guests. Guests should be able to quickly and easily access the resources they require without unnecessary delays.  
 - Integration with existing collaboration tools like Microsoft Teams and SharePoint, along with the option for Self-Service Sign-Up (SSSU) 
 - Capability to govern guest by regularly monitoring guest user activity, set an expiration on access and periodic access reviews ensure that guest access remains appropriate over time. 

With these key requirements in mind, here are two things to consider:
 - onboarding the guest to the tenant
 - getting the guest access to resources

There are different options depending on the business case. Let’s deep dive into onboarding of the guests and the options that are available.

:::zone-end

::: zone pivot="identity-governance-guest-onboard"  

## Onboarding of Business Guests: Develop a comprehensive onboarding process for business guests 
Onboarding, with regard to guest or external identities, is the process or processes of getting these identities setup in your organizations systems.  Depending on the systems they will be added to or allowed to access, these processes may differ.

Onboarding guest identities can be done in several ways.

[Entitlement Management](#example---inviting-a-user-using-entitlement-management) - External user onboarding processes often involve collecting information about the users to guide decisions about whether to grant access, or how to set up their account properly for the apps and resources they use. Collecting information about the users to guide decisions about: 
 
 - whether to grant access 
 - how to set up their account properly for the apps and resources they use.

 This process could include determining their role in their organization, so the approver knows whether the team is right for them. 
 You could need to set the location attribute for external users.  Using Entitlement management’s features automatically provide your approvers and apps with the information they need.  

[B2B collaboration](#example---inviting-guest-users-using-b2b-invitation-collab) - External collaboration settings let you specify what roles in your organization can invite external users for B2B collaboration. These settings also include options for allowing or blocking specific domains, and options for restricting what external guest users can see in your Microsoft Entra directory. 

[Self-Service sign up](#example---self-service-sign-up) - With a self-service sign-up user flow, you can create a sign-up experience for guests who want to access your apps. As part of the sign-up flow, you can provide options for different social or enterprise identity providers, and collect information about the user. 

[Bulk invite](#example---bulk-invite) - If you use Microsoft Entra B2B collaboration to work with external partners, you can invite multiple guest users to your organization at the same time.
 
The sections below provide examples of various ways that you can onboard guest users

### Example - Inviting a user using Entitlement Management:
As an IT admin, you have identified a project that requires onboarding external consultants from Fabrikam to collaborate. It is important to have automated access management, approval workflows, and lifecycle management.
Using Microsoft Entra’s Entitlement Management, you create an access package that allows you to bundle multiple resources (like groups, applications, and SharePoint sites), include approval workflows ensuring that access requests are reviewed and approved by the appropriate individuals before access is granted and set time period for the access. 

You send out the invitations to the consultants, who receive emails with links to accept the access package. John, one of the consultants, follows the link, verifies his identity, and gains access to the necessary resources within minutes. The onboarding process is smooth and secure, allowing the consultants to start collaborating immediately. The project kicks off without delays, ensuring a productive partnership between Contoso and Fabrikam. 

:::image type="content" source="media/external-guest-new/invite-user-1.png" alt-text="Conceputal drawing of invite using entitlement management." lightbox="media/external-guest-new/invite-user-1.png":::

For more information, see [Onboard external users with entitlement management](../entitlement-management-onboard.md) and [Configure an automatic assignment policy for an access package in entitlement management](../entitlement-management-access-package-auto-assignment-policy.md).  

For additional examples see [Tutorial - Onboard external users to Microsoft Entra ID through an approval process](../entitlement-management-onboard-external-user.md) and [Microsoft Entra deployment scenario - Workforce and guest onboarding, identity, and access lifecycle governance across all your apps](https://learn.microsoft.com/en-us/entra/architecture/deployment-scenario-workforce-guest)


### Example - Inviting guest users using B2B Invitation collab:  
For another design project, the design team manager asked you as the IT admin to add John Doe from Global Solutions to collaborate. The primary goal is to invite the user to join your directory and collaborate. You invite external user John as a guest user by simply using his email. The email invite is simple and flexible and allows you to invite users from various domains and identity providers, including social identities like Gmail or Microsoft accounts. 
John use his own credentials to sign in securely eliminating the need for password maintenance or account lifecycle management that simplifies the onboarding process.  

:::image type="content" source="media/external-guest-new/invite-user-2.png" alt-text="Conceputal drawing of invite using B2B." lightbox="media/external-guest-new/invite-user-2.png":::

For more information, see [Add B2B collaboration users in the Microsoft Entra admin center](../../external-id/add-users-administrator.md) and [Configure external collaboration settings](../external-id/external-collaboration-settings-configure.md)

### Example - Self-service sign up:  
You are the IT admin and have an additional requirement to onboard 25 freelance developers for a new project. You send an email with a sign-up link to all of them by customizing the look and feel of the sign-up process. By clicking on the link, they all enter the required details and complete the registration process without requiring manual intervention from your IT team. Upon completion, they all automatically gains access to the essential resources and applications according to predefined policies.  
By automating the sign-up process, you free up your IT team resources to focus on more strategic tasks. This efficiency can lead to cost savings and improved productivity.

For more information, see [Workforce Tenant Overview](../../external-id/what-is-b2b.md#allow-self-service-sign-up)

:::image type="content" source="media/external-guest-new/invite-user-3.png" alt-text="Conceputal drawing of invite using self-service sign up." lightbox="media/external-guest-new/invite-user-3.png":::

### Example - Bulk Invite: 
In another instance, you receive an urgent request from the HR department. They need to send out bulk invitations to onboard 150 contractors that need to go through a mandatory training session on cybersecurity as they onboard. You quickly gather the necessary details: a list of all contractors , their email addresses, and the training session details – what access is needed. Using the bulk email invitation feature, you download the template available and import the email list. You set the email to be sent out at 9:00 AM the following day, giving employees ample time to prepare for the training session. That way all the new trainees are securely and successfully onboarded! 

For more information, see [Bulk invite guest users for B2B collaboration tutorial](../../external-id/tutorial-bulk-invite.md#invite-guest-users-in-bulk) 


::: zone-end  

::: zone pivot="identity-governance-guest-redemption"  

## Redemption in B2B collaboration: Enable guest users to securely access an organization’s resources by accepting an invitation  

 

### Invitation Email: 
John, a guest user, receives an email invitation from Contoso to access their internal portal. He clicks on the link provided in the email, which takes him to the Contoso’s sign-in page. Here, John is presented with the company’s privacy terms and conditions, which he reads through and accepts. He then signs-in using his existing email account. With the sign-in process complete, John is granted access to the Contoso portal, where he can now seamlessly collaborate with internal users. 

### Direct Link: 
In another instance, Jane, another guest user, receives a direct link to the Contoso Ltd. application from her contact at the company. She clicks on the link, which directs her to the sign-in page. Jane reviews and accepts the privacy terms and conditions before signing in with her existing email account. Once authenticated, she gains access to the application and can start working with her Contoso Ltd. colleagues. 

### Common endpoint URL: 
Meanwhile, Alex, a guest user, navigates to the common endpoint URL, myapps.microsoft.com. He selects the option to sign-in to an organization and enters the domain name of Contoso Ltd. After reviewing and accepting the privacy terms and conditions, Alex signs in using his existing email account. Successfully authenticated, Alex can now access the resources provided by Contoso Ltd., ready to collaborate and contribute. 


::: zone-end  

::: zone pivot="identity-governance-guest-monitor"  

## Monitor and iterate additional resources via direct assignment 

Now you as an IT administrator have a requirement to bypass access requests and directly assign specific users to an access package, granting the external team instant access. you'll create the first access package assignment policy in the access package. You review the access package’s policies to confirm that it permits external users to be added directly. 

With everything in place, Emma moved to the assignments tab. She entered the email addresses of the external team members, ensuring they were correctly listed. After a final review, she clicked the “Assign” button. 

Almost immediately, the external partners received their invitations. They joined the directory seamlessly and gained access to the necessary resources without any delays. This efficient setup allowed both teams to start their collaborative work right away, fostering a productive and innovative environment. 

::: zone-end  

::: zone pivot="identity-governance-guest-cleanup"  

## Monitor and Cleanup: Ensure compliance and security by monitoring and cleaning up accounts 
 

 As the company grew, so did the complexity of managing who had access to what. You consistently monitor the consultant’s access, ensuring compliance with security policies. You make sure all guests have their access set to expire automatically at the end of the project duration by maintaining these details in access package lifecycle settings . With automated review process the system sent out review requests to managers and resource owners. They could approve or deny access with just a few clicks. This not only saved time but also reduced the risk of human error.  
 
You  also uses the dashboard to monitor and clean up any inactive accounts. By regularly conducting access reviews and utilizing the inactive guest user dashboard, he ensures that only active and necessary guest users retain access to the company’s resources. This helps maintain security, reduce risks, and streamline user management. 
 
As the months passed, Contoso saw a significant improvement in their security posture. Unauthorized access incidents dropped, and compliance audits became a breeze. The detailed reports generated by Entra Access Reviews provided clear insights into access patterns and potential risks. 

::: zone-end  

::: zone pivot="identity-governance-guest-offboard"  

## Offboarding: Seamlessly secure your environment by efficiently offboarding guest users.   
Offboard refers to the 



In Entitlement Management, an access package can have multiple policies, and each policy establishes how users get an assignment to the access package, and for how long.  You can establish a policy for automatic assignments that Entitlement Management follows to create and remove assignments automatically.

Offboarding of guest users is a critical aspect of identity and access management, helping to maintain security, compliance, and operational efficiency within your organization.

In order to accomplish this, it is imperative to have auto-access management start the offboarding process automatically when an access package expires.  

When an access package expires, the offboarding process should include the following:

- access to all resources associated with the expired package are revoked
- user is removed from any group that they are a member of
- account is removed from the guest user directory
- regularly check the status of access packages for guest users in the Microsoft Entra admin portal
- regularly conduct access reviews to ensure all guests status 
- use audit logs for compliance
- notifications are sent confirming successful offboarding

### Example
John is a guest whose access package has expired.  The system then revokes John's access to all resources linked to that package. John is removed from any group that he is a part of. Once his last active package expires, John's account is removed from the guest user directory. 

When the access package has expired and the above actions are taken, you also review John's status in the Microsoft Entra admin portal. During your next access review, you verify users such as John, whose packages have expired since the last review. 

You use detailed audit logs capture every step, providing a clear trail for compliance and notifications are sent to stakeholders, confirming the successful offboarding!

::: zone-end  




