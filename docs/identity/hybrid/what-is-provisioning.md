---
title: 'What is identity provisioning with Microsoft Entra ID?'
description: Describes overview of identity provisioning.

author: billmath
manager: amycolannino
ms.service: entra-id
ms.topic: overview
ms.date: 11/06/2023
ms.subservice: hybrid
ms.author: billmath

---

# What is identity provisioning?

Today, businesses and corporations are using a mixture of on-premises and cloud applications, with users requiring access to  applications in both spaces. An increasing need to have a single identity across these various applications (on-premises and cloud) stirs the "Provisioning" topic.

Provisioning is the process of creating an object based on certain conditions, keeping the object up to date, and deleting the object when conditions are no longer met. For context, an "object" can be a user, device, or service in on-premises and cloud environments. 

For example, when a new user joins an organization, that user's profile is entered into the HR system. At that point, Provisioning can create a corresponding user account in the cloud, in Active Directory, and different applications that the user needs access to. This allows the user to start work and have access to the applications and systems they need on day one. (Note: The HR department or Organizational Unit must be setup to have access to these applications and systems for the new user to inherit these permissions)

![Diagram that shows cloud provisioning with Microsoft Entra ID.](media/what-is-provisioning/cloud-1.png)

With regard to Microsoft Entra ID, provisioning can be broken down in to the following key scenarios.  

- **[HR-driven provisioning](#hr-driven-provisioning)**  
- **[App provisioning](#app-provisioning)**  
- **[Directory provisioning](#directory-provisioning)** 

## HR-driven provisioning

![Diagram that shows HR-driven provisioning with Cloud HR, On-premises HR, and Microsoft Entra ID.](media/what-is-provisioning/cloud-2.png)

Provisioning from HR to the cloud involves the creation of objects (users, roles, groups, and so on) based on the information that is in the organization's HR system.  

A common scenario would be, when a new employee joins a company, they're entered into the HR system. Afterwards, they're provisioned to the cloud. In this case, Microsoft Entra ID (Note: formerly known as Azure Active Directory (AAD)). Provisioning from HR can cover the following scenarios. 

- **Hiring new employees** - When a new employee is added to cloud HR, a user account is automatically created in Active Directory, Microsoft Entra ID, and optionally Microsoft 365 and other SaaS applications supported by Microsoft Entra ID, with write-back of the email address to Cloud HR.
- **Employee attribute and profile updates** - When an employee record is updated in cloud HR (such as their name, title, or manager), their user account will be automatically updated in Active Directory, Microsoft Entra ID, and optionally Microsoft 365 and other SaaS applications supported by Microsoft Entra ID.
- **Employee terminations** - When an employee is terminated in cloud HR, their user account is automatically disabled in Active Directory, Microsoft Entra ID, and optionally Office 365 and other SaaS applications supported by Microsoft Entra ID.
- **Employee rehires** - When an employee is rehired in cloud HR, their old account can be automatically reactivated or re-provisioned (depending on your preference) to Active Directory, Microsoft Entra ID, and optionally Microsoft 365 and other SaaS applications supported by Microsoft Entra ID.


## App provisioning

![Diagram that shows App provisioning with On-premises apps, Non-Microsoft cloud apps, and Microsoft Entra ID.](media/what-is-provisioning/cloud-3.png)

In Microsoft Entra ID, the term **[app provisioning](~/identity/app-provisioning/user-provisioning.md)** refers to automatically creating user identities and roles in the cloud applications that users need access to. In addition to creating user identities, automatic provisioning includes the maintenance and removal of user identities as status or roles change. Common scenarios include provisioning a Microsoft Entra user into applications like [Dropbox](~/identity/saas-apps/dropboxforbusiness-provisioning-tutorial.md), [Salesforce](~/identity/saas-apps/salesforce-provisioning-tutorial.md), [ServiceNow](~/identity/saas-apps/servicenow-provisioning-tutorial.md), and more.

## Directory provisioning

![cloud provisioning](media/what-is-provisioning/cloud-4.png)

On-premises provisioning involves provisioning from on-premises sources (like Active Directory) to Microsoft Entra ID.  

The most common scenario would be, when a user in Active Directory (AD) is provisioned into Microsoft Entra ID.

This has been accomplished by Microsoft Entra Connect Sync, Microsoft Entra Connect cloud provisioning and Microsoft Identity Manager. 
 
## Next steps 

- [What is Microsoft Entra Cloud Sync?](cloud-sync/what-is-cloud-sync.md)
- [Install cloud provisioning](cloud-sync/how-to-install.md)
