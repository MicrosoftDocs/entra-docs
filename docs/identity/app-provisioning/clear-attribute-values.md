---
title: Clear attribute values (Preview)
description: Learn how to clear target attribute values when a source attribute has a null or empty value in Microsoft Entra provisioning.
ms.topic: how-to
ms.date: 08/19/2026
ms.reviewer: cmmdesai
ai-usage: ai-assisted
---

# Clear attribute values (Preview)

Microsoft Entra provisioning can clear an existing target attribute value when the corresponding source attribute is null or empty. This capability also referred to as "null value provisioning" is useful when a value is removed from your system of record and the corresponding value must also be removed from the target system.

> [!NOTE]
> Clearing attribute values is currently in preview. We make previews available to our customers under the terms applicable to previews. These terms are outlined in the overall Microsoft product terms for [online services](https://www.microsoft.com/licensing/terms/product/ForOnlineServices/all).

The configuration for clearing attribute values is consistent across supported provisioning integrations. However, the source schema editor and the way a source system represents a null value can vary by integration.

## Preview scope and limitations

- Clearing attribute values is available in preview for API-driven inbound provisioning to:
  - Microsoft Entra ID.
  - On-premises Active Directory.
- Clearing attribute values is only supported for single-valued attributes. 
- This feature can be enabled for [custom security attribute provisioning](provision-custom-security-attributes.md).
- Clearing attribute values isn't currently supported for:
  - Outbound application provisioning scenarios.
  - Inbound provisioning from Workday or SAP SuccessFactors.
- Clearing multi-valued attributes is not supported. 

## How attribute values are cleared

Clearing attribute values is disabled by default and it is an opt-in feature. Clearing attribute values uses a two-gate safeguard mechanism to help prevent accidental data loss. You must enable the option **Flow null values** for both the source attribute and its corresponding target mapping. 

| Source value | Result when clearing is enabled |
|---|---|
| The attribute has a nonempty value. | The provisioning service evaluates the value by using the configured attribute mapping. |
| The attribute has a null or empty value. | During an update, the provisioning service clears the existing value from the mapped target attribute. |
| For API-driven provisioning, let's say you omit an attribute for which null flow is enabled. | During an update, the provisioning service treats the attribute as empty and clears the existing mapped target value. |

On user creation, a null, empty, or omitted source value doesn't populate the target attribute unless you configured **Default value if null**. A default value applies during creation only. During an update, the provisioning service clears the target value instead of applying the creation-time default.

> [!NOTE]
> Configure attribute value clearing only for attributes where an empty or null source value must remove the existing target value. Don't enable it for attributes that are required to match or create a user.

## Prerequisites

Before you begin, make sure that:

- You have at least the [Application Administrator](~/identity/role-based-access-control/permissions-reference.md#application-administrator) role.
- You configured a provisioning application and its attribute mappings.
- The source attribute exists in the provisioning application schema and has a target attribute mapping. To learn more, see [Customize Microsoft Entra attribute mappings](customize-application-attributes.md).

For API-driven inbound provisioning to on-premises Active Directory, review the additional [role and server prerequisites](inbound-provisioning-api-configure-app.md#prerequisites), and then [configure the provisioning agent and Active Directory connection](inbound-provisioning-api-configure-app.md#configure-api-driven-inbound-provisioning-to-on-premises-ad).

## Enable null value flow for the source attribute

First, configure the source schema attribute to flow null values. The name of the source schema editor varies by provisioning integration.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an Application Administrator.
1. Browse to **Entra ID** > **Enterprise apps**.
1. Search for and select your provisioning application.
1. Select **Provisioning** > **Attribute mapping**.
1. Open the attribute mapping for the object that you want to configure.
1. Expand **Advanced options**, and then select the option to edit the source attribute list. The option name identifies the source system or connector.
1. In the **Flow null values** column, select the check box for each source attribute that can clear its mapped target attribute.
1. Select **Save**.

## Enable null value flow in the target mapping

Next, enable null value flow for each corresponding target attribute mapping.

1. Return to the **Attribute mapping** page.
1. Select the mapping for the target attribute that you want to clear.
1. Select **Flow null values**.
1. Select **OK** to close the mapping editor.
1. Select **Save** to save the attribute mappings.
1. Repeat these steps for every target attribute that must accept a null value.

Both settings are required. If **Flow null values** isn't selected for the source schema attribute or the target mapping, the provisioning service doesn't use the null or empty source value to clear the target attribute.

## API-driven provisioning example

The following example shows how to configure API-driven inbound provisioning to clear attribute values and send null or empty values in a `/bulkUpload` request.

### Enable null value flow in the source schema

For API-driven provisioning, expand **Advanced options**, and then select **Edit API user attributes**. Locate the **Flow null values** column, and select the source attributes that can send null or empty values. In the example below, **Flow null values** is enabled for the SCIM extension attributes `division` and `department`. This setting instructs the provisioning service to process null or empty values for these attributes and evaluate the target attribute mapping for null flow.   

:::image type="content" source="./media/clear-attribute-values/flow-null-values-column.png" alt-text="Screenshot highlighting the Flow null values column in the API user attribute schema." lightbox="./media/clear-attribute-values/flow-null-values-column.png":::

:::image type="content" source="./media/clear-attribute-values/enable-source-null-flow.png" alt-text="Screenshot of API user attributes with Flow null values selected for the division and department attributes." lightbox="./media/clear-attribute-values/enable-source-null-flow.png":::

> [!NOTE]
> Enabling the option only on the source attribute doesn't clear the target value; the target mapping must also allow null value flow, as described in the next section.

### Enable null value flow in the target mapping

Open each corresponding target attribute mapping, and select **Flow null values**. The example below maps the source SCIM extension attribute `department` to the Active Directory attribute `department` and enables **Flow null values** so that when the source SCIM attribute is null or empty, the `department` attribute value is cleared in Active Directory.

:::image type="content" source="./media/clear-attribute-values/enable-target-mapping-null-flow.png" alt-text="Screenshot of an attribute mapping with Flow null values selected." lightbox="./media/clear-attribute-values/enable-target-mapping-null-flow.png":::

### Send null or empty values

Include the attribute in a `/bulkUpload` request and set its value to JSON `null` or an empty string. 

> [!IMPORTANT]
> For API-driven provisioning, enabling **Flow null values** changes how partial payloads are processed. Let's say you omit a source attribute for which null flow is enabled, then the provisioning service will clear its mapped target value. An incomplete or partial source payload might therefore unintentionally clear existing attribute values. As a best practice, include the complete source user record in every bulk request, for both full and delta sync and use an explicit JSON `null` or empty string to request deterministic clearing.

The following excerpt clears the existing `department` and `division` values for the matched user:

```json
{
  "schemas": [
    "urn:ietf:params:scim:api:messages:2.0:BulkRequest"
  ],
  "Operations": [
    {
      "method": "POST",
      "bulkId": "00aa00aa-bb11-cc22-dd33-44ee44ee44ee",
      "path": "/Users",
      "data": {
        "schemas": [
          "urn:ietf:params:scim:schemas:core:2.0:User",
          "urn:ietf:params:scim:schemas:extension:enterprise:2.0:User"
        ],
        "externalId": "701984",
        "userName": "bjensen@example.com",
        "urn:ietf:params:scim:schemas:extension:enterprise:2.0:User": {
          "department": null,
          "division": ""
        }
      }
    }
  ],
  "failOnErrors": null
}
```

Use the source attribute names from your provisioning app schema. Make sure that the request contains the matching attribute required by your configuration, such as `externalId`.

For instructions to submit the request, see [Quickstart API-driven inbound provisioning with Graph Explorer](inbound-provisioning-api-graph-explorer.md) or [Quickstart for API-driven inbound provisioning with cURL](inbound-provisioning-api-curl-tutorial.md).

## Verify the attribute was cleared

After the provisioning service processes the request, verify the result in the provisioning logs and the target directory.

1. In your provisioning app, select **Provisioning logs**.
1. Open the provisioning event for the user.
1. Select the **Modified properties** tab.
1. Confirm that the target attribute shows an empty new value.

    :::image type="content" source="./media/clear-attribute-values/verify-cleared-properties.png" alt-text="Screenshot of modified properties showing empty new values for company and department." lightbox="./media/clear-attribute-values/verify-cleared-properties.png":::

1. Verify that the attribute no longer has a value on the object in the target system.

In this on-premises Active Directory example, the API source attribute `division` maps to the target attribute `company`.
For on-premises Active Directory, the provisioning service removes the attribute value instead of writing an empty string.

## Troubleshoot clearing attribute values

Use the following guidance if the target attribute isn't cleared.

| Issue | Resolution |
|---|---|
| The null or empty value is ignored. | Confirm that **Flow null values** is selected for both the source schema attribute and the target mapping. |
| The wrong target attribute is cleared. | Review the attribute mapping and confirm that the source attribute maps to the expected target attribute. |
| The source uses a placeholder value instead of null. | Configure the source integration to return a null or empty value instead of a placeholder, or transform the placeholder before provisioning. |
| An API-driven provisioning request doesn't clear the attribute. | Use an explicit JSON `null` or empty string value. If you rely on omission for a child attribute, confirm that its containing complex object or collection element remains in the payload. Also confirm that the payload matching attribute identifies the existing target user. |
| An API-driven provisioning request unexpectedly clears an attribute. | Confirm that the attribute wasn't omitted from the payload. Include its current non-empty value whenever you want to preserve the existing target value. |

## Next steps

- [Customize Microsoft Entra attribute mappings](customize-application-attributes.md)
- [API-driven inbound provisioning concepts](inbound-provisioning-api-concepts.md)
- [Frequently asked questions about API-driven inbound provisioning](inbound-provisioning-api-faqs.md)
- [Troubleshoot API-driven inbound provisioning](inbound-provisioning-api-issues.md)
