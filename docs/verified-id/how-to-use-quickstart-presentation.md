---
title: Issue verifiable credentials by presenting claims from an existing verifiable credential
description: Learn how to use a quickstart to create custom credentials for from other Verifiable Credential attestation.
documentationCenter: ''
author: barclayn
manager: femila
ms.service: entra-verified-id
ms.topic: how-to
ms.date: 01/21/2025
ms.author: barclayn

#Customer intent: As a verifiable credentials administrator, I want to create a verifiable credential for self-asserted claims scenario. 
---

# Issue verifiable credentials by presenting claims from an existing verifiable credential

  
A [rules definition](rules-and-display-definitions-model.md#rulesmodel-type) that uses the [presentations attestation](rules-and-display-definitions-model.md#verifiablepresentationattestation-type) type produces an issuance flow where you want the user to present another verifiable credential in the wallet during issuance and where claim values for issuance of the new credential are taken from the presented credential. An example of this type of flow can be when you present your VerifiedEmployee credential to get a visitors pass credential.

## Create a custom credential with the presentations attestation type

In the **Azure portal**, when you select **Add credential**, you get the option to launch two quickstarts. Select **custom credential**, and then select **Next**.

:::image type="content" source="media/how-to-use-quickstart/quickstart-startscreen.png" alt-text="Screenshot of the 'Issue credentials' quickstart for creating a custom credential.":::

On the **Create a new credential** page, enter the JSON code for the display and the rules definitions. In the **Credential name** box, give the credential a name. This name is just an internal name for the credential in the portal. The type name of the credential is defined in the `vc.type` property name in the rules definition. To create the credential, select **Create**.

:::image type="content" source="media/how-to-use-quickstart/quickstart-create-new.png" alt-text="Screenshot of the 'Create a new credential' page, displaying JSON samples for the display and rules files.":::

## Sample JSON display definitions

The JSON display definition is nearly the same, regardless of attestation type. You only have to adjust the labels according to the claims that your verifiable credential has. The expected JSON for the display definitions is the inner content of the displays collection. The JSON is a collection, so if you want to support multiple locales, add multiple entries with a comma as separator. 

```json
{
  "locale": "en-US",
  "card": {
    "backgroundColor": "#000000",
    "description": "Use your verified credential to prove to anyone that you know all about verifiable credentials.",
    "issuedBy": "Microsoft",
    "textColor": "#ffffff",
    "title": "Verified Credential Expert",
    "logo": {
      "description": "Verified Credential Expert Logo",
      "uri": "https://didcustomerplayground.z13.web.core.windows.net/VerifiedCredentialExpert_icon.png"
    }
  },
  "consent": {
    "instructions": "Present your True Identity card to issue your VC",
    "title": "Do you want to get your Verified Credential?"
  },
  "claims": [
    {
      "claim": "vc.credentialSubject.firstName",
      "label": "First name",
      "type": "String"
    },
    {
      "claim": "vc.credentialSubject.lastName",
      "label": "Last name",
      "type": "String"
    }
  ]
}
```

## Sample JSON rules definitions

The JSON attestation definition should contain the **presentations** name. The **inputClaim** in the mapping section defines what claims should be captured in the credential the user presents. They need to have the prefix `$.vc.credentialSubject`. The **outputClaim** defined the name of the claims in the credential being issued. 

The following rules definition prompts the user to present the **True Identity** credential during issuance. This credential comes from the [public demo application](https://woodgroveemployee.azurewebsites.net/). 

```json
{
  "attestations": {
    "presentations": [
      {
        "mapping": [
          {
            "outputClaim": "firstName",
            "required": true,
            "inputClaim": "$.vc.credentialSubject.firstName",
            "indexed": false
          },
          {
            "outputClaim": "lastName",
            "required": true,
            "inputClaim": "$.vc.credentialSubject.lastName",
            "indexed": false
          }
        ],
        "required": false,
        "credentialType": "TrueIdentity",
        "contracts": [
          "https://verifiedid.did.msidentity.com/v1.0/tenants/aaaabbbb-0000-cccc-1111-dddd2222eeee/verifiableCredentials/contracts/M2MzMmVkNDAtOGExMC00NjViLThiYTQtMGIxZTg2ODgyNjY4dHJ1ZSBpZGVudGl0eSBwcm9k/manifest"
        ]
      }
    ]
  },
  "validityInterval": 2592001,
  "vc": {
    "type": [
      "VerifiedCredentialExpert"
    ]
  }
}
```

| **Property** | **Type** | **Description** |
| -------- | -------- | -------- |
|`credentialType`| string | credential type being requested during issuance. `TrueIdentity` in the previous example. |
|`contracts` | string (array) | list of manifest URLs of credentials requested. In the earlier example, the manifest URL is the manifest for `True Identity` |
| `trustedIssuers` | string (array) | a list of allowed issuer Decentralized Identifiers (DID)s for the credential being requested. In the earlier example, the DID is the DID of the `True Identity`issuer. |

Values

## Authenticator experience during issuance

During issuance, Authenticator prompts the user to select a matching credential. If the user has multiple matching credentials in the wallet, the user must select which one to present.

:::image type="content" source="media/how-to-use-quickstart-presentation/issue-presentation.png" alt-text="Screenshot of presentations claims input.":::

## Configure the samples to issue your custom credential

To configure your sample code to issue and verify your custom credential, you need:

- Your tenant's issuer decentralized identifier (DID)
- The credential type
- The manifest URL to your credential 

The easiest way to find this information for a custom credential is to go to your credential in the Azure portal. Select **Issue credential**. Then you have access to a text box with a JSON payload for the Request Service API. Replace the placeholder values with your environment's information. The issuer’s DID is the authority value.

:::image type="content" source="media/how-to-use-quickstart/quickstart-config-sample-2.png" alt-text="Screenshot of the quickstart custom credential issue.":::

## Next steps

See the [Rules and display definitions reference](rules-and-display-definitions-model.md).
