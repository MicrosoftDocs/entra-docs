---
title: Understand how expression builder works with Application Provisioning in Microsoft Entra ID
description: Understand how expression builder works with Application Provisioning in Microsoft Entra ID.

author: jenniferf-skc
manager: dougeby
ms.service: entra-id
ms.subservice: app-provisioning
ms.topic: conceptual
ms.date: 03/04/2025
ms.author: jfields
ms.reviewer: arvinh
ai-usage: ai-assisted
---

# Understand how expression builder in Application Provisioning works

You can use [expressions](functions-for-customizing-application-data.md) to [map attributes](./customize-application-attributes.md). Previously, you had to create these expressions manually and enter them into the expression box. Expression builder is a tool you can use to help you create expressions.

:::image type="content" source="media/expression-builder/expression-builder.png" alt-text="The default expression builder page before selecting a function." lightbox="media/expression-builder/expression-builder.png":::

For reference on building expressions, see [Reference for writing expressions for attribute mappings](functions-for-customizing-application-data.md). 

## Finding the expression builder

In application provisioning, you use expressions for attribute mappings. You access Express Builder on the attribute-mapping page by selecting **Show advanced options** and then select **Expression builder**.

:::image type="content" source="media/expression-builder/accessing-expression-builder.png" alt-text="The checkbox to show advanced settings is selected and a link is shown that says expression builder" lightbox="media/expression-builder/accessing-expression-builder.png":::

## Using expression builder

To use expression builder, select a function and attribute and then enter a suffix if needed. Then select **Add expression** to add the expression to the code box. To learn more about the functions available and how to use them, see [Reference for writing expressions for attribute mappings](functions-for-customizing-application-data.md).

Test the expression by providing values and selecting **Test expression**. For example, from the dropdown list, select the **mail** attribute. Fill in the value with the email domain that starts with the @ sign; for example, `@fabrikam.com`. Then select **Test expression** and the output of the expression test appears in the **View expression output** box.

When you're satisfied with the expression, move it to an attribute mapping. Copy and paste it into the expression box for the attribute mapping you're working on.

## Known limitations
* Extension attributes aren't available for selection in the expression builder. However, extension attributes can be used in the attribute mapping expression. 

## Next steps

[Reference for writing expressions for attribute mappings](functions-for-customizing-application-data.md)
