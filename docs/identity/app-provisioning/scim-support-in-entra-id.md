---
title: Undertand SCIM support in Microsoft Entra ID
description: Learn how Microsoft Entra ID supports the SCIM standard both as a provisioning client for SaaS applications and as a SCIM service provider through its SCIM APIs.
ms.topic: conceptual
ms.service: entra-id
author: cmmdesai
ms.author: jfields
ms.date: 03/23/2026
ms.reviewer: cmmdesai

---

# SCIM support in Microsoft Entra ID

Microsoft Entra ID supports the **System for Cross‑domain Identity Management (SCIM) 2.0** standard in multiple ways, depending on the provisioning scenario. Entra can act as:

- A **SCIM client**, provisioning users and groups from Entra into third‑party applications.
- A **SCIM service provider**, exposing SCIM APIs that allow external systems to provision users and groups directly into Entra.

This article provides an overview of SCIM support in Microsoft Entra ID and helps you understand which capabilities and documentation apply to your scenario.

---

## SCIM in Microsoft Entra ID at a glance

| Scenario | Role played by Entra | Typical use case |
|--------|---------------------|------------------|
| Provision users and groups to SaaS apps | SCIM client | Automatically create, update, and deprovision accounts in applications like ServiceNow, Zoom, or Dropbox |
| Provision users and groups into Entra | SCIM service provider | Synchronize users from HR systems, partner platforms, or custom identity pipelines into Microsoft Entra ID |

---

## Entra as a SCIM client (app provisioning)

Microsoft Entra ID includes a built‑in provisioning service that acts as a **SCIM client**. In this model, Microsoft Entra ID sends SCIM requests to applications that expose SCIM‑compliant endpoints.

### What you can do

When acting as a SCIM client, Microsoft Entra ID can:

- Provision and deprovision users in third‑party applications
- Keep user attributes synchronized over time
- Create and manage groups and group memberships
- Support both cloud and on‑premises applications that expose SCIM endpoints
- Apply conditional logic and transformations using attribute mappings

This capability is commonly used by IT administrators to automate access lifecycle management for SaaS applications without writing custom synchronization code.

### Where to learn more

- [Develop a SCIM endpoint for user provisioning](use-scim-to-provision-users-and-groups.md)
- [App specific provisioning tutorials](identity/saas-apps/tutorial-list.md)
- [Known SCIM 2.0 compliance issues](application-provisioning-config-problem-scim-compatibility.md)

---

## Entra as a SCIM service provider (SCIM APIs)

Microsoft Entra ID also acts as a **SCIM service provider** through its **SCIM 2.0 APIs**. In this model, external systems like HR systems can call SCIM API endpoints exposed by Microsoft Entra ID to manage identity data.

### What you can do

With Microsoft Entra ID SCIM APIs, you can:

- Create, read, update, and delete users in Entra
- Create and manage security groups and Microsoft 365 groups
- Manage group memberships
- Discover supported schemas, resource types, and service capabilities using standard SCIM endpoints
- Integrate using existing SCIM clients, connectors, and automation frameworks

This capability is designed for **standards‑based identity lifecycle automation**, particularly when customers or partners already use SCIM to integrate with applications like HR apps, middleware services and other identity and access platforms.

### Common scenarios

- Synchronizing users from an HR system into Microsoft Entra ID
- Migrating identities from another identity provider into Microsoft Entra ID
- Using a single SCIM‑based provisioning pipeline across multiple platforms
- Enabling partners to provision identities into customer Microsoft Entra ID tenants using an industry‑standard protocol

### Where to learn more

- [Configure Microsoft Entra SCIM 2.0 APIs](entra-id-scim-api-reference.md)
- [Microsoft Entra ID SCIM API endpoints](entra-id-scim-api-reference.md)
- [Microsoft Entra ID SCIM API schema](entra-id-scim-api-schema-documentation.md)

---

## Microsoft Graph vs. SCIM: when to use which

Microsoft Entra ID supports **both Microsoft Graph APIs and SCIM APIs** for managing users and groups. The right choice depends on your integration needs.

### Use Microsoft Graph when you need to:

- Access the full breadth of Microsoft identity, security, and Microsoft 365 capabilities
- Work with rich relationships and advanced identity features
- Build deeply integrated, Microsoft‑centric applications
- Use Microsoft‑specific concepts that go beyond lifecycle provisioning

### Use SCIM when you want to:

- Integrate using an **industry‑standard SCIM 2.0 protocol**
- Reuse existing SCIM clients, connectors, or provisioning frameworks
- Focus primarily on **user and group lifecycle management**
- Standardize identity provisioning across multiple platforms and identity providers

Many customers and partners use **both** approaches—SCIM for lifecycle synchronization and Microsoft Graph for richer Microsoft‑specific capabilities—depending on the scenario.

---

## Summary

Microsoft Entra ID provides flexible, standards‑based identity provisioning by supporting SCIM in two complementary roles:

- As a **SCIM client**, enabling provisioning from Microsoft Entra ID to business applications.
- As a **SCIM service provider**, enabling provisioning from business applications to Microsoft Entra ID through SCIM APIs.

Together with Microsoft Graph, these capabilities give customers and partners the choice to integrate with Entra using the model that best fits their architecture, tooling, and long‑term identity strategy.
