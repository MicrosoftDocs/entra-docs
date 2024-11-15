---
title: Export connector logs to the Log Analytics workspace
description: Extract connector logs and send those logs to the Log Analytics workspace in the customer’s Azure subscription.
ms.service: global-secure-access
ms.topic: how-to
ms.date: 11/22/2024
ms.author: jfields
author: jenniferf-skc
manager: amycolannino
ms.reviewer: sumeetmittal


# Customer intent: As an administrator, I want to extract private network connector logs from on-premises connector machines deployed on the customer's network and send those logs to the Log Analytics workspace in the customer’s Azure subscription.
---
# Export private network connector logs to the Log Analytics workspace

This article describes how to extract private network connector logs from connector machines deployed on the customer's network and send those logs to the Log Analytics workspace in the customer’s Azure subscription. This is done using Azure Arc and its extensions. The logs stay under the customer's control and management in their Azure environment. This ensures that customers keep full ownership and security of their data.

## Prerequisites

To complete the steps in this process, you must have the following prerequisites in place:

- An active Azure subscription.
- An on-premises Windows machine running Microsoft Entra Private Network Connector that you want to connect to Azure Log Analytics. For more information, see [Understand the Microsoft Entra private network connector](concept-connectors.md). 
- Access to navigate and execute commands in the Azure portal. 
- A Microsoft Azure Arc account to manage on-premises and multicloud resources. For more information, see [Azure Arc overview](/azure/azure-arc/overview).

## Extract connector logs
To extract connector logs, you must enable verbose logging on the connector machine and then stream the logs to Log Analytics.

### Enable verbose logging on the connector machine
Verbose logs can be very useful when debugging Microsoft Entra Private Network Connector side issues for Entra Private Access. Verbose logging is not enabled in the connector by default. To enable verbose logging:

1. Locate the installation directory of the connector at `C:\Program Files\Microsoft Entra Private Network Connector`.
2. 

### Set up Microsoft Azure Arc for the on-premises machine


### Set up the Log Analytics workspace


### Set up the data collection endpoint (DCE)


### Set up the data collection rule (DCR)


### Verify data collection



## Share workspace access
Once you have the logs into the Log Analytics workspace, you can expose the logs to a user outside your tenant by sharing access to the workspace in a secure manner. One use case could be to grant access to support personnel (as required) for any support issues. Support personnel could be from Microsoft CSS (Customer Service & Support), Engineering OCE (On Call Engineer) or the customer’s own support network. This would help with swiftly diagnosing the problem, positively impacting the Mean Time to Recovery (MTTR) and Mean Time to Mitigate (MTTM), by extension, customer satisfaction. 
 
Here are the steps to achieve this: 

Prerequisites 

Azure Subscription: Ensure you have an active Azure subscription. 

Log Analytics Workspace: An existing Log Analytics workspace that you want to share. 

Azure AD Guest User: The external user must be added as a guest user in your Azure Active Directory (AD). 

Step-by-Step Instructions 

Step 1: Add External User as a Guest in Azure AD 

Navigate to Azure Active Directory: 

Go to the Azure Portal. 

In the search bar, type "Microsoft Entra ID" and select it. 

Add a New Guest User: 

In the Entra ID dashboard, select "Manage->Users". 

Click on "+ New user" and then select "Invite external user". 

Enter the external user's email address and fill in the required information. 

Click "Invite" to send an invitation to the external user. 

The external user receives an email invitation to join your Entra ID as a guest. 

Step 2: Assign Roles to the Guest User in Log Analytics Workspace 

Navigate to the Log Analytics Workspace: 

In the Azure Portal, search for "Log Analytics workspaces" and select the workspace you want to share. 

Access Control (IAM): 

In the workspace blade, select "Access control (IAM)" from the left-hand menu. 

Click on "+ Add" and select "Add role assignment". 

Assign a Role: 

Select a role to assign to the guest user. Common roles for accessing Log Analytics include: 

Log Analytics Reader: Allows the user to read and query logs. 

Log Analytics Contributor: Allows the user to read, query, and modify logs. 

Add the Guest User: 

In the "Members" section, click "Select members". 

Search for the guest user you added earlier by their email address. 

Select the guest user and click "Select". 

Review and Assign: 

Review the role assignment and click "Review + assign" to complete the process. 

Step 3: Ensure Permissions Are Properly Set 

Verify Permissions: 

The guest user should now have access to the Log Analytics workspace with the permissions assigned. 

You can verify by going to "Access control (IAM)" in the Log Analytics workspace and checking the role assignments. 

Step 4: External User Access and Query Logs 

External User Access: 

The external user will need to accept the invitation sent to their email and log into the Azure Portal using their credentials. 

Accessing Log Analytics: 

Once logged in, the external user can navigate to the Log Analytics workspace shared with them. 

They can use the Log Analytics workspace's "Logs" feature to query and analyze logs based on the permissions granted. 

Additional Considerations 

Security: Ensure that you only grant the necessary permissions to the guest user. The principle of least privilege should be followed. 

Monitoring and Auditing: Regularly monitor and audit access to your Log Analytics workspace to ensure compliance and security. 

By following these steps, you can securely expose your Azure Log Analytics workspace to a user outs