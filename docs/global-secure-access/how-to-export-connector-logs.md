---
title: Export connector logs to the Log Analytics workspace
description: Extract connector logs and send those logs to the Log Analytics workspace in the customer’s Azure subscription.
ms.service: global-secure-access
ms.topic: how-to
ms.date: 11/26/2024
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
Verbose logs are useful when debugging Microsoft Entra Private Network Connector side issues for Entra Private Access. Verbose logging is not enabled in the connector by default. To enable verbose logging:

1. Locate the installation directory of the connector at `C:\Program Files\Microsoft Entra Private Network Connector`.
2. Create a folder on in the local directory with write permissions **On**. 
    To verify write permissions, 
    - Right-click on the folder you created, then click **Properties**.  
    - Go to the **Security** tab and make sure the **Write** property is checked for **Allow**.
    - If **Write** is not checked, select **edit**. 
    - On the pop-up window, select **allow** for the **write** row, then click **apply**. 
3. Right-click on a text editor application such as Notepad or Notepad++, select **Run as Administrator**, and open the file `MicrosoftEntraPrivateNetworkConnector.exe.config`to edit. 
4. Add the following higlighted section from <system.diagnostics> to </system.diagnostrics> to the file in that location.


``` json
<?xml version="1.0" encoding="utf-8" ?> 
<configuration> 
<runtime> 
<gcServer enabled="true"/> 
</runtime> 
<appSettings> 
<add key="TraceFilename" value="MicrosoftEntraPrivateNetworkConnector.log" /> 
</appSettings> 
<system.diagnostics> 
<trace autoflush="true" indentsize="4"> 
<listeners> 
<add name="consoleListener" type="System.Diagnostics.ConsoleTraceListener" /> 
<add name="textWriterListener" type="System.Diagnostics.TextWriterTraceListener" initializeData="C:\logs\connector_logs.log" /> 
<remove name="Default" /> 
</listeners> 
</trace> 
</system.diagnostics>
</configuration>
```

Next, we need to Stop and Start the Connector service for the above changes to take effect.

5. Type **Services** in search box in taskbar, then go to **Services**. 
6. Look for the **Microsoft Entra Private Network Connector** service from the Services list and select it.
7. Choose **Stop** the agent service, then **Start** the agent service again. At this point, you should see a text file labeled `connector_logs.log` in the C:\logs\ folder. 

> [!NOTE]
> When verbose logging isn't enabled, the default log file location is stored at `C:\Users\<user>\AppData\Local\Temp`. When verbose logging is enabled, the log file is stored at `C:\logs\connector_logs.log`.
> Verbose logging can be enabled or disabled by adding or removing the lines specified in step 4. You must restart the service agent each time for the logging changes to take effect.

### Set Up Azure Arc for On-Premises Machine
1. Get the script for enabling Azure Arc for the on-premises machine:
    - Go to the [Azure Portal](https://portal.azure.com/).
    - Search for **Azure Arc** in the search bar.
    - Go to **Azure Arc resources > Machines**.
    - Click on **Add/Create > Add a Machine**.
    - Add a single server > click on **Generate Script**.
    - Fill in the information, then click **Download and Run Script**.
2.	Install Azure Arc Agent on on-premises Connector Machine:
    - Download the Azure Arc agent setup script from the Azure portal or Microsoft documentation.
    - Search for **Windows PowerShell ISE** in the search box on the Task bar. Right click on the application, then click **Run as administrator**.  
    From PowerShell, open the downloaded file labeled `OnboardingScript.ps1`. 
    - Run the script. 
    - Log in on the pop up window to authenticate using the Azure account credentials. The screen returns a message that reads:
    `Authentication complete. You can return to the application. Feel free to close this browser tab.`
 
### Set Up Log Analytics Workspace
1. Go to the [Azure Portal](https://portal.azure.com/).
2. Create a Log Analytics workspace: 
    - In the search bar, type **Log Analytics** and select **Log Analytics workspaces**.
    - Click **Create**.
    - Fill in the necessary details:
      - **Subscription**: Select your subscription.
      - **Resource Group**: Select an existing resource group or create a new one.
      - **Name**: Provide a unique name for the Log Analytics workspace.
      - **Region**: Choose the region closest to your on-premise machine.
    - Click **Review + create** and then **Create**.
3. Create a table under the new workspace. 
	- Select the workspace name you just created. 
	- Navigate to **Workspace -> Settings -> Tables**. 
	- Click **Create -> New Custom Log (MMA-based)**.
	- Select log file from the VM location (`C:\logs\connector_logs.log`).
	- Set delimiter as New Line.
	- Add Collection Path Type – windows & Path as `C:\logs\connector_logs.log`. 
	- Click **Create**.

### Set Up Data Collection Endpoint (DCE)
1. Go to the [Azure Portal](https://portal.azure.com/).
2. In the search bar, search for **Data Collection Endpoint**.
3. Click **Create**.
4. Provide a name and region for the DCE.
5. Click **Review + create** and then **Create**.

### Set Up Data Collection Rule (DCR)
1. Go to the [Azure Portal](https://portal.azure.com/).
2. In the search bar, search for **Data Collection Rule**.
3. Click **Create**.
4. Fill in the necessary details:
    - **Subscription**: Select your subscription.
    - **Resource Group**: Select the same resource group as your Log Analytics workspace.
    - **Name**: Provide a name for the DCR.
    - **Region**: Choose the same region as your Log Analytics workspace.
    - **Platform**: Windows.
    - **Data collection Endpoint**: Select data collection endpoint you created in previous step.
5. Click Next: Resources
	- Add resources.
	- Open your subscription.
	- Select your resource group from the list.
	- Click apply. You should see your VM name list in the resources.
6. Click Next: Collect and deliver
	- Click **Add data source**.
	- For the Data source type, select "Custom Text logs".
	- Specify the paths to the logs on your on-premise Windows machine (e.g., C:\logs\ connector_logs.log).
	- Enter the table name you created under log analytics workspace. 
	  To get the table name, open a new tab and navigate to the azure portal and search for **Log Analytics Workspaces**. Select the table you created. Click on **setting** and open the 
      tables. Find the name of the **custom table (classic)**. 
	- Click **Add** and then **Next: Destination**.
7. Configure Destination:
	- Destination **Type-> Azure Monitor Logs**.
	- Select your subscription.
	- Select your Log Analytics workspace as the destination.
	- Ensure your Data Collection Endpoint is selected.
	- Click **Next: Review + create** and then **Create**.

### Verify Data Collection
1. Check Data in Log Analytics:
	- After installing and configuring the agent, it may take some time for data to start appearing.
	- In the Azure portal, go to your Log Analytics workspace > Select your Workspace.
	- Navigate to **Logs**, click exit on the pop up hub > **Custom Logs** > Double Click on your log name. This adds the log name into the query. 
	- Select **Run**. You'll see your logs.
    This setup allows you to collect text logs from on-premises Windows machines and send them to Azure Log Analytics using Azure Arc. The data collection rule ensures the logs are
    collected as per the defined paths, and the agent sends them to your Log Analytics workspace.

## Share access to your workspace 
Once you have the logs into the Log Analytics workspace, you can expose the logs to a user outside of your tenant by sharing access to the workspace in a secure manner. One use case is to grant access to support personnel (as required) for any support issues. Support personnel can be from Microsoft CSS (Customer Service & Support), Engineering OCE (On Call Engineer) or the customer’s own support network. This helps with swiftly diagnosing the problem, positively impacting the Mean Time to Recovery (MTTR) and Mean Time to Mitigate (MTTM), by extension, customer satisfaction.

Here are the steps to achieve this:

### Prerequisites

1.	**Azure Subscription**: Ensure you have an active Azure subscription.
2.	**Log Analytics Workspace**: An existing Log Analytics workspace that you want to share.
3.	**Azure AD Guest User**: The external user must be added as a guest user in your Azure Active Directory (AD).

### Add External User as a Guest in Azure AD
1.	Navigate to Azure Active Directory:
	- Go to the [Azure Portal](https://portal.azure.com/).
	- In the search bar, type **Microsoft Entra ID**, then select it.
2.	Add a New Guest User:
	- In the Microsoft Entra ID dashboard, select **Manage -> Users**.
	- Click on **+ New user**, then select **Invite external user**.
	- Enter the external user's email address and fill in the required information.
	- Click **Invite** to send an invitation to the external user.
The external user receives an email invitation to join your Microsoft Entra ID page as a guest.

### Assign Roles to the Guest User in Log Analytics Workspace
1.	Navigate to the Log Analytics Workspace:
	- In the Azure Portal, search for  **Log Analytics workspaces**, then select the workspace you want to share.
2.	Access Control (IAM):
	- In the workspace blade, select **Access control (IAM)** from the left-hand menu.
	- Click on **+ Add**, then select **Add role assignment**.
3.	Assign a Role:
	- Select a role to assign to the guest user. Common roles for accessing Log Analytics include:
	 - Log Analytics Reader: Allows the user to read and query logs.
	 - Log Analytics Contributor: Allows the user to read, query, and modify logs.
4.	Add the Guest User:
	- In the Members section, click **Select members**.
	- Search for the guest user you added earlier by their email address.
	- Select the guest user and click **Select**.
5.	Review and Assign:
	- Review the role assignment and click "Review + assign" to complete the process.

### Ensure Permissions Are Properly Set
1.	Verify Permissions:
	- The guest user should now have access to the Log Analytics workspace with the permissions assigned.
	- You can verify by going to "Access control (IAM)" in the Log Analytics workspace and checking the role assignments.

### External User Access and Query Logs
1.	**External User Access**:
	- The external user needs to accept the invitation sent to their email and log into the Azure Portal using their credentials.
2.	**Accessing Log Analytics**:
	- Once logged in, the external user navigates to the Log Analytics workspace shared with them.	
    - They can use the Log Analytics workspace's **Logs** feature to query and analyze logs based on the permissions granted.

### Additional Considerations
•	**Security**: Ensure that you only grant the necessary permissions to the guest user. The principle of least privilege should be followed.
•	**Monitoring and Auditing**: Regularly monitor and audit access to your Log Analytics workspace to ensure compliance and security.
By following these steps, you can securely expose your Azure Log Analytics workspace to a user outside your tenant, allowing them to access and query logs as needed.

## Next steps
