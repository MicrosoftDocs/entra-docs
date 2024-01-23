---
author: justinha
ms.service: active-directory
ms.custom: has-azure-ad-ps-ref
ms.topic: include
ms.date: 01/23/2024
ms.author: justinha
---

To create a trusted certificate authority, use the [New-MgOrganizationCertificateBasedAuthConfiguration](/powershell/module/microsoft.graph.identity.signins/new-mgorganizationcertificatebasedauthconfiguration) cmdlet and set the **crlDistributionPoint** attribute to a correct value:

```azurepowershell
    $cert=Get-Content -Encoding byte "[LOCATION OF THE CER FILE]"
    $new_ca=New-Object -TypeName Microsoft.Open.AzureAD.Model.CertificateAuthorityInformation
    $new_ca.AuthorityType=0
    $new_ca.TrustedCertificate=$cert
    $new_ca.crlDistributionPoint="<CRL Distribution URL>"
    New-AzureADTrustedCertificateAuthority -CertificateAuthorityInformation $new_ca
```
