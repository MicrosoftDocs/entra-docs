---
title: Configure Cosgrid Networks for automatic user provisioning with Microsoft Entra ID
description: Learn how to configure automatic user provisioning between Microsoft Entra ID and Cosgrid Networks using SCIM.
ms.topic: how-to
ms.date: 08/18/2026
---

# Configure Cosgrid Networks for automatic user provisioning with Microsoft Entra ID

This article describes how to configure automatic user provisioning between Cosgrid Networks and Microsoft Entra ID using the System for Cross-domain Identity Management (SCIM) protocol. When configured, Microsoft Entra ID can automatically provision and deprovision users in Cosgrid Networks. You can also synchronize Microsoft Entra ID groups with Cosgrid Networks teams when group synchronization is enabled.

This article covers:

- Configure SCIM provisioning in Cosgrid Networks
- Configure SCIM security
- Configure group synchronization
- Configure automatic provisioning in Microsoft Entra ID
- Configure attribute mappings
- Test user provisioning
- Monitor provisioning

## Prerequisites

To integrate Microsoft Entra ID with Cosgrid Networks, you need:

- A Microsoft Entra ID tenant.
- One of the following roles: Application Administrator, Cloud Application Administrator, or Application Owner.
- A Cosgrid Networks tenant.
- Administrator access to Cosgrid Networks.
- A test user or group.

## Step 1: Configure SCIM in Cosgrid Networks

1. Sign in to the Cosgrid Networks administrator portal.
1. Navigate to **Single Sign-On**.
1. Select **SCIM**.
1. The **Provisioning (SCIM)** page is displayed. The page provides the following configuration options:

    - **Connection**: Enables the identity provider connection for SCIM provisioning.
    - **Sync groups to teams**: Synchronizes groups from the identity provider with Cosgrid Networks teams.
    - **IP Allowlist**: Restricts SCIM requests to trusted IP addresses.

    [![Screenshot shows the Provisioning (SCIM) page in Cosgrid Networks with Connection, Sync groups to teams, IP Allowlist, and SCIM Base URL settings.](media/cosgrid-networks-provisioning-tutorial/scim-step-1.png "Provisioning (SCIM)")](media/cosgrid-networks-provisioning-tutorial/scim-step-1.png)

1. Enable **Connection**.
1. If you want Microsoft Entra ID groups to be synchronized with Cosgrid Networks teams, enable **Sync groups to teams**.
1. If you want to restrict SCIM requests to specific trusted IP addresses, enable **IP Allowlist** and configure the allowed addresses.
1. Under **SCIM provisioning**, locate the **SCIM Base URL**. This is the endpoint that Microsoft Entra ID uses to communicate with Cosgrid Networks. Use the SCIM Base URL displayed in your Cosgrid Networks tenant.
1. Under **SCIM token**, select **Generate token**.
1. Copy the generated SCIM token and store it securely.

> [!NOTE]
> The SCIM token is a credential used to authenticate provisioning requests. Treat it as a secret and don't include it in screenshots, documentation, source code, or support tickets.

## Step 2: Configure SCIM security

Cosgrid Networks provides security controls for SCIM provisioning.

### SCIM token

The SCIM token is used to authenticate requests from Microsoft Entra ID to the Cosgrid Networks SCIM endpoint. After generating the token:

1. Copy the token.
1. Store it securely.
1. Use the token when configuring automatic provisioning in Microsoft Entra ID.

If the token is compromised, generate a new token according to your Cosgrid Networks tenant configuration.

### IP Allowlist

The **IP Allowlist** option restricts SCIM requests to trusted IP addresses. To use this option:

1. Enable **IP Allowlist**.
1. Configure the trusted IP addresses.
1. Save the configuration.

> [!NOTE]
> Make sure the addresses used by Microsoft Entra provisioning are allowed before enabling IP restrictions. Otherwise, provisioning requests might be rejected.

## Step 3: Configure group synchronization

Cosgrid Networks can synchronize Microsoft Entra ID groups with Cosgrid Networks teams. To enable group synchronization:

1. Open the SCIM configuration in Cosgrid Networks.
1. Enable **Sync groups to teams**.
1. Configure the corresponding group provisioning settings in Microsoft Entra ID.
1. Save the configuration.

When enabled, changes to group membership can be synchronized with the corresponding Cosgrid Networks team.

> [!NOTE]
> Enable this option only if your organization requires group-to-team synchronization.

## Step 4: Add Cosgrid Networks to Microsoft Entra ID

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).
1. Browse to **Entra ID** > **Enterprise applications** > **New application**.
1. Search for **Cosgrid Networks**.
1. Select the **Cosgrid Networks** application and add it to your tenant.

If you already use the Cosgrid Networks enterprise application for SSO, you can use the same application for provisioning.

## Step 5: Configure automatic provisioning

1. Open the Cosgrid Networks enterprise application.
1. Select **Provisioning**.
1. Select **Get started**.
1. For **Provisioning mode**, select **Automatic**.
1. In **Admin Credentials**, enter the SCIM Base URL displayed in the Cosgrid Networks SCIM configuration.
1. Enter the SCIM token generated in Cosgrid Networks.
1. Select **Test Connection**.
1. Verify that the connection succeeds.
1. Select **Save**.

Microsoft Entra ID can now communicate with the Cosgrid Networks SCIM endpoint using the configured credentials.

## Step 6: Define users and groups in scope

You can control which Microsoft Entra ID users and groups are provisioned to Cosgrid Networks. For initial testing, start with a small number of users or groups.

1. Open the Cosgrid Networks enterprise application.
1. Select **Users and groups**.
1. Select **Add user/group**.
1. Assign a test user or group.
1. Configure the provisioning scope according to your requirements.

> [!NOTE]
> Starting with a test user or group allows you to validate the SCIM configuration before provisioning a larger number of users.

## Step 7: Configure attribute mappings

Microsoft Entra ID uses attribute mappings to determine which user information is sent to Cosgrid Networks.

1. In the Cosgrid Networks provisioning configuration, select **Mappings**.
1. Select **Provision Microsoft Entra ID Users**.
1. Review the default attribute mappings.
1. Configure the mappings required by Cosgrid Networks.

    Example:

    | Microsoft Entra attribute | SCIM attribute |
    | ----- | ----- |
    | User Principal Name | `userName` |
    | Display Name | `displayName` |
    | Given Name | `name.givenName` |
    | Surname | `name.familyName` |
    | Email | `emails` |
    | Account Enabled | `active` |

> [!NOTE]
> The final attribute mappings should match the SCIM attributes supported by the Cosgrid Networks implementation.

5. Save the attribute mappings.

## Step 8: Test provisioning

Before provisioning users across the organization, test the integration with a small number of accounts.

**Create a user**: Assign a test user to the Cosgrid Networks enterprise application. Verify that the user is created in Cosgrid Networks.

**Update a user**: Change a mapped attribute for the test user in Microsoft Entra ID. Verify that the corresponding attribute is updated in Cosgrid Networks.

**Deprovision a user**: Remove the test user from the provisioning scope, or disable the user, according to your configured provisioning behavior. Verify that the user's status in Cosgrid Networks is updated accordingly.

**Test group synchronization**: If **Sync groups to teams** is enabled:

1. Assign a test group to the application.
1. Add a test user to the group.
1. Wait for the provisioning cycle.
1. Verify that the corresponding Cosgrid Networks team and membership are synchronized.

## Step 9: Start provisioning

After successfully testing the integration:

1. Return to the **Provisioning** page in Microsoft Entra ID.
1. Verify the provisioning configuration.
1. Verify the provisioning scope.
1. Select **Start provisioning**.

Microsoft Entra ID begins provisioning users and groups according to the configured scope and attribute mappings.

## Step 10: Monitor provisioning

After provisioning starts, monitor the synchronization activity from Microsoft Entra ID. Check for:

- Successful user provisioning
- Failed provisioning
- User updates
- User deprovisioning
- Group synchronization

Use the provisioning logs to investigate failed operations.

## Troubleshooting

**Test Connection fails**: If the Microsoft Entra Test Connection operation fails, verify:

- The SCIM Base URL is correct.
- The SCIM token is correct and hasn't been revoked or replaced.
- The SCIM endpoint is reachable.
- The IP Allowlist configuration isn't blocking the request.

**User isn't provisioned**: Check that:

- The user is assigned to the Cosgrid Networks application.
- The user is included in the provisioning scope.
- Attribute mappings are configured correctly.
- The SCIM connection is enabled.
- Microsoft Entra provisioning logs for errors.

**User attributes aren't updated**: Check that:

- The attribute is included in the Microsoft Entra provisioning mappings.
- The SCIM attribute name is correct.
- The source attribute contains a value.
- The provisioning logs don't report a mapping or synchronization error.

**Group isn't synchronized**: If group synchronization is enabled, verify:

- **Sync groups to teams** is enabled in Cosgrid Networks.
- The group is assigned to the Cosgrid Networks application.
- Group provisioning is enabled in Microsoft Entra ID.
- Group membership is included in the provisioning scope.
- The provisioning logs don't report errors.

## Next steps

- [Configure SAML single sign-on](cosgrid-networks-tutorial.md)
- [Configure OIDC single sign-on](cosgrid-networks-oidc-tutorial.md)
