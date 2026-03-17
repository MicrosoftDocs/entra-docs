---
title: Interpret tenant discovery data (preview)
description: Learn how to interpret discovery data and signals in Microsoft Entra Tenant Governance.
author: barclayn
ms.author: barclayn
ms.service: entra-id-governance
ms.topic: how-to
ms.date: 03/05/2026
---

# Interpret tenant discovery data (preview)

[!INCLUDE [entra-tenant-governance-preview-note](~/includes/entra-tenant-governance-preview-note.md)]

This article helps administrators and security teams analyze related tenants discovered through Microsoft Entra Tenant Governance. It explains how to interpret related tenant signals and metrics to decide when to:

- **Seek governance**: Bring a tenant under management by establishing a governance relationship.
- **Quarantine a tenant**: Restrict interaction with an unsanctioned or risky tenant.
- **Acknowledge and ignore**: Document the tenant as a known, acceptable partner.

Related tenants is the starting point for tenant discovery and assessment.

## Background: What the related tenants feature represents

Related tenants provides situational awareness, not ownership or enforcement. A related tenant is surfaced because Microsoft Entra observed evidence of interaction across identity, application, or billing systems. These interactions can include:

- External partner or customer tenants
- Internally created or shadow-IT tenants
- Development, test, or experimentation tenants

Being "related" doesn't imply trust, risk, or administrative control by itself. Instead, it answers:

*"Which other Microsoft Entra tenants interact with mine, and what activity establishes those connections?"*

## Step 1: Review the related tenants inventory

After you enable tenant discovery, view a list of all discovered related tenants through the admin center or APIs. Each related tenant includes aggregated metrics that describe the nature and volume of interaction.

Key things to look for initially:

- **How many related tenants exist**
- **Which signals caused discovery**
- **Whether the tenant appears active or historical**

This step establishes scope, not judgment.

## Step 2: Understand the signals behind the relationship

Related tenants are inferred from multiple observable signals. Discovery signal categories include:

- **B2B collaboration activity**
  - B2B registration
  - B2B sign-ins
  - B2B administrative sign-ins
- **Multitenant applications**
- **Billing or commerce relationships**

A tenant related through multiple signals might be more connected to your tenant than one with a single signal. However, certain signals could matter more for organizational ties, such as a shared billing account. After you identify which signals are most important for your organization, filter the related tenants list to focus on those signals first.

## Step 3: Analyze metrics trends (initial vs. recent)

Each signal category includes initial and recent metrics. This distinction is critical for governance decisions. Metrics can include:

- Number of inbound vs. outbound users
- Number of applications involved
- Monthly activity levels
- Last update timestamps

You can sort metrics from increasing to decreasing use. Use these comparisons to answer:

- Is the relationship **ongoing or dormant**?
- Is activity **growing, stable, or declining**?
- Is interaction **one-sided or mutual**?

A tenant with recent, increasing activity typically warrants closer scrutiny than one with only historical, initial signals. For example, a tenant with active B2B guest users, active administrative sign-ins, and a shared billing account represents a stronger operational relationship. Compare this to a tenant surfaced only through historical B2B guest user presence captured at the time of discovery.

## Step 4: Classify the related tenant

Based on signals and metrics, classify each related tenant into one of three practical categories.

### Known and acceptable: Acknowledge and ignore

**Characteristics:**

- Clearly identifiable partner, vendor, or customer (naming, domains, users)
- Expected B2B or application activity
- Activity levels align with business context

**Recommended action:**

- Document the tenant as a known relationship.
- No immediate governance or quarantine action required.

This classification helps reduce noise and focus attention elsewhere.

### Requires governance review

**Characteristics:**

- Internal-looking tenant (naming, domains, users)
- Moderate or growing activity
- Unclear ownership or purpose

**Recommended action:**

- Investigate ownership (business unit, team, or developer).
- Evaluate whether IT should manage the tenant.
- Consider establishing a [governance relationship](how-to-setup-governance-relationship.md).

This approach aligns with the goal of bringing unsanctioned but legitimate tenants under governance, rather than blocking them.

### Potentially risky or unsanctioned: Quarantine candidate

**Characteristics:**

- Unknown or untrusted tenant
- Unexpected sign-in or application activity
- No clear business justification
- Signals suggest access paths into your tenant

**Recommended action:**

- Use related tenants data as input to your risk assessment.
- If you confirm the risk, consider quarantining the tenant. For more information, see [Quarantine unsanctioned tenants](/entra/fundamentals/quarantine-unsanctioned-tenants).

Base the quarantine decision on related tenant signals, not on isolated analysis.

## Next steps

- [Related tenants in Tenant Governance](related-tenants.md)
- [Signals and metrics for tenant discovery](signals-metrics.md)
- [Enable tenant discovery](how-to-enable-tenant-discovery.md)
- [Set up a governance relationship](how-to-setup-governance-relationship.md)
