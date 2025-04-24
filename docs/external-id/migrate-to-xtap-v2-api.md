---
title: "Migrate to CrossTenantAccessPolicy Microsoft Graph API v2"
description: Learn how to Migrate to version 2 of the CrossTenantAccessPolicy Microsoft Graph API.

author: msmimart
manager: celestedg
ms.author: mimart
ms.service: entra-external-id

ROBOTS: NOINDEX
ms.subservice: external
ms.topic: how-to
ms.date: 04/24/2025
---

# Migrate CrossTenantAccessPolicy JSON to the new Microsoft Graph API

A new version of the CrossTenantAccessPolicy Microsoft Graph API is now available, which enhances the functionality and management of your policies. Any cross-tenant access policies created during the Microsoft Teams Shared Channels and B2B collaboration private preview will need to be updated to the new version. This document describes the changes to the schema supported by the Microsoft Graph API and provides the steps for migrating your policies.

## Background

Legacy XTAP policies were created by tenant admins using the hidden Microsoft Graph API by setting serialized JSON, for example:

```json
POST https://graph.microsoft.com/beta/policies/crossTenantAccessPolicy
{
  "definition": [
    "CrossTenantAccessPolicy": ...
  ]
}
```

Customers are required to migrate to the new schematized CrossTenantAccessPolicy Microsoft Graph API. Due to the redesign of the API and backend JSON schema, the new API doesn’t support the existing policies created during private preview.

## How to migrate to the new API

Two options are available for migrating your existing policies to the new schema supported by the Microsoft Graph API: 

- Method 1: Migrate in place. Follow this method if your policy is in a production environment and data needs to be migrated.
- Method 2: Replace policy with blank new policy. The simplest method is to just replace the old policy by creating a new one using the new API. 

Migration needs to be performed only once. After migrating, you’ll no longer need to modify the JSON directly. The Microsoft Graph API will manage the underlying JSON for you. 

### Pre-check

> [!NOTE]
> If you’ve received communication regarding upgrading manually, this pre-check is most likely failing.

Before you begin, verify that migration is necessary by attempting to access the new CrossTenantAccessPolicy Microsoft Graph API. If an unsupported policy JSON is in use, an error will occur indicating an outdated schema. To run this check, you need an account with the Global Administrator, Security Administrator, or Conditional Access Administrator role.

1. Using Graph Explorer, sign in to your tenant and ensure you’ve consented to directory.AccessAsUser.All.

1. Run the following requests:

```http
GET https://graph.microsoft.com/beta/policies/crossTenantAccessPolicy/default
GET https://graph.microsoft.com/beta/policies/crossTenantAccessPolicy/partners
```

1. If you receive a Bad Request error in either response, you must migrate your JSON to a supported schema. If you receive OK – 200 in both responses, you are using a supported schema. Migration is either complete or not required.
1. Before moving on, ensure you have a backup copy of your current cross-tenant access policy to revert to if you encounter issues during migration.

## Method 1: Migrate in place

> [!IMPORTANT]
> Before you begin, read the section “Details about the new policy schema” in this document.

1. Review the changes to the schema and familiarize yourself with the template. Using the samples in this document, modify your existing JSON to match the correct format. 

1. Make sure you have the Microsoft Graph module installed for PowerShell. 

1. Start PowerShell and connect to your tenant: 
Connect-Graph -Scopes "Directory.AccessAsUser.All"

1. Follow the instructions and open a web browser to sign in and enter your Global Administrator credentials.

1. Read the updated JSON file into PowerShell using the following command. This command assumes the JSON file is in the current folder: 

```json
$policy = Get-Content .\CrossTenantAccessPolicy.json
```

1. Run the following command to convert the JSON to the correct format for ingestion using Microsoft Graph: 

```json
$json = "{\"displayName\": \"Cross Tenant Access Policy\", \"definition\":[\""+[string]$($policy.trim()).Replace("", \"\\\"").Replace("\r*\n", "")+"\"] }"
```

1. Run the following command to update the existing policy:

```json
Invoke-MgGraphRequest -Method PATCH -Uri "https://graph.microsoft.com/beta/policies/crossTenantAccessPolicy" -Body $json -Headers @{"Content-Type"="application/json"}
```

1. Finally, run the following command to verify the policy was updated successfully: 

```json
Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/beta/policies/crossTenantAccessPolicy" | %{$_.definition}
```

1. Disconnect from the tenant: 

```json
Disconnect-Graph
```

1. Close PowerShell.

1. Repeat the steps in the “Pre-check” section to make sure the API returns a valid response in both the default and partner’s endpoints.

## Details about the new policy schema

Before you create policies using the new API, review this entire section to understand the changes to the schema.

### ‘AllowAccess’ is no longer supported 
This applies equally to ‘FromMyTenancy’ and ‘ToMyTenancy’ sections.

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

In the **ToMyTenancy** section, trust settings must now be placed in a separate entry from the affordances for B2B Collaboration and Direct Connect. The JSON trust settings include **AcceptMFA**, **AcceptCompliantDevice**, and **AcceptHybridAzureADJoinedDevice**.

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

### Multiple configurations of users/groups for an application are not supported

Creating multiple configurations of users or groups accessing or being blocked from specific applications is no longer supported. Previously, the policy JSON schema allowed for many complex combinations of users and groups who were allowed or blocked for a specific application. For example, a policy could specify that users in Group A could access Application A, while users in Group B could be blocked from accessing Application B. The new schema only supports allowing or blocking users and groups, and allowing or blocking a set of applications. This change covers most scenarios and makes the feature more intuitive.

#### Examples of configurations that are NO longer supported

```json
"FromMyTenancy": [
  {
    "AllowNativeFederation": true,
    "Targets": {
      "Groups": [
        "8fcf03b8-7697-4459-b4ec-cddd89122900"
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
        "8fcf03b8-7697-4459-b4ec-cddd89122900"
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

The following configuration allows all users in group ‘aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb’ on the home tenant to access ‘Office365’ in all external tenants, while the second baseline configuration blocks all the home users from external access via B2B Direct Connect.

```json
"FromMyTenancy": [
  {
    "AllowNativeFederation": true,
    "Targets": {
      "Groups": [
        "8fcf03b8-7697-4459-b4ec-cddd89122900"
      ]
    },
    "Applications": ["Office365"]
  },
  {
    "AllowNativeFederation": false
  }
]	
```

This configuration allows B2B Direct Connect access to all external tenants for all users in the group ‘aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb’ in the home tenant. It also blocks access to one external application with application Id ‘cccccccc-2222-3333-4444-dddddddddddd’. The last configuration blocks access to the rest of the users in the home tenant for the B2B Direct Connect feature. 

```json
"ToMyTenancy": [
  {
    "AllowNativeFederation": true,
    "Targets": {
      "Groups": [
        "8fcf03b8-7697-4459-b4ec-cddd89122900"
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

In the new design, if you specify affordances for specific targets, you also need to add a baseline affordance that doesn’t specify any targets. This baseline affordance will then apply to the remaining targets. Otherwise, those targets will have the opposite affordance applied. Adding a baseline will ensure that targets will retain your intended affordance even when company or service defaults change.

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

The following is an example of a properly configured policy. You can use this as a template and delete the sections that are not relevant to you.

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

### Method 2: Replace the policy with a new blank policy

If you don’t need to migrate policies in place (for example, you’re doing this in a test environment), you can simply replace the old policy with a blank one. Then you can build your policies using the new API. To replace an old policy, run the steps above and upload the following policy:

```json
{ "CrossTenantAccessPolicy": { "Version": 1, "LastModified": "2021-09-20 16:14:00", "TenantGroup":[]} }
```
