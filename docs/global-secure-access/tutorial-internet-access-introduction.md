---
title: 'Tutorial: Get Started with Microsoft Entra Internet Access Labs'
description: Learn about Microsoft Entra Internet Access labs covering web filtering, TLS inspection, and threat intelligence.
ms.topic: tutorial
ms.date: 03/07/2026
ms.subservice: entra-internet-access
ms.reviewer: jebley
ai-usage: ai-assisted
ms.custom: sfi-image-nochange
---

# Tutorial: Get started with Microsoft Entra Internet Access labs

This learning lab series provides hands-on experience with Microsoft Entra Internet Access, a cloud-delivered secure web gateway and AI gateway.

In this tutorial, you learn how to:
> [!div class="checklist"]
> - Recognize what Internet Access is and understand how it works.
> - Review security service edge (SSE) concepts and capabilities.
> - Navigate the learning progression for the lab series.

## What is Microsoft Entra Internet Access?

Internet Access is part of the Microsoft SSE solution. It works by routing internet traffic through the Microsoft globally distributed cloud proxies, where security policies are applied before traffic reaches its destination.

As a secure web gateway, it protects users and devices from internet threats while enabling secure, identity-aware access to web resources. As an AI Gateway, it gives admins visibility into shadow AI apps, protects your organization's data behind your company AI tools, and helps prevent data leakage to unauthorized AI sites.

This approach provides:

- **Identity-aware security**: Policies can be targeted based on user identity, group membership, and device state.
- **Cloud-native protection**: No on-premises infrastructure to maintain.
- **Zero Trust alignment**: Every request is evaluated against your security policies.

## How to run the lab exercises

This series of exercises covers the fundamentals of Internet Access. The exercises assume that you follow them in order. If you skip around, you might miss a step. For example, in the baseline web-filtering tutorial, you create a security profile and assign it to a Microsoft Entra Conditional Access policy. Subsequent labs instruct you to assign the new policy to this existing security profile rather than creating a new security profile and Conditional Access policy each time.

## Learning progression

Each lab builds on the previous one and follows a logical progression.

| Exercise | What you learn |
|----------|----------------|
| [Enable Internet Access](tutorial-internet-access-enable-traffic-forwarding.md) | How traffic forwarding works and how to route internet traffic through Global Secure Access. |
| [Configure web content filtering](tutorial-internet-access-web-content-filtering.md) | How to create policies that apply to all users and understand policy evaluation. |
| [Transport Layer Security (TLS) inspection](tutorial-internet-access-tls-inspection.md) | Why encrypted traffic inspection is essential for modern security. |
| [URL filtering](tutorial-internet-access-url-filtering.md) | What the difference is between FQDN and URL filtering, and how TLS inspection enables deeper inspection. |
| [Threat intelligence](tutorial-internet-access-threat-intelligence.md) | How the Microsoft threat feeds protect against known malicious sites. |
| [Application discovery](tutorial-internet-access-application-discovery.md) | How to identify shadow IT and manage application risk. |
| [Content policies](tutorial-internet-access-content-policies.md) | How to prevent data exfiltration through network content filtering and file upload controls. |

## Next step

> [!div class="nextstepaction"]
> [Enable Internet Access traffic forwarding](tutorial-internet-access-enable-traffic-forwarding.md)
