---
title: Use additional context in Authenticator notifications
description: Learn how to use additional context in multifactor authentication (MFA) notifications.
ms.service: entra-id
ms.subservice: authentication
ms.topic: how-to
ms.date: 03/04/2025
ms.author: justinha
author: mjsantani
ms.custom: sfi-image-nochange
# Customer intent: As an identity administrator, I want to encourage users to use the Authenticator app in Microsoft Entra ID to improve and secure user sign-in events.
---
# Use additional context in Authenticator notifications - Authentication methods policy

This article discusses how to improve the security of user sign-in by adding the application name and geographic location of the sign-in to Authenticator passwordless and push notifications.

## Prerequisites

- Your organization needs to enable Authenticator passwordless and push notifications for some users or groups by using the new Authentication methods policy. You can edit the Authentication methods policy by using the Microsoft Entra admin center or Microsoft Graph API.
- Additional context can be targeted to only a single group, which can be dynamic or nested. The group can be synchronized from on-premises or cloud-only.

## Passwordless phone sign-in and multifactor authentication

When a user receives a passwordless phone sign-in or multifactor authentication (MFA) push notification in Authenticator, they see the name of the application that requests the approval and the location based on the IP address from where the sign-in originated.

:::image type="content" border="false" source="./media/howto-authentication-passwordless-phone/location.png" alt-text="Screenshot that shows additional context in the MFA push notification.":::

Admins can combine additional context with [number matching](how-to-mfa-number-match.md) to further improve sign-in security.

:::image type="content" border="false" source="./media/howto-authentication-passwordless-phone/location-with-number-match.png" alt-text="Screenshot that shows additional context with number matching in the MFA push notification.":::

### Policy schema changes

You can enable and disable the application name and geographic location separately. Under `featureSettings`, you can use the following name mapping for each feature:

- **Application name**: `displayAppInformationRequiredState`
- **Geographic location**: `displayLocationInformationRequiredState`

> [!NOTE]
> Make sure that you use the new policy schema for Microsoft Graph APIs. In Graph Explorer, you need to consent to the `Policy.Read.All` and `Policy.ReadWrite.AuthenticationMethod` permissions.

Identify your single target group for each of the features. Then use the following API endpoint to change `displayAppInformationRequiredState` or `displayLocationInformationRequiredState properties` under `featureSettings` to `enabled` and include or exclude the groups you want:

```msgraph-interactive
GET https://graph.microsoft.com/v1.0/authenticationMethodsPolicy/authenticationMethodConfigurations/MicrosoftAuthenticator
```

For more information, see [microsoftAuthenticatorAuthenticationMethodConfiguration resource type](/graph/api/resources/microsoftAuthenticatorAuthenticationMethodConfiguration).

#### Example of how to enable additional context for all users

In `featureSettings`, change `displayAppInformationRequiredState` and `displayLocationInformationRequiredState` from `default` to `enabled`.

The value of Authentication mode is either `any` or `push`, depending on whether or not you also want to enable passwordless phone sign-in. In these examples, we use `any`, but if you don't want to allow passwordless, use `push`.

You might need to `PATCH` the entire schema to prevent overwriting any previous configuration. In that case, do a `GET` first. Then update only the relevant fields and then `PATCH`. The following example shows how to update `displayAppInformationRequiredState` and `displayLocationInformationRequiredState` under `featureSettings`.

Only users who are enabled for Authenticator under `includeTargets` see the application name or geographic location. Users who aren't enabled for Authenticator don't see these features.

```json
//Retrieve your existing policy via a GET. 
//Leverage the Response body to create the Request body section. Then update the Request body similar to the Request body as shown below.
//Change the Query to PATCH and Run query
 
{
    "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#authenticationMethodConfigurations/$entity",
    "@odata.type": "#microsoft.graph.microsoftAuthenticatorAuthenticationMethodConfiguration",
    "id": "MicrosoftAuthenticator",
    "state": "enabled",
    "featureSettings": {
        "displayAppInformationRequiredState": {
            "state": "enabled",
            "includeTarget": {
                "targetType": "group",
                "id": "all_users"
            },
            "excludeTarget": {
                "targetType": "group",
                "id": "00000000-0000-0000-0000-000000000000"
            }
        },
        "displayLocationInformationRequiredState": {
            "state": "enabled",
            "includeTarget": {
                "targetType": "group",
                "id": "all_users"
            },
            "excludeTarget": {
                "targetType": "group",
                "id": "00000000-0000-0000-0000-000000000000"
            }
        }
    },
    "includeTargets@odata.context": "https://graph.microsoft.com/v1.0/$metadata#authenticationMethodsPolicy/authenticationMethodConfigurations('MicrosoftAuthenticator')/microsoft.graph.microsoftAuthenticatorAuthenticationMethodConfiguration/includeTargets",
    "includeTargets": [
        {
            "targetType": "group",
            "id": "all_users",
            "isRegistrationRequired": false,
            "authenticationMode": "any",
        }
    ]
} 
```

#### Example of how to enable application name and geographic location for separate groups

In `featureSettings`, change `displayAppInformationRequiredState` and `displayLocationInformationRequiredState` from `default` to `enabled`.
Inside `includeTarget` for each `featureSetting`, change the ID from `all_users` to the object ID of the group from the Microsoft Entra admin center.

You need to `PATCH` the entire schema to prevent overwriting any previous configuration. We recommend that you do a `GET` first. Then update only the relevant fields and then `PATCH`. The following example shows an update to `displayAppInformationRequiredState` and `displayLocationInformationRequiredState` under `featureSettings`.

Only users who are enabled for Authenticator under `includeTargets` see the application name or geographic location. Users who aren't enabled for Authenticator don't see these features.

```json
{
    "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#authenticationMethodConfigurations/$entity",
    "@odata.type": "#microsoft.graph.microsoftAuthenticatorAuthenticationMethodConfiguration",
    "id": "MicrosoftAuthenticator",
    "state": "enabled",
    "featureSettings": {
        "displayAppInformationRequiredState": {
            "state": "enabled",
            "includeTarget": {
                "targetType": "group",
                "id": "44561710-f0cb-4ac9-ab9c-e6c394370823"
            },
            "excludeTarget": {
                "targetType": "group",
                "id": "00000000-0000-0000-0000-000000000000"
            }
        },
        "displayLocationInformationRequiredState": {
            "state": "enabled",
            "includeTarget": {
                "targetType": "group",
                "id": "a229e768-961a-4401-aadb-11d836885c11"
            },
            "excludeTarget": {
                "targetType": "group",
                "id": "00000000-0000-0000-0000-000000000000"
            }
        }
    },
    "includeTargets@odata.context": "https://graph.microsoft.com/v1.0/$metadata#authenticationMethodsPolicy/authenticationMethodConfigurations('MicrosoftAuthenticator')/microsoft.graph.microsoftAuthenticatorAuthenticationMethodConfiguration/includeTargets",
    "includeTargets": [
        {
            "targetType": "group",
            "id": "all_users",
            "isRegistrationRequired": false,
            "authenticationMode": "any",
        }
    ]
}
```

To verify, run `GET` again and verify the object ID:

```msgraph-interactive
GET https://graph.microsoft.com/v1.0/authenticationMethodsPolicy/authenticationMethodConfigurations/MicrosoftAuthenticator
```

#### Example of how to disable the application name and only enable the geographic location

In `featureSettings`, change the state of `displayAppInformationRequiredState` to `default` or `disabled` and `displayLocationInformationRequiredState` to `enabled`.
Inside `includeTarget` for each `featureSetting` value, change the ID from `all_users` to the object ID of the group from the Microsoft Entra admin center.

You need to `PATCH` the entire schema to prevent overwriting any previous configuration. We recommend that you do a `GET` first. Then update only the relevant fields and then `PATCH`. The following example shows an update to `displayAppInformationRequiredState` and `displayLocationInformationRequiredState` under `featureSettings`.

Only users who are enabled for Authenticator under `includeTargets` see the application name or geographic location. Users who aren't enabled for Authenticator don't see these features.

```json
{
    "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#authenticationMethodConfigurations/$entity",
    "@odata.type": "#microsoft.graph.microsoftAuthenticatorAuthenticationMethodConfiguration",
    "id": "MicrosoftAuthenticator",
    "state": "enabled",
    "featureSettings": {
        "displayAppInformationRequiredState": {
            "state": "disabled",
            "includeTarget": {
                "targetType": "group",
                "id": "44561710-f0cb-4ac9-ab9c-e6c394370823"
            },
            "excludeTarget": {
                "targetType": "group",
                "id": "00000000-0000-0000-0000-000000000000"
            }
        },
        "displayLocationInformationRequiredState": {
            "state": "enabled",
            "includeTarget": {
                "targetType": "group",
                "id": "a229e768-961a-4401-aadb-11d836885c11"
            },
            "excludeTarget": {
                "targetType": "group",
                "id": "00000000-0000-0000-0000-000000000000"
            }
        }
    },
    "includeTargets@odata.context": "https://graph.microsoft.com/v1.0/$metadata#authenticationMethodsPolicy/authenticationMethodConfigurations('MicrosoftAuthenticator')/microsoft.graph.microsoftAuthenticatorAuthenticationMethodConfiguration/includeTargets",
    "includeTargets": [
        {
            "targetType": "group",
            "id": "all_users",
            "isRegistrationRequired": false,
            "authenticationMode": "any",
        }
    ]
}
```

#### Example of how to exclude a group from the application name and geographic location

In addition, for each of the features, you change the ID of `excludeTarget` to the object ID of the group from the Microsoft Entra admin center. This change excludes that group from seeing the application name or geographic location.

You need to `PATCH` the entire schema to prevent overwriting any previous configuration. We recommend that you do a `GET` first. Then update only the relevant fields and then `PATCH`. The following example shows an update to `displayAppInformationRequiredState` and `displayLocationInformationRequiredState` under `featureSettings`.

Only users who are enabled for Authenticator under `includeTargets` see the application name or geographic location. Users who aren't enabled for Authenticator don't see these features.

```json
{
    "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#authenticationMethodConfigurations/$entity",
    "@odata.type": "#microsoft.graph.microsoftAuthenticatorAuthenticationMethodConfiguration",
    "id": "MicrosoftAuthenticator",
    "state": "enabled",
    "featureSettings": {
        "displayAppInformationRequiredState": {
            "state": "enabled",
            "includeTarget": {
                "targetType": "group",
                "id": "44561710-f0cb-4ac9-ab9c-e6c394370823"
            },
            "excludeTarget": {
                "targetType": "group",
                "id": "5af8a0da-5420-4d69-bf3c-8b129f3449ce"
            }
        },
        "displayLocationInformationRequiredState": {
            "state": "enabled",
            "includeTarget": {
                "targetType": "group",
                "id": "a229e768-961a-4401-aadb-11d836885c11"
            },
            "excludeTarget": {
                "targetType": "group",
                "id": "b6bab067-5f28-4dac-ab30-7169311d69e8"
            }
        }
    },
    "includeTargets@odata.context": "https://graph.microsoft.com/v1.0/$metadata#authenticationMethodsPolicy/authenticationMethodConfigurations('MicrosoftAuthenticator')/microsoft.graph.microsoftAuthenticatorAuthenticationMethodConfiguration/includeTargets",
    "includeTargets": [
        {
            "targetType": "group",
            "id": "all_users",
            "isRegistrationRequired": false,
            "authenticationMode": "any",
        }
    ]
}
```

#### Example of removing the excluded group

In `featureSettings`, change the states of `displayAppInformationRequiredState` from `default` to `enabled`. Change the ID of `excludeTarget` to `00000000-0000-0000-0000-000000000000`.

You need to `PATCH` the entire schema to prevent overwriting any previous configuration. We recommend that you do a `GET` first. Then update only the relevant fields and then `PATCH`. The following example shows an update to `displayAppInformationRequiredState` and `displayLocationInformationRequiredState` under `featureSettings`.

Only users who are enabled for Authenticator under `includeTargets` see the application name or geographic location. Users who aren't enabled for Authenticator don't see these features.

```json
{
    "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#authenticationMethodConfigurations/$entity",
    "@odata.type": "#microsoft.graph.microsoftAuthenticatorAuthenticationMethodConfiguration",
    "id": "MicrosoftAuthenticator",
    "state": "enabled",
    "featureSettings": {
        " displayAppInformationRequiredState ": {
            "state": "enabled",
            "includeTarget": {
                "targetType": "group",
                "id": "1ca44590-e896-4dbe-98ed-b140b1e7a53a"
            },
            "excludeTarget": {
                "targetType": "group",
                "id": " 00000000-0000-0000-0000-000000000000"
            }
        }
    },
    "includeTargets@odata.context": "https://graph.microsoft.com/v1.0/$metadata#authenticationMethodsPolicy/authenticationMethodConfigurations('MicrosoftAuthenticator')/microsoft.graph.microsoftAuthenticatorAuthenticationMethodConfiguration/includeTargets",
    "includeTargets": [
        {
            "targetType": "group",
            "id": "all_users",
            "isRegistrationRequired": false,
            "authenticationMode": "any"
        }
    ]
}
```

### Turn off additional context

To turn off additional context, you need to `PATCH` `displayAppInformationRequiredState` and `displayLocationInformationRequiredState` from `enabled` to `disabled`/`default`. You can also turn off only one of the features.

```json
{
    "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#authenticationMethodConfigurations/$entity",
    "@odata.type": "#microsoft.graph.microsoftAuthenticatorAuthenticationMethodConfiguration",
    "id": "MicrosoftAuthenticator",
    "state": "enabled",
    "featureSettings": {
        "displayAppInformationRequiredState": {
            "state": "disabled",
            "includeTarget": {
                "targetType": "group",
                "id": "44561710-f0cb-4ac9-ab9c-e6c394370823"
            },
            "excludeTarget": {
                "targetType": "group",
                "id": "00000000-0000-0000-0000-000000000000"
            }
        },
        "displayLocationInformationRequiredState": {
            "state": "disabled",
            "includeTarget": {
                "targetType": "group",
                "id": "a229e768-961a-4401-aadb-11d836885c11"
            },
            "excludeTarget": {
                "targetType": "group",
                "id": "00000000-0000-0000-0000-000000000000"
            }
        }
    },
    "includeTargets@odata.context": "https://graph.microsoft.com/v1.0/$metadata#authenticationMethodsPolicy/authenticationMethodConfigurations('MicrosoftAuthenticator')/microsoft.graph.microsoftAuthenticatorAuthenticationMethodConfiguration/includeTargets",
    "includeTargets": [
        {
            "targetType": "group",
            "id": "all_users",
            "isRegistrationRequired": false,
            "authenticationMode": "any",
        }
    ]
}
```

## Enable additional context in the Microsoft Entra admin center

To enable the application name or geographic location in the Microsoft Entra admin center, follow these steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Authentication Policy Administrator](~/identity/role-based-access-control/permissions-reference.md#authentication-policy-administrator).
1. Browse to **Entra ID** > **Authentication methods** > **Microsoft Authenticator**.
1. On the **Basics** tab, select **Yes** and **All users** to enable the policy for everyone. Change **Authentication mode** to **Any**.

   Only users who are enabled for Authenticator here are included in the policy to show the application name or geographic location of the sign-in, or excluded from it. Users who aren't enabled for Authenticator can't see the application name or geographic location.

   :::image type="content" border="true" source="./media/how-to-mfa-additional-context/enable-settings-additional-context.png" alt-text="Screenshot that shows how to enable Authenticator settings for Any authentication mode.":::

1. On the **Configure** tab, for **Show application name in push and passwordless notifications**, change **Status** to **Enabled**. Choose who to include or exclude from the policy, and then select **Save**.

   :::image type="content" border="true" source="./media/how-to-mfa-additional-context/enable-app-name.png" alt-text="Screenshot that shows how to enable the application name.":::

   Then do the same for **Show geographic location in push and passwordless notifications**.

   :::image type="content" border="true" source="./media/how-to-mfa-additional-context/enable-geolocation.png" alt-text="Screenshot that shows how to enable the geographic location.":::

   You can configure the application name and geographic location separately. For example, the following policy enables the application name and geographic location for all users but excludes the Operations group from seeing the geographic location.

   :::image type="content" border="true" source="./media/how-to-mfa-additional-context/exclude.png" alt-text="Screenshot that shows how to enable the application name and geographic location separately.":::

## Known issues

- Additional context isn't supported for Network Policy Server (NPS) or Active Directory Federation Services.
- Users can modify the location reported by iOS and Android devices. As a result, Authenticator is updating its security baseline for Location-Based Access Control (LBAC) Conditional Access policies. Authenticator denies authentications where the user might be using a different location than the actual GPS location of the mobile device where Authenticator is installed.  

  In the November 2023 release of Authenticator, users who modify the location of their device see a denial message in Authenticator when they do an LBAC authentication. Beginning in January 2024, any users who run older Authenticator versions are blocked from LBAC authentication with a modified location:
  
  - Authenticator version 6.2309.6329 or earlier on Android
  - Authenticator version 6.7.16 or earlier on iOS
  
  To find which users run older versions of Authenticator, use [Microsoft Graph APIs](/graph/api/resources/microsoftauthenticatorauthenticationmethod#properties).

## Related content

- [Authentication methods in Microsoft Entra ID - Microsoft Authenticator app](concept-authentication-authenticator-app.md)
