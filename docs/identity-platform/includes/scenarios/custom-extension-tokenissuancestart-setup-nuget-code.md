---
title: Starter code for authentication events trigger for Azure Functions client library in C#
description: Code snippet for a custom authentication extension using the Azure Functions client library in C#.
author: cilwerner
manager: CelesteDG
ms.service: identity-platform
ms.topic: include
ms.date: 02/27/2024
ms.author: cwerner
ms.reviewer: stsoneff
ms.custom:
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
        public static AuthenticationEventResponse Run(
        // [AuthenticationEventsTrigger] TokenIssuanceStartRequest request, ILogger log)
        // The AuthenticationEventsTrigger attribute can be used to specify and audience app ID, authority URL and authorized party app id. This is an alternative route to setting up Authorization values instead of Environment variables or EzAuth
            [AuthenticationEventsTrigger(AudienceAppId = "Enter custom authentication extension app ID here",
                                         AuthorityUrl = "Enter authority URI here", 
                                         AuthorizedPartyAppId = "Enter the Authorized Party App Id here")]TokenIssuanceStartRequest request, ILogger log)
        {
            try
            {
                // Checks if the request is successful and did the token validation pass
                if (request.RequestStatus == RequestStatusType.Successful)
                {
                    // Fetches information about the user from external data store
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
                    // If the request fails, such as in token validation, output the failed request status, such as in token validation or response validation.
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
