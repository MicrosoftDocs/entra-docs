---
title: PowerShell sample - Generate and Sign TLS Certificates Using Active Directory Certificate Services
description: Use this PowerShell script to generate and sign TLS certificates using Active Directory Certificate Services in a test environment.
author: HULKsmashGithub
ms.author: jayrusso
manager: dougeby
ms.service: global-secure-access
ms.topic: sample
ms.date: 09/05/2025
ms.reviewer: teresayao

#customer intent: As an admin, I want to automate the creation of TLS certificates using PowerShell so that I can streamline my testing process.

---

# Use PowerShell to generate and sign TLS certificates using Active Directory Certificate Services

This script automates generating and signing Transport Layer Security (TLS) certificates using Active Directory Certificate Services (ADCS). It creates a certificate signing request (CSR), submits it to ADCS for signing, and retrieves the signed certificate.

## Generate and sign TLS certificates

```powershell
# This script requires the following:
#    - PowerShell 5.1 (x64) or later
#    - Module: Microsoft.Graph.Beta
##
# Before you begin:
#    
# - Make sure you are running PowerShell as an administrator
# - Make sure you run: Install-Module Microsoft.Graph.Beta -AllowClobber -Force
# - Make sure you have ADCS configured with a SubCA template and you have "<CAHostName>\<CACommonName>"
# Ensure Microsoft.Graph.Beta module is available
# Import Module

Import-Module Microsoft.Graph.Beta.NetworkAccess

# Connect to Microsoft Graph (handles token for you)
Connect-MgGraph -Scopes "NetworkAccess.ReadWrite.All" -NoWelcome

# Modify the following with your settings before running the script:
# Name of the certificate
$name = "TLSiCAName"
# Common Name (CN) for the certificate
$commonName = "TLS Demo"
# Organization Name (O) for the certificate
$organizationName = "Contoso"
#ADCS settings
# Make sure you have ADCS configured with a SubCA template and you have "<CAHostName>\<CACommonName>"
$Template = "SubCA"
$CAConfig="ADCSTLSDemo.tlsvalidation.local\tlsvalidation-ADCSTLSDemo-CA"

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

# Create the Certificate Signing Request (CSR)

$paramscsr = @{
	"@odata.type" = "#microsoft.graph.networkaccess.externalCertificateAuthorityCertificate"
	name = $name
	commonName =  $commonName
	organizationName = $organizationName
}
$createResponse = $null
try {
    $createResponse = New-MgBetaNetworkAccessTlExternalCertificateAuthorityCertificate -BodyParameter $paramscsr
} catch {
    Write-Error "Failed to create certificate signing request: $($_.Exception.Message)"
    exit 1
}

# Save CSR to file
$csr = $createResponse.CertificateSigningRequest
$CsrPath = "$name.csr"
Set-Content -Path $CsrPath -Value $csr -Encoding ascii
Write-Host "CSR saved to $CsrPath"

# Save the Certificate Id for upload later:
$certId = $createResponse.Id  # The unique identifier of the created certificate, used for uploading the signed certificate and chain


# Define file names
$signedCert = "TlsDemoCert.pem"
$chainContent = "TlsDemoCertChain.pem"

#ADCS sign CSR using SubCA template
#Submit CSR for signing and get Request ID
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

#Retrieve certificate in pem and chain in p7b format
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
#   Example:
#   $paramsupload = @{
#       certificate = "<PEM encoded certificate string>"
#       chain       = "<PEM encoded certificate chain string>"
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
- [Use PowerShell to generate and sign TLS certificates using OpenSSL on Windows](powershell-open-secure-sockets-layer-windows.md)
