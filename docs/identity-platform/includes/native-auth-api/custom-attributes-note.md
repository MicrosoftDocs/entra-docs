---
author: kengaderdus
ms.service: entra-external-id
ms.subservice: external
ms.topic: include
ms.date: 03/19/2024
ms.author: kengaderdus
---

> [!NOTE]
> Custom attributes (also known as directory extensions) are named by using the convention `extension_{appId-without-hyphens}_{attribute-name}` where `{appId-without-hyphens}` is the stripped version of the client ID for the *extensions app*. For example, if the client ID of the *extensions app* is `2588a-bcdwh-tfeehj-jeeqw-ertc` and the attribute name is *hobbies*, then the custom attribute is named as`extension_2588abcdwhtfeehjjeeqwertc_hobbies`. Learn more about [custom attributes and extension app](../../../external-id/customers/how-to-define-custom-attributes.md#create-custom-user-attributes).