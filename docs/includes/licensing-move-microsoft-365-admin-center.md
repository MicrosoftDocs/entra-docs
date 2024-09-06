---
author: barclayn
ms.author: barclayn
ms.date: 09/06/2024
manager: amycolannino
ms.service: entra-id
ms.topic: include
---



## License assignment move to the Microsoft 365 admin center FAQ 

Upcoming changes to license assignment processes, and move to the Microsoft 365 admin center require changes to the way you manage licenses. This section covers the reasons for the change, the timeline, license assignments options, and addresses common questions and known issues.

### Why is this change happening?  

This update is designed to streamline the license management process within the Microsoft ecosystem.  

### When are these changes happening? 

The changes will start taking effect from September 9, and will complete by  September 15.

### How do I use MS Graph/PowerShell to assign licenses? 

You can assign licenses using PowerShell or Microsoft Graph by following the detailed guides available on the Microsoft Learn website for user and group license assignments.

- [Assign Microsoft 365 licenses to user accounts with PowerShell](/microsoft-365/enterprise/assign-licenses-to-user-accounts-with-microsoft-365-powershell?view=o365-worldwide&preserve-view=true) 

- [Assign licenses to users with Microsoft Graph v1.0](/graph/api/user-assignlicense?view=graph-rest-1.0&tabs=http&preserve-view=true)

- [Assign Licenses to a Group with Microsoft Graph API](/graph/api/group-assignlicense?view=graph-rest-1.0&tabs=http&preserve-view=true)

### Are license assignment audit logs affected? 

There are no changes to the audit logs and you can still see all assigned licenses in the Microsoft Entra Admin Center. 

### Is there any loss of functionality with this change?  

No. There's no loss of functionality. This change is limited to the user interface. API and PowerShell access remain unaffected. However to assign licenses to a group via the Microsoft 365 Admin Center, the admin must have the License Administrator role. Group Administrators can still assign Group based licenses using the API and PowerShell.

### The admin portal doesn't provide functionality to reprocess group licenses.

The "reprocessing" button was originally introduced to address an issue with conversion between user and group based licensing. When debugging licensing issues, you can still reprocess users via Microsoft Graph and PowerShell using one of the following options:

- Use the Microsoft Graph PowerShell SDK module:

    ```powershell
    
    Import-Module Microsoft.Graph.Users.Actions 
    
    Invoke-MgLicenseUser -UserId $userId 
    ```

- Use the REST API directly

    ```powershell
    
    Invoke-MgGraphRequest -Uri "https://graph.microsoft.com/v1.0/users/$userid/reprocessLicense 
    ```

### What if I don’t have a Microsoft 365 Admin account or license and I manage licenses from the Azure portal?

For non-Microsoft 365 users, transitioning to managing licenses through a Microsoft 365 Admin Center account is essential.

Microsoft Entra ID roles: Global Administrator, User Administrator, and License Administrator have access to the Microsoft 365 Admin Center to manage licenses using their existing Microsoft Entra ID account. You don't have to be a Microsoft 365 customer to use the Microsoft 365 admin center. You don't have to be a Microsoft 365 customer to use the Microsoft 365 admin center, and can manage licenses there regardless. You don't have to be a Microsoft 365 customer to use the Microsoft 365 admin center, and can manage licenses there regardless. All Microsoft Entra customers have access to the Microsoft 365 Admin Center for domain and license management.

### How can I view license consumption and utilization now?

License consumption and utilization can still be viewed in the Microsoft 365 Admin Center under **Billing -> Licenses**.

### Who should I contact if I need help with these changes?

For questions, engage with community experts via Microsoft Questions and Answers. If you need technical assistance and have a support plan, you can create a support request.

For detailed instructions on assigning licenses, visit the [Microsoft 365 Admin Center guide](/microsoft-365/admin/manage/assign-licenses-to-users).

## Known Issues:

- Users with the Group Administrator role won't be able to assign licenses in the Microsoft 365 Admins Center.
  - This functionality was fully supported in both the Azure and Entra Portals. 
  - PowerShell continues to support the use of the Group Administrator role for license assignment.
  - Alternatively Group Administrators can be given the Licenses Administrator role in order to assign group based Licenses from the Microsoft 365 Admin Portal.  

- We are loosing some detailed group license assignments logging. The Azure portal was able to provide a detailed error to administrators.