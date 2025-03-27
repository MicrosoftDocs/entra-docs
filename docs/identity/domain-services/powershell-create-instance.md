---
title: Enable Microsoft Entra Domain Services using PowerShell | Microsoft Learn
description: Learn how to configure and enable Microsoft Entra Domain Services using Microsoft Graph PowerShell and Azure PowerShell.
author: justinha
manager: femila

ms.assetid: d4bc5583-6537-4cd9-bc4b-7712fdd9272a
ms.service: entra-id
ms.subservice: domain-services
ms.topic: sample
ms.date: 02/05/2025
ms.author: justinha
ms.reviewer: wanjikumugo
ms.custom: devx-track-azurepowershell, has-azure-ad-ps-ref, azure-ad-ref-level-one-done
---

# Enable Microsoft Entra Domain Services using PowerShell

Microsoft Entra Domain Services provides managed domain services such as domain join, group policy, LDAP, Kerberos/NTLM authentication that is fully compatible with Windows Server Active Directory. You consume these domain services without deploying, managing, and patching domain controllers yourself. Domain Services integrates with your existing Microsoft Entra tenant. This integration lets users sign in using their corporate credentials, and you can use existing groups and user accounts to secure access to resources.

This article shows you how to enable Domain Services using PowerShell.

[!INCLUDE [updated-for-az.md](~/includes/azure-docs-pr/updated-for-az.md)]

## Prerequisites

To complete this article, you need the following resources:

* Install and configure Azure PowerShell.
    * If needed, follow the instructions to [install the Azure PowerShell module and connect to your Azure subscription](/powershell/azure/install-azure-powershell).
    * Make sure that you sign in to your Azure subscription using the [Connect-AzAccount][Connect-AzAccount] cmdlet.
* Install and configure MS Graph PowerShell.
   - If needed, follow the instructions to [install the MS Graph PowerShell module and connect to Microsoft Entra ID](/powershell/microsoftgraph/installation).
    * Make sure that you sign in to your Microsoft Entra tenant using the [Connect-MgGraph][Connect-MgGraph] cmdlet.
* [!INCLUDE [Privileged role feature](~/includes/privileged-role-feature-include.md)]
* *Contributor* privileges for the Azure subscription are required for this feature.

  > [!IMPORTANT]
  > While the **Az.ADDomainServices** PowerShell module is in preview, you must install it separately
  > using the `Install-Module` cmdlet.

  ```azurepowershell-interactive
  Install-Module -Name Az.ADDomainServices
  ```

<a name='create-required-azure-ad-resources'></a>

## Create required Microsoft Entra resources

Domain Services requires a service principal to authenticate and communicate and a Microsoft Entra group to define which users have administrative permissions in the managed domain.

First, create a Microsoft Entra service principal by using a specific application ID named *Domain Controller Services*. The ID value is *2565bd9d-da50-47d4-8b85-4c97f669dc36* for global Azure and *6ba9a5d4-8456-4118-b521-9c5ca10cdf84* for other Azure clouds. Don't change this application ID.

Create a Microsoft Entra service principal using the [New-MgServicePrincipal][New-MgServicePrincipal] cmdlet:

```powershell
New-MgServicePrincipal -AppId "2565bd9d-da50-47d4-8b85-4c97f669dc36"
```

Now create a Microsoft Entra group named *AAD DC Administrators*. Users added to this group are then granted permissions to perform administration tasks on the managed domain.

First, get the *AAD DC Administrators* group object ID using the [Get-MgGroup][Get-MgGroup] cmdlet. If the group doesn't exist, create it with the *AAD DC Administrators* group using the [New-MgGroup][New-MgGroup] cmdlet:

```powershell
# First, retrieve the object ID of the 'AAD DC Administrators' group.
$GroupObject = Get-MgGroup `
  -Filter "DisplayName eq 'AAD DC Administrators'"

# If the group doesn't exist, create it
if (!$GroupObject) {
  $GroupObject = New-MgGroup -DisplayName "AAD DC Administrators" `
    -Description "Delegated group to administer Microsoft Entra Domain Services" `
    -SecurityEnabled:$true `
    -MailEnabled:$false `
    -MailNickName "AADDCAdministrators"
  } else {
  Write-Output "Admin group already exists."
}
```

With the *AAD DC Administrators* group created, get the desired user's object ID using the [Get-MgUser][Get-MgUser] cmdlet, then add the user to the group using the [New-MgGroupMemberByRef][New-MgGroupMemberByRef] cmdlet.

In the following example, the user object ID for the account with a UPN of `admin@contoso.onmicrosoft.com`. Replace this user account with the UPN of the user you wish to add to the *AAD DC Administrators* group:

```powershell
# Retrieve the object ID of the user you'd like to add to the group.
$UserObjectId = Get-MgUser `
  -Filter "UserPrincipalName eq 'admin@contoso.onmicrosoft.com'" | `
  Select-Object Id

# Add the user to the 'AAD DC Administrators' group.
New-MgGroupMember -GroupId $GroupObject.Id -DirectoryObjectId $UserObjectId.Id
```

## Create network resources

First, register the Microsoft Entra Domain Services resource provider using the [Register-AzResourceProvider][Register-AzResourceProvider] cmdlet:

```azurepowershell-interactive
Register-AzResourceProvider -ProviderNamespace Microsoft.AAD
```

Next, create a resource group using the [New-AzResourceGroup][New-AzResourceGroup] cmdlet. In the following example, the resource group is named *myResourceGroup* and is created in the *westus* region. Use your own name and desired region:

```azurepowershell-interactive
$ResourceGroupName = "myResourceGroup"
$AzureLocation = "westus"

# Create the resource group.
New-AzResourceGroup `
  -Name $ResourceGroupName `
  -Location $AzureLocation
```

Create the virtual network and subnets for Microsoft Entra Domain Services. Two subnets are created - one for *DomainServices*, and one for *Workloads*. Domain Services is deployed into the dedicated *DomainServices* subnet. Don't deploy other applications or workloads into this subnet. Use the separate *Workloads* or other subnets for the rest of your VMs.

Create the subnets using the [New-AzVirtualNetworkSubnetConfig][New-AzVirtualNetworkSubnetConfig] cmdlet, then create the virtual network using the [New-AzVirtualNetwork][New-AzVirtualNetwork] cmdlet.

```azurepowershell-interactive
$VnetName = "myVnet"

# Create the dedicated subnet for Microsoft Entra Domain Services.
$SubnetName = "DomainServices"
$AaddsSubnet = New-AzVirtualNetworkSubnetConfig `
  -Name $SubnetName `
  -AddressPrefix 10.0.0.0/24

# Create an additional subnet for your own VM workloads
$WorkloadSubnet = New-AzVirtualNetworkSubnetConfig `
  -Name Workloads `
  -AddressPrefix 10.0.1.0/24

# Create the virtual network in which you will enable Microsoft Entra Domain Services.
$Vnet= New-AzVirtualNetwork `
  -ResourceGroupName $ResourceGroupName `
  -Location westus `
  -Name $VnetName `
  -AddressPrefix 10.0.0.0/16 `
  -Subnet $AaddsSubnet,$WorkloadSubnet
```

### Create a network security group

Domain Services needs a network security group to secure the ports needed for the managed domain and block all other incoming traffic. A [network security group (NSG)][nsg-overview] contains a list of rules that allow or deny network traffic to traffic in an Azure virtual network. In Domain Services, the network security group acts as an extra layer of protection to lock down access to the managed domain. To view the ports required, see [Network security groups and required ports][network-ports].

The following PowerShell cmdlets use [New-AzNetworkSecurityRuleConfig][New-AzNetworkSecurityRuleConfig] to create the rules, then [New-AzNetworkSecurityGroup][New-AzNetworkSecurityGroup] to create the network security group. The network security group and rules are then associated with the virtual network subnet using the [Set-AzVirtualNetworkSubnetConfig][Set-AzVirtualNetworkSubnetConfig] cmdlet.

```azurepowershell-interactive
$NSGName = "dsNSG"

# Create a rule to allow inbound TCP port 3389 traffic from Microsoft secure access workstations for troubleshooting
$nsg201 = New-AzNetworkSecurityRuleConfig -Name AllowRD `
    -Access Allow `
    -Protocol Tcp `
    -Direction Inbound `
    -Priority 201 `
    -SourceAddressPrefix CorpNetSaw `
    -SourcePortRange * `
    -DestinationAddressPrefix * `
    -DestinationPortRange 3389

# Create a rule to allow TCP port 5986 traffic for PowerShell remote management
$nsg301 = New-AzNetworkSecurityRuleConfig -Name AllowPSRemoting `
    -Access Allow `
    -Protocol Tcp `
    -Direction Inbound `
    -Priority 301 `
    -SourceAddressPrefix AzureActiveDirectoryDomainServices `
    -SourcePortRange * `
    -DestinationAddressPrefix * `
    -DestinationPortRange 5986

# Create the network security group and rules
$nsg = New-AzNetworkSecurityGroup -Name $NSGName `
    -ResourceGroupName $ResourceGroupName `
    -Location $AzureLocation `
    -SecurityRules $nsg201,$nsg301

# Get the existing virtual network resource objects and information
$vnet = Get-AzVirtualNetwork -Name $VnetName -ResourceGroupName $ResourceGroupName
$subnet = Get-AzVirtualNetworkSubnetConfig -VirtualNetwork $vnet -Name $SubnetName
$addressPrefix = $subnet.AddressPrefix

# Associate the network security group with the virtual network subnet
Set-AzVirtualNetworkSubnetConfig -Name $SubnetName `
    -VirtualNetwork $vnet `
    -AddressPrefix $addressPrefix `
    -NetworkSecurityGroup $nsg
$vnet | Set-AzVirtualNetwork
```

## Create a managed domain

Now let's create a managed domain. Set your Azure subscription ID, and then provide a name for the managed domain, such as *dscontoso.com*. You can get your subscription ID using the [Get-AzSubscription][Get-AzSubscription] cmdlet.

If you choose a region that supports Availability Zones, the Domain Services resources are distributed across zones for redundancy.

Availability Zones are unique physical locations within an Azure region. Each zone is made up of one or more datacenters equipped with independent power, cooling, and networking. To ensure resiliency, there's a minimum of three separate zones in all enabled regions.

There's nothing for you to configure for Domain Services to be distributed across zones. The Azure platform automatically handles the zone distribution of resources. For more information and to see region availability, see [What are Availability Zones in Azure?][availability-zones].

```azurepowershell-interactive
$AzureSubscriptionId = "YOUR_AZURE_SUBSCRIPTION_ID"
$ManagedDomainName = "dscontoso.com"

# Enable Microsoft Entra Domain Services for the directory.
$replicaSetParams = @{
  Location = $AzureLocation
  SubnetId = "/subscriptions/$AzureSubscriptionId/resourceGroups/$ResourceGroupName/providers/Microsoft.Network/virtualNetworks/$VnetName/subnets/DomainServices"
}
$replicaSet = New-AzADDomainServiceReplicaSetObject @replicaSetParams

$domainServiceParams = @{
  Name = $ManagedDomainName
  ResourceGroupName = $ResourceGroupName
  DomainName = $ManagedDomainName
  ReplicaSet = $replicaSet
}
New-AzADDomainService @domainServiceParams
```

It takes a few minutes to create the resource and return control to the PowerShell prompt. The managed domain continues to be provisioned in the background, and can take up to an hour to complete the deployment. In the Microsoft Entra admin center, the **Overview** page for your managed domain shows the current status throughout this deployment stage.

When the Microsoft Entra admin center shows that the managed domain has finished provisioning, the following tasks need to be completed:

* Update DNS settings for the virtual network so virtual machines can find the managed domain for domain join or authentication.
    * To configure DNS, select your managed domain in the portal. On the **Overview** window, you are prompted to automatically configure these DNS settings.
* [Enable password synchronization to Domain Services](tutorial-create-instance.md#enable-user-accounts-for-azure-ad-ds) so end users can sign in to the managed domain using their corporate credentials.

## Complete PowerShell script

The following complete PowerShell script combines all of the tasks shown in this article. Copy the script and save it to a file with a `.ps1` extension. For Azure Global, use AppId value *2565bd9d-da50-47d4-8b85-4c97f669dc36*. For other Azure clouds, use AppId value *6ba9a5d4-8456-4118-b521-9c5ca10cdf84*. Run the script in a local PowerShell console or the [Azure Cloud Shell][cloud-shell].

[!INCLUDE [Privileged role feature](~/includes/privileged-role-feature-include.md)]

*Contributor* privileges for the Azure subscription are required for this feature.

```azurepowershell-interactive
# Change the following values to match your deployment.
$AaddsAdminUserUpn = "admin@contoso.onmicrosoft.com"
$ResourceGroupName = "myResourceGroup"
$VnetName = "myVnet"
$AzureLocation = "westus"
$AzureSubscriptionId = "YOUR_AZURE_SUBSCRIPTION_ID"
$ManagedDomainName = "dscontoso.com"

# Connect to your Microsoft Entra directory.
Connect-MgGraph -Scopes "Application.ReadWrite.All","Directory.ReadWrite.All"

# Login to your Azure subscription.
Connect-AzAccount

# Create the service principal for Microsoft Entra Domain Services.
New-MgServicePrincipal -AppId "2565bd9d-da50-47d4-8b85-4c97f669dc36"

# First, retrieve the object of the 'AAD DC Administrators' group.
$GroupObject = Get-MgGroup `
  -Filter "DisplayName eq 'AAD DC Administrators'"

# Create the delegated administration group for Microsoft Entra Domain Services if it doesn't already exist.
if (!$GroupObject) {
  $GroupObject = New-MgGroup -DisplayName "AAD DC Administrators" `
    -Description "Delegated group to administer Microsoft Entra Domain Services" `
    -SecurityEnabled:$true `
    -MailEnabled:$false `
    -MailNickName "AADDCAdministrators"
  } else {
  Write-Output "Admin group already exists."
}

# Now, retrieve the object ID of the user you'd like to add to the group.
$UserObjectId = Get-MgUser `
  -Filter "UserPrincipalName eq '$AaddsAdminUserUpn'" | `
  Select-Object Id

# Add the user to the 'AAD DC Administrators' group.
New-MgGroupMember -GroupId $GroupObject.Id -DirectoryObjectId $UserObjectId.Id

# Register the resource provider for Microsoft Entra Domain Services with Resource Manager.
Register-AzResourceProvider -ProviderNamespace Microsoft.AAD

# Create the resource group.
New-AzResourceGroup `
  -Name $ResourceGroupName `
  -Location $AzureLocation

# Create the dedicated subnet for Microsoft Entra Domain Services.
$SubnetName = "DomainServices"
$AaddsSubnet = New-AzVirtualNetworkSubnetConfig `
  -Name DomainServices `
  -AddressPrefix 10.0.0.0/24

$WorkloadSubnet = New-AzVirtualNetworkSubnetConfig `
  -Name Workloads `
  -AddressPrefix 10.0.1.0/24

# Create the virtual network in which you will enable Microsoft Entra Domain Services.
$Vnet=New-AzVirtualNetwork `
  -ResourceGroupName $ResourceGroupName `
  -Location $AzureLocation `
  -Name $VnetName `
  -AddressPrefix 10.0.0.0/16 `
  -Subnet $AaddsSubnet,$WorkloadSubnet

$NSGName = "dsNSG"

# Create a rule to allow inbound TCP port 3389 traffic from Microsoft secure access workstations for troubleshooting
$nsg201 = New-AzNetworkSecurityRuleConfig -Name AllowRD `
    -Access Allow `
    -Protocol Tcp `
    -Direction Inbound `
    -Priority 201 `
    -SourceAddressPrefix CorpNetSaw `
    -SourcePortRange * `
    -DestinationAddressPrefix * `
    -DestinationPortRange 3389

# Create a rule to allow TCP port 5986 traffic for PowerShell remote management
$nsg301 = New-AzNetworkSecurityRuleConfig -Name AllowPSRemoting `
    -Access Allow `
    -Protocol Tcp `
    -Direction Inbound `
    -Priority 301 `
    -SourceAddressPrefix AzureActiveDirectoryDomainServices `
    -SourcePortRange * `
    -DestinationAddressPrefix * `
    -DestinationPortRange 5986

# Create the network security group and rules
$nsg = New-AzNetworkSecurityGroup -Name $NSGName `
    -ResourceGroupName $ResourceGroupName `
    -Location $AzureLocation `
    -SecurityRules $nsg201,$nsg301

# Get the existing virtual network resource objects and information
$vnet = Get-AzVirtualNetwork -Name $VnetName -ResourceGroupName $ResourceGroupName
$subnet = Get-AzVirtualNetworkSubnetConfig -VirtualNetwork $vnet -Name $SubnetName
$addressPrefix = $subnet.AddressPrefix

# Associate the network security group with the virtual network subnet
Set-AzVirtualNetworkSubnetConfig -Name $SubnetName `
    -VirtualNetwork $vnet `
    -AddressPrefix $addressPrefix `
    -NetworkSecurityGroup $nsg
$vnet | Set-AzVirtualNetwork

# Enable Microsoft Entra Domain Services for the directory.
$replicaSetParams = @{
  Location = $AzureLocation
  SubnetId = "/subscriptions/$AzureSubscriptionId/resourceGroups/$ResourceGroupName/providers/Microsoft.Network/virtualNetworks/$VnetName/subnets/DomainServices"
}
$replicaSet = New-AzADDomainServiceReplicaSetObject @replicaSetParams

$domainServiceParams = @{
  Name = $ManagedDomainName
  ResourceGroupName = $ResourceGroupName
  DomainName = $ManagedDomainName
  ReplicaSet = $replicaSet
}
New-AzADDomainService @domainServiceParams
```

It takes a few minutes to create the resource and return control to the PowerShell prompt. The managed domain continues to be provisioned in the background, and can take up to an hour to complete the deployment. In the Microsoft Entra admin center, the **Overview** page for your managed domain shows the current status throughout this deployment stage.

When the Microsoft Entra admin center shows that the managed domain has finished provisioning, the following tasks need to be completed:

* Update DNS settings for the virtual network so virtual machines can find the managed domain for domain join or authentication.
    * To configure DNS, select your managed domain in the portal. On the **Overview** window, you are prompted to automatically configure these DNS settings.
* [Enable password synchronization to Domain Services](tutorial-create-instance.md#enable-user-accounts-for-azure-ad-ds) so end users can sign in to the managed domain using their corporate credentials.

## Next steps

To see the managed domain in action, you can [domain-join a Windows VM][windows-join], [configure secure LDAP][tutorial-ldaps], and [configure password hash sync][tutorial-phs].

<!-- INTERNAL LINKS -->
[windows-join]: join-windows-vm.md

[tutorial-ldaps]: tutorial-configure-ldaps.md

[tutorial-phs]: tutorial-configure-password-hash-sync.md

[nsg-overview]: /azure/virtual-network/network-security-groups-overview

[network-ports]: network-considerations.md#network-security-groups-and-required-ports

<!-- EXTERNAL LINKS -->
[Connect-AzAccount]: /powershell/module/az.accounts/connect-azaccount

[Connect-MgGraph]: /powershell/microsoftgraph/authentication-commands#using-connect-mggraph

[New-MgServicePrincipal]: /powershell/module/microsoft.graph.applications/new-mgserviceprincipal

[New-MgGroup]: /powershell/module/microsoft.graph.groups/new-mggroup

[New-MgGroupMemberByRef]: /powershell/module/microsoft.graph.groups/new-mggroupmemberbyref

[Get-MgGroup]: /powershell/module/microsoft.graph.groups/get-mggroup

[Get-MgUser]: /powershell/module/microsoft.graph.users/get-mguser

[Register-AzResourceProvider]: /powershell/module/az.resources/register-azresourceprovider

[New-AzResourceGroup]: /powershell/module/az.resources/new-azresourcegroup

[New-AzVirtualNetworkSubnetConfig]: /powershell/module/az.network/new-azvirtualnetworksubnetconfig

[New-AzVirtualNetwork]: /powershell/module/az.network/new-azvirtualnetwork

[Get-AzSubscription]: /powershell/module/az.accounts/get-azsubscription

[cloud-shell]: /azure/active-directory/develop/configure-app-multi-instancing

[availability-zones]: /azure/reliability/availability-zones-overview

[New-AzNetworkSecurityRuleConfig]: /powershell/module/az.network/new-aznetworksecurityruleconfig

[New-AzNetworkSecurityGroup]: /powershell/module/az.network/new-aznetworksecuritygroup

[Set-AzVirtualNetworkSubnetConfig]: /powershell/module/az.network/set-azvirtualnetworksubnetconfig
