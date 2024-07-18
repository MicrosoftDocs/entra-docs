---
title: Change subdomain authentication type using PowerShell and Graph
description: Change default subdomain authentication settings inherited from root domain settings in Microsoft Entra ID.

author: barclayn
manager: amycolannino
ms.service: entra-id
ms.subservice: users
ms.topic: how-to
ms.date: 01/09/2024
ms.author: barclayn
ms.reviewer: sumitp
ms.custom: it-pro, has-azure-ad-ps-ref

---

# Change subdomain authentication type in Microsoft Entra ID

After a root domain is added to Microsoft Entra ID, part of Microsoft Entra, all subsequent subdomains added to that root in your Microsoft Entra organization automatically inherit the authentication setting from the root domain. However, if you want to manage domain authentication settings independently from the root domain settings, you can now with the Microsoft Graph API. For example, if you have a federated root domain such as contoso.com, this article can help you verify a subdomain such as child.contoso.com as managed instead of federated.

In the Azure portal, when the parent domain is federated and the admin tries to verify a managed subdomain on the **Custom domain names** page, you'll get a 'Failed to add domain' error with the reason "One or more properties contains invalid values." If you try to add this subdomain from the Microsoft 365 admin center, you'll receive a similar error. For more information about the error, see [A child domain doesn't inherit parent domain changes in Office 365, Azure, or Intune](/microsoft-365/troubleshoot/administration/child-domain-fails-inherit-parent-domain-changes).

Because subdomains inherit the authentication type of the root domain by default, you must promote the subdomain to a root domain in Microsoft Entra ID using the Microsoft Graph so you can set the authentication type to your desired type.

[!INCLUDE [Azure AD PowerShell deprecation note](~/../docs/reusable-content/msgraph-powershell/includes/aad-powershell-deprecation-note.md)]

> [!WARNING]
> This code is provided as an example for demonstration purposes. If you intend to use it in your environment, consider testing it first on a small scale, or in a separate test organization. You may have to adjust the code to meet the specific needs of your environment.

## Add the subdomain

1. Use PowerShell to add the new subdomain, which has its root domain's default authentication type. The Microsoft Entra ID and Microsoft 365 admin centers don't yet support this operation.

   ```powershell
   Connect-MgGraph -Scopes "Domain.ReadWrite.All"
    $param = @{
      id="test.contoso.com"
      AuthenticationType="Federated"  
     }
   New-MgDomain -Name "child.mydomain.com" -Authentication Federated
   ```

1. Use the following example to GET the domain. Because the domain isn't a root domain, it inherits the root domain authentication type. Your command and results might look as follows, using your own tenant ID:

> [!Note]
> Issuing this request can be performed directly in [Graph Explorer](https://aka.ms/ge).

   ```http
   GET https://graph.microsoft.com/v1.0/domains/foo.contoso.com/
   
   Return:
     {
         "authenticationType": "Federated",
         "availabilityStatus": null,
         "isAdminManaged": true,
         "isDefault": false,
         "isDefaultForCloudRedirections": false,
         "isInitial": false,
         "isRoot": false,          <---------------- Not a root domain, so it inherits parent domain's authentication type (federated)
         "isVerified": true,
         "name": "child.mydomain.com",
         "supportedServices": [],
         "forceDeleteState": null,
         "state": null,
         "passwordValidityPeriodInDays": null,
         "passwordNotificationWindowInDays": null
     },
   ```

## Change subdomain to a root domain

Use the following command to promote the subdomain:

```http
POST https://graph.microsoft.com/v1.0/{tenant-id}/domains/foo.contoso.com/promote
```

### Promote command error conditions

Scenario | Method | Code | Message
-------- | ------ | ---- | -------
Invoking API with a subdomain whose parent domain is unverified | POST | 400 | Unverified domains can't be promoted. Please verify the domain before promotion.
Invoking API with a federated verified subdomain with user references | POST | 400 | Promoting a subdomain with user references isn't allowed. Please migrate the users to the current root domain before promotion of the subdomain.


### Change the subdomain authentication type to managed

> [!IMPORTANT]
> If you are changing the authentication type for a federated subdomain, you should take note of the existing federation configuration values before completing the steps below. This information may become necessary if you decide to reimplement federation prior to promoting a domain. 

1. Use the following command to change the subdomain authentication type:

   ```powershell
   Connect-MGGraph -Scopes "Domain.ReadWrite.All", "Directory.AccessAsUser.All"
   Update-MgDomain -DomainId "test.contoso.com" -BodyParameter @{AuthenticationType="Managed"}
   ```

1. Verify via GET in Microsoft Graph API that subdomain authentication type is now managed:

   ```http
   GET https://graph.microsoft.com/v1.0/domains/foo.contoso.com/
   
   Return:
     {
         "authenticationType": "Managed",   <---------- Now this domain is successfully added as Managed and not inheriting Federated status
         "availabilityStatus": null,
         "isAdminManaged": true,
         "isDefault": false,
         "isDefaultForCloudRedirections": false,
         "isInitial": false,
         "isRoot": true,   <------------------------------ Also a root domain, so not inheriting from parent domain any longer
         "isVerified": true,
         "name": "child.mydomain.com",
         "supportedServices": [
             "Email",
             "OfficeCommunicationsOnline",
             "Intune"
         ],
         "forceDeleteState": null,
         "state": null,
         "passwordValidityPeriodInDays": null,
         "passwordNotificationWindowInDays": null }
   ```

## Next steps

- [Upgrade from Azure AD PowerShell to Microsoft Graph PowerShell](/powershell/microsoftgraph/migration-steps)
- [Add custom domain names](~/fundamentals/add-custom-domain.yml?context=azure/active-directory/users-groups-roles/context/ugr-context)
- [Manage domain names](domains-manage.md)
- [ForceDelete a custom domain name with Microsoft Graph API](/graph/api/domain-forcedelete)
