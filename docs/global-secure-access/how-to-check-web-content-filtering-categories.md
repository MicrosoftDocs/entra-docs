---
title: Check web content filtering categories
description: Use the web category checker to find which web content category a URL belongs to via Microsoft Graph.
author: fgomulka
ms.author: frankgomulka
ms.topic: how-to
ms.service: global-secure-access
ms.date: 08/28/2025
ms.custom: sfi-image-nochange
ai-usage: ai-assisted
---

# Check web categories with the web category checker tool

This short how-to shows how to use the web category checker tool to determine which content category a given Uniform Resource Locator (URL) belongs to. The tool is currently available only via Microsoft Graph API.

## How to use the Web category checker

1. Sign in to Graph Explorer at https://aka.ms/ge as a Global Secure Access Administrator.
2. Set the HTTP method to **GET** and the API version to **beta**.
3. Use the following request format, replacing example.com with the host/path you want to check (for example, `msn.com/en-us/sports`):

```http
GET https://graph.microsoft.com/beta/networkaccess/connectivity/microsoft.graph.networkaccess.getWebCategoryByUrl(url='@url')?@url=example.com
```

Example:

```http
GET hhttps://graph.microsoft.com/beta/networkaccess/connectivity/microsoft.graph.networkaccess.getWebCategoryByUrl(url='@url')?@url=msn.com/en-us/sports
```

Notes:
- If the URL contains characters that need encoding (for example, spaces or query strings), URL-encode the `@url` value.
- The feature is API-only at the moment; there's no UI in the Microsoft Entra admin center for this.

## Responses

- 200 OK — The API returns JSON containing category information for the supplied URL. Example (illustrative):

```json
{
    "@odata.context": "https://graph.microsoft.com/beta/$metadata#microsoft.graph.networkaccess.webCategory",
    "name": "Sports",
    "displayName": "Sports",
    "group": "GeneralSurfing"
}
```

## Next steps

- Use the category value to validate or create network access rules and policies.
- Verify possible [web categories](reference-web-content-filtering-categories.md)
