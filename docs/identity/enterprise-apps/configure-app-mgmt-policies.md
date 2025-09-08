---
title: Configure restrictions on how applications can be configured

description: Configure app management policies in Microsoft Entra ID to set restrictions on how apps and service principals in your tenant can be configured. Secure your environment with step‑by‑step guidance.

author: arcrowe
manager: CelesteDG
ms.service: entra-id
ms.subservice: enterprise-apps

ms.topic: how-to
ms.date: 07/23/2025
ms.author: arcrowe
ms.reviewer: arcrowe
ms.custom: enterprise-apps
#zone_pivot_groups: enterprise-apps-minus-ps


#customer intent: As an IT admin, I want to configure app management policies, to prevent applications and service principals in my tenant from being configured insecurely and prevent attack risk.
---

# Configure restrictions on how applications can be configured

In this article, you learn how to configure app management policies in Microsoft Entra ID to control how app owners and administrators can configure applications and service principals in your organization.  This guidance helps administrators reduce security risks caused by insecure configurations.

The set of restrictions available to configure currently include:

| Restriction name            | Description                                                             | Security value | Availability                                                                                                                                    |
| :-------------------------- | :---------------------------------------------------------------------- | :-------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------- |
| asymmetricKeyLifetime       | Enforce a max lifetime range for an asymmetric key (certificate).       | Reduces security risk from long-lived credentials                               |  Can be configured through [app management policy APIs](https://learn.microsoft.com/en-us/graph/api/resources/applicationauthenticationmethodpolicy?view=graph-rest-beta) and the [Entra admin center](https://aka.ms/app-mgmt-policy-ux).  Referred to as `Restrict max certificate lifetime` in the Entra admin center. |
| audiences                   | Restricts creation or promotion of apps based on signInAudience values. | Prevents unsanctioned multi-tenant or consumer-facing applications | Can be configured through [app management policy APIs](https://learn.microsoft.com/en-us/graph/api/resources/applicationauthenticationmethodpolicy?view=graph-rest-beta) |
| customPasswordAddition      | Restrict a custom password secret on application or service principal.  | Prevents new user-provided app passwords, which are more easily compromised than system-generated ones  | Can be configured through [app management policy APIs](https://learn.microsoft.com/en-us/graph/api/resources/applicationauthenticationmethodpolicy?view=graph-rest-beta) and the [Entra admin center](https://aka.ms/app-mgmt-policy-ux).  Referred to as `Block custom passwords` in the Entra admin center. |
| nonDefaultUriAddition       | Block new identifier URIs for apps unless they are one of the default formats `api://{appId}` or `api://{tenantId}/{appId}`.      | Reduces security risk from improper audience validation                            | Can be configured through [app management policy APIs](https://learn.microsoft.com/en-us/graph/api/resources/applicationauthenticationmethodpolicy?view=graph-rest-beta) and the [Entra admin center](https://aka.ms/app-mgmt-policy-ux).  Referred to as `Block custom identifier URIs` in the Entra admin center. |
| uriAdditionWithoutUniqueTenantIdentifier       | Block new identifier URIs for apps unless they are one of the [secure formats](https://aka.ms/identifier-uri-policy).     | Reduces security risk from audience overlap                        | Can be configured through [app management policy APIs](https://learn.microsoft.com/en-us/graph/api/resources/applicationauthenticationmethodpolicy?view=graph-rest-beta) and the [Entra admin center](https://aka.ms/app-mgmt-policy-ux).  Referred to as `Block identifier URIs without unique tenant identifier` in the Entra admin center. |
| passwordAddition            | Block the addition of new passwords (also referred to as secrets) on applications altogether.                   | Prevents new passwords, which are the most easily compromised form of credential                                                                        | Can be configured through [app management policy APIs](https://learn.microsoft.com/en-us/graph/api/resources/applicationauthenticationmethodpolicy?view=graph-rest-beta) and the [Entra admin center](https://aka.ms/app-mgmt-policy-ux).  In the Entra admin center, combined with the `symmetricKeyAddition` restriction under the `Block password addition` setting. |
| passwordLifetime            | Enforce a max lifetime range for a password secret.                     | Reduces security risk from long-lived credentials | Can be configured through [app management policy APIs](https://learn.microsoft.com/en-us/graph/api/resources/applicationauthenticationmethodpolicy?view=graph-rest-beta) and the [Entra admin center](https://aka.ms/app-mgmt-policy-ux).  In the Entra admin center, combined with the `symmetricKeyLifetime` restriction under the `Restrict max password lifetime` setting. |
| symmetricKeyAddition        | Restrict symmetric keys on applications.                                | Prevents new symmetric keys, which are effectively passwords - the most easily compromised form of credential                                                                      | Can be configured through [app management policy APIs](https://learn.microsoft.com/en-us/graph/api/resources/applicationauthenticationmethodpolicy?view=graph-rest-beta) and the [Entra admin center](https://aka.ms/app-mgmt-policy-ux).  In the Entra admin center, combined with the `passwordAddition` restriction under the `Block password addition` setting. |
| symmetricKeyLifetime        | Enforce a max lifetime range for a symmetric key.                       | Reduces security risk from long-lived credentials                                         | Can be configured through [app management policy APIs](https://learn.microsoft.com/en-us/graph/api/resources/applicationauthenticationmethodpolicy?view=graph-rest-beta) and the [Entra admin center](https://aka.ms/app-mgmt-policy-ux).  In the Entra admin center, combined with the `passwordLifetime` restriction under the `Restrict max password lifetime` setting.  |
| trustedCertificateAuthority | Block new certificate credentials if the issuer is not listed in the trusted certificate authority list.                    | Ensures only trusted CAs are used by apps in your tenant                             | Can be configured through [app management policy APIs](https://learn.microsoft.com/en-us/graph/api/resources/applicationauthenticationmethodpolicy?view=graph-rest-beta). |

To learn more about how the app management policy API works, visit the [API documentation](https://learn.microsoft.com/en-us/graph/api/resources/applicationauthenticationmethodpolicy?view=graph-rest-beta).

## Prerequisites

To configure app management policies, you need:

- A user account. If you don't already have one, you can [create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
- The [Security Administrator](~/identity/role-based-access-control/permissions-reference#security-administrator) role, AND the [Cloud App Administrator](~/identity/role-based-access-control/permissions-reference#cloud-application-administrator) or [Application Administrator](~/identity/role-based-access-control/permissions-reference#application-administrator) role.  OR, just the [Global Administrator](~/identity/role-based-access-control/permissions-reference.md#global-administrator) role.

## Configure a restriction

You can configure app management policies in Microsoft Entra ID using either the Microsoft Entra admin center or Microsoft Graph API. 

### Enable a restriction for all applications

This example will block the addition of new passwords on all applications and service principals in your organization. A similar process can be used to enable other restrictions.

#### [Entra admin center](#tab/portal)

To block new passwords using the Microsoft Entra admin center:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).

1. Browse to **Entra ID** > **Enterprise apps** > **App management policies**.

1. Select **Block password addition**.

1. Set the status to **On**.  Ensure the 'Applies to' field is set to **All applications**.

1. Select **Save** to save your settings.

:::image type="content" source="./media/configure-app-mgmt-policies/enable-passwordaddition-restriction.png" alt-text="Screenshot of the 'password addition' restriction.":::

#### [Microsoft Graph](#tab/graph)

To block new password additions on applications and service principals using Microsoft Graph:

1. Retrieve your existing tenant wide app management policy.

    ```http
    GET https://graph.microsoft.com/beta/policies/defaultAppManagementPolicy
    ```

1. Find the `passwordCredentials` collection under the `applicationRestrictions` and `servicePrincipalsRestrictions` property.  In both collections, set the state of the `passwordAddition` restriction and the `symmetricKeyAddition` restriction to `enabled`.  If other restrictions are already present in the collection, include them in the request to avoid accidentally disabling them.

    ```http
    PATCH https://graph.microsoft.com/beta/policies/defaultAppManagementPolicy

    {
        "applicationRestrictions": {
            "passwordCredentials": [
                {
                    "restrictionType": "passwordAddition",
                    "state": "enabled"
                },
                {
                    "restrictionType": "symmetricKeyAddition",
                    "state": "enabled"
                }
            ]
        },
          "servicePrincipalRestrictions": {
            "passwordCredentials": [
                {
                    "restrictionType": "passwordAddition",
                    "state": "enabled"
                },
                {
                    "restrictionType": "symmetricKeyAddition",
                    "state": "enabled"
                }
            ]
        }      
    }
    ```

---

### Grant an exception to an application

Sometimes, exceptions are needed to your tenant-wide rules.  This example will grant an app an exception to the restriction blocking custom identifier URIs, so it can still have custom URIs added to it.  A similar process can be followed for other restrictions.

#### [Entra admin center](#tab/portal)

To grant an app an exception to the restriction blocking custom identifier URIs using the Entra admin center:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).

1. Browse to **Entra ID** > **Enterprise apps** > **App management policies**.

1. Select **Block custom identifier URIs**.

1. Ensure the status is **On**.  Set the 'Applies to' field to **All applications with exclusions**.

1. Under **Excluded apps**, select **Add applications**.

1. Choose the application you'd like to exclude from the restriction.

1. Select **Save** to save your settings.

:::image type="content" source="./media/configure-app-mgmt-policies/identifier-uri-restriction-with-exemption.png" alt-text="Screenshot of the 'custom identifier URI' restriction.":::

#### [Microsoft Graph](#tab/graph)

To grant an app an exception to the restriction blocking custom identifier URIs using the Microsoft Graph:

1. Create a new custom app management policy.  When creating it, set the `nonDefaultUriAddition` restriction under `restrictions.applicationRestrictions` to `disabled`. 

    ```http
    POST https://graph.microsoft.com/beta/policies/appManagementPolicies

    {
        "restrictions": {
            "applicationRestrictions": {
                "identifierUris": {
                    "nonDefaultUriAddition": {
                        "state": "disabled"
                    }
                }
            }
        }
    }
    ```

1. Record the ID of the new policy from the response. 

1. Assign the new custom policy to the application you'd like to exempt.

    ```http
    POST https://graph.microsoft.com/beta/applications/{objectIdOfTheApplication}/appManagementPolicies/$ref

    {
        "@odata.id":"https://graph.microsoft.com/v1.0/policies/appManagementPolicies/{idOfTheCustomPolicy}"
    }
    ```

1. If you get an error indicating that this application already has a custom policy assigned, then instead modify that policy to include this new exclusion.  Make sure the existing policy is not assigned to any other applications, or they will also receive the exclusion.

---

### Grant an exception to a user or service

Sometimes, exceptions need to be granted to the user or service creating or modifying the application.  For example, imagine an automated process in your organization periodically creates applications and sets passwords on them.  You want to block the new passwords in your organization, but you don't want to break this automated process while you're working on updating it.  [Application exceptions](#grant-an-exception-to-an-application) would not work in this case, because the apps being created/updated don't exist yet!  Instead, you can apply an exception to the process itself.  

This type of exception - sometimes labeled an 'actor' or 'caller' exception - is configured using [custom security attributes](https://learn.microsoft.com/en-us/entra/fundamentals/custom-security-attributes-overview).  Because of this, you need two additional roles for this scenario, in addition to the role(s) from [prerequisites](#prerequisites).

- [Attribute Definition Administrator](https://learn.microsoft.com/en-us/entra/identity/role-based-access-control/permissions-reference#attribute-definition-administrator)
- [Attribute Assignment Administrator](https://learn.microsoft.com/en-us/entra/identity/role-based-access-control/permissions-reference#attribute-assignment-administrator)

This example will grant a service an exception to the restriction enforcing a max lifetime on new certificates it adds to other applications and service principals.  The service will be represented by its service principal.  Find the service principal for a service by searching for it in [Enterprise applications](https://entra.microsoft.com/#view/Microsoft_AAD_IAM/StartboardApplicationsMenuBlade/~/AppAppsPreview).

#### [Entra admin center](#tab/portal)

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).

1. Browse to **Entra ID** > **Enterprise apps** > **App management policies**.

1. Select **Restrict max certificate lifetime**.

1. Ensure the status is **On**.  Set the 'Applies to' field to **All applications with exclusions**.

1. Under **Excluded callers**, select **Add excluded callers**.

1. Choose the service principal whose calls to create/update apps you'd like to exclude from the restriction.

1. Select **Save** to save your settings.

:::image type="content" source="./media/configure-app-mgmt-policies/restrict-certificate-lifetime.png" alt-text="Screenshot of the 'restrict max certificate lifetime' restriction.":::

#### [Microsoft Graph](#tab/graph)

##### Create a custom security attribute definition

This caller-based exemption is done through [custom security attributes](https://learn.microsoft.com/en-us/entra/fundamentals/custom-security-attributes-overview).  Custom security attributes are key-value pairs; they require a definition for the key-value pair to be created in the tenant, and then instances of the key-value pair can be added to specific users or service principals.

Custom security attribute definitions can be [created through the Entra portal](https://learn.microsoft.com/en-us/entra/fundamentals/custom-security-attributes-add), but you can also do so using Microsoft Graph.  First, [create an attribute set](https://learn.microsoft.com/en-us/graph/api/directory-post-attributesets) (if you don't have one already).   Attribute sets are containers for custom security attribute definitions.

```http
POST https://graph.microsoft.com/v1.0/directory/attributeSets 
{
    "id":"PolicyExemptions",
    "description":"Attributes for granting exemptions to policy",
    "maxAttributesPerSet":25
}
```

Then, [create the definition](https://learn.microsoft.com/en-us/graph/api/directory-post-customsecurityattributedefinitions).

```http
POST https://graph.microsoft.com/v1.0/directory/customSecurityAttributeDefinitions
{
    "attributeSet": "PolicyExemptions",
    "description": "App mgmt policy exemption attributes",
    "isCollection": false,
    "isSearchable": true,
    "name": "AppManagementExemption",
    "status": "Available",
    "type": "String",
    "usePreDefinedValuesOnly": true,
    "allowedValues": [
        {
            "id": "ExemptFromCertificateLifetimeRestriction",
            "isActive": true
        }
    ]
}
```

These are just example values; you can name your custom security attribute anything you like.  However, make sure that the custom security attribute definition you create is of `String` type, and `isCollection` is set to `false`.  Currently, single-value string types are the only custom security attributes supported as exemption indicators in app management policies.

##### Add the custom security attribute as an exemption indicator

Update the `excludeActors` property under the `asymmetricKeyLifetime` restriction in `applicationRestrictions` and `servicePrincipalRestrictions`.

```http
PATCH https://graph.microsoft.com/beta/policies/defaultAppManagementPolicy

 {  
    "applicationRestrictions": {
        "keyCredentials": [
            {
                "restrictionType": "asymmetricKeyLifetime",
                "state": "enabled",
                "maxLifetime": "P180D",
                "excludeActors": {
                    "customSecurityAttributes": [
                        {
                            "@odata.type": "#microsoft.graph.customSecurityAttributeStringValueExemption",
                            "id": "PolicyExemptions_AppManagementExemption",  //This `id` value is the concatenation of "AttributeSet_AttributeName"
                            "operator": "equals",
                            "value": "ExemptFromCertificateLifetimeRestriction"
                        }
                    ]
                }
            }
        ]
    },
    "servicePrincipalRestrictions": {
        "keyCredentials": [
            {
                "restrictionType": "asymmetricKeyLifetime",
                "state": "enabled",
                "maxLifetime": "P180D",
                "excludeActors": {
                    "customSecurityAttributes": [
                        {
                            "@odata.type": "#microsoft.graph.customSecurityAttributeStringValueExemption",
                            "id": "PolicyExemptions_AppManagementExemption",  //This `id` value is the concatenation of "AttributeSet_AttributeName"
                            "operator": "equals",
                            "value": "ExemptFromCertificateLifetimeRestriction"
                        }
                    ]
                }
            }
        ]
    }
 }
```

This indicates to Microsoft Entra that you want users or service principals with that specific custom security attribute value assigned to them to be exempt from the policy.

##### Assign the custom security attribute to the service principal

Custom security attributes can be assigned to both [users](https://learn.microsoft.com/en-us/entra/identity/users/users-custom-security-attributes) and [service principals](https://learn.microsoft.com/en-us/entra/identity/enterprise-apps/custom-security-attributes-apps) through the Entra portal, but you can also do so using Microsoft Graph. 

To assign to a service principal:

```http
PATCH https://graph.microsoft.com/v1.0/servicePrincipals/{id}
{
    "customSecurityAttributes":
    {
        "Engineering":
        {
            "@odata.type":"#Microsoft.DirectoryServices.CustomSecurityAttributeValue",
            "AppManagementExemption":"ExemptFromCertificateLifetimeRestriction"
        }
    }
}
```

Replace {id} with the object ID of the service principal.

Once this completes, the service principal with the custom security attribute assigned will be able to add a  to any app they have access to.

---

### Apply a restriction to a specific application

Sometimes, you aren't ready to apply a restriction to your entire tenant, but still want to apply the rule to a select set of security-sensitive applications.  This example will apply the restriction blocking custom passwords to a single application. A similar process can be followed for other restrictions.

#### [Entra admin center](#tab/portal)

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).

1. Browse to **Entra ID** > **Enterprise apps** > **App management policies**.

1. Select **Block custom passwords**.

1. Ensure the status is **On**.  Set the 'Applies to' field to **Select applications**.

1. Select **Add applications**.

1. Choose the application you'd like to apply the restriction to.

1. Select **Save** to save your settings.

:::image type="content" source="./media/configure-app-mgmt-policies/block-custom-passwords.png" alt-text="Screenshot of the 'block custom passwords' restriction.":::

#### [Microsoft Graph](#tab/graph)

1. Create a new custom app management policy.  When creating it, set the `customPasswordAddition` restriction under `restrictions.passwordCredentials` to `enabled`. 

    ```http
    POST https://graph.microsoft.com/beta/policies/appManagementPolicies

    {
        "restrictions": {
            "passwordCredentials": [
                {
                    "restrictionType": "customPasswordAddition",
                    "state": "enabled"
                }
            ]
        }
    }
    ```

1. Record the ID of the new policy from the response. 

1. Assign the new custom policy to the application you'd like to apply the restriction to.

    ```http
    POST https://graph.microsoft.com/beta/applications/{objectIdOfTheApplication}/appManagementPolicies/$ref

    {
        "@odata.id":"https://graph.microsoft.com/v1.0/policies/appManagementPolicies/{idOfTheCustomPolicy}"
    }
    ```

1. If you get an error indicating that this application already has a custom policy assigned, then instead modify that policy to include this new restriction.  Make sure the existing policy is not assigned to any other applications, or they will also receive the enforcement.

---

### View your custom policies

[Custom policies](https://learn.microsoft.com/en-us/graph/api/resources/appmanagementpolicy?view=graph-rest-beta) are applied to specific applications and service principals.  They are used to override the tenant-wide configuration for a specific app.  You can learn more about that [here](https://learn.microsoft.com/en-us/graph/api/resources/applicationauthenticationmethodpolicy?view=graph-rest-beta).

The Entra admin center automatically configures custom policies for you based on your intent.  For example, if you want to grant an exemption to a restriction for a specific app, the Entra admin center will craft the custom policy with that behavior that behind the scenes, and assign it to the application.

Because of this, the list of custom policies can't be viewed directly in the Entra admin center.  But they can be viewed through Microsoft Graph.

#### [Entra admin center](#tab/portal)

The list of custom policies can't be viewed directly in the Entra admin center.  Switch to the Microsoft Graph tab.

#### [Microsoft Graph](#tab/graph)

```http
GET https://graph.microsoft.com/beta/policies/appManagementPolicies
```

---

### Fix your policy state for use in the Entra admin center

If you have ever configured your app management policies outside of the Entra admin center, you may have configured them in a way the portal doesn't expect.  If this is the case, when loading a restriction, you'll see an error message like:

```The restriction have been modified outside of this interface. To prevent data loss, editing is disabled until restrictions are synchronized.```

In order to get your restrictions back into a state that the Entra admin center expects, you'll need to update them using Microsoft Graph.

#### [Entra admin center](#tab/portal)

This can't be done using the Entra admin center.  Switch to the Microsoft Graph tab.

#### [Microsoft Graph](#tab/graph)

First, retrieve your tenant-wide app management policy. 

```http
GET https://graph.microsoft.com/beta/policies/defaultAppManagementPolicy
```

Jump to the whichever restriction is blocked for you in the Entra admin center.

##### Password addition

The **Block password addition** restriction expects all four of the following restrictions to be in the same state:

- The `passwordAddition` restriction in the `applicationRestrictions.passwordCredentials` collection
- The `passwordAddition` restriction in the `servicePrincipalRestrictions.passwordCredentials` collection
- The `symmetricKeyAddition` restriction in the `applicationRestrictions.passwordCredentials` collection
- The `symmetricKeyAddition` restriction in the `servicePrincipalRestrictions.passwordCredentials` collection

This means the properties of all four restrictions should match. Or, all four restrictions should not be present in the policy.

##### Password lifetime

The **Restrict max password lifetime** restriction expects all four of the following restrictions to be in the same state:

- The `passwordLifetime` restriction in the `applicationRestrictions.passwordCredentials` collection
- The `passwordLifetime` restriction in the `servicePrincipalRestrictions.passwordCredentials` collection
- The `symmetricKeyLifetime` restriction in the `applicationRestrictions.passwordCredentials` collection
- The `symmetricKeyLifetime` restriction in the `servicePrincipalRestrictions.passwordCredentials` collection

This means the properties of all four restrictions should match. Or, all four restrictions should not be present in the policy.

##### Certificate lifetime

The **Restrict max certificate lifetime** restriction expects all both of the following restrictions to be in the same state:

- The `asymmetricKeyLifetime` restriction in the `applicationRestrictions.passwordCredentials` collection
- The `asymmetricKeyLifetime` restriction in the `servicePrincipalRestrictions.passwordCredentials` collection

This means the properties of both restrictions should match. Or, both restrictions should not be present in the policy.

---

## Next steps

- [App management policy API overview](https://learn.microsoft.com/en-us/graph/api/resources/applicationauthenticationmethodpolicy?view=graph-rest-beta)
