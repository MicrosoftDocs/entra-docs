---
title: Microsoft Entra Suite Scenario - Use entitlement management and Global Secure Access to restrict employee access to cloud apps 
description: Learn how you can use entitlement management and Global Secure Access to restrict employee access to cloud apps.
author: owinfreyatl
manager: dougeby
ms.service: entra-id-governance
ms.subservice: entitlement-management
ms.topic: how-to
ms.date: 05/13/2025
ms.author: owinfrey
ms.reviewer: jercon
---


# Microsoft Entra Suite Scenario: Use entitlement management and Global Secure Access to restrict employee access to cloud apps 

The Microsoft Entra Suite provides capabilities to govern who can access restricted websites. Microsoft Entra Internet Access protects access to SaaS apps and entitlement management enables organizations to manage identity and access lifecycle at scale, by automating access request workflows, access assignments, reviews, and expiration.

In this scenario, you set up Global Secure Access and Conditional Access to block access to a specific unauthorized website such as an unsanctioned AI app, while using entitlement management to provide governed access to users who should be exempt from the policy. This scenario is useful for generative AI applications and other web applications that don't support provisioning or federation with Microsoft Entra.

:::image type="content" source="media/entra-suite-scenario/restrict-access-saas-app.png" alt-text="Screenshot of a diagram showing restricting software as a service app using conditional access and Global Secure Access.":::

:::image type="content" source="media/entra-suite-scenario/grant-governed-access-saas-app.png" alt-text="Screenshot of a diagram showing granting governed software as a service app using conditional access and Global Secure Access.":::

## Prerequisites

To complete this scenario, you must have the following prerequisites in your Microsoft Entra tenant:

- Microsoft Entra Suite, or Microsoft Entra ID Governance along with Microsoft Global Secure Access
- Required roles: Conditional Access Administrator, Identity Governance Administrator, and Global Secure Access Administrator
- A Microsoft Entra ID joined device where the Global Secure Access client can be installed.

## Step 1: Set up Global Secure Access

If Global Secure Access isn't already configured, you need to set this up first. Visit [Get started with Global Secure Access](../global-secure-access/quickstart-access-admin-center.md) for a step-by-step guide. The four steps include:

1. Enable the [Internet Access profile](../global-secure-access/how-to-manage-internet-access-profile.md) and [Microsoft traffic forwarding profile](../global-secure-access/how-to-manage-microsoft-profile.md).

1. Install and configure the Global Secure Access Client on end-user devices.

## Step 2: Create a Global Secure Access web content filtering policy

In this step, you create a Global Secure Access web content filtering policy to block access to a specific website. See [How to configure Global Secure Access web content filtering](../global-secure-access/how-to-configure-web-content-filtering.md).

1. Identify the internet domain that you want to restrict access to and define the process for how users who are blocked should get access. In the following guide, we use a security group to provide users with access.

1. Go to Global Secure Access > Secure > Web content filtering policies and select **Create policy**.

1. Choose a name for the policy and select **Block** as the Action.

1. Under the Policy Rules tab, select “Add rule.” Choose a name, select “fqdn” for Destination type, and enter the destination you would like to block. Select add.

1. Review and create the policy.

## Step 3: Create a Global Secure Access security profile and link the filtering policy

1. Go to Global Secure Access > Secure > Security profiles and select **Create profile**.

1. Choose a profile name, leave “*enabled*” for State, and select a Priority.

1. Under the Link policies tab, choose “*Link a policy*” and select the web content filtering policy.

## Step 4: Create a security group for exempted users

1. Go to Groups and select **New group**.

1. Choose Group type **Security**, enter a group name, and leave membership as **Assigned**.

1. Create the group.

## Step 5: Configure a Conditional Access Policy

Once Global Secure Access is set up, you need to [create a Conditional Access policy](../identity/conditional-access/concept-conditional-access-policies.md) to restrict access to a specific website.

1. Browse to Protection > Conditional Access > Policies and select **New policy**.

1. Choose a name for the policy.

1. Under Users, select the Include tab and choose **All users**. Select the Exclude tab, choose **Users and groups**, and select the group that you created in Step 4 that is used as an exception group to the policy.

1. Under Target resources, select **All internet resources with Global Secure Access**.

1. Under Session select **Use Global Secure Access security profile**, and select the name of the security profile that you created in Step 3.

1. Under Enable policy select **On**, or leave in Report-only mode for testing.

1. Save the policy.

## Step 6: Create an entitlement management access package to provide governed access to the restricted resource

The last step in the scenario is to create an access package that contains the security group that you specified in Step 4. Users assigned to this access package are assigned to this group, and are exempt from the web content filtering policies that you established.

Like other access packages, you create a policy with rules specifying who can request the package, who must approve, and its lifecycle. Learn more at [Create an access package in entitlement management](../id-governance/entitlement-management-access-package-create.md).

## Step 7: Test the scenario

Once you complete the previous steps, you're ready to test the scenario.

1. On the Microsoft Entra ID joined device, attempt to visit the site you restricted in Step 2. You should receive a blocking experience for all browsers with a plaintext browser error for HTTP traffic and a "Connection Reset" browser error for HTTPS traffic.

1. In entitlement management, assign the access package you created in Step 5 to the user who is signed in on the Microsoft Entra ID joined device. This assigns the user to the access package which provides access to the security group you created in Step 4. Any required approvals need to be completed before the assignment is completed.

1. On the Microsoft Entra ID joined device, attempt to visit the site you restricted in Step 2. You should now be able to access the site. 

> [!NOTE]
> It can take up to 60 minutes for the Global Secure Access Policy to take effect.

## Related content

- [What is Global Secure Access?](../global-secure-access/overview-what-is-global-secure-access.md)
- [What is Conditional Access?](../identity/conditional-access/overview.md)
