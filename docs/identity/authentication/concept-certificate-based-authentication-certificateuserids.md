---
title: Mapping to the certificateUserIds attribute in Microsoft Entra ID 
description: Learn about certificate user IDs for Microsoft Entra certificate-based authentication without federation

ms.service: entra-id
ms.subservice: authentication
ms.topic: how-to
ms.date: 12/10/2023

ms.author: justinha
author: vimrang
manager: amycolannino
ms.reviewer: vranganathan
ms.custom: has-adal-ref
---

# Mapping to the certificateUserIds attribute in Microsoft Entra ID

User objects in Microsoft Entra ID have an attribute named certificateUserIds.

- The certificateUserIds attribute is multivalued and can hold up to 10 values.
- Each value can be no more than 1024 characters.
- Each value must be unique. Once a value is present on one user account, it can't be written to any other user account in the same Microsoft Entra tenant.
- The value doesn't need to be in email ID format. The certificateUserIds attribute can store nonroutable user principal names (UPNs) like *bob@woodgrove* or *bob@local*.

> [!NOTE]
> Although each value must be unique in Microsoft Entra ID, you can map a single certificate to multiple accounts by implementing multiple username bindings. For more information, see [Multiple username bindings](~/identity/authentication/concept-certificate-based-authentication-technical-deep-dive.md#securing-microsoft-entra-configuration-with-multiple-username-bindings).
 
## Supported patterns for certificate user IDs
 
The values stored in certificateUserIds should be in the format described in the following table. The X509:\<Mapping> prefixes are case-sensitive.

|Certificate mapping Field | Examples of values in certificateUserIds |
|--------------------------|--------------------------------------|
|PrincipalName | `X509:<PN>bob@woodgrove.com` |
|PrincipalName | `X509:<PN>bob@woodgrove`   | 
|RFC822Name	| `X509:<RFC822>user@woodgrove.com` |
|IssuerAndSubject | `X509:<I>DC=com,DC=contoso,CN=CONTOSO-DC-CA<S>DC=com,DC=contoso,OU=UserAccounts,CN=mfatest` |
|Subject | `X509:<S>DC=com,DC=contoso,OU=UserAccounts,CN=mfatest`  |
|SKI | `X509:<SKI>aB1cD2eF3gH4iJ5kL6mN7oP8qR` |
|SHA1PublicKey |`X509:<SHA1-PUKEY>cD2eF3gH4iJ5kL6mN7oP8qR9sT` |
|IssuerAndSerialNumber | `X509:<I>DC=com,DC=contoso,CN=CONTOSO-DC-CA<SR>eF3gH4iJ5kL6mN7oP8qR9sT0uV` <br> To get the correct value for serial number, run this command and store the value shown in certificateUserIds:<br> **Syntax**:<br> `Certutil –dump –v [~certificate path~] >> [~dumpFile path~]` <br> **Example**: <br> `certutil -dump -v firstusercert.cer >> firstCertDump.txt` |

## Roles to update certificateUserIds

Cloud-only users must have at least **Privileged Authentication Administrator** role to update certificateUserIds. Cloud-only users can use either the Microsoft Entra admin center or Microsoft Graph to update certificateUserIds. 

Synchronized users must have at least **Hybrid Identity Administrator** role to update certificateUserIds. Only Microsoft Entra Connect can be used to update certificateUserIds by synchronizing the value from on-premises. 

>[!NOTE]
>Active Directory administrators can make changes that impact the certificateUserIds value in Microsoft Entra ID for any synchronized account. Administrators can include accounts with delegated administrative privilege over synchronized user accounts, or administrative rights over the Microsoft Entra Connect servers.

## Update certificateUserIds
 
Use the following steps to update certificateUserIds for users:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Privileged Authentication Administrator](~/identity/role-based-access-control/permissions-reference.md#privileged-authentication-administrator) for cloud-only users or as at least a [Hybrid Identity Administrator](~/identity/role-based-access-control/permissions-reference.md#hybrid-identity-administrator) for synchronized users. 

1. Search for and select **All users**. 

   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-certificateuserids/user.png" alt-text="Screenshot of test user account.":::

1. Click a user, and click **Edit Properties**. 

1. Next to **Authorization info**, click **View**.

   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-certificateuserids/view.png" alt-text="Screenshot of View authorization info.":::

1. Click **Edit certificate user IDs**.

   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-certificateuserids/edit-cert.png" alt-text="Screenshot of Edit certificate user IDs.":::

1. Click **Add**.

   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-certificateuserids/add.png" alt-text="Screenshot of how to add a certificateUserIds.":::

1. Enter the value and click **Save**. You can add up to four values, each of 120 characters.

   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-certificateuserids/save.png" alt-text="Screenshot of a value to enter for certificateUserIds.":::

## Update certificateUserIds using Microsoft Graph queries

The following examples show how to use Microsoft Graph to look up certificateUserIds and update them.

### Look up certificateUserIds

Authorized callers can run Microsoft Graph queries to find all the users with a given certificateUserId value. On the Microsoft Graph [user](/graph/api/resources/user) object, the collection of certificateUserIds is stored in the **authorizationInfo** property.

To retrieve certificateUserIds of all user objects:

```msgraph-interactive
GET https://graph.microsoft.com/v1.0/users?$select=authorizationinfo
ConsistencyLevel: eventual
```
To retrieve certificateUserIds for a given user by user's ObjectId:

```msgraph-interactive
GET https://graph.microsoft.com/v1.0/users/{user-object-id}?$select=authorizationinfo
ConsistencyLevel: eventual
```
To retrieve the user object with a specific value in certificateUserIds:


```msgraph-interactive
GET https://graph.microsoft.com/v1.0/users?$select=authorizationinfo&$filter=authorizationInfo/certificateUserIds/any(x:x eq 'X509:<PN>user@contoso.com')&$count=true
ConsistencyLevel: eventual
```

You can also use the `not` and `startsWith` operators to match the filter condition. To filter against the certificateUserIds object, the request must include the `$count=true` query string, and the **ConsistencyLevel** header must be set to `eventual`.

### Update certificateUserIds

Run a PATCH request to update the certificateUserIds for a given user.

#### Request body

```http
PATCH https://graph.microsoft.com/v1.0/users/{user-object-id}
Content-Type: application/json
{
    "authorizationInfo": {
        "certificateUserIds": [
            "X509:<PN>123456789098765@mil"
        ]
    }
}
```
## Update certificateUserIds using PowerShell commands

For this configuration, you can use [Microsoft Graph PowerShell](/powershell/microsoftgraph/installation).

1. Start PowerShell with administrator privileges.
1. Install and import the Microsoft Graph PowerShell SDK.

   ```powershell
       Install-Module Microsoft.Graph -Scope AllUsers
       Import-Module Microsoft.Graph.Authentication
       Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
   ```
1. Connect to the tenant and accept all.

   ```powershell
      Connect-MGGraph -Scopes "Directory.ReadWrite.All", "User.ReadWrite.All" -TenantId <tenantId>
   ```
1. List certificateUserIds attribute of a given user.

   ```powershell
     $results = Invoke-MGGraphRequest -Method get -Uri 'https://graph.microsoft.com/v1.0/users/<userId>?$select=authorizationinfo' -OutputType PSObject -Headers @{'ConsistencyLevel' = 'eventual' }
     #list certificateUserIds
     $results.authorizationInfo
   ```
1. Create a variable with certificateUserIds values.
   
   ```powershell
     #Create a new variable to prepare the change. Ensure that you list any existing values you want to keep as this operation will overwrite the existing value
     $params = @{
           authorizationInfo = @{
                 certificateUserIds = @(
                 "X509:<SKI>gH4iJ5kL6mN7oP8qR9sT0uV1wX", 
                 "X509:<PN>user@contoso.com"
                 )
           }
     }
   ```
1. Update the certificateUserIds attribute.

   ```powershell
      $results = Invoke-MGGraphRequest -Method patch -Uri 'https://graph.microsoft.com/v1.0/users/<UserId>/?$select=authorizationinfo' -OutputType PSObject -Headers @{'ConsistencyLevel' = 'eventual' } -Body $params
   ```

**Update certificateUserIds using user object**

1. Get the user object.

   ```powershell
     $userObjectId = "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
     $user = Get-MgUser -UserId $userObjectId -Property AuthorizationInfo
   ```

1. Update the certificateUserIds attribute of the user object.

   ```powershell
      $user.AuthorizationInfo.certificateUserIds = @("X509:<SKI>iJ5kL6mN7oP8qR9sT0uV1wX2yZ", "X509:<PN>user1@contoso.com") 
      Update-MgUser -UserId $userObjectId -AuthorizationInfo $user.AuthorizationInfo
   ```
   
<a name='update-certificate-user-ids-using-azure-ad-connect'></a>

## Update certificateUserIds using Microsoft Entra Connect

Microsoft Entra Connect supports synchronizing values to certificateUserIds from an on-premises Active Directory environment. On-premises Active Directory supports certificate-based authentication and multiple username bindings. Make sure you use the latest version of [Microsoft Entra Connect](https://www.microsoft.com/download/details.aspx?id=47594).

To use these mapping methods, you need to populate the altSecurityIdentities attribute of user objects in the on-premises Active Directory. 
In addition, after you apply certificate-based authentication changes on Windows domain controllers as described in [KB5014754](https://support.microsoft.com/topic/kb5014754-certificate-based-authentication-changes-on-windows-domain-controllers-ad2c23b0-15d8-4340-a468-4d4f3b188f16), you may have implemented some of the non-reusable mapping methods (Type=strong) mapping methods to meet the on-premise Active Directory strong certificate binding enforcement requirements. 

To prevent synchronization errors, make sure the values being synchronized follow one of the supported formats for the certificateUserIds.  

Before you begin, make sure all user accounts that are synchronized from on-premises Active Directory have:

- 5 or fewer values in their altSecurityIdentities attributes 
- No value with more then 1024 characters
- No duplicate values
  
  Carefully consider if a duplicate value is meant to map a single certificate to multiple on-premises Active Directory accounts. For more information, see [Multiple username bindings](~/identity/authentication/concept-certificate-based-authentication-technical-deep-dive.md#securing-microsoft-entra-configuration-with-multiple-username-bindings).

  >[!NOTE]
  >In specific scenarios, a subset of users might have a valid business justification to map a single certificate to more than one on-premises Active Directory account. Review these scenarios and where needed, implement separate mapping methods to map to more then one account in both the on-premises Active Directory and Microsoft Entra ID.

**Considerations for ongoing synchronization of certificateUserIds**

- Ensure that the provisioning process for populating the values in on-premises Active Directory implements proper hygiene. Only values associated with current valid certificates are populated.
- Values are removed when the corresponding certificate is expired or revoked.
- Values larger then 1024 characters aren't populated.
- Duplicate values aren't provisioned.
- Use Microsoft Entra Connect Health to monitor synchronization.

Follow these steps to configure Microsoft Entra Connect to synchronize userPrincipalName to certificateUserIds:

1. On the Microsoft Entra Connect server, find and start the **Synchronization Rules Editor**.

1. Click **Direction**, and click **Outbound**. 

   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-certificateuserids/outbound.png" alt-text="Screenshot of outbound synchronization rule.":::

1. Find the rule **Out to Microsoft Entra ID – User Identity**, click **Edit**, and click **Yes** to confirm. 

   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-certificateuserids/user-identity.png" alt-text="Screenshot of user identity.":::

1. Enter a high number in the **Precedence** field, and then click **Next**. 

   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-certificateuserids/precedence.png" alt-text="Screenshot of a precedence value.":::

1. Click **Transformations** > **Add transformation**. You may need to scroll down the list of transformations before you can create a new one. 

### Synchronize X509:\<PN>PrincipalNameValue
 
To synchronize X509:\<PN>PrincipalNameValue, create an outbound synchronization rule, and choose **Expression** in the flow type. Choose the target attribute as **certificateUserIds**, and in the source field, add the following expression. If your source attribute isn't userPrincipalName, you can change the expression accordingly.

```
"X509:<PN>"&[userPrincipalName]
```
 
:::image type="content" border="true" source="./media/concept-certificate-based-authentication-certificateuserids/pnexpression.png" alt-text="Screenshot of how to sync x509.":::
 
### Synchronize X509:\<RFC822>RFC822Name

To synchronize X509:\<RFC822>RFC822Name, create an outbound synchronization rule and choose **Expression** in the flow type. Choose the target attribute as **certificateUserIds**, and in the source field, add the following expression. If your source attribute isn't userPrincipalName, you can change the expression accordingly.  

```
"X509:<RFC822>"&[userPrincipalName]
```

:::image type="content" border="true" source="./media/concept-certificate-based-authentication-certificateuserids/rfc822expression.png" alt-text="Screenshot of how to sync RFC822Name.":::

1. Click **Target Attribute**, select **certificateUserIds**, click **Source**, select **userPrincipalName**, and then click **Save**. 

   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-certificateuserids/edit-rule.png" alt-text="Screenshot of how to save a rule.":::

1. Click **OK** to confirm. 

>[!IMPORTANT]
> The preceding examples use userPrincipalName atribute as a source attribute in the transform rule. You can use any available attribute with the appropriate value. For example, some organizations use the mail attribute. For more complex transform rules, see [Microsoft Entra Connect Sync: Understanding Declarative Provisioning Expressions](~/identity/hybrid/connect/concept-azure-ad-connect-sync-declarative-provisioning-expressions.md)


For more information about declarative provisioning expressions, see [Microsoft Entra Connect: Declarative Provisioning Expressions](~/identity/hybrid/connect/concept-azure-ad-connect-sync-declarative-provisioning-expressions.md).

<a name='synchronize-alternativesecurityid-attribute-from-ad-to-azure-ad-cba-certificateuserids'></a>

<a name='synchronize-altsecurityidentities-attribute-from-active-directory-to-microsoft-entra-id-certificateuserids'></a>

## Synchronize altSecurityIdentities attribute from Active Directory to Microsoft Entra certificateUserIds

The altSecurityIdentities attribute isn't part of the default attributes set. An administrator needs to add a new attribute to the person object in the Metaverse, and then create the appropriate synchronization rules to relay this data to certificateUserIds in Microsoft Entra ID.

1. Open Metaverse Designer and select the person object. To create the alternativeSecurityId attribute, click **New attribute**. Select **String (non-indexable)** to create an attribute size up to 1024 characters, which is the maximum supported length for certificateUserIds. If you select **String (indexable)**, the maximum size of an attribute value is 448 characters. Make sure you select **Multi-valued**.
 
   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-certificateuserids/new-attribute.png" alt-text="Screenshot of how to create a new attribute.":::

1. Open Metaverse Designer, and select alternativeSecurityId to add it to the person object.

   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-certificateuserids/alt-security-identity-add.png" alt-text="Screenshot of how to add alternativeSecurityId to the person object.":::

1. Create an inbound synchronization rule to transform from altSecurityIdentities to alternativeSecurityId attribute.

   In the inbound rule, use the following options.
  
   |Option | Value |
   |-------|-------|
   |Name | Descriptive name of the rule, such as: In from Active Directory - altSecurityIdentities |
   |Connected System | Your on-premises Active Directory domain |
   |Connected System Object Type | user |
   |Metaverse Object Type | person |
   |Precedence | Choose a number under 100 that isn't currently used  |
  
   Then click **Transformations** and create a direct mapping to the target attribute alternativeSecurityId from the source attribute altSecurityIdentities, as shown in the following screenshot.

   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-certificateuserids/alt-security-identity-inbound.png" alt-text="Screenshot of how to transform from altSecurityIdentities to alternateSecurityId attribute.":::

1. Create an outbound synchronization rule to transform from the alternativeSecurityId attribute to the certificateUserIds attribute in Microsoft Entra ID.

   |Option | Value |
   |-------|-------|
   |Name | Descriptive name of the rule, such as: Out to Microsoft Entra ID - certificateUserIds |
   |Connected System | Your Microsoft Entra domain |
   |Connected System Object Type | user |
   |Metaverse Object Type | person |
   |Precedence | Choose a high number not currently used above all default rules, such as 150 |

   Then click **Transformations** and create a direct mapping to the target attribute certificateUserIds from the source attribute alternativeSecurityId, as shown in the following screenshot. 

   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-certificateuserids/alt-security-identity-outbound.png" alt-text="Screenshot of outbound synchronization rule to transform from alternateSecurityId attribute to certificateUserIds.":::

1. Run the synchronization to populate data to the certificateUserIds attribute.
1. To verify success, view the Authorization info of a user in Microsoft Entra ID.

   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-certificateuserids/auth-info.png" alt-text="Screenshot of successful synchronization.":::

To map a subset of values from the altSecurityIdentities attribute, replace the Transformation in step 4 with an Expression. To use an Expression, proceed to the **Transformations** tab and change your FlowType option to Expression, the target attribute to certificateUserIds, and then input the expression into the Source field. The following example filters only values that align to the SKI and SHA1PublicKey Certificate mapping fields:

:::image type="content" border="true" source="./media/concept-certificate-based-authentication-certificateuserids/view-rule.png" alt-text="Screenshot of an Expression.":::

**Expression code**:

```powershell
IIF(IsPresent([alternativeSecurityId]),
                Where($item,[alternativeSecurityId],BitOr(InStr($item, "X509:<SKI>"),InStr($item, "X509:<SHA1-PUKEY>"))>0),[alternativeSecurityId]
)
```

Administrators can filter values from altSecurityIdentities that align with the supported patterns. Ensure that the CBA configuration has been updated to support the username bindings that are being synchronized to certificateUserIds to enable authentication using these values. 

## Next steps

- [Overview of Microsoft Entra CBA](concept-certificate-based-authentication.md)
- [Technical deep dive for Microsoft Entra CBA](concept-certificate-based-authentication-technical-deep-dive.md)
- [How to configure Microsoft Entra CBA](how-to-certificate-based-authentication.md)
- [Microsoft Entra CBA on iOS devices](concept-certificate-based-authentication-mobile-ios.md)
- [Microsoft Entra CBA on Android devices](concept-certificate-based-authentication-mobile-android.md)
- [Windows smart card logon using Microsoft Entra CBA](concept-certificate-based-authentication-smartcard.md)
- [How to migrate federated users](concept-certificate-based-authentication-migration.md)
- [FAQ](certificate-based-authentication-faq.yml)
