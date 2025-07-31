---
title: How to manage an external authentication method (EAM) in Microsoft Entra ID (Preview)
description: Learn how to manage an external authentication method (EAM) for Microsoft Entra multifactor authentication
ms.service: entra-id
ms.subservice: authentication
ms.topic: conceptual
ms.date: 07/31/2025
ms.author: justinha
author: emakedon23
manager: dougeby
ms.reviewer: emilymakedon, gustavosa
ms.custom: sfi-ga-nochange, sfi-image-nochange
# Customer intent: As an authentication administrator, I want learn how to manage an external authentication method (EAM) for Microsoft Entra ID.
---
# Manage an external authentication method in Microsoft Entra ID (Preview)

An external authentication method (EAM) lets users choose an external provider to meet multifactor authentication (MFA) requirements when they sign in to Microsoft Entra ID. An EAM can satisfy MFA requirements from Conditional Access policies, Microsoft Entra ID Protection risk-based Conditional Access policies, Privileged Identity Management (PIM) activation, and when the application itself requires MFA. 

EAMs differ from federation in that the user identity is originated and managed in Microsoft Entra ID. With federation, the identity is managed in the external identity provider. EAMs require at least a Microsoft Entra ID P1 license.

:::image type="content" source="./media/concept-authentication-external-method-provider/how-external-method-authentication-works.png" alt-text="Diagram of how external method authentication works.":::

>[!IMPORTANT]
>Between 9/1/25 and 9/30/25, a new improvement is available for EAM. The improvement requires a backend migration to ensure a seamless experience. To minimize impact to your organization, this migration is performed on your behalf. Some users in your organization might experience limited impact to their authentication experience. For more information, see [Authentication method registration for EAMs](#authentication-method-registration-for-eams).

## Required metadata to configure an EAM
To create an EAM, you need the following information from your external authentication provider:

- An **Application ID** is generally a multitenant application from your provider, which is used as part of the integration. You need to provide admin consent for this application in your tenant.
- A **Client ID** is an identifier from your provider used as part of the authentication integration to identify Microsoft Entra ID requesting authentication.  
- A **Discovery URL** is the OpenID Connect (OIDC) discovery endpoint for the external authentication provider. 
 
   >[!NOTE]
   >See [Configure a new external authentication provider with Microsoft Entra ID](concept-authentication-external-method-provider.md#configure-a-new-external-authentication-provider-with-microsoft-entra-id) to set up the App registration.
   
   >[!IMPORTANT]
   > Ensure that the kid (Key ID) property is base64-encoded in both the JWT header of the id_token and in the JSON Web Key Set (JWKS) retrieved from the provider’s jwks_uri. This encoding alignment is essential for the seamless validation of token signatures during authentication processes. Misalignment can result in issues with key matching or signature validation.

## Manage an EAM in the Microsoft Entra admin center

EAMs are managed with the Microsoft Entra ID Authentication methods policy, just like built-in methods. 

### Create an EAM in the admin center

Before you create an EAM in the admin center, make sure you have the [metadata to configure an EAM](#required-metadata-to-configure-an-eam). 

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Privileged Role Administrator](~/identity/role-based-access-control/permissions-reference.md#privileged-role-administrator).
1. Browse to **Entra ID** > **Authentication methods** > **Add external method (Preview)**.

   :::image type="content" border="true" source="./media/how-to-authentication-external-method-manage/add-external-method.png" alt-text="Screenshot of how to add an EAM in the Microsoft Entra admin center.":::

   Add method properties based on configuration information from your provider. For example:
   
   - Name: Adatum
   - Client ID: 00001111-aaaa-2222-bbbb-3333cccc4444
   - Discovery Endpoint: `https://adatum.com/.well-known/openid-configuration`
   - App ID: 11112222-bbbb-3333-cccc-4444dddd5555

   >[!IMPORTANT]
   >The display name is the name that's shown to the user in the method picker. It can't be changed after the method is created. Display names must be unique.

   :::image type="content" border="true" source="./media/how-to-authentication-external-method-manage/method-properties.png" alt-text="Screenshot of how to add EAM properties.":::

   You need at least the [Privileged Role Administrator](../role-based-access-control/permissions-reference.md#privileged-role-administrator) role to grant admin consent for the provider’s application. If you don't have the role required to grant consent, you can still save your authentication method, but you can't enable it until consent is granted.

   After you enter the values from your provider, press the button to request for admin consent to be granted to the application so that it can read the required info from the user to authenticate correctly. You're prompted to sign in with an account with admin permissions and grant the provider’s application with the required permissions.

   After you sign in, click **Accept** to grant admin consent:

   :::image type="content" border="true" source="./media/how-to-authentication-external-method-manage/permissions-requested.png" alt-text="Screenshot of how to grant admin consent.":::

   You can see the permissions that the provider application requests before you grant consent. After you grant admin consent and the change replicates, the page refreshes to show that admin consent was granted.

   :::image type="content" border="true" source="./media/how-to-authentication-external-method-manage/consent-granted.png" alt-text="Screenshot of Authentication methods policy after consent is granted.":::

If the application has permissions, then you can also enable the method before saving. Otherwise, you need to save the method in a disabled state, and enable after the application is granted consent.

Once the method is enabled, all users in scope can choose the method for any MFA prompts. If the application from the provider doesn't have consent approved, then any sign-in with the method fails.

If the application is deleted or no longer has permission, users see an error and sign-in fails. The method can't be used.
<!---screenshot of error--->

### Configure an EAM in the admin center

To manage your EAMs in the Microsoft Entra admin center, open the Authentication methods policy. Select the method name to open the configuration options. You can choose which users are included and excluded from using this method. 

:::image type="content" border="true" source="./media/how-to-authentication-external-method-manage/target.png" alt-text="Screenshot of how to scope usage of the EAM for specific users.":::

### Delete an EAM in the admin center

If you no longer want your users to be able to use the EAM, you can either:

- Set **Enable** to **Off** to save the method configuration
- Click **Delete** to remove the method

:::image type="content" border="true" source="./media/how-to-authentication-external-method-manage/delete.png" alt-text="Screenshot of how to delete an EAM.":::

## Manage an EAM using Microsoft Graph

To manage the Authentication methods policy by using Microsoft Graph, you need the `Policy.ReadWrite.AuthenticationMethod` permission. For more information, see [Update authenticationMethodsPolicy](/graph/api/authenticationmethodspolicy-update).

## User experience

Users who are enabled for the EAM can use it when they sign-in and multifactor authentication is required. 

If the user has other ways to sign in and [system-preferred MFA](/entra/identity/authentication/concept-system-preferred-multifactor-authentication) is enabled, those other methods appear by default order. The user can choose to use a different method, and then select the EAM. For example, if the user has Authenticator enabled as another method, they get prompted for [number matching](/entra/identity/authentication/how-to-mfa-number-match).

:::image type="content" border="true" source="./media/how-to-authentication-external-method-manage/system-preferred.png" alt-text="Screenshot of how to choose an EAM when system-preferred MFA is enabled.":::


If the user has no other methods enabled, they can just choose the EAM. They're redirected to the external authentication provider to complete authentication.

:::image type="content" border="true" source="./media/how-to-authentication-external-method-manage/sign-in.png" alt-text="Screenshot of how to sign in with an EAM.":::

## Authentication method registration for EAMs
In the EAM preview, all users who are included in groups that are enabled for EAM are capable to use an EAM to satisfy MFA. These users aren't included in reports on authentication method registration.

Rollout of EAM registration in Microsoft Entra ID is in progress. After the rollout is finished, users who previously used an EAM need to register the EAM again with Microsoft Entra ID before they can use it to satisfy MFA. 

If they didn't sign in with their EAM in the past 28 days, some users might see a change the next time they sign in, depending on their current authentication setup:

- If they registered only an EAM, they need to register their EAM authentication method before they can continue.
- If they registered an EAM and other methods, they might lose access to the EAM for authentication. There's two ways to regain access:
  - They register their EAM at [Security info](https://mysignins.microsoft.com/security-info)
  - An admin must register the EAM on their behalf 

## FAQ

The next section cover common questions and answers.

### How users register their EAM in Security info

Users can follow these steps to register an EAM in Security info:

1. Sign into [Security info](https://mysignins.microsoft.com/security-info)
1. Select **+ Add sign-in method**.
1. When prompted to select a sign-in method from a list of available options, select **External Auth methods**.
1. Select **Next** at the confirmation screen.
1. Complete the second factor challenge with the external provider. If successful, users can see the EAM listed in their sign-in methods. 

### How admins register an EAM for a user

Admins can set a user as registered for an EAM or delete the registration on behalf of the user. This gives admins the ability to mark a user capable of using the authentication method, ensuring the method is available and the user doesn't need to register the method through inline or manual registration. Deleting the method enables the admin to help users who are enabled but not registered for other methods in recovery scenarios, by having their next sign in trigger registration. Admins can mark a user as registered by using Microsoft Graph or the Microsoft Entra admin center

#### Microsoft Graph PowerShell

Use the following sample script. This script is an example only and you should customize it as needed before using it.

```powershell
# PowerShell script to call MSGraph API to register external auth method
 
# How to create ServicePrinciple AppId and give permission for User Auth method read write operation
# 1. Create ServicePrincipal AppId:
#    - Go to Azure Portal (https://portal.azure.com/)
#    - Navigate to "Azure Active Directory" -> "App registrations" -> "New registration"
#    - Enter a name for the application and select "Accounts in this organizational directory only"
#    - click "Register"
#    - After creation, note down the Application (client) ID 
#    - Go to "Certificate & secrets" and create a new client secret, note down the client secret
#
# 2. Give permission for User Auth method read write operation:
#    - In the registered application, navigate to "API permissions" -> "Add a permission"
#    - Select "Microsoft Graph" -> "Application permissions"
#    - Add permissions for "UserAuthenticationMethod.ReadWrite.All"
#    - Click "Grant admin consent" to grant the permissions
# 3. Run the PowerShell script, Follow the steps
#    - Save the Script file on your computer. For Example: C:\ExternalAuth\RegisterExternalAuth.ps1
#    - Open PowerShell on your computer. You can do this by searching for "PowerShell" in the Start menu and selecting "Windows PowerShell".
#    - Use the cd command to navigate to the directory where you saved the script. For example: cd C:\ExternalAuth
#    - Execute the script by providing the required parameters. Here is an example of how to call the script:
#      .\RegisterExternalAuth.ps1 -TenantId "<Your-AzureActiveDirectoryTenantId> -ServicePrincipalAppId "<Your-ServicePrincipalAppId>" -ServicePrincipalAppSecret "<Your-ServicePrincipalAppSecret>" -ExternalAuthMethodConfigId "<Your-ExternalAuthMethodConfigId>" -Users @("<UserObjectId1>", "<UserObjectId2>", "<UserObjectId3>")
#    - Make sure to replace <Your-AzureActiveDirectoryTenantId>,<Your-ServicePrincipalAppId>, <Your-ServicePrincipalAppSecret>, <Your-ExternalAuthMethodConfigId>, and the user object Ids with the actual values
#
# *. Here is a PowerShell script to query all users' object IDs using the Microsoft Graph API and store them in an array. Further, this array can be passed as parameter to the main script.
#    $userObjectIds = @()
#    $usersResponse = Invoke-RestMethod -Uri "https://graph.microsoft.com/v1.0/users" -Headers @{Authorization = "Bearer $Token"} -Method Get
#    foreach ($user in $usersResponse.value) {
#        $userObjectIds += $user.id
#    }
#    $Users = $userObjectIds
 
 
param (
    [Parameter(Mandatory=$true, HelpMessage="The tenant ID of your Azure Active Directory")]
    [string]$TenantId,
    [Parameter(Mandatory=$true, HelpMessage="The Application (client) ID of the ServicePrincipal")]
    [string]$ServicePrincipalAppId,
    [Parameter(Mandatory=$true, HelpMessage="The secret key of the ServicePrincipal")]
    [string]$ServicePrincipalAppSecret,
    [Parameter(Mandatory=$true, HelpMessage="The configuration ID for the external authentication method")]
    [string]$ExternalAuthMethodConfigId,
    [Parameter(Mandatory=$true, HelpMessage="List of user object Ids in array format")]
    [array]$Users
)
 
# Function to get OAuth token
function Get-OAuthToken {
    param (
        [string]$TenantId,
        [string]$ClientId,
        [string]$ClientSecret
    )
    $body = @{
        grant_type    = "client_credentials"
        scope         = "https://graph.microsoft.com/.default"
        client_id     = $ClientId
        client_secret = $ClientSecret
    }
    $response = Invoke-RestMethod -Uri "https://login.microsoftonline.com/$TenantId/oauth2/v2.0/token" -Method Post -ContentType "application/x-www-form-urlencoded" -Body $body
    return $response.access_token
}
 
# Function to register external auth method using MSGraph Batch API
function Register-ExternalAuthMethod {
    param (
        [string]$Token,
        [string]$ExternalAuthMethodConfigId,
        [array]$Users,
        [int]$BatchSize
    )
 
    $graphApiVersion = "beta"
    $totalUsers = $Users.Count
    $batches = [math]::Ceiling($totalUsers / $BatchSize)
 
    # Initialize counters and lists for tracking results
    $successfulBatches = 0
    $failedBatches = 0
    $successfulUsers = 0
    $failedUsers = @()
    for ($i = 0; $i -lt $batches; $i++) {
        $startIndex = $i * $BatchSize
        $endIndex = [math]::Min($startIndex + $BatchSize, $totalUsers)
        $batchUsers = $Users[$startIndex..($endIndex-1)]
 
        # Create batch request body
        $requests = @()
        foreach ($userGuid in $batchUsers) {
            $requests += @{
                id = ($userGuid).ToString()
                method = "POST"
                url = "/users/$userGuid/authentication/externalAuthenticationMethods"
                headers = @{
					"Content-Type" = "application/json"
                }
                body = @{
                    configurationId = $ExternalAuthMethodConfigId
                }
            }
        }
        # Send batch request
        try {
 
            $batchBody = @{
                requests = $requests
            }
 
            $headers = @{
                "Authorization" = "Bearer $Token"
                "Content-Type" = "application/json"
            }
 
            $response = Invoke-RestMethod -Uri "https://graph.microsoft.com/$graphApiVersion/`$batch" -Method Post -Headers $headers -Body ($batchBody | ConvertTo-Json -Depth 5)
 
            $batchFailedUsers = 0
            # Check response for success and failure
            foreach ($result in $response.responses) {
                if ($result.status -In 200..204) {
                    $successfulUsers++
                } else {
                    $batchFailedUsers++
                    $failedUsers += $result.id.split('/')
                }
            }
 
            # Increment successful batch counter if all users succeeded, otherwise increment failed batch counter
            if ($batchFailedUsers -eq 0) {
                $successfulBatches++
            } else {
                $failedBatches++
            }
        } catch {
            # Print error message and increment failed batch counter in case of exception
            Write-Host "Error in batch $($i+1): $_"
 
            # Increment failed batch counter in case of exception
            $failedBatches++
            foreach ($userGuid in $batchUsers) {
                $failedUsers += $userGuid
            }
        }
 
 
        # Show progress of batch execution
        Write-Progress -Activity "Registering External Auth Method" -Status "Processing batch $($i+1) of $batches" -PercentComplete (($i+1) / $batches * 100)
 
        Start-Sleep -Seconds 2
 
    }
 
    # Show final results
    Write-Host "Batch Execution Results:"
    Write-Host "Successful Batches: $successfulBatches"
    Write-Host "Failed Batches: $failedBatches"
    Write-Host "Successful Users: $successfulUsers"
    Write-Host "Failed Users: $(($failedUsers | Measure-Object).Count)"
    Write-Host "Failed User GUIDs: $(($failedUsers | Out-String))"
}
 
# Main script execution
$Token = Get-OAuthToken -TenantId $TenantId -ClientId $ServicePrincipalAppId -ClientSecret $ServicePrincipalAppSecret
 
Register-ExternalAuthMethod -Token $Token -ExternalAuthMethodConfigId $ExternalAuthMethodConfigId -Users $Users -BatchSize 2
```

#### Microsoft Entra admin center

1. In the Microsoft Entra admin center, select **Users** > **All users**.
1. Select the user who needs to be registered for EAM.
1. In the User menu, select **Authentication Methods**, and select **+ Add Authentication Method**. 
1. Select **External authentication method**.
1. Select one or more EAMs, and select **Save**.
1. A success message appears, and the methods that you previously selected are listed in **Usable authentication methods**. 

### Registration experience for end users

When they sign in, users are prompted to begin the registration wizard. Users can select **I want to set up a different method** to proceed. If a user enabled multiple EAMs, they can select from those methods. To register, the user needs to authenticate with the EAM provider. 

If successful, the user can see that registration completed and the EAM is registered. They are redirected to the resource they wanted to access. 

If the authentication fails, the user is redirected back to the registration wizard, and the registration page provides an error message. The user can try again, or chose another way to sign in if they registered other methods.  

## Using EAM and Conditional Access custom controls in parallel

EAMs and custom controls can operate in parallel. Microsoft recommends that admins configure two Conditional Access policies: 

- One policy to enforce the custom control 
- Another policy with the MFA grant required

Include a test group of users for each policy, but not both. If a user is included in both policies, or any policy with both conditions, the user has to satisfy MFA during sign-in. They also have to satisfy the custom control, which makes them redirected to the external provider a second time.

## Next steps

For more information about how to manage authentication methods, see [Manage authentication methods for Microsoft Entra ID](/entra/identity/authentication/concept-authentication-methods-manage).

For EAM provider reference, see [Microsoft Entra multifactor authentication external method provider reference (Preview)](concept-authentication-external-method-provider.md).
