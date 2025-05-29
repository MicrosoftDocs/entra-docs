---
title: "Migrate to CrossTenantAccessPolicy Microsoft Graph API v2"
description: Learn how to Migrate to version 2 of the CrossTenantAccessPolicy Microsoft Graph API.

ms.author: cmulligan
author: csmulligan
manager: celestedg
ms.service: entra-external-id

ROBOTS: NOINDEX, NOFOLLOW
ms.subservice: external
ms.topic: how-to
ms.date: 04/24/2025
---

# Migrate CrossTenantAccessPolicy JSON to the new Microsoft Graph API

A new version of the CrossTenantAccessPolicy Microsoft Graph API is now available, which enhances the functionality and management of your policies. Any cross-tenant access policies created during the Microsoft Teams Shared Channels and Microsoft Entra External ID B2B collaboration preview must be updated to version 2. This document describes the changes to the schema supported by the Microsoft Graph API and provides the steps for migrating your policies.

## Background

During the preview of Microsoft Teams Shared Channels and Microsoft Entra External ID B2B collaboration, admins created cross-tenant access policies using version 1 of the CrossTenantAccessPolicy Microsoft Graph API and serialized JSON, for example:

```json
POST https://graph.microsoft.com/beta/policies/crossTenantAccessPolicy
{
  "definition": [
    "CrossTenantAccessPolicy": ...
  ]
}
```

However, with the redesign of the API and backend JSON schema in version 2, the new API no longer supports these previously created policies. As a result, customers must migrate to the new schematized CrossTenantAccessPolicy Microsoft Graph API.

## Precheck: Determine if migration is necessary

> [!NOTE]
> If you already received a communication instructing you to upgrade manually, this precheck is most likely failing.

First, determine if migration is necessary by trying to access the new CrossTenantAccessPolicy Microsoft Graph API. If you encounter an error indicating an outdated schema, it means an unsupported policy JSON is in use. To perform this check, you must have an account with one of the following roles: Global Administrator, Security Administrator, or Conditional Access Administrator.

1. Using Graph Explorer, sign in to your tenant and consent to `directory.AccessAsUser.All`.

1. Run the following requests:
   
   ```http
   GET https://graph.microsoft.com/beta/policies/crossTenantAccessPolicy/default
   GET https://graph.microsoft.com/beta/policies/crossTenantAccessPolicy/partners
   ```

1. If you receive a `Bad Request` error in either response, it means you need to migrate your JSON to a supported schema. However, if you receive an `OK – 200` status in both responses, it indicates that you're already using a supported schema, and migration is either complete or not required.

1. Before moving on, ensure you have a backup copy of your current cross-tenant access policy to revert to if you encounter issues during migration.

## How to migrate to the new API

Two options are available for migrating your existing policies to the new schema supported by the Microsoft Graph API: 

- [Method 1: Migrate in place](#method-1-migrate-in-place). Follow this method if your policy is in a production environment and data needs to be migrated.
- [Method 2: Replace the policy with a new blank policy](#method-2-replace-the-policy-with-a-new-blank-policy). The simplest method is to replace the old policy by creating a new one using the new API. 

You need to perform migration only once. After migration, you don't need to modify the JSON directly because the Microsoft Graph API manages the underlying JSON for you.

### Method 1: Migrate in place

> [!IMPORTANT]
> Before you begin, read the section [Details about the new policy schema](#details-about-the-new-policy-schema) in this document.

1. Review the changes to the schema and familiarize yourself with the template. Using the samples in this document, modify your existing JSON to match the correct format. 

1. Make sure you have the Microsoft Graph module installed for PowerShell. 

1. Start PowerShell and connect to your tenant:

   ```powershell
   Connect-Graph -Scopes "Directory.AccessAsUser.All"
   ```

1. Follow the instructions and open a web browser to sign in and enter your Global Administrator credentials.

1. Read the updated JSON file into PowerShell using the following command. This command assumes the JSON file is in the current folder: 

   ```powershell
   $policy = Get-Content .\CrossTenantAccessPolicy.json
   ```

1. Run the following command to convert the JSON to the correct format for ingestion using Microsoft Graph: 

   ```powershell
   $json = "{\"displayName\": \"Cross Tenant Access Policy\", \"definition\":[\""+[string]$($policy.trim()).Replace("", \"\\\"").Replace("\r*\n", "")+"\"] }"
   ```

1. Run the following command to update the existing policy:

   ```powershell
   Invoke-MgGraphRequest -Method PATCH -Uri "https://graph.microsoft.com/beta/policies/crossTenantAccessPolicy" -Body $json -Headers @{"Content-Type"="application/json"}
   ```

1. Run the following command to verify the policy was updated successfully: 

   ```powershell
   Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/beta/policies/crossTenantAccessPolicy" | %{$_.definition}
   ```

1. Disconnect from the tenant: 

   ```powershell
   Disconnect-Graph
   ```

1. Close PowerShell.

1. Repeat the steps in [Precheck: Determine if migration is necessary](#precheck-determine-if-migration-is-necessary) to make sure the API returns a valid response in both the default and partner’s endpoints.

### Method 2: Replace the policy with a new blank policy

If migrating existing policies isn't necessary (such as when working in a test environment), you can replace the old policy with a blank one. Then you can create your policies using the new API. See [Details about the new policy schema](#details-about-the-new-policy-schema) in this document. 

To replace an old policy, upload the following policy:

```json
{ "CrossTenantAccessPolicy": { "Version": 1, "LastModified": "2021-09-20 16:14:00", "TenantGroup":[]} }
```

## Details about the new policy schema

Before you create policies using the new API, review this entire section to understand the changes to the schema.

### AllowAccess is no longer supported

The `AllowAccess` setting is no longer supported in the `FromMyTenancy` and `ToMyTenancy` sections.

#### Before

```json
"FromMyTenancy": [
  {
    "AllowAccess": false
  }
]
```

#### After

```json
"FromMyTenancy": [
  {
    "AllowB2B": false,
    "AllowNativeFederation": false
  }
]
```

#### Before

```json
"ToMyTenancy": [
  {
    "AllowAccess": true,
    "AllowNativeFederation": true
  }
]
```

#### After

```json
"ToMyTenancy": [
  {
    "AllowB2B": true,
    "AllowNativeFederation": true
  }
]
```

#### Before

```json
"ToMyTenancy": [
  {
    "AllowAccess": true
  }
]
```

#### After

```json
"ToMyTenancy": [
  {
    "AllowB2B": true
  }
]
```

### Trust settings must be moved to a separate entry

In the `ToMyTenancy` section, trust settings must now be placed in a separate entry from the affordances for B2B collaboration and B2B direct connect. The JSON trust settings include `AcceptMFA`, `AcceptCompliantDevice`, and `AcceptHybridAzureADJoinedDevice`.

#### Before

```json
"ToMyTenancy": [
  {
    "AllowAccess": true,
    "AllowNativeFederation": true,
    "Targets": {
      "Groups": [
        "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
      ]
    },
    "AcceptMFA": true
  }
]
```

#### After

```json
"ToMyTenancy": [
  {
    "AllowB2B": true,
    "AllowNativeFederation": true,
    "Targets": {
      "Groups": [
        "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
      ]
    }
  },
  {
    "AcceptMFA": true
  }
]
```
#### Before

```json
"ToMyTenancy": [
  {
    "AllowAccess": true,
    "AcceptMFA": true,
    "AcceptCompliantDevice": true,
    "AcceptHybridAzureADJoinedDevice": false
  }
]	
```
#### After

```json
"ToMyTenancy": [
  {
    "AllowB2B": true
  },
  {
    "AcceptMFA": true,
    "AcceptCompliantDevice": true,
    "AcceptHybridAzureADJoinedDevice": false
  }
]
```	

### Multiple configurations of users/groups for an application aren't supported

Creating multiple configurations of users or groups accessing or being blocked from specific applications is no longer supported. Previously, the policy JSON schema allowed for many complex combinations of users and groups who were allowed or blocked for a specific application. For example, a policy could specify that users in Group A could access Application A, while users in Group B could be blocked from accessing Application B. The new schema only supports allowing or blocking users and groups, and allowing or blocking a set of applications. This change covers most scenarios and makes the feature more intuitive.

#### Examples of configurations that are no longer supported

The following configurations are **no longer supported** by the new schema:

```json
"FromMyTenancy": [
  {
    "AllowNativeFederation": true,
    "Targets": {
      "Groups": [
        "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
      ]
    },
    "Applications": ["Office365"]
  },
  {
    "AllowNativeFederation": true,
    "Targets": {
      "Groups": [
        "bbbbbbbb-1111-2222-3333-cccccccccccc"
      ]
    },
    "Applications": ["cccccccc-2222-3333-4444-dddddddddddd"]
  }
]
```

```json
"ToMyTenancy": [
  {
    "AllowAccess": true,
    "Targets": {
      "Groups": [
        "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
      ]
    },
    "Applications": ["Office365"]
  },
  {
    "AllowAccess": false,
    "Targets": {
      "Groups": [
        "bbbbbbbb-1111-2222-3333-cccccccccccc"
      ]
    },
    "Applications": ["cccccccc-2222-3333-4444-dddddddddddd"]
  }
]
```

#### Examples of valid configurations

The following configuration allows all users in group `aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb` on the home tenant to access `Office365` in all external tenants. The second baseline configuration blocks all the home users from external access via B2B direct connect.

```json
"FromMyTenancy": [
  {
    "AllowNativeFederation": true,
    "Targets": {
      "Groups": [
        "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
      ]
    },
    "Applications": ["Office365"]
  },
  {
    "AllowNativeFederation": false
  }
]	
```

The following configuration allows B2B direct connect access to all external tenants for all users in the group `aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb` in the home tenant. It also blocks access to one external application with application ID `cccccccc-2222-3333-4444-dddddddddddd`. The last configuration blocks access to the rest of the users in the home tenant for the B2B direct connect feature. 

```json
"ToMyTenancy": [
  {
    "AllowNativeFederation": true,
    "Targets": {
      "Groups": [
        "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
      ]
    }
  },
  {
    "AllowNativeFederation": false,
    "Applications": ["cccccccc-2222-3333-4444-dddddddddddd"]
  },
  {
    "AllowNativeFederation": false
  }
]
```

### Baseline settings are required when targets are specified

In the new design, if you specify affordances for specific targets, you also need to add a baseline affordance that doesn’t specify any targets. This baseline affordance applies to the remaining targets. Otherwise, those targets have the opposite affordance applied. Adding a baseline ensures that targets retain your intended affordance even when company or service defaults change.

#### Before

```json
"ToMyTenancy": [
  {
    "AllowNativeFederation": true,
    "Targets": {
      "Groups": [
        "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
      ]
    },
    "Applications": ["Office365"]
  }
]
```

#### After

```json
"ToMyTenancy": [
  {
    "AllowNativeFederation": true,
    "Targets": {
      "Groups": [
        "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
      ]
    },
    "Applications": ["Office365"]
  },
  {
    "AllowNativeFederation": false
  }
]
```
#### Before

```json
"FromMyTenancy": [
  {
    "AllowNativeFederation": true,
    "Targets": {
      "Groups": [
        "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
      ]
    }
  },
  {
    "AllowNativeFederation": false,
    "Applications": ["Office365"]
  }
]
```
#### After

```json
"FromMyTenancy": [
  {
    "AllowNativeFederation": true,
    "Targets": {
      "Groups": [
        "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
      ]
    }
  },
  {
    "AllowNativeFederation": false,
    "Applications": ["Office365"]
  },
  {
    "AllowNativeFederation": false
  }
]
```

### Template for CrossTenantAccessPolicy

The following example shows a properly configured policy. You can use this example as a template and delete the sections that aren't relevant to you.

```json
{
  "CrossTenantAccessPolicy": {
    "Version": 1,
    "LastModified": "2021-09-20 16:14:00",
    "TenantGroup": [
      {
        "DisplayName": "Allow B2B Collab to all home and external users for all apps",
        "Tenants": [
          "dddddddd-3333-4444-5555-eeeeeeeeeeee"
        ],
        "FromMyTenancy": [
          {
            "AllowB2B": true
          }
        ],
        "ToMyTenancy": [
          {
            "AllowB2B": true
          }
        ]
      },
      {
        "DisplayName": "Allow B2B Collab and Direct Connect to all home and external users for all apps",
        "Tenants": [
          "dddddddd-3333-4444-5555-eeeeeeeeeeee"
        ],
        "FromMyTenancy": [
          {
            "AllowB2B": true,
            "AllowNativeFederation": true
          }
        ],
        "ToMyTenancy": [
          {
            "AllowB2B": true,
            "AllowNativeFederation": true
          }
        ]
      },
      {
        "DisplayName": "Allow B2B Collab and Direct Connect to all home and external users for Office365 apps",
        "Tenants": [
          "dddddddd-3333-4444-5555-eeeeeeeeeeee"
        ],
        "FromMyTenancy": [
          {
            "AllowB2B": true,
            "AllowNativeFederation": true,
            "Applications": [
              "Office365"
            ]
          },
          {
            "AllowB2B": false,
            "AllowNativeFederation": false
          }
        ],
        "ToMyTenancy": [
          {
            "AllowB2B": true,
            "AllowNativeFederation": true,
            "Applications": [
              "Office365"
            ]
          },
          {
            "AllowB2B": false,
            "AllowNativeFederation": false
          }
        ]
      },
      {
        "DisplayName": "Allow B2B Collab to all home and external users for all apps and Direct Connect for Office365 apps only",
        "Tenants": [
          "dddddddd-3333-4444-5555-eeeeeeeeeeee"
        ],
        "FromMyTenancy": [
          {
            "AllowNativeFederation": true,
            "Applications": [
              "Office365"
            ]
          },
          {
            "AllowB2B": true,
            "AllowNativeFederation": false
          }
        ],
        "ToMyTenancy": [
          {
            "AllowNativeFederation": true,
            "Applications": [
              "Office365"
            ]
          },
          {
            "AllowB2B": true,
            "AllowNativeFederation": false
          }
        ]
      },
      {
        "DisplayName": "Allow B2B Direct Connect outbound for a group and Office365Appsonly and allow inbound external user to Office365 apps",
        "Tenants": [
          "dddddddd-3333-4444-5555-eeeeeeeeeeee"
        ],
        "FromMyTenancy": [
          {
            "AllowNativeFederation": true,
            "Applications": [
              "Office365"
            ],
            "Targets": {
              "Groups": [
                "eeeeeeee-4444-5555-6666-ffffffffffff"
              ]
            }
          },
          {
            "AllowNativeFederation": false
          }
        ],
        "ToMyTenancy": [
          {
            "AllowNativeFederation": true,
            "Applications": [
              "Office365"
            ]
          },
          {
            "AllowNativeFederation": false
          }
        ]
      },
      {
        "DisplayName": "Allow B2B Direct Connect inbound external users from partner to Office365 apps and trust their MFA and device",
        "Tenants": [
          "dddddddd-3333-4444-5555-eeeeeeeeeeee"
        ],
        "ToMyTenancy": [
          {
            "AllowNativeFederation": true,
            "Applications": [
              "Office365"
            ]
          },
          {
            "AllowNativeFederation": false
          },
          {
            "AcceptMFA": true
          }
        ]
      }
    ]
  }
}
```
