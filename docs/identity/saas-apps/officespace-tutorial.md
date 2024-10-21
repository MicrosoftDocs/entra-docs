---
title: 'Tutorial: Microsoft Entra single sign-on (SSO) integration with OfficeSpace Software'
description: Learn how to configure single sign-on between Microsoft Entra ID and OfficeSpace Software.

author: jeevansd
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: tutorial
ms.date: 03/25/2024
ms.author: jeedes

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and OfficeSpace Software so that I can control who has access to OfficeSpace Software, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Tutorial: Microsoft Entra single sign-on (SSO) integration with OfficeSpace Software

## Prerequisites

To get started, you need the following items:

* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* OfficeSpace Software single sign-on (SSO) enabled subscription.


## Configure and test Microsoft Entra SSO for OfficeSpace Software

Configure and test Microsoft Entra SSO with OfficeSpace Software using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in OfficeSpace Software.

To configure and test Microsoft Entra SSO with OfficeSpace Software, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **[Create a Microsoft Entra test user](#create-an-azure-ad-test-user)** - to test Microsoft Entra single sign-on with B.Simon.
    1. **[Assign the Microsoft Entra test user](#assign-the-azure-ad-test-user)** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure OfficeSpace Software SSO](#configure-officespace-software-sso)** - to configure the single sign-on settings on application side.


<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **OfficeSpace Software** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, click the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps:

	a. In the **Sign on URL** text box, type a URL using the following pattern:
    `https://<company name>.officespacesoftware.com/users/sign_in/saml`

    b. In the **Identifier (Entity ID)** text box, type a URL using the following pattern:
    `<company name>.officespacesoftware.com`

	> [!NOTE]
	> These values are not real. Update these values with the actual Sign on URL and Identifier. Contact the [OfficeSpace Software Client support team](mailto:support@officespacesoftware.com) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. OfficeSpace Software application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes, whereas **nameidentifier** is mapped with **user.userprincipalname**. OfficeSpace Software application expects **nameidentifier** to be mapped with **user.mail**, so you need to edit the attribute mapping by clicking on **Edit** icon and change the attribute mapping.

	![image](common/edit-attribute.png)

1. In addition to above, OfficeSpace Software application expects few more attributes to be passed back in SAML response which are shown below. These attributes are also pre-populated but you can review them as per your requirement.

	| Name | Source Attribute|
	| ---------------| --------------- |
	| email | user.mail |
	| name | user.displayname |
	| first_name | user.givenname |
	| last_name | user.surname |

1. In the **SAML Signing Certificate** section, click **Edit** button to open **SAML Signing Certificate** dialog.

	![Edit SAML Signing Certificate](common/edit-certificate.png)

1. In the **SAML Signing Certificate Section**, choose to choose to download the PEM certificate.

    ![PEM](https://github.com/user-attachments/assets/9c0e4fa7-1c4a-4a62-aa1b-a45bc06b1afd)

1. In the **Set up OfficeSpace Software** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

### Create a Microsoft Entra test user

In this section, you'll create a test user called B.Simon.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [User Administrator](~/identity/role-based-access-control/permissions-reference.md#user-administrator).
1. Browse to **Identity** > **Users** > **All users**.
1. Select **New user** > **Create new user**, at the top of the screen.
1. In the **User** properties, follow these steps:
   1. In the **Display name** field, enter `B.Simon`.  
   1. In the **User principal name** field, enter the username@companydomain.extension. For example, `B.Simon@contoso.com`.
   1. Select the **Show password** check box, and then write down the value that's displayed in the **Password** box.
   1. Select **Review + create**.
1. Select **Create**.

<a name='assign-the-azure-ad-test-user'></a>

### Assign the Microsoft Entra test user

In this section, you'll enable B.Simon to use single sign-on by granting access to OfficeSpace Software.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **OfficeSpace Software**.
1. In the app's overview page, select **Users and groups**.
1. Select **Add user/group**, then select **Users and groups** in the **Add Assignment** dialog.
   1. In the **Users and groups** dialog, select **B.Simon** from the Users list, then click the **Select** button at the bottom of the screen.
   1. If you are expecting a role to be assigned to the users, you can select it from the **Select a role** dropdown. If no role has been set up for this app, you see "Default Access" role selected.
   1. In the **Add Assignment** dialog, click the **Assign** button.

## Configure OfficeSpace Software SSO

1. In a different web browser window, sign in to your OfficeSpace Software tenant as an administrator.

2. In the Hamburger Menu, select **Connectors** under Admin.
   
![01 Connectors Highlighted](https://github.com/user-attachments/assets/708e0ab2-1e0b-4376-9c98-b634c317cf64)

3. Under Authentication, select **Add SAML Configuration**.

![02 Add SAML Highlighted](https://github.com/user-attachments/assets/bbf28318-16af-4823-9fa8-03c2d76e5648)

In the SAML Authentication section, perform the following steps:
   
4. Select an Icon for display, and enter in the **Display Name** "Microsoft Entra".

![03 Display Name Entered as Microsoft Entra](https://github.com/user-attachments/assets/915f2c4e-8c49-4d3d-9872-0f85db6032e3)

5.Enter your IdP login URL, Client IdP certificate (PEM), and IdP logout URL

![04 IdP Fields Annotated](https://github.com/user-attachments/assets/5f773ba7-ee1f-4886-89e8-42172856fb87)

6. Select **Create** to finish creating the SAML profile.

![05 Create Button Highlighted](https://github.com/user-attachments/assets/eb49478d-b8f4-4745-b616-d941fbaa27df)


