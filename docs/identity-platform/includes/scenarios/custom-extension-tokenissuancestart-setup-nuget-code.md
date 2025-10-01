---
title: Starter code for authentication events trigger for Azure Functions client library in C#
description: Code snippet for a custom authentication extension using the Azure Functions client library in C#.
author: cilwerner
manager: pmwongera
ms.service: identity-platform
ms.topic: include
ms.date: 04/10/2024
ms.author: cwerner
ms.reviewer: stsoneff
ms.custom:
---

```csharp
using System;
using Microsoft.Azure.WebJobs;
using Microsoft.Extensions.Logging;
using Microsoft.Azure.WebJobs.Extensions.AuthenticationEvents.TokenIssuanceStart;
using Microsoft.Azure.WebJobs.Extensions.AuthenticationEvents;

namespace AuthEventsTrigger
{
    public static class AuthEventsTrigger
    {
        [FunctionName("onTokenIssuanceStart")]
        public static WebJobsAuthenticationEventResponse Run(
            [WebJobsAuthenticationEventsTrigger] WebJobsTokenIssuanceStartRequest request, ILogger log)
        {
            try
            {
                // Checks if the request is successful and did the token validation pass
                if (request.RequestStatus == WebJobsAuthenticationEventsRequestStatusType.Successful)
                {
                    // Fetches information about the user from external data store
                    // Add new claims to the token's response
                    request.Response.Actions.Add(
                        new WebJobsProvideClaimsForToken(
                            new WebJobsAuthenticationEventsTokenClaim("dateOfBirth", "01/01/2000"),
                            new WebJobsAuthenticationEventsTokenClaim("customRoles", "Writer", "Editor"),
                            new WebJobsAuthenticationEventsTokenClaim("apiVersion", "1.0.0"),
                            new WebJobsAuthenticationEventsTokenClaim(
                                "correlationId", 
                                request.Data.AuthenticationContext.CorrelationId.ToString())));
                }
                else
                {
                    // If the request fails, such as in token validation, output the failed request status, 
                    // such as in token validation or response validation.
                    log.LogInformation(request.StatusMessage);
                }
                return request.Completed();
            }
            catch (Exception ex) 
            { 
                return request.Failed(ex);
            }
        }
    }
}
```
