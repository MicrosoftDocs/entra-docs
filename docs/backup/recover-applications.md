---
title: Recover application secrets using Microsoft Entra Backup and Recovery
description: Learn how to recover application secrets and credentials after accidental or malicious changes using Microsoft Entra Backup and Recovery
ms.topic: how-to
ms.date: 03/09/2026
---

# Recover application secrets using Microsoft Entra Backup and Recovery (Preview)

> [!IMPORTANT]
> Microsoft Entra Backup and Recovery is currently in public preview. See the [Supplemental Terms of Use for Microsoft Azure Previews](https://azure.microsoft.com/support/legal/preview-supplemental-terms/) for legal terms that apply to Azure features that are in beta, preview, or otherwise not yet released into general availability.

This article describes the steps to restore application secrets that were impacted by accidental or malicious activity, in conjunction with Microsoft Entra Backup and Recovery.

## Prepare for recovery

As part of your disaster recovery plan for applications, review your current processes for managing application secrets and secret rotation. Using best practices for managing application secrets eases recovery from accidental or malicious edits. This article assumes you're using Azure Key Vault or another secure solution for managing your application secrets. For more information, see [Best practices for protecting secrets](/azure/security/fundamentals/secrets-best-practices).

Some properties on applications beyond application secrets aren't included in Backup and Recovery. Review the [Appendix](#application-and-service-principal-properties-not-supported-by-backup-and-recovery) for properties that might need to be saved and manually reapplied to fully recover an application from accidental edits.

If your application is hard-deleted, it can't be recovered using Backup and Recovery and needs to be recreated. An application is hard-deleted after being in the soft-deleted state for 30 days, or when the hard-delete API is called directly. Limit the ability to hard-delete objects to only highly privileged admins by using a [protected action](/entra/identity/role-based-access-control/protected-actions-overview#deletion-of-directory-objects), to prevent the early deletion of an application. Maintain a record of all registered applications and any customized settings in case you need to recreate the application. For more information about application deletion, see [Deletion and recovery of applications FAQ](/entra/identity/enterprise-apps/delete-recover-faq).

Document and validate the recovery steps needed for your application, service principals, and application secrets using a nonproduction environment or test application to ensure you understand the processes needed to restore the application and its secrets after an edit or soft-deletion.

In this article, the steps cover recovering from an application that was accidentally or maliciously changed. In cases where it can't be determined if a change was malicious, Microsoft recommends that you assume the change was malicious as part of a Zero Trust environment. In the case of malicious changes, it's important to contain threats and evict bad actors as part of your recovery plan. Those steps aren't outlined in this article.

## Determine the cause of the changes and what was impacted

The first step is to determine if the changes made to applications were accidental or malicious. Accidental changes are often the result of automation, scripts, and direct administrative actions that were performed in error. Malicious changes are those changes that occur due to the activities of a bad actor. If it's not possible to determine the source of the changes, assume that the changes are malicious.

After you determine the cause of the changes, validate whether the secrets for applications were impacted. Changes to application secrets can be found in the audit log by looking for events that indicate the application secret was changed or updated.

<!-- TODO: [REVIEW NEEDED] The original source noted a bug fix for audit log events is in progress. Verify the correct audit log event names to reference here. -->

Depending on the nature of the change and if secrets were impacted determines the best path for recovery for your applications. Any time an application, service principal, or user is recovered from soft-delete, the secret is recovered to the state it was in when the delete action occurred.

## Recover accidental changes when secrets weren't impacted

This includes scenarios where the application was edited or soft-deleted, but the secrets on the application weren't edited.

Using Backup and Recovery, recover the application and service principals to a point in time before the changes occurred. At this point the application should be able to function using the existing secret. If the application was deleted, secrets are restored to the state they were in when the application was deleted.

If your team uses Azure Key Vault, validate your secrets are functioning correctly using these steps:

1. Open the [Azure portal](https://portal.azure.com).
1. Go to your Azure Key Vault service.
1. Find the Key Vault that you configured with this application.
1. Browse to **Secrets** and select the secret to see the current version.

   :::image type="content" source="./media/recover-applications/key-vault-secrets-list.png" alt-text="The Azure Key Vault Secrets page showing a secret with Enabled status." lightbox="./media/recover-applications/key-vault-secrets-list.png":::

   :::image type="content" source="./media/recover-applications/key-vault-secret-versions.png" alt-text="The Azure Key Vault secret versions page showing the current version enabled and an older version disabled." lightbox="./media/recover-applications/key-vault-secret-versions.png":::

1. Select **Show Secret Value** and compare the first three characters of the secret with the secret value configured in your application registration in the Microsoft Entra admin center. If they match, your secrets were unaltered and continue to function as expected.

   :::image type="content" source="./media/recover-applications/key-vault-secret-value-comparison.png" alt-text="The Azure Key Vault secret version detail page with the secret value revealed, highlighting the first three characters for comparison." lightbox="./media/recover-applications/key-vault-secret-value-comparison.png":::

   :::image type="content" source="./media/recover-applications/entra-app-certificates-secrets.png" alt-text="The Certificates and secrets page for an application in the Microsoft Entra admin center, showing the first three characters of the secret value for comparison with Azure Key Vault." lightbox="./media/recover-applications/entra-app-certificates-secrets.png":::

> [!NOTE]
> You might also need to review properties on the application that aren't supported by Backup and Recovery to fully restore the application to a previous state. See the [Appendix](#application-and-service-principal-properties-not-supported-by-backup-and-recovery) for addressing unsupported properties.

## Recover accidental changes when secrets were altered or deleted

Using Backup and Recovery, recover the applications and service principals to a point in time before the changes occurred.

If your team uses Azure Key Vault, you need to roll the secret for your application. Follow the steps in [Recover applications due to a malicious change](#recover-applications-due-to-a-malicious-change) to roll the secret.

If your team uses another product for backing up your secrets, you can recover your secrets using your own process. Since the Application Object ID is unchanged, you should be able to use your standard process for verifying or rolling secrets to update the application.

> [!NOTE]
> You might need to review properties on the application that aren't supported by Backup and Recovery to fully restore the application to a previous state. See the [Appendix](#application-and-service-principal-properties-not-supported-by-backup-and-recovery) for addressing unsupported properties.

## Recover applications due to a malicious change

First, ensure you're actively working to contain the threat and evict any bad actors. While you could use the existing secrets if they weren't altered, it's a more secure practice to also rotate the secrets. If the secrets weren't impacted and you don't want to roll the secrets immediately, you can follow the same process as accidental changes with no secrets being altered. However, this isn't recommended.

If your team uses Azure Key Vault, you can roll the secrets using these steps.

**Create a new secret for your application:**

1. Open the [Microsoft Entra admin center](https://entra.microsoft.com).
1. Go to your application in **Application registrations**.
1. Go to **Certificates & secrets** to create a new secret.

   :::image type="content" source="./media/recover-applications/entra-app-add-client-secret.png" alt-text="The Add a client secret panel in the Microsoft Entra admin center with description and expiration fields." lightbox="./media/recover-applications/entra-app-add-client-secret.png":::

1. Copy the value of the secret to create a new version of the secret in Azure Key Vault.

   :::image type="content" source="./media/recover-applications/entra-app-new-secret-created.png" alt-text="The Certificates and secrets page showing two client secrets, including the newly created secret with its value." lightbox="./media/recover-applications/entra-app-new-secret-created.png":::

**Add a new version of the secret in Key Vault to manage your new secret:**

1. Open the [Azure portal](https://portal.azure.com).
1. Go to your Azure Key Vault service.
1. Find the Key Vault that you configured with this application.
1. Browse to **Secrets** and select the secret to see the current version.
1. Select **New Version** and create a new secret by specifying the new secret value from your application. Make sure that it's enabled.

   :::image type="content" source="./media/recover-applications/key-vault-create-secret-version.png" alt-text="The Azure Key Vault Create a secret form with the secret value field populated and the Enabled toggle set to Yes." lightbox="./media/recover-applications/key-vault-create-secret-version.png":::

1. Go back to the previous version of this secret and disable it.

   :::image type="content" source="./media/recover-applications/key-vault-disable-old-version.png" alt-text="The Azure Key Vault secret versions page showing the Disable option for an older secret version." lightbox="./media/recover-applications/key-vault-disable-old-version.png":::

1. Copy the new **Secret Identifier** value and update it in code for your application as needed.

   :::image type="content" source="./media/recover-applications/key-vault-new-secret-identifier.png" alt-text="The Azure Key Vault secret version detail page with the Secret Identifier URL highlighted for copying to the application." lightbox="./media/recover-applications/key-vault-new-secret-identifier.png":::

If your team uses another product for backing up your secrets, roll the secrets using your own process. Since the Application Object ID is unchanged, you should be able to use your standard process for rolling secrets to update the impacted applications.

At this point, the application should be able to function using the rolled secrets.

> [!NOTE]
> You might need to review properties on the application that aren't supported by Backup and Recovery to fully restore the application to a previous state. See the [Appendix](#application-and-service-principal-properties-not-supported-by-backup-and-recovery) for addressing unsupported properties.

## If the application was hard-deleted and not recoverable

If your application was hard-deleted, it can't be recovered by Backup and Recovery. Since you need to recreate the application, you can't reuse any stored secrets.

If you use Azure Key Vault, you should point it to the new application and new secrets:

1. Open the [Azure portal](https://portal.azure.com).
1. Go to your Azure Key Vault service.
1. Find the Key Vault that you configured with this application.
1. Browse to **Secrets** and select the secret to see the current version.
1. Select **New Version** and create a new secret by specifying the new secret value from your application. Make sure that it's enabled.
1. Go back to the previous version of this secret and disable it.
1. Copy the new **Secret Identifier** value and update it in your application as needed.

For other solutions, you either need to generate and apply a new secret to your application, or update the Object ID in your secret management system and then readd the secret to the newly created application.

## Appendix

### Application and service principal properties not supported by Backup and Recovery

Using Backup and Recovery, recover the applications and service principals to a point in time before the malicious activity occurred. This capability supports recovery of a limited set of properties: *displayName*, *description*, *notes*, *applicationTag*, *appIdentifierUri*, *publicClient*, *publisherDomain*, *isDeviceOnlyAuthSupported*, and *serviceManagementReference*. Additional properties will be supported in the upcoming public preview.

Review key application settings such as redirect URIs, supported account types, assigned permissions or roles, and exposed API properties to ensure your application functions as expected after recovery:

1. The [claims policy](/entra/identity-platform/reference-claims-customization) and [home realm discovery policy](/entra/identity/enterprise-apps/configure-authentication-for-federated-users-portal?pivots=ms-powershell#create-an-hrd-policy-using-microsoft-graph-powershell) attached to the application can't be restored. You might have to configure the policies again.
1. If managed identities are attached to the application, they aren't restored.
1. If you configured the application for Application Proxy, the application proxy configuration can't be restored. You need to use endpoints under **onPremisesPublishing** to recreate the Application Proxy settings.
