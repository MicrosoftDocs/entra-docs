---
title: PowerShell samples for Global Secure Access
description: Use these PowerShell samples to automate common Global Secure Access tasks, including connector registration, client install, traffic forwarding bypasses, break glass scenarios, TLS certificate creation, operations monitoring, and recovery.
ms.topic: sample
ms.date: 06/17/2026
ms.reviewer: katabish
ai-usage: ai-assisted
---

# Global Secure Access PowerShell samples

## Overview

These sample scripts provide guidance on common Global Secure Access tasks using PowerShell. Most samples require the [Microsoft Graph Beta PowerShell module](/powershell/microsoftgraph/installation) 2.10 or newer, unless otherwise noted.

The samples are grouped by scenario.

## Connector setup

| Sample | Description |
|---|---|
| [Get token for connector](scripts/powershell-get-token.md) | Get the auth token for registering your Microsoft Entra private network connector through Azure, AWS, or GCP Marketplaces. |

## Client deployment

| Sample | Description |
|---|---|
| [Install the Global Secure Access Windows client as a proof of concept](scripts/powershell-windows-client-install-proof-of-concept.md) | Automate installation of the Global Secure Access Windows client and apply essential registry configurations for proof-of-concept deployments. |

## Traffic forwarding and bypass

| Sample | Description |
|---|---|
| [Add a custom bypass rule to Internet Access](scripts/powershell-bypass-script.md) | Programmatically add a custom bypass rule to the Microsoft Entra Internet Access forwarding policy to bypass specified domains or IPs. |
| [Add Intune device compliance bypasses to Internet Access](scripts/powershell-add-internet-access-device-compliance-bypasses.md) | Add Intune-related network endpoints to the Internet Access custom bypass policy to mitigate device compliance issues. |

## Break glass

| Sample | Description |
|---|---|
| [Disable traffic forwarding and Compliant Network policies (break glass)](scripts/powershell-break-glass.md) | Quickly disable traffic forwarding profiles and switch Conditional Access policies that use the Compliant Network condition into Report-Only mode during an outage. |
| [Restore Compliant Network requirement after break glass](scripts/powershell-break-glass-recovery.md) | Re-enable the forwarding profiles and Conditional Access policies that were disabled by the break glass script after an outage is resolved. |

## TLS inspection certificates

| Sample | Description |
|---|---|
| [Create and sign TLS certificates using Active Directory Certificate Services](scripts/powershell-active-directory-certificate-service.md) | Generate a certificate signing request through the TLS inspection Graph API, sign it with ADCS, and upload the certificate and chain to TLS inspection settings. |
| [Create and sign TLS certificates using OpenSSL](scripts/powershell-open-secure-sockets-layer.md) | Generate a certificate signing request through the TLS inspection Graph API, sign it with a self-signed root CA created by OpenSSL, and upload the certificate and chain to TLS inspection settings. |

## Operations monitoring

| Sample | Description |
|---|---|
| [Shared helper functions for operations scripts](scripts/powershell-global-secure-access-operations-helpers.md) | Use shared authentication, Log Analytics token, and alert email helper functions for operations automation scripts. |
| [Verify configuration backup compliance](scripts/powershell-test-backup-compliance.md) | Check recent Azure Automation jobs for your Global Secure Access configuration backup runbook and alert when backups fail or miss a scheduled run. |
| [Check role assignment reviews](scripts/powershell-test-role-based-access-control-hygiene.md) | Query Global Secure Access-related role assignments and identify administrator accounts that need quarterly review. |
| [Calculate alert noise ratio](scripts/powershell-test-alert-noise-ratio.md) | Calculate the Microsoft Sentinel alert noise ratio for Global Secure Access detections and identify noisy analytics rules. |

## Recovery

| Sample | Description |
|---|---|
| [List Microsoft Entra snapshots](scripts/powershell-get-entra-snapshot.md) | List Microsoft Entra Backup and Recovery snapshots for the tenant and identify the latest available snapshot. |
| [Preview Microsoft Entra recovery](scripts/powershell-start-entra-recovery-preview.md) | Create a non-destructive recovery preview job scoped to directory objects that affect Global Secure Access. |
| [Run Microsoft Entra recovery](scripts/powershell-invoke-entra-recovery.md) | Run a Microsoft Entra recovery job after reviewing and approving the matching preview job. |

## Related content

- [What is Global Secure Access?](overview-what-is-global-secure-access.md)
- [Global Secure Access operations guide](overview-operations.md)
- [Security operations for network access](how-to-security-operations.md)
- [Microsoft Graph Beta PowerShell module installation](/powershell/microsoftgraph/installation)
