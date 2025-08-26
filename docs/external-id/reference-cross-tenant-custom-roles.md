---
title: Custom roles for cross-tenant access settings
description: Learn how your organization can define custom roles to manage cross-tenant access settings, allowing for precise control without relying on built-in management roles.
author: csmulligan
manager: dougeby
ms.service: entra-external-id

ms.topic: reference
ms.date: 07/07/2025
ms.author: cmulligan
ms.custom: it-pro
---

# Create custom roles for managing cross-tenant access settings

Your organization can [define custom roles](../identity/role-based-access-control/custom-create.md) to manage cross-tenant access settings. These roles allow for precise control without relying on built-in management roles. This article provides guidance on creating recommended custom roles for managing cross-tenant access settings.

## Cross-tenant access administrator

This role can manage everything in cross-tenant access settings, including default and organizational based settings. This role should be assigned to users who need to manage all settings in cross-tenant access settings.

The following actions are recommended for this role.

| Actions |
| ------- |
| microsoft.directory/tenantRelationships/standard/read |
| microsoft.directory/crossTenantAccessPolicy/standard/read |
| microsoft.directory/crossTenantAccessPolicy/allowedCloudEndpoints/update |
| microsoft.directory/crossTenantAccessPolicy/basic/update |
| microsoft.directory/crossTenantAccessPolicy/default/b2bCollaboration/update |
| microsoft.directory/crossTenantAccessPolicy/default/b2bDirectConnect/update |
| microsoft.directory/crossTenantAccessPolicy/default/crossCloudMeetings/update |
| microsoft.directory/crossTenantAccessPolicy/default/standard/read |
| microsoft.directory/crossTenantAccessPolicy/default/tenantRestrictions/update |
| microsoft.directory/crossTenantAccessPolicy/partners/b2bCollaboration/update |
| microsoft.directory/crossTenantAccessPolicy/partners/b2bDirectConnect/update |
| microsoft.directory/crossTenantAccessPolicy/partners/create |
| microsoft.directory/crossTenantAccessPolicy/partners/crossCloudMeetings/update |
| microsoft.directory/crossTenantAccessPolicy/partners/delete |
| microsoft.directory/crossTenantAccessPolicy/partners/identitySynchronization/basic/update |
| microsoft.directory/crossTenantAccessPolicy/partners/identitySynchronization/create |
| microsoft.directory/crossTenantAccessPolicy/partners/identitySynchronization/standard/read |
| microsoft.directory/crossTenantAccessPolicy/partners/standard/read |
| microsoft.directory/crossTenantAccessPolicy/partners/tenantRestrictions/update |

## Cross-tenant access reader

This role can read everything in cross-tenant access settings, including default and organizational based settings. This role should be assigned to users who only need to review settings in cross-tenant access settings, but not manage them.

The following actions are recommended for this role.

| Actions |
| ------- |
| microsoft.directory.tenantRelationships/standard/read |
| microsoft.directory/crossTenantAccessPolicy/standard/read |
| microsoft.directory/crossTenantAccessPolicy/default/standard/read |
| microsoft.directory/crossTenantAccessPolicy/partners/identitySynchronization/standard/read |
| microsoft.directory/crossTenantAccessPolicy/partners/standard/read |

## Cross-tenant access partner administrator

This role can manage everything relating to partners and read the default settings. This role should be assigned to users who need to manage organizational based settings but not be able to change default settings.

The following actions are recommended for this role.

| Actions |
| ------- |
| microsoft.directory.tenantRelationships/standard/read |
| microsoft.directory/crossTenantAccessPolicy/standard/read |
| microsoft.directory/crossTenantAccessPolicy/basic/update |
| microsoft.directory/crossTenantAccessPolicy/default/standard/read |
| microsoft.directory/crossTenantAccessPolicy/partners/b2bCollaboration/update |
| microsoft.directory/crossTenantAccessPolicy/partners/b2bDirectConnect/update |
| microsoft.directory/crossTenantAccessPolicy/partners/create |
| microsoft.directory/crossTenantAccessPolicy/partners/crossCloudMeetings/update |
| microsoft.directory/crossTenantAccessPolicy/partners/delete |
| microsoft.directory/crossTenantAccessPolicy/partners/identitySynchronization/basic/update |
| microsoft.directory/crossTenantAccessPolicy/partners/identitySynchronization/create |
| microsoft.directory/crossTenantAccessPolicy/partners/identitySynchronization/standard/read |
| microsoft.directory/crossTenantAccessPolicy/partners/standard/read |
| microsoft.directory/crossTenantAccessPolicy/partners/tenantRestrictions/update |
