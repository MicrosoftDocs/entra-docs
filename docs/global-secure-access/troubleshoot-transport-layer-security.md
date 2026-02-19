---
title: Troubleshoot Transport Layer Security inspection errors
description: "Learn how to troubleshoot and resolve Transport Layer Security (TLS) inspection errors in Global Secure Access."
author: HULKsmashGithub
ms.author: jayrusso
ms.topic: troubleshooting-known-issue
ms.reviewer: teresayao
ms.date: 11/07/2025
ai-usage: ai-assisted

#customer intent: As an IT admin, I want to troubleshoot Transport Layer Security (TLS) inspection errors.

---

# Troubleshoot Global Secure Access Transport Layer Security inspection errors
This article explains common troubleshooting scenarios when deploying a Transport Layer Security (TLS) inspection policy.

## Certificate problem: unable to get the local issuer certificate
This error occurs because developer tools like Git and Python don't use the operating system's certificate store by default. Instead, they maintain their own certificate stores and don't recognize the TLS inspection certificate.

### Troubleshooting for Git
You can direct Git to use Windows' certificate store:

`git config --global http.sslbackend schannel`

Alternatively, you can append a custom TLS inspection root certificate to Git's Certificate Authority bundle so Git trusts your internal certificate authority.

```PowerShell
$certPath = "./myTLSInspectionRootCA.crt"
$gitCAPath = git config --get http.sslcainfo
if ($gitCAPath) {
    Get-Content $certPath | Add-Content -Path $gitCAPath
    Write-Host "Certificate appended to Git CA bundle"
} else {
    Write-Host "Git CA bundle path not found"
}
```

### Troubleshooting for Python
Python-based tools, such as Azure CLI, fail without the correct certificate authority. You can install `pip-system-certs` so Python trusts the Windows certificate store:

#### Azure CLI

```powershell
"C:\Program Files\Microsoft SDKs\Azure\CLI2\python.exe" -m pip install pip-system-certs
```

#### System Python

```bash
python -m pip install pip-system-certs
```

Alternatively, you can append a custom TLS inspection root certificate to Python’s CA bundle so Python trusts your internal certificate authority.

```powershell
$certPath = "./myTLSInspectionRootCA.crt"
$pythonCertPath = python -c "import certifi; print(certifi.where())"
Get-Content $certPath | Add-Content -Path $pythonCertPath
Write-Host "Certificate appended to Python's CA bundle"
```

### Troubleshooting for Docker
Docker containers might fail TLS connections when the TLS inspection certificate isn't trusted. Add your certificate to Docker's trusted certificates list by adding these commands to your Dockerfile:

#### Debian or Ubuntu-based images

```dockerfile
COPY myTLSInspectionRootCA.crt /usr/local/share/ca-certificates/
RUN update-ca-certificates
```

#### Alpine-based images

```dockerfile
COPY myTLSInspectionRootCA.crt /usr/local/share/ca-certificates/
RUN apk update && apk add ca-certificates && update-ca-certificates
```

## Applications don't work on mobile platforms
Mobile applications might fail when TLS inspection is enabled due to certificate pinning, which restricts applications to trust only specific certificates.

### Troubleshooting steps
Create a TLS bypass rule to exclude the application's destination FQDNs from TLS inspection. For detailed steps, see [Configure Transport Layer Security inspection policies](how-to-transport-layer-security.md).

## An internal certificate already exists
For preview customers with a legacy TLS configuration, when creating a Certificate Signing Request (CSR), you might see this error: `Cannot create external certificate, an internal certificate already exists for tenant.`

### Troubleshooting steps
To resolve this issue: 
1. Sign in to the Microsoft Entra admin center with [custom TLS inspection settings](https://aka.ms/tlspreview-portal) as a [Global Secure Access Administrator](/azure/active-directory/roles/permissions-reference#global-secure-access-administrator).
1. Browse to **Global Secure Access** > **Settings** > **Session management**.
1. Select the **TLS Inspection** tab. 
1. Select and delete the Certificate URL.
1. Select **Save**.

## Related content

- [Configure Transport Layer Security inspection policies](how-to-transport-layer-security.md)
- [Configure Transport Layer Security inspection settings](how-to-transport-layer-security-settings.md)
- [Frequently asked questions for Transport Layer Security inspection](faq-transport-layer-security.yml)
- [What is Transport Layer Security inspection?](concept-transport-layer-security.md)
