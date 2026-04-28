---
title: Validate agent identity tokens in a downstream API
titleSuffix: Microsoft Entra Agent ID
description: Learn how to validate Microsoft Entra Agent ID tokens in a downstream API by checking the signature, issuer, audience, and agent identity marker claim.
author: Dickson-Mwendia
ms.author: dmwendia
ms.topic: how-to
ms.date: 04/28/2026
ms.custom: agent-id, msecd-doc-authoring-1012
ai-usage: ai-assisted

#customer intent: As an API developer, I want to validate Microsoft Entra Agent ID tokens in my downstream API so that I can verify that requests come from authenticated agents with the correct identity.

---

# Validate agent identity tokens in a downstream API

When an AI agent calls your API through the Microsoft Entra SDK auth sidecar, the request includes a `Bearer` token. Your API validates this token to confirm the request comes from an authenticated agent with the correct permissions. If validation fails, your API returns HTTP 401 with a reason.

This article explains the validation checks and shows how to run a sample API that validates agent identity tokens end-to-end.

## Prerequisites

- **Docker Desktop** (macOS / Windows) or **Docker Engine** (Linux).
- A **Microsoft Entra tenant** with an agent identity blueprint and an agent identity. For setup steps, see [Create an agent blueprint](create-blueprint.md) and [Create and delete agent identities](create-delete-agent-identities.md).
- An agent identity token for testing. You can get one from the [sidecar local development sample](sidecar-local-development.md) or from the scripts in the [Microsoft Entra Agent ID samples repository](https://github.com/microsoft/entra-agentid-samples).

## Token validation checks

Your downstream API should perform four checks on every incoming agent identity token:

| Check | What it verifies | Details |
|---|---|---|
| **Signature** | The token isn't tampered with. | Verify the RS256 signature against the JSON Web Key Set (JWKS) at `https://login.microsoftonline.com/<tenant>/discovery/v2.0/keys`. |
| **Issuer** | Microsoft Entra ID issued the token. | The `iss` claim matches `https://sts.windows.net/<tenant>/` or `https://login.microsoftonline.com/<tenant>/v2.0`. |
| **Audience** | The token is intended for your API. | The `aud` claim matches your API's expected audience value. |
| **Agent identity marker** | The token was issued to an agent, not a regular app. | The `xms_par_app_azp` claim is present in agent identity tokens and absent in standard app-only tokens. This claim identifies the blueprint that created the agent. |

When all four checks pass, your API can trust and process the request.

## How the sample API works

The [Microsoft Entra Agent ID samples repository](https://github.com/microsoft/entra-agentid-samples) includes a weather API that demonstrates these validation checks. The API validates incoming agent identity tokens and returns real weather data from [Open-Meteo](https://open-meteo.com).

The API exposes two endpoints:

| Endpoint | Purpose |
|---|---|
| `GET /weather?city=<name>` | Validates the `Authorization: Bearer <token>` header and returns weather data for the specified city. |
| `GET /health` | Returns a health status without requiring token validation. |

The following diagram shows how tokens flow from the agent through the sidecar to the weather API:

```
┌─────────────┐                  ┌──────────────────┐
│ Agent       │  Bearer <TR>     │   weather-api    │
│             ├─────────────────▶│                  │
└─────────────┘                  │  - verify token  │
                                 │  - call          │
                                 │    Open-Meteo    │
                                 └──────────────────┘
```

Both the [local development (Ollama)](sidecar-local-development.md) and AWS (Bedrock) sidecar samples call the same weather API container. Using a single shared validator simplifies troubleshooting - if both samples fail against the weather API, the problem is in the sidecar or Microsoft Entra configuration, not in the downstream API.

## Run the sample validation API

To run the weather API as a standalone container and test token validation:

1. Clone the repository and navigate to the weather API directory:

    ```bash
    git clone https://github.com/microsoft/entra-agentid-samples.git
    cd entra-agentid-samples/sidecar/weather-api
    ```

1. Build and run the container:

    ```bash
    docker build -t weather-api:local .
    docker run --rm -p 8080:8080 \
      -e TENANT_ID=<your-tenant-id> \
      -e EXPECTED_AUDIENCE=https://graph.microsoft.com \
      weather-api:local
    ```

1. Send a request with an agent identity token:

    ```bash
    curl -H "Authorization: Bearer $TOKEN" \
         "http://localhost:8080/weather?city=Dallas"
    ```

## Review the API response

The API returns a JSON response that includes both the weather data and the token validation results:

```json
{
  "city": "Dallas",
  "temperature": 61,
  "temperature_unit": "F",
  "condition": "Overcast",
  "humidity": 93,
  "wind_speed": 8,
  "is_agent_identity": true,
  "agent_app_id": "<agent-app-id from xms_par_app_azp>",
  "validated_by": "Agent Identity Token",
  "data_source": "Open-Meteo API (Real-time)"
}
```

The `is_agent_identity`, `agent_app_id`, and `validated_by` fields confirm token validation:

| Field | Meaning |
|---|---|
| `is_agent_identity` | Set to `true` when the `xms_par_app_azp` claim is present, which confirms the token was issued to an agent identity rather than a standard app registration. |
| `agent_app_id` | The value of the `xms_par_app_azp` claim, which identifies the blueprint application that created the agent identity. |
| `validated_by` | The validation method applied to the token. Displays `Agent Identity Token` when the agent marker claim is present. |

## Configure the sample API

The sample API accepts the following environment variables:

| Variable | Required | Default | Purpose |
|---|---|---|---|
| `TENANT_ID` | Yes | — | Your Microsoft Entra tenant ID, used to build the JWKS URL and verify the issuer claim. |
| `EXPECTED_AUDIENCE` | No | `https://graph.microsoft.com` | The expected `aud` claim value. Defaults to Microsoft Graph so that the same agent tokens work for local testing. |
| `PORT` | No | `8080` | The HTTP port the API listens on. |

## Review the sample files

The weather API sample consists of three files:

| File | Purpose |
|---|---|
| `app.py` | Flask app with route handlers, token validation logic, and Open-Meteo client. |
| `Dockerfile` | Uses `python:3.11-slim` as the base image. Runs `python app.py` on port 8080. |
| `requirements.txt` | Dependencies: `flask`, `flask-cors`, `pyjwt[crypto]`, `requests`. |

Token validation libraries differ across ecosystems (Python, Node.js, .NET). This sample uses PyJWT with the `cryptography` backend for RS256 signature verification. When you build your own downstream API, choose the equivalent JWT validation library for your technology stack.

## Related content

- [Token claims reference](agent-token-claims.md)
- [Sidecar design pattern for agent authentication](sidecar-design-pattern.md)
- [Run the sidecar for local development](sidecar-local-development.md)
- [Microsoft Entra Agent ID samples repository](https://github.com/microsoft/entra-agentid-samples)
