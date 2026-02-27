---
title: Configure Bpanda for automatic user provisioning with Microsoft Entra ID
description: Learn how to automatically provision and de-provision user accounts from Microsoft Entra ID to Bpanda.


author: jeevansd
manager: pmwongera

ms.topic: how-to
ms.date: 02/27/2026
ms.author: jeedes

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Bpanda so that I can streamline the user management process and ensure that users have the appropriate access to Bpanda.
---

# Configure Bpanda for automatic user provisioning with Microsoft Entra ID

This article describes the steps you need to perform in both Bpanda and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and de-provisions users and groups to [Bpanda](http://www.mid.de) using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md). 


## Capabilities Supported
> [!div class="checklist"]
> * Create users in Bpanda
> * Remove users in Bpanda when they don't require access anymore
> * Keep user attributes synchronized between Microsoft Entra ID and Bpanda
> * Provision groups and group memberships in Bpanda
> * Single sign-on to Bpanda (recommended)

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* A cloud subscription process space in Bpanda. For on-premises, see our installation documentation.

## Step 1: Plan your provisioning deployment
1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
2. Determine who's in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
3. Determine what data to [map between Microsoft Entra ID and Bpanda](~/identity/app-provisioning/customize-application-attributes.md). 

<a name='step-2-configure-bpanda-to-support-provisioning-with-azure-ad'></a>

## Step 2: Configure Bpanda to support provisioning with Microsoft Entra ID
1. Reach out to support@mid.de for more information on your authentication Tenant URL.

2. A client secret for further generating access tokens. This secret must have been transmitted to you in a secure way. Reach out to support@mid.de for more information.

3. For establishing a successful connection between Microsoft Entra ID and Bpanda, an access token must be retrieved in either of the following ways.

* Use this command in **Linux**
```
curl -u scim:{Your client secret} --location --request POST '{Your tenant specific authentication endpoint}/protocol/openid-connect/token' \
--header 'Content-Type: application/x-www-form-urlencoded' \
--data-urlencode 'grant_type=client_credentials'
```

* or this command in **PowerShell**

``` 
$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("scim:{0}" -f {Your client secret})))    
$headers=@{}   
$headers.Add("Content-Type", "application/x-www-form-urlencoded")  
$headers.Add("Authorization", "Basic {0}" -f $base64AuthInfo)  
$response = Invoke-WebRequest -Uri "{Your tenant specific authentication endpoint}/protocol/openid-connect/token" -Method POST -Headers $headers -ContentType 'application/x-www-form-urlencoded' -Body 'grant_type=client_credentials' 
```

This value is entered in the **Secret Token** field in the Provisioning tab of your Bpanda application.


<a name='step-3-add-bpanda-from-the-azure-ad-application-gallery'></a>

## Step 3: Add Bpanda from the Microsoft Entra application gallery

Add Bpanda from the Microsoft Entra application gallery to start managing provisioning to Bpanda. If you have previously setup Bpanda for SSO, you can use the same application. However, we recommend that you create a separate app when testing out the integration initially. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md). 

## Step 4: Define who is in scope for provisioning 

[!INCLUDE [create-assign-users-provisioning.md](~/identity/saas-apps/includes/create-assign-users-provisioning.md)]

## Step 5: Configure automatic user provisioning to Bpanda 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in TestApp based on user and/or group assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-bpanda-in-azure-ad'></a>

### To configure automatic user provisioning for Bpanda in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Enterprise applications blade](common/enterprise-applications.png)

1. In the applications list, select **Bpanda**.

	![The Bpanda link in the Applications list](common/all-applications.png)

3. Select the **Provisioning** tab.

	![Provisioning tab](common/provisioning.png)

1. Set **+ New configuration**.

	![Screenshot of Provisioning tab automatic.](common/application-provisioning.png)

1. In the **Tenant URL** field, input your Bpanda Tenant URL and Secret Token. Select **Test Connection** to ensure Microsoft Entra ID can connect to Bpanda. If the connection fails, ensure your Bpanda account has the required admin permissions and try again.

   ![Screenshot of Provisioning test connection.](common/provisioning-test-connection.png)

1. Select **Create** to create your configuration.	

1. Select **Properties** in the **Overview** page. 

1. Select the pencil to edit the properties. Enable notification emails and provide an email to receive quarantine emails. Enable accidental deletions prevention. Select **Apply** to save the changes.

   ![Screenshot of Provisioning properties.](common/provisioning-properties.png)

1. Select **Attribute Mapping** in the left panel and select users.

9. Review the user attributes that are synchronized from Microsoft Entra ID to Bpanda in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in Bpanda for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the Bpanda API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported for Filtering|
   |---|---|---|
   |userName|String|&check;|
   |active|Boolean||
   |displayName|String||
   |emails[type eq "work"].value|String||
   |name.givenName|String||
   |name.familyName|String||
   |phoneNumbers[type eq "work"].value|String||
   |phoneNumbers[type eq "mobile"].value|String||
   |externalId|String||
   |title|String||
   |preferredLanguage|String||
   |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:department|String||
   |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:division|String||
   |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:organization|String||


10. Select **Groups**.

11. Review the group attributes that are synchronized from Microsoft Entra ID to Bpanda in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the groups in Bpanda for update operations. Select the **Save** button to commit any changes.

      |Attribute|Type|Supported for Filtering|
      |---|---|---|
      |displayName|String|&check;|
      |externalId|String||
      |members|Reference||

1. To configure scoping filters, refer to the following instructions provided in the [Scoping filter article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md) article.

1. Use [on-demand provisioning](~/identity/app-provisioning/provision-on-demand.md) to validate sync with a small number of users before deploying more broadly in your organization.  

1. When you're ready to provision, select **Start Provisioning** from the **Overview** page.

## Step 6: Monitor your deployment

[!INCLUDE [monitor-deployment.md](~/identity/saas-apps/includes/monitor-deployment.md)]

## Additional resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)
