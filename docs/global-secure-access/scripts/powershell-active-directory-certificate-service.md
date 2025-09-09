---
title: PowerShell sample - Create a TLS Certificate Using Active Directory Certificate Services
description: Use this PowerShell script to create a TLS certificate using Active Directory Certificate Services (ADCS) in a test environment.
author: HULKsmashGithub
ms.author: jayrusso
manager: dougeby
ms.service: global-secure-access
ms.topic: sample
ms.date: 09/09/2025
ms.reviewer: teresayao

#customer intent: As an admin, I want to automate the creation of TLS certificates using PowerShell so that I can streamline my testing process.

---

# Use PowerShell to generate and sign TLS certificates using Active Directory Certificate Services

This script automates generating and signing Transport Layer Security (TLS) certificates using Active Directory Certificate Services (ADCS). It creates a certificate signing request (CSR) using the TLS inspection graph API. The script then submits the certificate to ADCS for signing, retrieves the signed certificate, and uploads the certificate and chain to TLS inspection settings.

## Generate and sign TLS certificates

```powershell
# This script requires the following:
#    - PowerShell 5.1 (x64) or later
#    - Module: Microsoft.Graph.Beta
#
# Before you begin:
#    
# - Make sure you're running PowerShell as an administrator
# - Make sure you run: Install-Module Microsoft.Graph.Beta -AllowClobber -Force
# - Make sure you have ADCS configured with a SubCA template and you have "<CAHostName>\<CACommonName>"
# Ensure Microsoft.Graph.Beta module is available

# Import module

Import-Module Microsoft.Graph.Beta.NetworkAccess

# Connect to Microsoft Graph (handles token for you)
Connect-MgGraph -Scopes "NetworkAccess.ReadWrite.All" -NoWelcome

# Modify the following with your own settings before running the script:
# Name of the certificate (letters and numbers only and within 12 characters)
$name = "TLSiCAName"
# Common Name (CN) for the certificate
$commonName = "Contoso TLS Demo"
# Organization Name (O) for the certificate
$organizationName = "Contoso"
#ADCS settings
# Make sure you have ADCS configured with a SubCA template and you have "<CAHostName>\<CACommonName>"
$Template = "SubCA"
$CAConfig="<CACommonName> of your ADCS server"

# Check if the External Certificate Authority Certificates already exists
try {
    $response = Get-MgBetaNetworkAccessTlExternalCertificateAuthorityCertificate
    if ($response.Count -gt 0) 
    {
     Write-Host "A certificate for TLS inspection already exists."
	 exit 1
    } 
}
catch {
    Write-Error "Graph SDK call to check on the list of certificates failed: $($_.Exception.Message)"
}

# Create the certificate signing request (CSR)

$paramscsr = @{
	"@odata.type" = "#microsoft.graph.networkaccess.externalCertificateAuthorityCertificate"
	name = $name
	commonName =  $commonName
	organizationName = $organizationName
}
$createResponse = $null
try {
    $createResponse = New-MgBetaNetworkAccessTlExternalCertificateAuthorityCertificate -BodyParameter $paramscsr -ErrorAction Stop
} catch {
    Write-Error "Failed to create certificate signing request: $($_.Exception.Message)"
    exit 1
}

# Save CSR to file
$csr = $createResponse.CertificateSigningRequest
$CsrPath = "$name.csr"
Set-Content -Path $CsrPath -Value $csr -Encoding ascii
Write-Host "CSR saved to $CsrPath"

# The unique identifier of the created certificate, used for uploading the signed certificate and chain
$certId = $createResponse.Id

# Certificate and chain file names
$signedCert = "TlsDemoCert.pem"
$chainContent = "TlsDemoCertChain.pem"

# Submit CSR to ADCS to sign, using subordinate CA template, retrieve Request ID
$submitOutput = certreq -submit -attrib "CertificateTemplate:$Template" -config $CAConfig $CsrPath $signedCert
if (-not (Test-Path $signedCert)) {
    Write-Error "Certificate was not issued. Check CA or template permissions."
    exit 1
}
Write-Host "Certificate issued and saved to $signedCert"

# Extract Request ID from output
$requestId = ($submitOutput | Select-String -Pattern 'RequestId:\s*(\d+)' | ForEach-Object { 
    if ($_.Matches.Count -gt 0) { $_.Matches[0].Groups[1].Value }
})
if (-not $requestId) {
    Write-Error "Could not determine Request ID from certreq output."
    exit 1
}
Write-Host "Request ID: $requestId"

# Retrieve certificate in pem and chain in p7b format
$tempP7B ="tempchain.p7b"
$tempPem ="tempcert.pem"
Write-Host "Retrieving full certificate chain..."
certreq -retrieve -config $CAConfig $requestId $tempPem $tempP7B 
if (-not (Test-Path $tempP7B )) {
    Write-Error "Failed to retrieve certificate chain."
    exit 1
}
# Read the .p7b file as bytes
$p7bBytes = [System.IO.File]::ReadAllBytes($tempP7B)
# Create a certificate collection and import the .p7b content
$certCollection = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2Collection
$certCollection.Import($p7bBytes)
# Sort certificates from intermediate to root (based on Issuer/Subject)
# Initialize PEM block array
$pemBlocks = @()
# Loop through each certificate and convert to PEM format
foreach ($cert in $certCollection) {
    $base64 = [System.Convert]::ToBase64String($cert.RawData, 'InsertLineBreaks')
    $pem = "-----BEGIN CERTIFICATE-----`n$base64`n-----END CERTIFICATE-----"
    $pemBlocks += $pem
}
# Save all PEM blocks to a single file
$pemBlocks -join "`n" | Set-Content -Path $chainContent -Encoding ascii
Write-Host "Certificate chain saved to $chainContent"

# Read certificate and chain
if (-not (Test-Path $tempPem) -or ((Get-Content -Path $tempPem -Raw).Trim().Length -eq 0)) {
    Write-Error "The certificate file $tempPem does not exist or is empty. Aborting upload."
    exit 1
}
$paramsupload = @{
certificate = Get-Content -Path $tempPem -Raw
chain       = Get-Content -Path $chainContent -Raw
}
# Upload the signed certificate and its chain to Microsoft Graph using the SDK cmdlet.
# -ExternalCertificateAuthorityCertificateId: The unique ID of the certificate request previously created.
# -BodyParameter: A hashtable containing the PEM-encoded certificate and chain as required by the API.
#   }

try {
    Update-MgBetaNetworkAccessTlExternalCertificateAuthorityCertificate -ExternalCertificateAuthorityCertificateId $certId -BodyParameter $paramsupload
} catch {
    Write-Error "Failed to upload certificate and chain: $($_.Exception.Message)"
    exit 1
}
Write-Host "Your TLS certificate is created and uploaded successfully."

# Delete temp files other than the signed certificate and chain.
Remove-Item $CsrPath, $tempP7B, $tempPem -ErrorAction SilentlyContinue
```

## Related content
- [Configure Transport Layer Security inspection](../how-to-transport-layer-security.md)
- [Use PowerShell to generate and sign TLS certificates using OpenSSL](powershell-open-secure-sockets-layer.md)
