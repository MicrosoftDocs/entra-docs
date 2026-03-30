---
title: Disable the SCIM Provisioning API in Microsoft Entra ID
description: Learn how to disable the SCIM Provisioning API feature in the Microsoft Entra admin center to stop all API access and billing.
author: jenniferf-skc
manager: pmwongera
ms.service: entra-id
ms.subservice: app-provisioning
ms.topic: how-to
ms.date: 03/30/2026
ms.author: jfields
ms.reviewer: chmutali
ai-usage: ai-assisted

#customer intent: As an IT administrator, I want to disable the SCIM Provisioning API in Microsoft Entra ID so that I can stop all programmatic SCIM access and billing.
---

# Disable the SCIM Provisioning API

If you no longer need programmatic SCIM access, you can turn off the SCIM Provisioning API to stop all API access and billing.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).

1. In the left navigation, expand **ID Governance** and select **Dashboard**.

1. On the Dashboard page, locate the **SCIM Provisioning API** tile and select **Edit**.

1. In the **SCIM Provisioning API** pane, select **Turn off**.

1. Confirm the action when prompted. After the feature is turned off, all SCIM API calls to the tenant return an error and billing stops.

## Next steps

- [Enable the SCIM Provisioning API](enable-scim-api.md) – Learn how to enable the SCIM Provisioning API and set up credentials.
- [Microsoft Entra ID SCIM API reference](entra-id-scim-api-reference.md) – Learn about the supported SCIM API endpoints, request formats, and constraints.
