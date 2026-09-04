---
title: Configure TLS inspection with a Microsoft-managed certificate
description: Learn how to create, deploy, and use a Microsoft-managed certificate for Transport Layer Security inspection.
ms.topic: how-to
ms.reviewer: teresayao
ms.date: 08/28/2026
ai-usage: ai-assisted

#customer intent: As a Global Secure Access administrator, I want Microsoft to manage the certificate authority that supports TLS inspection for my organization.
---

# Configure TLS inspection with a Microsoft-managed certificate (preview)

Transport Layer Security (TLS) inspection in Microsoft Entra Internet Access requires a certificate authority (CA) that client devices trust. With a Microsoft-managed certificate, Microsoft generates and operates a tenant-specific root CA for your organization. You don't need to provide your own public key infrastructure (PKI) or CA for TLS inspection.

> [!NOTE]
> Microsoft-managed certificates for TLS inspection are currently in preview. This information relates to a prerelease product that might be substantially modified before release. Microsoft makes no warranties, expressed or implied, with respect to the information provided here. For more information, see the [Microsoft Entra preview terms](https://azure.microsoft.com/support/legal/preview-supplemental-terms/).

This article explains how to create a Microsoft-managed certificate, deploy the root CA certificate to client devices, and enable the certificate for TLS inspection. The private key is protected in Microsoft's secure key infrastructure and isn't exposed.

If your organization must use its own PKI, see [Configure TLS inspection with your own certificate](how-to-transport-layer-security-settings.md).

## Prerequisites

To complete the steps in this article, you need:

- A trial license for Microsoft Entra Internet Access.
- [Global Secure Access prerequisites](how-to-configure-web-content-filtering.md).
- The [Global Secure Access Administrator](../identity/role-based-access-control/permissions-reference.md#global-secure-access-administrator) role.

## Create a Microsoft-managed certificate

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/) as a Global Secure Access Administrator.
1. Browse to **Global Secure Access** > **Secure** > **TLS inspection policies**.
1. Select the **TLS inspection settings** tab.
1. Select **Create certificate**, and then select **Microsoft-managed**.

    :::image type="content" source="media/how-to-transport-layer-security-settings-managed-certificate/create-microsoft-managed-certificate-menu.png" alt-text="Screenshot that shows the Microsoft-managed option on the Create certificate menu." lightbox="media/how-to-transport-layer-security-settings-managed-certificate/create-microsoft-managed-certificate-menu.png":::

1. In the **Create Microsoft-managed certificate** pane, review the certificate details and lifecycle. Microsoft automatically configures the tenant-specific certificate authority. No certificate information is required.

    :::image type="content" source="media/how-to-transport-layer-security-settings-managed-certificate/create-microsoft-managed-certificate-pane.png" alt-text="Screenshot that shows the details and lifecycle of a Microsoft-managed certificate." lightbox="media/how-to-transport-layer-security-settings-managed-certificate/create-microsoft-managed-certificate-pane.png":::

   > [!NOTE]
   > The default root CA validity period is 10 years. You can use the API to configure a shorter validity period if your organization requires one.

1. Select **Create**.
1. Confirm that the certificate appears in the list with **Managed** in the **Type** column and **Disabled** in the **Status** column.

## Download and deploy the root CA certificate

Client devices must trust the managed root CA before you enable TLS inspection. If you apply a TLS inspection policy before distributing the root CA certificate, users can encounter certificate errors.

1. On the **TLS inspection settings** tab, find the managed certificate.
1. Select the actions menu (**...**), and then select **Download root certificate**.

    :::image type="content" source="media/how-to-transport-layer-security-settings-managed-certificate/download-root-certificate.png" alt-text="Screenshot that shows the Download root certificate action for a Microsoft-managed certificate." lightbox="media/how-to-transport-layer-security-settings-managed-certificate/download-root-certificate.png":::

1. Save the `.cer` file.
1. Use your MDM solution to deploy the root CA certificate to client devices. For Microsoft Intune, see [Trusted root certificate profiles for Microsoft Intune](/intune/intune-service/protect/certificates-trusted-root).
1. On a test device, confirm that the certificate is installed in the **Trusted Root Certification Authorities** store.

The downloaded file contains the public root CA certificate. It doesn't contain the private key.

## Enable the managed certificate

After you deploy the root CA certificate to your client devices:

1. On the **TLS inspection settings** tab, find the managed certificate.
1. Select the actions menu (**...**), and then select **Enable**.
1. Confirm that the certificate status changes to **Active**.

You can now [create and assign a TLS inspection policy](how-to-transport-layer-security.md).

## Manage the certificate

Use the actions menu (**...**) on the **TLS inspection settings** tab to manage a Microsoft-managed certificate:

- **Disable**: Temporarily stop using the certificate for TLS inspection.
- **Enable**: Enable a disabled certificate.
- **Delete**: Remove a certificate that you no longer need.

### Rotate a Microsoft-managed certificate

Rotate a certificate before it expires:

1. Create a new Microsoft-managed certificate.
1. Download the new root CA certificate.
1. Deploy the new root CA certificate to client devices.
1. Enable the new certificate.
1. Validate TLS inspection with the new certificate.
1. After validation succeeds, delete the old disabled certificate.

Don't remove the old root CA certificate from client devices until you validate the new certificate and complete the transition.

## Related content

- [Configure TLS inspection with your own certificate](how-to-transport-layer-security-settings.md)
- [Configure Transport Layer Security inspection policies](how-to-transport-layer-security.md)
- [What is Transport Layer Security inspection?](concept-transport-layer-security.md)
- [Transport Layer Security inspection frequently asked questions](faq-transport-layer-security.yml)
- [Troubleshoot Transport Layer Security inspection issues](troubleshoot-transport-layer-security.md)
