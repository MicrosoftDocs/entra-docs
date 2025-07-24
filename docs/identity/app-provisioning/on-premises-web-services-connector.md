---
title: Microsoft Entra provisioning to applications via web services connector
description: This document describes how to configure Microsoft Entra ID to provision users with external systems that offer web services based APIs.

author: jenniferf-skc
manager: pmwongera
ms.service: entra-id
ms.subservice: app-provisioning
ms.topic: how-to
ms.date: 04/09/2025
ms.author: jenniferf-skc
ms.reviewer: arvinh
---


# Provisioning with the web services connector
The following documentation provides information about the generic web services connector. Microsoft Entra ID Governance supports provisioning accounts into various applications such as [SAP ECC](on-premises-sap-connector-configure.md), Oracle eBusiness Suite, and line of business applications that expose REST or SOAP APIs. Customers that have previously deployed MIM to connect to these applications can easily switch to using the lightweight Microsoft Entra provisioning agent, while reusing the same web services connector built for MIM.  

## Capabilities supported

> [!div class="checklist"]
> - Create users in your application.
> - Remove users in your application when they don't need access anymore.
> - Keep user attributes synchronized between Microsoft Entra ID and your application.
> - Discover the schema for your application.

The web services connector implements the following functions:

- SOAP Discovery: Allows the administrator to enter the WSDL path exposed by the target web service. Discovery produces a tree structure of the application's hosted web services with their inner  endpoints or operations along with the operation’s Meta data description. There's no limit to the number of discovery operations that can be done (step by step). The discovered operations  are used later to configure the flow of operations that implement the connector’s operations against the data-source (as Import/Export).

- REST Discovery: Allows the administrator to enter REST service details, including Service Endpoint, Resource Path, Method and Parameter details. The REST services information is stored in the ```discovery.xml``` file of the ```wsconfig``` project. They'll be used later by the administrator to configure the Rest Web Service activity in the workflow.

- Schema configuration: Allows the administrator to configure the schema. The schema configuration includes a listing of Object Types and attributes for a specific application. The administrator may choose the attributes are to be part of the schema.

- Operation Flow configuration: Workflow designer UI for configuring the implementation of import and export operations per object type through exposed web service operations functions, including the assignment of parameters from the user being provisioned to web service functions.

## Prerequisites for provisioning

### On-premises prerequisites

The computer that runs the provisioning agent should have:

- Connectivity to application's REST or SOAP endpoints, as well as with outbound connectivity to login.microsoftonline.com, [other Microsoft Online Services](/microsoft-365/enterprise/urls-and-ip-address-ranges) and [Azure](/azure/azure-portal/azure-portal-safelist-urls) domains. An example is a Windows Server 2016 virtual machine hosted in Azure IaaS or behind a proxy. 
- At least 3 GB of RAM, to host a provisioning agent. 
- .NET Framework 4.7.2 
- A Windows Server 2016 or a later version. 

Before configuring provisioning, ensure that you:
- Expose the necessary SOAP or REST APIs in your application to create, update and delete users.


### Cloud requirements

 - A Microsoft Entra tenant with Microsoft Entra ID P1 or Premium P2 (or EMS E3 or E5). 
 
    [!INCLUDE [active-directory-p1-license.md](~/includes/entra-p1-license.md)]
 - The Hybrid Identity Administrator role for configuring the provisioning agent and the Application Administrator or Cloud Application Administrator roles for configuring provisioning in the Azure portal.
 - The Microsoft Entra users to be provisioned to your application must already be populated with any attributes required by your application. 



## Install and configure the Microsoft Entra Connect Provisioning Agent

 1. Sign in to the Azure portal.
 2. Go to **Enterprise applications** and select **New application**.
 3. Search for the **On-premises ECMA app** application, give the app a name, and select **Create** to add it to your tenant.
 4. From the menu, navigate to the **Provisioning** page of your application.
 5. Select **Get started**.
 6. On the **Provisioning** page, change the mode to **Automatic**.

 :::image type="content" source="~/includes/media/app-provisioning-sql/configure-7.png" alt-text="Screenshot of selecting Automatic." lightbox="~/includes/media/app-provisioning-sql/configure-7.png":::

 7. Under **On-premises Connectivity**, select **Download and install**, and select **Accept terms & download**.
 
 8. Leave the portal and run the provisioning agent installer, agree to the terms of service, and select **Install**.
 9. Wait for the Microsoft Entra provisioning agent configuration wizard and then select **Next**.
 10. In the **Select Extension** step, select **On-premises application provisioning** and then select **Next**.
 11. The provisioning agent uses the operating system's web browser to display a popup window for you to authenticate to Microsoft Entra ID, and potentially also your organization's identity provider. If you're using Internet Explorer as the browser on Windows Server, then you may need to add Microsoft web sites to your browser's trusted site list to allow JavaScript to run correctly.
 12. Provide credentials for a Microsoft Entra administrator when you're prompted to authorize. The user is required to have at least the [Hybrid Identity Administrator](/entra/identity/role-based-access-control/permissions-reference#hybrid-identity-administrator) role.
 13. Select **Confirm** to confirm the setting. Once installation is successful, you can select **Exit**, and also close the Provisioning Agent Package installer.

## Configure the On-premises ECMA app

 1. In the portal, on the **On-Premises Connectivity** section, select the agent that you deployed and select **Assign Agent(s)**.

      ![Screenshot that shows how to select and assign an agent.](~/includes/media/app-provisioning-sql/configure-7a.png)

 2. Keep this browser window open, as you complete the next step of configuration using the configuration wizard.

## Configure the Microsoft Entra ECMA Connector Host certificate

 1. On the Windows Server where the provisioning agent is installed, right select the **Microsoft ECMA2Host Configuration Wizard** from the start menu, and run as administrator.  Running as a Windows administrator is necessary for the wizard to create the necessary Windows event logs.
 
 1. After the ECMA Connector Host Configuration starts, if it's the first time you've run the wizard, it asks you to create a certificate. Leave the default port **8585** and select **Generate certificate** to generate a certificate. The autogenerated certificate is self-signed as part of the trusted root. The certificate SAN matches the host name.

     [![Screenshot that shows configuring your settings.](~/includes/media/app-provisioning-sql\configure-1.png)](~/includes/media/app-provisioning-sql\configure-1.png#lightbox)

 3. Select **Save**.

## Create a web services connector template

Before creating the web services connector configuration, you need to create a web services connector template and customize the template to meet the needs of your specific environment. Make sure that the ServiceName, EndpointName, and the OperationName are correct.

You can find example templates and guidance on how to integrate with popular applications such as [SAP ECC 7.0](on-premises-sap-connector-configure.md) and Oracle eBusiness Suite in the [connectors download package](https://www.microsoft.com/download/details.aspx?id=51495).  You can learn how to create a new project for your data source in the Web Service Configuration Tool using the [workflow guide for SOAP](/microsoft-identity-manager/reference/microsoft-identity-manager-2016-ma-ws-soap).

For more information on how to configure a template to connect to your own application's REST or SOAP API, see [the Overview of the generic Web Service connector](/microsoft-identity-manager/reference/microsoft-identity-manager-2016-ma-ws) in the MIM documentation library.

## Configure the generic web services connector

In this section, you'll create the connector configuration for your application.

### Connect the provisioning agent to your application

To connect the Microsoft Entra provisioning agent with your application, follow these steps:

1. Copy your web service connector template `.wsconfig` file into the `C:\Program Files\Microsoft ECMA2Host\Service\ECMA` folder.
1. Generate a secret token that is used for authenticating Microsoft Entra ID to the connector. It should be 12 characters minimum and unique for each application.
1. If you haven't already done so, launch the **Microsoft ECMA2Host Configuration Wizard** from the Windows Start menu.

1. Select **New Connector**.

     [![Screenshot that shows choosing New Connector.](~/includes/media/app-provisioning-sql\sql-3.png)](~/includes/media/app-provisioning-sql\sql-3.png#lightbox)

1. On the **Properties** page, fill in the boxes with the values specified in the table that follows the image and select **Next**.

     [![Screenshot that shows entering properties.](~/includes/media/app-provisioning-SAP\sap-properties-1.png)](~/includes/media/app-provisioning-SAP\sap-properties-1.png#lightbox)

     |Property|Value|
     |-----|-----|
     |Name|The name you chose for the connector, which should be unique across all connectors in your environment. |
     |Autosync timer (minutes)|120|
     |Secret Token|Enter the secret token you generated for this connector. The key should be 12 characters minimum.|
     |Extension DLL|For the web services connector, select **Microsoft.IdentityManagement.MA.WebServices.dll**.|

1. On the **Connectivity** page, fill in the boxes with the values specified in the table that follows the image and select **Next**.

     [![Screenshot that shows the Connectivity page.](~/includes/media/app-provisioning-SAP\sap-connectivity-1.png)](~/includes/media/app-provisioning-SAP\sap-connectivity-1.png#lightbox)
     
     |Property|Description|
     |-----|-----|
     |Web Service Project |Your web services template name.|
     |Host|Your application's SOAP endpoint host name, such as vhcalnplci.dummy.nodomain|
     |Port|Your application's SOAP endpoint port, such as 8000|


1. On the **Capabilities** page, fill in the boxes with the values specified in the following table and select **Next**.

    | Property | Value |
    | --- | --- |
    | Distinguished Name Style | Generic |
    | Export Type | ObjectReplace |
    | Data Normalization | None |
    | Object Confirmation | Normal |
    | Enable Import | Checked |
    | Enabled Delta Import | Unchecked |
    | Enable Export | Checked |
    | Enable Full Export | Unchecked |
    | Enable Export Password in the First Pass | Checked |
    | No Reference Values in First Export Pass | Unchecked |
    | Enable Object Rename | Unchecked |
    | Delete-Add as Replace | Unchecked |

>[!NOTE]
>If your web services connector template is opened for editing in the Web Service Configuration Tool, you'll get an error.

8. On the **Global** page, fill in the boxes, and select **Next**.

1. On the **Partitions** page, select **Next**.

1. On the **Run Profiles** page, keep the **Export** checkbox selected. Select the **Full import** checkbox and select **Next**. The **Export** run profile is used when the ECMA Connector host needs to send changes from Microsoft Entra ID to your application to insert, update and delete records. The **Full Import** run profile is used when the ECMA Connector host service starts, to read in the current content of your application.

    
    | Property | Value |
    | --- | --- |
    | Export | Run profile that export data to your application This run profile is required. |
    | Full import | Run profile that import all data from your application. |
    | Delta import | Run profile that import only changes from your application since the last full or delta import. |

1. On the **Object Types** page, fill in the boxes and select **Next**. Use the table that follows the image for guidance on the individual boxes.

    - **Anchor** : The values of this attribute should be unique for each object in the target system. The Microsoft Entra provisioning service queries the ECMA connector host by using this attribute after the initial cycle. This value is defined in the web services connector template.
    - **DN** : The Autogenerated option should be selected in most cases. If it isn't selected, ensure that the DN attribute is mapped to an attribute in Microsoft Entra ID that stores the DN in this format: CN = anchorValue, Object = objectType. For more information on anchors and the DN, see [About anchor attributes and distinguished names](/azure/active-directory/app-provisioning/on-premises-application-provisioning-architecture#about-anchor-attributes-and-distinguished-names).

     
        | Property | Value |
        | --- | --- |
        | Target object | User |
        | Anchor | userName |
        | DN | userName |
        | Autogenerated | Checked |
   

 1. The ECMA connector host discovers the attributes supported by your application. You can then choose which of the discovered attributes you want to expose to Microsoft Entra ID. These attributes can then be configured in the Azure portal for provisioning. On the **Select Attributes** page, add all the attributes in the dropdown list one at a time. The **Attribute** dropdown list shows any attribute that was discovered in your application and *wasn't* chosen on the previous **Select Attributes** page. Once all the relevant attributes are added, select **Next**.
 
 
     [![Screenshot that shows the Select Attributes page.](~/includes/media/app-provisioning-SAP\sap-select-attributes-1.png)](~/includes/media/app-provisioning-SAP\sap-select-attributes-1.png#lightbox)

 13. On the **Deprovisioning** page, under **Disable flow**, select **Delete**. The attributes selected on the previous page won't be available to select on the Deprovisioning page. Select **Finish**.
 >[!NOTE]
 >If you use the **Set attribute value** be aware that only boolean values are allowed.

 On the **Deprovisioning** page, under Disable flow, select None if you'll control user account status with a property such as **expirationTime**. Under Delete flow, select None if you don't want to delete users from your application or Delete if you do. Select **Finish**.
     

## Ensure the ECMA2Host service is running

 1. On the server running the Microsoft Entra ECMA Connector Host, select **Start**.
 2. Enter **run** and enter **services.msc** in the box.
 3. In the **Services** list, ensure that **Microsoft ECMA2Host** is present and running. If not, select **Start**.

     [![Screenshot that shows the service is running.](~/includes/media/app-provisioning-sql\configure-2.png)](~/includes/media/app-provisioning-sql\configure-2.png#lightbox)



 1. If you've recently started the service, and have many user objects in your application, then wait several minutes for the connector to establish a connection with your application and perform the initial full import.

## Configure the application connection in the Azure portal

1. Return to the web browser window where you were configuring the application provisioning.

    >[!NOTE]
    >If the window had timed out, then you'll need to re-select the agent.

     1. Sign in to the Azure portal.
     1. Go to **Enterprise applications** and the **On-premises ECMA app** application.
     1. Select **Provisioning**.
     1. Select **Get started** and then change the mode to **Automatic**,  on the **On-Premises Connectivity** section, select the agent that you deployed and select **Assign Agent(s)**. Otherwise go to **Edit Provisioning**.

 1. Under the **Admin credentials** section, enter the following URL. Replace the `{connectorName}` portion with the name of the connector on the ECMA connector host. The connector name is case sensitive and should be the same case as was configured in the wizard. You can also replace `localhost` with your machine hostname.

    |Property|Value|
    |-----|-----|
    |Tenant URL| `https://localhost:8585/ecma2host_APP1/scim`|

 5. Enter the **Secret Token** value that you defined when you created the connector.
     >[!NOTE]
     >If you just assigned the agent to the application, please wait 10 minutes for the registration to complete. The connectivity test won't work until the registration completes. Forcing the agent registration to complete by restarting the provisioning agent on your server can speed up the registration process. Go to your server, search for **services** in the Windows search bar, identify the **Microsoft Entra Connect Provisioning Agent Service**, right-select the service, and restart.
 1. Select **Test Connection**, and wait one minute.

 1. After the connection test is successful and indicates that the supplied credentials are authorized to enable provisioning, select **Save**.

     ![Screenshot that shows testing an agent.](~/includes/media/app-provisioning-sql\configure-9.png)

## Configure attribute mappings

Now you'll map attributes between the representation of the user in Microsoft Entra ID and the representation of the user in your application.

You'll use the Azure portal to configure the mapping between the Microsoft Entra user's attributes and the attributes that you previously selected in the ECMA Host configuration wizard.

 1. Ensure that the Microsoft Entra schema includes the attributes that are required by your application. If it requires users to have an attribute, and that attribute is not already part of your Microsoft Entra schema for a user, then you'll need to use the [directory extension feature](~/identity/app-provisioning/user-provisioning-sync-attributes-for-mapping.md) to add that attribute as an extension.
 1. In the Microsoft Entra admin center, under **Enterprise applications**, select the **On-premises ECMA app** application, and then the **Provisioning** page.
 1. Select **Edit provisioning**, and wait 10 seconds.
 1. Expand **Mappings** and select **Provision Microsoft Entra users**. If this is the first time you've configured the attribute mappings for this application, there will be only one mapping present, for a placeholder.


     ![Screenshot that shows provisioning a user.](~/includes/media\app-provisioning-sql\configure-10.png)

 5. To confirm that the schema of your application is available in Microsoft Entra ID, select the **Show advanced options** checkbox and select **Edit attribute list for ScimOnPremises**. Ensure that all the attributes selected in the configuration wizard are listed.  If not, then wait several minutes for the schema to refresh, and then reload the page.  Once you see the attributes listed, then cancel from this page to return to the mappings list.
 6. Now, select on the **userPrincipalName** PLACEHOLDER mapping.  This mapping is added by default when you first configure on-premises provisioning.  
 
:::image type="content" source="~/includes/media/app-provisioning-sql/configure-11.png" alt-text="Screenshot of placeholder." lightbox="~/includes/media/app-provisioning-sql/configure-11.png":::

 Change the value to match the following:
 
 |Mapping type|Source attribute|Target attribute|
 |-----|-----|-----|
 |Direct|userPrincipalName|urn:ietf:params:scim:schemas:extension:ECMA2Host:2.0:User:userName|
 

 7. Now select **Add New Mapping**, and repeat the next step for each mapping.
 

 8. Specify the source and target attributes for each of the attributes your application requires.  For example,

     
    | Microsoft Entra Attribute | ScimOnPremises Attribute | Matching precedence | Apply this mapping |
    | --- | --- | --- | --- |
    | ToUpper(Word([userPrincipalName], 1, "@"), ) | urn:ietf:params:scim:schemas:extension:ECMA2Host:2.0:User:userName | 1 | Only during object creation |
    | Redact("Pass@w0rd1") | urn:ietf:params:scim:schemas:extension:ECMA2Host:2.0:User:export\_password|| Only during object creation |
    | city | urn:ietf:params:scim:schemas:extension:ECMA2Host:2.0:User:city || Always |
    | companyName | urn:ietf:params:scim:schemas:extension:ECMA2Host:2.0:User:company || Always |
    | department | urn:ietf:params:scim:schemas:extension:ECMA2Host:2.0:User:department || Always |
    | mail | urn:ietf:params:scim:schemas:extension:ECMA2Host:2.0:User:email || Always |
    | Switch([IsSoftDeleted], , "False", "9999-12-31", "True", "1990-01-01") | urn:ietf:params:scim:schemas:extension:ECMA2Host:2.0:User:expirationTime || Always |
    | givenName | urn:ietf:params:scim:schemas:extension:ECMA2Host:2.0:User:firstName || Always |
    | surname | urn:ietf:params:scim:schemas:extension:ECMA2Host:2.0:User:lastName || Always |
    | telephoneNumber | urn:ietf:params:scim:schemas:extension:ECMA2Host:2.0:User:telephoneNumber ||Always |
    | jobTitle | urn:ietf:params:scim:schemas:extension:ECMA2Host:2.0:User:jobTitle || Always |

 
 9. Once all of the mappings are added, select **Save**.

## Assign users to the application

Now that you've the Microsoft Entra ECMA Connector Host talking with Microsoft Entra ID, and the attribute mapping configured, you can move on to configuring who's in scope for provisioning.

>[!IMPORTANT]
>If you were signed in using a Hybrid Identity Administrator role, you need to sign-out and sign-in with an account that has at least the Application Administrator role for this section. The Hybrid Identity Administrator role doesn't have permissions to assign users to applications.


If there are existing users in your application, then you should create application role assignments for those existing users. To learn more about how to create application role assignments in bulk, see [governing an application's existing users in Microsoft Entra ID](~/id-governance/identity-governance-applications-existing-users.md).

Otherwise, if there are no current users of the application, then select a test user from Microsoft Entra who will be provisioned to the application.

 1. Ensure that the user you select has all the properties to be mapped to the required attributes of your application.
 1. In the Azure portal, select **Enterprise applications**.
 2. Select the **On-premises ECMA app** application.
 3. On the left, under **Manage**, select **Users and groups**.
 4. Select **Add user/group**.

     [![Screenshot that shows adding a user.](~/includes/media/app-provisioning-sql\app-2.png)](~/includes/media/app-provisioning-sql\app-2.png#lightbox)

5. Under **Users**, select **None Selected**.

     [![Screenshot that shows None Selected.](~/includes/media/app-provisioning-sql\app-3.png)](~/includes/media/app-provisioning-sql\app-3.png#lightbox)

 6. Select users from the right and select the **Select** button.
 
     ![Screenshot that shows Select users.](~/includes/media/app-provisioning-sql\app-4.png)

 7. Now select **Assign**.

     [![Screenshot that shows Assign users.](~/includes/media/app-provisioning-sql\app-5.png)](~/includes/media/app-provisioning-sql\app-5.png#lightbox)
     
## Test provisioning

Now that your attributes are mapped and users are assigned, you can test on-demand provisioning with one of your users.
 
 1. In the Azure portal, select **Enterprise applications**.
 2. Select the **On-premises ECMA app** application.
 3. On the left, select **Provisioning**.
 4. Select **Provision on demand**.
 5. Search for one of your test users, and select **Provision**.

     ![Screenshot that shows testing provisioning.](~/includes/media/app-provisioning-sql\configure-13.png)

 6. After several seconds, then the message **Successfully created user in target system** appears, with a list of the user attributes.

## Start provisioning users

1. After on-demand provisioning is successful, return to the provisioning configuration page. Ensure that the scope is set to only assigned users and groups, turn provisioning **On**, and select **Save**.
 
    [![Screenshot that shows Start provisioning.](~/includes/media/app-provisioning-sql\configure-14.png)](~/includes/media/app-provisioning-sql\configure-14.png#lightbox)

2. Wait up to 40 minutes for the provisioning service to start. After the provisioning job has been completed, as described in the next section, if you're done testing, you can change the provisioning status to **Off**, and select **Save**. This action stops the provisioning service from running in the future.

## Troubleshooting provisioning errors

If an error is shown, then select **View provisioning logs**. Look in the log for a row in which the Status is **Failure**, and select on that row.

For more information, change to the **Troubleshooting & Recommendations** tab.


## Next steps

- [App provisioning](user-provisioning.md)
- [ECMA Connector Host generic SQL connector](tutorial-ecma-sql-connector.md)
- [ECMA Connector Host LDAP connector](on-premises-ldap-connector-configure.md)
