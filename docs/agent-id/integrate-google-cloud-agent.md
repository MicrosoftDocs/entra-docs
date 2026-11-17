---
title: Use a Google Cloud workload identity with Microsoft Entra Agent ID
description: Use a Google token to get an Agent ID token and call a protected API.
titleSuffix: Microsoft Entra Agent ID
ms.topic: how-to
ms.date: 11/05/2026
ms.reviewer: dastrock
ai-usage: ai-assisted

#customer-intent: As a developer hosting an agent on Google Cloud, I want to use its service account identity to get an Agent ID token without storing a Microsoft Entra secret.
---

# Use a Google Cloud workload identity with Microsoft Entra Agent ID

Use workload identity federation when an agent hosted on Google Cloud calls a Microsoft Entra-protected resource as itself. Google issues a short-lived OpenID Connect ID token for the workload's service account. Microsoft Entra ID trusts that token as a federated credential for the agent identity blueprint.

This path supports app-only access. It doesn't authenticate users or perform an On-Behalf-Of flow.

## Prerequisites

- An [agent identity blueprint](create-blueprint.md) and [Agent ID](create-delete-agent-identities.md).
- A Google Cloud service account attached to the workload.
- The service account's unique numeric ID.
- An application permission, app role, or resource role assigned to the Agent ID.
- Python 3 with the `requests` package for the example.
- A supported Google Cloud workload where the metadata server is available. Run the example on that workload with the intended service account attached, not on an unconfigured local workstation.

## Add the Google identity to the blueprint

Add a federated credential to the agent identity blueprint:

1. Open the blueprint in the Microsoft Entra admin center.
1. Select **Credentials** > **Federated credentials** > **Add credential**.
1. Select **Other issuer**.
1. Enter `https://accounts.google.com` as the issuer.
1. Enter the service account's unique numeric ID as the subject.
1. Enter `api://AzureADTokenExchange` as the audience.
1. Add the credential.

The values must exactly match the Google token:

| Federated credential | Google token claim | Value |
| --- | --- | --- |
| Issuer | `iss` | `https://accounts.google.com` |
| Subject | `sub` | Service account unique ID |
| Audience | `aud` | `api://AzureADTokenExchange` |

For the complete Microsoft procedure, see [Federate a Google Cloud workload identity with Microsoft Entra ID](/entra/workload-id/workload-identity-federation-google-cloud). For blueprint steps, see [Add a federated credential to an agent identity blueprint](manage-agent-blueprint.md#add-a-federated-credential).

## Grant access to the Agent ID

Grant the Agent ID the application permission or resource role required by the target API. The Google service account and the Agent ID remain separate identities. The federated credential lets the Google identity authenticate the blueprint; the target resource authorizes the Agent ID.

## Exchange the Google token

Install the example dependency:

```bash
pip install requests
```

The following example requests a Google ID token from the metadata server, exchanges it for an Agent ID resource token, and calls the protected API:

```python
import requests

TENANT_ID = "<tenant-id>"
BLUEPRINT_CLIENT_ID = "<agent-identity-blueprint-client-id>"
AGENT_ID_CLIENT_ID = "<agent-identity-client-id>"
RESOURCE_SCOPE = "api://<resource-client-id>/.default"
RESOURCE_URL = "https://api.contoso.com/data"

token_endpoint = (
    f"https://login.microsoftonline.com/{TENANT_ID}/oauth2/v2.0/token"
)


def exchange_token(client_id, scope, assertion, fmi_path=None):
    data = {
        "client_id": client_id,
        "scope": scope,
        "grant_type": "client_credentials",
        "client_assertion_type":
            "urn:ietf:params:oauth:client-assertion-type:jwt-bearer",
        "client_assertion": assertion,
    }
    if fmi_path:
        data["fmi_path"] = fmi_path

    response = requests.post(token_endpoint, data=data, timeout=30)
    response.raise_for_status()
    return response.json()["access_token"]


metadata_response = requests.get(
    "http://metadata.google.internal/computeMetadata/v1/instance/"
    "service-accounts/default/identity",
    params={"audience": "api://AzureADTokenExchange"},
    headers={"Metadata-Flavor": "Google"},
    timeout=10,
)
metadata_response.raise_for_status()
google_token = metadata_response.text

blueprint_token = exchange_token(
    BLUEPRINT_CLIENT_ID,
    "api://AzureADTokenExchange/.default",
    google_token,
    AGENT_ID_CLIENT_ID,
)

resource_token = exchange_token(
    AGENT_ID_CLIENT_ID,
    RESOURCE_SCOPE,
    blueprint_token,
)

resource_response = requests.get(
    RESOURCE_URL,
    headers={"Authorization": f"Bearer {resource_token}"},
    timeout=30,
)
resource_response.raise_for_status()
```

The metadata server is available only to supported Google Cloud workloads with an attached service account. Don't log the Google assertion, blueprint token, or resource token.

Verify that the resource call returns the API's expected successful response. If metadata retrieval fails, check the hosting environment and attached service account. If the Microsoft Entra exchange fails, compare the configured issuer, numeric service account subject, and audience with the required trust values. If only the resource call fails, check its scope and the permissions granted to the Agent ID rather than changing the Google service account's permissions.

For the Google token procedure, see [Get an ID token from the metadata server](https://cloud.google.com/docs/authentication/get-id-token#metadata-server). For the Agent ID exchanges, see [Agent autonomous app OAuth flow](agent-autonomous-app-oauth-flow.md).

## Clean up test access

Remove test-only resource permissions and the blueprint's federated credential when testing is complete. Delete the Agent ID or blueprint only if no remaining agent needs it. Don't delete a shared Google service account or detach it from other workloads as part of this cleanup.

## Related content

- [Federate a Google Cloud workload identity with Microsoft Entra ID](/entra/workload-id/workload-identity-federation-google-cloud)
- [Google Cloud service account ID tokens](https://cloud.google.com/docs/authentication/get-id-token)
- [Configure an app to trust an external identity provider](/entra/workload-id/workload-identity-federation-create-trust)
- [Validate Agent ID tokens in the protected API](how-to-validate-agent-tokens-downstream-api.md)
