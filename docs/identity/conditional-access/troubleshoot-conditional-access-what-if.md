---
title: Troubleshoot Conditional Access using the What If tool
description: Where to find what Conditional Access policies were applied and why
ms.service: entra-id
ms.subservice: conditional-access
ms.topic: troubleshooting
ms.date: 08/13/2024
ms.author: joflore
author: MicrosoftGuyJFlo
manager: dougeby
ms.reviewer: calebb
ms.custom: sfi-image-nochange
---
# Troubleshooting Conditional Access using the What If tool

The [What If tool](what-if-tool.md) in Conditional Access is powerful when trying to understand why a policy was or wasn't applied to a user in a specific circumstance or if a policy would apply in a known state.

Find the What If tool in the **Microsoft Entra admin center** > **Entra ID** > **Conditional Access** > **Policies** > **What If**.

![Screenshot of the Conditional Access What If tool at its default state.](./media/troubleshoot-conditional-access-what-if/conditional-access-what-if-tool.png)

## Gathering information

The What If tool needs only a **User** or **Workload identity** to get started.

The following additional information is optional but helps narrow the scope for specific cases:

* Cloud apps, actions, or authentication context
* IP address
* Country/region
* Device platform
* Client apps
* Device state
* Sign-in risk
* User risk level
* Service principal risk (Preview)
* Filter for devices

This information can be gathered from the user, their device, or the Microsoft Entra sign-in log.

## Generating results

Enter the criteria gathered in the previous section, and select **What If** to generate a list of results.

At any point, select **Reset** to clear any criteria input and return to the default state.

## Evaluating results

### Policies that will apply

This list shows which Conditional Access policies would apply given the conditions. The list includes both the grant and session controls that apply including policies in report-only mode. Examples include requiring multifactor authentication to access a specific application.

### Policies that won't apply

This list shows Conditional Access policies that wouldn't apply if the conditions applied. The list includes any policies and the reason why they don't apply including policies in report-only mode. Examples include users and groups that might be excluded from a policy.

## Use case

Many organizations create policies based on network locations, allowing trusted locations and blocking locations where access isn't allowed.

To validate that a configuration is appropriate, an admin can use the What If tool to mimic access from a location that should be allowed and from a location that should be denied.

[![Screenshot of the What If tool showing results with Block access.](./media/troubleshoot-conditional-access-what-if/conditional-access-what-if-results.png)](./media/troubleshoot-conditional-access-what-if/conditional-access-what-if-results.png#lightbox)

In this instance, the user is blocked from accessing any cloud app on their trip to North Korea because Contoso blocks access from that location.

This test can be expanded to include other data points to narrow the scope.

## Related content

* [What is Conditional Access report-only mode?](concept-conditional-access-report-only.md)
* [What is Microsoft Entra ID Protection?](~/id-protection/overview-identity-protection.md)
* [What is a device identity?](~/identity/devices/overview.md)
* [How it works: Microsoft Entra multifactor authentication](~/identity/authentication/concept-mfa-howitworks.md)
