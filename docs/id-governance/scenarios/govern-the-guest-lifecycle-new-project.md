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

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua

:::zone pivot="identity-governance-guest-onboard"

## Identify current lifecycle and governance processes for external identities 
Identify your current lifecycle and governance processes for external identities.  This exercise will help you to determine applicable scenarios, feasibility and scope.  

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

::: zone pivot="identity-governance-guest-assign"  

## Onboarding of Bsuiness Guests: Develop a comprehensive onboarding process for business guests 

### Inviting a user using Entitlement Management:
As an IT admin, you have identified a project that requires onboarding external consultants from Fabrikam to collaborate. It is important to have automated access management, approval workflows, and lifecycle management.
Using Microsoft Entra’s Entitlement Management, you create an access package that allows you to bundle multiple resources (like groups, applications, and SharePoint sites), include approval workflows ensuring that access requests are reviewed and approved by the appropriate individuals before access is granted and set time period for the access. You send out the invitations to the consultants, who receive emails with links to accept the access package. John, one of the consultants, follows the link, verifies his identity, and gains access to the necessary resources within minutes. The onboarding process is smooth and secure, allowing the consultants to start collaborating immediately. The project kicks off without delays, ensuring a productive partnership between Contoso and Fabrikam. 

:::image type="content" source="media/external-guest-new/invite-user-1.png" alt-text="Conceputal drawing of invite using entitlement management." lightbox="media/external-guest-new/invite-user-1.png":::

For more information, see [Configure an automatic assignment policy for an access package in entitlement management](../entitlement-management-access-package-auto-assignment-policy.md)

### Inviting guest users using B2B Invitation collab:  
For another design project, the design team manager asked you as the IT admin to add John Doe from Global Solutions to collaborate. The primary goal is to invite the user to join your directory and collaborate. You invite external user John as a guest user by simply using his email. The email invite is simple and flexible and allows you to invite users from various domains and identity providers, including social identities like Gmail or Microsoft accounts. 
John use his own credentials to sign in securely eliminating the need for password maintenance or account lifecycle management that simplifies the onboarding process.  

:::image type="content" source="media/external-guest-new/invite-user-2.png" alt-text="Conceputal drawing of invite using B2B." lightbox="media/external-guest-new/invite-user-2.png":::

For more information, see [Add B2B collaboration users in the Microsoft Entra admin center](../../external-id/add-users-administrator.md)

### Self-service sign up:  
You are the IT admin and have an additional requirement to onboard 25 freelance developers for a new project. You send an email with a sign-up link to all of them by customizing the look and feel of the sign-up process. By clicking on the link, they all enter the required details and complete the registration process without requiring manual intervention from your IT team. Upon completion, they all automatically gains access to the essential resources and applications according to predefined policies.  
By automating the sign-up process, you free up your IT team resources to focus on more strategic tasks. This efficiency can lead to cost savings and improved productivity.

For more information, see [Workforce Tenant Overview](../../external-id/what-is-b2b.md#allow-self-service-sign-up)

:::image type="content" source="media/external-guest-new/invite-user-3.png" alt-text="Conceputal drawing of invite using self-service sign up." lightbox="media/external-guest-new/invite-user-3.png":::

### Bulk Invite: 

In another instance, you receive an urgent request from the HR department. They need to send out bulk invitations to onboard 150 contractors that need to go through a mandatory training session on cybersecurity as they onboard. You quickly gather the necessary details: a list of all contractors , their email addresses, and the training session details – what access is needed. Using the bulk email invitation feature, you download the template available and import the email list. You set the email to be sent out at 9:00 AM the following day, giving employees ample time to prepare for the training session. That way all the new trainees are securely and successfully onboarded! 

For more information, see [Bulk invite guest users for B2B collaboration tutorial](../../external-id/tutorial-bulk-invite.md#invite-guest-users-in-bulk) 

::: zone-end  

::: zone pivot="identity-governance-guest-custom"  
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
::: zone-end  

::: zone pivot="identity-governance-guest-convert"  
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
::: zone-end  

::: zone pivot="identity-governance-guest-access"  
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
::: zone-end  

::: zone pivot="identity-governance-guest-close"  
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
::: zone-end  




