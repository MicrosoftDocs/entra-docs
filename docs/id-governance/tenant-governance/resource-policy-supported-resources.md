---
title: Supported Microsoft Entra resource policy resources and actions (preview)
description: Review the resource types, actions, and operation categories that Microsoft Entra resource policies can target.
ms.topic: reference
ms.date: 11/11/2026
ai-usage: ai-generated
# Customer intent: As a policy author, I want to identify supported targets so that I don't write policies for unsupported resources or operations.
---

# Supported Microsoft Entra resource policy resources and actions (preview)

A custom policy's `__metadata__.selector` identifies its target resource type or action and operations. Use supported targets rather than assuming that every Microsoft Graph endpoint participates in resource policy evaluation.

This reference lists policy targets, not the available built-in policies. Use the linked Microsoft Graph references to review resource properties, methods, request formats, and API versions.

## Resource types

Policies can target the following resource types. Resource selectors include supported derived types by default. Set `includeDerivedTypes` to `false` to target only the named type.

| Resource type | Resource |
| --- | --- |
| [`microsoft.graph.user`](/graph/api/resources/user?view=graph-rest-beta&preserve-view=true) | Users. |
| [`microsoft.graph.group`](/graph/api/resources/group?view=graph-rest-beta&preserve-view=true) | Groups. |
| [`microsoft.graph.application`](/graph/api/resources/application?view=graph-rest-beta&preserve-view=true) | Application registrations. |
| [`microsoft.graph.federatedIdentityCredential`](/graph/api/resources/federatedidentitycredential?view=graph-rest-beta&preserve-view=true) | Federated identity credentials. |
| [`microsoft.graph.servicePrincipal`](/graph/api/resources/serviceprincipal?view=graph-rest-beta&preserve-view=true) | Service principals. |
| [`microsoft.graph.appRoleAssignment`](/graph/api/resources/approleassignment?view=graph-rest-beta&preserve-view=true) | App role assignments. |
| [`microsoft.graph.oAuth2PermissionGrant`](/graph/api/resources/oauth2permissiongrant?view=graph-rest-beta&preserve-view=true) | Delegated permission grants. |
| [`microsoft.graph.administrativeUnit`](/graph/api/resources/administrativeunit?view=graph-rest-beta&preserve-view=true) | Administrative units. |
| [`microsoft.graph.scopedRoleMembership`](/graph/api/resources/scopedrolemembership?view=graph-rest-beta&preserve-view=true) | Scoped role memberships. |
| [`microsoft.graph.device`](/graph/api/resources/device?view=graph-rest-beta&preserve-view=true) | Devices. |
| [`microsoft.graph.directoryRole`](/graph/api/resources/directoryrole?view=graph-rest-beta&preserve-view=true) | Directory roles. |
| [`microsoft.graph.unifiedRoleDefinition`](/graph/api/resources/unifiedroledefinition?view=graph-rest-beta&preserve-view=true) | Unified role definitions. |
| [`microsoft.graph.unifiedRoleAssignment`](/graph/api/resources/unifiedroleassignment?view=graph-rest-beta&preserve-view=true) | Unified role assignments. |
| [`microsoft.graph.invitation`](/graph/api/resources/invitation?view=graph-rest-beta&preserve-view=true) | Invitations. |
| [`microsoft.graph.authorizationPolicy`](/graph/api/resources/authorizationpolicy?view=graph-rest-beta&preserve-view=true) | Authorization policies. |
| [`microsoft.graph.crossTenantAccessPolicy`](/graph/api/resources/crosstenantaccesspolicy?view=graph-rest-beta&preserve-view=true) | Cross-tenant access policies. |
| [`microsoft.graph.crossTenantAccessPolicyConfigurationDefault`](/graph/api/resources/crosstenantaccesspolicyconfigurationdefault?view=graph-rest-beta&preserve-view=true) | Cross-tenant access default configurations. |
| [`microsoft.graph.crossTenantAccessPolicyConfigurationPartner`](/graph/api/resources/crosstenantaccesspolicyconfigurationpartner?view=graph-rest-beta&preserve-view=true) | Cross-tenant access partner configurations. |
| [`microsoft.graph.crossTenantIdentitySyncPolicyPartner`](/graph/api/resources/crosstenantidentitysyncpolicypartner?view=graph-rest-beta&preserve-view=true) | Cross-tenant identity synchronization partner policies. |
| [`microsoft.graph.conditionalAccessPolicy`](/graph/api/resources/conditionalaccesspolicy?view=graph-rest-beta&preserve-view=true) | Conditional Access policies. |
| [`microsoft.graph.countryNamedLocation`](/graph/api/resources/countrynamedlocation?view=graph-rest-beta&preserve-view=true) | Country/region named locations. |
| [`microsoft.graph.ipNamedLocation`](/graph/api/resources/ipnamedlocation?view=graph-rest-beta&preserve-view=true) | IP named locations. |
| [`microsoft.graph.privilegedAccessGroupAssignmentScheduleRequest`](/graph/api/resources/privilegedaccessgroupassignmentschedulerequest?view=graph-rest-beta&preserve-view=true) | Privileged access group assignment schedule requests. |
| [`microsoft.graph.privilegedAccessGroupEligibilityScheduleRequest`](/graph/api/resources/privilegedaccessgroupeligibilityschedulerequest?view=graph-rest-beta&preserve-view=true) | Privileged access group eligibility schedule requests. |
| [`microsoft.graph.agentUser`](/graph/api/resources/agentuser?view=graph-rest-beta&preserve-view=true) | Agent users. |
| [`microsoft.graph.agentIdentity`](/graph/api/resources/agentidentity?view=graph-rest-beta&preserve-view=true) | Agent identities. |
| [`microsoft.graph.agentIdentityBlueprint`](/graph/api/resources/agentidentityblueprint?view=graph-rest-beta&preserve-view=true) | Agent identity blueprints. |
| [`microsoft.graph.agentIdentityBlueprintPrincipal`](/graph/api/resources/agentidentityblueprintprincipal?view=graph-rest-beta&preserve-view=true) | Agent identity blueprint principals. |

## Actions

Specify an action target as the binding type followed by its fully qualified action name.

| Target | Binding types |
| --- | --- |
| [`microsoft.graph.addPassword`](/graph/api/application-addpassword?view=graph-rest-beta&preserve-view=true) | [`microsoft.graph.application`](/graph/api/resources/application?view=graph-rest-beta&preserve-view=true). |
| [`microsoft.graph.addPassword`](/graph/api/serviceprincipal-addpassword?view=graph-rest-beta&preserve-view=true) | [`microsoft.graph.servicePrincipal`](/graph/api/resources/serviceprincipal?view=graph-rest-beta&preserve-view=true). |
| [`microsoft.graph.removePassword`](/graph/api/application-removepassword?view=graph-rest-beta&preserve-view=true) | [`microsoft.graph.application`](/graph/api/resources/application?view=graph-rest-beta&preserve-view=true). |
| [`microsoft.graph.removePassword`](/graph/api/serviceprincipal-removepassword?view=graph-rest-beta&preserve-view=true) | [`microsoft.graph.servicePrincipal`](/graph/api/resources/serviceprincipal?view=graph-rest-beta&preserve-view=true). |
| [`microsoft.graph.addKey`](/graph/api/application-addkey?view=graph-rest-beta&preserve-view=true) | [`microsoft.graph.application`](/graph/api/resources/application?view=graph-rest-beta&preserve-view=true). |
| [`microsoft.graph.addKey`](/graph/api/serviceprincipal-addkey?view=graph-rest-beta&preserve-view=true) | [`microsoft.graph.servicePrincipal`](/graph/api/resources/serviceprincipal?view=graph-rest-beta&preserve-view=true). |
| [`microsoft.graph.removeKey`](/graph/api/application-removekey?view=graph-rest-beta&preserve-view=true) | [`microsoft.graph.application`](/graph/api/resources/application?view=graph-rest-beta&preserve-view=true). |
| [`microsoft.graph.removeKey`](/graph/api/serviceprincipal-removekey?view=graph-rest-beta&preserve-view=true) | [`microsoft.graph.servicePrincipal`](/graph/api/resources/serviceprincipal?view=graph-rest-beta&preserve-view=true). |
| [`microsoft.graph.addTokenSigningCertificate`](/graph/api/serviceprincipal-addtokensigningcertificate?view=graph-rest-beta&preserve-view=true) | [`microsoft.graph.servicePrincipal`](/graph/api/resources/serviceprincipal?view=graph-rest-beta&preserve-view=true). |
| [`microsoft.graph.assignLicense`](/graph/api/user-assignlicense?view=graph-rest-beta&preserve-view=true) | [`microsoft.graph.user`](/graph/api/resources/user?view=graph-rest-beta&preserve-view=true). |
| [`microsoft.graph.assignLicense`](/graph/api/group-assignlicense?view=graph-rest-beta&preserve-view=true) | [`microsoft.graph.group`](/graph/api/resources/group?view=graph-rest-beta&preserve-view=true). |
| [`microsoft.graph.instantiate`](/graph/api/applicationtemplate-instantiate?view=graph-rest-beta&preserve-view=true) | [`microsoft.graph.applicationTemplate`](/graph/api/resources/applicationtemplate?view=graph-rest-beta&preserve-view=true). |

For example, the application key action uses the target [`microsoft.graph.application/microsoft.graph.addKey`](/graph/api/application-addkey?view=graph-rest-beta&preserve-view=true).

Action selectors use the operation `invokeAction` and omit `includeDerivedTypes`.

## Operations

The policy contract uses `create`, `updateOrUpsert`, `delete`, and `invokeAction`. Listing a resource type doesn't establish that every operation or endpoint shape for that type is supported.

Use explicit operation metadata and test the intended request shape, including alternate keys, reference requests, or partial updates where relevant.

## Related content

- [Author resource policies with Rego](resource-policy-rego.md).
- [Test and troubleshoot a resource policy](resource-policy-test-troubleshoot.md).
- [Resource policy service limits](resource-policy-service-limits.md).
