---
title: Microsoft Entra Suite deployment scenario - Workforce and guest lifecycle
description: Configure Microsoft Entra Suite products for hiring new remote employees and providing them with secure and seamless access to apps and resources.
ms.author: gasinh
author: gargi-sinha
manager: martinco
ms.service: entra
ms.subservice: architecture
ms.topic: concept-article
ms.date: 06/13/2024
ms.custom: sfi-ga-nochange, sfi-image-nochange
#CustomerIntent: As a Microsoft Entra Suite customer, I want to provide remote employees with secure access to apps and resources so that we prevent unauthorized access.
---
# Microsoft Entra Suite deployment scenario - Workforce and guest onboarding, identity, and access lifecycle governance across all your apps

The Microsoft Entra Suite deployment scenarios provide you with detailed guidance on how to combine and test these Microsoft Entra Suite products:

- [Microsoft Entra ID Protection](../id-protection/overview-identity-protection.md)
- [Microsoft Entra ID Governance](../id-governance/identity-governance-overview.md)
- [Microsoft Entra Verified ID (premium capabilities)](../verified-id/decentralized-identifier-overview.md)
- [Microsoft Entra Internet Access](../global-secure-access/concept-internet-access.md)
- [Microsoft Entra Private Access](../global-secure-access/concept-private-access.md)

In these guides, we describe scenarios that show the value of the Microsoft Entra Suite and how its capabilities work together.

- [Microsoft Entra deployment scenarios introduction](deployment-scenario-intro.md)
- [Microsoft Entra deployment scenario - Modernize remote access to on-premises apps with MFA per app](deployment-scenario-remote-access.md)
- [Microsoft Entra deployment scenario - Secure internet access based on business needs](deployment-scenario-internet-access.md)

## Scenario overview

In this guide, we describe how to configure Microsoft Entra Suite products for a scenario in which the fictional organization, Contoso, wants to hire new remote employees and provide them with secure and seamless access to necessary apps and resources. They want to invite and collaborate with external users (such as partners, vendors, or customers) and provide them with access to relevant apps and resources.

Contoso uses [Microsoft Entra Verified ID](../verified-id/decentralized-identifier-overview.md) to issue and verify digital proofs of identity and status for new remote employees (based on human resources data) and external users (based on email invitations). Digital wallets store identity proof and status to allow access to apps and resources. As an extra security measure, Contoso might verify identity with Face Check facial recognition based on the picture that the credential stores.

They use Microsoft Entra ID Governance to create and grant access packages for employees and external users based on verifiable credentials.

- For employees, they base access packages on job function and department. Access packages include cloud and on-premises apps and resources to which employees need access.
- For external collaborators, they base access packages on invitation to define external user roles and permissions. The access packages include only apps and resources to which external users need access.

Employees and external users can request access packages through a self-service portal where they provide digital proofs as identity verification. With single sign-on and multifactor authentication, employee and external user Microsoft Entra accounts provide access to apps and resources that their access packages include. Contoso verifies credentials and grants access packages without requiring manual approvals or provisioning.

Contoso uses Microsoft Entra ID Protection and Conditional Access to monitor and protect accounts from risky sign-ins and user behavior. They enforce appropriate access controls based on location, device, and risk level.

## Configure prerequisites

To successfully deploy and test the solution, configure the prerequisites that we describe in this section.

### Configure Microsoft Entra Verified ID

For this scenario, complete these prerequisite steps to configure Microsoft Entra Verified ID with Quick setup (Preview):

1. Register a custom domain (required for Quick setup) by following the steps in the [Add your custom domain](../fundamentals/add-custom-domain.yml) article.
1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Administrator](/entra/identity/role-based-access-control/permissions-reference#global-administrator).
   - Select **Verified ID**.
   - Select **Setup**.
   - Select **Get started**.
1. If you have multiple domains registered for your Microsoft Entra tenant, select the one that you would like to use for Verified ID.
1. After the setup process is complete, you see a default workplace credential available to edit and offer to employees of your tenant on their **My Account** page.

   :::image type="content" source="media/deployment-scenario-workforce-guest/verifiable-credentials-setup-complete-inline.png" alt-text="Screenshot of Verified ID, Overview." lightbox="media/deployment-scenario-workforce-guest/verifiable-credentials-setup-complete-expanded.png":::

1. Sign in to the test user's **My Account** with their Microsoft Entra credentials. Select **Get my Verified ID** to issue a verified workplace credential.

   :::image type="content" source="media/deployment-scenario-workforce-guest/verifiable-credentials-my-account-issue-inline.png" alt-text="Screenshot of My Account, Overview with a red ellipse highlighting the Get my Verified ID control." lightbox="media/deployment-scenario-workforce-guest/verifiable-credentials-my-account-issue-expanded.png":::

### Add trusted external organization (B2B)

Follow these prerequisite steps to add a trusted external organization (B2B) for the scenario.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Security Administrator](/entra/identity/role-based-access-control/permissions-reference#security-administrator).
1. Browse to **Entra ID** > **External Identities** > **Cross-tenant access settings**. Select **Organizational settings**.
1. Select **Add organization**.
1. Enter the organization's full domain name (or tenant ID).
1. Select the organization in the search results. Select **Add**.
1. Confirm the new organization (that inherits its access settings from default settings) in **Organizational settings**.

   :::image type="content" source="media/deployment-scenario-workforce-guest/org-specific-settings-inherited-inline.png" alt-text="Screenshot of Organizational settings with red boxes highlighting Inherited from default in the Inbound access and Outbound access columns." lightbox="media/deployment-scenario-workforce-guest/org-specific-settings-inherited-expanded.png":::

### Create catalog

Follow these steps to create an Entitlement management catalog for the scenario.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Identity Governance Administrator](/entra/identity/role-based-access-control/permissions-reference#identity-governance-administrator).
1. Browse to **ID Governance** > **Entitlement management** > **Catalogs**.
1. Select **+New catalog**.

   :::image type="content" source="media/deployment-scenario-workforce-guest/identity-governance-catalogs-inline.png" alt-text="Screenshot of New access review, Enterprise applications, All applications, Identity Governance, New catalog." lightbox="media/deployment-scenario-workforce-guest/identity-governance-catalogs-expanded.png":::

1. Enter a unique name and description for the catalog               . Requestors see this information in an access package's details.
1. To create access packages in this catalog only for internal users, select **Enabled for external users** > **No**.

   :::image type="content" source="media/deployment-scenario-workforce-guest/identity-governance-new-catalog.png" alt-text="Screenshot of New catalog with No selected for the Enabled for external users control.":::

1. On **Catalog**, open the catalog to which you want to add resources. Select **Resources** > **+Add resources**.
1. Select **Type**, then **Groups and Teams**, **Applications**, or **SharePoint sites**.
1. Select one or more resources of the type that you want to add to the catalog. Select **Add**.

## Create access packages

To successfully deploy and test the solution, configure the access packages that we describe in this section.

### Access package for remote users (internal)

Follow these steps to create an access package in entitlement management with Verified ID for remote (internal) users.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Identity Governance Administrator](/entra/identity/role-based-access-control/permissions-reference#identity-governance-administrator).
1. Browse to **ID Governance** > **Entitlement management** > **Access package**.
1. Select **New access package**.
1. For **Basics**, give the access package a name (such as *Finance Apps for Remote Users*). Specify the catalog that you previously created.
1. For **Resource roles**, select a resource type (for example: Groups and Teams, Applications, SharePoint sites). Select one or more resources.
1. In **Role**, select the role to which you want users assigned for each resource.

   :::image type="content" source="media/deployment-scenario-workforce-guest/resource-roles-inline.png" alt-text="Screenshot of Resources roles with a red box highlighting the Role column." lightbox="media/deployment-scenario-workforce-guest/resource-roles.png":::

1. For **Requests**, select **For users in your directory**.
1. In **Select users and groups**, select **For Users in your directory**. Select **+ Add users and groups**. Select an existing group entitled to request the access package.
1. Scroll to **Required Verified Ids**.
1. Select **+ Add issuer**. Select an issuer from the Microsoft Entra Verified ID network. Ensure that you select an issuer from an existing verified identity in the guest wallet.
1. **Optional:** In **Approval**, specify whether users require approval when they request the access package.
1. **Optional:** In **Requestor information**, select **Questions**. Enter a question (known as the display string) that you want to ask the requestor. To add localization options, select **Add localization**.
1. For **Lifecycle**, specify when a user's assignment to the access package expires. Specify whether users can extend their assignments. For **Expiration**, set **Access package assignments** expiration to **On date**, **Number of days**, **Number of hours**, or **Never**.
1. In **Access Reviews**, select **Yes**.
1. In **Starting on**, select the current date. Set **Review Frequency** to **Quarterly**. Set **Duration (in Days)** to 21.

### Access package for guests (B2B)

Follow these steps to create an access package in entitlement management with Verified ID for guests (B2B).

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Identity Governance Administrator](/entra/identity/role-based-access-control/permissions-reference#identity-governance-administrator).
1. Browse to **ID Governance** > **Entitlement management** > **Access package**.
1. Select **New access package**.
1. For **Basics**, give the access package a name (such as *Finance Apps for Remote Users*). Specify the catalog that you previously created.
1. For **Resource roles**, select a resource type (for example: Groups and Teams, Applications, SharePoint sites). Select one or more resources.
1. In **Role**, select the role to which you want users assigned for each resource.

   :::image type="content" source="media/deployment-scenario-workforce-guest/resource-roles-inline.png" alt-text="Screenshot of Resources roles with a red box highlighting the Role column." lightbox="media/deployment-scenario-workforce-guest/resource-roles.png":::

1. For **Requests**, select **For users not in your directory**.
1. Select **Specific connected organizations**. To select from a list of connected organizations that you previously added, select **Add directory**.
1. Enter the name or domain name to search for a previously connected organization.
1. Scroll to **Required Verified Ids**.
1. Select **+ Add issuer**. Select an issuer from the Microsoft Entra Verified ID network. Ensure that you select an issuer from an existing verified identity in the guest wallet.
1. **Optional:** In **Approval**, specify whether users require approval when they request the access package.
1. **Optional:** In **Requestor information**, select **Questions**. Enter a question (known as the display string) that you want to ask the requestor. To add localization options, select **Add localization**.
1. For **Lifecycle**, specify when a user's assignment to the access package expires. Specify whether users can extend their assignments. For **Expiration,** set **Access package assignments** expiration to **On date**, **Number of days**, **Number of hours**, or **Never**.
1. In **Access Reviews**, select **Yes**.
1. In **Starting on**, select the current date. Set **Review Frequency** to **Quarterly**. Set **Duration (in Days)** to 21.
1. Select **Specific reviewers**. Select **Self Review**.

   :::image type="content" source="media/deployment-scenario-workforce-guest/new-access-package.png" alt-text="Screenshot of New access package.":::

## Create a sign-in risk-based Conditional Access policy

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Conditional Access Administrator](/entra/identity/role-based-access-control/permissions-reference#conditional-access-administrator).
1. Browse to **Entra ID** > **Conditional Access** > **Policies**.
1. Select **New policy**.
1. Enter a policy name such as *Protect applications for remote high-risk sign-in users*.
1. For **Assignments**, select **Users**.
   1. For **Include**, select a remote user group or select all users.
   1. For **Exclude**, select **Users and groups**. Select your organization's emergency access or break-glass accounts.
   1. Select **Done**.
1. For **Cloud apps or actions** > **Include**, select the applications to target this policy.
1. For **Conditions** > **Sign-in risk**, set **Configure** to **Yes**. For **Select the sign-in risk level this policy will apply to**, select **High** and **Medium**.
   1. Select **Done**.
1. For **Access controls** > **Grant**.
   1. Select **Grant access** > **Require multifactor authentication**.
1. For **Session**, select **Sign-in frequency**. Select **Every time**.
1. Confirm settings. Select **Enable policy**.

   :::image type="content" source="media/deployment-scenario-workforce-guest/conditional-access-policies-new-inline.png" alt-text="Screenshot of Conditional Access Policies, New, Sign-in risk. A red box emphasizes User risk and Sign-in risk." lightbox="media/deployment-scenario-workforce-guest/conditional-access-policies-new-expanded.png":::

## Request access package

After you configure an access package with a Verified ID requirement, end-users who are within the scope of the policy can request access in their **My Access** portal. While approvers review requests for approval, they can see the claims of the verified credentials that requestors present.

1. As a remote user or guest, sign in to `myaccess.microsoft.com`.
1. Search for the access package that you previously created (such as *Finance Apps for Remote Users*). You can browse the listed packages or use the search bar. Select **Request**.
1. The system displays an information banner with a message such as, *To request access to this access package you need to present your Verifiable Credentials*. Select **Request Access**. To launch Microsoft Authenticator, scan the QR Code with your phone. Share your credentials.

   :::image type="content" source="media/deployment-scenario-workforce-guest/present-verified-id.png" alt-text="Screenshot of My Access, Available, Access packages, Present Verified ID, QR Code.":::

1. After you share your credentials, continue with the approval workflow.
1. **Optional:** Follow the [Simulating risk detections in Microsoft Entra ID Protection](../id-protection/howto-identity-protection-simulate-risk.md) instructions. You might need to try multiple times to raise the user risk to medium or high.
1. Try accessing the application that you previously created for the scenario to confirm blocked access. You might need to wait up to one hour for block enforcement.
1. Use sign in logs to validate blocked access by the Conditional Access policy that you created earlier. Open non-interactive sign in logs from the *ZTNA Network Access Client -- Private* application. View logs from the Private Access application name that you previously created as the **Resource name**.

## Related content

- [Microsoft Entra Verified ID](https://www.microsoft.com/security/business/identity-access/microsoft-entra-verified-id)
- [Plan your Microsoft Entra Verified ID verification solution](../verified-id/plan-verification-solution.md)
- [What is Microsoft Entra ID Protection?](../id-protection/overview-identity-protection.md)
- [Microsoft Entra ID Governance](../id-governance/identity-governance-overview.md)
- [Plan a Microsoft Entra Conditional Access deployment](../identity/conditional-access/plan-conditional-access.md)
