---
title: Overview of Microsoft Entra AD FS application migration
description: This guide provides an overview of the available tabs and configurations in the AD FS application migration. This overview outlines the supported and unsupported configurations, and provides useful troubleshooting tips for common issues.
services: active-directory
author: omondiatieno
manager: CelesteDG
ms.service: active-directory
ms.subservice: app-mgmt
ms.topic: conceptual
ms.workload: identity
ms.date: 09/26/2023
ms.author: jomondi
ms.reviewer: smriti3
ms.custom: not-enterprise-apps
---

# Migrate applications to Microsoft Entra ID with the AD FS application migration

The AD FS application migration provides IT Admins guided experience to migrate relying party applications from AD FS to Microsoft Entra ID. It provides one-click configuration for basic SAML URLs, claims mapping, and user assignments to integrate the application with Microsoft Entra ID.

With the wizard, all Relying party application configurations are imported from the on-premises environment. The **Ready to migrate** on the wizard's home page renders applications that are ready to migrate along with relying party application usage statistics such as unique user count, successful sign-in and failed sign-ins count. You can use these statistics to prioritize application migrations.

The wizard only supports migration of SAML applications. OIDC (OpenID Connect) and WS-Fed configurations aren't supported. For information on how to migrate other application types, see [Migrate applications to Microsoft Entra ID](migrate-adfs-apps-stages.md).
 
## The Migration Process

Access the list of applications that you can migrate using the AD FS application migration. The wizard displays only applications handling sign-in traffic within a specified time frame. The date range filter includes options for the last 1, 7, or 30 days. Inactive Relying Party Trusts that haven't handled sign-in traffic in the last 30 days don't appear on the Application migration's dashboard.

It's important to test your apps and configuration during the process of moving authentication to Microsoft Entra ID. We recommend using existing test environments or setting up a new one using Azure App Service or Azure Virtual Machines to ensure a smooth migration to the production environment. For a step by step guide on how to migrate your applications from AD FS using AD FS application migration, see [Migrate applications from AD FS to Microsoft Entra ID](migrate-adfs-application-wizard.md).

The following table explains the three tabs available in the AD FS application migration's home page.

| Tabs | Description |
| --- | --- |
| **All Apps** | Provides an application activity report for all SAML apps with sign-in activity. <br> Relying Party Trusts with yellow warning indicator and **Additional steps required** link are apps that require further configuration before migration. <br> Select the **additional steps required** button to analyze the blocking rules. Address the blocking rules on the on-premises side and wait for 24 hours for the AD FS Migration Insights job to reevaluate the configurations. <br> If no blocking issues are found, the application's new migration status will be identified during the next iteration. If the status is **Ready**, you can migrate the application using the wizard.<br><br> Relying Party Trusts that satisfy all migration rules appear with a green **Ready** icon under **Next steps**. <br> Selecting the **Ready** button shows all rules that passed and provides a **Begin migration** button. The **Begin migration** button launches the migration wizard. |
| **Ready to Migrate** | Lists those applications that are ready to migrate. For these applications, there are supported configurations. <br> <br> You can prioritize application migrations by referencing each application’s usage statics, which lists **Unique user** count, **Successful sign-ins** and **Failed sign-ins** count. In addition, all relying party application configurations are imported from the on-premises environment. <br><br> Selecting **Begin migration** under **Next Steps** launches the migration wizard. You can't access the **Begin migration** button if there aren't applications in the **Ready** state. |
| **Ready to Configure** | Lists all previously migrated applications. <br> Migrated applications are editable in the Microsoft Entra admin center under **Enterprise applications** pane. <br><br>Selecting the **Configure application in Microsoft Entra ID** button opens the **Single sign-on** pane of the newly created Microsoft Entra application. You can configure other Single Sign-on properties from this pane. |

When you're ready to complete configurations of the migrated application, use available tutorials to integrate SaaS apps with Microsoft Entra ID. See [Tutorial: Microsoft Entra single sign-on (SSO) integration with SaaS apps](../saas-apps/tutorial-list.md) to find tutorials for your apps.
Publish a migration schedule and prioritize apps based on urgency to have a list of all applications ready for migration.

## Supported configurations:

The AD FS application migration supports the following configurations:

- The option to customize the new Microsoft Entra application name.
- SAML application configurations only.
- Identifier and reply url, which are used for single sign-on settings.
- User and group membership assignments configurations.
- Microsoft Entra compatible claims configuration extracted from the Relying party claims configurations.

## Unsupported configurations:

The AD FS application migration doesn't support the following configurations:

- OIDC (OpenID Connect) and WS-Fed configurations.
- Conditional access policies.
- The signing certificate isn't migrated from the relying party application.
- You can configure the unsupported configurations after the application is migrated.


## Migration wizard configurations
|Tabs| Description|
|---|---|
|**Summary** | Gives a summary of all the configurations that are mapped from the relying party trust. It offers a field for the application's Microsoft Entra name |
| **Application Template**| This tab offers three options:<br> - Select the application template that best matches the application you're migrating. <br> - If the application template isn't listed, visit the Microsoft Entra Gallery to add the template.<br> - If you don't find it in the Microsoft Entra gallery, you can proceed to the next tab without selecting any of the templates. If you choose this option, migration proceeds with the default custom application template that Microsoft Entra ID provides. |
| **User & groups**| Automatically maps the users and groups from the on-premises environment to Microsoft Entra ID. Mapping of users is currently not supported. <br><br>In case you have groups associated with conditional access policies on the on-premises environment, aren't mapped to the Microsoft Entra application. So you see groups assigned to the migrated application|
|**SAML configurations**| SAML configurations from the on-premises environment to Microsoft Entra ID. <br><br>The assisted migration doesn't include mapping of **application identifier** and **reply URL**. To update these values, go to the Single sign-on pane of the newly created Microsoft Entra application |
|**Claims**| Automatically maps the claims from the on-premises environment to Microsoft Entra. <br><br> You may see fewer claims mapped to the Microsoft Entra application because only claims that can be translated to Microsoft Entra ID are mapped. Custom claims or claims transformations are currently not supported. <br><br> This tab doesn't support editing of claims. You can edit migrated claims or add/remove claims after migrating the application. |
|**Configuration results** | shows other warnings that were identified. These warnings require action and attention once the application is migrated to the Microsoft Entra tenant. |
|**Review + create**| |

## Troubleshooting

### Why am I getting **Download Agent** message instead of **Application Migration** report?

You're seeing the **Download Agent** pane instead of the **Application Migration** report because there's no AD FS to Microsoft Entra migration report data available for your on-premises environment. This could be due to the following reasons:
- Microsoft Entra Connect not being installed. For more information on how to install Microsoft Entra Connect, see [Install Microsoft Entra Connect](../hybrid/connect/how-to-connect-install-roadmap.md).
- Microsoft Entra Connect Health agents not being installed or properly configured. For more information on how to install and configure AD FS Health Agent, see [Install Microsoft Entra Connect Health Agent](../hybrid//connect/how-to-connect-health-agent-install.md).
- No user sign-ins activity against the AD FS Relying party trust in the last 30 days.

> [!NOTE]
> Newly installed agents or updated configurations require a 24-hour wait for AD FS migration jobs to process data by midnight GMT. After the 24-hour wait, you can access the **Application Migration** report.

### How can I roll back the migration?

If you want to roll back the migration, you can delete the newly configured application from the **Enterprise applications** pane. See [Delete an enterprise application in Microsoft Entra ID](delete-application-portal.md) for more information.

### Why am I getting **application with same identifier already exists** error while migration?

If you're getting an **application with same identifier already exists** error while migrating, it's likely because you previously attempted the migration and left the Enterprise application in your tenant. To address this issue, you need to manually delete the old Enterprise application instance from the **Enterprise applications** pane of the Microsoft Entra admin center and retry the migration.

### Why are more apps appearing in the **Enterprise applications** pane after a failed migration attempt? 

The migration process creates new app registration and enterprise application instances, but if there's a configuration failure, the old instances remain and must be manually deleted. To remove unused apps from your Microsoft Entra tenant, delete the app registration and Enterprise application instance from the **App Registrations** and **Enterprise applications** panes of the Microsoft Entra admin center. For more information on how to delete an app registration and enterprise application, see [Delete an app registration](../develop/howto-remove-app.md) and [Delete an enterprise application](delete-application-portal.md).

## Next steps

- [migrate-adfs-application-wizard](migrate-adfs-application-wizard.md)
- [Managing applications with Microsoft Entra ID](what-is-application-management.md)
- [Manage access to apps](what-is-access-management.md)