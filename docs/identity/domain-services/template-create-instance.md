---
title: Enable Azure DS Domain Services using a template | Microsoft Docs
description: Learn how to configure and enable Microsoft Entra Domain Services using an Azure Resource Manager template.
author: justinha
manager: amycolannino

ms.service: entra-id
ms.subservice: domain-services
ms.custom: devx-track-arm-template, has-azure-ad-ps-ref, azure-ad-ref-level-one-done
ms.topic: sample
ms.date: 09/15/2023
ms.author: justinha
---

# Create a Microsoft Entra Domain Services managed domain using an Azure Resource Manager template

Microsoft Entra Domain Services provides managed domain services such as domain join, group policy, LDAP, Kerberos/NTLM authentication that is fully compatible with Windows Server Active Directory. You consume these domain services without deploying, managing, and patching domain controllers yourself. Domain Services integrates with your existing Microsoft Entra tenant. This integration lets users sign in using their corporate credentials, and you can use existing groups and user accounts to secure access to resources.

This article shows you how to create a managed domain using an Azure Resource Manager template. Supporting resources are created using Azure PowerShell.

## Prerequisites

To complete this article, you need the following resources:

* Install and configure Azure PowerShell.
    * If needed, follow the instructions to [install the Azure PowerShell module and connect to your Azure subscription](/powershell/azure/install-azure-powershell).
    * Make sure that you sign in to your Azure subscription using the [Connect-AzAccount][Connect-AzAccount] cmdlet.
* Install and configure MS Graph PowerShell.
   - If needed, follow the instructions to [install the MS Graph PowerShell module and connect to Microsoft Entra ID](/powershell/microsoftgraph/authentication-commands?view=graph-powershell-1.0&preserve-view=true).
   - Make sure that you sign in to your Microsoft Entra tenant using the [Connect-MgGraph](/powershell/microsoftgraph/authentication-commands?view=graph-powershell-1.0&preserve-view=true) cmdlet.
* You need [Application Administrator](/azure/active-directory/roles/permissions-reference#application-administrator) and [Groups Administrator](/azure/active-directory/roles/permissions-reference#groups-administrator) Microsoft Entra roles in your tenant to enable Domain Services.
* You need Domain Services Contributor Azure role to create the required Domain Services resources.

## DNS naming requirements

When you create a Domain Services managed domain, you specify a DNS name. There are some considerations when you choose this DNS name:

* **Built-in domain name:** By default, the built-in domain name of the directory is used (a *.onmicrosoft.com* suffix). If you wish to enable secure LDAP access to the managed domain over the internet, you can't create a digital certificate to secure the connection with this default domain. Microsoft owns the *.onmicrosoft.com* domain, so a Certificate Authority (CA) doesn't issue a certificate.
* **Custom domain names:** The most common approach is to specify a custom domain name, typically one that you already own and is routable. When you use a routable, custom domain, traffic can correctly flow as needed to support your applications.
* **Non-routable domain suffixes:** We generally recommend that you avoid a nonroutable domain name suffix, such as *contoso.local*. The *.local* suffix isn't routable and can cause issues with DNS resolution.

> [!TIP]
> If you create a custom domain name, take care with existing DNS namespaces. It's recommended to use a domain name separate from any existing Azure or on-premises DNS name space.
>
> For example, if you have an existing DNS name space of *contoso.com*, create a managed domain with the custom domain name of *aaddscontoso.com*. If you need to use secure LDAP, you must register and own this custom domain name to generate the required certificates.
>
> You may need to create some additional DNS records for other services in your environment, or conditional DNS forwarders between existing DNS name spaces in your environment. For example, if you run a webserver that hosts a site using the root DNS name, there can be naming conflicts that require additional DNS entries.
>
> In this sample and how-to articles, the custom domain of *aaddscontoso.com* is used as a short example. In all commands, specify your own domain name.

The following DNS name restrictions also apply:

* **Domain prefix restrictions:** You can't create a managed domain with a prefix longer than 15 characters. The prefix of your specified domain name (such as *aaddscontoso* in the *aaddscontoso.com* domain name) must contain 15 or fewer characters.
* **Network name conflicts:** The DNS domain name for your managed domain shouldn't already exist in the virtual network. Specifically, check for the following scenarios that would lead to a name conflict.
  * If you already have an Active Directory domain with the same DNS domain name on the Azure virtual network.
  * If the virtual network where you plan to enable the managed domain has a VPN connection with your on-premises network. In this scenario, ensure you don't have a domain with the same DNS domain name on your on-premises network.
  * If you have an existing Azure cloud service with that name on the Azure virtual network.

<a name='create-required-azure-ad-resources'></a>

## Create required Microsoft Entra resources

Domain Services requires a service principal and a Microsoft Entra group. These resources let the managed domain synchronize data, and define which users have administrative permissions in the managed domain.

First, register the Microsoft Entra Domain Services resource provider using the [Register-AzResourceProvider][Register-AzResourceProvider] cmdlet:

```powershell
Register-AzResourceProvider -ProviderNamespace Microsoft.AAD
```

Create a Microsoft Entra service principal using the [New-MgServicePrincipal](/powershell/module/microsoft.graph.applications/new-mgserviceprincipal) cmdlet for Domain Services to communicate and authenticate itself. A specific application ID is used named *Domain Controller Services* with an ID of *2565bd9d-da50-47d4-8b85-4c97f669dc36* for Azure Global. For other Azure clouds, search for AppId value *6ba9a5d4-8456-4118-b521-9c5ca10cdf84*. 


```powershell
New-MgServicePrincipal
```

Now create a Microsoft Entra group named *AAD DC Administrators* using the [New-MgGroup](/powershell/module/microsoft.graph.groups/new-mggroup) cmdlet. Users added to this group are then granted permissions to perform administration tasks on the managed domain.


```powershell
New-MgGroup -DisplayName "AAD DC Administrators" `
  -Description "Delegated group to administer Microsoft Entra Domain Services" `
  -SecurityEnabled:$true -MailEnabled:$false `
  -MailNickName "AADDCAdministrators"
```

With the *AAD DC Administrators* group created, add a user to the group using the [New-MgGroupMember](/powershell/module/microsoft.graph.groups/new-mggroupmember) cmdlet. You first get the *AAD DC Administrators* group object ID using the [Get-MgGroup](/powershell/module/microsoft.graph.groups/get-mggroup) cmdlet, then the desired user's object ID using the [Get-MgUser](/powershell/module/microsoft.graph.users/get-mguser) cmdlet.

In the following example, the user object ID for the account with a UPN of `admin@contoso.onmicrosoft.com`. Replace this user account with the UPN of the user you wish to add to the *AAD DC Administrators* group:

```powershell
# First, retrieve the object ID of the newly created 'AAD DC Administrators' group.
$GroupObjectId = Get-MgGroup `
  -Filter "DisplayName eq 'AAD DC Administrators'" | `
  Select-Object Id

# Now, retrieve the object ID of the user you'd like to add to the group.
$UserObjectId = Get-MgUser `
  -Filter "UserPrincipalName eq 'admin@contoso.onmicrosoft.com'" | `
  Select-Object Id

# Add the user to the 'AAD DC Administrators' group.
New-MgGroupMember -GroupId $GroupObjectId.Id -DirectoryObjectId $UserObjectId.Id
```

Finally, create a resource group using the [New-AzResourceGroup][New-AzResourceGroup] cmdlet. In the following example, the resource group is named *myResourceGroup* and is created in the *westus* region. Use your own name and desired region:

```powershell
New-AzResourceGroup `
  -Name "myResourceGroup" `
  -Location "WestUS"
```

If you choose a region that supports Availability Zones, the Domain Services resources are distributed across zones for more redundancy. Availability Zones are unique physical locations within an Azure region. Each zone is made up of one or more datacenters equipped with independent power, cooling, and networking. To ensure resiliency, there's a minimum of three separate zones in all enabled regions.

There's nothing for you to configure for Domain Services to be distributed across zones. The Azure platform automatically handles the zone distribution of resources. For more information and to see region availability, see [What are Availability Zones in Azure?][availability-zones].

<a name='resource-definition-for-azure-ad-ds'></a>

## Resource definition for Domain Services

As part of the Resource Manager resource definition, the following configuration parameters are required:

| Parameter               | Value |
|-------------------------|---------|
| domainName              | The DNS domain name for your managed domain, taking into consideration the previous points on naming prefixes and conflicts. |
| filteredSync            | Domain Services lets you synchronize *all* users and groups available in Microsoft Entra ID, or a *scoped* synchronization of only specific groups.<br /><br /> For more information about scoped synchronization, see [Microsoft Entra Domain Services scoped synchronization][scoped-sync].|
| notificationSettings    | If there are any alerts generated in the managed domain, email notifications can be sent out. <br /><br />*Global administrators* of the Azure tenant and members of the *AAD DC Administrators* group can be *Enabled* for these notifications.<br /><br /> If desired, you can add other recipients for notifications when there are alerts that require attention.|
| domainConfigurationType | By default, a managed domain is created as a *User* forest. This type of forest synchronizes all objects from Microsoft Entra ID, including any user accounts created in an on-premises AD DS environment. You don't need to specify a *domainConfiguration* value to create a user forest.<br /><br /> A *Resource* forest only synchronizes users and groups created directly in Microsoft Entra ID. Set the value to *ResourceTrusting* to create a resource forest.<br /><br />For more information on *Resource* forests, including why you might use one and how to create forest trusts with on-premises AD DS domains, see [Domain Services resource forests overview][resource-forests].|

The following condensed parameters definition shows how these values are declared. A user forest named *aaddscontoso.com* is created with all users from Microsoft Entra ID synchronized to the managed domain:

```json
"parameters": {
    "domainName": {
        "value": "aaddscontoso.com"
    },
    "filteredSync": {
        "value": "Disabled"
    },
    "notificationSettings": {
        "value": {
            "notifyGlobalAdmins": "Enabled",
            "notifyDcAdmins": "Enabled",
            "additionalRecipients": []
        }
    },
    [...]
}
```

The following condensed Resource Manager template resource type is then used to define and create the managed domain. An Azure virtual network and subnet must already exist, or be created as part of Resource Manager template. The managed domain is connected to this subnet.

```json
"resources": [
    {
        "apiVersion": "2017-06-01",
        "type": "Microsoft.AAD/DomainServices",
        "name": "[parameters('domainName')]",
        "location": "[parameters('location')]",
        "dependsOn": [
            "[concat('Microsoft.Network/virtualNetworks/', parameters('vnetName'))]"
        ],
        "properties": {
            "domainName": "[parameters('domainName')]",
            "subnetId": "[concat('/subscriptions/', subscription().subscriptionId, '/resourceGroups/', resourceGroup().name, '/providers/Microsoft.Network/virtualNetworks/', parameters('vnetName'), '/subnets/', parameters('subnetName'))]",
            "filteredSync": "[parameters('filteredSync')]",
            "notificationSettings": "[parameters('notificationSettings')]"
        }
    },
    [...]
]
```

These parameters and resource type can be used as part of a wider Resource Manager template to deploy a managed domain, as shown in the following section.

## Create a managed domain using sample template

The following complete Resource Manager sample template creates a managed domain and the supporting virtual network, subnet, and network security group rules. The network security group rules are required to secure the managed domain and make sure traffic can flow correctly. A user forest with the DNS name of *aaddscontoso.com* is created, with all users synchronized from Microsoft Entra ID:

```json
{
    "$schema": "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "apiVersion": {
            "value": "2017-06-01"
        },
        "domainConfigurationType": {
            "value": "FullySynced"
        },
        "domainName": {
            "value": "aaddscontoso.com"
        },
        "filteredSync": {
            "value": "Disabled"
        },
        "location": {
            "value": "westus"
        },
        "notificationSettings": {
            "value": {
                "notifyGlobalAdmins": "Enabled",
                "notifyDcAdmins": "Enabled",
                "additionalRecipients": []
            }
        },
        "subnetName": {
            "value": "aadds-subnet"
        },
        "vnetName": {
            "value": "aadds-vnet"
        },
        "vnetAddressPrefixes": {
            "value": [
                "10.1.0.0/24"
            ]
        },
        "subnetAddressPrefix": {
            "value": "10.1.0.0/24"
        },
        "nsgName": {
            "value": "aadds-nsg"
        }
    },
    "resources": [
        {
            "apiVersion": "2017-06-01",
            "type": "Microsoft.AAD/DomainServices",
            "name": "[parameters('domainName')]",
            "location": "[parameters('location')]",
            "dependsOn": [
                "[concat('Microsoft.Network/virtualNetworks/', parameters('vnetName'))]"
            ],
            "properties": {
                "domainName": "[parameters('domainName')]",
                "subnetId": "[concat('/subscriptions/', subscription().subscriptionId, '/resourceGroups/', resourceGroup().name, '/providers/Microsoft.Network/virtualNetworks/', parameters('vnetName'), '/subnets/', parameters('subnetName'))]",
                "filteredSync": "[parameters('filteredSync')]",
                "domainConfigurationType": "[parameters('domainConfigurationType')]",
                "notificationSettings": "[parameters('notificationSettings')]"
            }
        },
        {
            "type": "Microsoft.Network/NetworkSecurityGroups",
            "name": "[parameters('nsgName')]",
            "location": "[parameters('location')]",
            "properties": {
                "securityRules": [
                    {
                        "name": "AllowSyncWithAzureAD",
                        "properties": {
                            "access": "Allow",
                            "priority": 101,
                            "direction": "Inbound",
                            "protocol": "Tcp",
                            "sourceAddressPrefix": "AzureActiveDirectoryDomainServices",
                            "sourcePortRange": "*",
                            "destinationAddressPrefix": "*",
                            "destinationPortRange": "443"
                        }
                    },
                    {
                        "name": "AllowPSRemoting",
                        "properties": {
                            "access": "Allow",
                            "priority": 301,
                            "direction": "Inbound",
                            "protocol": "Tcp",
                            "sourceAddressPrefix": "AzureActiveDirectoryDomainServices",
                            "sourcePortRange": "*",
                            "destinationAddressPrefix": "*",
                            "destinationPortRange": "5986"
                        }
                    },
                    {
                        "name": "AllowRD",
                        "properties": {
                            "access": "Allow",
                            "priority": 201,
                            "direction": "Inbound",
                            "protocol": "Tcp",
                            "sourceAddressPrefix": "CorpNetSaw",
                            "sourcePortRange": "*",
                            "destinationAddressPrefix": "*",
                            "destinationPortRange": "3389"
                        }
                    }
                ]
            },
            "apiVersion": "2018-04-01"
        },
        {
            "type": "Microsoft.Network/virtualNetworks",
            "name": "[parameters('vnetName')]",
            "location": "[parameters('location')]",
            "apiVersion": "2018-04-01",
            "dependsOn": [
                "[concat('Microsoft.Network/NetworkSecurityGroups/', parameters('nsgName'))]"
            ],
            "properties": {
                "addressSpace": {
                    "addressPrefixes": "[parameters('vnetAddressPrefixes')]"
                },
                "subnets": [
                    {
                        "name": "[parameters('subnetName')]",
                        "properties": {
                            "addressPrefix": "[parameters('subnetAddressPrefix')]",
                            "networkSecurityGroup": {
                                "id": "[concat('/subscriptions/', subscription().subscriptionId, '/resourceGroups/', resourceGroup().name, '/providers/Microsoft.Network/NetworkSecurityGroups/', parameters('nsgName'))]"
                            }
                        }
                    }
                ]
            }
        }
    ],
    "outputs": {}
}
```

This template can be deployed using your preferred deployment method, such as the [Microsoft Entra admin center][portal-deploy], [Azure PowerShell][powershell-deploy], or a CI/CD pipeline. The following example uses the [New-AzResourceGroupDeployment][New-AzResourceGroupDeployment] cmdlet. Specify your own resource group name and template filename:

```powershell
New-AzResourceGroupDeployment -ResourceGroupName "myResourceGroup" -TemplateFile <path-to-template>
```

It takes a few minutes to create the resource and return control to the PowerShell prompt. The managed domain continues to be provisioned in the background, and can take up to an hour to complete the deployment. In the Microsoft Entra admin center, the **Overview** page for your managed domain shows the current status throughout this deployment stage.

When the Microsoft Entra admin center shows that the managed domain finishes provisioning, the following tasks need to be completed:

* Update DNS settings for the virtual network so virtual machines can find the managed domain for domain join or authentication.
    * To configure DNS, select your managed domain in the portal. On the **Overview** window, you're prompted to automatically configure these DNS settings.
* [Enable password synchronization to Domain Services](tutorial-create-instance.md#enable-user-accounts-for-azure-ad-ds) so end users can sign in to the managed domain using their corporate credentials.

## Next steps

To see the managed domain in action, you can [domain-join a Windows VM][windows-join], [configure secure LDAP][tutorial-ldaps], and [configure password hash sync][tutorial-phs].

<!-- INTERNAL LINKS -->
[windows-join]: join-windows-vm.md

[tutorial-ldaps]: tutorial-configure-ldaps.md

[tutorial-phs]: tutorial-configure-password-hash-sync.md

[availability-zones]: /azure/reliability/availability-zones-overview

[portal-deploy]: /azure/azure-resource-manager/templates/deploy-portal

[powershell-deploy]: /azure/azure-resource-manager/templates/deploy-powershell

[scoped-sync]: scoped-synchronization.md

[resource-forests]: ./concepts-forest-trust.md

<!-- EXTERNAL LINKS -->
[Connect-AzAccount]: /powershell/module/Az.Accounts/Connect-AzAccount

[Connect-MgGraph]: /powershell/microsoftgraph/authentication-commands?view=graph-powershell-1.0

[New-MgServicePrincipal]: /powershell/module/microsoft.graph.applications/new-mgserviceprincipal

[New-MgGroup]: /powershell/module/microsoft.graph.groups/new-mggroup

[New-MgGroupMember]: /powershell/module/microsoft.graph.groups/new-mggroupmember

[Get-MgGroup]: /powershell/module/microsoft.graph.groups/get-mggroup

[Get-MgUser]: /powershell/module/microsoft.graph.users/get-mguser

[Register-AzResourceProvider]: /powershell/module/Az.Resources/Register-AzResourceProvider

[New-AzResourceGroup]: /powershell/module/Az.Resources/New-AzResourceGroup

[Get-AzSubscription]: /powershell/module/Az.Accounts/Get-AzSubscription

[cloud-shell]: /azure/active-directory/develop/configure-app-multi-instancing

[naming-prefix]: /windows-server/identity/ad-ds/plan/selecting-the-forest-root-domain

[New-AzResourceGroupDeployment]: /powershell/module/az.resources/new-azresourcegroupdeployment
