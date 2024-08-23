---
title: 'Deploy SAP NetWeaver AS ABAP 7'
description: This article describes how to set up a lab environment with SAP ECC for testing.
services: active-directory
documentationcenter: ''
author: billmath
manager: amycolannino
editor: ''
ms.service: active-directory
ms.topic: conceptual
ms.date: 07/28/2023
ms.author: billmath
---

# Deploy SAP NetWeaver AS ABAP 7.51
This document guides you in setting up a lab environment with SAP ECC for testing.

## Deploying SAP NetWeaver AS ABAP 7.51 on ASE test environment from the SAP Cloud Appliance Library 

 1. Navigate to the SAP Cloud Appliance Library: https://cal.sap.com/. 
 2. Create an account for yourself in the SAP CAL and log in to the SAP Cloud Appliance Library. https://calstatic.hana.ondemand.com/res/docEN/042bb15ad2324c3c9b7974dbde389640.html 
 3. Navigate to the [Appliance Templates - SAP Cloud Appliance Library](https://cal.sap.com/console/tenant_QMOV0I8VZP4H#/applianceTemplates) page 
 4. Search for the **7.51** appliance template and click the Create Appliance button to create a **SAP NetWeaver AS ABAP 7.51 SP02 on ASE** appliance. 
 
:::image type="content" source="media/deploy-sap-netweaver/sap-1.png" alt-text="Screenshot of SAP Appliance Templates." lightbox="media/deploy-sap-netweaver/sap-1.png":::
 
 5. Choose Create a new account. 
 Using the **Standard Authorization for Authorization** Type requires the following permissions: 
 The standard authorization includes permissions to create and manage appliances. The roles required by the Microsoft Azure user who grants permissions to SAP Cloud Appliance Library are: 
 - Option 1: An administrator of the subscription, that is, your user has the role Owner and has access to scope /subscriptions/. 
 - Option 2: Your Microsoft Azure user has the roles Contributor and User Access Administrator and has access to scope /subscriptions/. You must also have the role of Global Administrator for the Azure Active Directory. 
 Using the **Authorization with Application** for Authorization Type requires you to manually register an application in your Azure AD tenant and grant it the Contributor role to your subscription. 
 You must create an application registration and assign the role Contributor to the corresponding application for your subscription.In this guide, we'll use **Authorization with Application**. 

 6. Click the Test Connection button. Enter the name of your appliance and choose a master password to access your SAP instance. Click Create to provision resources into Azure AD tenant
 
:::image type="content" source="media/deploy-sap-netweaver/sap-update-4.png" alt-text="Screenshot of connection test." lightbox="media/deploy-sap-netweaver/sap-update-4.png":::
 
 7. Download and store the private key needed to access the appliance. 
 
:::image type="content" source="media/deploy-sap-netweaver/sap-5.png" alt-text="Screenshot of private key generation." lightbox="media/deploy-sap-netweaver/sap-5.png":::
 
 8. SAP CAL will start provisioning and activating resources into your subscription. It may take up to several hours to complete. 
 9. The next step is to log on into the SAP GUI, get a developer license, and install it to be able to save packages and update the SAP instance, e.g., publish a web service. 
 Once you create the appliance in the SAP Cloud Appliance Library, the SAP system generates a temporary license key that is sufficient to log on to the system. As a first step, before using the system, you need to install a Minisap license as described in the Community Wiki page: How to request and install Minisap license keys. 

 Installing the Minisap license changes the installation number from INITIAL to DEMOSYSTEM. The developer access key for user DEVELOPER and installation number DEMOSYSTEM is already in the system, and you can start developing in the customer's name range (Z*, Y*). 

 

## Exposing a Web Service for the SAP ECC 7.51 Connector 

The Web Service Configuration Tool discovers the Web service through WSDL (Web Services Description Language) and retrieves its services, endpoints, and operations (BAPIs) it provides. Services, endpoints, and operations (BAPIs) are used by the Web Service Connector to access the SAP server and manipulate identities with Microsoft Identity Manager (MIM) 2016\. 

For a web service to be discovered, it must be exposed in SAP ECC 7.51. This article describes the process of exposing the web service from SAP ECC 7\.51 workbench. 

Log in to SAP ECC 7 and enter the ABAP workbench using Transaction Code SE80. This opens the Object Navigator screen, where you maintain different SAP application components like packages, viewing function groups, BSP programs, etc. 

To create a web service utilized by Web Service Configuration Tool, you must first create a package so that all the objects can easily navigate through different systems. 

 1. From the dropdown, select Package, give the new package a name and press enter. The following screen appears if the object is not available in the system. Click Yes to proceed with the package creation. 

:::image type="content" source="media/deploy-sap-netweaver/sap-7.png" alt-text="Screenshot of create pack." lightbox="media/deploy-sap-netweaver/sap-7.png":::
 
 2. Provide the required details with the **Create Package** screen and click the Create button. You can choose to specify the Application Component. This action restricts the scope of object created only to the application (SAP module, for ex: ABAP, MM, PS, LW, etc.) specified. Note: It's recommended that you don't specify the application component that makes the object global. 

:::image type="content" source="media/deploy-sap-netweaver/sap-8.png" alt-text="Screenshot of package creation." lightbox="media/deploy-sap-netweaver/sap-8.png":::
 
 3. The system prompts for a transport request. Click the button next to Request to generate a new transport request. 

:::image type="content" source="media/deploy-sap-netweaver/sap-9.png" alt-text="Screenshot of request prompt." lightbox="media/deploy-sap-netweaver/sap-9.png":::
 
 4. Create a new local request. 

:::image type="content" source="media/deploy-sap-netweaver/sap-10.png" alt-text="Screenshot of Workbench request." lightbox="media/deploy-sap-netweaver/sap-10.png":::
 
 5. Double click on request name (NPL*) to select it. 

:::image type="content" source="media/deploy-sap-netweaver/sap-11.png" alt-text="Screenshot of NPL." lightbox="media/deploy-sap-netweaver/sap-11.png":::
 
 6. After workbench request is selected, click the Create button to create a package. 

:::image type="content" source="media/deploy-sap-netweaver/sap-12.png" alt-text="Screenshot of request creation." lightbox="media/deploy-sap-netweaver/sap-12.png":::
 
 7. Once the package is created, under Object Name, to start creating the web service, right-click on the Package name, and select Create -> Enterprise Service 

:::image type="content" source="media/deploy-sap-netweaver/sap-13.png" alt-text="Screenshot of object navigator." lightbox="media/deploy-sap-netweaver/sap-13.png":::
 
 8. The screen to select Object Type is displayed. Select Service Provider as object type and click Continue. 

:::image type="content" source="media/deploy-sap-netweaver/sap-14.png" alt-text="Screenshot of object type creation." lightbox="media/deploy-sap-netweaver/sap-14.png":::
 
 9. On the Kind of Service Provider screen, select Existing ABAP Objects (Inside Out) and press Continue. With inside out you start at the backend with an existing application and enable the service for a particular functionality. It means that you start with the implementation and move out towards the interface.

:::image type="content" source="media/deploy-sap-netweaver/sap-15.png" alt-text="Screenshot of Kind of Service Provider." lightbox="media/deploy-sap-netweaver/sap-15.png":::
 
 10. Provide the Service Definition name and description for the selected Object Type. Click Continue. 

:::image type="content" source="media/deploy-sap-netweaver/sap-16.png" alt-text="Screenshot of service definition." lightbox="media/deploy-sap-netweaver/sap-16.png":::
 
 11. On the Endpoint Type screen, select Function Group and press Continue. You must choose Function Group since the Web Service configuration tool for MIM requires a single URL for all the selected BAPIs. 

:::image type="content" source="media/deploy-sap-netweaver/sap-17.png" alt-text="Screenshot of endpoint type." lightbox="media/deploy-sap-netweaver/sap-17.png":::
 
 12. On the Endpoint Function Group screen, select the required Function Group name, and press Continue. The function group chosen in the example is already defined and encapsulates the BAPIs related to users. 

:::image type="content" source="media/deploy-sap-netweaver/sap-18.png" alt-text="Screenshot of endpoint function group." lightbox="media/deploy-sap-netweaver/sap-18.png":::
 
 13. On the Function Group screen, select all the required BAPIs and add the BAPIs that aren't included in the function group. Click Continue. In this example, all BAPIs from SU\_USER function groups are selected. Consult your SAP administrator regarding the BAPIs to be used in your project. 

:::image type="content" source="media/deploy-sap-netweaver/sap-19.png" alt-text="Screenshot of function group." lightbox="media/deploy-sap-netweaver/sap-19.png":::
 
 To implement basic user management scenarios, you may want to limit a list of BAPIs published to: 

 - BAPI_USER_GETLIST
 - BAPI_USER_GETDETAILS 
 - BAPI_USER_CREATE1
 - BAPI_USER_DELETE 
 - BAPI_USER_CHANGE 
 

 14. On the **Configure Service** screen, choose a profile for Security Settings. There are four profiles defined by SAP for selection. Select one profile as per requirement. 
 - Authentication with Certificates and Transport Guarantee 
 - Authentication with User and Password, No Transport Guarantee 
 - Authentication with User and Password and Transport Guarantee 
 - No Authentication and No Transport Guarantee 

 15. In this example, we use Authentication with User and Password and no Transport Guarantee (no HTTPs) option. Click Continue. 

:::image type="content" source="media/deploy-sap-netweaver/sap-20.png" alt-text="Screenshot of configure service." lightbox="media/deploy-sap-netweaver/sap-20.png":::
 
 16. On the Transport screen, click on the icon next to Request/Task name, and select your Local Workbench request. Click Continue. 

:::image type="content" source="media/deploy-sap-netweaver/sap-21.png" alt-text="Screenshot of transport." lightbox="media/deploy-sap-netweaver/sap-21.png":::
 
 17. On the **Finish** screen, click Complete button. 

:::image type="content" source="media/deploy-sap-netweaver/sap-22.png" alt-text="Screenshot of the finish screen." lightbox="media/deploy-sap-netweaver/sap-22.png":::
 
 18. After the Web Service is created, you must change the Profile settings of the Service definition. Under Configuration Tab, select Stateful communication properties, and activate Stateful profile. Click the Save button (diskette icon) in the toolbar. 

:::image type="content" source="media/deploy-sap-netweaver/sap-23.png" alt-text="Screenshot of profile change." lightbox="media/deploy-sap-netweaver/sap-23.png":::
 
 19. In the Repository Browser expand the ZSAPCONNECTORWS package, right click on the ZSAPCONNECTORWEBSERVICE service definition, and select Activate. 

:::image type="content" source="media/deploy-sap-netweaver/sap-24.png" alt-text="Screenshot of ZSAPCONNECTORWEBSERVICE service definition." lightbox="media/deploy-sap-netweaver/sap-24.png":::

## Configuring Web Service using SOA Manager 

Follow the steps below to configure the Web Service. 

 1. Open the Transaction SOAMANAGER. Navigate to the Technical Administration tab and click SAP Client Settings. 

:::image type="content" source="media/deploy-sap-netweaver/sap-25.png" alt-text="Screenshot of technical administration." lightbox="media/deploy-sap-netweaver/sap-25.png":::
 
 2. Expand the Web Service Navigator tray and enter a hostname of your SAP server and port number. Click Save. 

:::image type="content" source="media/deploy-sap-netweaver/sap-26.png" alt-text="Screenshot of host and port." lightbox="media/deploy-sap-netweaver/sap-26.png":::
 
 3. Click Back and Navigate to Service Administration tab. Select Web Service Configuration link. 

:::image type="content" source="media/deploy-sap-netweaver/sap-27.png" alt-text="Screenshot of web service configuration." lightbox="media/deploy-sap-netweaver/sap-27.png":::
 
 4. In the Object Name input field, type ZSAPCONNECTORWEBSERVICE and click Search. 

:::image type="content" source="media/deploy-sap-netweaver/sap-28.png" alt-text="Screenshot of search results." lightbox="media/deploy-sap-netweaver/sap-28.png":::
 
 5. Click to select ZSAPCONNECTORWEBSERVICE Service Definition. 
 6. On the Configurations tab, click Create Service button. 

:::image type="content" source="media/deploy-sap-netweaver/sap-29.png" alt-text="Screenshot of configuration create service." lightbox="media/deploy-sap-netweaver/sap-29.png":::
 
 7. On Configuration of New Binding for Service Definition page, enter the Service Name, the New Binding Name and click Next. 

:::image type="content" source="media/deploy-sap-netweaver/sap-30.png" alt-text="Screenshot of binding for service definition." lightbox="media/deploy-sap-netweaver/sap-30.png":::
 
 8. On the Provider Security page, select the User ID/Password under Transport Channel Authentication, and click Next. 

:::image type="content" source="media/deploy-sap-netweaver/sap-31.png" alt-text="Screenshot of binding for service definition configuration." lightbox="media/deploy-sap-netweaver/sap-31.png":::
 
 9. On the SOAP Protocol page, leave all settings by default, and click Next. 

:::image type="content" source="media/deploy-sap-netweaver/sap-32.png" alt-text="Screenshot of SOAP protocol page." lightbox="media/deploy-sap-netweaver/sap-32.png":::
 
 10. On the Operation Settings page, click Finish. 

:::image type="content" source="media/deploy-sap-netweaver/sap-33.png" alt-text="Screenshot of operation settings finish screen." lightbox="media/deploy-sap-netweaver/sap-33.png":::
 
 11. Once the Service is created click on web page icon to open WSDL generation parameters. 

:::image type="content" source="media/deploy-sap-netweaver/sap-34.png" alt-text="Screenshot of WSDL parameters." lightbox="media/deploy-sap-netweaver/sap-34.png":::
 
 Configure WSDL Flavors as: 
- WSP Version: No Policy 
- SOAP Version: SOAP 1.1
- SOAP Style: Document 
- WSDL Section: AllInOne 
 12. Click to save WSDL Flavor as: SOAP 1.1. Only 

:::image type="content" source="media/deploy-sap-netweaver/sap-35.png" alt-text="Screenshot of save." lightbox="media/deploy-sap-netweaver/sap-35.png":::
 
 13. Find a WSDL URL for Service under WSDL Generation section and copy that link. 
 Example: http://vhcalnplci.dummy.nodomain:8000/sap/bc/srt/wsdl/flv\_10002A1011D1/bndg\_url/sap/bc/srt/rfc/sap/zsapconnectorwebservice/001/zsapconnectorws/zsapconnectorws?sapclient\=001 

:::image type="content" source="media/deploy-sap-netweaver/sap-36.png" alt-text="Screenshot of WSDL URL." lightbox="media/deploy-sap-netweaver/sap-36.png":::
 

## Activating Web Service for SAP ECC 7.51 Connector 

 1. Log in to SAP ECC 7 and enter the ABAP workbench using Transaction Code SICF. Mention Hierarchy Type as Service and click Execute button. 

:::image type="content" source="media/deploy-sap-netweaver/sap-37.png" alt-text="Screenshot of hierarchy type." lightbox="media/deploy-sap-netweaver/sap-37.png":::
 
 2. On the **Define Services** page, type ZSAPCONNECTORWS Service Name, and click Apply. 
 3. Select the ZSAPCONNECTORWS service and choose Activate Service. 

:::image type="content" source="media/deploy-sap-netweaver/sap-38.png" alt-text="Screenshot of activate service." lightbox="media/deploy-sap-netweaver/sap-38.png":::
 
 4. Confirm Activation of ICF Service. Click Yes. 

:::image type="content" source="media/deploy-sap-netweaver/sap-39.png" alt-text="Screenshot of confirm activation." lightbox="media/deploy-sap-netweaver/sap-39.png":::
 
 5. On the **Define Services** page, type WSDL Service Name, and click Apply. Choose to Activate Service for both WSDL services. 

:::image type="content" source="media/deploy-sap-netweaver/sap-40.png" alt-text="Screenshot of active services." lightbox="media/deploy-sap-netweaver/sap-40.png":::
 
 6. Test the web service deployed using your favorite SOAP client tool to ensure that it does return proper data before configuring the Web Services Connector Template 

:::image type="content" source="media/deploy-sap-netweaver/sap-41.png" alt-text="Screenshot of test web service deployment." lightbox="media/deploy-sap-netweaver/sap-41.png":::

## Connecting to Web Service from MIM or the ECMA2Host machine 

 1. To avoid publishing your SAP Web Service endpoint to the Internet, set up peering between your SAP demo lab network and your MIM or ECMA2Host machine. This setup allows you to reach your Web Service by its internal IP address. 
 2. Add the SAP host name and IP address into the hosts file on MIM or ECMA2Host machine. 
 3. Test opening the WSDL URL on the MIM or ECMA2Host machine from a browser to check connectivity to SAP Web Service. 

The next step is to create a [webservice connector template](sap-ecma-template.md) to manage SAP ECC users using this SOAP endpoint and BAPIs published. 

 
## Next steps

* [Migrate identity management scenarios from SAP IDM to Microsoft Entra](migrate-from-sap-idm.md)
* [Author SAP ECC 7 Template for ECMA2Host](sap-ecma-template.md)
* [Configuring Microsoft Entra ID to provision users into SAP ECC with NetWeaver AS ABAP 7.0 or later](~/identity/app-provisioning/on-premises-sap-connector-configure.md)
