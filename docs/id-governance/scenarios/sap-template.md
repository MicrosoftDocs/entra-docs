---
title: 'Author SAP ECC 7 Template for ECMA2Host'
description: This article describes how to create a template for the Web Service ECMA connector to manage SAP ECC users. 
ms.service: entra-id-governance
ms.subservice:
documentationcenter: ''
author: billmath
manager: amycolannino
editor: ''
ms.topic: conceptual
ms.date: 07/28/2023
ms.author: billmath
---

# Authoring the SAP ECC 7.51 Web Service connector template for the ECMA2Host 

This guide walks you through the process of creating a template for the Web Service Extensibility Connectivity Management Agent (ECMA) connector to manage SAP ECC users. 

## Limitations and assumptions 

This template demonstrates how to manage users. Other object types like Local Activity Groups, Roles, and Profiles aren't covered by this guide as the ECMA2Host doesn't currently support multi-valued references. Password operations are also out of scope for this guide. 

This guide doesn't cover the creation of the service account within SAP that is used to call the exposed BAPI functions. It assumes that a pre-created demo account **Developer** is used with a profile **RFC_ALL** that grants permissions to the BAPIs mentioned below. 

The Web Service Configuration Tool doesn't support the following features exposed in SAP by default: WSP Policies and multiple bindings per endpoint. It does expect a WSDL with SOAP 1.1 only, all-in-one document style binding without policies. 

SAP ECC BAPI functions used in this template: 

 - BAPI_USER_GETLIST - get a list of all users connected to this system. 
 - BAPI_USER_GETDETAIL - get details of specific user. 
 - BAPI_USER_CREATE1 - creates a user. 
 - BAPI_USER_DELETE - deletes a user. 
 - BAPI_USER_CHANGE - updates a user. 

All SAP user properties in this guide are treated as single valued properties. 

The programming language used is Visual Basic. 

## Defining a web service endpoint and creating a schema 

Before you can design import and export workflows, you need to create a template and define an endpoint with the SAP BAPI functions exposed over a SOAP interface. Then create a schema of the ECMA2 objects and their properties is available in this template. 

 1. From the "C:\Program Files\Microsoft ECMA2Host\Web Service Configuration Tool" folder start the Web Service Configuration tool **wsconfigTool.exe**
 2. From the File-New menu choose Create new SOAP Project 
 
:::image type="content" source="media/sap-template/sap-template-1.png" alt-text="Screenshot of create SOAP project." lightbox="media/sap-template/sap-template-1.png":::
 
 3. Click on SOAP Project and choose Add new Web Service.

:::image type="content" source="media/sap-template/sap-template-12.png" alt-text="Screenshot of add new web service." lightbox="media/sap-template/sap-template-12.png":::
 
 4. Name your web service SAPECC, provide a URL to download WSDL published, enter SAPECC as namespace. 
 Web Service name helps you to distinguish this web service in your template from others. Namespace defines a name of the Microsoft .NET namespace used to generate classes. Choose Basic authentication mode unless instructed otherwise by SAP administrator. Click Next.

:::image type="content" source="media/sap-template/sap-template-23.png" alt-text="Screenshot of naming web service." lightbox="media/sap-template/sap-template-23.png"::: 
 
 5. Provide credentials to connect to SAP ECC endpoint. Click Next. 
 6. On the endpoints and operations page ensure that the BAPIs are displayed and click Finish 
 >[!NOTE]
 >if you see more than one endpoint, then you have both SOAP 1.2 and SOAP 1.1 bindings enabled. This causes the connector to fail. Modify your binding definition in SOAMANAGER and keep only one. Then re-add a web service. 
 
:::image type="content" source="media/sap-template/sap-template-45.png" alt-text="Screenshot of BAPIs." lightbox="media/sap-template/sap-template-45.png":::
 
 7. Save the project into C:\Program Files\Microsoft ECMA2Host\Service\ECMA folder. 
 8. Click on Object Types tab and choose to add User object type. Click Ok. 
 9. Expand Object Types tab and click on User type definition. 
  
:::image type="content" source="media/sap-template/sap-template-46.png" alt-text="Screenshot of object types." lightbox="media/sap-template/sap-template-46.png":::
 
 10. Add the following attributes into schema and choose userName as the anchor. 
   
:::image type="content" source="media/sap-template/sap-template-47.png" alt-text="Screenshot of adding attributes." lightbox="media/sap-template/sap-template-47.png":::
 
 11. Save your project. 

 |Name|Type|Anchor|
 |-----|-----|-----|
 |city|string||
 |company|string||
 |department|string||
 |email|string||
 |expirationTime|string||
 |firstName|string||
 |lastName|string||
 |middleName|string||
 |telephoneNumber|string||
 |jobTitle|string||
 |userName|string|checked|

## Creating Full Import workflow 

The Import workflow, while being optional in the ECMA2Host, allows you to import existing SAP users into the ECMA2Host in-memory cache and avoid duplicate users being created during provisioning. 

If you do not create an import workflow, then your connector is operating in Export-only mode and causes the ECMA2Host to always issue **Create user** operations, even for existing users. This may lead to failures or duplicates when standard SAP BAPIs are used unless duplicates are handled by the export workflow. 

SAP ECC doesn't offer a built-in mechanism for reading changes made since the last read. 

Therefore, we're implementing the Full Import workflow only. Should you need to implement Delta Imports for performance reasons, consult your SAP administrator for a list of BAPIs and have them published as a SOAP webservice. Then implement the Delta Import workflow using the below described approach and a customData property that contains a timestamp of the previous successful run. 

SAP ECC offers several BAPI functions to get a list of users with their properties: 

 - BAPI_USER_GETLIST - get a list of all users connected to this system. 
 - BAPI_USER_GETDETAIL - get details of specific user. 

Only these two BAPIs are used to retrieve existing users from SAP ECC in this template. 

 1. Navigate to Object Types -> User -> Import -> Full Import workflow and from the Toolbox on the right drag and drop Sequence activity onto workflow designer pane. 
 2. On the bottom left, find the Variables button and click it to expand a list of variables defined within this Sequence. 
 3. Add the following variables. To select a variable type generated from the SAP WSDL, click to Browse for Types and expand **generated** and then expand SAPECC namespace. 

 |Name|Variable Type|Scope|Default| 
 |-----|-----|-----|-----|
 |selRangeTable|SAPECC.TABLE_OF_BAPIUSSRGE|Sequence|new TABLE_OF_BAPIUSSRGE with {.item = new BAPIUSSRGE(){new BAPIUSSRGE}}| 
 |getListRetTable|SAPECC.TABLE_OF_BAPIRET2|Sequence|new TABLE_OF_BAPIRET2| 
 |pageSize|Int32|Sequence|200| 
 |returnedSize|Int32|Sequence|| 	 
 |usersTable|SAPECC.TABLE_OF_BAPIUSNAME|Sequence|new TABLE_OF_BAPIUSNAME()| 
 

:::image type="content" source="media/sap-template/sap-template-48.png" alt-text="Screenshot of full import operation workflow." lightbox="media/sap-template/sap-template-48.png":::

 4. From the Toolbox drag and drop four Assign activities inside your Sequence activity and set these values: 

 ```
 selRangeTable.item(0).PARAMETER = "USERNAME" 
 selRangeTable.item(0).SIGN = "I" selRangeTable.item(0).OPTION = "GT" selRangeTable.item(0).LOW = ""   
```
 These parameters used to call the BAPI_USER_GETLIST function and to implement pagination. 

:::image type="content" source="media/sap-template/sap-template-49.png" alt-text="Screenshot of full import workflow." lightbox="media/sap-template/sap-template-49.png":::
 
 5. To implement pagination, from the Toolbox drag and drop the DoWhile activity inside your Sequence activity after the last Assign operation. 
 6. On the right pane switch to the Properties tab and enter this condition for the DoWhile 
 - cycle: ```returnedSize = pageSize``` 

:::image type="content" source="media/sap-template/sap-template-2.png" alt-text="Screenshot of returnedsize screen." lightbox="media/sap-template/sap-template-2.png":::

 7. Click on the Variables and add currentPageNumber property of int32 type within DoWhile cycle with default value of 0. 

:::image type="content" source="media/sap-template/sap-template-3.png" alt-text="Screenshot of dowhile screen." lightbox="media/sap-template/sap-template-3.png":::
 
 8. Optional step: if you plan to implement Delta Import workflow, then from the Toolbox drag and drop Assign activity inside your Sequence activity after DoWhile cycle. Set this value: 
 - ```customData(schemaType.Name + "_lastImportTime") = DateTimeOffset.UtcNow.Ticks.ToString()``` 
 This saves the date and time of the last full import run and this timestamp can later be used in Delta Import workflow. 

:::image type="content" source="media/sap-template/sap-template-4.png" alt-text="Screenshot of the customdata screen." lightbox="media/sap-template/sap-template-4.png":::
 
 9. From the Toolbox drag and drop Sequence activity inside your DoWhile activity. Drag and drop WebServiceCall activity inside that Sequence activity and select SAPECC service name, ZSAPCONNECTORWS endpoint and BAPI_USER_GETLIST operation.  

:::image type="content" source="media/sap-template/sap-template-5.png" alt-text="Screenshot of dowhile sequence." lightbox="media/sap-template/sap-template-5.png":::
 
 10. Click on ... Arguments button to define parameters for web service call as follows: 
 
 |Name|Direction|Type|Value| 
 |-----|-----|-----|-----|
 |MAX_ROWS|In|Int32|pageSize| 
 |MAX_ROWSSpecified|In|Boolean|True|
 |RETURN|In/Out|TABLE_OF_BAPIRET2|getListRetTable| 
 |SELECTION_EXP|In/Out|TABLE_OF_BAPIUSSEXP|| 
 |SELECTION_RANGE|In/Out|TABLE_OF_BAPIUSSRGE|selRangeTable| 
 |USERLIST|In/Out|TABLE_OF_BAPIUSNAME|usersTable| 
 |WITH_USERNAME|In|String|| 
 |ROWS|Out|Int32|returnedSize| 
 
 11. Click OK. The warning sign disappears. 
 The list of users stored in the usersTable variable. As SAP doesn't return a complete list of users in one single response, we need to implement pagination and call this function several times while switching pages. Then for every user imported you need to get that user's details by making a separate call. 
 That means that for a landscape with 1000 users and a page size of 200, Web Service connector makes 5 calls to retrieve a list of users and 1000 individual calls to retrieve users' details. 
 To improve performance ask you SAP team to develop a custom BAPI program that lists all uses with their properties to avoid the need of making 1000 individual calls and expose that BAPI function over SOAP WS endpoint. 
 12. From the Toolbox drag and drop IF activity inside your DoWhile activity after WebServiceCall activity. Specify this condition to check for non-empty response and absence of errors: ```IsNothing(getListRetTable.item) OrElse getListRetTable.item.Count(Function(errItem) errItem.TYPE.Equals("E") = True) = 0``` 
 13. From the Toolbox drag and drop Throw activity into Else branch of your IF activity to throw an error on unsuccessful import. Switch to the Properties tab and enter this expression for Exception property of the Throw activity: ```New Exception(getListRetTable.item.First(Function(retItem) retItem.TYPE.Equals("E")).MESSAGE)``` 
 
:::image type="content" source="media/sap-template/sap-template-6.png" alt-text="Screenshot of exception property." lightbox="media/sap-template/sap-template-6.png":::
 
 14. To process a list of imported users, drag and drop ForEachWithBodyFactory activity from the Toolbox into Then branch of your IF activity. Switch to Properties tab and select SAPECC.BAPIUSNAME as TypeArgument. Click on ... button and type this expression for values property: ```if(usersTable.item,Enumerable.Empty(of BAPIUSNAME)())``` 

:::image type="content" source="media/sap-template/sap-template-7.png" alt-text="Screenshot of IF activity." lightbox="media/sap-template/sap-template-7.png":::
 
 15. From the Toolbox drag and drop Sequence activity inside your ForEach activity. Having this Sequence activity window active, click on the Variables button and define these variables:

|Name|Variable Type|Scope|Default| 
|-----|-----|-----|-----|
|company |SAPECC.BAPIUSCOMP |Sequence |new BAPIUSCOMP()|
|address |SAPECC.BAPIADDR3 |Sequence |new BAPIADDR3()|
|defaults |SAPECC.BAPIDEFAUL |Sequence |new BAPIDEFAUL()| 
|logondata |SAPECC.BAPILOGOND |Sequence |new BAPILOGOND()| 
|getDetailRetTable |SAPECC.TABLE_OF_BAPIRET2 |Sequence |new TABLE_OF_BAPIRET2()|

 Your IF activity looks like this: 

:::image type="content" source="media/sap-template/sap-template-8.png" alt-text="Screenshot of IF activity with foreach." lightbox="media/sap-template/sap-template-8.png":::

 16. Drag and drop CreateCSEntryChangeScope activity inside your Sequence activity. In the DN property enter schemaType.Name & item.USERNAME. In the CreateAnchorAttribute AnchorValue field enter item.username. 
   
   :::image type="content" source="media/sap-template/sap-template-9.png" alt-text="Screenshot of CreateCSEntryChangeScope." lightbox="media/sap-template/sap-template-9.png":::
 
 17. To retrieve details of each user, from the Toolbox drag and drop WebServiceCall activity inside Sequence activity right before CreateAnchorAttribute activity. Select SAPECC service name, ZSAPCONNECTORWS endpoint and BAPI_USER_GET_DETAIL operation. Click on ... Arguments button to define parameters for web service call as follows: 

|Name|Direction|Type|Value|
|-----|-----|-----|-----|
|RETURN|In/Out|TABLE_OF_BAPIRET2|getDetailRetTable| 
|USERNAME|In|String|item.username|
|ADDRESS|Out|BAPIADDR3|address| 
|COMPANY|Out|BAPIUSCOMP|company|
|DEFAULTS|Out|BAPIUSDEFAUL|defaults| 
|LOGONDATA|Out|BAPILOGOND|logonData|
|WITH_USERNAME|In|String| 
|ROWS|Out|Int32|returnedSize|

 18. Click OK. The warning sign disappears. The details of a user are stored in the above listed variables. Your IF activity looks like this:
    
:::image type="content" source="media/sap-template/sap-template-10.png" alt-text="Screenshot of parameters." lightbox="media/sap-template/sap-template-10.png":::
 
 19. To check the results of the BAPI_USER_GET_DETAIL operation, from the Toolbox, drag and drop IF activity and place it inside the Sequence activity in between WebServiceCall and CreateAnchorAttribute activities. Enter this condition: ```IsNothing(getDetailRetTable.item) OrElse getDetailRetTable.item.Count(Function(errItem) errItem.TYPE.Equals("E") = True) = 0``` 
 
  As missing user details shouldn't be treated as a catastrophic event, we want to indicate this error and continue processing of other users. Drag and drop Sequence activity into Else branch of your IF activity. Add Log activity inside that new Sequence activity. Switch to Properties tab and change Level property to High, Tag to Trace. Enter the following into LogText property: ```string.Join("\n", getDetailRetTable.item.Select (Function(item) item.MESSAGE ))``` 

 20. Drag and drop Sequence activity into Then branch of IF activity. Drag and drop existing CreateAnchorAttribute activity to Sequence activity inside Then branch of IF activity. Your ForEach activity now looks like this: 

:::image type="content" source="media/sap-template/sap-template-11.png" alt-text="Screenshot of ForEach." lightbox="media/sap-template/sap-template-11.png":::
 
 21. For each property of a user like city, company, department, email add IF activity after CreateAnchorAttribute activity and check for non-empty values by entering conditions like ```Not string.IsNullOrEmpty(address.city)``` and adding CreateAttributeChange activities into Then branch of that IF activity. 

:::image type="content" source="media/sap-template/sap-template-13.png" alt-text="Screenshot of CreateAttributeChange." lightbox="media/sap-template/sap-template-13.png":::
 
 For example: Add CreateAttributeChange activities for all user properties using this mapping table: 

|ECMA User property|SAP property|
|-----|-----| 
|city|address.city| 
|department|address.department| 
|company|company.company| 
|email|address.e_mail| 
|firstName|address.firstName| 
|lastName|address.lastName|
|middleName|address.middleName| 
|jobTitle|address.function| 
|expirationTime|logonData.GLTGB| 
|telephoneNumber|address.TEL1_NUMBR| 
 
 22. Finally, add SetImportStatusCode activity after the last CreateAttributeChange activity. Set ErrorCode to Success in the Then branch. Add one more SetImportStatus code activity into Else branch and set ErrorCode to ImportErrorCustomContinueRun. 

:::image type="content" source="media/sap-template/sap-template-14.png" alt-text="Screenshot of SetImportStatusCode." lightbox="media/sap-template/sap-template-14.png":::
 
 23. Collapse Sequence activity inside ForEach activity so your DoWhile cycle looks like this: 

:::image type="content" source="media/sap-template/sap-template-15.png" alt-text="Screenshot of DoWhile cycle." lightbox="media/sap-template/sap-template-15.png":::
 
 24. To retrieve the next page of users, update ```selRangeTable.item(0).LOW``` property. Drag and drop IF activity into Sequence activity within DoWhile, place it after existing IF activity. Enter returnedSize>0 as Condition. Add Assign activity into Then branch of IF activity and set ```selRangeTable.item(0).LOW``` to ```usersTable.item(returnedSize-1).username```.  

:::image type="content" source="media/sap-template/sap-template-16.png" alt-text="Screenshot of DoWhile final." lightbox="media/sap-template/sap-template-16.png":::
 

 You completed the definition of Full Import workflow. 

## Creating Export Add workflow 

To create a user in SAP ECC you can call BAPI_USER_CREATE1 program and provide all the parameters including an account name and an initial password. If you need an account name to be generated on the SAP side, consult with your SAP administrator and use a custom BAPI function that returns a userName property of a newly created user account. 

This guide doesn't demonstrate assignment of licenses, local or global activity groups, systems or profiles. Consult with your SAP administrator and modify this workflow accordingly. 

There's no need to implement pagination in export workflows. There's only one object objectToExport available within the workflow context. 

 1. Navigate to Object Types -> User -> Export -> Add workflow and from the Toolbox on the right drag and drop Sequence activity onto workflow designer pane. 
 2. On the bottom left, find the Variables button and click it to expand a list of variables defined within this Sequence. 
 3. Add the following variables. To select a variable type generated from the SAP WSDL, click to Browse for Types and expand **generated** and then expand SAPECC namespace. This initializes the data structures used by BAPI_USER_CREATE1 program. 
 
 |Name|Variable Type|Scope|Default|
|-----|-----|-----|-----|
|address|SAPECC.BAPIADDR3|Sequence|new BAPIADDR3()|
|userName|String|Sequence||
|password|SAPECC.BAPIPWD|Sequence|new BAPIPWD()|
|company|SAPECC.BAPIUSCOMP|Sequence|new BAPIUSCOMP()| 
|defaults|SAPECC.BAPIDEFAUL|Sequence|new BAPIDEFAUL()|
|logOnData|SAPECC.BAPILOGOND|Sequence|new BAPILOGOND()|
|bapiret2Table|SAPECC.TABLE_OF_BAPIRET2|Sequence|new TABLE_OF_BAPIRET2()| 
 
 

:::image type="content" source="media/sap-template/sap-template-17.png" alt-text="Screenshot of export add workflow." lightbox="media/sap-template/sap-template-17.png":::

 4. As we defined userName property as an immutable ID, an anchor, we'll need to extract userName value from a collection of anchors of our export object. Drag and drop ForEachWithBodyFactory activity from the Toolbox into your Sequence activity. Replace **item** variable name with **anchor**, switch to properties and choose TypeArgument of ```Microsoft.MetadirectoryServices.AnchorAttribute```. In the Value field type ```objectToExport.AnchorAttributes```. 

:::image type="content" source="media/sap-template/sap-template-18.png" alt-text="Screenshot of export add sequence." lightbox="media/sap-template/sap-template-18.png":::

 5. To extract a string value of a userName anchor, drag and drop Switch activity inside the ForEach activity. In the popup window select ```Microsoft.IdentityManagement.MA.WebServices.Activities.Extensions.AnchorAttributeNameWrapper``` type of a switch. Enter Expression value of: New AnchorAttributeNameWrapper(anchor.Name). 
 6. Click on Add new case area of Switch activity. Type userName as Case Value. Drag and drop Assign activity into userName case body and assign anchor.Value.ToString() to userName variable. 

:::image type="content" source="media/sap-template/sap-template-19.png" alt-text="Screenshot of new case." lightbox="media/sap-template/sap-template-19.png":::
 
 7. Now that we extracted userName value from exported object anchor property, we need to populate other structures like company, defaults, address, logon data that contain other SAP user details. We do this by cycling through collection of attribute changes. 
 8. Collapse your ForEach activity and drag and drop another ForEachWithBothFactory activity inside your Sequence activity after the existing ForEach activity. Replace **item** variable name with **attributeChange**, switch to properties and choose TypeArgument of ```Microsoft.MetadirectoryServices.AttributeChange```. In the Value field type ```objectToExport.AttributeChanges```. 

:::image type="content" source="media/sap-template/sap-template-20.png" alt-text="Screenshot of new sequence." lightbox="media/sap-template/sap-template-20.png":::
 
 9. Drag and drop the Switch activity into the body of your ForEach activity. 
 10. In the popup menu select ```Microsoft.IdentityManagement.MA.WebServices.Activities.Extensions.AttributeNameWrapper``` and click Ok. 
 11. Enter the following expression: New AttributeNameWrapper(attributeChange.Name). You'll see a warning icon in the top right corner of your Switch activity about unhandled attributes defined in schema and not assigned to any property. 
 12. Click on Add new case area of Switch activity and type a case value of **city**. 
 13. Drag and drop Assign activity into the body of this case. Assign ```attributeChange.ValueChanges(0).Value.ToString()``` to address.city. 

:::image type="content" source="media/sap-template/sap-template-21.png" alt-text="Screenshot of new export add workflow." lightbox="media/sap-template/sap-template-21.png":::
 
 14. Add other missing cases and assignments. Use this mapping table as a guide: 

|Case|Assignment|
|-----|-----| 
|city|address.city = attributeChange.ValueChanges(0)Value.ToString()| 
|company|company.company = attributeChange.ValueChanges(0)Value.ToString()| 
|department|address.department = attributeChange.ValueChanges(0)Value.ToString()| 
|email|address.e_mail = attributeChange.ValueChanges(0)Value.ToString()| 
|expirationTime|logOnData.GLTGB = attributeChange.ValueChanges(0)Value.ToString()| 
|firstname|address.firstname = attributeChange.ValueChanges(0)Value.ToString()| 
|lastName|address.lastname = attributeChange.ValueChanges(0)Value.ToString()| 
|middleName|address.middlename = attributeChange.ValueChanges(0)Value.ToString()| 
|telephoneNumber|address.TEL1_Numbr = attributeChange.ValueChanges(0)Value.ToString()| 
|jobTitle|address.function = attributeChange.ValueChanges(0)Value.ToString()| 
|export_password|password.BAPIPWD1 = attributeChange.ValueChanges(0)Value.ToString()| 

 Here export_password is a special virtual attribute that is always defined in the schema and can be used to pass an initial password of user being created. 

:::image type="content" source="media/sap-template/sap-template-22.png" alt-text="Screenshot of cases." lightbox="media/sap-template/sap-template-22.png":::
 

 15. Collapse your ForEach activity and drag and drop the IF activity into the Sequence activity, after the second ForEach activity, to validate the user properties, before submitting the create user request. We need at least 3 non-empty values: username, last name, initial password. Enter this condition: ```(String.IsNullOrEmpty(address.lastname) = False ) AND (String.IsNullOrEmpty(userName) = False) AND (String.IsNullOrEmpty(password.BAPIPWD1) = False)```
 16. In the Else branch of IF activity add one more IF activity as we want to throw different errors depending on what is missing. Enter condition value: String.IsNullOrEmpty(userName). Drag and Drop ```CreateCSEntryChangeResult``` activities into both branches of the second IF activity and set up ErrorCode of ```ExportErrorMissingAnchorComponent``` and ```ExportErrorMissingProvisioningAttribute```. 

:::image type="content" source="media/sap-template/sap-template-24.png" alt-text="Screenshot of second IF activity." lightbox="media/sap-template/sap-template-24.png":::

 17. Drag and drop Sequence activity in the empty Then branch of the first IF activity. Drag and drop WebSeviceCall activity inside the Sequence activity. Select SAPECC service name, ZSAPCONNECTORWS endpoint and BAPI_USER_CREATE1 operation. Click on ... Arguments button to define parameters for web service call as follows:

|Name|Direction|Type|Value|
|-----|-----|-----|-----|
|ADDRESS|In|BAPIADDR3|address| 
|COMPANY|In|BAPIUSCOMP|company| 
|DEFAULTS|In|BAPIDEFAUL|defaults| 
|LOGONDATA|In|BAPILOGOND|logOnData| 
|PASSWORD|In|BAPIPWD|password| 
|RETURN|In-Out|TABLE_OF_BAPIRET2|bapiret2Table| 
|SELF_REGISTER|In|String|"X"| 
|USERNAME|In|String|userName| 

 18. Click OK. The warning sign disappears. 

:::image type="content" source="media/sap-template/sap-template-25.png" alt-text="Screenshot of workflow after parameters." lightbox="media/sap-template/sap-template-25.png":::
 
 19. To process create user request results drag and drop IF activity inside the Sequence activity after the WebServiceCall activity. Enter the following condition: ```IsNothing (bapiret2Table.item) OrElse bapiret2Table.item.Count(Function(errItem) errItem.TYPE.Equals("E") = True) <> 0``` 
 21. If we get no errors, we assume that export operation completed successfully, and we want to indicate successful export of this object by creating CSEntryChangeResult with Success status. Drag and drop CreateCSEntryChangeResult activity into Else branch of your IF activity and select Success error code. 
 22. Optional: If the web service call returns a generated account name of a user, we need to update an anchor value of exported object. To do that, drag and drop ```CreateAttrubuteChange```activity inside the ```CreateCSEntryChangeResult``` activity and select to Add a userName. Then drag and drop ```CreateValueChange``` activity inside the ```CreateAttributeChange``` activity and enter the variable name populated by a web service call activity. In this guide, you use the userName variable that is not updated on export. 

:::image type="content" source="media/sap-template/sap-template-26.png" alt-text="Screenshot of updated sequence flow." lightbox="media/sap-template/sap-template-26.png":::
 
 23. The last step in the Export Add workflow is to handle and log export errors. Drag and drop Sequence activity into the empty Then branch of your IF activity. 
 24. Drag and drop Log activity into Sequence activity. Switch to Properties tab and enter LogText value of: ```bapiret2Table.item.First(Function(retItem) retItem.TYPE.Equals("E"))```.MESSAGE. Keep High logging level and Trace tag. This logs an error message into ConnectorsLog or the ECMA2Host event log when verbose tracing is enabled. 
 25. Drag and drop Switch activity inside the Sequence activity after Log activity. In the popup window select String type of the switch value. Enter the following expression: ```bapiret2Table.item.First(Function(retItem) retItem.TYPE.Equals("E")).NUMBER```
 26. Click on Default case and drag and drop CreateCSEntryChangeResult activity into the body of this case. Choose ExportErrorInvalidProvisioningAttributeValue error code. 
    
:::image type="content" source="media/sap-template/sap-template-27.png" alt-text="Screenshot of new update to workflow." lightbox="media/sap-template/sap-template-27.png":::
 
 27. Click on the Add new case area and type a case value of 224. Drag and drop ```CreateCSEntryChangeResult``` activity into the body of this case. Choose ```ExportErrorCustomContinueRun``` error code. 

:::image type="content" source="media/sap-template/sap-template-28.png" alt-text="Screenshot of final update to workflow." lightbox="media/sap-template/sap-template-28.png":::
 

You completed the definition of Export Add workflow. 

 

## Creating Export Delete workflow 

To delete a user in SAP ECC you can call BAPI_USER_DELETE program and provide an account name to be deleted in connected system. Consult with your SAP Administrator whether this scenario is mandatory as most often SAP ECC accounts aren't to be deleted but to be expired to keep historical records. 

This guide doesn't cover scenarios related to SAP Common User Administration system, deprovisioning of users from connected systems, revocation of licenses, etc. 

There's no need to implement pagination in export workflows. There's only one object objectToExport available within the workflow context. 

 1. Navigate to Object Types -> User -> Export -> Delete workflow and from the Toolbox on the right drag and drop Sequence activity onto workflow designer pane. 
 2. On the bottom left, find the Variables button and click it to expand a list of variables defined within this Sequence. 
 3. Add the following variables. To select a variable type generated from the SAP WSDL, click to Browse for Types and expand **generated** and then expand SAPECC namespace. This initializes the data structures used by BAPI_USER_DELETE program. 

|Name|Variable Type|Scope|Default|
|-----|-----|-----|-----|
|userName|String|Sequence| 
|bapiret2Table|SAPECC.TABLE_OF_BAPIRET2|Sequence|new TABLE_OF_BAPIRET2()|

 4. As we defined userName property as an immutable ID, an anchor, we'll need to extract userName value from a collection of anchors of our export object. Drag and drop ForEachWithBodyFactory activity from the Toolbox into your Sequence activity. Replace **item** variable name with **anchor**, switch to properties and choose TypeArgument of ```Microsoft.MetadirectoryServices.AnchorAttribute```. In the Value field type ```objectToExport.AnchorAttributes```. 

:::image type="content" source="media/sap-template/sap-template-29.png" alt-text="Screenshot of export delete operation workflow." lightbox="media/sap-template/sap-template-29.png":::
 

 5. To extract a string value of a userName anchor, drag and drop Switch activity inside the ForEach activity. In the popup window select ```Microsoft.IdentityManagement.MA.WebServices.Activities.Extensions.AnchorAttributeNameWrapper``` type of a switch. Enter Expression value of: New ```AnchorAttributeNameWrapper(anchor.Name)```. Click on Add new case area of Switch activity. Type userName as Case Value. Drag and drop Assign activity into userName case body and assign ```anchor.Value.ToString()``` to userName variable. 
 6. Drag and drop WebSeviceCall activity inside the Sequence activity after ForEach activity. Select SAPECC service name, ZSAPCONNECTORWS endpoint and BAPI_USER_DELETE operation. Click on ... Arguments button to define parameters for web service call as follows: 

|Name|Direction|Type|Value|
|-----|-----|-----|-----|
|RETURN|In/Out|TABLE_OF_BAPIRET2|bapiret2Table| 
|USERNAME|In|String|userName| 

 7. Click OK. The warning sign disappears.  

:::image type="content" source="media/sap-template/sap-template-30.png" alt-text="Screenshot of updated delete operation workflow." lightbox="media/sap-template/sap-template-30.png":::

 8. To process delete user request results drag and drop IF activity inside the Sequence activity after the WebServiceCall activity. Enter the following condition: ```If(bapiRet2Table.item, Enumerable.Empty(Of BAPIRET2)()).Count(Function(errItem) errItem.TYPE.Equals("E") = True) <> 0```
 9. If we get no errors, we assume that delete operation completed successfully and we want to indicate successful export of this object by creating ```CSEntryChangeResult``` with Success status. Drag and drop ```CreateCSEntryChangeResult``` activity into Else branch of your IF activity and select Success error code.  

:::image type="content" source="media/sap-template/sap-template-31.png" alt-text="Screenshot of export delete workflow." lightbox="media/sap-template/sap-template-31.png":::

 10. The last step in the Export Delete workflow is to handle and log export errors. Drag and drop Sequence activity into the empty Then branch of your IF activity. 
 11. Drag and drop Log activity into Sequence activity. Switch to Properties tab and enter LogText value of: ```bapiRetTable.item.First(Function(retItem) retItem.TYPE.Equals("E")= True).MESSAGE```. Keep High logging level and Trace tag. This logs an error message into the ConnectorsLog or ECMA2Host event log when verbose tracing is enabled. 
 12. Drag and drop Switch activity inside the Sequence activity after Log activity. In the popup window select String type of the switch value. Enter the following expression: ```bapiret2Table.item.First(Function(retItem) retItem.TYPE.Equals("E")).NUMBER``` 
 13. Click on Default case and drag and drop CreateCSEntryChangeResult activity into the body of this case. Choose ExportErrorSyntaxViolation error code.  

:::image type="content" source="media/sap-template/sap-template-32.png" alt-text="Screenshot of update to export delete operation workflow." lightbox="media/sap-template/sap-template-32.png":::

 14. Click on the Add new case area and type a case value of 124. Drag and drop ```CreateCSEntryChangeResult``` activity into the body of this case. Choose ```ExportErrorCustomContinueRun``` error code.  

:::image type="content" source="media/sap-template/sap-template-33.png" alt-text="Screenshot of final export delete operation workflow." lightbox="media/sap-template/sap-template-33.png":::

 You completed the definition of Export Delete workflow. 

## Creating Export Replace workflow 

To update a user in SAP ECC you can call BAPI_USER_CHANGE program and provide all the parameters including an account name and all user details, including those that aren't changing. The ECMA2 export mode when all user properties are to be provided is called Replace. In comparison, export mode of AttributeUpdate only provides you with attributes that are being changed and this may cause some user properties to be overwritten with empty values. Therefore, Webservice connector always uses Object Replace export mode and expects the connector to be configured for Export Type: Replace. 

Export Replace workflow is almost identical to the Export Add workflow. The only difference is that you need to specify extra parameters like addressX or companyX for BAPI_USER_CHANGE program, where X ending in the addressX indicates that the structure of address does contain a change. 

 1. Navigate to Object Types -> User -> Export -> Replace workflow and from the Toolbox on the right drag and drop Sequence activity onto workflow designer pane. 
 2. On the bottom left, find the Variables button and click it to expand a list of variables defined within this Sequence. 
 3. Add the following variables. To select a variable type generated from the SAP WSDL, click to Browse for Types and expand **generated** and then expand SAPECC namespace. This initializes the data structures used by BAPI_USER_CHANGE program. 

|Name|Variable Type|Scope|Default| 
|-----|-----|-----|-----|
|userName|String|Sequence|| 
|bapiret2Table|SAPECC.TABLE_OF_BAPIRET2|Sequence|new TABLE_OF_BAPIRET2()| 
|addressX|SAPECC.BAPIADDR3X|Sequence|new BAPIADDR3X()| 
|address|SAPECC.BAPIADDR3|Sequence|new BAPIADDR3()| 
|companyX|SAPECC. BAPIUSCOMX|Sequence|new BAPIUSCOMX()| 
|company|SAPECC.BAPIUSCOMP|Sequence|new BAPIUSCOMP()| 
|defaultsX|SAPECC.BAPIDEFAX|Sequence|new BAPIDEFAX()| 
|defaults|SAPECC.BAPIDEFAUL|Sequence|new BAPIDEFAUL()| 
|logOnDataX|SAPECC.BAPILOGONX|Sequence|new BAPILOGONX()| 
|logOnData|SAPECC.BAPILOGOND|Sequence|new BAPILOGOND()| 

Your Export Replace workflow looks like this: 

:::image type="content" source="media/sap-template/sap-template-35.png" alt-text="Screenshot of start of replace operation workflow." lightbox="media/sap-template/sap-template-35.png":::

 4. As we defined userName property as an immutable ID, an anchor, we'll need to extract userName value from a collection of anchors of our export object. Drag and drop ForEachWithBodyFactory activity from the Toolbox into your Sequence activity. Replace **item** variable name with **anchor**, switch to properties and choose TypeArgument of ```Microsoft.MetadirectoryServices.AnchorAttribute```. In the Value field type ```objectToExport.AnchorAttributes```. 

:::image type="content" source="media/sap-template/sap-template-36.png" alt-text="Screenshot of update to replace operation workflow." lightbox="media/sap-template/sap-template-36.png":::

 5. To extract a string value of a userName anchor, drag and drop Switch activity inside the ForEach activity. In the popup window select ```Microsoft.IdentityManagement.MA.WebServices.Activities.Extensions.AnchorAttributeNameWrapper``` type of a switch. Enter Expression value of: New ```AnchorAttributeNameWrapper(anchor.Name)```. Click on Add new case area of Switch activity. Type userName as Case Value. Drag and drop Assign activity into userName case body and assign ```anchor.Value.ToString()``` to userName variable.  Your Export Replace workflow looks like this: 

:::image type="content" source="media/sap-template/sap-template-37.png" alt-text="Screenshot of another update to replace operation workflow." lightbox="media/sap-template/sap-template-37.png":::

 6. Now that we extracted userName value from exported object anchor property, we need to populate other structures like company, defaults, address, logon data that contain other SAP user details. We do this by cycling through collection of all attributes defined in the schema. 
 7. Collapse your ForEach activity and drag and drop another ForEachWithBothFactory activity inside your Sequence activity after the existing ForEach activity. Replace **item** variable 
name with **schemaAttr**, switch to properties and choose TypeArgument of ```Microsoft.MetadirectoryServices.SchemaAttribute```. In the Value field type ```schemaType.Attributes```. 

:::image type="content" source="media/sap-template/sap-template-38.png" alt-text="Screenshot of replace operation sequence activity." lightbox="media/sap-template/sap-template-38.png":::

 8. Drag and drop the Sequence activity into the body of your ForEach activity. On the bottom left, find the Variables button and click it to expand a list of variables defined within this Sequence. Add the following variable: xValue of String type. Drag and drop Assign activity into your Sequence activity. Assign xValue the expression of: ```If(objectToExport.AttributeChanges.Contains(schemaAttr.Name), objectToExport.AttributeChanges(schemaAttr.Name).ValueChanges(0).Value.ToString(), String.Empty)```  It will either extract the changes staged for export for this attribute or initialize it with an empty string. Your Export Replace workflow looks like this: 

:::image type="content" source="media/sap-template/sap-template-39.png" alt-text="Screenshot of update to the replace sequence." lightbox="media/sap-template/sap-template-39.png":::

 9. Drag and drop the Switch activity after Assign activity. In the popup menu select ```Microsoft.IdentityManagement.MA.WebServices.Activities.Extensions.AttributeNameWrapper``` and click Ok. Enter the following expression: New ```AttributeNameWrapper(schemaAttr.Name)```. You'll see a warning icon in the top right corner of your Switch activity about unhandled attributes defined in the schema and not assigned to any property. Click on Add new case area of Switch activity and type a case value of **city**. Drag and drop Sequence activity into the body of this case. Drag and drop the Assign activity into the body of this case. Assign "X" value to addressX.city. Drag and drop another Assign activity into the body of this case. Assign xValue to address.city. Your Export Replace workflow looks like this: 

:::image type="content" source="media/sap-template/sap-template-40.png" alt-text="Screenshot of drag and drop switch activity." lightbox="media/sap-template/sap-template-40.png":::

 10.Add other missing cases and assignments. Use this mapping table as a guide: 

|Case|Assignment| 
|-----|-----|
|city|addressX.city = "X" address.city = xValue| 
company|companyX.company = "X" company.company = xValue| 
department|address.departmentX = "X" address.department = xValue| 
email|addressX.e_mail = "X" address.e_mail = xValue| 
expirationTime|logOnDataX.GLTGB = "X" logOnData.GLTGB = xValue| 
firstname|addressX.firstname = "X" address.firstname = xValue| 
lastName|addressX.lastname = "X" address.lastname = xValue| 
middleName|addressX.middlename = "X" address.middlename = xValue| 
telephoneNumber|addressX.TEL1_Numbr = "X" address.TEL1_Numbr = xValue| 
jobTitle|addressX.function = "X" address.function = xValue| 

Your Export Replace workflow looks like this: 

:::image type="content" source="media/sap-template/sap-template-41.png" alt-text="Screenshot of second drag and drop switch activity." lightbox="media/sap-template/sap-template-41.png":::


 11. Before calling BAPI_USER_CHANGE program, we need to check for non-empty username. Collapse both ForEach activities and drag and drop IF activity after the second ForEach activity. Enter the following condition: ```String.IsNullOrEmpty(userName ) = False``` 
 12. When username is empty, we want to indicate that operation was unsuccessful. Drag and drop ```CreateCSEntryChangeResult``` activity into the Else branch of your IF activity and select ```ExportErrorCustomContinueRun``` error code. Your Export Replace workflow looks like this: 
:::image type="content" source="media/sap-template/sap-template-42.png" alt-text="Screenshot of CreateCSEntryChangeResult activity." lightbox="media/sap-template/sap-template-42.png":::

 13. Drag and drop the Sequence activity in the empty Then branch of the first IF activity. Drag and drop WebSeviceCall activity inside the Sequence activity. Select SAPECC service name, ZSAPCONNECTORWS endpoint and BAPI_USER_CHANGE operation. Click on ... Arguments button to define parameters for web service call as follows: 

|Name|Direction|Type|Value|
|-----|-----|-----|-----| 
|ADDRESS|In|BAPIADDR3|address| 
|ADDRESSX|In|BAPIADDR3X|addressX| 
|COMPANY|In|BAPIUSCOMP|company| 
|COMPANYX|In|BAPIUSCOMX|company| 
|DEFAULTS|In|BAPIDEFAUL|defaults| 
|DEFAULTSX|In|BAPIDEFAX|defaultsX| 
|LOGONDATA|In|BAPILOGOND|logOnData| 
|LOGONDATAX|In|BAPILOGONX|logOnDataX| 
|RETURN|In/Out|TABLE_OF_BAPIRET2|bapiret2Table| 
|USERNAME|In|String|userName| 

 14. Click OK. The warning sign disappears. Your Export Replace workflow looks like this: 
    
:::image type="content" source="media/sap-template/sap-template-43.png" alt-text="Screenshot of BAPI_USER_CHANGE operation." lightbox="media/sap-template/sap-template-43.png":::

 15. To process change user request results, drag and drop the IF activity inside the Sequence activity after the WebServiceCall activity. Enter the following condition: ```Not IsNothing(bapiret2Table.item) AndAlso bapiret2Table.item.Count(Function(errItem) errItem.TYPE.Equals("E") = True) <> 0```
 16. If we get no errors, we assume that export operation completed successfully, and we want to indicate successful export of this object by creating ```CSEntryChangeResult``` with Success status. Drag and drop ```CreateCSEntryChangeResult``` activity into Else branch of your IF activity and select Success error code. 
 17. Drag and drop Sequence activity into Then branch of your IF activity. Add Log activity with LogText value of ```string.Join("\n",bapiret2Table.item.Where(Function(retItem) retItem.TYPE.Equals("E")).Select(Function(r) r.MESSAGE))``` and Error tag. Add ```CreateCSEntryChangeResult``` activity after Log activity with error code of ```ExportErrorCustomContinueRun```. Your Export Replace workflow looks like this: 

:::image type="content" source="media/sap-template/sap-template-44.png" alt-text="Screenshot of final export replace workflow." lightbox="media/sap-template/sap-template-44.png":::

 You completed the definition of Export Replace workflow. 

 

The next step is to configure [ECMA2Host Webservice connector](~/identity/app-provisioning/on-premises-sap-connector-configure.md) using this template. 

## Next steps



* [Migrate identity management scenarios from SAP IDM to Microsoft Entra](migrate-from-sap-idm.md)
* [Deploy SAP NetWeaver AS ABAP 7.51](deploy-sap-netweaver.md)
* [Configuring Microsoft Entra ID to provision users into SAP ECC with NetWeaver AS ABAP 7.0 or later](~/identity/app-provisioning/on-premises-sap-connector-configure.md)