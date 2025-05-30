---
title: Microsoft Entra Connect Health instructions data retrieval
description: This page describes how to retrieve data from Microsoft Entra Connect Health.
author: billmath
manager: femila
ms.service: entra-id
ms.subservice: hybrid-connect
ms.tgt_pltfrm: na
ms.topic: how-to
ms.date: 04/09/2025
ms.author: billmath
ms.custom: sfi-image-nochange
---


# Microsoft Entra Connect Health instructions for data retrieval

This document describes how to use Microsoft Entra Connect to retrieve data from Microsoft Entra Connect Health.

[!INCLUDE [active-directory-app-provisioning.md](~/includes/azure-docs-pr/gdpr-intro-sentence.md)]

## Retrieve all email addresses for users configured for health alerts.

To retrieve the email addresses for all of your users that are configured in Microsoft Entra Connect Health to receive alerts, use the following steps.

1. Start at the Microsoft Entra Connect Health blade and select **Sync Services** from the left-hand navigation bar.
 ![Sync Services](./media/how-to-connect-health-data-retrieval/retrieve1.png)

2. Select on the **Alerts** tile.</br>
 ![Alert](./media/how-to-connect-health-data-retrieval/retrieve3.png)

3. Select on **Notification Settings**.
 ![Notification](./media/how-to-connect-health-data-retrieval/retrieve4.png)

4. On the **Notification Setting** blade, find the list of email addresses that are enabled as recipients for health Alert notifications.
 ![Emails](./media/how-to-connect-health-data-retrieval/retrieve5a.png)
 
## Retrieve all sync errors

To retrieve a list of all sync errors, use the following steps.

1. Starting on the Microsoft Entra Health blade, select **Sync Errors**.
 ![Sync errors](./media/how-to-connect-health-data-retrieval/retrieve6.png)

2. In the **Sync Errors** blade, select on **Export**. This exports a list of the recorded sync errors.
 ![Export](./media/how-to-connect-health-data-retrieval/retrieve7.png)

## Next Steps
* [Microsoft Entra Connect Health](./whatis-azure-ad-connect.md)
* [Microsoft Entra Connect Health Agent Installation](how-to-connect-health-agent-install.md)
* [Microsoft Entra Connect Health Operations](how-to-connect-health-operations.md)
* [Microsoft Entra Connect Health FAQ](reference-connect-health-faq.yml)
* [Microsoft Entra Connect Health Version History](reference-connect-health-version-history.md)
