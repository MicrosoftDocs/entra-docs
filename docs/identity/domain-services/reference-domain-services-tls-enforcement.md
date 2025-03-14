---
title: TLS 1.2 enforcement for Microsoft Entra Domain Services | Microsoft Learn
description: Learn how to enforce TLS 1.2 for a Microsoft Entra Domain Services managed domain.
author: justinha
manager: femila

ms.assetid: 6b4665b5-4324-42ab-82c5-d36c01192c2a
ms.service: entra-id
ms.subservice: domain-services
ms.topic: how-to
ms.date: 03/14/2025
ms.author: justinha
ms.reviewer: bochingwa
ms.custom: has-azure-ad-ps-ref, azure-ad-ref-level-one-done
---
# TLS 1.2 enforcement for Microsoft Entra Domain Services

Azure services are on a deprecation path for legacy TLS versions 1.0 and 1.1.
Microsoft Entra Domain Services supports the legacy TLS versions, but they are disabled by default.
Domain Services will use the following deprecation path for legacy TLS:

1. Remove the ability to disable the TLS 1.2 only mode. Customers who disable TLS 1.2 only mode can enable it. \<date\>
1. Customers can't enable or disable the security setting by using the Azure portal, Microsoft Entra admin center, or programmatically with ARM APIs, PowerShell, or Bicep or ARM templates. \<date\>
1. Work with customers needing legacy TLS.

## How to check status for TLS in Domain Services

Use the Azure Portal:
1.	In th Azure portal, go to the Microsoft Entra DS instance. 
2.	Go to the Security settings.
3.	If the TLS 1.2 only mode is set to **Disable**, the instance has enabled legacy TLS.
4.	If TLS 1.2 only mode is disabled, enable it and then save.

Use PowerShell:

1. Install the Az.ADDomainServices module:

   ```powershell
   Install-Module -Name Az.ADDomainServices
   ```

1. Connect to the Azure subscription:

   ```powershell
   Connect-AzAccount -Subscription aaaa0a0a-bb1b-cc2c-dd3d-eeeeee4e4e4e
   ```

1. Check the value of TLS only mode:

   ```powershell
   Get-AzADDomainService -DomainSecuritySettingTlsV1
   ```

   If the value is **Disabled**, then the instance is compliant. If the value is **Enabled**, proceed to the next step.

1. To change the value from **Enabled** to **Disabled**, get the name of the Domain Services instance:

   ```powershell 
   Get-AzADDomainService -Name
   ```

   Get the Resource Group Name where the domain instance is located:

   ```powershell
   Get-AzADDomainService -ResourceGroupName

   Update the value of TLS only mode: 

   ```powershell
   Update-AzADDomainService -Name "name" -ResourceGroupName "resourceGroupName" -DomainSecuritySettingTlsV1 Disabled
   ```

   This command may take about 10 minutes to complete.


