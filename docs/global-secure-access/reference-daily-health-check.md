---
title: Global Secure Access daily health check
description: "Consolidated daily health check checklist for all Microsoft Entra Global Secure Access capabilities."
ms.topic: reference
ms.date: 05/04/2026
ms.reviewer: tdetzner
ai-usage: ai-assisted
---

# Global Secure Access daily health check

Use this checklist every business day. Record results and escalate any failed checks per the "What to do" column.

**Date:** _______________  **Completed by:** _______________

## Private Access

| # | Check | Status | What to do if it fails |
| --- | --- | --- | --- |
| 1 | All connectors show **Active** in Entra admin center > Global Secure Access > Connect > Connectors | Pass / Fail | Restart the connector service. If unresolved, check network connectivity and Windows Event Logs on the connector host. |
| 2 | No unassigned P1/P2 Private Access alerts in Sentinel | Pass / Fail | Assign and investigate. Escalate alerts older than 4 hours. |
| 3 | Audit log reviewed — no unauthorized configuration changes | Pass / Fail | Flag unrecognized changes. Verify each change maps to an approved change request. |

## Internet Access

| # | Check | Status | What to do if it fails |
| --- | --- | --- | --- |
| 4 | Internet Access traffic forwarding profile is enabled | Pass / Fail | Re-enable the profile. Check audit logs for who disabled it. |
| 5 | No unassigned P1/P2 Internet Access alerts in Sentinel | Pass / Fail | Assign and investigate. Escalate alerts older than 4 hours. |
| 6 | Spot-check top 10 blocked URLs — verify they should be blocked | Pass / Fail | Adjust policies or add exceptions for legitimate business sites. |

## Remote Networks

| # | Check | Status | What to do if it fails |
| --- | --- | --- | --- |
| 7 | All tunnels show **Connected** in Entra admin center > Global Secure Access > Connect > Remote networks | Pass / Fail | Check CPE device status and ISP connectivity at the affected branch. |
| 8 | No unassigned P1/P2 Remote Networks alerts in Sentinel | Pass / Fail | Assign and investigate. Escalate alerts older than 4 hours. |
| 9 | Traffic volumes for major sites are within baseline range | Pass / Fail | Investigate significant drops (possible outage) or spikes (possible anomaly). |

## Microsoft Traffic

| # | Check | Status | What to do if it fails |
| --- | --- | --- | --- |
| 10 | Microsoft traffic forwarding profile is enabled | Pass / Fail | Re-enable the profile. Check audit logs for who disabled it. |
| 11 | No user-reported Microsoft 365 performance issues in helpdesk queue | Pass / Fail | If reported, compare Global Secure Access traffic logs with the Microsoft 365 service health dashboard. |
| 12 | Spot-check sign-in logs for compliant network enrichment | Pass / Fail | Verify the Global Secure Access client is running on affected devices and the compliant network check is configured. |

## Cross-cutting

| # | Check | Status | What to do if it fails |
| --- | --- | --- | --- |
| 13 | Azure Service Health and Microsoft 365 service health — no reported Global Secure Access service issues | Pass / Fail | If Microsoft reports an issue, communicate it to your operations team and follow the published mitigation guidance. |
| 14 | All scheduled automation jobs (backups, reports) ran successfully | Pass / Fail | Troubleshoot the failed job. Run the backup or report manually if needed. |

---

**Notes / issues observed:**

_______________________________________________________________________________

_______________________________________________________________________________

_______________________________________________________________________________
