---
author: justinha
ms.service: entra-id
ms.custom: no-azure-ad-ps-ref
ms.topic: include
ms.date: 11/12/2026
ms.author: justinha
ai-usage: ai-assisted
---

To revoke a client certificate, Microsoft Entra ID fetches the certificate revocation list (CRL) from the URLs uploaded as part of certificate authority information and caches it. The last publish timestamp (**Effective Date** property) in the CRL is used to ensure the CRL is still valid. The CRL is periodically referenced to revoke access to certificates that are a part of the list.

Use [Revoke-MgUserSignInSession](/powershell/module/microsoft.graph.users.actions/revoke-mgusersigninsession) to invalidate the user's refresh tokens and browser session cookies. Run the command for each affected user. The operation resets **signInSessionsValidFromDateTime** to the current date and time.

```powershell
# Authenticate to Microsoft Graph
Connect-MgGraph -Scopes "User.RevokeSessions.All"

# Revoke sign-in sessions for the affected user
Revoke-MgUserSignInSession -UserId "test@contoso.com"
```

Revocation can take a few minutes to take effect. For more information, see [Revoke sign-in sessions](/graph/api/user-revokesigninsessions). Revoking sessions doesn't revoke the certificate. To make sure the revocation persists, add the certificate to the CRL and publish a CRL whose **Effective Date** is later than the user's **signInSessionsValidFromDateTime** value.
