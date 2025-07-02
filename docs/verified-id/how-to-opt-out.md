---
title: Opt out of Microsoft Entra Verified ID
description: Learn how to opt out of Microsoft Entra Verified ID.
documentationCenter: ''
author: barclayn
manager: femila
ms.service: entra-verified-id
ms.topic: how-to
ms.date: 01/21/2025
ms.author: barclayn
ms.custom: sfi-image-nochange
#Customer intent: As an administrator, I'm looking for information to help me disable my Microsoft Entra Verified ID environment.
---

# Opt out of Microsoft Entra Verified ID

Opting out is the process of resetting your Microsoft Entra Verified ID environment.

## When do you need to opt out?

Opting out is a one-way operation. After the process finishes, your Microsoft Entra Verified ID environment is reset. Opting out might be required to:

- Enable new service capabilities.
- Reset your service configuration.
- Switch between trust systems ION and web.

## What happens to your data?

When you finish opting out of the Microsoft Entra Verified ID service, the following actions occur:

- The decentralized identifier (DID) keys in Azure Key Vault are [soft deleted](/azure/key-vault/general/soft-delete-overview).
- The issuer object is deleted from our database.
- The tenant identifier is deleted from our database.
- All the verifiable credentials contracts are deleted from our database.

After an opt-out action takes place, you can't recover your DID or conduct any operations on your DID. This step is a one-way operation, and you need to onboard again. Onboarding again results in the creation of a new environment.

## Effect on existing verifiable credentials

All verifiable credentials already issued continue to exist. For the ION trust system, they aren't cryptographically invalidated because your DIDs remain resolvable through ION. However, when relying parties call the status API, they always receive a failure message.

## Opt out from Microsoft Entra Verified ID

1. From the **Azure portal**, search for verifiable credentials.
1. Select **Organization Settings** on the leftmost menu.
1. In the section **Reset your organization**, select **Delete all credentials and reset service**.

    :::image type="content" source="media/how-to-opt-out/settings-reset.png" alt-text="Screenshot that shows the section on the Organization settings page where you reset your organization.":::

1. Read the warning message and select **Delete & opt out** to continue.

    :::image type="content" source="media/how-to-opt-out/delete-and-opt-out.png" alt-text="Screenshot that shows Delete & opt out.":::

## Next steps

- Set up verifiable credentials on your [Azure tenant](verifiable-credentials-configure-tenant.md).
