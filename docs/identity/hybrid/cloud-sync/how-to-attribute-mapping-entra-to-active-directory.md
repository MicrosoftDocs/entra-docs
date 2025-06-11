---
title: 'Attribute mapping - Microsoft Entra ID to Active Directory'
description: This article describes how the attribute mapping and how to configure attributes when provisioning from Microsoft Entra ID to Active Directory.

author: billmath
manager: femila
ms.service: entra-id
ms.topic: how-to
ms.date: 04/09/2025
ms.subservice: hybrid-cloud-sync
ms.author: billmath

---



# Scoping filter and attribute mapping - Microsoft Entra ID to Active Directory
You can customize the default attribute-mappings according to your business needs. So, you can change or delete existing attribute-mappings, or create new attribute-mappings. 


:::image type="content" source="media/how-to-configure-entra-to-active-directory/entra-to-ad-6.png" alt-text="Screenshot of the attribute based scoping." lightbox="media/how-to-configure-entra-to-active-directory/entra-to-ad-6.png":::

The following document will guide you through attribute scoping with Microsoft Entra Cloud Sync for provisioning from Microsoft Entra ID to Active Directory. If you're looking for information on attribute mapping from AD to Microsoft Entra ID, see [ Attribute mapping - Active Directory to Microsoft Entra ID](how-to-attribute-mapping.md).

## Schema for Microsoft Entra ID to Active Directory configurations
Currently, the AD Schema isn't discoverable and there's fixed set of mappings. The following table provides the default mappings and schema for the Microsoft Entra ID to Active Directory configurations.

|Target attribute|Source attribute|Mapping type|Notes|
|-----|-----|-----|-----|
|adminDescription|Append("Group_",[objectId])|Expression|CANNOT UPDATE IN UI - DO NOT UPDATE</br></br>Used for filtering out AD to cloud sync</br></br>Not visible in UI|
|cn|Append(Append(Left(Trim([displayName]),51),"_"),Mid([objectId],25,12))|Expression||
|description|Left(Trim([description]),448)|Expression||
|displayName|displayName|Direct||
|isSecurityGroup|True|Constant|CANNOT UPDATE IN UI - DO NOT UPDATE</br></br>Not visible in UI|
|member|members|Direct|CANNOT UPDATE IN UI - DO NOT UPDATE</br></br>Not visible in UI|
|msDS-ExternalDirectoryObjectId|Append("Group_",[objectId])|Expression|CANNOT UPDATE IN UI - DO NOT UPDATE</br></br>Used for joining - matching in AD</br></br>Not visible in UI|
|ObjectGUID|||CANNOT UPDATE IN UI - DO NOT UPDATE</br></br>Read only - anchor in AD</br></br>Not visible in UI|
|parentDistinguishedName|OU=Users,DC=&lt;domain selected at configuration start&gt;,DC=com|Constant|Default in the UI|
|UniversalScope|True|Constant|CANNOT UPDATE IN UI - DO NOT UPDATE</br></br>Not visible in UI|

Be aware that not all of the above mappings are visible in the portal. For more information on how to add an attribute mapping see, see [attribute mapping](how-to-attribute-mapping.md#add-an-attribute-mapping---microsoft-entra-id-to-ad-preview).

### sAmAccountName custom mapping
The sAMAccount attribute isn't, by default, synchronized from Microsoft Entra ID to Active Directory.  Because of this, when the new group is created in Active Directory, it's given a randomly generated name.

:::image type="content" source="media/how-to-attribute-mapping-entra-to-active-directory/sam-account-1.png" alt-text="Screenshot sAMAccountName using ADSI Edit." lightbox="media/how-to-attribute-mapping-entra-to-active-directory/sam-account-1.png":::

If you want your own unique value for sAMAccountName, you can create a custom mapping to sAMAccountName using an expression.  For example, you could do something like:  `Join("_", [displayName], "Contoso_Group")`

:::image type="content" source="media/how-to-attribute-mapping-entra-to-active-directory/sam-account-2.png" alt-text="Screenshot of an expression for sAMAccountName in the portal." lightbox="media/how-to-attribute-mapping-entra-to-active-directory/sam-account-2.png":::

This will take the displayName value and add "Contoso_Group" to it.  So the new sAMAccountName would be something like, Marketing_Contoso_Group

:::image type="content" source="media/how-to-attribute-mapping-entra-to-active-directory/sam-account-3.png" alt-text="Screenshot of the sAMAccountName value after expression." lightbox="media/how-to-attribute-mapping-entra-to-active-directory/sam-account-3.png":::

>[!IMPORTANT]
>If you decide create a custom attribute mapping for sAMAccountName, you must ensure that it's unique within Active Directory.

## Scoping filter target container
The default target container is OU=User,DC=&lt;domain selected at configuration start&gt,DC=com. You can change this to be your own custom container.

Multiple target containers can also be configured using an attribute mapping expression with the Switch() function. With this expression, if the displayName value is Marketing or Sales, the group is created in the corresponding OU. If there's no match, then the group is created in the default OU.

 ```Switch([displayName],"OU=Default,OU=container,DC=contoso,DC=com","Marketing","OU=Marketing,OU=container,DC=contoso,DC=com","Sales","OU=Sales,OU=container,DC=contoso,DC=com") ```

 :::image type="content" source="media/how-to-configure-entra-to-active-directory/config-6.png" alt-text="Screenshot of the scoping filters expression." lightbox="media/how-to-configure-entra-to-active-directory/config-6.png":::

Another example for this is shown below. Imagine you have the following 3 groups and they have the following displayName attribute values:


 - NA-Sales-Contoso
 - SA-Sales-Contoso
 - EU-Sales-Contoso

You could use the following switch statement to filter and provision the groups:

``` Switch(Left(Trim([displayName]), 2), "OU=Groups,DC=contoso,DC=com", "NA","OU=NorthAmerica,DC=contoso,DC=com", "SA","OU=SouthAmerica,DC=contoso,DC=com", "EU", "OU=Europe,DC=contoso,DC=com") ```

This statement will, by default provision all groups to the OU=Groups,DC=contoso,DC=com container in Active Directory. However, if the group begins with NA, it will provision the group to OU=NorthAmerica,DC=contoso,DC=com. Likewise, if the group begins with SA to OU=SouthAmerica,DC=contoso,DC=com and EU to OU=Europe,DC=contoso,DC=com.


For more information, see [Reference for writing expressions for attribute mappings in Microsoft Entra ID](../../app-provisioning/functions-for-customizing-application-data.md).

## Attribute scope filtering
Attribute based scope filtering is supported. You can scope groups based on certain attributes. However, be aware that the attribute mapping section for a Microsoft Entra ID to Active Directory configuration is slightly different than the traditional attribute mapping section.

:::image type="content" source="media/how-to-configure-entra-to-active-directory/entra-to-ad-6.png" alt-text="Screenshot of the attribute based scoping." lightbox="media/how-to-configure-entra-to-active-directory/entra-to-ad-6.png":::




### Supported clauses

A scoping filter consists of one or more clauses. Clauses determine which groups are allowed to pass through the scoping filter by evaluating each group's attributes. For example, you might have one clause that requires that a groups "displayName" attribute equals "Marketing", so only Marketing groups are provisioned.

### The default security grouping
The default security grouping is applied on top of every clause created and uses the "AND" logic. It contains the following conditions:
 - securityEnabled IS True AND 
 - dirSyncEnabled IS FALSE AND 
 - mailEnabled IS FALSE
 
The default security grouping is ALWAYS applied first and uses the AND logic when working with a single clause. Clause will then follow the logic outlined below.

A single clause defines a single condition for a single attribute value. If multiple clauses are created in a single scoping filter, they're evaluated together using "AND" logic. The "AND" logic means all clauses must evaluate to "true" in order for a user to be provisioned.

:::image type="content" source="media/how-to-configure-entra-to-active-directory/entra-to-ad-8.png" alt-text="Screenshot of AND clause attribute based scoping." lightbox="media/how-to-configure-entra-to-active-directory/entra-to-ad-8.png":::

Finally, multiple scoping filters can be created for a group. If multiple scoping filters are present, they're evaluated together by using "OR" logic. The "OR" logic means that if either of the clauses in any of the configured scoping filters evaluate to "true", the group is provisioned.

:::image type="content" source="media/how-to-configure-entra-to-active-directory/entra-to-ad-9.png" alt-text="Screenshot of OR clause attribute based scoping." lightbox="media/how-to-configure-entra-to-active-directory/entra-to-ad-9.png":::


### Supported operators
The following operators are supported:

|Operator|Description|
|-----|-----|
|&||
|ENDS_WITH||
|EQUALS|Clause returns "true" if the evaluated attribute matches the input string value exactly (case sensitive).|
|GREATER_THAN|Clause returns "true" if the evaluated attribute is greater than the value. The value specified on the scoping filter must be an integer and the attribute on the user must be an integer [0,1,2,...].|
|GREATER_THAN_OR_EQUALS| Clause returns "true" if the evaluated attribute is greater than or equal to the value. The value specified on the scoping filter must be an integer and the attribute on the user must be an integer [0,1,2,...].|
|INCLUDES||
|IS FALSE| Clause returns "true" if the evaluated attribute contains a Boolean value of false.|
|IS_MEMBER_OF||
|isn't NULL|Clause returns "true" if the evaluated attribute isn't empty.|
|IS NULL|Clause returns "true" if the evaluated attribute is empty.|
|IS TRUE|Clause returns "true" if the evaluated attribute contains a Boolean value of true.|
|!&L||
|NOT EQUALS|Clause returns "true" if the evaluated attribute doesn't match the input string value (case sensitive).|
|NOT REGEX MATCH|Clause returns "true" if the evaluated attribute doesn't match a regular expression pattern. It returns "false" if the attribute is null / empty.|
|PRESENT||
|REGEX MATCH|Clause returns "true" if the evaluated attribute matches a regular expression pattern. For example: ([1-9][0-9]) matches any number between 10 and 99 (case sensitive).|
|VALID CERT MATCH||

### Using Regular Expressions to filter on
A more advanced filter might use a REGEX MATCH. This allows you to search an attribute as a string for a substring of that attribute. For instance, lets say that you have several groups and they all have the following descriptions:

  Contoso-Sales-US
  Contoso-Marketing-US
  Contoso-Operations-US
  Contoso-LT-US

Now, you only want to provision the Sales, Marketing, and Operations groups to Active Directory. You could use a REGEX MATCH to achieve this. 

```REGEX MATCH description (?:^|\W)Sales|Marketing|Operations(?:$|\W)```

This REGEX MATCH will search the descriptions for any of the following words we have supplied and provision only those groups.


:::image type="content" source="media/how-to-attribute-mapping-entra-to-active-directory/regex-filter-1.png" alt-text="Screenshot REGEX MATCH based scoping." lightbox="media/how-to-attribute-mapping-entra-to-active-directory/regex-filter-1.png":::








### Create an attribute based filter
To create an attribute based filter use the following steps:

1. Click **Add attribute filter**
2. In the **Name** box, provide a name for your filter
3. From the drop-down, under **Target attribute** select the target attribute
4. Under **Operator**, select an operator.
5. Under **Value**, specify a value.
6. Click **Save**.

:::image type="content" source="media/how-to-configure-entra-to-active-directory/entra-to-ad-7.png" alt-text="Screenshot of the setting up attribute based scoping." lightbox="media/how-to-configure-entra-to-active-directory/entra-to-ad-7.png":::

For more information, see [attribute mapping](how-to-attribute-mapping.md#add-an-attribute-mapping---microsoft-entra-id-to-ad-preview) and [Reference for writing expressions for attribute mappings in Microsoft Entra ID](../../app-provisioning/functions-for-customizing-application-data.md).

## Next steps 
- [Group writeback with Microsoft Entra Cloud Sync ](../group-writeback-cloud-sync.md)
- [Govern on-premises Active Directory based apps (Kerberos) using Microsoft Entra ID Governance](govern-on-premises-groups.md)
- [Migrate Microsoft Entra Connect Sync group writeback V2 to Microsoft Entra Cloud Sync](migrate-group-writeback.md)
