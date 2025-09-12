---
title: 'Microsoft Entra Connect: Device options'
description: This document details device options available in Microsoft Entra Connect

author: omondiatieno
manager: mwongerapk
editor: billmath
ms.assetid: c0ff679c-7ed5-4d6e-ac6c-b2b6392e7892
ms.service: entra-id
ms.tgt_pltfrm: na
ms.topic: how-to
ms.date: 04/09/2025
ms.subservice: hybrid-connect
ms.author: jomondi


---

# Microsoft Entra Connect: Device options

The following documentation provides information about the various device options available in Microsoft Entra Connect. You can use Microsoft Entra Connect to configure the following two operations: 
* **Microsoft Entra hybrid join**: If your environment has an on-premises AD footprint and you want the benefits of Microsoft Entra ID, you can implement Microsoft Entra hybrid joined devices. These devices are joined  both to your on-premises Active Directory, and your Microsoft Entra ID.
* **Device writeback**: Device writeback is used to enable Conditional Access based on devices to AD FS (2012 R2 or higher) protected devices

<a name='configure-device-options-in-azure-ad-connect'></a>

## Configure device options in Microsoft Entra Connect

1. Run Microsoft Entra Connect. In the **Additional tasks** page, select **Configure device options**.  Click **Next**.
    ![Configure device options](./media/how-to-connect-device-options/deviceoptions.png) 

    The **Overview** page displays the details.
    ![Overview](./media/how-to-connect-device-options/deviceoverview.png)

    >[!NOTE]
    > The new Configure device options is available only in version 1.1.819.0 and newer.

2. After providing the credentials for Microsoft Entra ID, you can chose the operation to be performed on the Device options page.
    ![Device operations](./media/how-to-connect-device-options/deviceoptionsselection.png)

## Next steps

* [Configure Microsoft Entra hybrid join](~/identity/devices/hybrid-join-plan.md)
* [Configure / Disable device writeback](how-to-connect-device-writeback.md)
