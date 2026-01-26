---
title: Understand why a service principal was created in your tenant
description: Learn why a Microsoft Entra service principal was created in your tenant and who or what triggered the event through new properties that have been added audit log activity. 

author: jenniferf-skc
manager: pmwongera
ms.service: entra-id
ms.topic: reference
ms.subservice: monitoring-health
ms.date: 01/26/2026
ms.author: jfields
ms.reviewer: arishorr1
ai-usage: ai-assisted

#Customer intent: As an IT admin or security analyst, I want to understand the new audit log properties for service principal creation events so that I can quickly identify why a service principal was created, who or what triggered it, and reduce my dependency on additional API calls during investigations.
---

# Understand why a service principal was created in your tenant

Microsoft Entra audit logs capture changes to applications, groups, users, and other directory resources. To help you understand why a Microsoft Entra service principal was created in your tenant and who or what triggered the event, new properties are being added to the **Add service principal** activity under the **ApplicationManagement** category. This article explains what is changing in the audit logs, how to find the new data, and how to interpret the different property values.

## What you can do with these audit log improvements

- Quickly identify whether a newly created service principal was provisioned by Microsoft, by a subscription you purchased, or by direct user or app actions.
- See which Microsoft 365 or other SKUs in your tenant made a Microsoft service principal eligible for just-in-time provisioning.
- Distinguish between different provisioning mechanisms, such as commerce-based just-in-time (JIT) provisioning, default eligibility, manager applications, Azure resource providers, and managed identities.
- Reduce dependency on additional Microsoft Graph calls and custom data pipelines when investigating why a service principal was created.

## Prerequisites

To view and use these properties in Microsoft Entra audit logs, you need:

- Access to the [Microsoft Entra admin center](https://entra.microsoft.com).
- One of the following roles (or a role with equivalent permissions): [Security administrator](../role-based-access-control/permissions-reference.md#security-administrator), [Security reader](../role-based-access-control/permissions-reference.md#security-reader), or [Reports reader](../role-based-access-control/permissions-reference.md#reports-reader).
- Audit logging enabled for your tenant. For more information, see the [Microsoft Entra audit logs overview](concept-audit-logs.md).

>[!NOTE]
> Yuo can also view these new logs with Microsoft Graph API or in the Log Analytics AuditLogs table.

## Where the new properties appear in audit logs

The new properties are emitted for service principal creation events that appear in Microsoft Entra audit logs with the following characteristics:

- **Service:** Core Directory
- **Category:** ApplicationManagement
- **Activity (activityDisplayName):** Add service principal

In the [Microsoft Entra admin center](https://entra.microsoft.com), you can find these events under **Monitoring & health** > **Audit logs**. When you select an **Add service principal** event, the new properties appear in the **Additional details** section and in the corresponding JSON if you export or query the logs.

:::image type="content" source="media/understand-service-principal-creation-with-new-audit-log-properties/audit-logs-categories.png" alt-text="Screenshot of the Microsoft Entra admin center showing the category drop-down to Application Management." lightbox="media/understand-service-principal-creation-with-new-audit-log-properties/audit-logs-categories.png":::

:::image type="content" source="media/understand-service-principal-creation-with-new-audit-log-properties/audit-logs-activity-add-service-principal.png" alt-text="Screenshot of the Activity drop-down leading to add a service principal." lightbox="media/understand-service-principal-creation-with-new-audit-log-properties/audit-logs-activity-add-service-principal.png":::

## New audit log properties for service principal creation

The following new properties help you understand service principal creation events:

- **ServicePrincipalProvisioningType**—describes how and why the service principal became eligible to be created, and what provisioning mechanism was used.
- **SubscribedSkus**—lists the tenant subscriptions and service plans that made a Microsoft service principal eligible for commerce-based just-in-time provisioning.
- **AppOwnerOrganizationId**—identifies the home tenant of the app registration that owns the service principal.

### ServicePrincipalProvisioningType

`ServicePrincipalProvisioningType` is an enum value that tells you the provisioning path used for the Add service principal event. In other words, it answers the question, "Why was this service principal created, and which system or actor initiated it?" This field is logged for both Microsoft first-party and third-party apps.

| Value | What it means |
|-------|---------------|
| `defaultMicrosoft` | The service principal was created by Microsoft as part of a default eligibility or system-managed process. This includes default just-in-time (JIT) provisioning or other managed provisioning for Microsoft first-party apps. |
| `subscription` | The service principal was created because your tenant has an eligible subscription (SKU) or included service plan. This is commerce-based JIT provisioning for Microsoft first-party apps. Use the **SubscribedSkus** field to see which SKUs or service plans made it eligible. |
| `managerApplications` | A Microsoft-managed "manager" application, with permission to manage other service principals, created this service principal. The manager app identity is available in existing audit log fields such as initiatedBy.app. |
| `AzureResourceProvider` | An Azure resource provider created the service principal as part of onboarding an Azure service (for example, Azure Data Explorer). This typically represents infrastructure-driven provisioning. |
| `ManagedServiceIdentity` | The service principal represents a managed identity (system-assigned or user-assigned). This value appears when a managed identity is created for an Azure resource. |
| `Other` | Reserved for provisioning mechanisms that don't fall into the categories above, including delegated and app-only flows. **Delegated:** A user action, or an app acting with delegated permissions on behalf of a user, directly triggered service principal creation (for example, calling POST /servicePrincipals via Microsoft Graph or a portal UX that provisions an app). **AppOnly:** An application using app-only permissions directly called into Microsoft Graph or the directory to create the service principal (for example, automation or a custom provisioning service). |

> [!NOTE]
> You can use other audit log event properties to differentiate between these flows.

You can use `ServicePrincipalProvisioningType` to separate Microsoft-driven provisioning (for example, `defaultMicrosoft`, `subscription`, `AzureResourceProvider`, `managerApplications`) from tenant-driven provisioning (for example, Other). Separating Microsoft-driven provisioning from tenant-driven provisioning helps you quickly decide whether a new service principal resulted from a Microsoft platform process or from admins, users, or custom apps in your tenant. See [View service principal details in audit log properties](howto-view-service-principal-creation-with-audit-log-properties.md) for more information on creating detections for new service principals in your tenant.

### SubscribedSkus

`SubscribedSkus` is a JSON array that links a Microsoft service principal created with `ServicePrincipalProvisioningType = subscription` back to the subscriptions and service plans in your tenant that made it eligible for commerce-based, just-in-time provisioning.

Because a single service principal can be associated with multiple service plans, and each service plan can belong to multiple SKUs, SubscribedSkus gives you a concise list of the SKUs and plans in your tenant that could have led to provisioning eligibility. This is intended as a starting point for your investigation.

| Key | What it represents |
|-----|--------------------|
| `SkuId` | The GUID of a subscription (SKU) in your tenant. You can use this ID with Microsoft Graph /subscribedSkus to retrieve full details. |
| `SkuName` or `SkuPartNumber` | A human-readable name or part number for the SKU, such as Microsoft 365 E5 or SPE_E5. |
| `ServicePlanId` | The GUID of a service plan inside a SKU, such as a specific SharePoint or e-signature plan. |
| `ServicePlanName` | The internal name of the service plan (for example, `SHAREPOINTENTERPRISE`). |
| `ServicePlanServiceType` | The Microsoft service the plan belongs to (for example, `SharePoint`). |
| `Association` | Describes how the plan relates to the service principal, such as `include` for an app that is included in a larger plan. |

For example, if `SubscribedSkus` shows a service plan named `SHAREPOINTENTERPRISE` with an associated `SPE_E5` SKU, you can infer that a Microsoft 365 E5 subscription in your tenant made this Microsoft service principal eligible for provisioning. You can then use Microsoft Graph to query the `/subscribedSkus` resource and confirm which subscription and service plans are active.

:::image type="content" source="media/understand-service-principal-creation-with-new-audit-log-properties/service-principal-additional-details.png" alt-text="Screenshot of code showing the SubscribedSkus JSON array structure with SKU and service plan properties." lightbox="media/understand-service-principal-creation-with-new-audit-log-properties/service-principal-additional-details.png":::

### AppOwnerOrganizationId

`AppOwnerOrganizationId` logs the home tenant ID of the application that owns the service principal. This value is written in the Additional details section as a key/value pair such as `"AppOwnerOrganizationId" : "<tenantId>"`.

You can use this value to distinguish between:

- **Apps registered in your own tenant**—the value matches your tenant ID.
- **Microsoft-owned apps**—the value matches a Microsoft services tenant ID (f8cdef31-a31e-4b4a-93e4-5f571e91255a).
- **Other external or partner apps**—the value matches a different external tenant.

This reduces the need to call Microsoft Graph separately to retrieve `appOwnerOrganizationId` for every new service principal creation event.

## Next steps
[View service principal details in audit log properties](howto-view-service-principal-creation-with-audit-log-properties.md)

