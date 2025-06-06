---
title: Configure risk-based step-up consent
description: Learn how to disable and enable risk-based step-up consent to reduce user exposure to malicious apps that make illicit consent requests.

author: omondiatieno
manager: CelesteDG
ms.service: entra-id
ms.subservice: enterprise-apps

ms.topic: how-to
ms.date: 05/21/2025
ms.author: jomondi
ms.reviewer: phsignor
ms.custom: enterprise-apps, no-azure-ad-ps-ref, 
#customer intent: As an IT admin, I want to configure risk-based step-up consent in Microsoft Entra ID using PowerShell, so that I can reduce user exposure to malicious apps and ensure that admin approval is required for risky consent requests.
---
# Configure risk-based step-up consent using PowerShell

In this article, you learn how to configure risk-based step-up consent in Microsoft Entra ID. Risk-based step-up consent helps reduce user exposure to malicious apps that make [illicit consent requests](/microsoft-365/security/office-365-security/detect-and-remediate-illicit-consent-grants). 

For example, consent requests for newly registered multitenant apps that aren't [publisher verified](~/identity-platform/publisher-verification-overview.md) and require nonbasic permissions are considered risky. If a risky user consent request is detected, the request requires a "step-up" to admin consent instead. This step-up capability is enabled by default, but it results in a behavior change only when user consent is enabled.

When a risky consent request is detected, the consent prompt displays a message that indicates that admin approval is needed. If the [admin consent request workflow](configure-admin-consent-workflow.md) is enabled, the user can send the request to an admin for further review directly from the consent prompt. If the admin consent request workflow isn't enabled, the following message is displayed:

**AADSTS90094**: \<clientAppDisplayName> needs permission to access resources in your organization that only an admin can grant. Request an admin to grant permission to this app before you can use it.

In this case, an audit event is also logged with a category of "ApplicationManagement," an activity type of "Consent to application,"  and a status reason of "Risky application detected."

## Prerequisites

To configure risk-based step-up consent, you need:

- A user account. If you don't already have one, you can [create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
- A [Privileged Role Administrator](~/identity/role-based-access-control/permissions-reference.md#privileged-role-administrator).

## Disable or re-enable risk-based step-up consent

Use the [Microsoft Graph PowerShell beta module](/powershell/microsoftgraph/installation) to disable or enable the admin step-up when a risk is detected.

> [!IMPORTANT]
> Make sure you're using the Microsoft Graph PowerShell Beta cmdlets module.

1. Run the following command:

    ```powershell
    Install-Module Microsoft.Graph.Beta
    ```

1. Connect to Microsoft Graph PowerShell:

   ```powershell
   Connect-MgGraph -Scopes "Directory.ReadWrite.All"
   ```

1. Retrieve the current value for the **Consent Policy Settings** directory settings in your tenant. Doing so requires checking to see whether the directory settings for this feature are created. If they aren't created, use the values from the corresponding directory settings template.

    ```powershell
    $consentSettingsTemplateId = "dffd5d46-495d-40a9-8e21-954ff55e198a" # Consent Policy Settings
    $settings = Get-MgBetaDirectorySetting -All | Where-Object { $_.TemplateId -eq $consentSettingsTemplateId }
    if (-not $settings) {
        $params = @{
            TemplateId = $consentSettingsTemplateId
            Values = @(
                @{ 
                    Name = "BlockUserConsentForRiskyApps"
                    Value = "True"
                }
                @{ 
                    Name = "ConstrainGroupSpecificConsentToMembersOfGroupId"
                    Value = "<groupId>"
                }
                @{ 
                    Name = "EnableAdminConsentRequests"
                    Value = "True"
                }
                @{ 
                    Name = "EnableGroupSpecificConsent"
                    Value = "True"
                }
            )
        }
        $settings = New-MgBetaDirectorySetting -BodyParameter $params
    }
    $riskBasedConsentEnabledValue = $settings.Values | ? { $_.Name -eq "BlockUserConsentForRiskyApps" }
    ```

1. Check the value:

    ```powershell
    $riskBasedConsentEnabledValue
    ```

    Understand the settings value:

    | Setting       | Type         | Description  |
    | ------------- | ------------ | ------------ |
    | BlockUserConsentForRiskyApps   | Boolean |  A flag indicating whether user consent is blocked when a risky request is detected. |

1. To change the value of `BlockUserConsentForRiskyApps`, use the [Update-MgBetaDirectorySetting](/powershell/module/microsoft.graph.beta.identity.directorymanagement/update-mgbetadirectorysetting) cmdlet.

    ```powershell
    $params = @{
        TemplateId = $consentSettingsTemplateId
        Values = @(
            @{ 
                Name = "BlockUserConsentForRiskyApps"
                Value = "False"
            }
            @{ 
                Name = "ConstrainGroupSpecificConsentToMembersOfGroupId"
                Value = "<groupId>"
            }
            @{ 
                Name = "EnableAdminConsentRequests"
                Value = "True"
            }
            @{ 
                Name = "EnableGroupSpecificConsent"
                Value = "True"
            }
        )
    }
    Update-MgBetaDirectorySetting -DirectorySettingId $settings.Id -BodyParameter $params
    ```

## Next steps

- [Manage app consent policies](manage-app-consent-policies.md)
- [Configure the admin consent workflow](configure-admin-consent-workflow.md)
