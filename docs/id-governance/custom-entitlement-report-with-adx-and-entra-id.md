---
title: 'Custom reports using Microsoft Entra and application data'
description: Tutorial that describes how to create customized reports in Azure Data Explorer using data from Microsoft Entra ID.
author: billmath
manager: amycolannino
ms.service: entra-id-governance
ms.topic: overview
ms.date: 12/10/2024
ms.author: billmath
---

# Tutorial: Customized reports in Azure Data Explorer using data from Microsoft Entra ID

In this tutorial, you'll learn how to create customized reports in [Azure Data Explorer (ADX)](/azure/data-explorer/data-explorer-overview) using data from Microsoft Entra ID and Microsoft Entra ID Governance services. This tutorial complements other reporting options such as [Archive & report with Azure Monitor and entitlement management](entitlement-management-logs-and-reporting.md), which focuses on exporting the audit log into Azure Monitor for retention and analysis. By comparison, exporting Microsoft Entra ID data to Azure Data Explorer provides flexibility for creating custom reports on Microsoft Entra objects, including historical and deleted objects. In addition, use of Azure Data Explorer enables data aggregation from additional sources, with massive scalability, flexible schema, and retention policies. Azure Data Explorer is especially helpful when you need to retain access data for years, perform ad-hoc investigations, or need to run custom queries on user access data.

This article illustrates how to show configuration, users, and access rights exported from Microsoft Entra alongside data exported from other sources, such as applications with SQL databases. You can then use the Kusto Query Language (KQL) in Azure Data Explorer to build custom reports based on your organization's requirements. 

You'll take the following steps to create these reports: 

 1. [Set up Azure Data Explorer](#step-1-setup-azure-data-explorer) in an Azure subscription. 
 2. [Extract data from Microsoft Entra](#step-2-connect-to-ms-graph-and-extract-entra-data-with-powershell) and third-party databases or applications using PowerShell scripts and MS Graph. 
 3. [Import the data into Azure Data Explorer](#step-3-import-json-file-data-into-azure-data-explorer), a fast and scalable data analytics service. 
 4. [Build a custom query](#step-4-use-azure-data-explorer-to-build-custom-reports) using Kusto Query Language. 

By the end of this tutorial, you'll have built skills to develop customized views of the access rights and permissions of users across different applications using Microsoft supported tools. 

## Prerequisites

If you're new to Azure Data Explorer and wish to learn the scenarios shown in this article, you can obtain a [free Azure Data Explorer cluster](/azure/data-explorer/start-for-free). For production supported use with a service level agreement for Azure Data Explorer, you'll need an Azure subscription to host a full Azure Data Explorer cluster.

Determine what data you want to include in your reports. The scripts in this article provide samples with specific data from users, groups, and applications from Entra. These samples are meant to illustrate the types of reports you can generate with this approach, but your specific reporting needs may vary and require different or additional data. You can start with these objects and bring in more kinds of Microsoft Entra objects over time.

- This article illustrates retrieving data from Microsoft Entra as a signed-in user. To do so, ensure you have the required role assignments to retrieve data from Microsoft Entra. You'll need the roles with the right permissions to export the type of Entra data you would like to work with. 
  - User data: Global Administrator, Privileged Role Administrator, User Administrator 
  - Groups data: Global Administrator, Privileged Role Administrator, Group Administrator 
  - Applications/App Role Assignments: Global Administrator, Privileged Role Administrator, Application Administrator, Cloud Application Administrator 
- Microsoft Graph PowerShell must be consented to allow for retrieval of Microsoft Entra objects via Microsoft Graph. The examples in this tutorial require the delegated User.Read.All, Group.Read.All, Application.Read.All, and Directory.Read.All permissions. If you're planning on retrieving data using automation without a signed-in user, then consent to the corresponding application permissions instead. See [Microsoft Graph permissions reference](/graph/permissions-reference) for additional information.  If you have not already consented Microsoft Graph PowerShell to those permissions, you'll need to be a Global Administrator to perform this consent operation.
- This tutorial does not illustrate custom security attributes. By default, Global Administrator and other administrator roles don't include permissions to read custom security attributes from Microsoft Entra users. If you're planning on retrieving custom security attributes, then more roles and permissions may be required.
- On the computer where Microsoft Graph PowerShell is installed, ensure you have write access to the file system directory where you'll install the required MS Graph PowerShell modules and where the exported Entra data will be saved. 
- Ensure you have permissions to retrieve data from other data sources beyond Microsoft Entra.

## Step 1: Setup Azure Data Explorer 

If you haven’t previously used Azure Data Explorer, you'll need to set this up first. You can create a [free cluster without an Azure subscription or credit card](/azure/data-explorer/start-for-free) or a full cluster which requires an Azure subscription. See [Quickstart: Create an Azure Data Explorer cluster and database](/azure/data-explorer/create-cluster-and-database) to get started. 

## Step 2: Connect to MS Graph and Extract Entra data with PowerShell 

In this step, you'll [install MS Graph PowerShell modules](/powershell/microsoftgraph/installation) and [Connect to MS Graph](/powershell/module/microsoft.graph.authentication/connect-mggraph). 

The first time your organization uses these modules for this scenario, you need to be in a Global Administrator role to allow Microsoft Graph PowerShell to be consented to be used in your tenant. Subsequent interactions can use a lower-privileged role.

 1. Open PowerShell.
 1. If you don't have all the [Microsoft Graph PowerShell modules](https://www.powershellgallery.com/packages/Microsoft.Graph) already installed, install the required MS Graph modules. The following modules are required for this tutorial: `Microsoft.Graph.Authentication`, `Microsoft.Graph.Users`, `Microsoft.Graph.Groups`, `Microsoft.Graph.Applications`, `Microsoft.Graph.DirectoryObjects`. 

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
 3. Connect to Microsoft Graph.
 
```powershell
  Connect-MgGraph -Scopes "User.Read.All", "Group.Read.All", "Application.Read.All", "Directory.Read.All" -ContextScope Process
``` 

 This command prompts you to sign in with your Microsoft Entra credentials. After signing in, you may need to consent to the required permissions if it's your first time connecting, or if new permissions are required.
  

### PowerShell Queries to extract data needed to build custom reports in Azure Data Explorer

The following queries extract Entra data from MS Graph using PowerShell and export the data to JSON files which will be imported into Azure Data Explorer in Step 3. There may be multiple scenarios for generating reports with this type of data: 

 - An auditor would like to see a report that lists the group members for 10 groups, organized by the members’ department. 
 - An auditor would like to see a report of all users who had access to an application between two dates. 
 - An admin would like to view all users added to an application from Microsoft Entra ID and SQL databases. 

These types of reports aren't built in to Microsoft Entra ID, but you can create these reports yourself by extracting data from Entra and combining them using custom queries in Azure Data Explorer. 

For this tutorial, we'll extract Entra data from several areas: 

 - User information such as display name, UPN, and job details 
 - Group information 
 - Application and role assignments 

This data set will enable us to perform a broad set of queries around who was given access to an application, role information, and the associated timeframe. Note that these are sample queries, and your data and specific requirements may vary from what is shown here. 

>[!NOTE]
> Larger tenants may experience throttling / 429 errors that will be handled by the MS Graph module. 

In these PowerShell scripts, we'll export selected properties from the Entra objects to JSON files. The data from these exported properties will then be used to generate custom reports in Azure Data Explorer. The specific properties below, were included in these examples, because we're using this data to illustrate the types of reports you can create in Azure Data Explorer. Since your specific reporting needs will likely vary from what is shown below, you should include the specific properties in these scripts that you're interested in viewing in your reports, however you can follow the same pattern shown below to help build your scripts. 

We have also included a hard-coded **snapshot date** below which identifies the data in the JSON file with a specific date and will allow us to keep track of similar data sets over time in Azure Data Explorer. The snapshot date is also useful for comparing changes in data between two snapshot dates. 

### Get Entra user data 

This script will export selected properties from the Entra user object to a JSON file. We'll import this data into Azure Data Explorer in Step 3. 

     
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
      $userObject["SnapshotDate"] = "2024-01-11" 
      [pscustomobject]$userObject 
    } 
    # Convert the user data to JSON and save it to a file 
    $users | ConvertTo-Json -Depth 2 | Set-Content ".\EntraUsers.json" 
  } 
  # Execute the function 
  Export-EntraUsersToJson 
```
### Get Group data 

Generate a JSON file with group names and IDs that will be used to create custom views in Azure Data Explorer. The sample will include all groups, but additional filtering can be included if needed. If you're filtering to only include certain groups, you may want to include logic in your script to check for nested groups. 
```powershell
    # Get all groups and select Id and DisplayName 
    $groups = Get-MgGroup -All | Select-Object Id,DisplayName 
    # Export the groups to a JSON file 
    $groups | ConvertTo-Json | Set-Content ".\EntraGroups.json" 
```
### Get Group Membership data 

Generate a JSON file with group membership which will be used to create custom views in Azure Data Explorer. 
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
      } 
      # Pause for a short time to avoid rate limits 
      Start-Sleep -Milliseconds 200 
    } 
    # Convert the results array to JSON format and save it to a file 
    $results | ConvertTo-Json | Set-Content "EntraGroupMembership.json" 
``` 

### Get Application and Service Principal data 

Generates JSON file with all applications and the corresponding service principals in the tenant. We'll import this data into Azure Data Explorer in Step 3 which will allow us to generate custom reports related to applications based on this data. 
```powershell
    # Fetch applications and their corresponding service principals, then export to JSON 
    Get-MgApplication -All | ForEach-Object { 
      $app = $_ 
      $sp = Get-MgServicePrincipal -Filter "appId eq '$($app.AppId)'" 
      [pscustomobject]@{ 
        Name        = $app.DisplayName 
        ApplicationId   = $app.AppId 
        ServicePrincipalId = $sp.Id 
      } 
    } | ConvertTo-Json -Depth 10 | Set-Content "Applications.json" 
``` 
### Get AppRole data 

Generate a JSON file of all appRoles for enterprise apps in Entra. Once imported to Azure Data Explorer, we'll utilize this data to generate reports involving app role assignments for users. 
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
          SnapshotDate     = "2024-03-13" # Hard-coded date 
        } 
      } 
    } 
    $result | ConvertTo-Json -Depth 10 | Out-File "AppRoleAssignments.json" 
``` 

## Step 3: Import JSON file data into Azure Data Explorer 

In Step 3, we'll import the newly created JSON files for further analysis. If you haven’t yet setup Azure Data Explorer, please see Step 1 above. 

Azure Data Explorer is a powerful data analysis tool that is highly scalable and flexible providing an ideal environment for generating customized user access reports. Azure Data Explorer uses the Kusto Query Language (KQL). 

Once you have setup a database in your Azure Data Explorer cluster or free cluster, navigate to that database.

 1. Sign-in to the [Azure Data Explorer web UI](https://dataexplorer.azure.com/home).
 1. From the left menu, select **Query**.

Next, follow these steps for each exported JSON file, to get your exported data into that Azure Data Explorer database.

 1. Right-click on the database name of the database where you want to ingest the data. Select **Get Data**.

    :::image type="content" source="/azure/data-explorer/media/get-data-file/get-data.png" alt-text="Screenshot of query tab, with right-click on a database and the get options dialog open." lightbox="/azure/data-explorer/get-data-filemedia/get-data-file/get-data.png":::

 2. Select the data source from the available list. In this tutorial, you're ingesting data from a **Local file**.

    [!INCLUDE [ingestion-size-limit](/azure/data-explorer/includes/cross-repo/ingestion-size-limit.md)]

 1. Select **+ New table** and enter a table name, based on the name of the JSON file you're importing, For example, if you're importing EntraUsers.json, name the table **EntraUsers**. After the first import, the table will already exist, and you can select it as the target table for a subsequent import.
 1. Select **Browse for files**, select the JSON file, and select **Next**.
 1. Azure Data Explorer will automatically detect the schema and provide a preview in the **Inspect** tab. Click **Finish** to create the table and import the data from that file.
 1. Repeat each of the preceding steps for each of the JSON files that you generated in the first section.

## Step 4: Use Azure Data Explorer to build custom reports 

With the data now available in Azure Data Explorer, you're ready to begin creating customized reports based on your business requirements. The following queries provide examples of common reports, but you can customize these reports to suit your needs and create additional reports. 

### Example 1: Generate app role assignments for direct and group assignments for a specific snapshot date 

This report provides a view of who had what access and when to the target app and can be used for security audits, compliance verification, and understanding access patterns within the organization. 

This query targets a specific application within Entra AD and analyzes the role assignments as of a certain date. The query retrieves both direct and group-based role assignments, merging this data with user details from the EntraUsers table and role information from the AppRoles table. 

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
### Example 4: Combine App Assignments from an Entra and a second source (for example, SQL export) to create a report of all users (Entra assignments and local assignments) who had access to Salesforce between two dates 
 

This report illustrates how you can combine data from two separate systems to create custom reports in Azure Data Explorer. It aggregates data about users, their roles, and other attributes from two systems into a unified format for analysis or reporting. 

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