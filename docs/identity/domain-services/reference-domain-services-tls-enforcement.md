---
title: How to migrate to Transport Layer Security (TLS) 1.2 enforcement for Microsoft Entra Domain Services | Microsoft Learn
description: Learn how to enforce TLS 1.2 for a Microsoft Entra Domain Services managed domain.
author: justinha
manager: dougeby

ms.assetid: 6b4665b5-4324-42ab-82c5-d36c01192c2a
ms.service: entra-id
ms.subservice: domain-services
ms.topic: how-to
ms.date: 06/29/2025
ms.author: justinha
ms.reviewer: bochingwa
ms.custom: has-azure-ad-ps-ref, azure-ad-ref-level-one-done
---
# How to migrate to Transport Layer Security (TLS) 1.2 enforcement for Microsoft Entra Domain Services

Microsoft is enhancing security by disabling TLS versions 1.0 and 1.1 as communicated on November 10, 2023. While the Microsoft implementation of TLS 1.0 and TLS 1.1 versions isn't known to have vulnerabilities, TLS 1.2 or later versions provide improved security features, including perfect forward secrecy and stronger cipher suites. This change helps protect customer data and ensures compliance with industry standards.

Microsoft Entra Domain Services supports TLS versions 1.0 and 1.1, but they're disabled by default.
Domain Services will use the following retirement path for TLS versions 1.0 and 1.1:

1. Domain Services will remove the ability to disable **TLS 1.2 Only Mode**. Customers who disable **TLS 1.2 Only Mode** can enable it. 
1. After Domain Services removes the ability to disable the **TLS 1.2 Only Mode**, customers can't change the setting.

You can use the Azure portal or PowerShell to enable **TLS 1.2 Only Mode**.

## [**Azure portal**](#tab/portal)

1.	In the Azure portal, search for **Domain Services**, and select your Domain Services instance. 
2.	Select **Security Settings**.
3.	If **TLS 1.2 Only Mode** is set to **Disable**, the instance enables TLS versions 1.0 and 1.1. Set **TLS 1.2 Only Mode** to **Enable**, and then click **Save**.

   This change may take about 10 minutes to complete as domain security updates are enforced.

   :::image type="content" border="true" source="media/reference-domain-services-tls-enforcement/enable.png" alt-text="Screenshot that shows how to enable TLS 1.2 Only Mode for Domain Services.":::

## [**PowerShell**](#tab/powershell)

1. Install the Az.ADDomainServices module:

   ```powershell
   Install-Module -Name Az.ADDomainServices
   ```

1. Connect to the Azure subscription:

   ```powershell
   Connect-AzAccount -Subscription aaaa0a0a-bb1b-cc2c-dd3d-eeeeee4e4e4e
   ```

1. Check the value of TLS 1.2 only mode:

   ```powershell
   Get-AzADDomainService -DomainSecuritySettingTlsV1
   ```

   If the value is **Disabled**, then the instance is compliant. If the value is **Enabled**, proceed to the next step.

1. To change the value from **Enabled** to **Disabled**, get the name of the Domain Services instance:

   ```powershell 
   Get-AzADDomainService -Name
   ```

1. Get the resource group name where the domain instance is located:

   ```powershell
   Get-AzADDomainService -ResourceGroupName
   ```

1. Update the value of TLS 1.2 only mode: 

   ```powershell
   Update-AzADDomainService -Name "name" -ResourceGroupName "resourceGroupName" -DomainSecuritySettingTlsV1 Disabled
   ```

This command may take about 10 minutes to complete as domain security updates are enforced.

---

## Troubleshooting

If the steps to enable **TLS 1.2 Only Mode** fail, open an [Azure support request](/entra/fundamentals/how-to-get-support) for more troubleshooting help. 

## Related content

- [Enable support for TLS 1.2 in your environment for Microsoft Entra TLS 1.1 and 1.0 deprecation](/troubleshoot/entra/entra-id/ad-dmn-services/enable-support-tls-environment)
- [TLS 1.2 enforcement for Microsoft Entra Connect](/entra/identity/hybrid/connect/reference-connect-tls-enforcement)
