---
title: 'Custom reports using Microsoft Entra and application data'
description: Tutorial that describes how to create customized reports in Azure Data Explorer using data from Microsoft Entra.
author: billmath
manager: amycolannino
ms.service: entra-id-governance
ms.topic: overview
ms.date: 12/30/2024
ms.author: billmath
---

# Tutorial: Customized reports in Azure Data Explorer using data from Microsoft Entra

In this tutorial, you learn how to create customized reports in [Azure Data Explorer (ADX)](/azure/data-explorer/data-explorer-overview) using data from Microsoft Entra ID and Microsoft Entra ID Governance services. This tutorial complements other reporting options such as [Archive & report with Azure Monitor and entitlement management](entitlement-management-logs-and-reporting.md), which focuses on exporting the audit log into Azure Monitor for retention and analysis. By comparison, exporting Microsoft Entra ID data to Azure Data Explorer provides flexibility for creating custom reports on Microsoft Entra objects, including historical and deleted objects. In addition, use of Azure Data Explorer enables data aggregation from additional sources, with massive scalability, flexible schema, and retention policies. Azure Data Explorer is especially helpful when you need to retain access data for years, perform ad-hoc investigations, or need to run custom queries on user access data.

This article illustrates how to show configuration, users, and access rights exported from Microsoft Entra alongside data exported from other sources, such as applications with access rights in their own SQL databases. You can then use the Kusto Query Language (KQL) in Azure Data Explorer to build custom reports based on your organization's requirements. 

Use the following steps to create these reports: 

 1. [Set up Azure Data Explorer](#1-setup-azure-data-explorer) in an Azure subscription, or create a free cluster.
 2. [Extract data from Microsoft Entra ID](#2-extract-microsoft-entra-id-data-with-powershell) using PowerShell scripts and Microsoft Graph.
 3. [Import that data from Microsoft Entra ID into Azure Data Explorer](#3-import-json-files-with-data-from-microsoft-entra-id-into-azure-data-explorer).
 1. [Extract data from Microsoft Entra ID Governance](#4-extract-microsoft-entra-id-governance-data-with-powershell).
 1. [Import that data from Microsoft Entra ID Governance into Azure Data Explorer](#5-import-json-files-with-data-from-microsoft-entra-id-governance-into-azure-data-explorer).
 1. [Build a custom query](#6-use-azure-data-explorer-to-build-custom-reports) using Kusto Query Language.

By the end of this tutorial, you'll be able to develop customized views of the access rights and permissions of users. These views span across different applications using Microsoft supported tools. You can also bring in data from third-party databases or applications to report on those as well.

## Prerequisites

If you're new to Azure Data Explorer and wish to learn the scenarios shown in this article, you can obtain a [free Azure Data Explorer cluster](/azure/data-explorer/start-for-free). For production supported use with a service level agreement for Azure Data Explorer, you need an Azure subscription to host a full Azure Data Explorer cluster.

Determine what data you want to include in your reports. The scripts in this article provide samples with specific data from users, groups, and applications from Microsoft Entra. These samples are meant to illustrate the types of reports you can generate with this approach, but your specific reporting needs may vary and require different or additional data. You can start with these objects and bring in more kinds of Microsoft Entra objects over time.

- This article illustrates retrieving data from Microsoft Entra as a signed-in user. To do so, ensure you have the required role assignments to retrieve data from Microsoft Entra. You need the roles with the right permissions to export the type of Microsoft Entra data you would like to work with. 
  - User data: Global Administrator, Privileged Role Administrator, User Administrator 
  - Groups data: Global Administrator, Privileged Role Administrator, Group Administrator 
  - Applications/App Role Assignments: Global Administrator, Privileged Role Administrator, Application Administrator, Cloud Application Administrator 
- Microsoft Graph PowerShell must be consented to allow for retrieval of Microsoft Entra objects via Microsoft Graph. The examples in this tutorial require the delegated User.Read.All, Group.Read.All, Application.Read.All, and Directory.Read.All permissions. If you're planning on retrieving data using automation without a signed-in user, then consent to the corresponding application permissions instead. See [Microsoft Graph permissions reference](/graph/permissions-reference) for additional information. If you haven't already consented Microsoft Graph PowerShell to those permissions, you need to be a Global Administrator to perform this consent operation.
- This tutorial does not illustrate custom security attributes. By default, Global Administrator and other administrator roles don't include permissions to read custom security attributes from Microsoft Entra users. If you're planning on retrieving custom security attributes, then more roles and permissions may be required.
- On the computer where Microsoft Graph PowerShell is installed, ensure you have write access to the file system directory. This is where you install the required Microsoft Graph PowerShell modules and where the exported Microsoft Entra data is saved. 
- Ensure you have permissions to retrieve data from other data sources beyond Microsoft Entra, if you wish to incorporate that data into Azure Data Explorer as well.

## 1: Setup Azure Data Explorer 

If you haven’t previously used Azure Data Explorer, you need to set this up first. You can create a [free cluster without an Azure subscription or credit card](/azure/data-explorer/start-for-free) or a full cluster which requires an Azure subscription. See [Quickstart: Create an Azure Data Explorer cluster and database](/azure/data-explorer/create-cluster-and-database) to get started. 

## 2: Extract Microsoft Entra ID data with PowerShell 

In this section, you [install Microsoft Graph PowerShell modules](/powershell/microsoftgraph/installation) and, in PowerShell, [connect to Microsoft Graph](/powershell/module/microsoft.graph.authentication/connect-mggraph) to extract Microsoft Entra ID data.

The first time your organization uses these modules for this scenario, you need to be in a Global Administrator role to allow Microsoft Graph PowerShell to grant consent for use in your tenant. Subsequent interactions can use a lower-privileged role.

 1. Open PowerShell.
 1. If you don't have all the [Microsoft Graph PowerShell modules](https://www.powershellgallery.com/packages/Microsoft.Graph) already installed, install the required Microsoft Graph modules. The following modules are required for this section of the tutorial: `Microsoft.Graph.Authentication`, `Microsoft.Graph.Users`, `Microsoft.Graph.Groups`, `Microsoft.Graph.Applications`, `Microsoft.Graph.DirectoryObjects`. If you already have these modules installed, then continue at the next step.

```powershell
   $modules = @('Microsoft.Graph.Users', 'Microsoft.Graph.Groups', 'Microsoft.Graph.Applications', 'Microsoft.Graph.DirectoryObjects') 
   foreach ($module in $modules) { 
   Install-Module -Name $module -Scope CurrentUser -AllowClobber -Force
   } 
```  
 2. Import the modules into the current PowerShell session. 
 
 ```powershell
   $modules = @('Microsoft.Graph.Users', 'Microsoft.Graph.Groups', 'Microsoft.Graph.Applications', 'Microsoft.Graph.DirectoryObjects') 
   foreach ($module in $modules) { 
   Import-Module -Name $module 
   } 
``` 
 3. Connect to Microsoft Graph. This section of the tutorial illustrates reading users, groups, and applications, so requires the `User.Read.All`, `Group.Read.All`, `Application.Read.All`, and `Directory.Read.All` permission scopes. For more information on permissions, see [Microsoft Graph permissions reference](/graph/permissions-reference).
 
```powershell
  Connect-MgGraph -Scopes "User.Read.All", "Group.Read.All", "Application.Read.All", "Directory.Read.All" -ContextScope Process -NoWelcome
``` 

 This command prompts you to sign in with your Microsoft Entra credentials. After signing in, you may need to consent to the required permissions if it's your first time connecting, or if new permissions are required.
  

### PowerShell Queries to extract Microsoft Entra ID data needed to build custom reports in Azure Data Explorer

The following queries extract Microsoft Entra ID data from Microsoft Graph using PowerShell and export the data to JSON files which are imported into Azure Data Explorer in the subsequent section 3. There may be multiple scenarios for generating reports with this type of data, including:

 - An auditor would like to see a report that lists the group members for 10 groups, organized by the members’ department. 
 - An auditor would like to see a report of all users who had access to an application between two dates. 
 
You can also bring in data to Azure Data Explorer from other sources beyond Microsoft Entra. This enables scenarios such as:

- An admin would like to view all users added to an application from Microsoft Entra ID and their access rights in the application's own repository, such as SQL databases. 

These types of reports aren't built in to Microsoft Entra ID. However, you can create these reports yourself by extracting data from Entra and combining them using custom queries in Azure Data Explorer. This will be addressed later in the tutorial in [bring in data from other sources](#bring-in-data-from-other-sources) section.

For this tutorial, we extract Microsoft Entra ID data from several areas: 

 - User information such as display name, UPN, and job details 
 - Group information including their memberships
 - Application and application role assignments

This data set enables us to perform a broad set of queries around who was given access to an application, with their application role information, and the associated timeframe. Note that these are sample queries, and your data and specific requirements may vary from what is shown here.

>[!NOTE]
> Larger tenants may experience throttling / 429 errors that are handled by the Microsoft Graph module. Azure Data Explorer may also limit file upload sizes.

In these PowerShell scripts, we export selected properties from the Microsoft Entra objects to JSON files. The data from these exported properties is used to generate custom reports in Azure Data Explorer. The specific properties that follow were included in these examples, because we're using this data to illustrate the types of reports you can create in Azure Data Explorer. Since your specific reporting needs likely vary from what is shown, you should include the specific properties in these scripts that you're interested in viewing in your reports. However, you can follow the same pattern shown to help build your scripts. 

### Select a snapshot date

We included a hard-coded **snapshot date** which identifies the data in the JSON file with a specific date and allows us to keep track of similar data sets over time in Azure Data Explorer. The snapshot date is also useful for comparing changes in data between two snapshot dates. 

```powershell
$SnapshotDate = Get-Date -AsUTC -Format "yyyy-MM-dd"
```

### Get Entra user data 

This script exports selected properties from the Entra user object to a JSON file. We'll import this and additional data from other JSON files into Azure Data Explorer in a [subsequent section of this tutorial](#3-import-json-files-with-data-from-microsoft-entra-id-into-azure-data-explorer).

     
```powershell
  function Export-EntraUsersToJson { 

  # Define a hash table for property mappings 
   $propertyMappings = @{ 
    "Id" = "ObjectID" 
    "DisplayName" = "DisplayName" 
    "UserPrincipalName" = "UserPrincipalName" 
    "EmployeeId" = "EmployeeId" 
    "UserType" = "UserType" 
    "CreatedDateTime" = "CreatedDateTime" 
    "JobTitle" = "JobTitle" 
    "Department" = "Department" 
    "AccountEnabled" = "AccountEnabled" 

   # Add custom properties as needed 
    "custom_extension" = "CustomExtension" 
   } 
  # Retrieve users with specified properties and create custom objects directly 
   $users = Get-MgUser -Select ($propertyMappings.Keys) -All | ForEach-Object { 
      $userObject = @{} 
      foreach ($key in $propertyMappings.Keys) { 
        if ($key -eq "CreatedDateTime") { 
          # Convert date string directly to DateTime and format it 
          $date = [datetime]::Parse($_.$key) 
          $userObject[$propertyMappings[$key]] = $date.ToString("yyyy-MM-dd") 
        } else { 
          $userObject[$propertyMappings[$key]] = $_.$key 
        } 
      } 
      # Additional properties or transformations 
      $userObject["SnapshotDate"] = $SnapshotDate
      [pscustomobject]$userObject 
    } 
    # Convert the user data to JSON and save it to a file 
    $users | ConvertTo-Json -Depth 2 | Set-Content ".\EntraUsers.json" 
  } 
  # Execute the function 
  Export-EntraUsersToJson 
```
### Get Group data 

Generate a JSON file with group names and IDs that are used to create custom views in Azure Data Explorer. The sample includes all groups, but additional filtering can be included if needed. If you're filtering to only include certain groups, you may want to include logic in your script to check for nested groups. 
```powershell
    # Get all groups and select Id and DisplayName 
    $groups = Get-MgGroup -All | Select-Object Id,DisplayName 
    # Export the groups to a JSON file 
    $groups | ConvertTo-Json | Set-Content ".\EntraGroups.json" 
```
### Get Group Membership data 

Generate a JSON file with group membership which is used to create custom views in Azure Data Explorer. 
```powershell
    # Retrieve all groups from Microsoft Entra (Azure AD) 
    $groups = Get-MgGroup -All 
    # Initialize an array to store results 
    $results = @() 
    # Iterate over each group 
    foreach ($group in $groups) { 
      # Extract the group ID 
      $groupId = $group.Id 
      # Get members of the current group and select their IDs 
      $members = Get-MgGroupMember -GroupId $groupId | Select-Object -ExpandProperty Id 
      # Add a custom object with group ID and member IDs to the results array 
      $results += [PSCustomObject]@{ 
        GroupId = $groupId 
        Members = $members 
        SnapshotDate = $SnapshotDate
      } 
      # Pause for a short time to avoid rate limits 
      Start-Sleep -Milliseconds 200 
    } 
    # Convert the results array to JSON format and save it to a file 
    $results | ConvertTo-Json | Set-Content "EntraGroupMembership.json" 
``` 

### Get Application and Service Principal data 

Generates JSON file with all applications and the corresponding service principals in the tenant. We'll import this data into Azure Data Explorer in [a subsequent section of this tutorial](#3-import-json-files-with-data-from-microsoft-entra-id-into-azure-data-explorer) which allows us to generate custom reports related to applications based on this data. 
```powershell
    # Fetch applications and their corresponding service principals, then export to JSON 
    Get-MgApplication -All | ForEach-Object { 
      $app = $_ 
      $sp = Get-MgServicePrincipal -Filter "appId eq '$($app.AppId)'" 
      [pscustomobject]@{ 
        Name        = $app.DisplayName 
        ApplicationId   = $app.AppId 
        ServicePrincipalId = $sp.Id 
        SnapshotDate = $SnapshotDate
      } 
    } | ConvertTo-Json -Depth 10 | Set-Content "Applications.json" 
``` 
### Get AppRole data 

Generate a JSON file of all appRoles for enterprise apps in Microsoft Entra. Once imported to Azure Data Explorer, we utilize this data to generate reports involving app role assignments for users. 
```powershell
    # Get a list of all applications, handle pagination manually if necessary 
    $apps = Get-MgApplication -All 
    # Loop through each application to gather the desired information 
    $results = foreach ($app in $apps) { 
      # Get the service principal for the application using its appId 
      $spFilter = "appId eq '$($app.AppId)'" 
      $sp = Get-MgServicePrincipal -Filter $spFilter | Select-Object -First 1 
      # Process AppRoles, if any, for the application 
      $appRoles = if ($app.AppRoles) { 
        $app.AppRoles | Where-Object { $_.AllowedMemberTypes -contains "User" } | 
        Select-Object Id, Value, DisplayName 
      } 
      # Construct a custom object with application and service principal details 
      [PSCustomObject]@{ 
        ApplicationId    = $app.AppId 
        DisplayName     = $app.DisplayName 
        ServicePrincipalId = $sp.Id 
        AppRoles      = $appRoles 
        SnapshotDate = $SnapshotDate
      } 
    } 
    # Export the results to a JSON file 
    $results | ConvertTo-Json -Depth 4 | Out-File 'AppRoles.json' 
``` 
### Get AppRole Assignment data 

Generate a JSON file of all app role assignments in the tenant. 
```powershell
    $users = Get-MgUser -All 
    $result = @() 
    foreach ($user in $users) { 
      Get-MgUserAppRoleAssignment -UserId $user.Id | ForEach-Object { 
        # Use the same date formatting approach 
        $createdDateTime = $_.CreatedDateTime -replace "\\/Date\((\d+)\)\\/", '$1' 
        # Convert the milliseconds timestamp to a readable date format if needed 
        $result += [PSCustomObject]@{ 
          AppRoleId      = $_.AppRoleId 
          CreatedDateTime   = $createdDateTime 
          PrincipalDisplayName = $_.PrincipalDisplayName 
          PrincipalId     = $_.PrincipalId 
          ResourceDisplayName = $_.ResourceDisplayName 
          ResourceId      = $_.ResourceId 
          SnapshotDate     = $SnapshotDate
        } 
      } 
    } 
    $result | ConvertTo-Json -Depth 10 | Out-File "AppRoleAssignments.json" 
``` 

## 3: Import JSON files with data from Microsoft Entra ID into Azure Data Explorer

In this section, we import the newly created JSON files for the Microsoft Entra ID services into Azure Data Explorer for further analysis.

Once you have setup a database in your Azure Data Explorer cluster or free cluster, as described in the first section of this article, navigate to that database.

 1. Sign-in to the [Azure Data Explorer web UI](https://dataexplorer.azure.com/home).
 1. From the left menu, select **Query**.

Next, follow these steps for each exported JSON file, to get your exported data into that Azure Data Explorer database.

 1. Right-select on the database name of the database where you want to ingest the data. Select **Get data**.

    :::image type="content" source="/azure/data-explorer/media/get-data-file/get-data.png" alt-text="Screenshot of query tab, with right-select on a database and the get options dialog open." lightbox="/azure/data-explorer/media/get-data-file/get-data.png":::

 2. Select the data source from the available list. In this tutorial, you're ingesting data from a **Local file**.
 1. Select **+ New table** and enter a table name, based on the name of the JSON file you're importing, For example, if you're importing EntraUsers.json, name the table **EntraUsers**. After the first import, the table already exists, and you can select it as the target table for a subsequent import.
 1. Select **Browse for files**, select the JSON file, and select **Next**.
 1. Azure Data Explorer automatically detects the schema and provides a preview in the **Inspect** tab. Select **Finish** to create the table and import the data from that file. Once the data is ingested, click **Close**.
 1. Repeat each of the preceding steps for each of the JSON files that you generated in the previous section.

## 4: Extract Microsoft Entra ID Governance data with PowerShell

In this section, you'll use PowerShell to extract data from Microsoft Entra ID Governance services. If you do not have Microsoft Entra ID Governance, Microsoft Entra ID P2 or Microsoft Entra Suite, then continue in section [use Azure Data Explorer to build custom reports](#6-use-azure-data-explorer-to-build-custom-reports).

For this you may need to [install Microsoft Graph PowerShell modules](/powershell/microsoftgraph/installation) to extract Microsoft Entra ID Governance data. The first time your organization uses these modules for this scenario, you need to be in a Global Administrator role to allow Microsoft Graph PowerShell to grant consent for use in your tenant. Subsequent interactions can use a lower-privileged role.

 1. Open PowerShell.
 1. If you don't have all the [Microsoft Graph PowerShell modules](https://www.powershellgallery.com/packages/Microsoft.Graph) already installed, install the required Microsoft Graph modules. The following modules are required for this section of the tutorial: `Microsoft.Graph.Identity.Governance`. If you already have these modules installed, then continue at the next step.

```powershell
   $modules = @('Microsoft.Graph.Identity.Governance')
   foreach ($module in $modules) {
   Install-Module -Name $module -Scope CurrentUser -AllowClobber -Force
   }
```  
 2. Import the modules into the current PowerShell session. 
 
 ```powershell
   $modules = @('Microsoft.Graph.Identity.Governance')
   foreach ($module in $modules) {
   Import-Module -Name $module
   } 
``` 

 3. Connect to Microsoft Graph. This section of the tutorial illustrates retrieving data from entitlement management and access reviews, so requires the `AccessReview.Read.All` and `EntitlementManagement.Read.All` permission scopes. For other reporting use cases such as for PIM or lifecycle workflows, then update the `Scopes` parameter with the necessary permissions. For more information on permissions, see [Microsoft Graph permissions reference](/graph/permissions-reference).
 
```powershell
  Connect-MgGraph -Scopes "AccessReview.Read.All, EntitlementManagement.Read.All" -ContextScope Process -NoWelcome
``` 

 This command prompts you to sign in with your Microsoft Entra credentials. After signing in, you may need to consent to the required permissions if it's your first time connecting, or if new permissions are required.

### PowerShell queries to extract Microsoft Entra ID Governance data needed to build custom reports in Azure Data Explorer

You can use queries to extract Microsoft Entra ID Governance data from Microsoft Graph using PowerShell and export the data to JSON files, which are imported into Azure Data Explorer in the subsequent section. There may be multiple scenarios for generating reports with this type of data, including:

 * reporting on historical access reviews
 * reporting on assignments via entitlement management

### Get Access review schedule definition data

Generate a JSON file with access review definition names and IDs that are used to create custom views in Azure Data Explorer. The sample includes all access reviews, but additional filtering can be included if needed. For more information, see [use the filter query parameter](/graph/api/accessreviewset-list-definitions?view=graph-rest-1.0&tabs=http#use-the-filter-query-parameter).

```powershell
   $allsched = Get-MgIdentityGovernanceAccessReviewDefinition -All
   $definitions = @()
   # Iterate over each definition
   foreach ($definition in $allsched) {
      $definitions += [PSCustomObject]@{
         Id = $definition.Id
         DisplayName = $definition.DisplayName
         SnapshotDate = $SnapshotDate
      }
   }
   $definitions | ConvertTo-Json -Depth 10 | Set-Content "EntraAccessReviewDefinition.json"
```

### Get entitlement management access package data

Generate a JSON file with access package names and IDs that are used to create custom views in Azure Data Explorer. The sample includes all access packages, but additional filtering can be included if needed.

```powershell
   $accesspackages1 = Get-MgEntitlementManagementAccessPackage -All
   $accesspackages2 = @()
   # Iterate over each access package
   foreach ($accesspackage in $accesspackages1) {
      $accesspackages2 += [PSCustomObject]@{
         Id = $accesspackage.Id
         DisplayName = $accesspackage.DisplayName
         SnapshotDate = $SnapshotDate
      }
   }
   $accesspackages2 | ConvertTo-Json -Depth 10 | Set-Content "EntraAccessPackage.json"
```

## 5: Import JSON files with data from Microsoft Entra ID Governance into Azure Data Explorer

In this section, we import the newly created JSON files for the Microsoft Entra ID Governance services into Azure Data Explorer, alongside the data already imported for the Microsoft Entra ID services, for further analysis.

In your Azure Data Explorer cluster or free cluster, navigate to the database which holds your Microsoft Entra ID data.

 1. Sign-in to the [Azure Data Explorer web UI](https://dataexplorer.azure.com/home).
 1. From the left menu, select **Query**.

Next, follow these steps for each exported JSON file from the previous section, to get your exported data into that Azure Data Explorer database.

 1. Right-select on the database name of the database where you want to ingest the data. Select **Get data**.

    :::image type="content" source="/azure/data-explorer/media/get-data-file/get-data.png" alt-text="Screenshot of query tab, with right-select on a database and the get options dialog open." lightbox="/azure/data-explorer/media/get-data-file/get-data.png":::

 2. Select the data source from the available list. In this tutorial, you're ingesting data from a **Local file**.
 1. Select **+ New table** and enter a table name, based on the name of the JSON file you're importing, After the first import, the table already exists, and you can select it as the target table for a subsequent import.
 1. Select **Browse for files**, select the JSON file, and select **Next**.
 1. Azure Data Explorer automatically detects the schema and provides a preview in the **Inspect** tab. Select **Finish** to create the table and import the data from that file. Once the data is ingested, click **Close**.
 1. Repeat each of the preceding steps for each of the JSON files that you generated in the previous section.

## 6: Use Azure Data Explorer to build custom reports 

With the data now available in Azure Data Explorer, you're ready to begin creating customized reports based on your business requirements. 

Azure Data Explorer is a powerful data analysis tool that is highly scalable and flexible providing an ideal environment for generating customized user access reports. Azure Data Explorer uses the Kusto Query Language (KQL).

The following queries provide examples of common reports, but you can customize these reports to suit your needs and create additional reports. 

### Example 1: Generate app role assignments for direct and group assignments for a specific snapshot date 

This report provides a view of who had what access and when to the target app and can be used for security audits, compliance verification, and understanding access patterns within the organization. 

This query targets a specific application within Microsoft Entra AD and analyzes the role assignments as of a certain date. The query retrieves both direct and group-based role assignments, merging this data with user details from the EntraUsers table and role information from the AppRoles table. 

```kusto
/// Define constants 
let targetServicePrincipalId = "<your service principal-id>"; // Target Service Principal ID 
let targetSnapshotDate = datetime("2024-01-13"); // Target Snapshot Date for the data 

// Extract role assignments for the target Service Principal and Snapshot Date 
let roleAssignments = AppRoleAssignments 
    | where ResourceId == targetServicePrincipalId and startofday(SnapshotDate) == targetSnapshotDate 
    | extend AppRoleIdStr = tostring(AppRoleId); // Convert AppRoleId to string for easier comparison 

// Prepare user data from EntraUsers table 
let users = EntraUsers 
    | project ObjectID, UserPrincipalName, DisplayName, ObjectIDStr = tostring(ObjectID); // Include ObjectID as string for joining 

// Prepare role data from AppRoles table 
let roles = AppRoles 
    | mvexpand AppRoles // Expand AppRoles to handle multiple roles 
    | extend RoleName = AppRoles.DisplayName, RoleId = tostring(AppRoles.Id) // Extract Role Name and ID 
    | project RoleId, RoleName; 
// Process direct assignments 
let directAssignments = roleAssignments 
    | join kind=inner users on $left.PrincipalId == $right.ObjectID // Join with EntraUsers on PrincipalId 
    | join kind=inner roles on $left.AppRoleIdStr == $right.RoleId // Join with roles to get Role Names 
    | project UserPrincipalName, DisplayName, CreatedDateTime, RoleName, AssignmentType = "Direct", SnapshotDate; 

// Process group-based assignments 

let groupAssignments = roleAssignments 
    | join kind=inner EntraGroupMembership on $left.PrincipalId == $right.GroupId // Join with Group Membership 
    | mvexpand Members // Expand group members 
    | extend MembersStr = tostring(Members) // Convert member ID to string 
    | distinct MembersStr, CreatedDateTime, AppRoleIdStr, SnapshotDate // Get distinct values 
    | join kind=inner users on $left.MembersStr == $right.ObjectIDStr // Join with EntraUsers for user details 
    | join kind=inner roles on $left.AppRoleIdStr == $right.RoleId // Join with roles for role names 
    | project UserPrincipalName, DisplayName, CreatedDateTime, RoleName, AssignmentType = "Group", SnapshotDate; 

// Combine results from direct and group-based assignments 
directAssignments 
| union groupAssignments 
``` 
### Example 2: Build Basic Auditor Report with Entra data showing who had access to an app between these two dates 

This report provides a view of who had what access to the target app between two dates and can be used for security audits, compliance verification, and understanding access patterns within the organization. 

This query targets a specific application within Microsoft Entra ID and analyzes the role assignments between two dates. The query retrieves direct role assignments from the AppRoleAssignments table and merges this data with user details from the EntraUsers table and role information from the AppRoles table. 

```kusto
// Set the date range and service principal ID for the query 
let startDate = datetime('2024-01-01'); 
let endDate = datetime('2024-03-14'); 
let servicePrincipalId = "<your service principal-id>"; 

// Query AppRoleAssignments for the specified service principal within the date range 
AppRoleAssignments 
| where ResourceId == servicePrincipalId and 
    todatetime(CreatedDateTime) between (startDate .. endDate) 

// Extend AppRoleId to a string for joining 
| extend AppRoleIdStr = tostring(AppRoleId) 

// Project the necessary fields for the join with EntraUsers and AppRoles 
| project PrincipalId, AppRoleIdStr, CreatedDateTime 

// Join with EntraUsers to get user details 
| join kind=inner (EntraUsers | project UserPrincipalName, DisplayName, ObjectID) on $left.PrincipalId == $right.ObjectID 

// Join with AppRoles to get the role display names 
| join kind=inner ( 
  AppRoles | mvexpand AppRoles | project RoleIdStr = tostring(AppRoles.Id), RoleDisplayName = tostring(AppRoles.DisplayName) 
) on $left.AppRoleIdStr == $right.RoleIdStr 

// Final projection of the report with the current date and time 
| project UserPrincipalName, DisplayName, RoleDisplayName, CreatedDateTime, ReportDate = now() 
``` 

### Example 3: Get added users to an app between two data snapshot dates 

These reports provide a view of which users were given an app role assignment to the target application between two dates. These reports can be used to track changes in app access over time. 

This query targets a specific application within Microsoft Entra ID and changes to the role assignments between a start and end date. 

 
```kusto
// Define the date range and service principal ID for the query 

let startDate = datetime("2024-03-01"); 
let endDate = datetime("2024-03-14"); 
let servicePrincipalId = "<your service principal-id>"; 
let earlierDate = startDate; // Update this to your specific earlier date 

AppRoleAssignments 
| where SnapshotDate < endDate and ResourceId == servicePrincipalId
| project PrincipalId, AppRoleId2 = tostring(AppRoleId), CreatedDateTime 
| join kind=anti ( 
    AppRoleAssignments 
    | where SnapshotDate < earlierDate and ResourceId == servicePrincipalId 
    | project PrincipalId, AppRoleId1 = tostring(AppRoleId) 
) on PrincipalId 
| join kind=inner (EntraUsers) on $left.PrincipalId == $right.ObjectID 
| join kind=inner (AppRoles 
                   | mvexpand AppRoles 
                   | project AppRoleId=tostring(AppRoles.Id), RoleDisplayName=tostring(AppRoles.DisplayName) 
                  ) on $left.AppRoleId2 == $right.AppRoleId 
| project UserPrincipalName, DisplayName, RoleDisplayName, CreatedDateTime, PrincipalId, Change = "Added" 
``` 

## Set up ongoing imports

This tutorial illustrates a one-time data extract, transform and load (ETL) process to populate Azure Data Explorer with a single snapshot for reporting purposes. For ongoing reporting or to compare changes over time, you can automate the process of populating Azure Data Explorer from Microsoft Entra, so that your database continues to have current data. 

You can use [Azure Automation](/azure/automation/overview), an Azure cloud service, to host the PowerShell scripts needed to extract data from Microsoft Entra ID and Microsoft Entra ID Governance and import it into Azure Data Explorer. For more information, see [Automate Microsoft Entra ID Governance tasks with Azure Automation](identity-governance-automation.md).

## Bring in data from other sources

You can also [create additional tables](/azure/data-explorer/create-table-wizard) in Azure Data Explorer to ingest data from other sources. If the data is in a JSON file, similar to the examples above, or a CSV file, then you can create the table at the time you first [get data from the file](/azure/data-explorer/get-data-file).

For more information on data ingestion, see [Azure Data Explorer data ingestion overview](/azure/data-explorer/ingest-data-overview).

### Example 4: Combine App Assignments from an Entra and a second source to create a report of all users who had access to an application between two dates

This report illustrates how you can combine data from two separate systems to create custom reports in Azure Data Explorer. It aggregates data about users, their roles, and other attributes from two systems into a unified format for analysis or reporting. 

This example assumes there's a table named `salesforceAssignments` that has been populated by bringing in data from another application.

```kusto
// Define the date range and service principal ID for the query 

let startDate = datetime("2023-06-01"); 
let endDate = datetime("2024-03-13"); 
let servicePrincipalId = "<your service principal-id>"; 

// Pre-process AppRoleAssignments with specific filters and projections 
let processedAppRoleAssignments = AppRoleAssignments 
    | where ResourceId == servicePrincipalId and todatetime(CreatedDateTime) between (startDate .. endDate) 
    | extend AppRoleId = tostring(AppRoleId) 
    | project PrincipalId, AppRoleId, CreatedDateTime, ResourceDisplayName; // Exclude DeletedDateTime and keep ResourceDisplayName 

// Pre-process AppRoles to get RoleDisplayName for each role 
let processedAppRoles = AppRoles 
    | mvexpand AppRoles 
    | project AppRoleId = tostring(AppRoles.Id), RoleDisplayName = tostring(AppRoles.DisplayName); 

// Main query: Process EntraUsers by joining with processed role assignments and roles 
EntraUsers 
    | join kind=inner processedAppRoleAssignments on $left.ObjectID == $right.PrincipalId // Join with role assignments 
    | join kind=inner processedAppRoles on $left.AppRoleId == $right.AppRoleId // Join with roles to get display names 

    // Summarize to get the latest record for each unique combination of user and role attributes 
    | summarize arg_max(AccountEnabled, *) by UserPrincipalName, DisplayName, tostring(EmployeeId), Department, JobTitle, ResourceDisplayName, RoleDisplayName, CreatedDateTime 

    // Final projection of relevant fields including source indicator and report date 
    | project UserPrincipalName, DisplayName, EmployeeId=tostring(EmployeeId), Department, JobTitle, AccountEnabled=tostring(AccountEnabled), ResourceDisplayName, RoleDisplayName, CreatedDateTime, Source="EntraUsers", ReportDate = now() 

// Union with processed salesforceAssignments to create a combined report 
| union ( 
    salesforceAssignments 

    // Project fields from salesforceAssignments to align with the EntraUsers data structure 
    | project UserPrincipalName = UserName, DisplayName = Name, EmployeeId = tostring(EmployeeId), Department, JobTitle, AccountEnabled = "N/A", ResourceDisplayName = AppName, RoleDisplayName = Role, CreatedDateTime, Source = "salesforceAssignments", ReportDate = now() 
) 
``` 
## Next steps

- [What is Microsoft Entra entitlement management?](entitlement-management-overview.md)
