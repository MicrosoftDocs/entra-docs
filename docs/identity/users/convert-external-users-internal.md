---
title: Convert external users to internal users (Preview)
description: You can convert users from external to internal without the need to recreate them.
services: active-directory 
author: barclayn
ms.author: barclayn
manager: amycolannino
ms.date: 12/13/2023
ms.topic: how-to
ms.service: active-directory
ms.subservice: enterprise-users
ms.workload: identity
ms.custom: 
ms.reviewer: yuank

---

# Convert external users to internal users (Preview)

Enterprises go through reorganizations, mergers and acquisitions may require a change in the way you work with some users. In some cases, you could need to change existing external users into internal ones. External user conversion enables administrators to turn external users to internal members without the need to delete the existing user object and create new one. Keeping the original object ensures the 
user’s account and access isn’t disrupted and that their history of activities remains intact as their relationship with the host organization changes

- **Internal users** are users who authenticate with the internal tenant.
- **External users** are those users who authenticate via a method not managed by the host organization, for example, another organization’s Azure AD, Google fed, Microsoft account, etc. While many external users likely have a userType of ‘guest’ there is no formal relation between userType and how a user signs-in. As a 
result, some external users may have a userType of ‘member’. These users will also be eligible for 
conversion.

External user conversion takes external users and converts them into internal users and as part of the conversion process, updates the userType from guest to member.
Maintaining the same underlying object ensures the user's account and access to resources isn't disrupted and that their history of activities remains intact as their relationship with the host organization changes.

Customers using cross-tenant sync for their Mergers and Acquisitions (M&A) create B2B external users in their home tenant first. As external users have a lot of restrictions, this conversion capability is key to the tenant migration / consolidation for these customers' M&A scenarios.

The API includes the ability to convert on-prem synced external users to synced internal users. When converting a cloud-only external user, the admin must specify the UPN and password for the user, to allow the user to authenticate with the host's organization. The API updates the userType from guest to member and also stamps the "externalUserConvertedOn" attribute with a datetime value indicating when the user was converted. When an on-prem synced user is converted, you can't specify UPN or password. The user will continue to use the on-prem credentials, as on-prem synced user is managed on-prem.

External User Conversion can be performed using MS Graph API or the Entra ID Portal.

External users are those that authenticate via a method not managed by the host organization (i.e., another organization's Azure AD, Google federation, Microsoft account, etc.) While many external users likely have a userType of guest there is no formal relation between userType and how a user signs-in. As a result, some external users may have a userType of member. These users will also be eligible for conversion.

>[!NOTE]
> When an external user is converted the property "convertedToInternalUserDateTime" gets stamped on their object.

## Converting external users

It is important to note that a userType of member vs guest doesn't indicate where a user authenticates. Member vs guest only defines the level of permissions the user has in the current tenant. Customers can update the user type for their users, but that alone doesn't change the users' external vs internal state.

Cloud user conversion
When a cloud user is converted from external to internal, administrators must specify a UPN and password for the user. This ensures the user can authenticate with the current tenant.

Synched user conversion
For on-prem synced users where the tenant is a managed, meaning it uses cloud authentication, administrators are required to specify a password during conversion.

For on-prem synced users where the tenant uses federated authentication and Password Hash Sync (PHS) is enabled, administrators are blocked from setting a new password during conversion. However, if the federated tenant does not have PHS enabled, administrators have the option to set a password.

| Tenant Authentication type | Password Hash Sync enabled | Password Hash Sync disabled |
|---------------------------|----------------------------|-----------------------------|
| Federated                 | Block Write Password       | Allow Write Password        |
| Managed                   | Force Write Password       | Force Write Password     |

>[!NOTE]
> Password hash sync does not have the user's password



## Testing external user conversion

When testing external user conversion we recommend you use test accounts or accounts that would not create a disruption if unavailable.

### Requirements

- Converting external users requires an account with at least the [user administrator](~/identity/role-based-access-control/permissions-reference.md#user-administrator)
role assigned.
- Only users configured with an authentication method external to the host organization are eligible for conversion. 
    - A check for eligibility is performed via an internal property that stores information regarding external sign in types. If a user is not eligible for conversion the API or PS command will return a 400 "Bad request" with a message that the user isn't eligible.
- If you are using MSGraph API from your own application, the least privileged permission is required is ‘UserConvertToInternal.ReadWrite.All” permission.

### Converting a user via MS Graph API

Detailed steps on calling Microsoft Graph API are available [here](/graph/call-api)

When converting a user, you can specify which user you’d like to convert via object ID or user principal name (UPN). The following are the required and optional input parameters for the API & PS command.

Here is a markdown version of the table in the parameters section on the current web page:

| Parameter name | Type | Required | Description |
| -------------- | ---- | -------- | ----------- |
| userPrincipalName | String | Yes | New UPN value for the user. For cloud-only users, the UPN domain must be one that is non-federated¹[1]. For on-prem synced users, you don't need to provide a UPN²[2]³[3]. The user will continue to use the on-prem credentials. |⁴[4]⁵[5]
| passwordProfile | passwordProfile | Yes | New temporary password for the user and whether to force change password on login. For on-prem synced users, you can't configure a password⁶[6]³[3]. The user will continue to use the on-prem credentials. |⁴[4]⁵[5]
| mail | String | No | Optional new mail address for cloud users. |


#### API call that provides the required UPN and password profile.


```json
POST https://graph.microsoft.com/beta/users/{id}/convertExternalToInternalMemberUser
{
 "userprincipalName": "user1Name",
"passwordProfile": 
 { 
 "password": "te$tPassw0rd", 
 "forceChangePasswordNextSignIn": "true" 
}
}
```

```json
HTTP/1.1 200 OK
{
 "id": "ddbc5871-cc95-4b99-a162-ecdc91ece43e"
 "displayName": "user1Name",
 "userPrincipalName": "newUpn@contoso.com",
 "convertedToInternalUserDateTime": "9999-12-31T23:59:59.9999999"
}
```

#### converts an on-prem synced user:

```
POST https://graph.microsoft.com/v1.0/users/id/convertExternalToInternalMemberUser

```

The successful response returns the 200 OK status and a payload of the following format:

```json
HTTP/1.1 200 OK

{
 "id": "ddbc5871-cc95-4b99-a162-ecdc91ece43e"
 "displayName": "user1Name",
 "userPrincipalName": "newUpn@contoso.com",
 "convertedToInternalUserDateTime": "9999-12-31T23:59:59.9999999"
}

```

#### Example of an error condition when encountering an invalid UPN

```json
POST https://graph.microsoft.com/beta/users/{id}/convertExternalToInternalMemberUser
{
 "userPrincipalName": "newUPN@fabrikam.com",
 "passwordProfile: {
 "password": "testPassword",
 "forceChangePasswordNextSignIn": "true"
 }
}

```

Returns

```json

HTTP/1.1 400 Bad Request
{
 "message": "UserPrincipalName domain is not a verified domain or shared domain on 
the company."
}
```

#### Example failed operation converting on-prem synced users if UPN or password are provided

```json
POST https://graph.microsoft.com/v1.0/users/id/convertExternalToInternalMemberUser
{
 "userprincipalName": "user1Name"
 "passwordProfile": { "password": "te$tPassw0rd", "forceChangePasswordNextSignIn": 
"true" }
}
HTTP/1.1 400 Bad Request
{
 "error": {
 "code": "badRequest",
 "message": "For users synchronized from on-premises, userPrincipalName and 
passwordProfile must be empty"
 }
}

```

#### Example how to retrieve the **convertedToInternalUserDateTime** property

When an external user is converted the property ```convertedToInternalUserDateTime``` is stamped on 
their object. You can use this property to query for converted users like so:

```json
GET https://graph.microsoft.com/beta/users?$filter=externalUserConvertedOn ge 2022-
01-01T00:00:00Z
HTTP/1.1 200 OK
{
 "value": [
 {
 "displayName": "user1Name",
 " convertedToInternalUserDateTime" : "2022-01-02T23:59:59.9999999"
 },
 {
 "displayName": "user2Name",
 " convertedToInternalUserDateTime" : "2022-01-03T23:59:59.9999999"
 }
 ]
}

```

## Known issues

- Currently, converted users may not be able to access Teams Shared Channels. We are working 
with the Teams team to actively resolve this issue.
- Converted users cannot access Viva Engage (Yammer).
- A user cannot be converted if they have a role assigned to them.

### Errors

| Scenario | Code | Message |
| --- | --- | --- |
| UserPrincipalName email domain does not belong to the tenant verified domain list. | 400 | The provided UPN does not have a valid domain. |
| UserPrincipalName is empty. | 400 | The provided UPN cannot be empty. |
| Mail address email domain does not belong to the tenant verified domain list. | 400 | The provided UPN does not have a valid domain. |
| Mail address is empty "". | 400 | The mail provided cannot be empty. |
| Password is invalid. | 400 | The provided password is not valid. |
| User is not eligible for conversion. | 400 | The user authentication is already internal and is not eligible for conversion. |
| UserPrincipalName name and password should be empty for on prem users | 400 | For users synchronized from on-premises, userPrincipalName and passwordProfile must be empty |
| UserState is neither accepted nor pending. | 412 | If a user who was previously converted from external to internal is invited again, this error indicates the user cannot be convereted back to external. Search for any users in tenant matching invited email and confirm user was previously converted via externalUserConvertedOn attribute presence |


## Questions and feedback

If you have questions or feedback about external user conversion email 