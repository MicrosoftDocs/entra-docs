---
author: justinha
ms.service: active-directory
ms.custom: has-azure-ad-ps-ref
ms.topic: include
ms.date: 01/23/2024
ms.author: justinha
---

To remove a trusted certificate authority, use the [Remove-MgOrganizationCertificateBasedAuthConfiguration](powershell/module/microsoft.graph.identity.signins/remove-mgorganizationcertificatebasedauthconfiguration) cmdlet:

```powershell
    Remove-MgOrganizationCertificateBasedAuthConfiguration -CertificateBasedAuthConfigurationId <String> -OrganizationId <String>
```


