---
title: Certificate renewal for Microsoft 365 and Microsoft Entra users
description: This article explains to Microsoft 365 users how to resolve issues with emails that notify them about renewing a certificate.
author: omondiatieno
manager: mwongerapk
ms.assetid: 543b7dc1-ccc9-407f-85a1-a9944c0ba1be
ms.service: entra-id
ms.tgt_pltfrm: na
ms.custom: no-azure-ad-ps-ref, sfi-image-nochange
ms.topic: how-to
ms.date: 04/09/2025
ms.subservice: hybrid-connect
ms.author: jomondi
---
# Renew federation certificates for Microsoft 365 and Microsoft Entra ID
## Overview
For successful federation between Microsoft Entra ID and Active Directory Federation Services (AD FS), the certificates used by AD FS to sign security tokens to Microsoft Entra ID should match what is configured in Microsoft Entra ID. Any mismatch can lead to broken trust. Microsoft Entra ID ensures that this information is kept in sync when you deploy AD FS and Web Application Proxy (for extranet access).

> [!NOTE]
> This article provides information on managing your federation certificates. For information on emergency rotation see [Emergency Rotation of the AD FS certificates](how-to-connect-emergency-ad-fs-certificate-rotation.md)

This article provides you additional information to manage your token signing certificates and keep them in sync with Microsoft Entra ID, in the following cases:

* You aren't deploying the Web Application Proxy, and therefore the federation metadata is not available in the extranet.
* You aren't using the default configuration of AD FS for token signing certificates.
* You're using a third-party identity provider.

> [!IMPORTANT]
> Microsoft highly recommends using a Hardware Security Module (HSM) to protect and secure certificates.
> For more information see [Hardware Security Module](/windows-server/identity/ad-fs/deployment/best-practices-securing-ad-fs#hardware-security-module-hsm) under best practices for securing AD FS.

## Default configuration of AD FS for token signing certificates
The token signing and token decrypting certificates are usually self-signed certificates, and are good for one year. By default, AD FS includes an auto-renewal process called **AutoCertificateRollover**. If you're using AD FS 2.0 or later, Microsoft 365 and Microsoft Entra ID automatically update your certificate before it expires.

### Renewal notification from the Microsoft 365 admin center or an email
> [!NOTE]
> If you received an email asking you to renew your certificate for Office, see [Managing changes to token signing certificates](#managecerts) to check if you need to take any action. Microsoft is aware of a possible issue that can lead to notifications for certificate renewal being sent, even when no action is required.
>
>

Microsoft Entra ID attempts to monitor the federation metadata, and update the token signing certificates as indicated by this metadata. Thirty-five (35) days before the expiration of the token signing certificates, Microsoft Entra ID checks if new certificates are available by polling the federation metadata.

* If it can successfully poll the federation metadata and retrieve the new certificates, no email notification is issued to the user.
* If it can't retrieve the new token signing certificates, either because the federation metadata is not reachable or automatic certificate rollover is not enabled, Microsoft Entra ID issues an email.


> [!IMPORTANT]
> If you're using AD FS, to ensure business continuity, please verify that your servers have the following updates so that authentication failures for known issues do not occur. This mitigates known AD FS proxy server issues for this renewal and future renewal periods:
>
> Server 2012 R2 - [Windows Server May 2014 rollup](https://support.microsoft.com/kb/2955164)
>
> Server 2008 R2 and 2012 - [Authentication through proxy fails in Windows Server 2012 or Windows 2008 R2 SP1](https://support.microsoft.com/kb/3094446)
>
>

## Check if the certificates need to be updated <a name="managecerts"></a>
### Step 1: Check the AutoCertificateRollover state
On your AD FS server, open PowerShell. Check that the AutoCertificateRollover value is set to True.

```azurepowershell-interactive
Get-Adfsproperties
```

![AutoCertificateRollover](./media/how-to-connect-fed-o365-certs/autocertrollover.png)

>[!NOTE] 
>If you're using AD FS 2.0, first run Add-Pssnapin Microsoft.Adfs.Powershell.

<a name='step-2-confirm-that-ad-fs-and-azure-ad-are-in-sync'></a>

### Step 2: Confirm that AD FS and Microsoft Entra ID are in sync
On your AD FS server, open the PowerShell prompt, and connect to Microsoft Entra ID.

> [!NOTE]
> Microsoft Entra are part of the Microsoft Entra PowerShell.
> You can download the Microsoft Entra PowerShell module directly from the PowerShell Gallery.

```azurepowershell-interactive
Install-Module -Name Microsoft.Entra
```

Connect to Microsoft Entra ID.

```azurepowershell-interactive
Connect-Entra -Scopes 'Domain.Read.All'
```

Check the certificates configured in AD FS and Microsoft Entra ID trust properties for the specified domain.

```azurepowershell-interactive
Get-EntraFederationProperty -DomainName <domain.name> | FL Source, SigningCertificate
```
If the thumbprints in both the outputs match, your certificates are in sync with Microsoft Entra ID.

### Step 3: Check if your certificate is about to expire

In the output of either Get-EntraFederationProperty or Get-AdfsCertificate, check for the date under "Not After." If the date is less than 35 days away, you should take action.

| AutoCertificateRollover | Certificates in sync with Microsoft Entra ID | Federation metadata is publicly accessible | Validity | Action |
|:---:|:---:|:---:|:---:|:---:|
| Yes |Yes |Yes |- |No action needed. See [Renew token signing certificate automatically](#autorenew). |
| Yes |No |- |Less than 15 days |Renew immediately. See [Renew token signing certificate manually](#manualrenew). |
| No |- |- |Less than 35 days |Renew immediately. See [Renew token signing certificate manually](#manualrenew). |

\[-]  Doesn't matter

## Renew the token signing certificate automatically (recommended) <a name="autorenew"></a>
You don't need to perform any manual steps if both of the following are true:

* You have deployed Web Application Proxy, which can enable access to the federation metadata from the extranet.
* You're using the AD FS default configuration (AutoCertificateRollover is enabled).

Check the following to confirm that the certificate can be automatically updated.

**1. The AD FS property AutoCertificateRollover must be set to True.** This indicates that AD FS automatically generates new token signing and token decryption certificates, before the old ones expire.

**2. The AD FS federation metadata is publicly accessible.** Check that your federation metadata is publicly accessible by navigating to the following URL from a computer on the public internet (off of the corporate network):

`https://(your_FS_name)/federationmetadata/2007-06/federationmetadata.xml`

where `(your_FS_name)` is replaced with the federation service host name your organization uses, such as fs.contoso.com.  If you're able to verify both of these settings successfully, you do not have to do anything else.  

Example: `https://fs.contoso.com/federationmetadata/2007-06/federationmetadata.xml`
## Renew the token signing certificate manually <a name="manualrenew"></a>
You may choose to renew the token signing certificates manually. For example, the following scenarios might work better for manual renewal:

* Token signing certificates aren't self-signed certificates. The most common reason for this is that your organization manages AD FS certificates enrolled from an organizational certificate authority.
* Network security does not allow the federation metadata to be publicly available.
* You are migrating the federated domain from an existing federation service to a new federation service.
  
> [!IMPORTANT]
> If you're migrating an existing federated domain to a new federation service, it is recommended to follow [Emergency Rotation of the AD FS certificates](how-to-connect-emergency-ad-fs-certificate-rotation.md)


In these scenarios, every time you update the token signing certificates, you must also update your Microsoft 365 domain by using the PowerShell command, Update-MgDomainFederationConfiguration.

### Step 1: Ensure that AD FS has new token signing certificates
**Non-default configuration**

If you're using a non-default configuration of AD FS (where **AutoCertificateRollover** is set to **False**), you're probably using custom certificates (not self-signed). For more information about how to renew the AD FS token signing certificates, see [Certificate requirements for federated servers](/windows-server/identity/ad-fs/design/certificate-requirements-for-federation-servers).

**Federation metadata is not publicly available**

On the other hand, if **AutoCertificateRollover** is set to **True**, but your federation metadata is not publicly accessible, first make sure that new token signing certificates are generated by AD FS. Confirm you have new token signing certificates by taking the following steps:

1. Verify that you're logged on to the primary AD FS server.
2. Check the current signing certificates in AD FS by opening a PowerShell command window, and running the following command:

    `Get-ADFSCertificate -CertificateType Token-Signing`

   > [!NOTE]
   > If you're using AD FS 2.0, you should run `Add-Pssnapin Microsoft.Adfs.Powershell` first.
   >
   >
3. Look at the command output at any certificates listed. If AD FS has generated a new certificate, you should see two certificates in the output: one for which the **IsPrimary** value is **True** and the **NotAfter** date is within 5 days, and one for which **IsPrimary** is **False** and **NotAfter** is about a year in the future.
4. If you only see one certificate, and the **NotAfter** date is within 5 days, you need to generate a new certificate.
5. To generate a new certificate, execute the following command at a PowerShell command prompt: `Update-ADFSCertificate -CertificateType Token-Signing`.
6. Verify the update by running the following command again: `Get-ADFSCertificate -CertificateType Token-Signing`

Two certificates should be listed now, one of which has a **NotAfter** date of approximately one year in the future, and for which the **IsPrimary** value is **False**.

### Step 2: Update the new token signing certificates for the Microsoft 365 trust
Update Microsoft 365 with the new token signing certificates to be used for the trust, as follows.

1. Open Azure PowerShell.
2. Run `Connect-Entra -Scopes 'Domain.Read.All'`. This cmdlet connects you to the cloud service. Creating a context that connects you to the cloud service is required before running any of the additional cmdlets installed by the tool.
  
> [!NOTE]
> 
> -InternalDomainFederationId can be found by running the command `Get-EntraFederationProperty -Domainname your_domain.com`
   <img width="1774" height="165" alt="Get-EntraFedProperty" src="https://github.com/user-attachments/assets/05daad2b-81b2-48f8-9fca-c34eb729b594" />

3. Run `Update-MgDomainFederationConfiguration -DomainId <your_domain.com> -InternalDomainFederationId <hex_domain ID>`. This cmdlet updates the settings from AD FS into the cloud service, and configures the trust relationship between the two.


>
> [!NOTE]
> If you need to support multiple top-level domains, such as contoso.com and fabrikam.com, you must apply the above settings and go domain by domain without the **-SupportMultipleDomain** switch since it is no longer available for **Microsoft.Entra** and **Microsoft.Graph** modules.
>
> For more information, see [Support for Multiple Top Level Domains](how-to-connect-install-multiple-domains.md).
>
> If your tenant is federated with more than one domain, the `Update-MgDomainFederationConfiguration` needs to be run for all the domains, listed in the output from:
> 
> `Get-EntraDomain | Where-Object {$ _. 'AuthenticationType' -eq 'Federated'} | Select-object Name, AuthenticationType`.
> 
> This ensures that all of the federated domains are updated to the Token-Signing certificate and you can achieve this by running:
> 
> `Update-MgDomainFederationConfiguration -DomainId <your_domain.com> -InternalDomainFederationId <hex_domain ID>`

<a name='repair-azure-ad-trust-by-using-azure-ad-connect-a-nameconnectrenewa'></a>

## Repair Microsoft Entra ID trust by using Microsoft Entra Connect <a name="connectrenew"></a>
If you configured your AD FS farm and Microsoft Entra ID trust by using Microsoft Entra Connect, you can use Microsoft Entra Connect to detect if you need to take any action for your token signing certificates. If you need to renew the certificates, you can use Microsoft Entra Connect to do so.

For more information, see [Repairing the trust](how-to-connect-fed-management.md).

<a name='ad-fs-and-azure-ad-certificate-update-steps'></a>

## AD FS and Microsoft Entra certificate update steps
Token signing certificates are standard X509 certificates that are used to securely sign all tokens that the federation server issues. Token decryption certificates are standard X509 certificates that are used to decrypt any incoming tokens. 

By default, AD FS is configured to generate token signing and token decryption certificates automatically, both at the initial configuration time and when the certificates are approaching their expiration date.

Microsoft Entra ID tries to retrieve a new certificate from your federation service metadata 35 days before the expiry of the current certificate. In case a new certificate is not available at that time, Microsoft Entra ID continues to monitor the metadata on regular daily intervals. As soon as the new certificate is available in the metadata, the federation settings for the domain are updated with the new certificate information. You can use `Get-MgDomainFederationConfiguration` to verify if you see the new certificate in the NextSigningCertificate / SigningCertificate.

For more information on Token Signing certificates in AD FS, see [Obtain and Configure Token Signing and Token Decryption Certificates for AD FS](/windows-server/identity/ad-fs/operations/configure-ts-td-certs-ad-fs)
