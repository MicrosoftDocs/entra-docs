---
ms.date: 11/05/2026
ms.topic: include
ai-usage: ai-assisted
---

## Validate tokens from agent identities

Validate tokens issued for an agent identity or its dedicated user account with the API's supported authentication library. Validate the signature, issuer, audience, and lifetime, then enforce the required scopes or roles. See [Validate agent tokens in a downstream API](../how-to-validate-agent-tokens-downstream-api.md). The following identity metadata checks don't replace token validation or API authorization:

- Check if a token was issued for an agent identity and for which agent blueprint.

    ```csharp
    HttpContext.User.GetParentAgentBlueprint()
    ```

- Check if a token was issued for an agent's user account identity.

    ```csharp
    HttpContext.User.IsAgentUserIdentity()
    ```

These two extension methods apply to both `ClaimsIdentity` and `ClaimsPrincipal`.
