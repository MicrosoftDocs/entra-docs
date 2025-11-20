---
title: Microsoft Entra SAP IAG integration
description: #Required; Keep the description within 100- and 165-characters including spaces.
author: owinfreyATL
ms.author: owinfrey
ms.service: entra-id-governance
ms.subservice: entitlement-management
ms.topic: how-to #Required; leave this attribute/value as-is
ms.date: 11/20/2025

#CustomerIntent: As an IT administrator I want to integrate SAP IAG with Microsoft Entra to expand the capabilities of both solutions.
---

# Microsoft Entra SAP IAG integration


## License requirements

[!INCLUDE [Microsoft Entra ID Governance license](../includes/entra-entra-governance-license.md)]

## Prerequisites 

To utilize the Microsoft Entra Entitlement Management Integration with SAP IAG, customers must satisfy the following prerequisites:

Microsoft Azure Subscription with a Microsoft Azure Key Vault instance: 
- User account with at least **Key Vault Data Access Administrator** and **Key Vault Secrets Officer** to the appropriate Key Vault resource
- If you need to create a Key Vault Instance, see: [Quickstart: Create a key vault using the Azure portal](/azure/key-vault/general/quick-create-portal)
- To create a secret to store your SAP IAG Client Secret, see: [Quickstart: Set and retrieve a secret from Azure Key Vault using the Azure portal](/azure/key-vault/secrets/quick-create-portal). You need a user with Key Vault Secrets Officer role or appropriate Key Vault policy.


SAP Cloud Identity Services instance that is already integrated with Microsoft Entra for:
- User Provisioning: See, [Configure SAP Cloud Identity Services for automatic user provisioning with Microsoft Entra ID](../identity/saas-apps/sap-cloud-platform-identity-authentication-provisioning-tutorial.md)
- In your attribute mapping, make sure Microsoft Entra ObjectId is mapped for username as follows:
    - Select *EDIT* in the username line and make sure the Source and Target attribute as defined:
    - Source Attribute: objectId
    - Target Attribute: userName
    :::image type="content" source="media/entitlement-management-sap-integration/attribute-mapping.png" alt-text="Screenshot of attribute mapping for SAP integration.":::
    - For a better user experience, also add a mapping for the manager attribute. This allows manager information to be synchronized from Microsoft Entra to SAP cloud Identity Services.
    :::image type="content" source="media/entitlement-management-sap-integration/manager-attribute.png" alt-text="Screenshot of setting manager attribute for SAP integration.":::
- User Single Sign-On (Optional): See, [Configure SAP Cloud Identity Services for Single sign-on with Microsoft Entra ID](../identity/saas-apps/sap-hana-cloud-platform-identity-authentication-tutorial.md)


SAP Cloud Identity and Access Governance (IAG) tenant license:

- You will need support from the SAP BTP administrator to complete the requirements
- The Microsoft Entra User Account configuring the connector and Access Packages must be synced to SAP Cloud Identity Services (IAS) and SAP IAG, and must be a member of IAG_SUPER_ADMIN group and have CIAG_Super_Admin role in SAP BTP to add SAP IAG Access Rights as Resource in Microsoft Entra Entitlement Management
    - Make sure you run the “Repository Sync” and “SCI User Group Sync Job” on SAP IAG after you provision the Microsoft Entra users to SAP Cloud Identity Services.
-  SAP IAG with pre-requisites detailed in the instructions following instructions


## Prepare your SAP Identity Access Governance instance to connect with Microsoft Entra

To synchronize user-group and attribute data from your SAP Cloud Identity tenant into the [SAP Cloud Identity Access Governance (IAG)](https://help.sap.com/docs/SAP_CLOUD_IDENTITY_ACCESS_GOVERNANCE?state=DRAFT), complete these steps:

### 1. Register IAG Sync system administrator

1. In your SAP Cloud Identity tenant, open **Administrators > + Add > Add System**.
1.  Name it **IAG Sync** and assign the provisioning roles (Manage Users, Manage Groups, Proxy System API, Real-Time Provisioning API, Identity Provisioning Tenant Admin API)
:::image type="content" source="media/entitlement-management-sap-integration/sync-tool.png" alt-text="Screenshot of the SAP Cloud IAG sync tool.":::
1. Under **Configure System Authentication > Certificate**, generate a certificate and save it. You can either keep the downloaded certificate p12 file and the password for the certificate, or  you can upload a .p12 certificate.
:::image type="content" source="media/entitlement-management-sap-integration/generate-sap-certificate.png" alt-text="Screenshot of uploading a p12 certificate in SAP.":::


### 2. Create the BTP HTTP destination

1. In your SAP BTP subaccount, navigate to Connectivity > Destination Certificates > Create and use Generation method ‘Import’. Upload the p12 certificate file from the previous step
1. In your SAP BTP subaccount, navigate to Connectivity > Destinations > New Destination > From Scratch.
1. Set Name to SAP_Identity_Services_Identity_Directory, Type to HTTP, URL to 
https://<SCI_TENANT_ID>.accounts.ondemand.com, Proxy Type to Internet and 
Authentication to ClientCertificate.
1. Configure Authentication using your Client ID/Secret or certificate you created and uploaded in 
the first step. Set Store Source as ‘DestinationService’, Key Store location select the certificate 
from the drop down list and should be same as uploaded in Destination Certificates
1. Add the following properties:
    - Accept = application/scim+json
    - GROUPSURL = /Groups
    - USERSURL = /Users
    - serviceURL = /scim
    :::image type="content" source="media/entitlement-management-sap-integration/sap-destination.png" alt-text="Screenshot of setting SAP HTTP destination.":::

### 3. Point IAG at the destination

In IAG’s [Configuration app](https://help.sap.com/http.svc/login?time=1763658868990&url=%2Fdocs%2FSAP_CLOUD_IDENTITY_ACCESS_GOVERNANCE%c%2F8c45d577632044e9b31f65faf4a7be7c.html%3Fversion%3DCLOUDFOUNDRY), select Application Parameters, locate **UserSource > SourceSystem**, select edit and enter *SAP_Identity_Services_Identity_Directory*.

### 4. Execute the SCI User Group Sync job

1. Open Job Scheduler in IAG, select Schedule Job, select SCI User Group Sync, choose *Start Immediately* (or set a recurrence), and confirm.
1. Track execution and logs in **Job History**.

### 5. Create IPS_PROXY destination in BTP subaccount

**Prerequisite**: Administrator user is created in IAS and user and P/W are available. 
1. Create IPS_Proxy destination in BTP subaccount. Navigate to Destination -> Create -> From Scratch and add the following details:
    - Name – IPS_PROXY
    - Authentication – BasicAuthentication
    - Type – HTTP
    - User – Client ID of the administrator user in IAS (user IAG Sync created in Step 1)
    - Password – User P/W of IAS administrator user
    - Description – IPS Destination
    - Proxy Type – Internet
    - URL – Use the IPS URL - https://<YOUR_IPS_TENANT>>. 
    <<DOMAIN>>.hana.ondemand.com
    - Additional Properties: 
        1. Accept - application/scim+json
        1. ServiceURL - /ipsproxy/service/api/v1/scim/
        1. USERSURL - /Users
        1. GROUPSURL - /Groups

### 6. Create application in IAG

**Prerequisite**: IPS Proxy systems are created in Cloud Identity Services.

Go to IAG -> Application -> + to create -> Add description.

For more comprehensive instructions, including detailed role assignments, destination configurations, and 
scheduling options, see SAP documentation: [Syncing User Groups from SAP Identity Services into IAG](https://help.sap.com/docs/SAP_CLOUD_IDENTITY_ACCESS_GOVERNANCE/e12d8683adfa4471ac4edd40809b9038/de385218e7f94ce9ad62b1c3488413dd.html?version=CLOUDFOUNDRY).



## Connect your SAP IAG instance in Microsoft Entra

**Prerequisite: You will need an Azure Subscription and an Azure Key Vault to store your SAP IAG information.**

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Identity Governance Administrator](../identity/role-based-access-control/permissions-reference.md#identity-governance-administrator).

1. Browse to **ID Governance** > **Entitlement management** > **Control configurations**. 

1.  On the Control Configurations page, there will be a Manage External Connectors card. Select **View Connectors**.
    :::image type="content" source="media/entitlement-management-sap-integration/external-connectors.png" alt-text="Screenshot of external connectors card in entitlement management.":::
1. On the Connectors page, select **New connector**.

1. In the New Connector context, select **SAP IAG** from the drop down list.
    :::image type="content" source="media/entitlement-management-sap-integration/sap-connector.png" alt-text="Screenshot of the sap connector selection screen.":::
1.  After you select SAP IAG, you will see the option to fill out the following fields: Name, Description, Subscription, Resource Group, Key Vault Name, Secret Key, Client ID, Access Token URL, Scope, Endpoint URL, and Domain.

To fill out the fields for the SAP IAG connector, you must work with your SAP BTP Tenant administrator to get the following information:


|Field  |Description  |Provided by  |
|---------|---------|---------|
|Type     |   Default: IAG      |   Microsoft Entra      |
|Name     |   Custom      |   Customer      |
|Description     |    Customer     |    Customer     |
|SubscriptionID     |   Select your Azure Subscription ID where Azure Key Vault resource is located.|    Customer     |
|Key Vault Name     |   Select your Azure Key Vault.      |    Customer. IT Admin must select the drop-box and select the correct Azure Key Vault Resource where IAG secret is stored.    |
|Secret Name     |   Select your Secret      |    Customer. Copy the clientsecret parameter from you SAP IAG service credentials and add it to your Key Vault as a new secret. Then select the Secret Name value to this field. Customer needs to create a Key Vault unless they already have one, in which case they simply create a [new secret key](/azure/key-vault/secrets/quick-create-portal).  |
|Client ID     |   Client identifier      | Customer obtains from SAP BTP. When SAP IAG service is subscribed, this will come with service Key and can be viewed by tenant admin only, using SAP BTP Cockpit.Go to BTP Cockpit, Instances and Subscriptions and locate your SAP IAG Service instance (Service Technical Name: grc-iag-api), then select View Credentials, and copy the ClientID value. |
|SAP IAG Access token URL   |   Base url for generating an authentication token to call SAP IAG services.      | Customer obtains from SAP BTP. When service is subscribed, a service key is generated along with endpoint URL as well. This information can be found in BTP subaccount. It’s only visible by SAP BTP tenant admin. Go to BTP Cockpit, Instances and Subscriptions and locate your SAP IAG Service instance (Service Technical Name: grc-iag-api), then select View Credentials, and copy the URL value. Copy the URL paramater and add the suffix “/oauth/token” before adding it to the New Connector.|
|IAG URL    |   Base URL of all services exposed by SAP IAG (for eg. To fetch roles or to check status of role assignments)| Customer obtains from SAP BTP. When service is subscribed, a service key is generated along with endpoint URL as well. This information can be found in BTP subaccount. It’s only visible by SAP BTP tenant admin. Go to BTP Cockpit, Instances and Subscriptions and locate your SAP IAG Service instance (Service Technical Name: grc-iag-api), then select View Credentials, and copy the ARQAPI value. |



After this information is entered, select **Create** to create the connector. Catalog Administrators are now able to add SAP business roles from your SAP IAG instance to Entitlement Management catalogs and access packages.

## Set up catalog and access package with SAP business role

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Identity Governance Administrator](../identity/role-based-access-control/permissions-reference.md#identity-governance-administrator).

1. Browse to **ID Governance** > **Entitlement management** > **Catalogs**. 

1. [Create a new catalog](entitlement-management-catalog-create.md)

1. Once the catalog is created, go to its **Resource** section and select **Add resources**

1.  Select the SAP IAG button to open a context pane where you can select the SAP IAG instance you want to include in this catalog as a resource. In the dropdown, select the SAP IAG instance you connected. 
    :::image type="content" source="media/entitlement-management-sap-integration/sap-resource.png" alt-text="Screenshot of adding SAP IAG as a resource to catalog.":::
1. Once you’ve added the SAP IAG instance to your catalog, go to the Access packages tab within the catalog and select the New access package button. In the Resource roles tab, select on SAP IAG. Here, you are able to select the SAP IAG Access Rights

1. In the resources table, you can select the specific business roles you want to include in the access package and select **Next**. 
    :::image type="content" source="media/entitlement-management-sap-integration/sap-resource-roles.png" alt-text="Screenshot of setting role for an SAP IAG resource.":::
1. On the Requests tab, you create the first policy to specify who can request the access package. You also configure approval settings for that policy.
    1. Select “**For Users, service principals, and agent identities in your Directory**”
    1. Select “**Specific Users and Groups**” to limit the usage of this access package only to users participating in the Private Preview. We recommend you create a new Microsoft Entra Group for it.
    1. Define Approval setting as desired
    1. Make sure “self” is selected within **Who can request access**.
    1. Select **Next: Requestor Information**
1.  On Requestor Information Tab, select **Next: Lifecycle**  

1.  On Lifecycle Tab, enter the number of days you want to grant access, make sure **Require Access Review** is unselected, and select **Next: Rules**.

1. Select **Create** to finish setting up the access package with your settings. For more details on creating an access package, see: [Create an access package in entitlement management](entitlement-management-access-package-create.md).


## Testing Integration
Once configuring the new SAP IAG Connector, IT admins can follow these steps for an end-to-end test scenario:
1. Create a new SAP IAG Business Role 
1. Create a new Access Package to grant access to the new SAP IAG Business Role
1. As a user, request the new access package
    1. For information on how to request an access package, see: [Request access to an access package in entitlement management](entitlement-management-request-access.md).    
1. Verify the role has been assigned in SAP IAG, make the necessary approvals.

## Next steps

- [Approve or deny access requests - entitlement management](entitlement-management-request-approve.md)
- [Request process and email notifications](entitlement-management-process.md)

