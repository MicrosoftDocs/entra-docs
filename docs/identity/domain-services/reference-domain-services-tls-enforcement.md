---
title: How to migrate to Transport Layer Security (TLS) 1.2 enforcement for Microsoft Entra Domain Services | Microsoft Learn
description: Learn how to enforce TLS 1.2 for a Microsoft Entra Domain Services managed domain.
author: justinha
manager: dougeby

ms.assetid: 6b4665b5-4324-42ab-82c5-d36c01192c2a
ms.service: entra-id
ms.subservice: domain-services
ms.topic: how-to
ms.date: 08/15/2025
ms.author: justinha
ms.reviewer: bochingwa
ms.custom: has-azure-ad-ps-ref, azure-ad-ref-level-one-done
---
# How to migrate to Transport Layer Security (TLS) 1.2 enforcement for Microsoft Entra Domain Services

Microsoft is enhancing security by disabling TLS versions 1.0 and 1.1 as communicated on November 10, 2023. While the Microsoft implementation of TLS 1.0 and TLS 1.1 versions isn't known to have vulnerabilities, TLS 1.2 or later versions provide improved security features, including perfect forward secrecy and stronger cipher suites. This change helps protect customer data and ensures compliance with industry standards.

Microsoft Entra Domain Services supports TLS versions 1.0 and 1.1, but they're disabled by default. Domain Services has removed the ability to disable **TLS 1.2 Only Mode**. Customers who disable **TLS 1.2 Only Mode** can enable it. 

You can use the Azure portal or PowerShell to enable **TLS 1.2 Only Mode**.

## Identify applications that use deprecated TLS versions

Before you enable **TLS 1.2 Only Mode**, it's important to identify applications that still use TLS 1.0 or 1.1, and update them or replace them with alternatives that support TLS 1.2. For more information about apps that are expected to be impacted, see [TLS 1.0 and TLS 1.1 deprecation in Windows](/windows/win32/secauthn/tls-10-11-deprecation-in-windows).

## [**Azure portal**](#tab/portal)

1. In the Azure portal, search for **Domain Services**, and select your Domain Services instance. 
1. Select **Security Settings**.
1. If **TLS 1.2 Only Mode** is set to **Disable**, the instance enables TLS versions 1.0 and 1.1. Set **TLS 1.2 Only Mode** to **Enable**, and then click **Save**.

   This change may take about 10 minutes to complete as domain security updates are enforced.

   :::image type="content" border="true" source="media/reference-domain-services-tls-enforcement/enable.png" alt-text="Screenshot that shows how to enable TLS 1.2 Only Mode for Domain Services.":::

>[!Note] 
>Until August 31, 2025, you can select **Disable** to temporarily allow legacy TLS traffic while you update or replace apps that might fail. Select **Enable** again to remain compliant. 

## [**PowerShell**](#tab/powershell)


1. Install the Az.ADDomainServices module:

   ```powershell
   Install-Module -Name Az.ADDomainServices
   ```

1. Connect to the Azure subscription:

   ```powershell
   Connect-AzAccount -Subscription aaaa0a0a-bb1b-cc2c-dd3d-eeeeee4e4e4e
   ```

1. Update the value of **TLS 1.2 Only Mode** by executing these two commands:

   ```powershell
   $domainService = Get-AzADDomainService
   ```
   
   ```powershell
   Update-AzADDomainService -Name $domainService.Name -ResourceGroupName $domainService.ResourceGroupName -DomainSecuritySettingTlsV1 Disabled
   ```

   This command may take about 10 minutes to complete as domain security updates are enforced.

## Troubleshooting

- Some apps provide logs or error messages when TLS handshakes fail. Use application-level diagnostics to  look for errors related to unsupported protocols.

- Until August 31, 2025, you can modify the following powershell example to temporarily allow legacy TLS traffic while you update or replace apps:

  ```powershell
  Update-AzADDomainService -Name $domainService.Name -ResourceGroupName $domainService.ResourceGroupName -DomainSecuritySettingTlsV1 Enabled
  ```

- For more troubleshooting help, you can [create an Azure support request](/entra/fundamentals/how-to-get-support). 

## Related content

- [Enable support for TLS 1.2 in your environment for Microsoft Entra TLS 1.1 and 1.0 deprecation](/troubleshoot/entra/entra-id/ad-dmn-services/enable-support-tls-environment)
- [TLS 1.2 enforcement for Microsoft Entra Connect](/entra/identity/hybrid/connect/reference-connect-tls-enforcement)
