---
title: Microsoft Entra Permissions Management offboarding guidance
description: How to transition off of Microsoft Entra Permissions Management for the anticipated product deprecation.
author: jenniferf-skc
manager: femila
ms.service: entra-permissions-management

ms.topic: how-to
ms.date: 04/01/2025
ms.author: jfields
---

# How to offboard and transition off of Microsoft Entra Permissions Management 

> [!NOTE]
> Effective April 1, 2025, Microsoft Entra Permissions Management will no longer be available for purchase, and on October 1, 2025, we'll retire and discontinue support of this product. More information can be found [here](https://aka.ms/MEPMretire). 

## Introduction

Microsoft Entra Permissions Management will be retired on October 01, 2025, with new purchases unavailable starting April 1, 2025. Existing paid customers will continue to have access to Permissions Management between April 1, 2025 - September 30, 2025. 

On October 01, 2025, Microsoft Entra Permissions Management will be automatically offboarded and associated data collection will be deleted. For customers needing to offboard prior to Oct 1, 2025, refer to the Offboarding Steps section in this guide. 

## Why is Microsoft Entra Permissions Management being retired? 

Microsoft has made the decision to retire Microsoft Entra Permissions Management as part of a strategic realignment to focus Microsoft's Security investments on core identity categories, leveraging AI for security and securing AI. 


## Recommended solutions

Since Microsoft Entra Permissions Management will be retired, Microsoft recommends that customers who have onboarded the product in their environment start planning for transition. Customers who haven’t onboarded the product should refrain from onboarding.   

To support this transition, Microsoft has partnered with [Delinea](https://delinea.com/). Delinea offers a cloud-native, fully Microsoft-compatible Cloud Infrastructure Entitlement Management (CIEM) solution, Privilege Control for Cloud Entitlements (PCCE), which provides functionality comparable to Microsoft Entra Permissions Management, including continuous discovery of entitlements that enable organizations to monitor and adjust access rights for both human and machine identities.  

We recommend beginning the shift away from Microsoft Entra Permissions Management as soon as possible, well before September 30th. We are committed to providing extensive support, alongside our partner, Delinea.  


## Recommended steps before migrating to Delinea

To ensure you continue with the CIEM objectives with our recommended partner, we recommend making a note of the following information from your Permissions Management portal: 

1. Authorization system IDs which are being monitored across Azure, AWS and GCP. To find this, launch **Microsoft Entra Permissions Management** portal, select **Settings (Gear icon)** and select the **Authorization Systems** tab to view list of Authorization system IDs.  
1. Groups and users given admin access with the Permissions Management Administrator role in Entra ID. To find this, launch **Entra portal**, select **Roles and Admins**, search for **Permissions Management Administrator role**, select **Assignments**. 
1. Authorization system-specific access provided to groups through the Permissions Management portal. To find this, launch **Entra Permissions Management portal**, Select **User Management**, then click the **Groups** tab to view all groups assignments.  
1. Custom reports configured in your environment. To find this, launch **Entra Permissions Management portal**, select **Reports**, navigate to **Custom Reports**.
1. Alerts configured in your environment. To find this, launch **Entra Permissions Management portal**, select **Alerts** (bell icon), navigate to respective alerts tab.

## Remove a task

1. On the Permissions Management home page, select the **Remediation** tab, and then select the **Permissions** subtab.
1. From the **Authorization System Type** dropdown, select **Azure** or **GCP**.
1. From the **Authorization System** dropdown, select the accounts you want to access.
1. From the **Search For** dropdown, select **Group**, **User**, or **APP/Service Account**, and then select **Apply**.
1. Make a selection from the results list.

1. To remove a task, select **Remove Tasks**.
1. In the **Remove Tasks** page, from the **Available Tasks** list, select the plus sign **(+)** to move the task to the **Selected Tasks** list.
1. When you have finished selecting tasks, select **Submit**.
1. When the following message displays: **Are you sure you want to change permission?**, select:
    - **Generate Script** to generate a script where you can manually add/remove the permissions you selected.
    - **Execute** to change the permission.
    - **Close** to cancel the action.

## Offboarding steps

Once onboarded to our recommended partner and/or any other vendor, customers can initiate offboarding. Please follow the below steps in the following order:  

1. Removal of permissions assigned in AWS, Azure, GCP.
1. Remove the OIDC application for AWS and GCP environments.
1. Stop collecting data for your entire list of accounts / subscriptions/ projects by deleting the associated data collectors: This will ensure no new data is collected and you will no longer have access to any historic data.
1. Disable user sign-in to Cloud Infrastructure Entitlement Management (CIEM) enterprise application   

 Detailed guidelines for each of these steps are outlined below: 

## Removal of permissions assigned in AWS, Azure, GCP

For successful offboarding of your data, remove permissions from your onboarded cloud provider (Azure, AWS, or GCP) and Microsoft Entra Permissions Management. Any roles and permissions assigned during onboarding should be removed. This will ensure your environment is secure with no overprivileged access once your environment is offboarded from Entra Permissions Management. 

Refer to the Data Collector configuration from the Entra Permissions Management portal and select the settings (gear icon). Note down the configuration settings to remove roles and permissions assigned in your respective cloud provider.  

## Remove the OIDC application for AWS and GCP environments

For AWS and GCP, delete the application created in the Microsoft Entra Admin Center tenant where Permissions Management is enabled. This app was used to set up an OIDC (OpenID Connect) connection to your AWS and GCP environments.   

To find the Enterprise Application created which was used to setup OIDC connection to your AWS and GCP environments, follow the below steps: 

> [!NOTE] 
> User must have the [Permissions Management Administrator](/entra-docs-pr/docs/identity/role-based-access-control/permissions-reference.md) and [Cloud Application Administrator](/entra-docs-pr/docs/identity/role-based-access-control/permissions-reference.md) role assignments to perform this task. 

1. Go to [Microsoft Entra admin center](https://entra.microsoft.com/) and sign in to [Microsoft Entra ID](https://portal.azure.com/#blade/Microsoft_AAD_IAM/ActiveDirectoryMenuBlade/Overview).
1. Launch the **Microsoft Entra Permissions Management portal**.
1. Select **Settings** (gear icon), then select the **Data Collectors** tab.
1. On the **Data Collectors** dashboard, select your authorization system type:
    1. **AWS** for Amazon Web Services. 
    1. **GCP** for Google Cloud Platform.
1. Select the ellipses **(...)** at the end of the row in the table.
1. Select **Edit Configuration**. The app is located under the **Azure App** name.
1. Go to [Microsoft Entra admin center](https://entra.microsoft.com/) and sign in to [Microsoft Entra ID](https://portal.azure.com/#blade/Microsoft_AAD_IAM/ActiveDirectoryMenuBlade/Overview).
1. Navigate to **Identity > Applications > App Registrations**. 
1. Enter the name of the existing application in the search box, and then select the application from the search results.
1. From the Overview page, select **Delete**. Read the deletion consequences. Check the box if one appears at the bottom of the pane.
1. Select **Delete** to confirm that you want to delete the app. 

## Stop data collection

Stop collecting data for your list of accounts / subscriptions / projects by deleting the associated data collectors. 

> [!NOTE]
> User must have the *Permissions Management Administrator* role assignment to perform this task.

1. Go to [Microsoft Entra admin center](https://entra.microsoft.com/) and sign in to [Microsoft Entra ID](https://portal.azure.com/#blade/Microsoft_AAD_IAM/ActiveDirectoryMenuBlade/Overview).
1. Select **Microsoft Entra Permissions Management** and click on **launch portal**. 
1. Select **Settings** (the gear icon). Then select the **Data Collectors** tab. 
1. On the **Data Collectors** dashboard, select your authorization system type: 
    1. **AWS** for Amazon Web Services. 
    1. **Azure** for Microsoft Azure. 
    1. **GCP** for Google Cloud Platform. 
1. Select the ellipses **(...)** at the end of the row in the table. 
1. Select **Delete Configuration**. The **Permissions Management Onboarding - Summary** box displays. 
1. Select **Delete**. 
1. Check your email for a one-time password (OTP) code, then enter it in **Enter OTP**. 
1. If you don't receive an OTP, select **Resend OTP**. 
1. The following message displays: ```Successfully deleted configuration```. 

## Disable user sign-in to the Cloud Infrastructure Entitlement Management (CIEM) enterprise application

Once data collection has stopped for all AWS accounts, Azure subscriptions and GCP projects, disable the Cloud Infrastructure Entitlement Management (CIEM) app so that it cannot be signed in. This ensures Microsoft Entra Permissions Management can no longer access your environments (accounts, subscriptions and projects).  

Note: User must have the Cloud Application Administrator role assignment to perform this task. 

To disable the CIEM App for users to sign in: 

1. Go to [Microsoft Entra admin center](https://entra.microsoft.com/) and sign in to [Microsoft Entra ID](https://portal.azure.com/#blade/Microsoft_AAD_IAM/ActiveDirectoryMenuBlade/Overview).
1. Navigate to **Identity > Applications > Enterprise Applications > All applications**.
1. Search for **Cloud Infrastructure Entitlement Management**. If you can’t locate the app, reset the filters.
1. Open **Properties**.
1. Toggle Enabled for users to sign-in to **No**.

:::image type="content" source="media/how-to-offboard-permissions-management/enable-user-sign-in-no.png" alt-text="Screenshot of enabling a user to sign in.:::

## Next steps

- For more information on the Microsoft Entra Permissions Management product retirement, visit [aka.ms/MEPMretire](https://aka.ms/MEPMretire)
