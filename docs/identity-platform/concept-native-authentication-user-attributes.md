---
title: Native authentication user attribute concepts
description: Understand attribute descriptors, sign-up forms, email verification order, and validation in the Native Authentication API.
author: adamstoffel
ms.author: adamstoffel
ms.service: identity-platform
ms.subservice: external
ms.topic: concept-article
ms.custom: msecd-doc-authoring-1030
ms.date: 11/13/2026
ai-usage: ai-generated
#customer intent: As an application developer, I want to understand user attribute collection so that I can render sign-up forms from service responses.
---

# Native authentication user attribute concepts

[!INCLUDE [applies-to-external-only](../external-id/includes/applies-to-external-only.md)]

[!INCLUDE [applies-to-authentication-native](../external-id/includes/applies-to-authentication-native.md)]

Native authentication user attributes are values that your application collects during sign-up according to the application's user flow. The service describes the fields and validation requirements in its response. Your application controls the interface and collection logic, satisfies the returned requirements, and submits values by their returned identifiers.

## Descriptors define the form

[!INCLUDE [native-authentication-public-preview](../external-id/includes/native-authentication-public-preview.md)]

A response with `action: collectAttributes` contains an `attributes` array and a `submitAttributes` link. Use the descriptors for the current interaction when deciding which values need user input.

| Descriptor | Client use |
| --- | --- |
| **`attributeId`** | Use this exact value as the key in the submitted `attributes` object. |
| **`inputType`** | Select the appropriate input control. Examples include `text`, `boolean`, `date`, and `checkboxMultiSelect`. |
| **`required`** | Indicate that a value is required before the flow can complete. |
| **`hidden`** | Determine whether the field is visible. |
| **`canChange`** | Use the returned editability information when included. |
| **`label`** | Present the returned label when included. |
| **`initialValue`** | Use the prepopulated value when included. |
| **`validation.validationRegEx`** | Help the customer correct invalid input without replacing service validation. |
| **`options`** | Present the returned choices, using each option's `label` and `value`. |
| **`confirmationInput`** | Apply the indicated confirmation behavior, such as `retype`, `reveal`, or `none`. |

For example, an email-only form can be described as:

```json
{
  "attributeId": "email",
  "inputType": "text",
  "hidden": false,
  "required": true,
  "canChange": true,
  "label": "Email"
}
```

The submission uses `"email"` as the key, not the display label `"Email"`. Render labels and validation messages as text, not executable HTML.

## Pages group the requested attributes

Your application can group fields into screens, but it doesn't need a `pages` member to render attribute collection. Field definitions and requirements come from the current `attributes` array. If page-grouping metadata is returned, treat it as additional presentation information, not a requirement for every response.

If the service asks for another collection round, replace the prior form model with the new response. Sign-up can require multiple attribute-collection steps.

## Collection order and email verification

The service determines the collection and verification order. It can request email before other account details, collect several attributes together, or return to collection after verification. Submit only the attributes requested by the latest response, then follow the next response's action.

All required attributes and proofs still need to be satisfied. When the response returns `verify` for email, the service has sent the passcode. Your app collects it and follows the returned verification link instead of sending an extra challenge.

Email-with-password sign-up requests a password as an attribute. Email one-time passcode sign-up doesn't request a password. Collect the values requested for the selected user flow.

## Values and validation

Attribute submission contains the latest continuation token and an object of string values:

```json
{
  "continuationToken": "******",
  "attributes": {
    "email": "user@contoso.com"
  }
}
```

Use the returned identifiers for built-in and custom fields, including any custom-attribute prefix. Optional attributes can be omitted. Missing required values can cause a validation error or another collection response. An input control type doesn't change the request's string-value contract; don't substitute a JSON Boolean or array based only on the control.

Structured validation entries in `error.innerError.details` can identify affected `attributeIds` and include `code`, `message`, optional `suggestions`, and optional `recovery`. Associate a field error with the matching control. A corrected request still needs service validation; accepting input locally doesn't complete sign-up.

## Profile values, methods, and tokens are different

Profile attribute collection, authentication-method registration, and credential verification have separate contracts. For example, a phone number collected as a profile attribute still requires the applicable registration and verification operations before use as an MFA method.

Submitted profile values aren't necessarily included in every token. Token requests use the scopes and claims established at the beginning of authorization. Avoid logging either submitted profile values or the issued tokens.

After account creation, don't replay successful attribute submissions. Follow the latest action, including additional policy requirements, until authorization can continue.

## Related content

- [Sign-up API reference](reference-native-authentication-sign-up.md).
- [Native authentication flow](concept-native-authentication-flow.md).
- [Configure an application](how-to-native-authentication-configure-app.md).
