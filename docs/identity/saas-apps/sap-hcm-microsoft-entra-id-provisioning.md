---
title: Provision users from SAP Human Capital Management (HCM) to Microsoft Entra ID
description: Learn how to provision users from SAP Human Capital Management (HCM) to Microsoft Entra ID. This guide covers prerequisites, integration steps, attribute mapping, and best practices for automating user account creation, updates, and deprovisioning between SAP HCM and Microsoft Entra ID to streamline identity management and enhance security.
author: jenniferf-skc
manager: pmwongera
ms.reviewer: chmutali
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 07/15/2025
ms.author: jfields

# Customer intent: As an IT administrator, I want to learn how to provision current users from SAP Human Capital Management (HCM) to Microsoft Entra ID so that I can streamline identity management and enhance security.
---

# Provision users from SAP Human Capital Management (HCM) to Microsoft Entra ID

This document is intended to guide system integration partners who are planning to provision users from SAP HCM to Microsoft Entra ID. If SAP HCM is integrated with SAP Identity Management (SAP IDM) and you’re planning a migration to Microsoft Entra ID Governance, this document also discusses the important architectural considerations and how Azure Logic Apps can be used. 

At a high level, this document describes three integration options: 

- Option 1: CSV-file based inbound provisioning from SAP HCM
- Option 2: SAP BAPI-based inbound provisioning leveraging the Azure Logic Apps SAP connector
- Option 3: SAP IDocs-based inbound provisioning leveraging the Azure Logic Apps SAP connector

For customers who wish to extend their current investment in SAP ERP HCM, The integration options in this document are also relevant to SAP HCM for the SAP S/4HANA On-Premise offering known as "H4S4". 

## Terminology

| Term  | Definition |
|--------|-------|
| AS ABAP      | SAP NetWeaver Application Server platform supporting ABAP runtime.  |
| SAP NetWeaver| SAP’s application server platform hosting on-premises SAP ERP applications, including SAP HCM, and providing integration capabilities.  |
| BAPI         | Business Application Programming Interface; enables external applications to access SAP business object data and processes.  |
| IDocs        | Intermediate Documents; standardized SAP format for exchanging business data between systems, consisting of control and data records for batch processing. |
| RFC          | Remote Function Calls; SAP protocol for communication between SAP and external systems, supporting inbound and outbound function calls via RFC ports.  |
| FM           | Function Modules; BAPI function modules configured in SAP HCM.  |
| H4S4         | SAP HCM for SAP S/4HANA On-Premise; optimized SAP ERP HCM version for native S/4HANA platform deployment.  |

## Understand current SAP HCM to SAP IDM integration

### Architecture overview

The data transfer from the SAP HCM system to SAP Identity Management takes place using SAP IDM Virtual Directory Server. The Virtual Directory Server exposes an LDAP interface towards the identity store, allowing the SAP HCM system to write to the identity store using the LDAP capabilities of the Application Server ABAP.

Reference: [Integration with SAP HCM | SAP Help Portal](https://help.sap.com/docs/SAP_IDENTITY_MANAGEMENT/d376345fb4e94928a70036ddf91d690b/490d22699aff42519eb6b328c7f44e24.html)

To enable data flow from SAP HCM to SAP IDM, the SAP administrators perform steps documented in [Setting Up an SAP HCM System | SAP Help Portal](https://help.sap.com/docs/SAP_IDENTITY_MANAGEMENT/4773a9ae1296411a9d5c24873a8d418c/0c0075a4a025422587257d16b22461ea.html). 

### SAP HCM Tables and Infotypes
Employee data in SAP HCM is stored in a SQL relational database. With access to the right function modules (FM) and permissions, it is possible to query the backend database tables storing employee information. 
For every table in the database, there is a functional equivalent in SAP HCM called Infotype, which is a mechanism to logically group related data. SAP HCM admins use Infotype terminology when managing employee data in SAP HCM screens. 
This section provides a list of important tables in SAP HCM storing employee data. The field “Personnel number – PERNR” uniquely identifies every employee in these tables. 

| Table name | Infotype | Remarks |
|------------|----------|---------|
| PA0000     | 0000- Actions      | Captures actions performed by HR on the employee. Example fields: employment status, action type, action name, start date, end date. | 
| PA0001     | 0001 – Employee Org assignments | Captures organization data for an employee. Example fields: company code, cost center, business area. |
| PA0002     | 0002 – Personal Data | Captures personal data. Example fields: first name, last name, date of birth, nationality. |
| PA0006     | 0006 – Addresses | Captures address and phone data. Example fields: street, city, country, phone. |

Example SQL query to fetch active employees’ username, status, first name and last name:
SELECT DISTINCT p0.PERNR username, CASE WHEN (p0.STAT2 = 3) THEN 1 END statuskey, p2.NACHN last_name, p2.VORNA first_name 
FROM SAP_PA0000 p0 left join SAP_PA0002 p2 on p0.PERNR = p2.PERNR 
WHERE p0.STAT2 = 3 and p0.ENDDA > SYSDATE() 

3.3	Scenarios Supported by SAP IDM 
SAP IDM typically ingests more than just basic worker records from SAP HCM. The integration supports a broad range of employee-related data, including:
•	Core identity attributes: name, employee ID, employment status.
•	Organizational data: including cost center, business unit, and reporting structure.
•	Personal data: such as date of birth, nationality, and contact information.
•	Communication and external identifiers: like email addresses and external system IDs.
This is achieved by reading from multiple SAP HCM infotypes (e.g., 0000, 0001, 0002, 0006, 0105), which are logical groupings of related employee data. These are accessed via SAP function modules (FMs) or BAPIs that abstract the underlying table structures.
3.4	Key Aspects of SAP IDM Integration
A notable architectural feature of SAP IDM is its use of a staging area—a conceptually distinct layer between the source system (SAP HCM) and the productive identity store. This staging area offers several advantages:
•	Data validation and transformation: Data can be reviewed, enriched, or transformed before being committed to the identity store.
•	Workflow integration: Approval workflows can be triggered based on staged data, allowing for human-in-the-loop validation.
•	Schema flexibility: Changes in the SAP HCM schema can be accommodated by adjusting mappings in the staging area without altering the identity store schema.
The staging area is equivalent to a "connector space"—a buffer zone where data can be inspected and controlled before it becomes authoritative. 
3.5	Contrast with Microsoft Entra Provisioning Flow
Currently, Microsoft Entra’s inbound provisioning flow does not include a native equivalent of this staging area. Data transformations and validations must be handled externally—typically in middleware (e.g., Azure Logic Apps or PowerShell scripts)—before invoking the Entra provisioning API. This architectural difference is incorporated in the solution options suggested below.
4	SAP HCM and Entra Inbound Provisioning options
This section describes options that SAP HCM customers can consider for implementing inbound provisioning from SAP HCM to Microsoft Entra / on-premises Active Directory. 
Use the following decision tree to determine which option to use. 
 
4.1	Option 1: CSV-file based inbound provisioning
4.1.1	When to use this approach
Use this approach if the customer is using both SAP HCM and SAP SuccessFactors in side-by-side deployment mode, where SAP SuccessFactors is not yet authoritative/operational as the primary HR data source. This approach provides faster time-to-value and aligns better with the customer’s objective of eventually moving to SAP SuccessFactors. 
In what scenarios will a customer have deployed both SAP HCM and SAP SuccessFactors?
It’s common for customers to start their SAP SuccessFactors deployment with ancillary HR modules like Performance and Goals, Learn, etc., before moving core HR modules to SAP SuccessFactors. In this scenario, the on-premises SAP HCM system continues to be the authoritative source for employee and organization data. 
Why is this approach recommended only for SAP HCM customers with SAP SuccessFactors deployment plan?
Only customers with this side-by-side deployment configuration are eligible to use SAP’s Add-on Integration Module for SAP HCM and SuccessFactors that simplifies the periodic export of employee data into CSV files. 
4.1.2	High level data flow and configuration steps
The diagram below illustrates the high-level data flow and configuration steps. 
 
•	Step 1: In SAP HCM, configure periodic export of CSV files with employee data. When running the integration for the very first time, we recommend performing a full export for the initial sync. Once initial sync is complete, you can perform incremental exports that only capture changes. The exported CSV files can be stored on SFTP server or Azure File shares in encrypted format.  
o	References: 
	Replicating employee data from SAP ERP HCM
	2214465 - Integration Add-On 3.0 for SAP ERP HCM - SAP for Me (requires SAP support login) 
	Slide deck explaining integration between SAP ERP HCM and SuccessFactors
o	Note: CSV Files can have delta (or incremental) data. 
•	Step 2: In Microsoft Entra, configure API-driven provisioning app to receive employee data from SAP HCM.
o	References: 
	API-driven inbound provisioning concepts 
	Configure API-driven inbound provisioning app
•	Step 3: Configure middleware tool to decrypt/read the CSV, convert it to SCIM bulk payload and send the data to the API endpoint configured in step 2. The CSV file can be stored in a staging location like Azure File Share. It is recommended to implement validation and circuit-breaking logic in the middleware tool to keep out bad data from flowing into Entra. For e.g. if employeeType is invalid, then skip the record and if a certain percentage of HR records have invalid data, stop the bulk upload operation. 
o	References: 
	API-driven inbound provisioning with PowerShell script
	API-driven inbound provisioning with Azure Logic Apps
4.1.3	Deployment variations
If the customer does not have access to the SAP provided add-on integration module or does not plan to use SuccessFactors, even in this scenario, it’s still possible to use the CSV approach if the customer’s on-premises SAP ERP team can “build a custom automation in SAP HCM” to export CSV files on a regular basis for both full sync and incremental sync. 
4.2	Option 2: SAP BAPI-based inbound provisioning
4.2.1	When to use this approach
Use this approach if the customer does not have SAP SuccessFactors deployed and the solution architecture calls for a scheduled periodic sync using Azure Logic Apps due to system constraints or deployment requirements. 
This integration leverages the Azure Logic Apps SAP connector. Azure Logic Apps ships two connector types for SAP: 
o	SAP built-in connector, which is available only for Standard workflows in single-tenant Azure Logic Apps.
o	SAP managed connector that's hosted and run in multitenant Azure. It’s available with both Standard and Consumption logic app workflows. 

The SAP “built-in connector” has certain advantages over the “managed connector” for the reasons documented in this article. For example: With the SAP built-in connector, on-premises connections don't require the on-premises data gateway and dedicated actions provide better experience for stateful BAPIs and RFC transactions. 

4.2.2	High level data flow and configuration steps
The diagram below illustrates the high-level data flow and configuration steps. 
Note: The diagram depicts the deployment components for the Azure Logic Apps SAP built-in connector. 
Networking considerations: 
o	If a customer prefers using the Azure Logic Apps SAP managed connector, then consider using Azure Express Route that permits peering of Logic App Standard network with that of on-premises SAP deployment. The on-premises data gateway component is not recommended as it leads to diminished security. 
o	If the SAP HCM system is already running on Azure, the connection from Logic Apps to the customers SAP system could be done in the same VNET (without the need for on-premises data gateway).
 
•	Step 1: Configure pre-requisites in SAP HCM to use the SAP built-in connector. This includes setting up an SAP system account with appropriate authorizations to invoke the following BAPI function modules. The RPY* and SWO* function modules will enable the customer to use the dedicated BAPI actions that allow listing the available business objects and discovering which ABAP methods are available to act upon these objects. This is recommended over direct call of the RFC implementing the BAPI method as better discoverability and more specific metadata for the input-output. 
o	RFC_READ_DATA
o	RFC_READ_TABLE
o	BAPI_USER_GETLIST
o	BAPI_USER_GET_DETAIL
o	BAPI_EMPLOYEE_GETDATA
o	RFC_METADATA
	RFC_METADATA_GET
	RFC_METADATA_GET_TIMESTAMP
o	RPY_BOR_TREE_INIT 
o	SWO_QUERY_METHODS 
o	SWO_QUERY_API_METHODS
If the customer has defined custom function modules, then those should be included in the list. 
•	Step 2: In Microsoft Entra, configure API-driven provisioning app to receive employee data from SAP HCM.
o	References: 
	API-driven inbound provisioning concepts 
	Configure API-driven inbound provisioning app
•	Step 3: Configure a logic app workflow that invokes the appropriate BAPI function modules preferably via [BAPI] call method in SAP, processes the response, builds a SCIM payload and sends the response to the Microsoft Entra provisioning API endpoint. As a best practice to stay within API-driven provisioning usage limits, we recommend batching multiple changes into a single SCIM bulk request rather than submitting one SCIM bulk request for each change.
o	References: 
	API-driven inbound provisioning with Azure Logic Apps
•	Step 4: Query the Entra ID provisioning logs endpoints to check the status of the provisioning operation. Record successful operations and retry failures. 
4.2.3	Defining a custom RFC for delta imports 
Use the steps below to create a custom RFC in the SAP GUI/ABAP Workbench. This custom RFC will return attributes of users that have changed between a specific start date and end date. 
1.	Define the RFC Function Module:
a.	Use transaction SE37 to create a custom RFC-enabled function module that accepts as input a start date (p_begda) and an end date (p_endda).
b.	In the function module, write logic to query the relevant tables (e.g., PA0001, PA0002) for user attributes.
c.	Filter the data based on the timestamp of the last change (e.g., using the CHANGED_ON field).
2.	Implement the Logic:
a.	Use ABAP code to fetch the required attributes and apply the filter for changes within the last hour.
b.	Example ABAP snippet: 

FORM read_database USING p_begda p_endda.
 
    IF lv_pernr IS INITIAL.
*& -- > Employee list
        SELECT pernr endda begda FROM pa0000
            INTO TABLE 1t_pernr WHERE aedtm BETWEEN p_begda AND p_endda.
 
*& -- > Org assignment details
        SELECT pernr endda begda FROM pa0001
            APPENDING TABLE 1t_pernr WHERE aedtm BETWEEN p_begda AND p_endda.
 
*& -- > Personal Details
        SELECT pernr endda begda FROM pa0002
            APPENDING TABLE 1t_pernr WHERE aedtm BETWEEN p_begda AND p_endda.
 
    ENDIF.
 



•	Ensure the function module returns the data in a structured format (e.g., internal table 1t_pernr).
3.	Enable RFC Access:
a.	Mark the function module as RFC-enabled in its attributes.
b.	Test the RFC using transaction SM59 to ensure it can be called remotely.
4.	Test and Deploy:
a.	Test the RFC locally and remotely to verify its functionality.
b.	Deploy the RFC in your ECC system and document its usage.
5.	Configure RFC call in Logic Apps
a.	Specify the SAP system details, including the RFC name you created in SAP ECC.
 
b.	Input any required parameters for the RFC (e.g., in the above screenshot, the parameter BEGDA points to a watermark date stored in Azure Blob Storage corresponding to the previous run, while ENDDA is the start date of the current logic app run.)
6.	Parse the JSON Response from the RFC Call and use it to create the SCIM bulk request payload. 
 
o	References: 
	API-driven inbound provisioning with Azure Logic Apps


4.3	Option 3: SAP IDocs-based inbound provisioning  
4.3.1	When to use this approach
Use this approach if the customer does not have SAP SuccessFactors deployed and the solution architecture calls for event-based sync using Azure Logic Apps due to system constraints or deployment requirements. 
This integration leverages the Azure Logic Apps SAP Connector. Azure Logic Apps ships two connector types for SAP: 
o	SAP built-in connector, which is available only for Standard workflows in single-tenant Azure Logic Apps.
o	SAP managed connector that's hosted and run in multitenant Azure. It’s available with both Standard and Consumption logic app workflows. 

The SAP “built-in connector” has certain advantages over the “managed connector” for the reasons documented in this article. For example: With the SAP built-in connector, on-premises connections don't require the on-premises data gateway, it supports IDoc deduplication and has better support for handling IDoc file formats in the trigger when a message is received. 


4.3.2	High level data flow and configuration steps
The diagram below illustrates the high-level data flow and configuration steps. 
Note: The diagram depicts the deployment components for the Azure Logic Apps SAP built-in connector. 
Networking considerations: 
o	If a customer prefers using the Azure Logic Apps SAP managed connector, then consider using Azure Express Route that permits peering of Logic Apps Standard network with that of on-premises SAP deployment. The on-premises data gateway component is not recommended as it leads to diminished security. 
o	If the SAP HCM system is already running on Azure, the connection from Azure Logic Apps to the customers SAP system could be done in the same VNET (without the need for on-premises data gateway)
 
•	Step 1: Configure pre-requisites in SAP HCM to use the Azure Logic Apps SAP built-in connector. This includes setting up an SAP system account with appropriate authorizations to invoke BAPI function modules and IDoc messages. 
Complete the steps to set up and test sending IDocs from SAP to your logic app workflow. 

•	Step 2: In Microsoft Entra, configure API-driven provisioning app to receive employee data from SAP HCM.
o	References: 
	API-driven inbound provisioning concepts 
	Configure API-driven inbound provisioning app
•	Step 3: Build a logic app workflow that is initiated with the trigger when message is received, process the IDocs message, build a SCIM payload and send the response to the Microsoft Entra provisioning API endpoint. As a best practice to stay within API-driven provisioning usage limits, we recommend batching multiple changes into a single SCIM bulk request rather than submitting one SCIM bulk request for each change.
o	References: 
	API-driven inbound provisioning with Azure Logic Apps
•	Step 4: Query the Entra ID provisioning logs endpoints to check the status of the provisioning operation. Record successful operations and retry failures.
5	Configuring Writeback to SAP HCM
After a worker record from SAP HCM is provisioned in Entra ID, usually there is a business need to write back IT-managed attributes like email and username to SAP HCM. 
We recommend using Microsoft Entra ID Governance -> Joiner Lifecycle Workflow with custom Logic Apps extension for this scenario. The flow schematic is as shown below. 
 
1)	Configure Joiner Lifecycle Workflow to trigger on hire date. 
2)	Configure a custom Logic Apps extension as part of the Joiner workflow. 
3)	In this Logic Apps extension, call the BAPI_USER_CHANGE function to update the user’s email address / username.  


## Acknowledgements
We thank the following partners for their help reviewing and contributing to this article:
•	Kocho
•	iC Consult

## Related content

* [Provision users from SAP SuccessFactors to Microsoft Entra ID](./sap-successfactors-microsoft-entra-id-provisioning.md)