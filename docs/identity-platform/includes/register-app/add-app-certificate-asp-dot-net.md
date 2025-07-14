---
author: cilwerner
manager: CelesteDG
ms.author: cwerner
ms.date: 11/06/2024
ms.reviewer:
ms.service: identity-platform

ms.topic: include
---

To use a certificate credential for your web app, you need to create, then upload the certificate. For testing purposes, you can use a self-signed certificate. Use the following steps to create and upload a self-signed certificate:

1. Using your terminal, navigate to a directory of your choice, then create the self-signed certificate by using the following command.

    ```console
    dotnet dev-certs https -ep ./certificate.crt --trust
    ```

1. Return to the Microsoft Entra admin center, and under **Manage**, select **Certificates & secrets** > **Upload certificate**.
1. Select the **Certificates (0)** tab, then select **Upload certificate**.
1. An **Upload certificate** pane appears. Use the icon to navigate to the certificate file you created in the previous step, and select **Open**.
1. Enter a description for the certificate, for example *Certificate for aspnet-web-app*, and select **Add**.
1. Record the **Thumbprint** value for use in the next step.