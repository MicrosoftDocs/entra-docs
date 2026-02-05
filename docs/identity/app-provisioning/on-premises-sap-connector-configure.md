---
title: Microsoft Entra provisioning into SAP ERP Central Component (SAP ECC, formerly SAP R/3) with NetWeaver AS ABAP 7.0 or later.
description: This document describes how to configure Microsoft Entra ID to provision users into SAP ERP Central Component (SAP ECC, formerly SAP R/3) with NetWeaver AS ABAP 7.0 or later.
ms.subservice: app-provisioning
ms.topic: how-to
ms.date: 04/09/2025
ms.reviewer: arvinh
---

# Configuring Microsoft Entra ID to provision users into SAP ECC with NetWeaver AS ABAP 7.0 or later
The following documentation provides configuration and tutorial information demonstrating how to provision users from Microsoft Entra ID into SAP ERP Central Component (SAP ECC, formerly SAP R/3) with NetWeaver 7.0 or later. If you're using other versions of SAP R/3, you can still use the guides provided in the [Connectors for Microsoft Identity Manager 2016](https://www.microsoft.com/download/details.aspx?id=51495) download as a reference to build your own template for provisioning.

>[!NOTE]
>This article only covers provisioning to SAP ECC via the Microsoft Entra provisioning agent. If you are using SAP S/4HANA, including SAP S/4HANA On-Premise, or other SAP SaaS applications, follow the [tutorial to configure SAP Cloud Identity Services for automatic user provisioning](~/identity/saas-apps/sap-cloud-platform-identity-authentication-provisioning-tutorial.md) to provision to those applications via SAP Cloud Identity Services instead. For more information on the SAP integrations, see [manage access to your SAP applications](~/id-governance/sap.md).

:::image type="content" source="media/on-premises-sap-connector-configure/provisioning-to-sap-on-premises-apps.png" alt-text="Diagram of provisioning to SAP ECC and SAP S/4HANA On-Premise.":::

[!INCLUDE [app-provisioning-sap.md](~/includes/app-provisioning-sap.md)]

## Next steps

- [App provisioning](user-provisioning.md)
- [Manage access to your SAP applications](~/id-governance/sap.md)
