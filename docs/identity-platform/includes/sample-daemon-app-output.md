---
author: kengaderdus
manager: dougeby
ms.author: kengaderdus
ms.date: 11/06/2024
ms.reviewer:
ms.service: identity-platform
ms.topic: include
---

If the app runs successfully, you should see a JSON formatted output representing a list of all users from your workforce tenant. It looks similar to the following snippet:

```json
{
  '@odata.context': 'https://graph.microsoft.com/v1.0/$metadata#users',
  value: [
    {
      businessPhones: [],
      displayName: 'Casey Jensen',
      givenName: 'Jense',
      jobTitle: null,
      mail: null,
      mobilePhone: null,
      officeLocation: null,
      preferredLanguage: null,
      surname: 'Casey',
      userPrincipalName: 'jensen@contoso.onmicrosoft.com',
      id: 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
    },
    ...
  ]
}

```