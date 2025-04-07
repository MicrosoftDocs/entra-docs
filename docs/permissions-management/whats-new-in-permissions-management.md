---
title: What's new in Microsoft Entra Permissions Management
description: View the latest public preview and general availability of features in Permissions Management.
author: jenniferf-skc
manager: femila
ms.service: entra-permissions-management

ms.topic: whats-new
ms.date: 04/01/2025
ms.author: jfields
---

# What's new in Microsoft Entra Permissions Management

> [!NOTE]
> Effective April 1, 2025, Microsoft Entra Permissions Management will no longer be available for purchase, and on October 1, 2025, we'll retire and discontinue support of this product. More information can be found [here](https://aka.ms/MEPMretire).

This article provides the latest Public Preview and General Availability information of features in Microsoft Entra Permissions Management. 

## May 2024

### General availability - Microsoft Entra Permissions Management integration for Microsoft Defender for Cloud
**Type:** Changed feature   
**Service category:**                      
**Product capability:** Permissions Management  

Deploying applications and infrastructure across multiple clouds has become the norm. Ensuring the security of cloud applications and infrastructure requires integrating identity and permission insights into the overall security strategy. This objective is achieved through the integration of Microsoft Entra Permissions Management with Microsoft Defender for Cloud. 

Permissions Management capabilities are available to integrate into the Defender for Cloud CSPM plan. Adding the capabilities of [Permissions Management to Defender for Cloud](permissions-management-for-defender-for-cloud.md) strengthens the prevention of security breaches that might occur due to excessive permissions or misconfigurations in the cloud environment. By continuously monitoring and managing cloud entitlements, Permissions Management helps to reduce the attack surface, detect potential threats, and maintain compliance with regulatory standards. These added features make Permissions Management an essential tool to integrate into the capabilities of Defender for Cloud for securing cloud-native applications and protecting sensitive data in the cloud. 

For instructions on how to enable Permissions Management in your Defender for Cloud environment, see [Enable Permissions Management in Microsoft Defender for Cloud](https://go.microsoft.com/fwlink/?linkid=2252561)


### General availability - Support for PIM-enabled Groups 
**Type:** Changed feature   
**Service category:**                      
**Product capability:** Permissions Management  

Privileged Identity Management (PIM) for Groups in Microsoft Entra ID allows Permissions Management admins to grant users just-in-time membership and ownership of a security group or a Microsoft 365 group. Nested groups are also supported. For example, if a user is an active member of Group A, and Group A is an eligible member of Group B, the user can activate their membership in Group B. PIM provides a powerful mechanism to manage access and enhance security by granting just-in-time access to critical resources. 

Microsoft Entra Permissions Management adds the support to read the just-in-time membership along with existing support for direct group membership. It also solves the challenge of having visibility into who has access to what resource with eligible and direct role assignments. This feature enables the complete visibility into RBAC permissions assigned to the identities in different ways and the potential impact on Permissions Creep Index (PCI). A complete list of RBAC role assignments is provisioned directly, via the group membership or by an eligible group member, and can be seen per identity under the Analytics tab. 

## March 2024

### Public Preview - Support for PIM-enabled Groups 
**Type:** Changed feature   
**Service category:**                      
**Product capability:** Permissions Management  

As multiple customers embrace PIM for groups as a popular feature, Microsoft Entra Permissions Management adds the support to read the just-in-time membership impact on the eligible granted Azure RBAC permissions and Permissions Creep Index (PCI). The feature enables the complete visibility into RBAC permissions assigned to the identities in different ways.  
 
In the Permissions Management console, admins can see the membership eligibility status as well as role eligibility status for Groups. For each identity, admins can get the visibility into the membership eligibility status as well as roles eligibility status. 


## December 2023

### General availability - Permissions Analytics Report PDF

**Type:** Changed feature   
**Service category:**                      
**Product capability:** Permissions Management  

The [Permissions Analytics Report (PAR)](product-permissions-analytics-reports.md) lists findings relating to permissions risks across identities and resources in Permissions Management. The PAR is an integral part of the risk assessment process where customers discover areas of highest risk in their cloud infrastructure. This report can be directly viewed in the Permissions Management UI, downloaded in Excel (XSLX) format, and exported as a PDF. The report is available for all supported cloud environments: Amazon Web Services (AWS), Microsoft Azure, and Google Cloud Platform (GCP). 

The PAR PDF is one part of the overall reporting redesign effort led by the engineering team. As part of this feature release, customers can download all reports (system or custom) with no row limitations in CSV and XSLX formats. 


## October 2023

### Public preview - Permissions Analytics Report PDF for multiple authorization systems

**Type:** Changed feature   
**Service category:**                        
**Product capability:** Permissions Management            

The Permissions Analytics Report (PAR) lists findings relating to permissions risks across identities and resources in Permissions Management. The PAR is an integral part of the risk assessment process where customers discover areas of highest risk in their cloud infrastructure. This report can be directly viewed in the Permissions Management UI, downloaded in Excel (XSLX) format, and exported as a PDF. The report is available for all supported cloud environments: Amazon Web Services (AWS), Microsoft Azure, and Google Cloud Platform (GCP).  

The PAR PDF has a new design to enhance usability, align with the product UX redesign effort, and address various customer feature requests. [You can download the PAR PDF for up to 10 authorization systems](product-permissions-analytics-reports.md).

### General availability - ServiceNow app for Permissions Management

**Type:** New feature   
**Service category:**                        
**Product capability:** Permissions Management

The ServiceNow Application for Microsoft Entra Permissions Management enables users to request time-bound, on-demand permissions for multicloud environments (Azure, AWS, GCP) through the ServiceNow portal. This integration aids organizations in enhancing their Zero Trust posture by enforcing the principle of least privilege for multicloud permissions. The ServiceNow app streamlines access permission requests within existing approval workflows.  

Get the ServiceNow app in the [ServiceNow app store](https://store.servicenow.com/sn_appstore_store.do#!/store/application/24073ae31bfca9100e564082b24bcb56/1.0.1?referer=%2Fstore%2Fsearch%3Flistingtype%3Dallintegrations%25253Bancillary_app%25253Bcertified_apps%25253Bcontent%25253Bindustry_solution%25253Boem%25253Butility%25253Btemplate%25253Bgenerative_ai%25253Bsnow_solution%26q%3Dentra%2520permissions%2520management&sl=sh). 

### Public preview - Okta and AWS Identity Center identity provider integrations

**Type:** New feature   
**Service category:**                        
**Product capability:** Permissions Management

Permissions Management supports third party identity providers (IdP) integration to get more insight of single sign-on data of permissions assigned in cloud environments. With this information, Permissions Management can provide more accurate analytics. By reading role assignments and user data from the IdP side, Permissions Management more effectively calculates permissions granted, and as a result, reads more precise data on permissions creep. 

For [Okta Identity Provider integration](how-to-configure-okta-as-an-identity-provider.md), an admin needs to configure the API application to give the access to read Okta users, groups, and apps via Okta APIs. Permissions Management reads Okta users, groups, and apps via Okta APIs. 

For [AWS Identity and Access Management (IAM) Identity Center integration](how-to-configure-aws-iam.md), an admin can provide Permissions Management access to read user and role access configuration data from the management account by running the CloudFormation template (CFT) in their AWS environment. After successful configuration, Permissions Management can read the data to calculate the analytics.

