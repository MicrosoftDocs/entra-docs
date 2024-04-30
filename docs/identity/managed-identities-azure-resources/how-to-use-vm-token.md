---
title: Use managed identities on a virtual machine to acquire access token
description: Step-by-step instructions and examples for using managed identities for Azure resources on virtual machines to acquire an OAuth access token.

author: barclayn
manager: amycolannino

ms.service: entra-id
ms.subservice: managed-identities
ms.topic: how-to
ms.tgt_pltfrm: na
ms.custom: devx-track-dotnet, devx-track-extended-java
ms.date: 05/15/2023
ms.author: barclayn

---

# How to use managed identities for Azure resources on an Azure VM to acquire an access token 

[!INCLUDE [preview-notice](~/includes/entra-msi-preview-notice.md)]  

Managed identities for Azure resources provide Azure services with an automatically managed identity in Microsoft Entra ID. You can use this identity to authenticate to any service that supports Microsoft Entra authentication, without having credentials in your code. 

This article provides various code and script examples for token acquisition. It also contains guidance about handling token expiration and HTTP errors.

## Prerequisites

[!INCLUDE [msi-qs-configure-prereqs](~/includes/entra-msi-qs-configure-prereqs.md)]

If you plan to use the Azure PowerShell examples in this article, be sure to install the latest version of [Azure PowerShell](/powershell/azure/install-azure-powershell).


> [!IMPORTANT]
> - All sample code/script in this article assumes the client is running on a virtual machine with managed identities for Azure resources. Use the virtual machine "Connect" feature in the Azure portal, to remotely connect to your VM. For details on enabling managed identities for Azure resources on a VM, see [Configure managed identities for Azure resources on a VM using the Azure portal](qs-configure-portal-windows-vm.md), or one of the variant articles (using PowerShell, CLI, a template, or an Azure SDK). 

> [!IMPORTANT]
> - The security boundary of managed identities for Azure resources, is the resource where the identity is used. All code/scripts running on a virtual machine can request and retrieve tokens for any managed identities available on it. 

## Overview

A client application can request a managed identity [app-only access token](~/identity-platform/developer-glossary.md#access-token) to access a given resource. The token is [based on the managed identities for Azure resources service principal](overview.md#managed-identity-types). As such, there's no need for the client to obtain an access token under its own service principal. The token is suitable for use as a bearer token in
[service-to-service calls requiring client credentials](~/identity-platform/v2-oauth2-client-creds-grant-flow.md).

| Link | Description |
| -------------- | -------------------- |
| [Get a token using HTTP](#get-a-token-using-http) | Protocol details for managed identities for Azure resources token endpoint |
| [Get a token using Azure.Identity](#get-a-token-using-the-azure-identity-client-library) | Get a token using Azure.Identity library |
| [Get a token using the Microsoft.Azure.Services.AppAuthentication library for .NET](#get-a-token-using-the-microsoftazureservicesappauthentication-library-for-net) | Example of using the Microsoft.Azure.Services.AppAuthentication library from a .NET client
| [Get a token using C#](#get-a-token-using-c) | Example of using managed identities for Azure resources REST endpoint from a C# client |
| [Get a token using Java](#get-a-token-using-java) | Example of using managed identities for Azure resources REST endpoint from a Java client |
| [Get a token using Go](#get-a-token-using-go) | Example of using managed identities for Azure resources REST endpoint from a Go client |
| [Get a token using PowerShell](#get-a-token-using-powershell) | Example of using managed identities for Azure resources REST endpoint from a PowerShell client |
| [Get a token using CURL](#get-a-token-using-curl) | Example of using managed identities for Azure resources REST endpoint from a Bash/CURL client |
| Handling token caching | Guidance for handling expired access tokens |
| [Error handling](#error-handling) | Guidance for handling HTTP errors returned from the managed identities for Azure resources token endpoint |
| [Resource IDs for Azure services](#resource-ids-for-azure-services) | Where to get resource IDs for supported Azure services |

## Get a token using HTTP 

The fundamental interface for acquiring an access token is based on REST, making it accessible to any client application running on the VM that can make HTTP REST calls. This approach is similar to the Microsoft Entra programming model, except the client uses an endpoint on the virtual machine (vs a Microsoft Entra endpoint).

Sample request using the Azure Instance Metadata Service (IMDS) endpoint *(recommended)*:

```
GET 'http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https://management.azure.com/' HTTP/1.1 Metadata: true
```

| Element | Description |
| ------- | ----------- |
| `GET` | The HTTP verb, indicating you want to retrieve data from the endpoint. In this case, an OAuth access token. | 
| `http://169.254.169.254/metadata/identity/oauth2/token` | The managed identities for Azure resources endpoint for the Instance Metadata Service. |
| `api-version`  | A query string parameter, indicating the API version for the IMDS endpoint. Use API version `2018-02-01` or greater. |
| `resource` | A query string parameter, indicating the App ID URI of the target resource. It also appears in the `aud` (audience) claim of the issued token. This example requests a token to access Azure Resource Manager, which has an App ID URI of `https://management.azure.com/`. |
| `Metadata` | An HTTP request header field required by managed identities. This information is used as a mitigation against server side request forgery (SSRF) attacks. This value must be set to "true", in all lower case. |
| `object_id` | (Optional) A query string parameter, indicating the object_id of the managed identity you would like the token for. Required, if your VM has multiple user-assigned managed identities.|
| `client_id` | (Optional) A query string parameter, indicating the client_id of the managed identity you would like the token for. Required, if your VM has multiple user-assigned managed identities.|
| `msi_res_id` | (Optional) A query string parameter, indicating the msi_res_id (Azure Resource ID) of the managed identity you would like the token for. Required, if your VM has multiple user-assigned managed identities. |

Sample response:

```json
HTTP/1.1 200 OK
Content-Type: application/json
{
  "access_token": "eyJ0eXAi...",
  "refresh_token": "",
  "expires_in": "3599",
  "expires_on": "1506484173",
  "not_before": "1506480273",
  "resource": "https://management.azure.com/",
  "token_type": "Bearer"
}
```

| Element | Description |
| ------- | ----------- |
| `access_token` | The requested access token. When you call a secured REST API, the token is embedded in the `Authorization` request header field as a "bearer" token, allowing the API to authenticate the caller. | 
| `refresh_token` | Not used by managed identities for Azure resources. |
| `expires_in` | The number of seconds the access token continues to be valid, before expiring, from time of issuance. Time of issuance can be found in the token's `iat` claim. |
| `expires_on` | The timespan when the access token expires. The date is represented as the number of seconds from "1970-01-01T0:0:0Z UTC"  (corresponds to the token's `exp` claim). |
| `not_before` | The timespan when the access token takes effect, and can be accepted. The date is represented as the number of seconds from "1970-01-01T0:0:0Z UTC" (corresponds to the token's `nbf` claim). |
| `resource` | The resource the access token was requested for, which matches the `resource` query string parameter of the request. |
| `token_type` | The type of token, which is a "Bearer" access token, which means the resource can give access to the bearer of this token. |

## Get a token using the Azure identity client library

Using the Azure identity client library is the recommended way to use managed identities. All Azure SDKs are integrated with the ```Azure.Identity``` library that provides support for DefaultAzureCredential. This class makes it easy to use Managed Identities with Azure SDKs.[Learn more](/dotnet/api/overview/azure/identity-readme)

1. Install the [Azure.Identity](https://www.nuget.org/packages/Azure.Identity) package and other required [Azure SDK library packages](https://aka.ms/azsdk), such as [Azure.Security.KeyVault.Secrets](https://www.nuget.org/packages/Azure.Security.KeyVault.Secrets/).
2. Use the sample code below. You don't need to worry about getting tokens. You can directly use the Azure SDK clients. The code is for demonstrating how to get the token, if you need to.

    ```csharp
    using Azure.Core;
    using Azure.Identity;
    
    string userAssignedClientId = "<your managed identity client Id>";
    var credential = new DefaultAzureCredential(new DefaultAzureCredentialOptions { ManagedIdentityClientId = userAssignedClientId });
    var accessToken = credential.GetToken(new TokenRequestContext(new[] { "https://vault.azure.net" }));
    // To print the token, you can convert it to string 
    String accessTokenString = accessToken.Token.ToString();
    
    //You can use the credential object directly with Key Vault client.     
    var client = new SecretClient(new Uri("https://myvault.vault.azure.net/"), credential);
    ```

## Get a token using the Microsoft.Azure.Services.AppAuthentication library for .NET

For .NET applications and functions, the simplest way to work with managed identities for Azure resources is through the Microsoft.Azure.Services.AppAuthentication package. This library will also allow you to test your code locally on your development machine. You can test your code using your user account from Visual Studio, the [Azure CLI](/cli/azure/), or Active Directory Integrated Authentication. For more on local development options with this library, see the [Microsoft.Azure.Services.AppAuthentication reference](/dotnet/api/overview/azure/service-to-service-authentication). This section shows you how to get started with the library in your code.

1. Add references to the [Microsoft.Azure.Services.AppAuthentication](https://www.nuget.org/packages/Microsoft.Azure.Services.AppAuthentication) and [Microsoft.Azure.KeyVault](https://www.nuget.org/packages/Microsoft.Azure.KeyVault) NuGet packages to your application.

2.  Add the following code to your application:

    ```csharp
    using Microsoft.Azure.Services.AppAuthentication;
    using Microsoft.Azure.KeyVault;
    // ...
    var azureServiceTokenProvider = new AzureServiceTokenProvider();
    string accessToken = await azureServiceTokenProvider.GetAccessTokenAsync("https://management.azure.com/");
    // OR
    var kv = new KeyVaultClient(new KeyVaultClient.AuthenticationCallback(azureServiceTokenProvider.KeyVaultTokenCallback));
    ```
    
To learn more about Microsoft.Azure.Services.AppAuthentication and the operations it exposes, see the [Microsoft.Azure.Services.AppAuthentication reference](/dotnet/api/overview/azure/service-to-service-authentication) and the [App Service and KeyVault with managed identities for Azure resources .NET sample](https://github.com/Azure-Samples/app-service-msi-keyvault-dotnet).


## Get a token using C#


```csharp
using System;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Web.Script.Serialization; 

// Build request to acquire managed identities for Azure resources token
HttpWebRequest request = (HttpWebRequest)WebRequest.Create("http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https://management.azure.com/");
request.Headers["Metadata"] = "true";
request.Method = "GET";

try
{
    // Call /token endpoint
    HttpWebResponse response = (HttpWebResponse)request.GetResponse();

    // Pipe response Stream to a StreamReader, and extract access token
    StreamReader streamResponse = new StreamReader(response.GetResponseStream()); 
    string stringResponse = streamResponse.ReadToEnd();
    JavaScriptSerializer j = new JavaScriptSerializer();
    Dictionary<string, string> list = (Dictionary<string, string>) j.Deserialize(stringResponse, typeof(Dictionary<string, string>));
    string accessToken = list["access_token"];
}
catch (Exception e)
{
    string errorText = String.Format("{0} \n\n{1}", e.Message, e.InnerException != null ? e.InnerException.Message : "Acquire token failed");
}

```

## Get a token using Java

Use this [JSON library](https://mvnrepository.com/artifact/com.fasterxml.jackson.core/jackson-core/2.9.4) to retrieve a token using Java.

```Java
import java.io.*;
import java.net.*;
import com.fasterxml.jackson.core.*;
 
class GetMSIToken {
    public static void main(String[] args) throws Exception {
 
        URL msiEndpoint = new URL("http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https://management.azure.com/");
        HttpURLConnection con = (HttpURLConnection) msiEndpoint.openConnection();
        con.setRequestMethod("GET");
        con.setRequestProperty("Metadata", "true");
 
        if (con.getResponseCode()!=200) {
            throw new Exception("Error calling managed identity token endpoint.");
        }
 
        InputStream responseStream = con.getInputStream();
 
        JsonFactory factory = new JsonFactory();
        JsonParser parser = factory.createParser(responseStream);
 
        while(!parser.isClosed()){
            JsonToken jsonToken = parser.nextToken();
 
            if(JsonToken.FIELD_NAME.equals(jsonToken)){
                String fieldName = parser.getCurrentName();
                jsonToken = parser.nextToken();
 
                if("access_token".equals(fieldName)){
                    String accesstoken = parser.getValueAsString();
                    System.out.println("Access Token: " + accesstoken.substring(0,5)+ "..." + accesstoken.substring(accesstoken.length()-5));
                    return;
                }
            }
        }
    }
}
```

## Get a token using Go

```go
package main

import (
  "fmt"
  "io/ioutil"
  "net/http"
  "net/url"
  "encoding/json"
)

type responseJson struct {
  AccessToken string `json:"access_token"`
  RefreshToken string `json:"refresh_token"`
  ExpiresIn string `json:"expires_in"`
  ExpiresOn string `json:"expires_on"`
  NotBefore string `json:"not_before"`
  Resource string `json:"resource"`
  TokenType string `json:"token_type"`
}

func main() {
    
    // Create HTTP request for a managed services for Azure resources token to access Azure Resource Manager
    var msi_endpoint *url.URL
    msi_endpoint, err := url.Parse("http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01")
    if err != nil {
      fmt.Println("Error creating URL: ", err)
      return 
    }
    msi_parameters := msi_endpoint.Query()
    msi_parameters.Add("resource", "https://management.azure.com/")
    msi_endpoint.RawQuery = msi_parameters.Encode()
    req, err := http.NewRequest("GET", msi_endpoint.String(), nil)
    if err != nil {
      fmt.Println("Error creating HTTP request: ", err)
      return 
    }
    req.Header.Add("Metadata", "true")

    // Call managed services for Azure resources token endpoint
    client := &http.Client{}
    resp, err := client.Do(req) 
    if err != nil{
      fmt.Println("Error calling token endpoint: ", err)
      return
    }

    // Pull out response body
    responseBytes,err := ioutil.ReadAll(resp.Body)
    defer resp.Body.Close()
    if err != nil {
      fmt.Println("Error reading response body : ", err)
      return
    }

    // Unmarshall response body into struct
    var r responseJson
    err = json.Unmarshal(responseBytes, &r)
    if err != nil {
      fmt.Println("Error unmarshalling the response:", err)
      return
    }

    // Print HTTP response and marshalled response body elements to console
    fmt.Println("Response status:", resp.Status)
    fmt.Println("access_token: ", r.AccessToken)
    fmt.Println("refresh_token: ", r.RefreshToken)
    fmt.Println("expires_in: ", r.ExpiresIn)
    fmt.Println("expires_on: ", r.ExpiresOn)
    fmt.Println("not_before: ", r.NotBefore)
    fmt.Println("resource: ", r.Resource)
    fmt.Println("token_type: ", r.TokenType)
}
```

## Get a token using PowerShell

The following example demonstrates how to use the managed identities for Azure resources REST endpoint from a PowerShell client to:

1. Acquire an access token.
2. Use the access token to call an Azure Resource Manager REST API and get information about the VM. Be sure to substitute your subscription ID, resource group name, and virtual machine name for `<SUBSCRIPTION-ID>`, `<RESOURCE-GROUP>`, and `<VM-NAME>`, respectively.

```azurepowershell
Invoke-WebRequest -Uri 'http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https%3A%2F%2Fmanagement.azure.com%2F' -Headers @{Metadata="true"}
```

Example of how to parse the access token from the response:
```azurepowershell
# Get an access token for managed identities for Azure resources
$response = Invoke-WebRequest -Uri 'http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https%3A%2F%2Fmanagement.azure.com%2F' `
                              -Headers @{Metadata="true"}
$content =$response.Content | ConvertFrom-Json
$access_token = $content.access_token
echo "The managed identities for Azure resources access token is $access_token"

# Use the access token to get resource information for the VM
$vmInfoRest = (Invoke-WebRequest -Uri 'https://management.azure.com/subscriptions/<SUBSCRIPTION-ID>/resourceGroups/<RESOURCE-GROUP>/providers/Microsoft.Compute/virtualMachines/<VM-NAME>?api-version=2017-12-01' -Method GET -ContentType "application/json" -Headers @{ Authorization ="Bearer $access_token"}).content
echo "JSON returned from call to get VM info:"
echo $vmInfoRest

```

## Get a token using CURL

```bash
curl 'http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https%3A%2F%2Fmanagement.azure.com%2F' -H Metadata:true -s
```


Example of how to parse the access token from the response:

```bash
response=$(curl 'http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https%3A%2F%2Fmanagement.azure.com%2F' -H Metadata:true -s)
access_token=$(echo $response | python -c 'import sys, json; print (json.load(sys.stdin)["access_token"])')
echo The managed identities for Azure resources access token is $access_token
```

## Token caching

The managed identities subsystem caches tokens but we still recommend that you implement token caching in your code.
You should prepare for scenarios where the resource indicates that the token is expired.

On-the-wire calls to Microsoft Entra ID result only when:

- Cache miss occurs due to no token in the managed identities for Azure resources subsystem cache.
- The cached token is expired.

## Error handling

The managed identities endpoint signals errors via the status code field of the HTTP response message header, as either 4xx or 5xx errors:

| Status Code | Error Reason | How To Handle |
| ----------- | ------------ | ------------- |
| 404 Not found. | IMDS endpoint is updating. | Retry with Exponential Backoff. See guidance below. |
| 410  | IMDS is going through updates |  IMDS will be available within 70 seconds |
| 429 Too many requests. |  IMDS Throttle limit reached. | Retry with Exponential Backoff. See guidance below. |
| 4xx Error in request. | One or more of the request parameters was incorrect. | Don't retry.  Examine the error details for more information.  4xx errors are design-time errors.|
| 5xx Transient error from service. | The managed identities for Azure resources subsystem or Microsoft Entra ID returned a transient error. | It's safe to retry after waiting for at least 1 second.  If you retry too quickly or too often, IMDS and/or Microsoft Entra ID may return a rate limit error (429).|
| timeout | IMDS endpoint is updating. | Retry with Exponential Backoff. See guidance below. |

If an error occurs, the corresponding HTTP response body contains JSON with the error details:

| Element | Description |
| ------- | ----------- |
| error   | Error identifier. |
| error_description | Verbose description of error. **Error descriptions can change at any time. Do not write code that branches based on values in the error description.**|

### HTTP response reference

This section documents the possible error responses. A "200 OK" status is a successful response, and the access token is contained in the response body JSON, in the access_token element.

| Status code | Error | Error Description | Solution |
| ----------- | ----- | ----------------- | -------- |
| 400 Bad Request | invalid_resource | AADSTS50001: The application named *\<URI\>* wasn't found in the tenant named *\<TENANT-ID\>*. This message shows if the tenant administrator hasn't installed the application or no tenant user consented to it. You might have sent your authentication request to the wrong tenant.\ | (Linux only) |
| 400 Bad Request | bad_request_102 | Required metadata header not specified | Either the `Metadata` request header field is missing from your request, or is formatted incorrectly. The value must be specified as `true`, in all lower case. See the "Sample request" in the preceding REST section for an example.|
| 401 Unauthorized | unknown_source | Unknown Source *\<URI\>* | Verify that your HTTP GET request URI is formatted correctly. The `scheme:host/resource-path` portion must be specified as `http://localhost:50342/oauth2/token`. See the "Sample request" in the preceding REST section for an example.|
|           | invalid_request | The request is missing a required parameter, includes an invalid parameter value, includes a parameter more than once, or is otherwise malformed. |  |
|           | unauthorized_client | The client isn't authorized to request an access token using this method. | Caused by a request on a VM that doesn't have managed identities for Azure resources configured correctly. See [Configure managed identities for Azure resources on a VM using the Azure portal](qs-configure-portal-windows-vm.md) if you need assistance with VM configuration. |
|           | access_denied | The resource owner or authorization server denied the request. |  |
|           | unsupported_response_type | The authorization server doesn't support obtaining an access token using this method. |  |
|           | invalid_scope | The requested scope is invalid, unknown, or malformed. |  |
| 500 Internal server error | unknown | Failed to retrieve token from the Active directory. For details see logs in *\<file path\>* | Verify that the VM has managed identities for Azure resources enabled. See [Configure managed identities for Azure resources on a VM using the Azure portal](qs-configure-portal-windows-vm.md) if you need assistance with VM configuration.<br><br>Also verify that your HTTP GET request URI is formatted correctly, particularly the resource URI specified in the query string. See the "Sample request" in the preceding REST section for an example, or [Azure services that support Microsoft Entra authentication](./managed-identities-status.md) for a list of services and their respective resource IDs.

> [!IMPORTANT]
> - IMDS is not intended to be used behind a proxy and doing so is unsupported. For examples of how to bypass proxies, refer to the [Azure Instance Metadata Samples](https://github.com/microsoft/azureimds).  

## Retry guidance 

It's recommended to retry if you receive a 404, 429, or 5xx error code (see [Error handling](#error-handling) above). If you receive a 410 error, it indicates that IMDS is going through updates and will be available in a maximum of 70 seconds.  

Throttling limits apply to the number of calls made to the IMDS endpoint. When the throttling threshold is exceeded, IMDS endpoint limits any further requests while the throttle is in effect. During this period, the IMDS endpoint returns the HTTP status code 429 ("Too many requests"), and the requests fail. 

For retry, we recommend the following strategy: 

| **Retry strategy** | **Settings** | **Values** | **How it works** |
| --- | --- | --- | --- |
|ExponentialBackoff |Retry count<br />Min back-off<br />Max back-off<br />Delta back-off<br />First fast retry |5<br />0 sec<br />60 sec<br />2 sec<br />false |Attempt 1 - delay 0 sec<br />Attempt 2 - delay ~2 sec<br />Attempt 3 - delay ~6 sec<br />Attempt 4 - delay ~14 sec<br />Attempt 5 - delay ~30 sec |

## Resource IDs for Azure services

See [Azure Services with managed identities support](managed-identities-status.md) for a list of resources that support managed identities for Azure resources.


## Next steps

- To enable managed identities for Azure resources on an Azure VM, see [Configure managed identities for Azure resources on a VM using the Azure portal](qs-configure-portal-windows-vm.md).
