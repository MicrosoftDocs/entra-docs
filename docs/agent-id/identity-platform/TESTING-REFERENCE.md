# Quick Reference: Agent Identity Concepts for Testing

This is a simplified explanation of what you're testing so you can verify the documentation is accurate.

## The Core Workflow (What You're Testing)

```
1. Create Blueprint → 2. Add Credential → 3. Get Token → 4. Create Agent
```

## Key Concepts (Just Enough to Test)

### Blueprint (create-blueprint.md)
- **What it is**: A template/factory for creating agent identities
- **Why it exists**: So you can create many agents with the same security settings
- **What you're testing**: That you can create it and add a managed identity credential

### Managed Identity Credential
- **What it is**: A special credential that only works on Azure services (no passwords to manage)
- **Why it matters**: This is the recommended production approach (more secure than client secrets)
- **What you're testing**: That you can add it to the blueprint and use it to get tokens

### Blueprint Principal
- **What it is**: The "active" version of the blueprint in your tenant
- **Why it exists**: The blueprint app is just a definition; the principal can actually do things
- **What you're testing**: That creating it works after you create the blueprint

### Agent Identity (create-delete-agent-identities.md)
- **What it is**: The actual identity representing one AI agent
- **Why it exists**: Each AI agent gets its own identity for authentication
- **What you're testing**: That you can create it using the blueprint's token

## The Token Flow (This is the Tricky Part)

When you use managed identity, there's a two-step token exchange:

```
Step 1: Get MI Token
Your VM → Azure Managed Identity Service → MI Token

Step 2: Exchange for Blueprint Token  
MI Token → Microsoft Entra → Blueprint Token

Step 3: Use Blueprint Token
Blueprint Token → Microsoft Graph → Create Agent
```

**Why two tokens?** Security. The managed identity proves "I'm running on Azure", then you exchange that for a blueprint token that proves "I'm authorized to create agents."

## Commands You'll Run (High Level)

### From create-blueprint.md:
1. `Connect-MgGraph` - Connect to Microsoft Graph
2. `Invoke-MgGraphRequest` - Create the blueprint
3. `Invoke-MgGraphRequest` - Create the principal
4. `Invoke-MgGraphRequest` - Add managed identity as credential

### From create-delete-agent-identities.md:
1. `Invoke-RestMethod` - Get managed identity token (only works on Azure)
2. `Invoke-RestMethod` - Exchange for blueprint token
3. `Invoke-RestMethod` - Create agent identity

## Testing Checklist

### Before You Start:
- [ ] You're on an Azure VM (not local machine)
- [ ] You have the VM's managed identity ID
- [ ] You have PowerShell 7 installed
- [ ] You have Microsoft Graph modules installed

### While Testing Blueprint Article:
- [ ] Commands run without errors
- [ ] You get a blueprint app ID back
- [ ] Principal creation succeeds
- [ ] Managed identity credential is added

### While Testing Agent Identity Article:
- [ ] Managed identity token acquisition works (proves you're on Azure)
- [ ] Token exchange works (proves the credential is configured correctly)
- [ ] Agent creation works (proves the whole flow is good)

## Common Issues You Might Hit

| Issue | What It Means | Fix |
|-------|---------------|-----|
| "Cannot connect to 169.254.169.254" | Not on Azure service | Must run from Azure VM |
| "Federated credential not found" | Credential not configured yet | Complete blueprint article first |
| "Invalid client assertion" | Wrong managed identity ID | Verify you copied the right Object ID from VM Identity |
| "Insufficient privileges" | Don't have required permissions | Check you have Agent ID Developer or Admin role |

## What Success Looks Like

After running both articles' commands, you should have:
- ✓ A blueprint visible in Entra admin center
- ✓ A blueprint principal (service principal type)
- ✓ A federated credential configured on the blueprint
- ✓ At least one agent identity created
- ✓ All JSON responses showing success (no error messages)

## Files Created for You

1. **TESTING-SETUP.md** - Step-by-step Azure VM setup
2. **test-agent-flow.ps1** - Automated script that runs everything
3. **This file** - Quick reference for concepts

## Next Steps

1. Follow [TESTING-SETUP.md](TESTING-SETUP.md) to create your Azure VM
2. Connect to the VM via RDP
3. Run [test-agent-flow.ps1](test-agent-flow.ps1) to test the full flow
4. OR manually follow along with the articles using the script as reference
5. Document any issues or unclear steps you find
