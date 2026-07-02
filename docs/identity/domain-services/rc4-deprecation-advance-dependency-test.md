---
title: RC4 deprecation advance dependency test in Microsoft Entra Domain Services | Microsoft Docs
description: Learn what the RC4 deprecation advance dependency test is, when it runs, and how to prepare for and recover from it in Microsoft Entra Domain Services.

ms.assetid: 9d1f2e7a-1c3b-4f6e-9b2a-7c8d5e4f1a23
ms.topic: how-to
ms.date: 07/01/2026
ai-usage: ai-assisted
---
# RC4 deprecation advance dependency test in Microsoft Entra Domain Services

Microsoft is deprecating RC4 encryption for Kerberos in Microsoft Entra Domain Services as part of the security hardening related to [CVE-2026-20833](https://www.cve.org/CVERecord?id=CVE-2026-20833). To assess customer readiness before RC4 is permanently disabled, the Domain Services team runs an *advance dependency test*: a controlled, time-limited disablement of RC4 encryption on managed domain controllers. The test surfaces active RC4 dependencies so you can remediate them before enforcement becomes permanent.

This article explains what the advance dependency test is, when it runs, and how to prepare for and recover from it.

## How the advance dependency test works

During the test, the team temporarily moves RC4 to enforcement mode (AES-only encryption) on the domain controllers in your region. If your workloads depend on RC4 for Kerberos authentication or LDAP binds, they might experience authentication failures after the test starts. **Starting the week of July 13, 2026, RC4 is permanently disabled across all regions.**

## Schedule

Tests start at 10:00 local time in each region, in three waves across the Americas, Europe, and Asia-Pacific and China. If your workloads are affected, you self-remediate by using the recovery steps later in this article.

### Wave 1 — Americas (Mon, Jul 6, 2026)

| PaaS region | Local timezone | Local start time | UTC start time |
|---|---|---|---|
| West Central US | MT (UTC-6) | 10:00 MDT | 16:00 UTC |
| West US | PT (UTC-7) | 10:00 PDT | 17:00 UTC |
| East US | ET (UTC-4) | 10:00 EDT | 14:00 UTC |
| US Gov Virginia | ET (UTC-4) | 10:00 EDT | 14:00 UTC |
| US Gov Arizona | MT (UTC-6) | 10:00 MDT | 16:00 UTC |
| US Nat East | ET (UTC-4) | 10:00 EDT | 14:00 UTC |
| US Nat West | PT (UTC-7) | 10:00 PDT | 17:00 UTC |
| US Sec East | ET (UTC-4) | 10:00 EDT | 14:00 UTC |
| US Sec West | PT (UTC-7) | 10:00 PDT | 17:00 UTC |

### Wave 2 — Europe (Tue, Jul 7, 2026)

| PaaS region | Local timezone | Local start time | UTC start time |
|---|---|---|---|
| West Europe (Netherlands) | CEST (UTC+2) | 10:00 CEST | 08:00 UTC |
| North Europe (Ireland) | IST (UTC+1) | 10:00 IST | 09:00 UTC |
| BLEU France Central (Paris) | CEST (UTC+2) | 10:00 CEST | 08:00 UTC |
| BLEU France South (Marseille) | CEST (UTC+2) | 10:00 CEST | 08:00 UTC |
| Delos Germany Central (Frankfurt) | CEST (UTC+2) | 10:00 CEST | 08:00 UTC |
| Delos Germany North (Berlin) | CEST (UTC+2) | 10:00 CEST | 08:00 UTC |

### Wave 3 — Asia-Pacific and China (Wed, Jul 8, 2026)

| PaaS region | Local timezone | Local start time | UTC start time |
|---|---|---|---|
| Southeast Asia (Singapore) | SGT (UTC+8) | 10:00 SGT | 02:00 UTC |
| Japan East (Tokyo) | JST (UTC+9) | 10:00 JST | 01:00 UTC |
| Japan West (Osaka) | JST (UTC+9) | 10:00 JST | 01:00 UTC |
| China North 2 (Beijing) | CST (UTC+8) | 10:00 CST | 02:00 UTC |
| China East 2 (Shanghai) | CST (UTC+8) | 10:00 CST | 02:00 UTC |

## Prepare for the test

Before the test window for your region, take the following steps:

1. Turn on security audits for the managed domain by following [Enable security and DNS audits for Microsoft Entra Domain Services](security-audit-events.md).
1. Use [Sample query 7](security-audit-events.md#sample-query-7) to identify Kerberos RC4 ticket issuance in your environment.
1. Migrate the affected workloads to AES encryption.

## Recover if you're impacted

If your workloads experience authentication failures during the test, members of the *AAD DC Administrators* group can immediately restore RC4 by using the [self-service RC4 configuration](troubleshoot-alerts.md#self-service-rc4-configuration) steps. Set `rc4DefaultDisablementPhase` to `1` (audit mode) and `defaultDomainSupportedEncTypes` to `60`. Changes apply within about 10 minutes.

File an Azure support request only if the self-service steps don't restore your workloads.

## Related content

- [AADDS123: Kerberos RC4 usage detected for service ticket issuance](troubleshoot-alerts.md#aadds123-kerberos-rc4-usage-detected-for-service-ticket-issuance)
- [Harden a Microsoft Entra Domain Services managed domain](secure-your-domain.md)
- [Enable security and DNS audits for Microsoft Entra Domain Services](security-audit-events.md)
