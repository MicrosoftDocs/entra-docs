---
title: Multitenant organization optional policy templates
description: Learn about multitenant organization optional policy templates in Microsoft Entra ID.
author: kenwith
manager: femila
ms.service: entra-id
ms.subservice: multitenant-organizations
ms.topic: conceptual
ms.date: 04/23/2024
ms.author: kenwith
ms.custom: it-pro
#Customer intent: As a dev, devops, or it admin, I want to
---

# Multitenant organization optional policy templates

Administrators staying in control of their resources is a guiding principle for multitenant organization collaboration. Cross-tenant access settings are required for each tenant-to-tenant relationship. Tenant administrators explicitly configure cross-tenant access partner configurations and identity synchronization settings for partner tenants inside the multitenant organization.

To help apply homogenous cross-tenant access settings to partner tenants in the multitenant organization, the administrator of each tenant can configure optional cross-tenant access settings templates dedicated to the multitenant organization. This article describes how to use templates to preconfigure cross-tenant access settings that are applied to any partner tenant newly joining the multitenant organization.

## Autogeneration of cross-tenant access settings

Within a multitenant organization, each pair of tenants must have bidirectional [cross-tenant access settings](~/external-id/cross-tenant-access-settings-b2b-collaboration.yml), for both, partner configuration and identity synchronization. These settings provide the underlying policy framework for enabling trust and for sharing users and applications.

When your tenant joins a new multitenant organization, or when a partner tenant joins your existing multitenant organization, cross-tenant access settings to other partner tenants in the enlarged multitenant organization, if they don't already exist, are automatically generated in an unconfigured state. In an unconfigured state, these cross-tenant access settings pass through the [default settings](~/external-id/cross-tenant-access-settings-b2b-collaboration.yml#configure-default-settings).

Default cross-tenant access settings apply to all external tenants for which you haven't created organization-specific customized settings. Typically, these settings are configured to be nontrusting. For example, cross-tenant trusts for multifactor authentication and compliant device claims might be disabled and user and group sharing in B2B direct connect or B2B collaboration might be disallowed.

In multitenant organizations, on the other hand, cross-tenant access settings are typically expected to be trusting. For example, cross-tenant trusts for multifactor authentication and compliant device claims might be enabled and user and group sharing in B2B direct connect or B2B collaboration might be allowed.

While the autogeneration of cross-tenant access settings for multitenant organization partner tenants in and of itself doesn't change any authentication or authorization policy behavior, it allows your organization to easily customize the cross-tenant access settings for partner tenants in the multitenant organization on a per-tenant basis.

## Policy templates at multitenant organization formation

As previously described, in multitenant organizations, cross-tenant access settings are typically expected to be trusting. For example, cross-tenant trusts for multifactor authentication and compliant device claims might be enabled and user and group sharing in B2B direct connect or B2B collaboration might be allowed.

While autogeneration of cross-tenant access settings, per previous section, guarantees the existence of cross-tenant access settings for every multitenant organization partner tenant, further maintenance of the cross-tenant access settings for multitenant organization partner tenants is conducted individually, on a per-tenant basis.

To reduce the workload for administrators at the time of multitenant organization formation, you can optionally use policy templates for preemptive configuration of cross-tenant access settings. These template settings are applied at the time of your tenant joins a multitenant organization to all external multitenant organization partner tenants as well as at the time of any partner tenant joins your existing multitenant organization to such new partner tenant.

[Enablement or configuration of the optional policy templates](multi-tenant-organization-configure-templates.md), at the time of a partner tenant joins a multitenant organization, preemptively amend the corresponding [cross-tenant access settings](~/external-id/cross-tenant-access-settings-b2b-collaboration.yml), for both partner configuration and identity synchronization.

As an example, consider the actions of the administrators for an anticipated multitenant organization with three tenants, A, B, and C.

- The administrators of all three tenants enable and configure their respective optional policy templates to enable cross-tenant trusts for multifactor authentication and compliant device claims and to allow user and group sharing in B2B direct connect and B2B collaboration.
- Administrator A creates the multitenant organization and adds tenants B and C as pending tenants to the multitenant organization.
- Administrator B joins the multitenant organization. Cross-tenant access settings in tenant A for partner tenant B are amended, according to tenant A policy template settings. Vice versa, cross-tenant access settings in tenant B for partner tenant A are amended, according to tenant B policy template settings.
- Administrator C joins the multitenant organization. Cross-tenant access settings in tenants A (and B) for partner tenant C are amended, according to tenant A (and B) policy template settings. Similarly, cross-tenant access settings in tenant C for partner tenants A and B are amended, according to tenant C policy template settings.
- Following the formation of this multitenant organization of three tenants, the cross-tenant access settings of all tenant pairs in the multitenant organization have preemptively been configured.

In summary, configuration of the optional policy templates enable you to homogeneously initialize cross-tenant access settings across your multitenant organization, while maintaining maximum flexibility to customize your cross-tenant access settings as needed on a per-tenant basis.

To stop using the policy templates, you can reset them to their default state. For more information, see [Configure multitenant organization templates](multi-tenant-organization-configure-templates.md).

## Policy template scoping and additional properties

To provide administrators with further configurability, you can choose when cross-tenant access settings are to be amended according to the policy templates. For example, you can choose to apply the policy templates for the following tenants when a tenant joins a multitenant organization:

| Tenant | Description |
| --- | --- |
| Only new partner tenants | Tenants whose cross-tenant access settings are autogenerated |
| Only existing partner tenants | Tenants who already have cross-tenant access settings |
| All partner tenants | Both new partner tenants and existing partner tenants |
| No partner tenants | Policy templates are effectively disabled |

In this context, *new* partners refer to tenants for which you haven't yet configured cross-tenant access settings, while *existing* partners refer to tenants for which you have already configured cross-tenant access settings. This scoping is specified with the `templateApplicationLevel` property on the cross-tenant access [partner configuration template](/graph/api/resources/multitenantorganizationpartnerconfigurationtemplate) and the `templateApplicationLevel` property on the cross-tenant access [identity synchronization template](/graph/api/resources/multitenantorganizationidentitysyncpolicytemplate).

Finally, in terms of interpretation of template property values, any template property value of `null` has no effect on the corresponding property value in the targeted cross-tenant access settings, while a defined template property value causes the corresponding property value in the targeted cross-tenant access settings to be amended in accordance with the template. The following table illustrates how template property values are being applied to corresponding cross-tenant access setting values.

| Template Value | Initial Partner Settings Value<br/>(Before joining multitenant org) | Final Partner Settings Value<br/>(After joining multitenant org) |
| --- | --- | --- |
| `null` | &lt;Partner Settings Value&gt; | &lt;Partner Settings Value&gt; |
| &lt;Template Value&gt; | &lt;any value&gt; | &lt;Template Value&gt; |

## Policy templates used by Microsoft 365 admin center

When a multitenant organization is formed in Microsoft 365 admin center, an administrator agrees to the following multitenant organization template settings:

- Identity synchronization is set to allow users to synchronize into this tenant
- Cross-tenant access is set to automatically redeem user invitations for both inbound and outbound

This is achieved by setting the corresponding three template property values to `true`:

- `automaticUserConsentSettings.inboundAllowed`
- `automaticUserConsentSettings.outboundAllowed`
- `userSyncInbound`

For more information, see [Join or leave a multitenant organization in Microsoft 365](/microsoft-365/enterprise/join-leave-multi-tenant-org).

## Cross-tenant access settings at time of multitenant organization disassembly

Currently, there's no equivalent policy template feature supporting the disassembly of a multitenant organization. When a partner tenant leaves the multitenant organization, each tenant administrator must reexamine and amend accordingly the cross-tenant access settings for the partner tenant that left the multitenant organization.

The partner tenant that left the multitenant organization must reexamine and amend accordingly the cross-tenant access settings for all former multitenant organization partner tenants as well as consider resetting the two policy templates for cross-tenant access settings.

## Next steps

- [Configure multitenant organization templates using the Microsoft Graph API](./multi-tenant-organization-configure-templates.md)
