---
title: Microsoft Entra ID Protection notifications
description: Learn how notifications support your investigation activities.

ms.service: entra-id-protection

ms.topic: how-to
ms.date: 04/15/2024

ms.author: joflore
author: MicrosoftGuyJFlo
manager: amycolannino
ms.reviewer: chuqiaoshi
---
# Microsoft Entra ID Protection notifications

Microsoft Entra ID Protection sends two types of automated notification emails to help you manage user risk and risk detections:

- Users at risk detected email
- Weekly digest email

This article provides you with an overview of both notification emails.

   > [!Note]
   > **We don't support sending emails to users in group-assigned roles.**

> [!IMPORTANT]
> By default users actively assigned Global Administrator, Security Administrator, or Security Reader roles are automatically added to this list if that user has a valid "Email" or "Alternate email" configured. If a user is enrolled in PIM to elevate to one of these roles on demand, then **they will only receive emails if they are elevated at the time the email is sent**.

## Users at risk detected email

In response to a detected account at risk, Microsoft Entra ID Protection generates an email alert with **Users at risk detected** as subject. The email includes a link to the **[Users flagged for risk](./overview-identity-protection.md)** report. As a best practice, you should immediately investigate the users at risk.

The configuration for this alert allows you to specify at what user risk level you want the alert to be generated. The email is generated when the user's risk level reaches what you specified. For example, if you set the policy to alert on medium user risk and your user's risk score moves to medium risk because of a real-time sign-in risk, you receive the users at risk detected email. If the user has subsequent risk detections that cause the user risk level calculation to be the specified risk level (or higher), you receive more user at risk detected emails when the user risk score is recalculated. For example, if a user moves to medium risk on January 1, you'll receive an email notification if your settings are set to alert on medium risk. If that same user has another risk detection on January 5 and the user risk score is recalculated but is still medium, you receive another email notification. 

An extra email notification is sent if the time the change in user risk level is more recent than the last email sent. For example, a user signs in on January 1 at 5 AM and there's no real-time risk (meaning no email would be generated because of that sign-in). 10 minutes later, at 5:10 AM, the same user signs-in again and has high real-time risk, causing the user risk level to move to high and an email to be sent. Then, at 5:15 AM, the offline risk score for the original sign-in at 5 AM changes to high risk because of offline risk processing. Another user flagged for risk e-mail wouldn't be sent, since the time of the first sign-in was before the second sign-in that already triggered an email notification.

To prevent an overload of e-mails, you only receive one email within a 5-second time period. If multiple users move to the specified risk level during the same 5-second time period, we aggregate the data and send one e-mail for all of them.

If your organization enabled self-remediation as described in the article, [User experiences with Microsoft Entra ID Protection](concept-identity-protection-user-experience.md) there's a chance that the user might remediate their risk before you have the opportunity to investigate. You can see risky users and risky sign-ins that were already remediated by adding **Remediated** to the **Risk state** filter in either the **Risky users** or **Risky sign-ins** reports.

### Configure users at risk detected alerts

As an administrator, you can set:

- **The user risk level that triggers the generation of this email** - By default, the risk level is set to "High" risk.
- **The recipients of this email**
   - Optionally you can **Add custom email here** users defined must have the appropriate permissions to view the linked reports.

Configure the users at risk email in the [Microsoft Entra admin center](https://entra.microsoft.com) under **Protection** > **Identity Protection** > **Users at risk detected alerts**.

## Weekly digest email

The weekly digest email contains a summary of new risk detections.  
It includes:

- New risky users detected
- New risky sign-ins detected (in real time)
- Links to the related reports in Identity Protection

![A screenshot showing a sample weekly digest email.](./media/howto-identity-protection-configure-notifications/weekly-digest-email.png)

### Configure weekly digest email

As an administrator, you can switch sending a weekly digest email on or off and choose the users assigned to receive the email.

Configure the weekly digest email in the [Microsoft Entra admin center](https://entra.microsoft.com) > **Protection** > **Identity Protection** > **Weekly digest**.

## See also

- [Microsoft Entra ID Protection](./overview-identity-protection.md)
