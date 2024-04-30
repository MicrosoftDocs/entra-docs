---
author: kengaderdus
ms.service: entra-external-id
ms.subservice: customers
ms.topic: include
ms.date: 03/19/2024
ms.author: kengaderdus
---

You specify the information you want to collect from the user by configuring the user flow settings in the Microsoft Entra admin center. Use the [Collect custom user attributes during sign-up](../../../external-id/customers/how-to-define-custom-attributes.md) article to learn how to collect values for both built-in and custom attributes.

You can also specify the **User Input Type** for the attributes you configure. The following table summarizes supported user input types, and how to submit values collected by the UI controls to Microsoft Entra.

|    User Input Type     |     Format of submitted values    |
|----------------------|----------------------|
|   TextBox   |   A single value such as job title, *Software Engineer*.  |
|   SingleRadioSelect   |  A single value such as Language, *Norwegian*.  |
|   CheckboxMultiSelect   |  One or multiple values such as a hobby or hobbies, *Dancing* or *Dancing, Swimming, Traveling*. |

Here's an example request that shows how you submit the attributes' values:

```http
POST /{tenant_subdomain}.onmicrosoft.com/signup/v1.0/continue HTTP/1.1
Host: {tenant_subdomain}.ciamlogin.com
Content-Type: application/x-www-form-urlencoded
 
continuation_token=ABAAEAAAAtfyo... 
&client_id=111101-14a6-abcd-97bc-abcd1110011 
&grant_type=attributes 
&attributes={"jobTitle": "Software Engineer", "extension_2588abcdwhtfeehjjeeqwertc_language": "Norwegian", "extension_2588abcdwhtfeehjjeeqwertc_hobbies": "Dancing,Swimming,Traveling"}
&continuation_token=AQABAAEAAAAtn...
```

Learn more about user attributes input types in [Custom user attributes input types](../../../external-id/customers/concept-user-attributes.md#custom-user-attributes-input-types) article.

### Reference user attributes 

When you [create a sign-up user-flow](../../../external-id/customers/how-to-user-flow-sign-up-sign-in-customers.md), you configure user attributes that you want to collect from the user during sign-up. The names of the user attributes in the Microsoft Entra admin center are different from how you reference them in the native authentication API.

For example, *Display Name* in the Microsoft Entra admin center is referenced as *displayName* in the API.

Use the [User profile attributes](../../../external-id/customers/concept-user-attributes.md) article to learn how to reference both built-in and custom user attributes in the native authentication API.