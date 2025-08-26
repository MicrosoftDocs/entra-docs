---
title: Microsoft Entra provisioning to applications using custom connectors
description: This document describes how to configure Microsoft Entra ID to provision users with external systems that offer REST and SOAP APIs.

author: jenniferf-skc
manager: pmwongera
ms.service: entra-id
ms.subservice: app-provisioning
ms.topic: how-to
ms.date: 04/09/2025
ms.author: jfields
ms.reviewer: arvinh
---


# Provisioning with the custom connectors

Microsoft Entra ID includes connectivity to provision into applications that support the following protocols and interfaces:

> [!div class="checklist"]
> - [SCIM 2.0](on-premises-scim-provisioning.md)
> - [SQL](tutorial-ecma-sql-connector.md)
> - [LDAP](on-premises-ldap-connector-configure.md)
> - [REST](on-premises-web-services-connector.md)
> - [SOAP](on-premises-web-services-connector.md)
> - [PowerShell](on-premises-powershell-connector.md)

For connectivity to applications that don't support one of the aforementioned protocols and interfaces, customers and [partners](/archive/technet-wiki/1589.fim-2010-mim-2016-management-agents-from-partners) have built custom [ECMA 2.0](/previous-versions/windows/desktop/forefront-2010/hh859557(v=vs.100)) connectors for use with Microsoft Identity Manager (MIM) 2016. ECMA2 connectors can be used to provision into apps with the Microsoft Entra provisioning agent and Extensible Connectivity(ECMA) Connector host, without needing MIM sync deployed.


## Exporting and importing a MIM connector
If you have a custom ECMA 2.0 connector in MIM, you can export its configuration by following the instructions [here](on-premises-migrate-microsoft-identity-manager.md#export-a-connector-configuration-from-mim-sync). You need to save the XML file, the DLL, and related software for your connector.

To import your connector, you can use the instructions [here](on-premises-migrate-microsoft-identity-manager.md#import-a-connector-configuration). You need to copy the DLL for your connector, and any of its prerequisite DLLs, to that same ECMA subdirectory of the Service directory. After the xml import, continue through the wizard and ensure that all the required fields are populated.

## Updating a custom connector DLL
When updating a connector with a newer build, ensure that the DLL is updated in all the required locations. Use these steps to properly update your custom connector DLL:
1. Close the Microsoft ECMA2Host Configuration Wizard.
2. Stop the Microsoft ECMA2Host service.
3. Manually update the custom connector DLL into each of the following folders.
    1. ECMA
    2. ECMA > Cache > {connector name}
    3. ECMA > Cache > {connector name} > AutosyncService
4. Start the Microsoft ECMA2Host service.
   
 > [!NOTE]
 > If multiple connectors are using the same custom DLL, complete step 3.ii and 3.iii for each connector.
 
## Troubleshooting

Custom connectors built for MIM rely on the [ECMA framework](/previous-versions/windows/desktop/forefront-2010/hh859557(v=vs.100)). If you're having difficulties importing and using a connector, please ensure that you're following best practices:
* Ensuring that methods in your connector are declared as public
* Excluding prefixes from method names. For example: 
  * **Correct:** public Schema GetSchema (KeyedCollection<string, ConfigParameter> configParameters)
  * **Incorrect:** Schema PrefixGetSchema.GetSchema (KeyedCollection<string, ConfigParameter> configParameters)
    
The following table includes capabilities of the ECMA framework that differ between MIM and the Microsoft Entra provisioning agent. For a list of known limitations for the Microsoft Entra provisioning service and on-premises application provisioning, see [here](known-issues.md#on-premises-application-provisioning).  


| **Capability**   | **Comments**   |
| --- | --- |
| Object type  | Provisioning agent permits one object type  |
| Partitions  | Provisioning agent permits one partition  |
| Hierarchies  | Not used by provisioning agent  |
| Full export   | Not used by provisioning agent |
| ExportPasswordInFirstPass  | Not supported  |
| Normalizations  | Not used by provisioning agent   |
| Concurrent operations  | Not used by provisioning agent  |
| DeleteAddAsReplace  | Not used by provisioning agent  |

## Next steps

- [App provisioning](user-provisioning.md)
- [ECMA Connector Host generic SQL connector](tutorial-ecma-sql-connector.md)
- [ECMA Connector Host LDAP connector](on-premises-ldap-connector-configure.md)
