---
author: justinha
ms.service: entra-id
ms.custom: no-azure-ad-ps-ref
ms.topic: include
ms.date: 02/17/2025
ms.author: justinha
---

To revoke a client certificate, Microsoft Entra ID fetches the certificate revocation list (CRL) from the URLs uploaded as part of certificate authority information and caches it. The last publish timestamp (**Effective Date** property) in the CRL is used to ensure the CRL is still valid. The CRL is periodically referenced to revoke access to certificates that are a part of the list.

If a more instant revocation is required (for example, if a user loses a device), the authorization token of the user can be invalidated. To invalidate the authorization token, set the **StsRefreshTokensValidFrom** field for this particular user using Windows PowerShell. You must update the **StsRefreshTokensValidFrom** field for each user you want to revoke access for.

To ensure that the revocation persists, you must set the **Effective Date** of the CRL to a date after the value set by **StsRefreshTokensValidFrom** and ensure the certificate in question is in the CRL.

The following steps outline the process for updating and invalidating the authorization token by setting the **StsRefreshTokensValidFrom** field.


```https
# Authenticate to Microsoft Graph
Connect-MgGraph -Scopes "User.Read.All"

# Get the user
$user = Get-MgUser -UserPrincipalName "test@yourdomain.com"

# Get the StsRefreshTokensValidFrom property
$user.StsRefreshTokensValidFrom
```

The date you set must be in the future. If the date is not in the future, the **StsRefreshTokensValidFrom** property is not set. If the date is in the future, **StsRefreshTokensValidFrom** is set to the current time (not the date indicated by Set-MsolUser command).
