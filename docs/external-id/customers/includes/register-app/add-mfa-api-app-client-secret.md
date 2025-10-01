---
author: kengaderdus
ms.service: entra-external-id
ms.subservice: external
ms.topic: include
ms.date: 05/05/2023
ms.author: kengaderdus
ms.manager: dougeby
---

Create a client secret for the registered application. The application uses the client secret to prove its identity when it requests for tokens.

1. From the **App registrations** page, select the application that you created (such as *edit-profile-service*) to open its **Overview** page.
1. Under **Manage**, select **Certificates & secrets**.
1. Select **New client secret**.
1. In the **Description** box, enter a description for the client secret (for example, *edit-profile-service client secret*).
1. Under **Expires**, select a duration for which the secret is valid (per your organizations security rules), and then select **Add**.
1. Record the secret's **Value**. You'll use this value for configuration in a later step. The secret value won't be displayed again, and isn't retrievable by any means, after you navigate away from the **Certificates and secrets**. Make sure you record it.