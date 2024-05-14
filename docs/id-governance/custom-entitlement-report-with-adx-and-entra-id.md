---
title: 'Custom reports using Microsoft Entra and application data'
description: Tutorial that describes how to create customized entitlement reports in Azure Data Explorer (ADX) using data from Microsoft Entra ID.
author: billmath
manager: amycolannino
ms.service: entra-id-governance
ms.topic: overview
ms.date: 01/05/2023
ms.author: billmath
---

# Tutorial: Customized entitlement reports in Azure Data Explorer (ADX) using data from Microsoft Entra ID.

In this tutorial, you will learn how to create customized entitlement reports in Azure Data Explorer (ADX) using data from Microsoft Entra ID. This tutorial complements other reporting options such as [Archive & report with Azure Monitor and entitlement management](entitlement-management-logs-and-reporting.md) which focuses on exporting audit log data for longer retention and analysis. By comparison, exporting Entra ID data to Azure Data Explorer provides greater flexibility for creating custom reports by allowing data aggregation from multiple sources with massive scalability, and flexible schema and retention policies. 

This report illustrates how to show configuration, users and access rights exported from Microsoft Entra alongside data exported from other sources, such as applications with a SQL database.  You can then use the Kusto Query Language (KQL) to build custom reports based on your organization's requirements. Generating these types of reports within Azure Data Explorer may be especially helpful if you need to retain access data for longer periods, perform ad-hoc investigations, or need to run custom queries on user access data.

You will take the following steps to create these reports: 

 1. Set up Azure Data Explorer in an Azure subscription. 
 2. Extract data from Microsoft Entra and third-party databases or applications using PowerShell scripts and MS Graph. 
 3. Ingest the data into Azure Data Explorer, a fast and scalable data analytics service. 
 4. (Optional) Extract data from other applications and inject that data into Azure Data Explorer. 
 5. Build a custom query using Kusto Query Language. 

By the end of this tutorial, you will have built skills to develop customized views of the access rights and permissions of users across different applications using Microsoft supported tools. 

## Prerequisites

- Ensure you have the required permissions. You will need the right permissions to export the type of Entra data you would like to work with and permissions to save exported JSON files. 
     - User data: Global Administrator, Privileged Role Administrator, User Administrator 
     - Groups data: Global Administrator, Privileged Role Administrator, Group Administrator 
     - Applications/App Role Assignments: Global Administrator, Privileged Role Administrator, Application Administrator, Cloud Application Administrator 

- PowerShell must be set to allow for User.Read.All, Group.Read.All, Application.Read.All, and Directory.Read.All. See Microsoft Graph permissions reference for additional information. 
- Ensure you have write access to the directory where you will install the required MS Graph PowerShell modules and where the exported Entra data will be saved.  
- Determine what data you want to include in your reports. The scripts in this article provide samples with specific data from users, groups, and applications from Entra. These samples are meant to illustrate the types of reports you can generate with this approach, but your specific reporting needs may vary and require different or additional data.  

## Step 1: Setup Azure Data Explorer 

If you haven’t previously used Azure Data Explorer, you will need to set this up first. You can create a free cluster without an Azure subscription or credit card or a full cluster which requires an Azure subscription. See [Quickstart: Create an Azure Data Explorer cluster and database](/azure/data-explorer/create-cluster-and-database) to get started. 

## Step 2: Connect to MS Graph and Extract Entra data with PowerShell 

Install MS Graph Powershell modules and Connect to MS Graph 

 1. Install the required MS Graph modules. The following modules are required for this tutorial: Microsoft.Graph.Users, Microsoft.Graph.Groups, Microsoft.Graph.Applications, Microsoft.Graph.DirectoryObjects 

     ```
         $modules = @('Microsoft.Graph.Users', 'Microsoft.Graph.Groups', 'Microsoft.Graph.Applications', 'Microsoft.Graph.DirectoryObjects') 

         foreach ($module in $modules) { 

         Install-Module -Name $module -Scope CurrentUser -AllowClobber -Force
         } 
     ```    
 2. Import the modules: 
 
     ```
         $modules = @('Microsoft.Graph.Users', 'Microsoft.Graph.Groups', 'Microsoft.Graph.Applications', 'Microsoft.Graph.DirectoryObjects') 

         foreach ($module in $modules) { 

         Import-Module -Name $module 

         }  
     ``` 
 3. Connect to Microsoft Graph
  
     ```
     Connect-MgGraph -Scopes "User.Read.All", "Group.Read.All", "Application.Read.All", "Directory.Read.All"   
     ``` 