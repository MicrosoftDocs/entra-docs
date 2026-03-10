---
title: Signals and metrics for tenant discovery
description: Learn about the signals and metrics used in Microsoft Entra tenant governance to identify and evaluate related tenants.
author: barclayn
ms.author: barclayn
ms.service: entra-id-governance
ms.topic: concept-article
ms.date: 03/10/2026
---

<!-- source: [Concept] Related tenants signals and metrics.docx -->

# Signals and metrics for tenant discovery

Tenant Discovery is a core capability within the Tenant Governance pillar that helps organizations identify **related tenants** -- tenants that have a discoverable relationship with your tenant.

Discovery is powered by a small set of **well‑defined discovery signals** derived from existing Entra and Azure platform interactions. These signals explain *why* two tenants are related. **Metrics provide additional context**, such as directionality, recency, and relative scale, to help administrators interpret those relationships and prioritize governance actions.

This article focuses exclusively on:

1. Discovery signals and what they represent

1. How each signal is composed

1. How metric concepts apply to each signal

1. How signals and metrics should be interpreted together

## Discovery Signals at a Glance

| Type | Discovery Signal | What it Represents | Nature |
|---|---|---|---|
| B2B collaboration | **B2B registration** | Guest users cross-tenant | State‑based |
| B2B collaboration | **B2B sign-ins** | Cross-tenant sign-in activity | Activity-based |
| B2B collaboration | **Admin app sign-ins** | Cross-tenant sign-in activity across predefined admin applications | Activity-based |
| Multitenant applications | **Multitenant applications** | Cross‑tenant application trust and consent | State‑based |
| Shared billing accounts | **Shared billing accounts** | Financial and operational linkage between tenants | State‑based |

Discovery signals are **descriptive, not prescriptive**. A signal explains that a relationship exists and why but does not imply ownership or required action.

## Discovery Signals

### B2B Collaboration Signals

The **B2B collaboration signal** identifies tenants that participate in **cross‑tenant identity interactions** with the related tenant. It is grounded in Microsoft Entra External Identities and captures both user collaboration and cross‑tenant administrative activity.

At a conceptual level, this signal answers:

> *Are identities from one tenant authenticating into or collaborating with another tenant?*

This signal intentionally combines multiple identity inputs to reflect both breadth and depth of cross‑tenant interaction.

The B2B collaboration signal is composed of three related sub-signals:

- B2B registration

- B2B sign-ins

- Admin app sign-ins

#### B2B Registration

B2B registration reflects the presence of **guest users or external members** from one tenant registered in another tenant. This is often the first observable indicator of cross‑tenant collaboration.

**Why it matters**

- Establishes that a trust boundary has been crossed

- Indicates potential access to resources

- Does not imply active usage

#### B2B Sign‑Ins

B2B user sign‑ins capture **authentication activity** by guest users or external members across tenants. Unlike registration, sign‑ins indicate active collaboration.

**Why it matters**

- Distinguishes active relationships from dormant ones

- Serves as a primary signal for *recent* activity

- Helps assess the operational relevance of a tenant relationship

#### Admin App Sign‑Ins

Admin app sign‑ins are a **specialized subset of B2B sign‑ins** that occur when users **authenticate across tenants to predefined Microsoft Entra administrative applications.** These sign‑ins usually indicate cross‑tenant administrative activity, not just collaboration.

**What are "admin apps"?**\
Admin apps are a predefined set of first‑party Microsoft Entra administrative surfaces. The exact set of admin apps is defined and maintained by the Tenant Discovery service and is not customer‑configurable.

| Application |
|---|
| Azure Portal |
| Entra Admin Center |
| Intune Admin center |
| Exchange Admin Center |
| Windows Admin Center |
| SharePoint Tenant Admin Center |
| Microsoft Teams Admin Portal Service |
| Microsoft 365 Admin Portal |
| Microsoft Office 365 Portal |

**Why it matters**

- Indicates elevated trust and privilege across tenants

- Suggests that administrative workflows span tenant boundaries

- Often correlates with higher governance relevance

#### How the B2B Components Work Together

| Observation | Interpretation |
|---|---|
| Registration only | Trust established, activity unclear |
| User sign‑ins present | Active collaboration |
| Admin app sign‑ins present | Administrative coupling and elevated impact |

Together, these inputs provide layered context without exposing user‑level data.

### Multitenant Application Signal

The **multitenant application signal** identifies tenants that have established **application‑level trust relationships** with the related tenant through multitenant application registrations and cross-tenant consent and instantiation.

At a conceptual level, this signal answers:

*Are applications registered in one tenant trusted and instantiated in another tenant?*

This signal captures non‑human trust relationships, which often persist longer and are harder to audit than user collaboration.

**Why it matters**

- Applications may have broad permissions

- Trust relationships are durable

- Risk can exist even without active user collaboration

### Shared Billing Accounts Signal

The **billing signal** identifies tenants that are connected through the underlying concept of **primary and associated billing tenants** in Azure MCA enterprise billing accounts.

At a conceptual level, this signal answers:

*Are these tenants financially or operationally linked?*

This signal reflects organizational affiliation, not identity or application trust.

At this time, EA/legacy commerce constructs are not supported. You must have an MCA enterprise billing account to discover related tenants via the billing signal.

**Why it matters**

- Strong indicator of internal ownership or alignment

- Often correlates with centrally funded environments

- High‑confidence input for prioritization

## Metrics Concepts

Metrics provide additional context for discovery signals. They help administrators understand:

- Whether a relationship is active or historical

- Directionality of trust and access

- The relative strength of a relationship

Not all metric concepts apply to all signals.

### Initial vs. Recent Metrics

For activity‑based signals, Tenant Discovery distinguishes between **initial** and **recent** metrics.

| Metric | Meaning |
|---|---|
| Initial | First observed instance of qualifying activity |
| Recent | Ongoing or newly observed activity within a rolling window |

This distinction answers:

*When was this relation discovered and is this relation still active use today?*

**Signal Applicability**

| Signal | Initial | Recent |
|---|---|---|
| B2B collaboration | ✅ | ✅ |
| Multitenant applications | ✅ | ✅ |
| Shared billing accounts | ❌ | ❌ |

Billing relationships are configuration‑based and do not fluctuate over time.

### Inbound vs. Outbound Metrics

Inbound and outbound metrics describe the **direction of interaction**.

| Direction | Definition |
|---|---|
| Inbound | Activity or configuration originating from the related tenant. |
| Outbound | Activity or configuration originating from the calling tenant. |

This answers:

*What is the directionality of trust and/or access?*

**Signal Applicability**

| Signal | Inbound / Outbound |
|---|---|
| B2B collaboration | ✅ |
| Multitenant applications | ✅ |
| Shared billing accounts | ❌ |

### Aggregations

Tenant Discovery surfaces **aggregated metrics**, not raw counts. Values are returned as **orders of magnitude**, not exact numbers.

Aggregations answer:

*How significant is this relationship at a high level?*

**Aggregation Behavior**

| Actual Value Range | Value Returned |
|---|---|
| 1-9 | 1 |
| 10-99 | 10 |
| 100-999 | 100 |
| 1,000-9,999 | 1,000 |
| 10,000-99,999 | 10,000 |

Recent metrics are only updated when activity crosses into a new order of magnitude.

**Example (B2B sign‑ins)**

- Initial detection: 50 users → returned value 10

- Later increases to 101 users → returned value 100 and timestamp updated

**Signal Applicability**

| Signal | Aggregations |
|---|---|
| B2B collaboration | ✅ |
| Multitenant applications | ✅ |
| Shared billing accounts | ✅ |

Billing is presence‑based rather than activity‑based.

### Signal-Metric Mapping Summary

| Metric Concept | B2B | Multitenant Apps | Billing |
|---|---|---|---|
| Initial vs recent | ✅ | ✅ | ❌ |
| Inbound vs outbound | ✅ | ✅ | ❌ |
| Aggregated counts | ✅ | ✅ | ✅ |
| Activity‑based | ✅ | ✅ | ❌ |
| Configuration‑based | ❌ | ❌ | ✅ |

Signals explain ***why*** tenants are related while metrics explain ***how*, *how much*, and *how recently*.** Both are intentionally non‑prescriptive. They inform investigation and prioritization without enforcing governance actions.

## Related content

- [What is Microsoft Entra B2B?](/entra/external-id/what-is-b2b)

- [Application model](/entra/identity-platform/application-model#multitenant-apps)

- [Manage billing across multiple tenants](/azure/cost-management-billing/manage/manage-billing-across-tenants)

