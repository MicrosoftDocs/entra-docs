---
title: PowerShell samples in Application Management
description: These PowerShell samples are used for apps you manage in your Microsoft Entra tenant. You can use these sample scripts to find expiration information about secrets and certificates.

author: omondiatieno
manager: CelesteDG
ms.service: entra-id
ms.subservice: enterprise-apps

ms.topic: sample
ms.date: 07/12/2023
ms.author: jomondi
ms.reviewer: sureshja
ms.custom: enterprise-apps, has-azure-ad-ps-ref

#customer intent: As an IT admin managing application registrations and enterprise apps in Microsoft Entra ID, I want to export secrets and certificates for app registrations and enterprise apps in my Microsoft Entra tenant, so that I can ensure their security and manage expiring credentials.
---

# Azure Active Directory PowerShell examples for Application Management

The following table includes links to PowerShell script examples for Microsoft Entra Application Management.

These samples require the [Microsoft Graph PowerShell](/powershell/microsoftgraph/installation) SDK module.

| Link | Description |
|---|---|
|**Application Management scripts**||
| [Export secrets and certs (app registrations)](scripts/powershell-export-all-app-registrations-secrets-and-certs.md) | Export secrets and certificates for app registrations in Microsoft Entra tenant. |
| [Export secrets and certs (enterprise apps)](scripts/powershell-export-all-enterprise-apps-secrets-and-certs.md) | Export secrets and certificates for enterprise apps in Microsoft Entra tenant. |
| [Export expiring secrets and certs (app registrations)](scripts/powershell-export-apps-with-expiring-secrets.md) | Export app registrations with expiring secrets and certificates and their Owners in Microsoft Entra tenant. |
| [Export expiring secrets and certs (enterprise apps)](scripts/powershell-export-enterprise-apps-with-expiring-secrets.md) | Export enterprise apps with expiring secrets and certificates and their Owners in Microsoft Entra tenant. |
| [Export secrets and certs expiring beyond required date](scripts/powershell-export-apps-with-secrets-beyond-required.md) | Export App Registrations with secrets and certificates expiring beyond the required date in Microsoft Entra tenant. This uses the non interactive Client_Credentials Oauth flow. |
