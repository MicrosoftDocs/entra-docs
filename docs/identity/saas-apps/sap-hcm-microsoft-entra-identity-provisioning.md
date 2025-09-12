---
title: Provision users from SAP Human Capital Management (HCM) to Microsoft Entra ID
description: Learn how to provision users from SAP Human Capital Management (HCM) to Microsoft Entra ID.
author: jenniferf-skc
manager: pmwongera
ms.reviewer: chmutali
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 07/18/2025
ms.author: jfields
ai-usage: ai-assisted

# Customer intent: As an IT administrator, I want to learn how to provision current users from SAP Human Capital Management (HCM) to Microsoft Entra ID so that I can streamline identity management and enhance security.
---

# Provision users from SAP human capital management (HCM) to Microsoft Entra ID

This article guides system integration partners planning to provision users from SAP HCM to Microsoft Entra ID. If SAP HCM is integrated with SAP Identity Management (SAP IDM) and you’re planning a migration to Microsoft Entra ID Governance, this document also discusses the important architectural considerations and how Azure Logic Apps are used. 

At a high level, this document describes three integration options: 

- Option 1: CSV-file based inbound provisioning from SAP HCM
- Option 2: SAP BAPI-based inbound provisioning using the Azure Logic Apps SAP connector
- Option 3: SAP IDocs-based inbound provisioning using the Azure Logic Apps SAP connector

If you wish to extend your current investment in SAP Enterprise Resource Planning (ERP) HCM, the integration options in this document are also relevant to SAP HCM for the SAP S/4HANA On-Premise offering known as "H4S4". 

## Terminology

| Term  | Definition |
|--------|-------|
| AS ABAP      | SAP NetWeaver Application Server platform supporting Advanced Business Application Programming (ABAP) runtime.  |
| SAP NetWeaver| SAP’s application server platform hosting on-premises SAP ERP applications, including SAP HCM, and providing integration capabilities.  |
| BAPI         | Business Application Programming Interface; enables external applications to access SAP business object data and processes.  |
| IDocs        | Intermediate Documents; standardized SAP format for exchanging business data between systems, consisting of control and data records for batch processing. |
| RFC          | Remote Function Calls; SAP protocol for communication between SAP and external systems, supporting inbound and outbound function calls via RFC ports.  |
| FM           | Function Modules; BAPI function modules configured in SAP HCM.  |
| H4S4         | SAP HCM for SAP S/4HANA On-Premise; optimized SAP ERP HCM version for native S/4HANA platform deployment.  |

## Understand the existing SAP HCM to SAP IDM integration

### Architecture overview

The data transfer from the SAP HCM system to SAP Identity Management takes place using SAP IDM Virtual Directory Server. The Virtual Directory Server exposes a Lightweight Directory Access Protocol (LDAP) interface towards the identity store, allowing the SAP HCM system to write to the identity store using the LDAP capabilities of the Application Server ABAP.

Reference: [Integration with SAP HCM | SAP Help Portal](https://help.sap.com/docs/SAP_IDENTITY_MANAGEMENT/d376345fb4e94928a70036ddf91d690b/490d22699aff42519eb6b328c7f44e24.html)

To enable data flow from SAP HCM to SAP IDM, SAP administrators need to perform steps documented in [Setting Up an SAP HCM System | SAP Help Portal](https://help.sap.com/docs/SAP_IDENTITY_MANAGEMENT/4773a9ae1296411a9d5c24873a8d418c/0c0075a4a025422587257d16b22461ea.html). 

### SAP HCM Tables and Infotypes

Employee data in SAP HCM is stored in a SQL relational database. With access to the right function modules (FM) and permissions, it's possible to query the backend database tables storing employee information. 
For every table in the database, there's a functional equivalent in SAP HCM called **Infotype**, which is a mechanism to logically group related data. SAP HCM admins use Infotype terminology when managing employee data in SAP HCM screens. 
This section provides a list of important tables in SAP HCM storing employee data. The field **Personnel number – PERNR** uniquely identifies every employee in these tables. 

| Table name | Infotype | Remarks |
|------------|----------|---------|
| PA0000     | 0000- Actions  | Captures actions performed by HR on the employee. Example fields: employment status, action type, action name, start date, end date. | 
| PA0001     | 0001 – Employee Org assignments | Captures organization data for an employee. Example fields: company code, cost center, business area. |
| PA0002     | 0002 – Personal Data | Captures personal data. Example fields: first name, last name, date of birth, nationality. |
| PA0006     | 0006 – Addresses | Captures address and phone data. Example fields: street, city, country, phone. |

Example SQL query to fetch active employees’ username, status, first name, and last name:

```sql
SELECT DISTINCT p0.PERNR username, CASE WHEN (p0.STAT2 = 3) THEN 1 END statuskey, p2.NACHN last_name, p2.VORNA first_name
FROM SAP_PA0000 p0 left join SAP_PA0002 p2 on p0.PERNR = p2.PERNR
WHERE p0.STAT2 = 3 and p0.ENDDA > SYSDATE()
```


### Scenarios Supported by SAP IDM 

SAP IDM typically ingests more than just basic worker records from SAP HCM. The integration supports a broad range of employee-related data, including:

- **Core identity attributes**, name, employee ID, employment status.
- **Organizational data**, including cost center, business unit, and reporting structure.
- **Personal data**, such as date of birth, nationality, and contact information.
- **Communication and external identifiers**, such as email addresses and external system IDs.

This scenario is achieved by reading from multiple SAP HCM infotypes (Example: 0000, 0001, 0002, 0006, 0105), which are logical groupings of related employee data. These are accessed through SAP function modules (FMs) or BAPIs that abstract the underlying table structures.

### Key Aspects of SAP IDM Integration

A notable architectural feature of SAP IDM is its use of a staging area—a conceptually distinct layer between the source system (SAP HCM) and the productive identity store. This staging area offers several advantages:

- **Data validation and transformation**: Data is reviewed, enriched, or transformed before being committed to the identity store.
- **Workflow integration**: Approval workflows are triggered based on staged data, allowing for human-in-the-loop validation.
- **Schema flexibility**: Changes in the SAP HCM schema are accommodated by adjusting mappings in the staging area without altering the identity store schema.

The staging area is equivalent to a "connector space" — a buffer zone where data is inspected and controlled before it becomes authoritative. 

### Contrast with Microsoft Entra Provisioning Flow

Currently, Microsoft Entra’s inbound provisioning flow doesn't include a native equivalent of this staging area. Data transformations and validations must be handled externally; typically in middleware (Example: Azure Logic Apps or PowerShell scripts) before invoking the Entra provisioning API. This architectural difference is incorporated in the following solution options.

## SAP HCM and Entra Inbound Provisioning options

This section describes options that SAP HCM customers can consider for implementing inbound provisioning from SAP HCM to Microsoft Entra / on-premises Active Directory. 
Use the following decision tree to determine which option to use. 

:::image type="content" source="./media/sap-hcm-microsoft-entra-identity-provisioning/diagram-sap-hcm-entra-identity-sync.png" alt-text="Diagram of SAP HCM to Entra ID decision tree workflow.":::

## Option 1: CSV-file based inbound provisioning

### When to use this approach

Use this approach if you're using both SAP HCM and SAP SuccessFactors in side-by-side deployment mode, where SAP SuccessFactors isn't yet authoritative/operational as the primary HR data source. This approach provides faster time-to-value and aligns better with your objective of eventually moving to SAP SuccessFactors. 

**In what scenarios will a customer have deployed both SAP HCM and SAP SuccessFactors?**

It’s common for you to start your SAP SuccessFactors deployment with ancillary HR modules like Performance and Goals, Learn, etc., before moving core HR modules to SAP SuccessFactors. In this scenario, the on-premises SAP HCM system continues to be the authoritative source for employee and organization data. 

**Why is this approach recommended only for SAP HCM customers with SAP SuccessFactors deployment plan?**

Only customers with this side-by-side deployment configuration are eligible to use SAP’s [Add-on Integration Module for SAP HCM and SuccessFactors](https://help.sap.com/doc/87c19c94e71e4e389e5b1daea1942c72/3.0%20SP06/en-US/loio06b98261c1d34e67b554c9527d6a3565_06b98261c1d34e67b554c9527d6a3565.pdf) that simplifies the periodic export of employee data into CSV files. 

### High-level data flow and configuration steps

This diagram illustrates the high-level data flow and configuration steps. 

:::image type="content" source="./media/sap-hcm-microsoft-entra-identity-provisioning/diagram-sap-hcm-entra-identity-csv-file-dataflow.png" alt-text="Diagram of high-level data flow from SAP HCM to Entra ID.":::
 
- **Step 1**: In SAP HCM, configure periodic export of CSV files with employee data. When running the integration for the very first time, we recommend performing a full export for the initial sync. Once initial sync is complete, you can perform incremental exports that only capture changes. The exported CSV files can be stored on SFTP server or Azure File shares in encrypted format.  
    - References: 
        - [Replicating employee data from SAP ERP HCM](https://help.sap.com/doc/2eff62546be748739ca05477c2ab7ba7/2505/en-US/SF_ERP_EC_EE_Data_HCI_en-US.pdf)
        - [2214465 - Integration Add-On 3.0 for SAP ERP HCM - SAP for Me](https://me.sap.com/notes/0002214465) (requires SAP support login) 
        - Slide deck explaining integration between [SAP ERP HCM and SuccessFactors](https://s3-eu-west-1.amazonaws.com/static.wm3.se/sites/572/media/339260_Integration_between_SAP_ERP_HCM_and_SuccessFactors_BizX.pdf?1572267595)
	> [!NOTE]
    > CSV Files can have delta (or incremental) data. 
- **Step 2**: In Microsoft Entra, configure the API-driven provisioning app to receive employee data from SAP HCM.
    - References: 
        - [API-driven inbound provisioning concepts](../app-provisioning/inbound-provisioning-api-concepts.md) 
        - [Configure API-driven inbound provisioning app](../app-provisioning/inbound-provisioning-api-configure-app.md)
- **Step 3**: Configure middleware tool to decrypt/read the CSV, convert it to SCIM bulk payload, then send the data to the API endpoint configured in Step 2. The CSV file can be stored in a staging location like Azure File Share. It's recommended to implement validation and circuit-breaking logic in the middleware tool to keep out bad data from flowing into Entra. For example, if ```employeeType``` is invalid, then skip the record and if a certain percentage of HR records have invalid data, stop the bulk upload operation. 
    - References: 
        - [API-driven inbound provisioning with PowerShell script](../app-provisioning/inbound-provisioning-api-powershell.md)
        - [API-driven inbound provisioning with Azure Logic Apps](../app-provisioning/inbound-provisioning-api-logic-apps.md)


### Deployment variations
If you don't have access to the SAP provided add-on integration module or don't plan to use SuccessFactors, even in this scenario, it’s still possible to use the CSV approach if your on-premises SAP ERP team can build a custom automation in SAP HCM to export CSV files regularly for both full sync and incremental sync. 

## Option 2: SAP BAPI-based inbound provisioning

### When to use this approach

Use this approach if you don't have SAP SuccessFactors deployed and the solution architecture calls for a scheduled periodic sync using Azure Logic Apps due to system constraints or deployment requirements. 
This integration uses the [Azure Logic Apps SAP connector](/azure/logic-apps/connectors/sap). Azure Logic Apps ships two connector types for SAP: 

- [SAP built-in connector](/azure/logic-apps/connectors/built-in/reference/sap), which is available only for Standard workflows in single-tenant Azure Logic Apps.
- [SAP managed connector](/azure/logic-apps/connectors/sap) that's hosted and run in multitenant Azure. It’s available with both Standard and Consumption logic app workflows. 

The SAP "built-in connector" has certain advantages over the “managed connector” for the reasons documented in this article. For example, With the SAP built-in connector, on-premises connections don't require the on-premises data gateway and dedicated actions provide better experience for stateful BAPIs and RFC transactions. 

### High level data flow and configuration steps

This diagram illustrates the high-level data flow and configuration steps for SAP BAPI-based inbound provisioning. 

> [!NOTE] 
> The diagram depicts the deployment components for the Azure Logic Apps SAP built-in connector. 

**Networking considerations**: 

- If you prefer using the Azure Logic Apps SAP managed connector, then consider using Azure Express Route that permits peering of Logic App Standard network with that of on-premises SAP deployment. The on-premises data gateway component isn't recommended as it leads to diminished security. 
- If the SAP HCM system is already running on Azure, the connection from Logic Apps to your SAP system can be done in the same VNET (without the need for on-premises data gateway).
 
:::image type="content" source="./media/sap-hcm-microsoft-entra-identity-provisioning/diagram-prereqs-deployment-components-sap-azure-logic-apps-built-in-connector.png" alt-text="Diagram of high-level data flow of deployment components for SAP BAPI-based inbound provisioning.":::

- **Step 1**: Configure [prerequisites](/azure/logic-apps/connectors/sap#prerequisites) in SAP HCM to use the SAP built-in connector. This includes setting up an SAP system account with appropriate authorizations to invoke the following BAPI function modules. The RPY* and SWO* function modules enable you to use the dedicated BAPI actions that allow listing the available business objects and discovering which ABAP methods are available to act upon these objects. For better discoverability and more specific metadata for the input-output, we recommend this over direct call of the RFC implementation of the BAPI method.
 
    - `RFC_READ_DATA`
    - `RFC_READ_TABLE`
    - `BAPI_USER_GETLIST`
    - `BAPI_USER_GET_DETAIL`
    - `BAPI_EMPLOYEE_GETDATA`
    - `RFC_METADATA`
        - `RFC_METADATA_GET`
        - `RFC_METADATA_GET_TIMESTAMP`
    - `RPY_BOR_TREE_INIT` 
    - `SWO_QUERY_METHODS` 
    - `SWO_QUERY_API_METHODS`

If you have defined custom function modules, then those should be included in the list. 

- **Step 2**: In Microsoft Entra, configure the API-driven provisioning app to receive employee data from SAP HCM.
    - References: 
        - [API-driven inbound provisioning concepts](../app-provisioning/inbound-provisioning-api-concepts.md) 
        - [Configure API-driven inbound provisioning app](../app-provisioning/inbound-provisioning-api-configure-app.md)
- **Step 3**: Configure a logic app workflow that invokes the appropriate BAPI function modules preferably via [BAPI call method in SAP](/azure/logic-apps/connectors/built-in/reference/sap/#[bapi]-call-method-in-sap), processes the response, builds a SCIM payload and sends the response to the Microsoft Entra provisioning API endpoint. As a best practice to stay within [API-driven provisioning usage limits](../../id-governance/licensing-fundamentals.md#api-driven-provisioning), we recommend batching multiple changes into a single SCIM bulk request rather than submitting one SCIM bulk request for each change.

    - References: 
        - [API-driven inbound provisioning with Azure Logic Apps](../app-provisioning/inbound-provisioning-api-logic-apps.md)
- **Step 4**: Query the Entra ID provisioning logs endpoints to check the status of the provisioning operation. Record successful operations and retry failures. 

### Define a custom RFC for delta imports 

Use these steps to create a custom RFC in the SAP GUI/ABAP Workbench. This custom RFC returns attributes of users that have changed between a specific start date and end date. 
1.	**Define the RFC Function Module**

    a. Use transaction **SE37** to create a custom RFC-enabled function module that accepts as input a start date (`p_begda`) and an end date (`p_endda`)<br>
    b. In the function module, write logic to query the relevant tables (Example, PA0001, PA0002) for user attributes.<br>
    c. Filter the data based on the timestamp of the last change (Example, using the `CHANGED_ON field`).<br>
2.	**Implement the Logic**

    a. Use ABAP code to fetch the required attributes and apply the filter for changes within the last hour.<br>
    b. Example ABAP snippet: 

    ```abap
    FORM read_database USING p_begda p_endda. 

        IF lv_pernr IS INITIAL. 

    *-- > Employee list 
            SELECT pernr endda begda FROM pa0000 
                INTO TABLE 1t_pernr WHERE aedtm BETWEEN p_begda AND p_endda. 

    *-- > Org assignment details 
            SELECT pernr endda begda FROM pa0001 
                APPENDING TABLE 1t_pernr WHERE aedtm BETWEEN p_begda AND p_endda. 

    *-- > Personal Details 
            SELECT pernr endda begda FROM pa0002 
                APPENDING TABLE 1t_pernr WHERE aedtm BETWEEN p_begda AND p_endda. 

        ENDIF.

    ENDFORM.
    ```

    c. Ensure the function module returns the data in a structured format (Example, internal table `1t_pernr`).<br>
3.	**Enable RFC Access**

    a. Mark the function module as RFC-enabled in its attributes.<br>  
    b. Test the RFC using transaction SM59 to ensure it can be called remotely.<br>
4.	**Test and Deploy**

    a. Test the RFC locally and remotely to verify its functionality.<br>
    b. Deploy the RFC in your ECC system and document its usage.<br>
5.	**Configure RFC call in Logic Apps**

    a. Specify the SAP system details, including the RFC name you created in SAP ECC.<br>
:::image type="content" source="./media/sap-hcm-microsoft-entra-identity-provisioning/screenshot-sap-call-user-changes-rfc-function-sap.png" alt-text="Screenshot of Call get user changes RFC function in SAP.":::
    b. Input any required parameters for the RFC (for example, in the previous screenshot, the parameter BEGDA points to a watermark date stored in Azure Blob Storage corresponding to the previous run, while ENDDA is the start date of the current logic app run.).<br>
6.	Parse the JSON Response from the RFC Call and use it to create the SCIM bulk request payload. 
:::image type="content" source="./media/sap-hcm-microsoft-entra-identity-provisioning/screenshot-outputs-call-user-changes-rfc-function-sap.png" alt-text="Screenshot of the output for Call get user changes RFC function in SAP.":::

- References: 
    - [API-driven inbound provisioning with Azure Logic Apps](../app-provisioning/inbound-provisioning-api-logic-apps.md)


##	Option 3: SAP IDocs-based inbound provisioning 
 
### When to use this approach

Use this approach if you don't have SAP SuccessFactors deployed and the solution architecture calls for event-based sync using Azure Logic Apps due to system constraints or deployment requirements. 

This integration uses the Azure Logic Apps SAP Connector. Azure Logic Apps ships two connector types for SAP: 
- [SAP built-in connector](/azure/logic-apps/connectors/built-in/reference/sap), which is available only for Standard workflows in single-tenant Azure Logic Apps.
- [SAP managed connector](/azure/logic-apps/connectors/sap), which is hosted and run in multitenant Azure. It’s available with both Standard and Consumption logic app workflows. 

The SAP "built-in connector" has certain advantages over the “managed connector” for the reasons documented [in this article](/azure/logic-apps/connectors/sap#connector-differences). For example, with the SAP built-in connector, on-premises connections don't require the on-premises data gateway, it supports IDoc deduplication and has better support for handling IDoc file formats in the trigger [when a message is received](/azure/logic-apps/connectors/built-in/reference/sap#when-a-message-is-received). 


### High level data flow and configuration steps
This diagram illustrates the high-level data flow and configuration steps. 
> [!NOTE]
> The diagram depicts the deployment components for the Azure Logic Apps SAP built-in connector. 

**Networking considerations**: 
- If you prefer using the Azure Logic Apps SAP managed connector, then consider using Azure Express Route that permits peering of the Logic Apps Standard network with on-premises SAP deployment. The on-premises data gateway component isn't recommended as it leads to diminished security. 
- If the SAP HCM system is already running on Azure, the connection from Azure Logic Apps to the customers SAP system could be done in the same VNET (without the need for on-premises data gateway).
:::image type="content" source="./media/sap-hcm-microsoft-entra-identity-provisioning/diagram-deployment-components-sap-azure-logic-apps-connector.png" alt-text="Diagram of high-level data flow of deployment components for the Azure Logic Apps SAP built-in connector.":::
 
- **Step 1**: Configure prerequisites in SAP HCM to use the Azure Logic Apps SAP built-in connector. This step includes setting up an SAP system account with appropriate authorizations to invoke BAPI function modules and IDoc messages. 
Complete the steps to set up and test sending IDocs from SAP to your logic app workflow. 

- **Step 2**: In Microsoft Entra, configure API-driven provisioning app to receive employee data from SAP HCM.
    - References: 
        - [API-driven inbound provisioning concepts](../app-provisioning/inbound-provisioning-api-concepts.md)
        - [Configure API-driven inbound provisioning app](../app-provisioning/inbound-provisioning-api-configure-app.md)
- **Step 3**: Build a logic app workflow that is initiated with the trigger when message is received, process the IDocs message, build a SCIM payload and send the response to the Microsoft Entra provisioning API endpoint. As a best practice to stay within API-driven provisioning usage limits, we recommend batching multiple changes into a single SCIM bulk request rather than submitting one SCIM bulk request for each change.
    - References: 
        - API-driven inbound provisioning with Azure Logic Apps
- **Step 4**: Query the Entra ID provisioning logs endpoints to check the status of the provisioning operation. Record successful operations and retry failures.

## Configure Writeback to SAP HCM

After a worker record from SAP HCM is provisioned in Entra ID, there's often a business need to write back IT-managed attributes like email and username to SAP HCM. 
We recommend using Microsoft Entra ID Governance -> Joiner Lifecycle Workflow with a custom Logic Apps extension for this scenario. The flow schematic is as shown in this diagram. 
:::image type="content" source="./media/sap-hcm-microsoft-entra-identity-provisioning/diagram-joiner-lifecycle-workflow-azure-logic-apps.png" alt-text="Diagram of Joiner Lifecycle Workflow with Azure Logic Apps and SAP built-in connector.":::

Follow these steps to configure writeback:

1. Configure Joiner Lifecycle Workflow to trigger on-hire date.
2. Configure a custom Logic Apps extension as part of the Joiner workflow.
3. In this Logic Apps extension, call the `BAPI_USER_CHANGE` function to update the user’s email address and username.


## Acknowledgements
We thank the following partners for their help reviewing and contributing to this article:
- [Kocho](https://kocho.co.uk/)
- [iC Consult](https://ic-consult.com/en/)

## Related content

[API-driven inbound provisioning with Azure Logic Apps](../app-provisioning/inbound-provisioning-api-logic-apps.md)