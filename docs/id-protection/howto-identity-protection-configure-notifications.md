---
title: Configure Microsoft Entra ID Protection notifications
description: Learn how to configure Microsoft Entra ID Protection notifications, including users at risk alerts and weekly digest emails, to support your investigation activities.
ms.topic: how-to
ms.date: 05/27/2026
ms.reviewer: chuqiaoshi
ai-usage: ai-assisted
ms.custom: sfi-ga-nochange, msecd-doc-authoring-101
#customer intent: As a security administrator, I want to configure ID Protection notification emails so that I'm alerted when users are at risk.
---
# Configure Microsoft Entra ID Protection notifications

Microsoft Entra ID Protection sends two types of automated notification emails to help you manage user risk and risk detections:

- Users at risk detected
- Weekly digest

## Prerequisites

- The Microsoft Entra ID P2 or Microsoft Entra Suite license is required for full access to Microsoft Entra ID Protection features, including modifying the MFA registration policy.
    - For a detailed list of capabilities for each license tier, see [What is Microsoft Entra ID Protection](overview-identity-protection.md).
- The [Security Administrator](../identity/role-based-access-control/permissions-reference.md#security-administrator) role is the least privileged role required to **configure alerts**.

## Who receives notification emails

By default, users actively assigned the Global Administrator, Security Administrator, or Security Reader roles are automatically added to the notification recipient list. These users must have a valid **Email** or **Alternate email** configured.

If a user is enrolled in Privileged Identity Management (PIM) to elevate to one of these roles on demand, they only receive emails if they're elevated at the time the email is sent.

> [!NOTE]
> Sending emails to users in group-assigned roles is not supported.

## Users at risk detected email

In response to a detected account at risk, Microsoft Entra ID Protection generates an email alert with **Users at risk detected** as the subject. The email includes a link to the **[Users flagged for risk](./overview-identity-protection.md)** report. As a best practice, immediately investigate to protect affected accounts.

The configuration for this alert allows you to specify at what user risk level you want the alert to be generated. The email is generated when the user's risk level reaches what you specified. 

### Example scenario

You set the policy to alert on medium user risk. Your user's risk score moves to medium risk because of a real-time sign-in risk, you receive the users at risk detected email.

If the user has subsequent risk detections that cause the user risk level calculation to be the specified risk level (or higher), you receive more user at risk detected emails when the user risk score is recalculated. For example, if a user moves to medium risk on January 1, you receive an email notification if your settings are set to alert on medium risk. If that same user has another risk detection on January 5 and the user risk score is recalculated but is still medium, you receive another email notification.

### Email notification timing considerations

An extra email notification is only sent if the change in user risk level is more recent than the last email sent. For example, a user signs in on January 1 at 5 AM and there's no real-time risk (meaning no email is generated because of that sign-in). Ten minutes later, at 5:10 AM, the same user signs in again and has high real-time risk, causing the user risk level to move to high and triggering an email. Then, at 5:15 AM, the offline risk score for the original sign-in at 5 AM changes to high risk because of offline risk processing. Another user flagged for risk email isn't sent, because the time of the first sign-in was before the second sign-in that already triggered an email notification.

To prevent an overload of emails, you only receive one email within a 5-second time period. If multiple users move to the specified risk level during the same 5-second time period, the data is aggregated and sent in one email for all of them.

### User risk and remediation

If your organization enabled self-remediation as described in the article, [User experiences with Microsoft Entra ID Protection](concept-identity-protection-user-experience.md) there's a chance that the user might remediate their risk before you have the opportunity to investigate. You can see risky users and risky sign-ins that were already remediated by adding **Remediated** to the **Risk state** filter in either the **Risky users** or **Risky sign-ins** reports.

If you receive notifications for risky sign-ins but don't see any results in the Microsoft Entra admin center, the sign-ins might have been automatically remediated.
To view these events, go to **ID Protection** > **Risky sign-ins** and set the **Risk state** filter to include **Remediated**.
The notification emails include detections at the time they occur, even if the risk is later resolved automatically. As a result, remediated sign-ins may not appear in reports unless explicitly filtered.

### Configure users at risk detected alerts

To configure the user risk level and recipients for these alerts, follow these steps.

As an administrator, you can set:

- **The user risk level that triggers the generation of this email** - By default, the risk level is set to "High" risk.
- **The recipients of this email**
   - Optionally you can **Add custom email here** users defined must have the appropriate permissions to view the linked reports.

Configure the users at risk email in the [Microsoft Entra admin center](https://entra.microsoft.com) under **ID Protection** > **Dashboard** > **Users at risk detected alerts**.

## Weekly digest email

The weekly digest email contains a summary of new risk detections.  
It includes:

- New risky users detected
- New risky sign-ins detected (in real time)
- Links to the related reports in ID Protection

:::image type="content" source="./media/howto-identity-protection-configure-notifications/weekly-digest-email.png" alt-text="Screenshot of a sample weekly digest email from Microsoft Entra ID Protection showing new risky users and risky sign-ins summary.":::

### Configure weekly digest email

As an administrator, you can switch sending a weekly digest email on or off and choose the users assigned to receive the email.

Configure the weekly digest email in the [Microsoft Entra admin center](https://entra.microsoft.com) > **ID Protection** > **Dashboard** > **Weekly digest**.

## Related content

- [Microsoft Entra ID Protection](./overview-identity-protection.md)
