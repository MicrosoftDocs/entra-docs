---
title: Starter code for authentication events trigger for Azure Functions client library in C#
description: include file
author: cilwerner
manager: CelesteDG
ms.service: identity-platform
ms.topic: include
ms.date: 02/27/2024
ms.author: cwerner
ms.reviewer: stsoneff
ms.custom: include file
---

```csharp
    using System;
        using System.Threading.Tasks;
        using Microsoft.AspNetCore.Mvc;
        using Microsoft.Azure.WebJobs;
        using Microsoft.Extensions.Logging;
        using Microsoft.Azure.WebJobs.Extensions.AuthenticationEvents.TokenIssuanceStart.Actions;
        using Microsoft.Azure.WebJobs.Extensions.AuthenticationEvents.TokenIssuanceStart;
        using Microsoft.Azure.WebJobs.Extensions.AuthenticationEvents.Framework;
        using Microsoft.Azure.WebJobs.Extensions.AuthenticationEvents;
        
        namespace AuthEventTrigger
        {
            public static class Function1
            {
                [FunctionName("onTokenIssuanceStart")]
                public static async Task<AuthenticationEventResponse> Run(
                    [AuthenticationEventsTrigger] TokenIssuanceStartRequest request, ILogger log)
                // [AuthenticationEventsTrigger(TenantId = "Enter tenant ID here", AudienceAppId = "Enter application client ID here")] TokenIssuanceStartRequest request, ILogger log)
                // This is required. The only way that [AuthenticationEventsTrigger] TokenIssuanceStartRequest request, ILogger log) will work is if the settings are set in local.settings.json are set to bypass token validation. i.e. "AuthenticationEvents__BypassTokenValidation": true. This is only recommended for local development and testing.
                {
                    try
                    {
                        // Checks if the request is successful and did the token validation pass
                        if (request.RequestStatus == RequestStatusType.Successful)
                        {
                            // Fetches information about the user from external data store
                            // request.Response = null;
                            // request.Response.Actions = null;
                            // Add new claims to the token's response
                            request.Response.Actions.Add(new ProvideClaimsForToken(
                                                          new TokenClaim("dateOfBirth", "01/01/2000"),
                                                          new TokenClaim("customRoles", "Writer", "Editor"),
                                                          new TokenClaim("apiVersion", "1.0.0"),
                                                          new TokenClaim("correlationId", request.Data.AuthenticationContext.CorrelationId.ToString())
                                                     ));
                        }
                        else
                        {
                            // If the request fails, such as in token validation, output the failed request status
                            log.LogInformation(request.StatusMessage);
                        }
                        return await request.Completed();
                    }
                    catch (Exception ex) 
                    { 
                        return await request.Failed(ex);
                    }
                }
            }
        }
```