# Agent Identity Testing Script
# Run this script FROM your Azure VM (not locally)
# This script walks through creating a blueprint and agent identity using managed identity

# ============================================================================
# PART 1: SETUP AND CONTEXT
# ============================================================================

Write-Host "=== Agent Identity Testing Script ===" -ForegroundColor Cyan
Write-Host "This script helps you test the managed identity flow for agent blueprints" -ForegroundColor Yellow
Write-Host ""

# Check if running on Azure (has access to managed identity endpoint)
Write-Host "Checking if running on Azure service..." -ForegroundColor Cyan
try {
    $testMI = Invoke-RestMethod -Uri 'http://169.254.169.254/metadata/identity/oauth2/token?api-version=2019-08-01&resource=https://management.azure.com' -Headers @{Metadata="true"} -TimeoutSec 5
    Write-Host "✓ Running on Azure - Managed Identity available!" -ForegroundColor Green
} catch {
    Write-Host "✗ NOT running on Azure - Managed Identity NOT available" -ForegroundColor Red
    Write-Host "You must run this script from an Azure VM or Azure service" -ForegroundColor Red
    exit
}

# ============================================================================
# PART 2: GATHER REQUIRED INFORMATION
# ============================================================================

Write-Host "`n=== Gathering Required Information ===" -ForegroundColor Cyan

# Get tenant ID
$tenantId = Read-Host "Enter your tenant ID"

# Get managed identity principal ID
Write-Host "`nTo get your VM's managed identity principal ID:" -ForegroundColor Yellow
Write-Host "  1. Go to Azure Portal > Your VM > Identity" -ForegroundColor Yellow
Write-Host "  2. Copy the 'Object (principal) ID'" -ForegroundColor Yellow
$managedIdentityId = Read-Host "Enter your managed identity Object (principal) ID"

# ============================================================================
# PART 3: CONNECT AND CREATE BLUEPRINT
# ============================================================================

Write-Host "`n=== Creating Agent Identity Blueprint ===" -ForegroundColor Cyan

# Connect to Microsoft Graph
Write-Host "Connecting to Microsoft Graph..." -ForegroundColor Cyan
Connect-MgGraph -Scopes "AgentIdentityBlueprint.Create","User.Read","AgentIdentityBlueprintPrincipal.Create","AgentIdentityBlueprint.AddRemoveCreds.All" -TenantId $tenantId

# Get current user
$currentUser = Get-MgContext | Select-Object -ExpandProperty Account
$user = Get-MgUser -UserId $currentUser
Write-Host "✓ Connected as: $($user.DisplayName) ($($user.Id))" -ForegroundColor Green

# Create the blueprint
Write-Host "`nCreating agent identity blueprint..." -ForegroundColor Cyan
$blueprintBody = @{
    "@odata.type" = "Microsoft.Graph.AgentIdentityBlueprint"
    "displayName" = "Test Agent Blueprint $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
    "sponsors@odata.bind" = @("https://graph.microsoft.com/v1.0/users/$($user.Id)")
    "owners@odata.bind" = @("https://graph.microsoft.com/v1.0/users/$($user.Id)")
} | ConvertTo-Json -Depth 5

$blueprint = Invoke-MgGraphRequest `
    -Method POST `
    -Uri "https://graph.microsoft.com/beta/applications/graph.agentIdentityBlueprint" `
    -Body $blueprintBody `
    -ContentType "application/json"

$blueprintId = $blueprint.id
$blueprintAppId = $blueprint.appId

Write-Host "✓ Blueprint created!" -ForegroundColor Green
Write-Host "  Blueprint ID: $blueprintId" -ForegroundColor White
Write-Host "  Blueprint App ID: $blueprintAppId" -ForegroundColor White

# ============================================================================
# PART 4: CREATE BLUEPRINT PRINCIPAL
# ============================================================================

Write-Host "`n=== Creating Blueprint Principal ===" -ForegroundColor Cyan

$principalBody = @{
    appId = $blueprintAppId
} | ConvertTo-Json

$principal = Invoke-MgGraphRequest `
    -Method POST `
    -Uri "https://graph.microsoft.com/beta/serviceprincipals/graph.agentIdentityBlueprintPrincipal" `
    -Headers @{ "OData-Version" = "4.0" } `
    -Body $principalBody

Write-Host "✓ Blueprint principal created!" -ForegroundColor Green
Write-Host "  Principal ID: $($principal.id)" -ForegroundColor White

# ============================================================================
# PART 5: ADD MANAGED IDENTITY CREDENTIAL
# ============================================================================

Write-Host "`n=== Adding Managed Identity as Credential ===" -ForegroundColor Cyan

$ficBody = @{
    name = "vm-managed-identity"
    issuer = "https://login.microsoftonline.com/$tenantId/v2.0"
    subject = $managedIdentityId
    audiences = @("api://AzureADTokenExchange")
} | ConvertTo-Json

$fic = Invoke-MgGraphRequest `
    -Method POST `
    -Uri "https://graph.microsoft.com/beta/applications/$blueprintId/federatedIdentityCredentials" `
    -Body $ficBody `
    -ContentType "application/json"

Write-Host "✓ Managed identity credential added!" -ForegroundColor Green

# ============================================================================
# PART 6: TEST TOKEN ACQUISITION (This is the magic part!)
# ============================================================================

Write-Host "`n=== Testing Token Acquisition ===" -ForegroundColor Cyan

# Step 1: Get managed identity token
Write-Host "Getting managed identity token..." -ForegroundColor Cyan
$miTokenResponse = Invoke-RestMethod `
    -Uri "http://169.254.169.254/metadata/identity/oauth2/token?api-version=2019-08-01&resource=api://AzureADTokenExchange" `
    -Headers @{Metadata="true"}

$miToken = $miTokenResponse.access_token
Write-Host "✓ Got managed identity token!" -ForegroundColor Green

# Step 2: Exchange for blueprint token
Write-Host "Exchanging for blueprint token..." -ForegroundColor Cyan
$tokenBody = @{
    client_id = $blueprintAppId
    scope = "https://graph.microsoft.com/.default"
    client_assertion_type = "urn:ietf:params:oauth:client-assertion-type:jwt-bearer"
    client_assertion = $miToken
    grant_type = "client_credentials"
}

$blueprintTokenResponse = Invoke-RestMethod `
    -Method POST `
    -Uri "https://login.microsoftonline.com/$tenantId/oauth2/v2.0/token" `
    -Body $tokenBody `
    -ContentType "application/x-www-form-urlencoded"

$blueprintToken = $blueprintTokenResponse.access_token
Write-Host "✓ Got blueprint token!" -ForegroundColor Green

# ============================================================================
# PART 7: CREATE AGENT IDENTITY
# ============================================================================

Write-Host "`n=== Creating Agent Identity ===" -ForegroundColor Cyan

$agentBody = @{
    displayName = "Test Agent $(Get-Date -Format 'HH:mm:ss')"
    agentIdentityBlueprintId = $blueprintAppId
    "sponsors@odata.bind" = @("https://graph.microsoft.com/v1.0/users/$($user.Id)")
} | ConvertTo-Json

$agent = Invoke-RestMethod `
    -Method POST `
    -Uri "https://graph.microsoft.com/beta/serviceprincipals/Microsoft.Graph.AgentIdentity" `
    -Headers @{
        "Authorization" = "Bearer $blueprintToken"
        "Content-Type" = "application/json"
        "OData-Version" = "4.0"
    } `
    -Body $agentBody

Write-Host "✓ Agent identity created!" -ForegroundColor Green
Write-Host "  Agent Display Name: $($agent.displayName)" -ForegroundColor White
Write-Host "  Agent ID: $($agent.id)" -ForegroundColor White
Write-Host "  Agent App ID: $($agent.appId)" -ForegroundColor White

# ============================================================================
# SUMMARY
# ============================================================================

Write-Host "`n=== Testing Complete! ===" -ForegroundColor Green
Write-Host "You successfully:" -ForegroundColor Green
Write-Host "  ✓ Created an agent identity blueprint" -ForegroundColor Green
Write-Host "  ✓ Created a blueprint principal" -ForegroundColor Green
Write-Host "  ✓ Added managed identity as credential" -ForegroundColor Green
Write-Host "  ✓ Acquired tokens using managed identity" -ForegroundColor Green
Write-Host "  ✓ Created an agent identity" -ForegroundColor Green

Write-Host "`nKey Values to Save:" -ForegroundColor Yellow
Write-Host "  Blueprint App ID: $blueprintAppId" -ForegroundColor White
Write-Host "  Agent App ID: $($agent.appId)" -ForegroundColor White

# Optional: Export to file for reference
$summary = @{
    TenantId = $tenantId
    ManagedIdentityId = $managedIdentityId
    BlueprintId = $blueprintId
    BlueprintAppId = $blueprintAppId
    AgentId = $agent.id
    AgentAppId = $agent.appId
    CreatedAt = Get-Date
}

$summary | ConvertTo-Json | Out-File "agent-test-results.json"
Write-Host "`nResults saved to: agent-test-results.json" -ForegroundColor Cyan
