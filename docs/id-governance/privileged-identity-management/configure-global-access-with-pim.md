---
title: Securing high value private application access with Privileged Identity Management (PIM)
description: Learn how to secure high value private application access with Privileged Identity Management (PIM)
author: kenwith
manager: amycolannino
ms.service: entra-id
ms.subservice: app-proxy
ms.topic: conceptual
ms.date: 06/25/2024
ms.author: kenwith
ms.reviewer: katabish
---

# Securing high value private application access with Privileged Identity Management (PIM)

Microsoft Entra Private Access provides secure access to private application. Private Access includes built-in capabilities to analyze device health posture combined with user risks and state. For general corporate access, see [Microsoft Entra Private Access](/entra/global-secure-access).

For specific resources, such as highly valued servers and applications, customers typically add an extra in-depth defense layer by enforcing privilege access on top of their already secured private access. 

This article discusses how to use Microsoft Entra Private Access to enable Privileged Identity Management (PIM) for Secure Access. For details about enabling (PIM), see [What is Microsoft Entra Privileged Identity Management?](/entra/id-governance/privileged-identity-management/pim-configure). 

## Add Microsoft Entra Private Access with Privileged Identity Management (PIM)

Customer should consider configuring PIM using Global Secure Access for these reasons:

**Enhanced Security:** PIM allows for just-in-time privileged access, reducing the risk of excessive, unnecessary, or misused access permissions within your environment. This enhanced security aligns with the Zero Trust principle of least privilege, ensuring that users have access only when they need it.

**Efficient Management**: Microsoft Global Secure Access offers Role-Based Access Control (RBAC) to manage administrative access efficiently. Admin roles like Global Administrator, Security Administrator, and others have varying levels of access, from full permissions to read-only access. This helps in delegating access effectively based on administrative responsibilities.

**Compliance and Auditing**: Using PIM with Microsoft Global Secure Access can help ensure that your organization meets compliance requirements by providing detailed tracking and logging of privileged access requests and activations.

## Prerequisites 

- Microsoft Entra ID SKU support Privileged Identity Management (P2 or E5) 
- Microsoft Entra Private Access

## Secure private access 

To successfully implement secure private access, you must complete these three steps:
- Step 1: [Configure and assign groups](#step-1-configure-amd-assign-groups)
- Step 2: [Activate privileged access](#step-2-activate-privileged-access)
- Step 3: [Tracking and logging compliance](#step-3-tracking-and-logging-compliance)

## Step 1: Configure and assign groups

To begin, we configure and assign groups by creating a Microsoft Entra ID group, onboard it as a PIM managed group, update group assignments with eligible membership, and specify access for user and devices.

1. Navigate to [Microsoft Entra](https://entra.microsoft.com/) > **Identity** > **Groups** > **All groups**.
 
   :::image type="content" border="true" source="./media/pim-global-secure-access/all-groups.png" alt-text="Screenshot of the All groups screen.":::

1. Select **New Group**.
1. In the **Group type**, select **Security**.
1. Provide a group name; for example, `HighRiskAssetAccess`.
1. In the **Membership type** option, select **Assigned**.
1. Select **Create**. 

   :::image type="content" border="true" source="./media/pim-global-secure-access/new-group.png" alt-text="Screenshot of the New group screen.":::

### Onboard the group to PIM 

1. Navigate to [Microsoft Entra](https://entra.microsoft.com/) >  **Identity Governance**  > **Privileged Identity Management**.
1. Select **Groups**, then **Discover groups**. 

   :::image type="content" border="true" source="./media/pim-global-secure-access/discover-groups.png" alt-text="Screenshot of the Groups screen with Discover groups selected.":::

1. Select the group that you created; for example, `HighRiskAssetAccess`, then select **Manage groups**. 
1. When prompted for onboarding, select **OK**. 

    :::image type="content" border="true" source="./media/pim-global-secure-access/manage-groups.png" alt-text="Screenshot of the Managed groups screen with a group selected.":::

### Configure customer role (optional step)

1. Select **Setting**, then select **Member**. 

   :::image type="content" border="true" source="./media/pim-global-secure-access/choose-member-role.png" alt-text="Screenshot of Member Role screen.":::

1. Adjust any other settings you want in the **Activation** tab.

1. Set the **Activation Max Duration**; for example, 0.5 hours. 
1. In the **On activation** option, require **Azure MFA**, and select **Update**.

   :::image type="content" border="true" source="./media/pim-global-secure-access/activation-tab.png" alt-text="Screenshot of the Activation tab options.":::

### Assign eligible membership

1. Select **Assignments**, then **Add assignments**. 

   :::image type="content" border="true" source="./media/pim-global-secure-access/add-assignments.png" alt-text="Screenshot of the Add assignments option.":::

1. In the **Role** option, select **Member**, then select **Next**.
1. Add the selected members that you would like to include for the role.
 
   :::image type="content" border="true" source="./media/pim-global-secure-access/eligible-assignment.png" alt-text="Screenshot of the eligible member.":::

1. In the **Assignment Type** option, select **Eligible**, then select **Assign**.

   :::image type="content" border="true" source="./media/pim-global-secure-access/eligible-member.png" alt-text="Screenshot of the Eligible member screen.":::

### Quick Access assignment

1. Navigate to [Microsoft Entra](https://entra.microsoft.com/) > **Global Secure Access** > **Quick Access** > **Users and groups**. 
1. Select **Add user/group**, then specify the group that you created; for example `HighRiskAssetAccess`.  

   :::image type="content" border="true" source="./media/pim-global-secure-access/quick-access.png" alt-text="Screenshot of the Quick Access screen.":::

> [!NOTE]  
> This scenario is most effective when you choose **Per-app Access**, as **Quick Access** is used here for reference only. Apply the same steps if you choose **Enterprise Applications**.

### Client-side experience

Even if a user and their device meet security requirements, attempting to access a privileged resource results in an error. This error occurs because Microsoft Entra Private Access recognizes that the user hasn't been assigned access to the application. 

:::image type="content" border="true" source="./media/pim-global-secure-access/client-experience.png" alt-text="Screenshot of the client experience error message.":::

## Step 2: Activate privileged access

Next, we activate the PIM role using the Microsoft Entra admin center, and then attempt to connect with the new role activated.

1. With at least a privileged user role, navigate to [Microsoft Entra](https://entra.microsoft.com/)  >  **Identity Governance**  > **Privileged Identity Management**. 
1. Select **My roles** and select **Groups** to see all eligible assignments.

   :::image type="content" border="true" source="./media/pim-global-secure-access/my-roles-groups.png" alt-text="Screenshot of My role groups screen.":::

1. Select **Activate**, then type the reason in the **Reason** box. You can also choose to adjust the parameters of the session, then select **Activate**.

   :::image type="content" border="true" source="./media/pim-global-secure-access/activate-member.png" alt-text="Screenshot of the Activate member screen.":::

1. Once the role is activated, you receive a confirmation from the portal.

   :::image type="content" border="true" source="./media/pim-global-secure-access/member-activated.png" alt-text="Screenshot of the member being activated in the portal.":::

### Reattempt to connect with role activated 

- Browse any of the published resources, as you should be able to successfully connect to them. 

   :::image type="content" border="true" source="./media/pim-global-secure-access/identify-remote-computer.png" alt-text="Screenshot of connecting to published resource.":::

### Deactivate the role 

If the work is completed ahead of the time you allocated, you can choose to deactivate the role. This action terminates the role membership. 

1. With at least *Privileged User* access, navigate to entra.microsoft.com  >  **Identity Governance**  > **Privileged Identity Management**.
1. Select **My Roles**, then **Groups**. 
1. Select **Deactivate**. 

:::image type="content" border="true" source="./media/pim-global-secure-access/deactivate-member.png" alt-text="Screenshot of Deactiviate member screen.":::

1. A confirmation is sent to you once the role is deactivated.  

## Step 3: Tracking and logging compliance

This final step enables you to successfully maintain a history of access requests and activations. The standard log format helps to meet the compliance guidance and provide an audit trail. 

:::image type="content" border="true" source="./media/pim-global-secure-access/audit-log-details.png" alt-text="Screenshot of the Audit log details screen.":::
