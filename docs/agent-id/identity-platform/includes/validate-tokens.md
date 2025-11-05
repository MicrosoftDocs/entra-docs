---
author: SHERMANOUKO
ms.author: shermanouko
ms.date: 11/04/2025
ms.service: entra-id

ms.topic: include
# Purpose:
# To provide information about validating tokens issued to agent identities.
---

## Validate tokens from agent identities

Token validation of token acquired for agent identities or agent user identities is [the same as for any web API](). You can do more checks to ascertain a few more things:

- Check if a token was issued for an agent identity and for which agent blueprint.

    ```csharp
    HttpContext.User.GetParentAgentBlueprint()
    ```

- Check if a token was issued for an agent user identity.

    ```csharp
    HttpContext.User.IsAgentUserIdentity()
    ```

These two extensions methods, apply to both `ClaimsIdentity` and `ClaimsPrincipal`.
