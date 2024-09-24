---
title: Considerations for specific personas in a phishing-resistant passwordless authentication deployment in Microsoft Entra ID
description: Persona-specific guidance to deploy passwordless and phishing-resistant authentication for organizations that use Microsoft Entra ID.

ms.service: entra-id 
ms.subservice: authentication
ms.topic: how-to
ms.date: 09/24/2024

ms.author: justinha
author: mepples21
manager: amycolannino
ms.reviewer: miepping

ms.collection: M365-identity-device-management
# Customer intent: As an identity administrator, I want to understand how to plan phishing-resistant and passwordless authentication deployment in Microsoft Entra ID

---
# Considerations for specific personas in a phishing-resistant passwordless authentication deployment in Microsoft Entra ID

Each persona has its own challenges and considerations that commonly come up during phishing-resistant passwordless deployments. As you identify which personas you need to accommodate, you should factor these considerations into your deployment project planning. Below are links to specific guidance for each persona:
•	Information Workers
•	Frontline Workers
•	IT Pros / DevOps Workers
•	Highly Regulated Workers

## Information Workers
Information Workers typically have the simplest requirements and are the easiest to begin your phishing-resistant passwordless deployment with. However, there are still some issues that frequently arise when deploying for these users. Common examples include:

:::image type="content" border="true" source="media/how-to-deploy-phishing-resistant-passwordless-authentication/information-worker-examples.png" alt-text="Diagram that shows examples of requirements for information workers.":::

Information worker deployments, just like any other user persona, require proper communication and support. This commonly involves convincing users to install certain apps on their phones, distributing security keys where users won’t use apps, addressing concerns about biometrics, and developing processes for helping users recover from partial or total loss of their credentials.

When dealing with concerns about biometrics, make sure that you understand how technologies like Windows Hello for Business handle biometrics. The biometric data is stored only locally on the device and cannot be converted back into raw biometric data even if stolen:

•	Windows Hello for Business Biometric data storage

Information Worker Deployment Flow  

Phases 1-3 of the deployment flow for Information Workers should typically follow the standard deployment flow as pictured above. Adjust the methods used at each step as needed in your environment:

:::image type="content" border="true" source="media/how-to-deploy-phishing-resistant-passwordless-authentication/information-worker-deployment.png" alt-text="Diagram that shows deployment flow for information workers.":::


