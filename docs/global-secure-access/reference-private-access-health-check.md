---
title: Private Access health check checklist
description: "Daily, weekly, and monthly health check checklist for Microsoft Entra Private Access operations."
ms.topic: reference
ms.date: 05/04/2026
ms.reviewer: tdetzner
ai-usage: ai-assisted
---

# Private Access health check checklist

Use this checklist to maintain the health of your Microsoft Entra Private Access environment. For the consolidated daily health check covering all GSA capabilities, see the [daily health check template](reference-daily-health-check.md).

---

## Daily checks

**Date:** _______________  **Completed by:** _______________

| # | Check | How | Status | What to do if it fails |
|---|---|---|---|---|
| 1 | All connectors **Active** | Entra admin center > **Global Secure Access** > **Connect** > **Connectors** | Pass / Fail | Restart the `Microsoft Entra private network connector` service. Check outbound connectivity to `*.msappproxy.net:443`. Review Windows Event Logs on the connector host. |
| 2 | Connector resource utilization normal | Check CPU and memory on each connector host via your monitoring tool | Pass / Fail | If CPU > 80% or memory > 85%, investigate high-traffic applications and consider adding a connector to the group. |
| 3 | No unassigned P1/P2 alerts | Review Private Access alerts in Sentinel (or your SIEM) from the last 24 hours | Pass / Fail | Assign and begin investigation. Escalate alerts unassigned for more than 4 hours. |
| 4 | Audit log — no unauthorized changes | Run the [audit log KQL query](how-to-operate-private-access.md#kql-queries-for-private-access-monitoring) for the last 24 hours | Pass / Fail | Verify each change maps to an approved change request. Flag unrecognized changes and investigate. |
| 5 | Application access success rate normal | Spot-check `NetworkAccessTraffic` for Private Access denials in the last 24 hours | Pass / Fail | Identify affected users and apps. Determine if the denials are policy-related (adjust policy) or security-related (escalate to SOC). |
| 6 | Quick Access and per-app segments reachable | Verify key applications are accessible (manual test or synthetic monitoring) | Pass / Fail | Check the application segment configuration. Test DNS resolution and connectivity from the connector host to the backend server. |

**Daily notes:**

_______________________________________________________________________________

---

## Weekly checks

**Week of:** _______________  **Completed by:** _______________

| # | Check | How | Status | What to do if it fails |
|---|---|---|---|---|
| 1 | Connector group load distribution | Run the [connector group load KQL query](how-to-operate-private-access.md#kql-queries-for-private-access-monitoring) — look for hot connectors | Pass / Fail | If one connector handles significantly more traffic, check connector group assignments and consider rebalancing. |
| 2 | Policy efficacy review | Review top denied applications and users in the Sentinel workbook | Pass / Fail | Adjust policies for persistent false positives (legitimate traffic blocked). Investigate repeated unauthorized access attempts. |
| 3 | Configuration backup completed | Verify the [weekly configuration export](how-to-operate-private-access.md#export-private-access-configuration-via-graph-api) ran successfully and output is stored | Pass / Fail | Run the export manually. Troubleshoot the automation runbook. |
| 4 | Application segment inventory | Compare active segments (both Quick Access and per-app) against your application inventory | Pass / Fail | Add segments for newly onboarded apps. Flag stale segments for decommissioned apps (review before removing). |
| 5 | Cross-correlation review | Run the [cross-correlation KQL query](how-to-operate-private-access.md#kql-queries-for-private-access-monitoring) — denied connections + identity risk | Pass / Fail | Investigate users with both denied connections and elevated risk. Escalate confirmed threats to SOC. |
| 6 | Connector host OS health | Check for pending OS patches, disk space, and certificate expiration on connector hosts | Pass / Fail | Schedule patching during maintenance windows. Patch one connector at a time per group. Free disk space or extend storage. |

**Weekly notes:**

_______________________________________________________________________________

---

## Monthly checks

**Month:** _______________  **Completed by:** _______________

| # | Check | How | Status | What to do if it fails |
|---|---|---|---|---|
| 1 | Connector software version | Compare installed version on each host against the [latest available version](https://learn.microsoft.com/en-us/entra/global-secure-access/concept-connectors) | Pass / Fail | Schedule connector updates during a maintenance window. Update one connector at a time per group. |
| 2 | Failover validation | Follow the [failover validation procedure](how-to-operate-private-access.md#failover-validation) during a scheduled maintenance window | Pass / Fail | Investigate connector group assignment and network routing. Do not run in production without a maintenance window. |
| 3 | RBAC review | Review accounts with Global Secure Access Administrator or related roles in the Entra admin center | Pass / Fail | Remove access for accounts that no longer require it. Verify all admin accounts use phishing-resistant MFA. |
| 4 | Capacity assessment | Review 30-day trend of concurrent sessions and bandwidth per connector group against [capacity thresholds](how-to-operate-private-access.md#capacity-thresholds) | Pass / Fail | If any group is consistently above 70%, plan to add connectors. Use the [Private Access Sizing Planner](https://github.com/FranckhDev/GSA-Private-Access-Sizing-Planner). |
| 5 | Stale segment cleanup | Identify application segments with zero traffic in the last 90 days using [automation playbook #6](how-to-operate-private-access.md#automation-playbooks) | Pass / Fail | Review with application owners before removing. Document removed segments. |
| 6 | Performance baseline comparison | Compare current month's traffic patterns against the [30-day baseline](how-to-operate-private-access.md#kql-queries-for-private-access-monitoring) | Pass / Fail | Investigate significant deviations. Update baseline if traffic growth is expected (for example, new user populations onboarded). |
| 7 | DR/fallback plan review | Confirm your fallback connectivity plan is documented and contacts are current | Pass / Fail | Update the plan. If no plan exists, create one per [maintenance and health checks](how-to-operate-private-access.md#maintenance-and-health-checks). |

**Monthly notes:**

_______________________________________________________________________________

---

## Related content

- [Private Access operations guide](how-to-operate-private-access.md)
- [Daily health check (all capabilities)](reference-daily-health-check.md)
- [Common operations guide](how-to-operations-common.md)
