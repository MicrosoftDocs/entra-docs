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
ms.reviewer: jeevanb
---

# Securing high value private application access with Privileged Identity Management (PIM)

Microsoft Entra Private Access provides secure access to private application. Private Access has built in capabilities to analyze device health posture combined with user risks and state. For general corporate access, see [Microsoft Entra Private Access](/entra/global-secure-access).

For specific resources, such as highly-valued servers and applications, customers typically add an additional in-depth defense layer by enforcing privilege access on top of their already secured private access. 

## Add Microsoft Entra Private Access with Privileged Identity Management (PIM)

[TBD: Add context for a scenario that describes why someone would want to configure this in the first place.]

[In this scenario, TBD.]

This article discusses how use Microsoft Entra Private Access to enable Privileged Identity Management (PIM) for Secure Access. For details about enabling (PIM), see [What is Microsoft Entra Privileged Identity Management?]( https://learn.microsoft.com/en-us/entra/id-governance/privileged-identity-management/pim-configure). 

## Prerequisites 

- Microsoft Entra ID SKU support Privileged Identity Management (P2 or E5) 
- Microsoft Entra Private Access

## Secure private access 

The following diagram shows how you can easily achieve secure private access using both Microsoft Entra Private Access and Microsoft Entra ID built-in integration. 

:::image type="content" border="true" source="./media/image.png" alt-text="Screenshot of X.":::

To successfully implement secure private access, you must complete these three steps:
- Step 1: [Configure and assign groups](#step-1-configure-amd-assign-groups)
- Step 2: [Activate privileged access](#step-2-activate-privileged-access)
- Step 3: [Tracking and logging compliance](#step-3-tracking-and-logging-compliance)

## Step 1: Configure amd assign groups

[To begin, we TBD.]

1. Navigate to [Microsoft Entra](https://entra.microsoft.com/) > **Identity** > **Groups** > **All Groups**.
 
   :::image type="content" border="true" source="./media/image.png" alt-text="Screenshot of X.":::

1. Select **New Group**.
1. In the **Group Type**, select **Security**.
1. Provide a group name; for example, `HighRiskAssetAccess`.
1. In the **Choose Membership** option, select **Assigned**.
1. Select **Create**. 

   :::image type="content" border="true" source="./media/image.png" alt-text="Screenshot of X.":::

### Onboard the group to PIM 

1. Navigate to [Microsoft Entra](https://entra.microsoft.com/) >  **Identity Governance**  > **Privileged Identity Management**.
1. Select **Groups**, then **Discover Groups**. 

   :::image type="content" border="true" source="./media/image.png" alt-text="Screenshot of X.":::

1. Select the group that you created; for example `HighRiskAssetAccess`, then select **Manage groups**. 
1. When prompted for onboarding, select **OK**. 

    :::image type="content" border="true" source="./media/image.png" alt-text="Screenshot of X.":::

### Configure customer role (optional step)
 
1. Select **Setting**, then select **Member role**. 

   :::image type="content" border="true" source="./media/image.png" alt-text="Screenshot of X.":::

1. Adjust any other settings you want.  

1. Set the **Activation Max Duration**; for example .5 hours. 
1. In the **On activation** option, require **Azure MFA**. 

   :::image type="content" border="true" source="./media/image.png" alt-text="Screenshot of X.":::

### Assign eligible membership

1. Select **Assignments**, then **Add assignments**. 

   :::image type="content" border="true" source="./media/image.png" alt-text="Screenshot of X.":::

1. In the **Role** option, select **Member**.
1. Add the selected member(s) that you would like to include for the role.
1. In the **Assignment Type** option, select **Eligible**.

   :::image type="content" border="true" source="./media/image.png" alt-text="Screenshot of X.":::

   :::image type="content" border="true" source="./media/image.png" alt-text="Screenshot of X.":::

### Quick Access assignment

1. Navigate to [Microsoft Entra](https://entra.microsoft.com/) > **Global Secure Access** > **Quick Access** > **Users and Groups**. 
1. Select **Add user/group**, then specify the group that you created; for example `HighRiskAssetAccess`.

   > [!NOTE]  
   > This scenario is most effective when you choose **Per-App Access**, as **Quick Access** is used here for reference only. Apply the same steps if you choose **Enterprise Applications**.  

   :::image type="content" border="true" source="./media/image.png" alt-text="Screenshot of X.":::

### Client-side experience

Even if a user and their device meet security requirements, attempting to access a privileged resource results in an error. This error occurs because Microsoft Entra Private Access recognizes that the user has not been assigned access to the application. 

:::image type="content" border="true" source="./media/image.png" alt-text="Screenshot of X.":::

## Step 2: Activate privileged access

[Next, we TBD.]

1. With at least a privileged user role, navigate to [Microsoft Entra](https://entra.microsoft.com/)  >  **Identity Governance**  > **Privileged Identity Management**. 
1. Select **My Roles** and select **Groups** to see all eligible assignments.

   :::image type="content" border="true" source="./media/image.png" alt-text="Screenshot of X.":::

1. Select **Activate**, then type the reason in the **Reason** box. You can also choose to adjust the parameters of the session.

   :::image type="content" border="true" source="./media/image.png" alt-text="Screenshot of X.":::

1. Once the role is activated, you receive a confirmation from the portal.

   :::image type="content" border="true" source="./media/image.png" alt-text="Screenshot of X.":::

### Reattempt to connect with role activated 

- Browse any of the published resources, as you should be able to successfully connect to them. 

   :::image type="content" border="true" source="./media/image.png" alt-text="Screenshot of X.":::

### Deactivate the role 

If the work has completed ahead of the time you allocated, you can choose to deactivate the role. This action terminates the role membership. 

1. With at least *Privileged User* access, navigate to entra.microsoft.com  >  **Identity Governance**  > **Privileged Identity Management**.
2. Select **My Roles**, then **Groups**. 
3. Select **Deactivate**. 

A confirmation is sent to you once the role has been deactivated.  

:::image type="content" border="true" source="./media/image.png" alt-text="Screenshot of X.":::

:::image type="content" border="true" source="./media/image.png" alt-text="Screenshot of X.":::


## Step 3: Tracking and logging compliance

This final step enables you to successfully maintain a history of access requests and activations. The standard log format helps to meet the compliance guidance and provide an audit trail. 

:::image type="content" border="true" source="./media/image.png" alt-text="Screenshot of X.":::
