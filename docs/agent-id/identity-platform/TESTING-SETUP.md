# Testing Setup for Agent Identity Articles

This guide helps you set up an Azure environment to test the managed identity credential flow for agent identity blueprints.

## Why You Need This

The managed identity (FIC) credential method in [create-blueprint.md](create-blueprint.md) requires your code to run on an Azure service. This setup gives you a simple Azure VM where you can:
1. Create a blueprint with managed identity credentials
2. Get tokens using that managed identity
3. Create agent identities using the blueprint

## Option 1: Azure VM (Recommended for Full Testing)

### Create a Windows VM with Managed Identity

1. **In Azure Portal**, create a new VM:
   - Go to portal.azure.com > Virtual Machines > Create
   - Choose Windows Server 2022 Datacenter
   - Size: Standard_B2s (cheap, sufficient for testing)
   - Enable **System assigned managed identity** under the Management tab
   
2. **Note the Managed Identity Details**:
   - After VM is created, go to VM > Identity
   - Copy the **Object (principal) ID** - this is your managed identity ID
   - This is what you'll use in the blueprint article as `<managed-identity-principal-id>`

3. **Connect to the VM**:
   - Use RDP (download the RDP file from Azure Portal)
   - Install PowerShell 7: 
     ```powershell
     winget install Microsoft.PowerShell
     ```

### Install Required Modules on the VM

```powershell
# Install Microsoft Graph PowerShell modules
Install-Module Microsoft.Graph -Scope CurrentUser -Force
Install-Module Microsoft.Graph.Beta.Applications -Scope CurrentUser -Force
```

### Testing Workflow

Now you can follow both articles from the VM:

1. **From [create-blueprint.md](create-blueprint.md)**:
   - Run all the PowerShell commands to create the blueprint
   - When you get to "Configure credentials", use the managed identity approach
   - Use the Object (principal) ID you copied earlier as the `<managed-identity-principal-id>`

2. **From [create-delete-agent-identities.md](create-delete-agent-identities.md)**:
   - The VM's managed identity can now request tokens
   - You can test the token flow using the Microsoft Graph API tab examples

## Option 2: Azure Cloud Shell (Quick but Limited)

If you just want to test PowerShell commands quickly without a full VM:

1. Go to portal.azure.com and click the Cloud Shell icon (>_)
2. Choose PowerShell
3. Cloud Shell has a built-in managed identity, but it's more limited for this scenario

**Note**: Cloud Shell is good for running commands but harder to test the full managed identity token flow.

## Testing the Managed Identity Token Flow

Once on your Azure VM, you can test getting a managed identity token:

```powershell
# This only works from Azure services (like your VM)
$response = Invoke-RestMethod -Uri 'http://169.254.169.254/metadata/identity/oauth2/token?api-version=2019-08-01&resource=https://graph.microsoft.com' -Headers @{Metadata="true"}
$token = $response.access_token
Write-Host "Got managed identity token!"
```

This is the foundation for the token exchange flow in the agent identities article.

## Cost Considerations

- **VM cost**: ~$30-40/month if running 24/7
- **Tip**: Stop (deallocate) the VM when not testing to avoid charges
- **Alternative**: Delete the VM after testing is complete

## Quick Checklist

- [ ] VM created with system-assigned managed identity
- [ ] Copied the managed identity Object (principal) ID  
- [ ] Connected to VM via RDP
- [ ] Installed PowerShell 7 on VM
- [ ] Installed Microsoft Graph modules
- [ ] Ready to test blueprint creation
- [ ] Ready to test token acquisition

## Next Steps

1. Open [create-blueprint.md](create-blueprint.md) on your VM
2. Follow the steps to create a blueprint
3. When configuring credentials, use your VM's managed identity
4. Move to [create-delete-agent-identities.md](create-delete-agent-identities.md) to test agent creation
