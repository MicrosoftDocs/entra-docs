---
title: Microsoft Entra Global Secure Access operations guide
description: "Overview and navigation for the post-deployment operations guide suite for Microsoft Entra Global Secure Access."
ms.topic: overview
ms.date: 05/04/2026
ms.reviewer: jricketts
ai-usage: ai-assisted
---

# Microsoft Entra Global Secure Access operations guide

This operations guide suite provides prescriptive, post-deployment procedures for running Microsoft Entra Global Secure Access in an enterprise environment. The guides cover day-to-day alerting, health checks, integration, automation, and metrics—focusing on operational tasks that keep the service reliable, secure, and performant.

## Who this guide is for

- **IT administrators and network security engineers** responsible for Global Secure Access configuration and maintenance
- **Platform operations and monitoring engineers** who manage health checks, automation, and dashboards
- **Security leadership** reviewing operational metrics and service value

This guide assumes Global Secure Access is already deployed and configured. For deployment and initial setup, see the [Global Secure Access deployment guide](/entra/architecture/gsa-deployment-guide-intro). For broader identity-layer security investigations and incident response, see the [Microsoft Entra Security Operations Guide](https://aka.ms/AzureADSecOps).

## Overview

The operational practices in these guides align with the Information Technology Infrastructure Library (ITIL) service management processes and the National Institute of Standards and Technology (NIST) Cybersecurity Framework. Rather than teaching these frameworks, the guides apply their principles directly: alert-first monitoring (NIST Detect), structured change management (ITIL), configuration backup and failover testing (NIST Recover), and continuous improvement through metrics-driven reviews.

The guide suite groups content by Global Secure Access capability, plus a shared common guide for cross-cutting topics.

### Shared operations

| Guide | What it covers |
| --- | --- |
| [Common operations](how-to-operations-common.md) | RACI matrix (responsible, accountable, consulted, informed) for roles and responsibilities, change management process, metrics and reporting framework, continuous improvement |

### Capability-specific operations

Each capability guide follows a consistent structure: Alerting and monitoring, Maintenance and health checks, Integration and automation, Operational metrics, and Troubleshooting quick reference.

| Guide | What it covers |
| --- | --- |
| [Private Access operations](how-to-operate-private-access.md) | Connector health, application segment management, ZTNA-specific alerting, Graph API automation for connector and app management |
| [Internet Access operations](how-to-operate-internet-access.md) | Web filtering policy management, Transport Layer Security (TLS) inspection, URL categorization, threat blocking metrics |
| [Remote Networks operations](how-to-operate-remote-networks.md) | GRE/IPsec tunnel monitoring, branch site capacity management, customer-premises equipment (CPE) device health, tunnel failover testing |
| [Microsoft Traffic operations](how-to-operate-microsoft-traffic.md) | Microsoft 365 traffic profile management, compliant network enforcement, Microsoft 365 endpoint coverage, service performance monitoring |

### Templates and checklists

| Template | Purpose |
| --- | --- |
| [Daily health check](reference-daily-health-check.md) | Consolidated daily checklist covering all Global Secure Access capabilities |
| [Private Access health check](reference-private-access-health-check.md) | Capability-specific checklist for Private Access connectors and application segments |
| [Change request template](reference-change-request-template.md) | Structured template for Global Secure Access configuration change requests |
| [Communication plan template](reference-communication-plan.md) | Template for communicating planned changes to stakeholders |

## Getting started with operations

If you completed deployment, follow this sequence:

1. **Establish your team**—Assign roles using the [RACI matrix](how-to-operations-common.md#raci-matrix). Ensure at least two people cover each role.
2. **Configure alerting**—Set up the critical alerts listed in each capability guide: [Private Access](how-to-operate-private-access.md#alerting-and-monitoring), [Internet Access](how-to-operate-internet-access.md#alerting-and-monitoring), [Remote Networks](how-to-operate-remote-networks.md#alerting-and-monitoring), and [Microsoft Traffic](how-to-operate-microsoft-traffic.md#alerting-and-monitoring). Don't rely on dashboards for issue detection.
3. **Establish baselines**—Collect a 30-day performance baseline for traffic volume, latency, and usage. Calibrate alert thresholds against this baseline. Each capability guide includes Kusto Query Language (KQL) queries for baseline establishment.
4. **Set up automation**—Start with configuration backups and alert notifications. Expand to the full automation playbook list over time.
5. **Schedule recurring checks**—Implement the daily, weekly, and monthly checklists from each capability guide.
6. **Begin reporting**—Start with weekly operational team reports. Add monthly management reports after the first month.

## Related content

- [Global Secure Access documentation](/entra/global-secure-access/)
- [Global Secure Access deployment guide](/entra/architecture/gsa-deployment-guide-intro)
- [Microsoft Entra Security Operations Guide](https://aka.ms/AzureADSecOps)
- [Microsoft Entra what's new](/entra/fundamentals/whats-new)
