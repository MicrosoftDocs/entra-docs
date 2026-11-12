---
title: Microsoft Entra resource policy parameters (preview)
description: Understand resource policy parameter schemas, assignment values, defaults, validation, and update behavior.
ms.topic: concept-article
ms.date: 11/11/2026
ai-usage: ai-generated
# Customer intent: As a policy author or administrator, I want to understand parameter schemas and values so that I can configure reusable policy logic correctly.
---

# Microsoft Entra resource policy parameters (preview)

Parameters separate reusable policy logic from assignment-specific values. A custom policy declares its parameter schema in `__metadata__.paramsSchema`; an assignment supplies values in `params`. Rego reads those values through a fully qualified reference or an import alias.

Built-in policies define their own parameter schemas. You can set their assignment values, but can't edit their schemas.

## Parameter schema

The schema defines parameter names, types, descriptions, required values, and optional defaults. This fragment of `__metadata__` declares a required string, an optional Boolean, and an optional string array:

```json
{
  "paramsSchema": {
    "properties": {
      "required_prefix": {
        "type": "string",
        "description": "Required prefix for application display names."
      },
      "case_sensitive": {
        "type": "boolean",
        "description": "Whether name comparisons are case-sensitive.",
        "default": true
      },
      "banned_word_list": {
        "type": "array",
        "items": {
          "type": "string"
        },
        "description": "Words the policy disallows in application display names.",
        "default": []
      }
    },
    "required": [
      "required_prefix"
    ]
  }
}
```

The schema describes configuration, not the policy's enforcement logic. For example, the string type permits an empty prefix; Rego must enforce a nonempty-prefix requirement if the policy needs one.

## Assignment values

Values belong in the assignment's `params` property:

```json
{
  "params": {
    "required_prefix": "Contoso-",
    "case_sensitive": false,
    "banned_word_list": [
      "Test",
      "Temp"
    ]
  }
}
```

This assignment overrides the default `case_sensitive` value. When creating an assignment, omitting `case_sensitive` uses `true`, and omitting `banned_word_list` uses an empty array. Updates follow the [merge rules](#assignment-update-behavior) instead.

These fragments aren't complete policy or assignment requests. For assignment procedures, see [Create or update an assignment](resource-policy-manage-portal.md#create-or-update-an-assignment).

## Parameters in Rego

In Rego, read parameter values through `data.graph.<definitionUniqueName>["<version>"].params`. The definition name and version must match the policy's package declaration.

Import that path as `params` to keep rule expressions short:

```rego
package graph.application_name_prefix_parameterized["1.0.0"]

import data.graph.application_name_prefix_parameterized["1.0.0"].params as params

prefix := params.required_prefix
case_sensitive := params.case_sensitive
banned_words := params.banned_word_list
```

Without the alias, the prefix reference is `data.graph.application_name_prefix_parameterized["1.0.0"].params.required_prefix`. The import changes only Rego access; assignment and evaluation request bodies still use the JSON property `params`.

Don't declare your own `params` rule. For the complete policy structure and rule requirements, see [Author resource policies with Rego](resource-policy-rego.md).

## Validation and defaults

The service validates values against the policy version's schema when creating or updating an assignment. Required parameters must have values, and supplied values must match their declared types. Optional parameters can have a `default` of the declared type; required parameters can't.

`evaluatePolicy` also validates supplied `params` against the inline policy's schema, independently of assignments. It can check proposed values before an assignment changes. See [Test and troubleshoot a resource policy](resource-policy-test-troubleshoot.md#evaluate-custom-policy-logic).

Parameter validation failures are configuration errors, not successfully evaluated policy violations. Passing schema validation doesn't prove that a resource change meets the policy's requirements.

## Supported parameter types

| Value | Schema example |
| --- | --- |
| String | `{"type": "string"}` |
| Integer | `{"type": "integer"}` |
| Number | `{"type": "number"}` |
| Boolean | `{"type": "boolean"}` |
| Array of strings | `{"type": "array", "items": {"type": "string"}}` |

Arrays contain scalars: `string`, `integer`, `number`, or `boolean`.

Object values, nested arrays, nullable types, type unions, references, and schema composition aren't supported. Express constraints such as `enum`, `pattern`, `minLength`, and numeric bounds in Rego.

Don't add root `type`, `$schema`, or `additionalProperties` keywords to `paramsSchema`.

## Parameter names

Names must start with an ASCII letter and contain only ASCII letters, digits, or underscores. `required_prefix` and `prefix1` are valid; `_prefix`, `1prefix`, and `required-prefix` aren't.

Rego v1 reserved words can't be names: `as`, `contains`, `default`, `else`, `every`, `false`, `if`, `import`, `in`, `not`, `null`, `package`, `some`, `true`, and `with`.

These rules apply even to unused declarations or values accessed with brackets.

## Assignment update behavior

Updates merge `params` with stored values. Supplied arrays replace stored arrays; they don't append.

| Update | Behavior before schema validation and defaults |
| --- | --- |
| Omit `params` | Keep the stored values when the assigned version is unchanged. |
| `"params": {}` | Keep the stored values. |
| `"params": {"required_prefix": "Fabrikam-"}` | Replace this value and keep other stored values. |
| `"params": {"required_prefix": null}` | Remove this stored value. |
| `"params": null` | Clear all stored values. |

After merging, the service validates values and applies defaults. Removing an optional value can restore its default. Removing a required value, such as `required_prefix`, fails validation.

Because updates merge values, supplying the previous object alone doesn't remove newly added stored values. Restoring an earlier configuration also requires removing those additions with `null`.

Only one live assignment is allowed per version, including a disabled assignment. Different parameter values can't be assessed through a second report-only assignment to the same version.

For editing steps, see [Edit an existing assignment](resource-policy-manage-portal.md#edit-an-existing-assignment). Allow [assignment changes to take effect](resource-policy-evaluation.md#assignment-propagation) before interpreting request results.

## Schema and version changes

Changing the schema or logic requires a new definition version. A schema change requires a higher major version, such as `2.0.0`. See [Publish a new custom policy version](resource-policy-lifecycle.md#publish-a-new-custom-policy-version).

Update parameter references or imports to match the new package version. Remove obsolete stored values with `null` members in `params`, and supply new required values in the same object.

If you change `assignedPolicy.version`, explicitly include `params` and check that the resulting values meet the new schema. For rollout without losing existing enforcement, see [Roll out the new version](resource-policy-lifecycle.md#roll-out-the-new-version).

## Related content

- [Author resource policies with Rego](resource-policy-rego.md).
- [Test and troubleshoot a resource policy](resource-policy-test-troubleshoot.md).
- [Update and retire resource policies](resource-policy-lifecycle.md).
- [Safely deploy resource policy assignments](resource-policy-safe-deployment.md).
- [Create and manage resource policies in the Microsoft Entra admin center](resource-policy-manage-portal.md).
