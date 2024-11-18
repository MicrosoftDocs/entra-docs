---
title: "How to use Continuous Access Evaluation enabled APIs in your applications"
description: Increase app security and resilience by adding support for Continuous Access Evaluation, enabling long-lived access tokens that can be revoked based on critical events and policy evaluation.
author: OwenRichards1
manager: CelesteDG
ms.author: owenrichards
ms.date: 11/18/2024
ms.reviewer: iambmelt
ms.service: identity-platform

ms.topic: concept-article
#Customer intent: As an application developer, I want to learn how to use Continuous Access Evaluation for building resiliency through long-lived, refreshable tokens that can be revoked based on critical events and policy evaluation.
---
# How to use Continuous Access Evaluation enabled APIs in your applications

[Continuous Access Evaluation (CAE)](~/identity/conditional-access/concept-continuous-access-evaluation.md) is a Microsoft Entra feature that allows access tokens to be revoked based on [critical events](~/identity/conditional-access/concept-continuous-access-evaluation.md#critical-event-evaluation) and [policy evaluation](~/identity/conditional-access/concept-continuous-access-evaluation.md#conditional-access-policy-evaluation) rather than relying on token expiry based on lifetime. For some resource APIs, because risk and policy are evaluated in real time, this can increase token lifetime up to 28 hours. These long-lived tokens are proactively refreshed by the Microsoft Authentication Library (MSAL), increasing the resiliency of your applications.

This article shows you how to use CAE-enabled APIs in your applications. Applications not using MSAL can add support for [claims challenges, claims requests, and client capabilities](claims-challenge.md) to use CAE.

## Implementation considerations

To use CAE, both your app and the resource API it's accessing must be CAE-enabled. However, preparing your code to use a CAE enabled resource won't prevent you from using APIs that aren't CAE enabled.

If a resource API implements CAE and your application declares it can handle CAE, your app receives CAE tokens for that resource. For this reason, if you declare your app CAE ready, your application must handle the CAE claim challenge for all resource APIs that accept Microsoft Identity access tokens. If you don't handle CAE responses in these API calls, your app could end up in a loop retrying an API call with a token that is still in the returned lifespan of the token but has been revoked due to CAE.

## Handling CAE in your application

The first step is to add code to handle a response from the resource API rejecting the call due to CAE. With CAE, APIs will return a 401 status and a WWW-Authenticate header when the access token has been revoked or the API detects a change in IP address used. The WWW-Authenticate header contains a Claims Challenge that the application can use to acquire a new access token.

For example:

```console
// Line breaks for legibility only

HTTP 401; Unauthorized

Bearer authorization_uri="https://login.windows.net/common/oauth2/authorize",
  error="insufficient_claims",
  claims="eyJhY2Nlc3NfdG9rZW4iOnsibmJmIjp7ImVzc2VudGlhbCI6dHJ1ZSwgInZhbHVlIjoiMTYwNDEwNjY1MSJ9fX0="
```

Your app would check for:

- the API call returning the 401 status
- the existence of a WWW-Authenticate header containing:
  - an "error" parameter with the value "insufficient_claims"
  - a "claims" parameter

## [OneAuth-MSAL](#tab/OneAuth-MSAL)

### Declare support for the CP1 Client Capability

OneAuth/MSAL supports 2 ways of declaring capabilities, to apps of any size/scale/complexity. While we recommend setting them at the app-wide level, some complex applications (like Office), may have a mix of components that support CAE and others that don't, in which case you should opt for setting capabilities on a per-call basis. NOTE: Capabilities will be de-duped before requests are sent to the server, so there's no harm in setting a capability twice.

App-wide To declare your entire app supports a capability like CAE, add it to the (optional) capabilities vector in your app's AADConfiguration object:

```csharp
static Microsoft::Authentication::AadConfiguration AadConfig(
    Microsoft::Authentication::UUID::FromString("d3590ed6-52b3-4102-aeff-aad2292ab01c"), //Client ID
    "urn:ietf:wg:oauth:2.0:oob", //Redirect URI
    "https://officeapps.live.com", //Default Sign in resource 
    {"CP1"} //Capabilities
    ); 
```

Per-call to declare that a specific call supports a capability like CAE, add it to the (optional) capabilities vector in your call's AuthenticationParameters object:

```csharp
AuthParameters::CreateForBearer(
        "https://login.microsoftonline.com/organizations", //Authority
        "https://officeapps.live.com", //Target
        "", //AccessTokenToRenew
        "", //Claims
        {"CP1"}, //Capabilities (for this call)
        {} //AdditionalParameters
        );
```

### Use OneAuth's claims challenge parser

While your app is welcome to parse the 401 challenge itself, and insert the base64-decoded claims string into the claims parameter of the AuthParams object for a given call (see above codeblock), OneAuth has a built in challenge parsing util which will take the 401 claims challenge headers, parse/decode them, and return an AuthParams object that contains all the details from the challenge.
    
    ```csharp
    auto result = OneAuthPrivate::ParseAuthenticationHeaders(
        mapOfChallengeHeaders, //Headers
        "https://microsoft.sharepoint.com", //Target
        {"CP1", "CP2"}, //Capabilities
        "", //HttpMethod
        "", //UriPath
        "" //UriHost
        );
    ```

### Apple platform

Advertise the `CP1` client capability:

```swift
MALAppConfiguration *appConfiguration =
    [[MALAppConfiguration alloc] initWithApplicationId:@"com.contoso.appbundle"
                                               appName:@"contoso"
                                            appVersion:[MALOneAuthVersion oneAuthVersion]
                                          languageCode:[[NSLocale currentLocale] localeIdentifier]];

// Add OneAuth auth configuration, in capabilities, CP1 needs to be added to declare the application is CAE capable
NSUUID *aadClientId = [[NSUUID alloc] initWithUUIDString:@"contoso-app-ABCDE-12345"];
MALAadConfiguration *aadConfiguration =
    [[MALAadConfiguration alloc] initWithClientId:aadClientId
                                      redirectUri:@"msauth.com.contoso.appbundle://auth"
                            defaultSignInResource:@"https://graph.contoso.com"
                                     capabilities:@[@"CP1"]];

MALAuthenticatorConfiguration *config =
    [[MALAuthenticatorConfiguration alloc] initWithAppConfiguration:appConfiguration
                                                   aadConfiguration:aadConfiguration
                                                   msaConfiguration:nil
                                            onPremisesConfiguration:nil
                                             telemetryConfiguration:nil];
[MALOneAuth startup:config];
```

Parse WWW-Authenticate headers from HTTP 401 responses and try a silent request, falling back to an interactive one if the silent request fails



When these conditions are met, the app can extract the claims challenge from the API response header as follows:
    
```swift
// NSURLResponse response = ...; // Request not shown

if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    NSInteger statusCode = httpResponse.statusCode;
    // Check the response code...
    if (200 == statusCode) {
        // ...
    } else if (401 == statusCode) {
        // Extract and log all headers
        NSDictionary *headers = httpResponse.allHeaderFields;
        // parse WWW-Authenticate header
        NSDictionary *wwwAuthenticateHeader = [self parsewwwAuthenticateHeader:headers];
        if (!wwwAuthenticateHeader)
        {
            // if no WWW-Authenticate header, handle gracefully
            return;
        }
        else
        {
            // acquireTokenSilentlyWithClaim with insufficient_claims
            [self acquireTokenSilentlyWithClaim:wwwAuthenticateHeader[@"claims"] account:account];
        }
    }
}

- (nullable NSDictionary *)parsewwwAuthenticateHeader:(NSDictionary *)wwwAuthenticateHeaderObjc {
    
    // No native Objective-C API to do the parse form OneAuth. you can do either of the following:
    // 1st option Call OneAuth public API in Objective cpp code to do the parsing (This sample)
    // 2nd option Write your own logic to get the claims
    
    std::vector<std::pair<std::string, std::string>> wwwAuthenticateHeader;
    for (id key in wwwAuthenticateHeaderObjc) {
        // Convert key and value to std::string
        NSString *keyString = [key description];
        NSString *valueString = [[wwwAuthenticateHeaderObjc objectForKey:key] description];
        
        // Add the pair to the vector
        wwwAuthenticateHeader.emplace_back([keyString UTF8String], [valueString UTF8String]);
    }
    
    auto vector =  Microsoft::Authentication::OneAuth::ParseAuthChallenges(wwwAuthenticateHeader);
    NSMutableArray *array = [NSMutableArray array];
    for (const auto& map : vector) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        
        for (const auto& pair : map) {
            NSString *key = [NSString stringWithUTF8String:pair.first.c_str()];
            NSString *value = [NSString stringWithUTF8String:pair.second.c_str()];
            [dict setObject:value forKey:key];
        }
        
        [array addObject:dict];
    }
    
    if (array.count == 1)
    {
        return array.firstObject;
    }
    else
    {
        // handle gracefully
        return nil;
    }
}

- (void)acquireTokenSilentlyWithClaim:(NSString *)claim account:(MALAccount *)account
{
    // Create auth oarams
    MALAuthParameters *params = [MALAuthParameters authParametersWithAuthScheme:MALAuthSchemeBearer
                                                                      authority:[account authority]
                                                                         target:@"https://graph.microsoft.com/"
                                                             accessTokenToRenew:@""
                                                                         claims:claim
                                                                   capabilities:nil
                                                           additionalParameters:nil];
    
    MALTelemetryParameters *telemetryParameters =
        [MALTelemetryParameters telemetryParametersWithCorrelationId:[NSUUID UUID]];
    
    // get authResult with acquireCredentialSilentlyForAccount API
    [[MALOneAuth getAuthenticator] acquireCredentialSilentlyForAccount:account parameters:params telemetryParameters:telemetryParameters completion:^(MALAuthResult * _Nonnull authResult) {
        // If successful - your business logic goes here...
        // else try to call signInInteractively
        
        [[MALOneAuth getAuthenticator] signInInteractivelyWithUxContextHandle:MALDefaultUxContext accountHint:account.loginName authParameters:nil behaviorParameters:nil telemetryParameters:telemetryParameters completion:^(MALAuthResult * _Nonnull authResult) {
            // handle new result
        }];
    }];
}
```

You can test your application by signing in a user to the application then using the Azure portal to revoke the user's sessions. The next time the app calls the CAE enabled API, the user will be asked to reauthenticate.

## [.NET](#tab/dotnet)

When these conditions are met, the app can extract and decode the claims challenge using MSAL.NET `WwwAuthenticateParameters` class.

```csharp
if (APIresponse.IsSuccessStatusCode)
{
    // ...
}
else
{
    if (APIresponse.StatusCode == System.Net.HttpStatusCode.Unauthorized
        && APIresponse.Headers.WwwAuthenticate.Any())
    {
        string claimChallenge = WwwAuthenticateParameters.GetClaimChallengeFromResponseHeaders(APIresponse.Headers);
```

Your app would then use the claims challenge to acquire a new access token for the resource.

```csharp
try
{
    authResult = await _clientApp.AcquireTokenSilent(scopes, firstAccount)
        .WithClaims(claimChallenge)
        .ExecuteAsync()
        .ConfigureAwait(false);
}
catch (MsalUiRequiredException)
{
    try
    {
        authResult = await _clientApp.AcquireTokenInteractive(scopes)
            .WithClaims(claimChallenge)
            .WithAccount(firstAccount)
            .ExecuteAsync()
            .ConfigureAwait(false);
    }
    // ...
```

Once your application is ready to handle the claim challenge returned by a CAE enabled resource, you can tell Microsoft Identity your app is CAE ready. To do this in your MSAL application, build your Public Client using the Client Capabilities of "cp1".

```csharp
_clientApp = PublicClientApplicationBuilder.Create(App.ClientId)
    .WithDefaultRedirectUri()
    .WithAuthority(authority)
    .WithClientCapabilities(new [] {"cp1"})
    .Build();
```

You can test your application by signing in a user to the application then using the Azure portal to revoke the user's sessions. The next time the app calls the CAE enabled API, the user will be asked to reauthenticate.

## [JavaScript](#tab/JavaScript)

When these conditions are met, the app can extract the claims challenge from the API response header as follows: 

```javascript
try {
  const response = await fetch(apiEndpoint, options);

  if (response.status === 401 && response.headers.get('www-authenticate')) {
    const authenticateHeader = response.headers.get('www-authenticate');
    const claimsChallenge = parseChallenges(authenticateHeader).claims;
    
    // use the claims challenge to acquire a new access token...
  }
} catch(error) {
  // ...
}

// helper function to parse the www-authenticate header
function parseChallenges(header) {
    const schemeSeparator = header.indexOf(' ');
    const challenges = header.substring(schemeSeparator + 1).split(',');
    const challengeMap = {};

    challenges.forEach((challenge) => {
        const [key, value] = challenge.split('=');
        challengeMap[key.trim()] = window.decodeURI(value.replace(/['"]+/g, ''));
    });

    return challengeMap;
}
```

Your app would then use the claims challenge to acquire a new access token for the resource.

```javascript
const tokenRequest = {
    claims: window.atob(claimsChallenge), // decode the base64 string
    scopes: ['User.Read'],
    account: msalInstance.getActiveAccount()
};

let tokenResponse;

try {
    tokenResponse = await msalInstance.acquireTokenSilent(tokenRequest);
} catch (error) {
     if (error instanceof InteractionRequiredAuthError) {
        tokenResponse = await msalInstance.acquireTokenPopup(tokenRequest);
    }
}
```

Once your application is ready to handle the claim challenge returned by a CAE-enabled resource, you can tell Microsoft Identity your app is CAE-ready by adding a `clientCapabilities` property in the MSAL configuration.

```javascript
const msalConfig = {
    auth: {
        clientId: 'Enter_the_Application_Id_Here', 
        clientCapabilities: ["CP1"]
        // remaining settings...
    }
}

const msalInstance = new PublicClientApplication(msalConfig);
```

You can test your application by signing in a user to the application then using the Azure portal to revoke the user's sessions. The next time the app calls the CAE enabled API, the user will be asked to reauthenticate.

## [MSAL-Python](#tab/Python)

```Python
import msal  # pip install msal
import requests  # pip install requests
import www_authenticate  # pip install www-authenticate==0.9.2

# Once your application is ready to handle the claim challenge returned by a CAE enabled resource, you can tell Microsoft Identity your app is CAE ready. To do this in your MSAL application, build your Public Client using the Client Capabilities of "cp1".
app = msal.PublicClientApplication("your_client_id", client_capabilities=["cp1"])

...

# When these conditions are met, the app can extract the claims challenge from the API response header as follows:
response = requests.get("https://httpbin.org/status/401")
if response.status_code == 401 and response.headers.get('WWW-Authenticate'):
    parsed = www_authenticate.parse(response.headers['WWW-Authenticate'])
    claims = parsed.get("bearer", {}).get("claims")

    # Your app would then use the claims challenge to acquire a new access token for the resource.
    if claims:
        auth_result = app.acquire_token_interactive(["scope"], claims_challenge=claims)
```

You can test your application by signing in a user to the application then using the Azure portal to revoke the user's sessions. The next time the app calls the CAE enabled API, the user will be asked to reauthenticate.

## [MSAL-Android](#tab/Java)

### Declare support for the CP1 Client Capability

In your application configuration, you must declare that your application supports CAE by including the `CP1` client capability. This is specified by using the `client_capabilities` JSON property.

```java
{
  "client_id" : "<your_client_id>",
  "authorization_user_agent" : "DEFAULT",
  "redirect_uri" : "msauth://<pkg>/<cert_hash>",
  "multiple_clouds_supported":true,
  "broker_redirect_uri_registered": true,
  "account_mode": "MULTIPLE",
  "client_capabilities": "CP1",
  "authorities" : [
    {
      "type": "AAD",
      "audience": {
        "type": "AzureADandPersonalMicrosoftAccount"
      }
    }
  ]
}
```

### Respond to CAE Challenges at Runtime

Make a request to a resource, if the response contains a claims challenge, extract it, and feed it back into MSAL for use in the next request.

```java
final HttpURLConnection connection = ...;
final int responseCode = connection.getResponseCode();

// Check the response code...
if (200 == responseCode) {
    // ...
} else if (401 == responseCode) {
    final String authHeader = connection.getHeaderField("WWW-Authenticate");

    if (null != authHeader) {
        final ClaimsRequest claimsRequest = WWWAuthenticateHeader
                                                .getClaimsRequestFromWWWAuthenticateHeaderValue(authHeader);

        // Feed the challenge back into MSAL, first silently, then interactively if required
        final AcquireTokenSilentParameters silentParameters = new AcquireTokenSilentParameters.Builder()
            .fromAuthority(authority)
            .forAccount(account)
            .withScopes(scope)
            .withClaims(claimsRequest)
            .build();
        
        try {
            final IAuthenticationResult silentRequestResult = mPublicClientApplication.acquireTokenSilent(silentParameters);
            // If successful - your business logic goes here...

        } catch (final Exception e) {
            if (e instanceof MsalUiRequiredException) {
                // Retry the request interactively, passing in any claims challenge...
            }
        }
    }
} else {
    // ...
}

// Don't forget to close your connection
```

You can test your application by signing in a user to the application then using the Azure portal to revoke the user's sessions. The next time the app calls the CAE enabled API, the user will be asked to reauthenticate.

## [MSAL-ObjC](#tab/ObjC)

The below code sample describes the flow of getting token silently -> make http call to resource provider -> handling CAE case. An extra interaction call maybe required in the end if the silent call failed with claims.

### Declare support for CP1 client capability

In your application configuration, you must declare that your application supports CAE by including the `CP1` client capability. This is specified by using the `clientCapabilities` property.

```objc
let clientConfigurations = MSALPublicClientApplicationConfig(clientId: "contoso-app-ABCDE-12345",
                                                            redirectUri: "msauth.com.contoso.appbundle://auth",
                                                            authority: try MSALAuthority(url: URL(string: "https://login.microsoftonline.com/organizations")!))
clientConfigurations.clientApplicationCapabilities = ["CP1"]
let applicationContext = try MSALPublicClientApplication(configuration: clientConfigurations)
```

Implement a helper function for parsing claims challenges (example shown below)

```objc
func parsewwwAuthenticateHeader(headers:Dictionary<AnyHashable, Any>) -> String? {
    // !! This is a sample code and is not validated, please provide your own implementation or fully test the sample code provided here.
    // Can also refer here for our internal implementation: https://github.com/AzureAD/microsoft-authentication-library-common-for-objc/blob/dev/IdentityCore/src/webview/embeddedWebview/challangeHandlers/MSIDPKeyAuthHandler.m#L112
    guard let wwwAuthenticateHeader = headers["WWW-Authenticate"] as? String else {
        // did not find the header, handle gracefully
        return nil
    }
    
    var parameters = [String: String]()
    // regex mapping
    let regex = try! NSRegularExpression(pattern: #"(\w+)="([^"]*)""#)
    let matches = regex.matches(in: wwwAuthenticateHeader, range: NSRange(wwwAuthenticateHeader.startIndex..., in: wwwAuthenticateHeader))
    
    for match in matches {
        if let keyRange = Range(match.range(at: 1), in: wwwAuthenticateHeader),
           let valueRange = Range(match.range(at: 2), in: wwwAuthenticateHeader) {
            let key = String(wwwAuthenticateHeader[keyRange])
            let value = String(wwwAuthenticateHeader[valueRange])
            parameters[key] = value
        }
    }
    
    guard let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) else {
        // cannot convert params into json date, end gracefully
        return nil
    }
    return String(data: jsonData, encoding: .utf8)
}
```

Catch & parse 401 / claims challenges

```objc
let response = .... // HTTPURLResponse object from 401'd service response

switch response.statusCode {
case 200:
    // ...succeeded!
    break
case 401:
    let headers = response.allHeaderFields

    // Parse header fields
    guard let wwwAuthenticateHeaderString = self.parsewwwAuthenticateHeader(headers: headers) else {
        // 3.7 no valid wwwAuthenticateHeaderString is returned from header, end gracefully
        return
    }
    
    let claimsRequest = MSALClaimsRequest(jsonString: wwwAuthenticateHeaderString, error: nil)
    // Create claims request
    let parameters = MSALSilentTokenParameters(scopes: "Enter_the_Protected_API_Scopes_Here", account: account)
    parameters.claimsRequest = claimsRequest
    // Acquire token silently again with the claims challenge
    applicationContext.acquireTokenSilent(with: parameters) { (result, error) in
        
        if let error = error {
            // error happened end flow gracefully, and handle error. (e.g. interaction required)
            return
        }
        
        guard let result = result else {
            
            // no result end flow gracefully
            return
        }                    
        // Success - You got a token!
    }
    
    break
default:
    break
}
```
You can test your application by signing in a user to the application then using the Azure portal to revoke the user's sessions. The next time the app calls the CAE enabled API, the user will be asked to reauthenticate.

## [MSAL-Go](#tab/Go)

Advertise client capabilities:

```Go
client, err := New("client-id", WithAuthority(authority), WithClientCapabilities([]string{"cp1"}))
```

Parse the claims challenge

```Go
// No snippet provided
```

Attempt to acquire a token silently with the claims challenge
    
```Go
var ar AuthResult;
ar, err := client.AcquireTokenSilent(ctx, tokenScope, public.WithClaims(claims))
```

You can test your application by signing in a user to the application then using the Azure portal to revoke the user's sessions. The next time the app calls the CAE enabled API, the user will be asked to reauthenticate.

---

You can test your application by signing in a user and then using the Azure portal to revoke the user's session. The next time the app calls the CAE-enabled API, the user will be asked to reauthenticate.

## Code samples

* [Enable your Angular single-page application to sign in users and call Microsoft Graph](https://github.com/Azure-Samples/ms-identity-docs-code-javascript/tree/main/angular-spa)
* [Enable your React single-page application to sign in users and call Microsoft Graph](https://github.com/Azure-Samples/ms-identity-javascript-react-tutorial/tree/main/2-Authorization-I/1-call-graph)
* [Enable your ASP.NET Core web app to sign in users and call Microsoft Graph](https://github.com/Azure-Samples/active-directory-aspnetcore-webapp-openidconnect-v2/tree/master/2-WebApp-graph-user/2-1-Call-MSGraph)

## Related content

* [Continuous access evaluation](~/identity/conditional-access/concept-continuous-access-evaluation.md) conceptual overview
* [Claims challenges, claims requests, and client capabilities](claims-challenge.md)
