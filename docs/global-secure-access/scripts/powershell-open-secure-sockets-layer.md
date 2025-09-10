---
title: PowerShell Sample - Create a TLS Certificate Using OpenSSL
description: Use this PowerShell script to generate and sign Transport Layer Security (TLS) certificates using OpenSSL in a test environment.
author: HULKsmashGithub
ms.author: jayrusso
manager: dougeby
ms.service: global-secure-access
ms.topic: sample
ms.date: 09/09/2025
ms.reviewer: teresayao

#customer intent: As an admin, I want to automate the creation of TLS certificates using PowerShell so that I can streamline my testing process.

---

# Use PowerShell to create and sign TLS certificates using OpenSSL

This script automates generating and signing Transport Layer Security (TLS) certificates using OpenSSL. It creates a certificate signing request (CSR) using the TLS inspection graph API. The script creates a self-signed root certificate authority using OpenSSL, signs the CSR, and uploads the certificate and chain to TLS inspection settings.

## Prerequisites
- Install OpenSSL for Windows or Linux.

> [!NOTE]
> While other tools might be available for certificate management, this sample code in this article uses OpenSSL. OpenSSL is bundled with many Linux distributions, such as Ubuntu.

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
# Ensure Microsoft.Graph.Beta module is available

# Import Module

Import-Module Microsoft.Graph.Beta.NetworkAccess

# Connect to Microsoft Graph (handles token for you)
Connect-MgGraph -Scopes "NetworkAccess.ReadWrite.All" -NoWelcome

# Modify the following with your own settings before running the script:
# Parameters of the certificate sign request (letters and numbers only and within 12 characters).
    $name = "TLSiDemoCA"
    $commonName = "Contoso TLS Demo"
    $organizationName = "Contoso"

# Replace with your openSSLpath
    $openSSLPath = "C:\Program Files\OpenSSL-Win64\bin\openssl.exe"

# Self-signed CA file names
$rootKey = "TlsDemorootCA.key"
$rootCert = "TlsDemorootCAcert.pem"
$subject = "/C=US/ST=Washington/L=Redmond/O=Contoso/CN=Contoso"
$signedCert = "signedcertificate.pem"

#: Check if External Certificate Authority Certificates already exists
try {
    $response = Get-MgBetaNetworkAccessTlExternalCertificateAuthorityCertificate
    if ($response.Count -gt 0) {
        Write-Host "A certificate for TLS inspection already exists."
	exit 1
    } 
}
catch {
    Write-Error "The Graph SDK call failed: $($_.Exception.Message)"
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
} 
catch {
    Write-Error "Failed to create certificate signing request: $($_.Exception.Message)"
    Exit 1	
}
# Save CSR to file
$csr = $createResponse.CertificateSigningRequest
$csrPath = "$name.csr"
Set-Content -Path $csrPath -Value $csr
Write-Host "CSR saved to $csrPath"

# Save the certificate ID to upload later:
$externalCertificateAuthorityCertificateId = $createResponse.Id

# Create openssl.cnf with predefined profiles
$opensslCnfContent = @"
[ rootCA_ext ]
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid:always,issuer
basicConstraints = critical, CA:true
keyUsage = critical, digitalSignature, cRLSign, keyCertSign

[ interCA_ext ]
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid:always,issuer
basicConstraints = critical, CA:true, pathlen:1
keyUsage = critical, digitalSignature, cRLSign, keyCertSign

[ signedCA_ext ]
basicConstraints = critical, CA:true
keyUsage = critical, digitalSignature, cRLSign, keyCertSign
extendedKeyUsage = serverAuth

[ server_ext ]
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid:always,issuer
basicConstraints = critical, CA:false
keyUsage = critical, digitalSignature
extendedKeyUsage = serverAuth
"@

$opensslCnfPath = "openssl.cnf"

# Write content to openssl.cnf file
Set-Content -Path $opensslCnfPath -Value $opensslCnfContent -Encoding ASCII



# Generate Root CA private key and certificate. Note: You need to install the Root CA certificate in the trusted certificate store of testing users' devices.
Write-Host "Generating Root CA key and certificate..."
& $openSSLPath req -x509 -new -nodes -newkey rsa:4096 -keyout $rootKey -sha256 -days 370 -out $rootCert -subj $subject -config $opensslCnfPath -extensions rootCA_ext

# Sign CSR using Root CA
if (Test-Path $csrPath) {
    Write-Host "Signing CSR file $csrPath..."
    & $openSSLPath x509 -req -in $csrPath -CA $rootCert -CAkey $rootKey -CAcreateserial -out $signedCert -days 370 -sha256 -extfile $opensslCnfPath -extensions signedCA_ext
    Write-Host "Signed certificate saved to $signedCert"
} else {
    Write-Host "CSR file '$csrPath' not found. Please generate it first."
}

# Read certificate and chain
$paramsupload = @{
certificate = Get-Content -Path $SignedCert -Raw
chain       = Get-Content -Path $RootCert -Raw
}
# Upload using SDK cmdlet
Update-MgBetaNetworkAccessTlExternalCertificateAuthorityCertificate -ExternalCertificateAuthorityCertificateId $externalCertificateAuthorityCertificateId -BodyParameter $paramsupload

# Upload the signed certificate and its chain to Microsoft Graph using the SDK cmdlet.
# -ExternalCertificateAuthorityCertificateId: The unique ID of the certificate request previously created.
# -BodyParameter: A hashtable containing the PEM-encoded certificate and chain as required by the API.

try {Update-MgBetaNetworkAccessTlExternalCertificateAuthorityCertificate -ExternalCertificateAuthorityCertificateId $externalCertificateAuthorityCertificateId -BodyParameter $paramsupload
-ErrorAction Stop} catch {
Write-Error "Failed to upload certificate and chain: $($_.Exception.Message)"
exit 1
}

Write-Host "Upload complete via Microsoft Graph SDK."
```

## Related content
- [Configure Transport Layer Security inspection](../how-to-transport-layer-security.md)
- [Use PowerShell to generate and sign TLS certificates using Active Directory Certificate Services](powershell-active-directory-certificate-service.md)
