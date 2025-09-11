---
title: Customize emails sent from workflow tasks
description: Get a step-by-step guide for customizing emails that you send by using tasks within lifecycle workflows.
author: owinfreyATL
ms.author: owinfrey
manager: dougeby
ms.service: entra-id-governance
ms.subservice: lifecycle-workflows
ms.topic: how-to
ms.date: 05/25/2025
ms.custom: template-how-to
---

# Customize emails sent from workflow tasks

Lifecycle workflows provide several tasks that send email notifications. You can customize email notifications to suit the needs of a specific workflow. For a list of these tasks, see [Lifecycle workflow built-in tasks](lifecycle-workflow-tasks.md).

Email tasks allow for the customization of:

- Recipients
- Sender domain
- Organizational branding
- Subject
- Message body
- Email language

When you're customizing the subject or message body, we recommend that you also enable the custom sender domain and organizational branding. Otherwise, your email will contain an additional security disclaimer.

For more information on these customizable parameters, see [Common email task parameters](lifecycle-workflow-tasks.md#common-email-task-parameters).

## Prerequisites

[!INCLUDE [Microsoft Entra ID Governance license](../includes/entra-entra-governance-license.md)]

## Customize email by using the Microsoft Entra admin center


When you're customizing an email sent via lifecycle workflows, you can choose to customize either a new task or an existing task. You do these customizations the same way whether the task is new or existing, but the following steps walk you through updating an existing task. To customize emails sent from tasks within workflows by using the Microsoft Entra admin center:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Lifecycle Workflows Administrator](../identity/role-based-access-control/permissions-reference.md#lifecycle-workflows-administrator).

1. Browse to **ID Governance** > **Lifecycle workflows** > **workflows**.

1. Select the workflow that contains the email tasks you want to customize.

1. On the pane that lists tasks, select the task for which you want to customize the email.

1. On the pane for the specific task under **Basics**, you can  edit the task name or description, along with configuring which recipient or recipients you want to send the email to outside the default audience. You can set the To recipient to the user, their manager, their sponsor, or specific users, and Cc additional users as needed. If the user is the recipient, you can select which of their available email addresses to use from the mail, otherMails, directoryExtensions, or custom security attributes fields.

   :::image type="content" source="media/customize-workflow-email/email-recipient-list-new.png" alt-text="Screenshot of the recipient list for an email customization task.":::
   
    :::image type="content" source="media/customize-workflow-email/email-recipient-address-property.png" alt-text="Screenshot of the recipient list property for an email customization task.":::

   > [!NOTE]
    > CC recipients are only available if the recipient is the user themselves or their manager. If there are multiple CC recipients, they're copied on the single individual email.
1. Select the **Email Customization** tab.

1. Enter a custom subject, a message body, and the email language translation option that will be used to translate the message body of the email. 

   If you stay with the default templates and don't customize the subject and body of the email, the text will be automatically translated into the recipient's preferred language. If you select an email language, the determination based on the recipient's preferred language will be overridden. If you specify a custom subject or body, it won't be translated.

   :::image type="content" source="media/customize-workflow-email/customize-workflow-email-example.png" alt-text="Screenshot of an example of a customized email from a workflow.":::

1. Select **Save** to capture your changes in the customized email.

## Customize email text

Emails sent by workflows can have their text customized to personalize, or stress specific points within, them. Workflow text can currently be customized in the following way:

- Bold: Text within emails can be bolded by placing the desired text within `<b></b>` brackets.
- Italics:Text within emails can be italicized by placing the desired text within `<i></i>` brackets.
- Underlined:Text within emails can be italicized by placing the desired text within `<u></u>` brackets.


### Format attributes within customized emails

To further personalize customized emails, you can take advantage of dynamic attributes. By placing dynamic attributes in specific attributes, you can specifically call out values such as a user's name, their generated Temporary Access Pass, or even their manager's email.

To use dynamic attributes within your customized emails, you must follow formatting rules. The proper format is:

`{{dynamic attribute}}`

The following screenshot is an example of the proper format for dynamic attributes within a customized email:

:::image type="content" source="media/customize-workflow-email/workflow-dynamic-attribute-example.png" alt-text="Screenshot of an example of dynamic attributes within a customized email.":::

When you're typing a dynamic attribute, the email is written the following way:

```html
Welcome to the team, {{userGivenName}}

We're excited to have you join our growing team and look forward to a successful and memorable journey together.

We've already set up a few things to help you get started quickly and make your onboarding process as smooth as possible.

For more information and next steps, please contact your manager, {{managerDisplayName}} 

```

For a full list of dynamic attributes that you can use with customized emails, see [Dynamic attributes within email](lifecycle-workflow-tasks.md#dynamic-attributes-within-email).

## Use custom branding and domain in emails sent via workflows

You can customize emails that you send via lifecycle workflows to have your own company branding and to use your company domain. When you opt in to using custom branding and a custom domain, every email that you send by using lifecycle workflows reflects these settings.

To enable these features, you need the following prerequisites:

- A verified domain. To add a custom domain, see [Managing custom domain names in Microsoft Entra ID](../identity/users/domains-manage.md).
- Custom branding set within Microsoft Entra ID if you want to use your custom branding in emails. To set organizational branding within your Azure tenant, see [Configure your company branding](../fundamentals/how-to-customize-branding.md).

> [!NOTE]
> For compliance with the [RFC for sending and receiving email](https://www.ietf.org/rfc/rfc2142.txt), we recommend using a domain that has the appropriate DNS records to facilitate email validation, like SPF, DKIM, DMARC, and MX. [Learn more about Exchange Online email routing](/exchange/mail-flow-best-practices/mail-flow-best-practices).

After you meet the prerequisites, follow these steps:

1. On the page for lifecycle workflows, select **Workflow settings**.

1. On the **Workflow settings** pane, for **Email domain**, select your domain from the drop-down list of verified domains.
  
   :::image type="content" source="media/customize-workflow-email/workflow-email-settings.png" alt-text="Screenshot of workflow domain settings.":::
1. Turn on the **Use company branding banner logo** toggle if you want to use company branding in emails.

   :::image type="content" source="media/customize-workflow-email/customize-email-logo-setting.png" alt-text="Screenshot of the email logo setting.":::

## Customize email by using Microsoft Graph

To customize email by using the Microsoft Graph API, see [workflow: createNewVersion](/graph/api/identitygovernance-workflow-createnewversion).

## Set custom branding and domain workflow settings by using Microsoft Graph

To turn on custom branding and domain feature settings in lifecycle workflows by using the Microsoft Graph API, see [`lifecycleManagementSettings` resource type](/graph/api/resources/identitygovernance-lifecyclemanagementsettings).

## Next steps

- [Lifecycle workflow tasks](lifecycle-workflow-tasks.md)
- [Manage workflow versions](manage-workflow-tasks.md)
