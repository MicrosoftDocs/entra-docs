---
title: Microsoft Entra Connect Health instructions data retrieval
description: This page describes how to retrieve data from Microsoft Entra Connect Health.
ms.subservice: hybrid-connect
ms.tgt_pltfrm: na
ms.topic: how-to
ms.date: 09/10/2026
---


# Microsoft Entra Connect Health instructions for data retrieval

This document describes how to use Microsoft Entra Connect to retrieve data from Microsoft Entra Connect Health.

[!INCLUDE [active-directory-app-provisioning.md](~/includes/azure-docs-pr/gdpr-intro-sentence.md)]

## Retrieve email addresses configured for health alerts

To retrieve the email addresses for all of your users that are configured in Microsoft Entra Connect Health to receive alerts, use the following steps.

1. Open [Microsoft Entra Connect Health](https://aka.ms/aadconnecthealth).
2. Select **Sync errors**.
3. Select **Notification settings** on the command bar.
4. In the notification settings panel, review whether Global Administrators receive notifications and the addresses listed under the custom email recipients section.
 
:::image type="content" source="media/how-to-connect-health-data-retrieval/connect-health-notification-settings.png" alt-text="Screenshot of the Connect Health notification settings panel with callouts for enabling email, choosing recipients, and saving changes." lightbox="media/how-to-connect-health-data-retrieval/connect-health-notification-settings.png":::

## Retrieve all sync errors

To retrieve a list of all sync errors, use the following steps.

1. Open [Microsoft Entra Connect Health](https://aka.ms/aadconnecthealth), and then select **Sync errors**.
2. Select **Export** on the command bar. The browser downloads a CSV file that contains the recorded sync errors.

## Next Steps
* [Microsoft Entra Connect Health](./whatis-azure-ad-connect.md)
* [Microsoft Entra Connect Health Agent Installation](how-to-connect-health-agent-install.md)
* [Microsoft Entra Connect Health Operations](how-to-connect-health-operations.md)
* [Microsoft Entra Connect Health FAQ](reference-connect-health-faq.yml)
* [Microsoft Entra Connect Health Version History](reference-connect-health-version-history.md)
