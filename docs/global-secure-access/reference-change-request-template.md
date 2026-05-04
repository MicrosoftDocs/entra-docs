---
title: Global Secure Access change request template
description: "Template for documenting and tracking configuration changes to Microsoft Entra Global Secure Access."
ms.topic: reference
ms.date: 05/04/2026
ms.reviewer: tdetzner
ai-usage: ai-assisted
---

# Global Secure Access change request template

Use this template for all **normal** and **major** changes to Global Secure Access configuration. For change categories and the execution process, see the [Common operations guide](how-to-operations-common.md#change-management).

---

## Change request details

| Field | Value |
| --- | --- |
| **Change ID** | _(your ITSM ticket number or sequential ID)_ |
| **Date submitted** | |
| **Requested by** | |
| **Change category** | Standard / Normal / Emergency / Major |
| **Priority** | Low / Medium / High / Critical |
| **Target date** | |
| **Maintenance window required** | Yes / No |

## Description

**What is being changed?**

_(Describe the specific configuration change in detail. Include the GSA capability affected: Private Access, Internet Access, Remote Networks, or Microsoft Traffic.)_

**Why is this change needed?**

_(Business justification, user request, security requirement, or compliance need.)_

## Scope and impact

**Affected GSA capability:**
- [ ] Private Access
- [ ] Internet Access
- [ ] Remote Networks
- [ ] Microsoft Traffic
- [ ] Common / Cross-cutting

**Affected components:**

_(List specific components: connector groups, application segments, web filtering policies, traffic forwarding rules, tunnels, etc.)_

**Affected users / sites:**

_(Estimate the number of users or sites impacted. List specific groups or locations if known.)_

**Expected user impact during change:**

- [ ] No user impact
- [ ] Brief reconnection (< 1 minute)
- [ ] Service interruption during maintenance window
- [ ] Extended impact — communication plan required

## Risk assessment

| Risk factor | Assessment |
| --- | --- |
| **Risk level** | Low / Medium / High |
| **Potential for service disruption** | None / Minimal / Moderate / High |
| **Reversibility** | Fully reversible / Partially reversible / Irreversible |

**What could go wrong?**

_(Describe the worst-case scenario if the change fails.)_

## Testing

**Tested in non-production?** Yes / No / Not applicable

**Test results:**

_(Describe testing performed and outcomes. If not tested, explain why.)_

## Pre-change checklist

- [ ] Configuration backup completed (see capability guide for export scripts)
- [ ] Change approved by Service Owner or Change Advisory Board
- [ ] Communication sent to affected users and support teams (if required)
- [ ] Rollback plan documented (see below)
- [ ] Maintenance window scheduled (if required)
- [ ] On-call engineer confirmed for maintenance window

## Rollback plan

**How to roll back if the change fails:**

_(Step-by-step procedure to restore the previous configuration. Reference the backup file created in the pre-change checklist.)_

**Maximum time to decide on rollback:**

_(How long to wait before deciding the change has failed and needs to be rolled back.)_

## Execution

| Step | Action | Completed | Notes |
| --- | --- | --- | --- |
| 1 | Back up current configuration | [ ] | |
| 2 | _(Add change steps)_ | [ ] | |
| 3 | _(Add change steps)_ | [ ] | |
| 4 | Verify change — check traffic logs, alerts, and user connectivity | [ ] | |
| 5 | Confirm rollback is not needed | [ ] | |

## Post-change verification

- [ ] Traffic logs show expected behavior
- [ ] No new alerts triggered
- [ ] User access confirmed for affected applications / sites
- [ ] Change documented in ITSM system

## Approvals

| Role | Name | Approved | Date |
| --- | --- | --- | --- |
| Service Owner | | Yes / No | |
| Network Security Engineer | | Yes / No | |
| Change Advisory Board (if major) | | Yes / No | |

---

**Post-change notes:**

_______________________________________________________________________________

_______________________________________________________________________________
