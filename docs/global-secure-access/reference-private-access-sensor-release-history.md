---
title: Microsoft Entra Private Access Sensor release notes
description: This article tracks the released versions of the Microsoft Entra Private Access Sensor and the changes in each version.
ms.topic: reference
ms.date: 06/17/2026
ms.subservice: entra-private-access
ms.reviewer: shkhalid
ai-usage: ai-assisted
---

# Microsoft Entra Private Access Sensor release notes

This article lists the released versions of the Microsoft Entra Private Access Sensor and the changes in each version.

## Download the latest version

You can download the current version of the Private Access Sensor from the Microsoft Entra admin center.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Secure Access Administrator](/azure/active-directory/roles/permissions-reference#global-secure-access-administrator).
1. Browse to **Global Secure Access** > **Connect** > **Connectors and sensors** > **Private access sensors**.
1. Select **Download private access sensor**.

## Version 2.2.42

Released for download on June 16, 2026.

### Security enhancements

- Hardens file and Event Tracing for Windows (ETW) channels against tampering by using channel permissions.
- Adds fail-close enforcement for policy failures.

### Kerberos observability

- Adds ticket hash computation for AS-REP, TGS-REQ, and TGS-REP.
- Adds differentiated ETW event IDs for all sensor events.

### Configurable ETW trace file size cap

- Caps ETL, trace, and log files at a configurable maximum size.
- Persists the configured maximum size across upgrades.
- Helps prevent disk exhaustion.

### Diagnostics and telemetry

- Improves telemetry reporting to the cloud.

### Access enforcement

- Adds privileged user access enforcement. This capability restricts cloud-based user access to privileged local users by UPN or SID and is in preview.

### Bug fixes

- Includes bug fixes and minor improvements.
