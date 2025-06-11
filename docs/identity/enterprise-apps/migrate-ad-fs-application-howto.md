---
title: Use the AD FS application migration to move AD FS apps to Microsoft Entra ID
description: Learn how to use the AD FS application migration to migrate AD FS relying party applications from ADFS to Microsoft Entra ID. This guided experience provides one-click configuration for basic SAML URLs, claims mapping, and user assignments to integrate the application with Microsoft Entra ID.
author: omondiatieno
manager: CelesteDG
ms.service: entra-id
ms.subservice: enterprise-apps
ms.topic: how-to
ms.date: 06/10/2024
ms.author: jomondi
ms.reviewer: smriti3
ms.custom: not-enterprise-apps, sfi-image-nochange
#customer intent: As an IT admin currently using AD FS to access applications, I want to migrate my AD FS applications to Microsoft Entra ID using the AD FS application migration wizard, so that I can have a unified experience to discover, evaluate, and configure new Microsoft Entra applications.
---

# Use AD FS application migration to move AD FS apps to Microsoft Entra ID

In this article, you learn how to migrate your Active Directory Federation Services (AD FS) applications to Microsoft Entra ID using the AD FS application migration.

The AD FS application migration provides IT Admins guided experience to migrate AD FS relying party applications from AD FS to Microsoft Entra ID. The wizard gives you a unified experience to discover, evaluate, and configure new Microsoft Entra application. It provides one-click configuration for basic SAML URLs, claims mapping, and user assignments to integrate the application with Microsoft Entra ID.

The AD FS application migration tool is designed to provide end-to-end support to migrate your on-premises AD FS applications to Microsoft Entra ID.

With AD FS application migration you can:

- **Evaluate AD FS relying party application sign-in activities**, which helps you to identify the usage and impact of the given applications.
- **Analyze AD FS to Microsoft Entra migration feasibility** that helps you to identify migration blockers or actions required to migrate their applications to Microsoft Entra platform.
- **Configure new Microsoft Entra application using one-click application migration process**, which automatically configures a new Microsoft Entra application for the given AD FS application.

## Prerequisites

To use the AD FS application migration:

- Your organization must be currently using AD FS to access applications.
- You have a Microsoft Entra ID P1 or P2 license.
- You should have one of the following roles assigned,
  - Cloud Application Administrator
  - Application Administrator
  - Global Reader (read-only access)
  - Report Reader (read-only access)
- Microsoft Entra Connect should be installed on the on-premises environments, alongside Microsoft Entra Connect Health AD FS health agents.
  - [Microsoft Entra Connect](https://www.microsoft.com/download/details.aspx?id=47594)
  - [Microsoft Entra Connect Heath AD FS agents](https://go.microsoft.com/fwlink/?LinkID=518973)

There are couple reasons why you won't see all the applications that you're expecting after you have installed Microsoft Entra Connect Health agents for AD FS:

- The AD FS application migration dashboard only shows AD FS applications that have user logins in the last 30 days.
- Microsoft related AD FS relying party applications aren't available on the dashboard.

## View AD FS application migration dashboard in Microsoft Entra ID

The AD FS application migration dashboard is available in the Microsoft Entra admin center under **Usage & insights** reporting. There are a two entry points to the wizard:

From **Enterprise applications** section:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**.
1. Under **Usage & Insights**, select **AD FS application migration** to access the AD FS applications migration dashboard.

From **Monitoring & health** section:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Monitoring & health** > **Usage & insights**.
1. Under **Manage**, select **Usage & Insights**, and then select **AD FS application migration** to access the AD FS applications migration dashboard.

The AD FS application migration dashboard shows the list of all your AD FS relying party applications that have actively had sign-in traffic in the last 30 days period.

The dashboard has the date range filter. The filter allows you to select all the active AD FS relying party application as per selected time range. The filter supports last 1 day, 7 days, and 30 days period.

There are three tabs that give the complete list of applications, configurable applications, and previously configured applications. From this dashboard, you see an overview of overall progress of your migration work.

The three tabs on the dashboard are:

- **All apps** - shows the list of all applications that are discovered from your on-premises environment.
- **Ready to migrate** - shows list of all the applications that have **Ready** or **Needs review** migration status.
- **Ready to configure** - shows the list of all the Microsoft Entra applications that were previously migrated using AD FS application migration wizard.

### Application migration status

The Microsoft Entra Connect and Microsoft Entra Connect Health agents for AD FS reads your AD FS relying party application configurations and sign-in audit logs. This data about each AD FS application is analyzed to determine whether the application can be migrated as-is, or if additional review is needed. Based on the result of this analysis, migration status for the given application is indicated as one of the following statuses:

- **Ready to migrate** means, the AD FS application configuration is fully supported in Microsoft Entra ID and can be migrated as-is.
- **Needs review** means, some of the application's settings can be migrated to Microsoft Entra ID, but you need to review the settings that can't be migrated as-is. However, those aren't blocker for the migration.
- **Additional steps required** means, Microsoft Entra ID doesn't support some of the application's settings, so the application can't be migrated in its current state.

Let's review each tab on the AD FS application migration dashboard in more detail.

### All apps tab

The **All apps** tab shows all active AD FS relying party applications from selected date range. User can analyze the impact of each application by using the aggregated sign-in data. They can also navigate to the details pane by using the **Migration status** link.

To view details about each validation rule, see [AD FS application migration validation rules](migrate-ad-fs-application-overview.md#ad-fs-application-migration-validation-tests).

:::image type="content" source="media/migrate-ad-fs-application-howto/migration-details.png" alt-text="Screenshot of the AD FS application migration details pane.":::

Select a message to open additional migration rule details. For a full list of the properties tested, see the following configuration tests table.

#### Check the results of claim rule tests

If you have configured a claim rule for the application in AD FS, the experience provides a granular analysis of all the claim rules. You see which claim rules you can move to Microsoft Entra ID and which ones need further review.

1. Select an app from the list of apps in the **All apps** tab, then select the status in the **Migration status** column to view migration details. You see a summary of the configuration tests that passed, along with any potential migration issues.
2. On the **Migration rule details** page, expand the results to display details about potential migration issues and to get additional guidance. For a detailed list of all claim rules tested, see the [claim rule tests](#claim-rule-tests) section in this article.

The following example shows migration rule details for the IssuanceTransform rule. It lists the specific parts of the claim that need to be reviewed and addressed before you can migrate the application to Microsoft Entra ID.

:::image type="content" source="media/migrate-ad-fs-application-howto/migration-rules-details.png" alt-text="Screenshot of the AD FS application migration rules details pane.":::

#### Claim rule tests

The following table lists all claim rule tests that are performed on AD FS applications.

|Property  |Description  |
|---------|---------|
|UNSUPPORTED_CONDITION_PARAMETER      | The condition statement uses Regular Expressions to evaluate if the claim matches a certain pattern.  To achieve a similar functionality in Microsoft Entra ID, you can use predefined transformation such as  IfEmpty(), StartWith(), Contains(), among others. For more information, see [Customize claims issued in the SAML token for enterprise applications](~/identity-platform/saml-claims-customization.md).          |
|UNSUPPORTED_CONDITION_CLASS      | The condition statement has multiple conditions that need to be evaluated before running the issuance statement. Microsoft Entra ID can support this functionality with the claim’s transformation functions where you can evaluate multiple claim values.  For more information, see [Customize claims issued in the SAML token for enterprise applications](~/identity-platform/saml-claims-customization.md).          |
|UNSUPPORTED_RULE_TYPE      | The claim rule couldn’t be recognized. For more information on how to configure claims in Microsoft Entra ID, see [Customize claims issued in the SAML token for enterprise applications](~/identity-platform/saml-claims-customization.md).          |
|CONDITION_MATCHES_UNSUPPORTED_ISSUER      | The condition statement uses an Issuer that isn't supported in Microsoft Entra ID. Currently, Microsoft Entra doesn’t source claims from stores different that Active Directory or Microsoft Entra ID. If this is blocking you from migrating applications to Microsoft Entra ID, [let us know](https://feedback.azure.com/d365community/forum/22920db1-ad25-ec11-b6e6-000d3a4f0789).         |
|UNSUPPORTED_CONDITION_FUNCTION      | The condition statement uses an aggregate function to issue or add a single claim regardless of the number of matches.  In Microsoft Entra ID, you can evaluate the attribute of a user to decide what value to use for the claim with functions like IfEmpty(), StartWith(), Contains(), among others. For more information, see [Customize claims issued in the SAML token for enterprise applications](~/identity-platform/saml-claims-customization.md).          |
|RESTRICTED_CLAIM_ISSUED      | The condition statement uses a claim that is restricted in Microsoft Entra ID. You might be able to issue a restricted claim, but you can’t modify its source or apply any transformation. For more information, see [Customize claims emitted in tokens for a specific app in Microsoft Entra ID](~/identity-platform/saml-claims-customization.md).          |
|EXTERNAL_ATTRIBUTE_STORE      | The issuance statement uses an attribute store different that Active Directory. Currently, Microsoft Entra doesn’t source claims from stores different that Active Directory or Microsoft Entra ID. If this result is blocking you from migrating applications to Microsoft Entra ID, [let us know](https://feedback.azure.com/d365community/forum/22920db1-ad25-ec11-b6e6-000d3a4f0789).          |
|UNSUPPORTED_ISSUANCE_CLASS      | The issuance statement uses ADD to add claims to the incoming claim set. In Microsoft Entra ID, this can be configured as multiple claim transformations.  For more information, see [Customize claims issued in the SAML token for enterprise applications](~/identity-platform/saml-claims-customization.md).         |
|UNSUPPORTED_ISSUANCE_TRANSFORMATION      | The issuance statement uses Regular Expressions to transform the value of the claim to be emitted. To achieve similar functionality in Microsoft Entra ID, you can use predefined transformation such as `Extract()`, `Trim()`, and `ToLower()`. For more information, see [Customize claims issued in the SAML token for enterprise applications](~/identity-platform/saml-claims-customization.md).          |

### Ready to migrate tab

The **Ready to migrate** tab shows all the applications that have migration status as **Ready** or **Needs review**.

You can use the sign-in data to identify the impact of each application and select the right applications for the migration. Select **Begin migration** link to initiate the assisted one-click application migration process.

### Ready to configure tab

This tab shows list of all the Microsoft Entra applications that were previously migrated using AD FS application migration wizard.

The **Application name** is the name of new Microsoft Entra application. **Application identifier** is same as of AD FS relying party application identifier that can be used to correlate the application with your AD FS environment. The **Configure application in Microsoft Entra** link enables you to navigate to the newly configured Microsoft Entra application within the **Enterprise application** section.

## Migrate an app from AD FS to Microsoft Entra ID using AD FS application migration wizard

1. To initiate the application migration, select the **Begin migration** link for the application you want to migrate from the **Ready to migrate** tab.
1. The link redirects you to assisted one-click application migration section of the AD FS application migration wizard. All the configurations on the wizard are imported from your on-premises AD FS environment.

Before we go through the details of the various tabs in the wizard, it's important to understand the supported and unsupported configurations.

### Supported configurations

The assisted AD FS application migration supports the following configurations:

- Supports SAML application configuration only.
- The option to customize the new Microsoft Entra application name.
- Allows users to select any application template from the application template galley.
- Configuration of basic SAML application configurations that is, identifier and reply URL.
- Configuration of Microsoft Entra application to allow all users from the tenant.
- Auto assignment of groups to the Microsoft Entra application.
- Microsoft Entra compatible claims configuration extracted from the AD FS relying party claims configurations.

### Unsupported configurations:

The AD FS application migration doesn't support the following configurations:

- OIDC (OpenID Connect), OAuth, and WS-Fed configurations aren't supported.
- Auto configuration of Conditional Access policies isn't supported, however, user can configure the same after configuration of new application into their tenant.
- The signing certificate isn't migrated from the AD FS relying party application.
The following tabs exist in the AD FS application migration wizard:

Let's look at the details of each tab in the assisted one-click application migration section of the AD FS application migration wizard

### Basics tab

- **Application name** that is prepopulated with AD FS relying party application name. You can use it as the name for your new Microsoft Entra application. You can also modify the name to any other value you prefer.
- **Application template**. Select any application template that is most suitable for your application. You can skip this option if you don't want to use any template.

### User & groups tab

The on-click configuration automatically assigns the users and groups to your Microsoft Entra application that are same as of your on-premises configuration.

All the groups are extracted from the access control policies of the AD FS relying party application. Groups should be synced into your Microsoft Entra tenant using Microsoft Entra Connect agents. In case groups are mapped with AD FS relying party application, but aren't synced with Microsoft Entra tenant. Those groups are skipped from configuration.

Assisted users and groups configuration supports the following configurations from the on-premises AD FS environment:

- Permit everyone from the tenant.
- Permit specific groups.

:::image type="content" source="media/migrate-ad-fs-application-howto/user-group-settings-on-premises.png" alt-text="Screenshot of the AD FS users and groups settings pane.":::

These are the users and groups you can view on the configuration wizard. This is a read-only view, you can't make any changes to this section.

### SAML configurations tab

This tab shows the basic SAML properties that are used for the Single sign-on settings of the Microsoft Entra application. Currently, only required properties are mapped which are Identifier and Reply URL only.

These settings are directly implemented from your AD FS relying party application and can't be modified from this tab. However, after configuring application, you can modify these from the Microsoft Entra admin center's Single sign-on pane of your enterprise application.

:::image type="content" source="media/migrate-ad-fs-application-howto/saml-configurations-on-premises.png" alt-text="Screenshot of the AD FS SAML configurations pane.":::

:::image type="content" source="media/migrate-ad-fs-application-howto/saml-configuration-migration-wizard.png" alt-text="Screenshot of the AD FS application migration SAML configurations tab.":::

### Claims tab

All AD FS claims don't get translated as is to the Microsoft Entra claims. The migration wizard supports specific claims only. If you find any missing claims, you can configure them on the migrated enterprise application in Microsoft Entra admin center.

In case, AD FS relying party application has `nameidentifier` configured which is supported in Microsoft Entra ID, then it's configured as `nameidentifier`. Otherwise, `user.userprincipalname` is used as default nameidentifier claim.

:::image type="content" source="media/migrate-ad-fs-application-howto/claims-configurations-on-premises.png" alt-text="Screenshot of the AD FS claims configurations pane.":::

This is read-only view, you can't make any changes here.

:::image type="content" source="media/migrate-ad-fs-application-howto/claims-configurations-application-migration.png" alt-text="Screenshot of the AD FS application migration claims configurations tab.":::

### Next steps tab

This tab provides information about next steps or reviews that are expected from the user's side. The following example shows the list of configurations for this AD FS relying party application, which aren't supported in Microsoft Entra ID.

From this tab, you can access the relevant documentation to investigate and understand the issues.

:::image type="content" source="media/migrate-ad-fs-application-howto/next-steps-tab.png" alt-text="Screenshot of the AD FS application migration next steps tab.":::

### Review + create tab

This tab shows the summary of all the configurations that you have seen from the previous tabs. You can review it once again. If you're happy with all the configurations and you want to go ahead with application migration, select the **Create** button to start the migration process. This migrates the new application into your Microsoft Entra tenant.

The application migration is currently a nine step process that you can monitor using the notifications. The workflow completes the following actions:

- Creates an application registration
- Creates a service principal
- Configures SAML settings
- Assigns users and groups to the application
- Configures claims

Once the migration process is complete, you see a notification message that reads **Application migration successful**.

:::image type="content" source="media/migrate-ad-fs-application-howto/application-configuration-successful.png" alt-text="Screenshot of the application migration successful message.":::

On application migration completion, you get redirected to the **Ready to configure** tab where all previously migrated applications are shown, including the latest ones that you've configured.

## Review and configure the enterprise application

1. From the **Ready to configure** tab, you can use the **Configure application in Microsoft Entra** link to navigate to the newly configured application under the "**Enterprise applications**" section. By default, it goes into the **SAML-based Sign-on** page of your application.

   :::image type="content" source="media/migrate-ad-fs-application-howto/saml-based-sign-on-pane.png" alt-text="Screenshot of the SAML-based sign-on pane.":::

1. From the **SAML-based Sign-on** pane, all AD FS relying party application settings are already applied to the newly migrated Microsoft Entra application. The **Identifier** and **Reply URL** properties from the **Basic SAML Configuration** and list of claims from the **Attributes & Claims** tabs of the AD FS application migration wizard are the same as those on the enterprise application.

1. From the **Properties** pane of the application, the application template logo implies that the application is linked to the selected application template. On the **Owners** page, the current administrator user gets added as a one of the owners of the application.

1. From **Users and groups** pane, all required groups are already assigned to the application.

After reviewing the migrated enterprise application, you can update the application as per your business needs. You can add or update claims, assign more users and groups or configure Conditional Access policies to enable support for multifactor authentication or other conditional authorization features.

## Rollback

The one-click configuration of AD FS application migration wizard migrates the new application into Microsoft Entra tenant. However, the migrated application remains inactive until you redirect your sign-in traffic to it. Until then, if you want to roll back, you can delete the newly migrated Microsoft Entra application from your tenant.

The wizard doesn't provide any automated clean-up. In case you don't want to proceed with setting up the migrated application, you have to manually delete the application from your tenant. For instructions on how to delete an application registration and its corresponding enterprise application, see the following URLs:

- [Delete an application registration](~/identity-platform/howto-remove-app.md)
- [Delete an enterprise application](delete-application-portal.md)

## Troubleshooting tips

### Can't see all my AD FS applications in the report

If you have installed Microsoft Entra Connect Health agents for AD FS but you still see the prompt to install it or you don't see all your AD FS applications in the report, it might be that you don't have active AD FS applications, or your AD FS applications are Microsoft application.

> [!NOTE]
> The AD FS application migration lists all the AD FS applications in your organization with active users sign-in in the last 30 days only.
> The report doesn't display Microsoft related relying parties in AD FS such as Office 365. For example, relying parties with name `urn:federation:MicrosoftOnline`, `microsoftonline`, `microsoft:winhello:cert:prov:server` don't show up in the list.

### Why am I seeing the validation error "application with same identifier already exists"?

Each application within your tenant should have a unique application identifier. If you see this error message, it means you already have another application with the same identifier in your Microsoft Entra tenant. In this case, you either need to update the existing application identifier or update your AD FS relying party application identifier and wait for 24 hours to get updates reflected.

## Next steps

- [Managing applications with Microsoft Entra](what-is-application-management.md)
- [Manage access to apps](what-is-access-management.md)
