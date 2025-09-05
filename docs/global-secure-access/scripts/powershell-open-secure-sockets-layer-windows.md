---
title: PowerShell sample - Generate and Sign TLS Certificates Using OpenSSL on Windows
description: Use this PowerShell script to generate and sign Transport Layer Security (TLS) certificates using OpenSSL on Windows in a test environment.
author: HULKsmashGithub
ms.author: jayrusso
manager: dougeby
ms.service: global-secure-access
ms.topic: sample
ms.date: 09/05/2025
ms.reviewer: teresayao

#customer intent: As an admin, I want to automate the creation of TLS certificates using PowerShell so that I can streamline my testing process.

---

# Use PowerShell to generate and sign TLS certificates using OpenSSL on Windows

This script automates generating and signing Transport Layer Security (TLS) certificates using OpenSSL on Windows. It creates a certificate signing request (CSR), submits it to OpenSSL for signing, and retrieves the signed certificate.

## Generate and sign TLS certificates

```powershell
# Make sure you run: Install-Module Microsoft.Graph.Beta -AllowClobber -Force
# Ensure Microsoft.Graph.Beta module is available
# Import Module

Import-Module Microsoft.Graph.Beta.NetworkAccess

# Connect to Microsoft Graph (handles token for you)
Connect-MgGraph -Scopes "NetworkAccess.ReadWrite.All" -NoWelcome

# Modify the following with your setting before running the script:
    $name = "TLSiCAName"
    $commonName = "TLS Demo Common Name"
    $organizationName = "TLS Demo Org Name"
    $openSSLPath = "C:\Program Files\OpenSSL-Win64\bin\openssl.exe"

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

# Create the Certificate Sign Request (CSR)

$paramscsr = @{
	"@odata.type" = "#microsoft.graph.networkaccess.externalCertificateAuthorityCertificate"
	name = $name
	commonName =  $commonName
	organizationName = $organizationName
}

$createResponse =New-MgBetaNetworkAccessTlExternalCertificateAuthorityCertificate -BodyParameter $paramscsr
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

# Define file names
$rootKey = "TlsDemorootCA.key"
$rootCert = "TlsDemorootCAcert.pem"
$subject = "/C=US/ST=Washington/L=Redmond/O=NaasLitware/CN=NaasLitware"
$signedCert = "signedcertificate.pem"

#Generate Root CA private key and certificate, note you need to install rootCA certificate on the trusted certificate store of testing users' devices
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

Write-Host "Upload complete via Microsoft Graph SDK."
```

## Related content
- [Configure Transport Layer Security inspection](../how-to-transport-layer-security.md)
- [Use PowerShell to generate and sign TLS certificates using Active Directory Certificate Services](powershell-active-directory-certificate-service.md)
