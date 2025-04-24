---
title: "Set up SSO with Microsoft Entra ID for Human Focus"
description: "Step-by-step guide to configure single sign-on between Microsoft Entra ID and Human Focus."
author: mazharhf
ms.author: mazharali@humanfocus.co.uk  (macrosoft partner account)
ms.date: 04/25/2025
ms.topic: how-to
ms.service: entra-id
---

# Human Focus Single Sign-On (SSO) Setup for Microsoft Entra ID

Follow these steps to set up Single Sign-On (SSO) for Human Focus using Microsoft Entra ID formerly Azure Active Directory (Azure AD).

## Step 1: Log in to Microsoft Entra ID

1. Login to Microsoft Entra ID.
2. Click on **Enterprise Applications**.
   ![Enterprise Applications](common/HF-overview.png)

## Step 2: Create a New Application

1. Click the **+ New application** button.
   ![New Application](common/HF-allApplication.png)
2. Select **Create your own application**.
   ![Provide name](common/HF-brows.png)
3. Provide a name for your application.
4. Select the last option appearing on the page and click **Create**.
   ![Create Application](common/HF-create.png)

## Step 3: Set up Single Sign-On

1. Click on **Set up single sign on**.
   ![Set up Single Sign-On](common/HF-properties.png)
2. Select the **SAML** option.
   ![SAML Option](common/HF-saml.png)

## Step 4: Configure SAML

1. Enter the following values:

    - **Identifier**: `https://www.humanfocus.org.uk/`
    - **Reply URL**: `https://www.humanfocus.org.uk/CBTbyB/SAML/AssertionConsumerService.aspx`
   ![Configure SAML](common/HF-signOn.png)

## Step 5: Edit User Attributes & Claims

1. Edit the **User Attributes & Claims** section.
2. In the **Unique User Identifier (Name ID)** claim, ensure the value is set to `user.userprincipalname [nameid-format:emailAddress]`.
    ![Edit Attributes](common/HF-manageClaim.png)

3. Delete any default attributes under the **Additional claims** section.
    ![default attributes](common/HF-attribute.png)

4. Add the following attributes:

    - **first_name**: `user.givenname`
    - **last_name**: `user.surname`
    - **email**: `user.userprincipalname`
    - **roles**: `user.assignedroles`

    If you want to enable Role Mapping in Contentstack, ensure you add the `roles` attribute for IdP Role Mapping.
    ![Role Mapping](common/HF-managesave.png)

## Step 6: Download SAML Signing Certificate

1. In the **SAML Signing Certificate** section, click the **Download** link next to **Certificate (Base64)**.
2. Save the Base64 version of the certificate and send it to Human Focus.
   ![Download Certificate](common/HF-samlcert.png)
3. If needed, edit the Notification Email Addresses section, change the notification
email, and click on Save.
   ![Notification Email](common/HF-signcert.png)

## Step 7: Provide Configuration Details

1. In the **Set up <app_name>** section, you will find important data such as:

    - Login URL
    - Microsoft Entra ID Identifier
    - Logout URL

2. Send this information to Human Focus.
   ![Configuration Details](common/HF-setup.png)
