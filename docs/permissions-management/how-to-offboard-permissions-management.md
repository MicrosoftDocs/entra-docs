---
title: Microsoft Entra Permissions Management offboarding guidance
description: How to transition off of Microsoft Entra Permissions Management for the anticipated product deprecation.
author: jenniferf-skc
manager: femila
ms.service: entra-permissions-management

ms.topic: how-to
ms.date: 04/03/2025
ms.author: jfields
---

# How to offboard and transition off of Microsoft Entra Permissions Management 

> [!NOTE]
> Effective April 1, 2025, Microsoft Entra Permissions Management will no longer be available for purchase, and on October 1, 2025, we'll retire and discontinue support of this product. More information can be found [here](https://aka.ms/MEPMretire). 

Microsoft Entra Permissions Management (Permissions Management) is retiring on October 01, 2025, with new purchases unavailable starting April 1, 2025. Existing paid customers will continue to have access to Permissions Management between April 1, 2025 - September 30, 2025. 

On October 01, 2025, Permissions Management will be automatically offboarded and associated data collection will be deleted. For customers needing to offboard before October 1, 2025, refer to the [Offboarding steps](#offboarding-steps) section in this guide. 

## Why is Permissions Management being retired? 

The decision to phase out Microsoft Entra Permissions Management from the Microsoft Security portfolio was made after deep consideration of our innovation portfolio and how we can focus on delivering the best innovations aligned to our differentiating areas and partners with the ecosystem on adjacencies. We remain committed to delivering top-tier solutions across the Microsoft Entra portfolio, which includes Microsoft Entra ID, Microsoft Entra Suite (encompassing ID Protection, ID Governance, Verified ID, Internet Access, and Private Access), Microsoft Entra External ID, Microsoft Entra Workload ID, and more.


## Recommended solutions

Since Permissions Management is retiring, Microsoft recommends that customers who have onboarded the product in their environment start planning for transition. Customers who are not onboarded should refrain from onboarding.   

To support this transition, Microsoft is partnering with [Delinea](https://delinea.com/). Delinea offers a cloud-native, fully Microsoft-compatible Cloud Infrastructure Entitlement Management (CIEM) solution, Privilege Control for Cloud Entitlements (PCCE). PCCE provides functionality comparable to Permissions Management, including continuous discovery of entitlements that allow you to monitor and adjust access rights for both human and machine identities.  

We recommend beginning the shift away from Permissions Management as soon as possible, well before September 30th. We're committed to providing extensive support, alongside our partner, Delinea.  


## Recommended steps before migrating to Delinea

To ensure you continue with the CIEM objectives with our recommended partner, we recommend making a note of the following information from your Permissions Management portal: 

- First, go to [Microsoft Entra admin center](https://entra.microsoft.com/) and sign in to [Microsoft Entra ID](https://portal.azure.com/#blade/Microsoft_AAD_IAM/ActiveDirectoryMenuBlade/Overview), then click **Permissions Management** from the navigation blade. 

    - Authorization system IDs which are being monitored across Azure, Amazon Web Service (AWS) and Google Cloud Platform (GCP). To find this, launch the **Permissions Management** portal, select **Settings (Gear icon)** and select the **Authorization Systems** tab to view list of Authorization system IDs.  
    - Groups and users given admin access with the Permissions Management Administrator role in Entra ID. To find this, launch **Entra ID**, select **Roles and Admins**, search for **Permissions Management Administrator role**, select **Assignments**. 
    - Authorization system-specific access provided to groups through the Permissions Management portal. To find this, launch **Permissions Management** portal, Select **User Management**, then click the **Groups** tab to view all group assignments.  
    - Custom reports configured in your environment. To find this, launch the **Permissions Management** portal, select **Reports**, navigate to **Custom Reports**.
    - Alerts configured in your environment. To find this, launch the **Permissions Management** portal, select **Alerts** (bell icon), navigate to respective alerts tab.

## Offboarding steps

Once onboarded to our recommended partner and/or any other vendor, customers can initiate offboarding. Follow these steps in order:  

1. Remove permissions assigned in AWS, Azure, and GCP.
1. Remove the OIDC application for AWS and GCP environments.
1. Stop collecting data for your entire list of accounts / subscriptions/ projects by deleting the associated data collectors: This ensures no new data is collected and you'll no longer have access to any historic data.
1. Disable user sign-in to Cloud Infrastructure Entitlement Management (CIEM) enterprise application   

 Continue for detailed guidelines for each of these steps.

## Remove permissions assigned in AWS, Azure, and GCP

For successful offboarding of your data, remove permissions from your onboarded cloud provider (Azure, AWS, or GCP) and Permissions Management. Any roles and permissions assigned during onboarding should be removed. This ensures your environment is secure with no overprivileged access once your environment is offboarded from Permissions Management. 

Refer to the Data Collector configuration from the Permissions Management portal and select the settings (gear icon). Note down the configuration settings to remove roles and permissions assigned in your respective cloud provider.  

## Remove the OIDC application for AWS and GCP environments

For AWS and GCP, delete the application created in the Microsoft Entra Admin Center tenant where Permissions Management is enabled. This app was used to set up an OIDC (OpenID Connect) connection to your AWS and GCP environments.   

To find the Enterprise Application created which was used to set up OIDC connection to your AWS and GCP environments, follow the below steps: 

> [!NOTE] 
> User must have the [Permissions Management Administrator](~/identity/role-based-access-control/permissions-reference.md#permissions-management-administrator) and [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator) role assignments to perform this task. 

1. Go to [Microsoft Entra admin center](https://entra.microsoft.com/) and sign in to [Microsoft Entra ID](https://portal.azure.com/#blade/Microsoft_AAD_IAM/ActiveDirectoryMenuBlade/Overview).
1. Launch the **Permissions Management** portal.
1. Select **Settings** (gear icon), then select the **Data Collectors** tab.
1. On the **Data Collectors** dashboard, select your authorization system type:
    - **AWS** for Amazon Web Services. 
    - **GCP** for Google Cloud Platform.
1. Select the ellipses **(...)** at the end of the row in the table.
1. Select **Edit Configuration**. The app is located under the **Azure App** name.
1. Go to [Microsoft Entra admin center](https://entra.microsoft.com/) and sign in to [Microsoft Entra ID](https://portal.azure.com/#blade/Microsoft_AAD_IAM/ActiveDirectoryMenuBlade/Overview).
1. Navigate to **Entra ID** > **App registrations**. 
1. Enter the name of the existing application in the search box, and then select the application from the search results.
1. From the Overview page, select **Delete**. Read the deletion consequences. Check the box if one appears at the bottom of the pane.
1. Select **Delete** to confirm that you want to delete the app. 

## Stop data collection

Stop collecting data for your list of accounts / subscriptions / projects by deleting the associated data collectors. 

> [!NOTE]
> User must have the [Permissions Management Administrator](~/identity/role-based-access-control/permissions-reference.md#permissions-management-administrator) role assignment to perform this task.

1. Go to [Microsoft Entra admin center](https://entra.microsoft.com/) and sign in to [Microsoft Entra ID](https://portal.azure.com/#blade/Microsoft_AAD_IAM/ActiveDirectoryMenuBlade/Overview).
1. Select **Permissions Management** and click on **Launch portal**. 
1. Select **Settings** (the gear icon), then select the **Data Collectors** tab. 
1. On the **Data Collectors** dashboard, select your authorization system type: 
    - **AWS** for Amazon Web Services. 
    - **Azure** for Microsoft Azure. 
    - **GCP** for Google Cloud Platform. 
1. Select the ellipses **(...)** at the end of the row in the table. 
1. Select **Delete Configuration**. The **Permissions Management Onboarding - Summary** box displays. 
1. Select **Delete**. 
1. Check your email for a one-time password (OTP) code, then enter it in **Enter OTP**. 
1. If you don't receive an OTP, select **Resend OTP**. 
1. The following message displays: ```Successfully deleted configuration```. 

## Disable user sign-in to the Cloud Infrastructure Entitlement Management (CIEM) enterprise application

Once data collection stops for all AWS accounts, Azure subscriptions, and GCP projects, disable the Cloud Infrastructure Entitlement Management (CIEM) app so that it can't be signed in. This ensures Permissions Management can no longer access your environments (accounts, subscriptions and projects).  

> [!NOTE]
> User must have the [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator) role assignment to perform this task. 

To disable the CIEM App for users to sign in: 

1. Go to [Microsoft Entra admin center](https://entra.microsoft.com/) and sign in to [Microsoft Entra ID](https://portal.azure.com/#blade/Microsoft_AAD_IAM/ActiveDirectoryMenuBlade/Overview).
1. Navigate to **Entra ID** > **Enterprise apps** > **All applications**.
1. Search for **Cloud Infrastructure Entitlement Management**. If you can’t locate the app, reset the filters.
1. Open **Properties**.
1. Toggle Enabled for users to sign-in to **No**.

## Next steps

- For more information on the Permissions Management product retirement, visit [aka.ms/MEPMretire](https://aka.ms/MEPMretire)
