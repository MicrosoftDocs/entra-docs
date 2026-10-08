---
title: Configure Microsoft Entra Kerberos trust
description: Learn how to configure and manage Microsoft Entra Kerberos trust between Microsoft Entra ID and Active Directory Domain Services.
manager: pmwongera
ms.service: entra-id
ms.subservice: authentication
ms.topic: how-to
ms.date: 10/07/2026
ms.reviewer: Vimala, vimrang, barclayn
ms.custom: msecd-doc-authoring-1012
ai-usage: ai-assisted
# Customer intent: As an IT admin, I want to configure Microsoft Entra Kerberos trust so that users can access resources by using modern credentials.
---

# Configure Microsoft Entra Kerberos trust

Microsoft Entra Kerberos trust establishes an inbound trust relationship in which on-premises Active Directory Domain Services (AD DS) trusts Microsoft Entra ID as a Kerberos Key Distribution Center (KDC). This trust enables hybrid identity organizations to use modern credentials for applications and allows Microsoft Entra ID to become the trusted source for cloud and on-premises authentication.

This article explains how to create the Trusted Domain Object, configure clients to retrieve Kerberos tickets, rotate the Kerberos key, and remove the trust configuration.

## Prerequisites

To complete the steps in this article, you need:

- A supported Windows client that's joined to Active Directory. The domain must have a functional level of Windows Server 2012 or later.
- An on-premises Active Directory administrator account that's either a member of the Domain Admins group for the domain or a member of the Enterprise Admins group for the forest.
- A Microsoft Entra Global Administrator account.
- Hybrid identities synchronized between on-premises AD DS and Microsoft Entra ID.

## Create and configure the Microsoft Entra Kerberos Trusted Domain Object

To create and configure the Microsoft Entra Kerberos Trusted Domain Object, use the [Azure AD Hybrid Authentication Management](https://www.powershellgallery.com/packages/AzureADHybridAuthenticationManagement/) PowerShell module.

### Register the Trusted Domain Object with Microsoft Entra ID

Use the Azure AD Hybrid Authentication Management PowerShell module to set up a Trusted Domain Object in the Active Directory domain and register trust information with Microsoft Entra ID. This action creates an inbound trust relationship, which enables on-premises Active Directory to trust Microsoft Entra ID.

You only need to set up the Trusted Domain Object once per domain. If you already set up this object for your domain, skip this section and proceed to [Configure clients to retrieve Kerberos tickets](#configure-clients-to-retrieve-kerberos-tickets).

#### Install the Azure AD Hybrid Authentication Management PowerShell module

1. Start a Windows PowerShell session by using the **Run as administrator** option.

1. Install the Azure AD Hybrid Authentication Management PowerShell module by using the following script. The script:

    1. Enables TLS 1.2 for communication.
    1. Installs the NuGet package provider.
    1. Registers the PSGallery repository if it isn't already registered.
    1. Configures PSGallery as a trusted repository.
    1. Installs the PowerShellGet module.
    1. Installs the Azure AD Hybrid Authentication Management PowerShell module.

    The Azure AD Hybrid Authentication Management PowerShell module uses the AzureADPreview module, which provides advanced Microsoft Entra management features. To prevent unnecessary installation conflicts with the Azure AD PowerShell module, the installation command includes the `-AllowClobber` parameter.

    ```powershell
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

    Install-PackageProvider -Name NuGet -Force

    if (@(Get-PSRepository | Where-Object { $_.Name -eq "PSGallery" }).Count -eq 0) {
        Register-PSRepository -Default
    }

    Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted

    Install-Module -Name PowerShellGet -Force

    Install-Module -Name AzureADHybridAuthenticationManagement -AllowClobber
    ```

#### Create the Trusted Domain Object

1. Start a Windows PowerShell session by using the **Run as administrator** option.

1. Set the common parameters. Customize the script before you run it.

    1. Set the `$domain` parameter to your on-premises Active Directory domain name.
    1. When `Get-Credential` prompts you, enter the credentials for an on-premises Active Directory administrator account. The account must meet the permissions described in [Prerequisites](#prerequisites).
    1. Set the `$cloudUserName` parameter to the user principal name of a Microsoft Entra Global Administrator account.

    > [!NOTE]
    > To use your current Windows sign-in account for on-premises Active Directory access, don't assign credentials to `$domainCred`, and omit the `-DomainCredential` parameter from the PowerShell commands in this article.

    ```powershell
    $domain = "your on-premises domain name, for example contoso.com"
    $domainCred = Get-Credential
    $cloudUserName = "Microsoft Entra ID user principal name, for example admin@contoso.onmicrosoft.com"
    ```

1. Check the current Kerberos domain settings:

    ```powershell
    Get-AzureADKerberosServer -Domain $domain `
        -DomainCredential $domainCred `
        -UserPrincipalName $cloudUserName
    ```

    The first time you call a Microsoft Entra Kerberos command, you're prompted for Microsoft Entra ID access. Enter the password for your Microsoft Entra Global Administrator account. If your organization uses another modern authentication method, such as Microsoft Entra multifactor authentication or a smart card, follow the sign-in instructions.

    If Microsoft Entra Kerberos isn't configured, the [Get-AzureADKerberosServer cmdlet](howto-authentication-passwordless-security-key-on-premises.md#view-and-verify-the-microsoft-entra-kerberos-server) displays empty information:

    ```output
    ID                  :
    UserAccount         :
    ComputerAccount     :
    DisplayName         :
    DomainDnsName       :
    KeyVersion          :
    KeyUpdatedOn        :
    KeyUpdatedFrom      :
    CloudDisplayName    :
    CloudDomainDnsName  :
    CloudId             :
    CloudKeyVersion     :
    CloudKeyUpdatedOn   :
    CloudTrustDisplay   :
    ```

    If your domain already supports FIDO2 security key authentication, the cmdlet displays Microsoft Entra service account information. The `CloudTrustDisplay` field is empty:

    ```output
    ID                  : XXXXX
    UserAccount         : CN=krbtgt-AzureAD, CN=Users, DC=contoso, DC=com
    ComputerAccount     : CN=AzureADKerberos, OU=Domain Controllers, DC=contoso, DC=com
    DisplayName         : XXXXXX_XXXXX
    DomainDnsName       : contoso.com
    KeyVersion          : 53325
    KeyUpdatedOn        : 2/24/2024 9:03:15 AM
    KeyUpdatedFrom      : ds-aad-auth-dem.contoso.com
    CloudDisplayName    : XXXXXX_XXXXX
    CloudDomainDnsName  : contoso.com
    CloudId             : XXXXX
    CloudKeyVersion     : 53325
    CloudKeyUpdatedOn   : 2/24/2024 9:03:15 AM
    CloudTrustDisplay   :
    ```

1. Add the Trusted Domain Object.

    Run the [Set-AzureADKerberosServer cmdlet](howto-authentication-passwordless-security-key-on-premises.md#create-a-kerberos-server-object) with the `-SetupCloudTrust` parameter. If a Microsoft Entra service account doesn't exist, this command creates one. The command creates the Trusted Domain Object only when a Microsoft Entra service account is available.

    ```powershell
    Set-AzureADKerberosServer -Domain $domain `
        -UserPrincipalName $cloudUserName `
        -DomainCredential $domainCred `
        -SetupCloudTrust
    ```

    > [!NOTE]
    > In a multidomain forest, follow these steps to avoid the *LsaCreateTrustedDomainEx 0x549* error when you run the command on a child domain:
    >
    > 1. Run the command on the root domain with the `-SetupCloudTrust` parameter.
    > 1. Run the same command on the child domain without the `-SetupCloudTrust` parameter.

    After you create the Trusted Domain Object, check the updated Kerberos settings by using the `Get-AzureADKerberosServer` cmdlet. When the `Set-AzureADKerberosServer` cmdlet completes successfully with the `-SetupCloudTrust` parameter, the `CloudTrustDisplay` field returns `Microsoft.AzureAD.Kdc.Service.TrustDisplay`:

    ```output
    ID                  : XXXXX
    UserAccount         : CN=krbtgt-AzureAD, CN=Users, DC=contoso, DC=com
    ComputerAccount     : CN=AzureADKerberos, OU=Domain Controllers, DC=contoso, DC=com
    DisplayName         : XXXXXX_XXXXX
    DomainDnsName       : contoso.com
    KeyVersion          : 53325
    KeyUpdatedOn        : 2/24/2024 9:03:15 AM
    KeyUpdatedFrom      : ds-aad-auth-dem.contoso.com
    CloudDisplayName    : XXXXXX_XXXXX
    CloudDomainDnsName  : contoso.com
    CloudId             : XXXXX
    CloudKeyVersion     : 53325
    CloudKeyUpdatedOn   : 2/24/2024 9:03:15 AM
    CloudTrustDisplay   : Microsoft.AzureAD.Kdc.Service.TrustDisplay
    ```

    > [!NOTE]
    > Azure sovereign clouds require you to set the `TopLevelNames` property, which is set to `windows.net` by default. Some sovereign cloud services use a different top-level domain name, such as `usgovcloudapi.net` for Azure Government. Set the Trusted Domain Object to the required top-level domain names:
    >
    > ```powershell
    > Set-AzureADKerberosServer -Domain $domain `
    >     -DomainCredential $domainCred `
    >     -UserPrincipalName $cloudUserName `
    >     -SetupCloudTrust `
    >     -TopLevelNames "usgovcloudapi.net,windows.net"
    > ```
    >
    > Verify the setting:
    >
    > ```powershell
    > Get-AzureADKerberosServer -Domain $domain `
    >     -DomainCredential $domainCred `
    >     -UserPrincipalName $cloudUserName |
    >     Select-Object -ExpandProperty CloudTrustDisplay
    > ```

## Configure clients to retrieve Kerberos tickets

Identify your [Microsoft Entra tenant ID](/entra/fundamentals/how-to-find-tenant), and use Group Policy to configure every client that needs to retrieve Microsoft Entra Kerberos tickets.

Set **Administrative Templates\System\Kerberos\Specify KDC proxy servers for Kerberos clients** to **Enabled**:

1. Edit the **Administrative Templates\System\Kerberos\Specify KDC proxy servers for Kerberos clients** policy setting.
1. Select **Enabled**.
1. Under **Options**, select **Show...**.
1. Define the KDC proxy server mapping shown in the following table. Replace `your_Microsoft_Entra_tenant_ID` with your tenant ID. Include the space after `https` and before the closing `/` in the value.

    | Value name | Value |
    | --- | --- |
    | KERBEROS.MICROSOFTONLINE.COM | <https login.microsoftonline.com:443:`your_Microsoft_Entra_tenant_ID`/kerberos /> |

1. Select **OK** to close the **Show Contents** dialog.
1. Select **Apply** in the **Specify KDC proxy servers for Kerberos clients** dialog.

## Rotate the Kerberos key

Microsoft Entra Kerberos uses a shared Kerberos server key between on-premises AD DS and Microsoft Entra ID. The key encrypts and protects Ticket Granting Tickets (TGTs) issued by Microsoft Entra ID. It's stored on a dedicated Microsoft Entra Kerberos server object in on-premises Active Directory and securely published to Microsoft Entra ID. This object is logical, not a physical server, and functions like a read-only domain controller (RODC) for Kerberos trust.

Rotate the key periodically for the Microsoft Entra service account and Trusted Domain Object. Regular rotation:

- Limits the lifetime of cryptographic material.
- Reduces risk if a key is compromised.
- Aligns with standard Kerberos and Active Directory security practices.

Microsoft doesn't mandate a fixed rotation interval. Rotate the Microsoft Entra Kerberos server key on the same schedule as other Active Directory Kerberos (`krbtgt`) keys, during scheduled security maintenance windows, and immediately after a suspected credential compromise.

### How key rotation works

Microsoft Entra Kerberos uses a dual-key model to avoid service disruption during rotation:

- **Primary key**: Encrypts all newly issued Kerberos tickets.
- **Secondary key**: Retains the previous key to validate existing tickets until they expire.

When you rotate the key, the new key becomes the primary key, and the previous primary key becomes the secondary key. Microsoft Entra ID uses the primary key for new Kerberos tickets and continues to honor tickets protected by the secondary key. This process doesn't interrupt user access.

### Rotate the key

Use the `Set-AzureADKerberosServer` cmdlet to rotate the key. The command:

- Generates a new Kerberos server key.
- Stores the key on the on-premises Active Directory Kerberos server object.
- Securely publishes the key to Microsoft Entra ID.
- Updates the key version in both environments.

```powershell
Set-AzureADKerberosServer -Domain $domain `
    -DomainCredential $domainCred `
    -UserPrincipalName $cloudUserName `
    -SetupCloudTrust `
    -RotateServerKey
```

> [!WARNING]
> Other tools can rotate `krbtgt` keys, but you must use the `Set-AzureADKerberosServer` cmdlet for the Microsoft Entra Kerberos server. This cmdlet ensures that the keys are updated in both on-premises Active Directory and Microsoft Entra ID.

After you rotate the key, allow several hours for the changed key to propagate between the Kerberos KDC servers. Because of this key distribution timing, you can rotate the key once within 24 hours.

> [!IMPORTANT]
> To fully retire the older keys, perform the rotation twice after the original primary and secondary keys and their tickets have expired.

### Use the -Force parameter

If you need to rotate the key again within 24 hours, such as immediately after creating the Trusted Domain Object, add the `-Force` parameter:

```powershell
Set-AzureADKerberosServer -Domain $domain `
    -DomainCredential $domainCred `
    -UserPrincipalName $cloudUserName `
    -SetupCloudTrust `
    -RotateServerKey `
    -Force
```

The `-Force` parameter applies or updates the Kerberos server configuration without confirmation prompts while maintaining security controls. Use it when:

- You need to rotate the key again within 24 hours.
- You rerun the command to repair or reconcile configuration.
- You automate Kerberos setup or key management.
- You recover from a partial or failed configuration attempt.
- You need to ensure consistent state across environments without manual confirmation.

## Remove the Trusted Domain Object

Remove the Trusted Domain Object:

```powershell
Remove-AzureADKerberosServerTrustedDomainObject -Domain $domain `
    -DomainCredential $domainCred `
    -UserPrincipalName $cloudUserName
```

This command removes only the Trusted Domain Object. If your domain supports FIDO2 security key authentication, you can remove the object while maintaining the Microsoft Entra service account required for that authentication service.

## Remove all Kerberos settings

Remove both the Microsoft Entra service account and the Trusted Domain Object:

```powershell
Remove-AzureADKerberosServer -Domain $domain `
    -DomainCredential $domainCred `
    -UserPrincipalName $cloudUserName
```

## Related content

- [Introduction to Microsoft Entra Kerberos](kerberos.md)
- [Kerberos authentication overview in Windows Server](/windows-server/security/kerberos/kerberos-authentication-overview)
- [Enable Microsoft Entra Kerberos authentication for hybrid identities on Azure Files](/azure/storage/files/storage-files-identity-auth-hybrid-identities-enable?tabs=azure-portal%2Cintune)
