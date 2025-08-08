---
title: Self-service password reset deep dive
description: How does self-service password reset work
ms.service: entra-id
ms.subservice: authentication
ms.topic: article
ms.date: 03/04/2025
ms.author: justinha
author: justinha
manager: femila
ms.reviewer: tilarso
ms.custom: sfi-ga-nochange, sfi-image-nochange
---
# How it works: Microsoft Entra self-service password reset

Microsoft Entra self-service password reset (SSPR) gives users the ability to change or reset their password, with no administrator or help desk involvement. If a user's account is locked or they forget their password, they can follow prompts to unblock themselves and get back to work. This ability reduces help desk calls and loss of productivity when a user can't sign in to their device or an application. We recommend this video on [how to enable and configure SSPR in Microsoft Entra ID](https://www.youtube.com/watch?v=rA8TvhNcCvQ).

> [!IMPORTANT]
> This conceptual article explains to an administrator how self-service password reset works. If you're an end user already registered for self-service password reset and need to get back into your account, go to [https://aka.ms/sspr](https://aka.ms/sspr).
>
> If your IT team hasn't enabled the ability to reset your own password, reach out to your helpdesk for additional assistance.

## How does the password reset process work?

A user can reset or change their password using the [SSPR portal](https://aka.ms/sspr). Also to highlight SSPR for Administrators isn't enabled on the tenant by default as SSPR is only for the end users.  They must first register their desired authentication methods. When a user accesses the SSPR portal, the Microsoft Entra platform considers the following factors:

* How should the page be localized?
* Is the user account valid?
* What organization does the user belong to?
* Where is the user's password managed?

When a user selects the **Can't access your account** link from an application or page, or goes directly to [https://aka.ms/sspr](https://passwordreset.microsoftonline.com), the language used in the SSPR portal is based on the following options:

* By default, the browser locale is used to display the SSPR in the appropriate language. The password reset experience is localized into the same languages that [Microsoft 365 supports](https://support.microsoft.com/office/what-languages-is-office-available-in-26d30382-9fba-45dd-bf55-02ab03e2a7ec).
* If you want to link to the SSPR in a specific localized language, append `?mkt=` to the end of the password reset URL along with the required locale.
    * For example, to specify the Spanish *es-us* locale, use `?mkt=es-us` - [https://passwordreset.microsoftonline.com/?mkt=es-us](https://passwordreset.microsoftonline.com/?mkt=es-us).

After the SSPR portal is displayed in the required language, the user is prompted to enter a user ID and pass a captcha. Microsoft Entra ID now verifies that the user is able to use SSPR by doing the following checks:

* Checks that the user has SSPR enabled.
  * If the user isn't enabled for SSPR, the user is asked to contact their administrator to reset their password.
* Checks that the user has the right authentication methods defined on their account in accordance with administrator policy.
  * If the policy requires only one method, check that the user has the appropriate data defined for at least one of the authentication methods enabled by the administrator policy.
    * If the authentication methods aren't configured, the user is advised to contact their administrator to reset their password.
  * If the policy requires two methods, check that the user has the appropriate data defined for at least two of the authentication methods enabled by the administrator policy.
    * If the authentication methods aren't configured, the user is advised to contact their administrator to reset their password.
  * If an Azure administrator role is assigned to the user, then the strong two-gate password policy is enforced. For more information, see [Administrator reset policy differences](concept-sspr-policy.md#administrator-reset-policy-differences).
* Checks to see if the user's password is managed on-premises, such as if the Microsoft Entra tenant is using federated, pass-through authentication, or password hash synchronization:
  * If SSPR writeback is configured and the user's password is managed on-premises, the user is allowed to proceed to authenticate and reset their password.
  * If SSPR writeback isn't deployed and the user's password is managed on-premises, the user is asked to contact their administrator to reset their password.

If all of the previous checks are successfully completed, the user is guided through the process to reset or change their password.

> [!NOTE]
> SSPR may send email notifications to users as part of the password reset process. These emails are sent using the SMTP relay service, which operates in an active-active mode across several regions.
>
> SMTP relay services receive and process the email body, but don't store it. The body of the SSPR email that may potentially contain customer provided info isn't stored in the SMTP relay service logs. The logs only contain protocol metadata.

To get started with SSPR, complete the following tutorial:

> [!div class="nextstepaction"]
> [Tutorial: Enable self-service password reset (SSPR)](tutorial-enable-sspr.md)


## Require users to register when they sign in

You can enable the option to require a user to complete the SSPR registration if they use modern authentication or web browser to sign in to any applications using Microsoft Entra ID. This workflow includes the following applications:

* Microsoft 365
* Microsoft Entra admin center
* Access Panel
* Federated applications
* Custom applications using Microsoft Entra ID

When you don't require registration, users aren't prompted during sign-in, but they can manually register. Users can either visit [https://aka.ms/ssprsetup](https://aka.ms/ssprsetup) or select the **Register for password reset** link under the **Profile** tab in the Access Panel.

:::image type="content" border="true" source="media/concept-sspr-howitworks/registration.png" alt-text="Screenshot of password reset registration for Microsoft Entra ID.":::

> [!NOTE]
> Users can dismiss the SSPR registration portal by selecting **cancel** or by closing the window. However, they're prompted to register each time they sign in until they complete their registration.
>
> This interrupt to register for SSPR doesn't break the user's connection if they're already signed in.

## Reconfirm authentication information

You can require users to confirm their authentication information after a certain period of time. This option is only available if you enable the **Require users to register when signing in** option.

Valid values to prompt a user to confirm their authentication information are from *0* to *730* days. Setting this value to *0* means that users are never asked to confirm their authentication information. Users need to sign in before they can reconfirm their information.

> [!NOTE]
> If SSPR requires more than one authentication method, a user who deletes a method isn't required to confirm their authentication information until they reach the **Number of days before users are asked to re-confirm their authentication information**.

## Authentication methods

When a user is enabled for SSPR, they must register at least one authentication method. We highly recommend that you choose two or more authentication methods so that your users have more flexibility in case they're unable to access one method when they need it. For more information, see [What are authentication methods?](concept-authentication-methods.md).

The following authentication methods are available for SSPR:

* Mobile app notification
* Mobile app code
* Hardware OATH token
* Software OATH token
* Email
* Mobile phone
* Office phone (available only for tenants with paid subscriptions)
* Security questions

Users can only reset their password if they register an authentication method that the administrator has enabled.

> [!WARNING]
> Accounts assigned Azure *administrator* roles are required to use methods as defined in the section [Administrator reset policy differences](concept-sspr-policy.md#administrator-reset-policy-differences).

:::image type="content" border="true" source="media/concept-sspr-howitworks/authentication-methods.png" alt-text="Screenshot of the Authentication methods policy for Microsoft Entra ID.":::

### Number of authentication methods required

You can configure the number of the available authentication methods a user must provide to reset or unlock their password. This value can be set to either *one* or *two*.

Users should register multiple authentication methods so they can sign-in another way if they're unable to access one method.

If a user doesn't register the minimum number of required methods, they see an error page when they try to use SSPR. They need to request that an administrator reset their password. For more information, see [Change authentication methods](#change-authentication-methods).

#### Mobile app and SSPR

When using a mobile app as a method for password reset, like Microsoft Authenticator, the following considerations apply if an organization hasn't [migrated to the centralized Authentication methods policy](how-to-authentication-methods-manage.md):

* When administrators require one method be used to reset a password, verification code is the only option available.
* When administrators require two methods be used to reset a password, users are able to use notification **OR** verification code in addition to any other enabled methods.

| Number of methods required to reset | One | Two |
| :---: | :---: | :---: |
| Mobile app features available | Code | Code or Notification |

Users can register their mobile app at [https://aka.ms/mfasetup](https://aka.ms/mfasetup), or in the combined security info registration at [https://aka.ms/setupsecurityinfo](https://aka.ms/setupsecurityinfo).

> [!IMPORTANT]
> Authenticator can't be selected as the only authentication method when only one method is required. Similarly, Authenticator and only one additional method can't be selected if you require two methods.
>
> When configuring SSPR policies that include the Authenticator app as a method, at least one additional method should be selected when one method is required, and at least two additional methods should be selected when configuring two methods are required.

### Change authentication methods

If you start with a policy that has only one required authentication method for reset or unlock registered and you change that to two methods, what happens?

| Number of methods registered | Number of methods required | Result |
| :---: | :---: | :---: |
| 1 or more | 1 | **Able** to reset or unlock |
| 1 | 2 | **Unable** to reset or unlock |
| 2 or more | 2 | **Able** to reset or unlock |

Changing the available authentication methods may also cause problems for users. If you change which authentication methods are available, users without the minimum amount of data available can't use SSPR.

Consider the following example scenario:

1. The original policy is configured with two authentication methods required. It uses only the office phone number and the security questions.
1. The administrator changes the policy to no longer use the security questions, but allows the use of a mobile phone and an alternate email.
1. Users without the mobile phone or alternate email fields populated now can't reset their passwords.

## Notifications

To improve awareness of password events, SSPR lets you configure notifications for both the users and identity administrators.

### Notify users on password resets

If this option is set to **Yes**, users resetting their password receive an email notifying them that their password has been changed. The email is sent via the SSPR portal to their primary and alternate email addresses that are stored in Microsoft Entra ID. If no primary or alternate email address is defined SSPR will attempt email notification via the users User Principal Name (UPN). No one else is notified of the reset event.

### Notify all admins when other admins reset their passwords

If this option is set to **Yes**, then Global Administrators receive an email to their primary email address stored in Microsoft Entra ID. The email notifies them that another administrator has changed their password by using SSPR.

> [!NOTE]
> Email notifications from the SSPR service will be sent from the following addresses based on the Azure cloud you are working with: 
> - Public: msonlineservicesteam@microsoft.com, msonlineservicesteam@microsoftonline.com
> - Microsoft Azure operated by 21Vianet (Azure in China): msonlineservicesteam@oe.21vianet.com, 21Vianetonlineservicesteam@21vianet.com
> - Azure for US Government: msonlineservicesteam@azureadnotifications.us, msonlineservicesteam@microsoftonline.us
>
> If you observe issues in receiving notifications, please check your spam settings. 

If you want custom administrators to receive the notification emails, use SSPR customizations and [set up a custom helpdesk link or email](/entra/identity/authentication/tutorial-enable-sspr#set-up-notifications-and-customizations).

## On-premises integration

In a hybrid environment, you can configure Microsoft Entra Connect cloud sync to write password change events back from Microsoft Entra ID to an on-premises directory.

:::image type="content" border="true" source="media/concept-sspr-howitworks/password-writeback-enabled.png" alt-text="Screenshot of password writeback enabled for Microsoft Entra ID to an on-premises integration.":::

Microsoft Entra ID checks your current hybrid connectivity and provides messages in the Microsoft Entra admin center. For help with resolving possible errors, see [Troubleshoot Microsoft Entra Connect](./troubleshoot-sspr-writeback.md).

To get started with SSPR writeback, complete the following tutorial:

> [!div class="nextstepaction"]
> [Tutorial: Enable self-service password reset (SSPR) writeback](./tutorial-enable-sspr-writeback.md)

### Write back passwords to your on-premises directory

You can enable password writeback using the Microsoft Entra admin center. You can also temporarily disable password writeback without having to reconfigure Microsoft Entra Connect.

* If the option is set to **Yes**, then writeback is enabled. Federated, pass-through authentication, or password hash synchronized users are able to reset their passwords.
* If the option is set to **No**, then writeback is disabled. Federated, pass-through authentication, or password hash synchronized users aren't able to reset their passwords.

### Allow users to unlock accounts without resetting their password

By default, Microsoft Entra ID unlocks accounts when it performs a password reset. To provide flexibility, you can choose to allow users to unlock their on-premises accounts without having to reset their password. Use this setting to separate those two operations.

* If set to **Yes**, users are given the option to reset their password and unlock the account, or to unlock their account without having to reset the password.
* If set to **No**, users are only be able to perform a combined password reset and account unlock operation.

### On-premises Active Directory password filters

SSPR performs the equivalent of an admin-initiated password reset in Active Directory. If you use a third-party password filter to enforce custom password rules, and you require that this password filter is checked during Microsoft Entra self-service password reset, ensure that the third-party password filter solution is configured to apply in the admin password reset scenario. [Microsoft Entra password protection for Active Directory Domain Services](concept-password-ban-bad-on-premises.md) is supported by default.

## Password reset for B2B users

Password reset and change are fully supported on all business-to-business (B2B) configurations. B2B user password reset is supported in the following three cases:

* **Users from a partner organization with an existing Microsoft Entra tenant**: If your partner has a Microsoft Entra tenant, we respect whatever password reset policies are enabled on that tenant. For password reset to work, the partner organization just needs to make sure that Microsoft Entra SSPR is enabled. There's no other charge for Microsoft 365 customers.
* **Users who sign up through self-service sign-up**: If your partner used the [self-service sign-up](~/identity/users/directory-self-service-signup.md) feature to get into a tenant, we let them reset the password with the email they registered.
* **B2B users**: Any new B2B users created by using the new [Microsoft Entra B2B capabilities](~/external-id/what-is-b2b.md) can also reset their passwords with the email they registered during the invite process.

To test this scenario, go to `https://passwordreset.microsoftonline.com` with one of these partner users. If the user defined an alternate email or authentication email, password reset works as expected.

> [!NOTE]
> Microsoft accounts that are granted guest access to your Microsoft Entra tenant, such as those from Hotmail.com, Outlook.com, or other personal email addresses, can't use Microsoft Entra SSPR. For more information, see [When you can't sign in to your Microsoft account](https://support.microsoft.com/help/12429/microsoft-account-sign-in-cant).

## Next steps

To get started with SSPR, complete the following tutorial:

> [!div class="nextstepaction"]
> [Tutorial: Enable self-service password reset (SSPR)](tutorial-enable-sspr.md)
