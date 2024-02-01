---
title: Lifecycle Workflow hybrid capabilities
description: Conceptual article discussing Lifecycle Workflow's hybrid compatibility
author: owinfreyATL
ms.author: owinfrey
manager: amycolannino
ms.service: active-directory
ms.subservice: compliance
ms.workload: identity
ms.topic: conceptual 
ms.date: 01/31/2024
ms.custom: template-concept 

#CustomerIntent: As an IT administrator, I want to learn about hybrid support with Lifecycle workflows so that I can manage synced on-premises users using workflows.
---

<!--
Remove all the comments in this template before you sign-off or merge to the  main branch.

This template provides the basic structure of a Concept article pattern. See the [instructions - Concept](../level4/article-concept.md) in the pattern library.

You can provide feedback about this template at: https://aka.ms/patterns-feedback

Concept is an article pattern that defines what something is or explains an abstract idea.

There are several situations that might call for writing a Concept article, including:

* If there's a new idea that's central to a service or product, that idea must be explained so that customers understand the value of the service or product as it relates to their circumstances. A good recent example is the concept of containerization or the concept of scalability.
* If there's optional information or explanations that are common to several Tutorials or How-to guides, this information can be consolidated and single-sourced in a full-bodied Concept article for you to reference.
* If a service or product is extensible, advanced users might modify it to better suit their application. It's better that advanced users fully understand the reasoning behind the design choices and everything else "under the hood" so that their variants are more robust, thereby improving their experience.

-->

<!-- 1. H1
-----------------------------------------------------------------------------

Required. Set expectations for what the content covers, so customers know the content meets their needs. The H1 should NOT begin with a verb.

Reflect the concept that undergirds an action, not the action itself. The H1 must start with:

* "\<noun phrase\> concept(s)", or
* "What is \<noun\>?", or
* "\<noun\> overview"

Concept articles are primarily distinguished by what they aren't:

* They aren't procedural articles. They don't show how to complete a task.
* They don't have specific end states, other than conveying an underlying idea, and don't have concrete, sequential actions for the user to take.

One clear sign of a procedural article would be the use of a numbered list. With rare exception, numbered lists shouldn't appear in Concept articles.

-->

# Lifecycle Workflow hybrid capabilities


<!-- 2. Introductory paragraph
----------------------------------------------------------

Required. Lead with a light intro that describes what the article covers. Answer the fundamental “why would I want to know this?” question. Keep it short.

* Answer the fundamental "Why do I want this knowledge?" question.
* Don't start the article with a bunch of notes or caveats.
* Don’t link away from the article in the introduction.
* For definitive concepts, it's better to lead with a sentence in the form, "X is a (type of) Y that does Z."

-->

Lifecycle Workflows allow you to create workflows that can be triggered for users based on joiner, mover, or leaver scenarios. With hybrid support, you are able to trigger these workflows for users synced from on-premises Active Directory to Microsoft Entra ID. This is accomplished by allowing you to create a task enabling an on-premises user account, so that you are able to run other tasks in a workflow for the user. You are also able to disable, or even delete, a user account when they are no longer active in your organization. This allows you to use workflows to automate tasks across the lifecycle of users in your hybrid environment. Using Lifecycle Workflows with hybrid users requires additional prerequisites. For more information on these prerequisites, see: [Prerequisites](manage-workflow-onprem.md#prerequisites)

<!-- 3. Prerequisites --------------------------------------------------------------------

Optional: Make **Prerequisites** your first H2 in the article. Use clear and unambiguous
language and use a unordered list format. 

-->

## Hybrid specific tasks

With Lifecycle Workflow's hybrid-specific tasks, you are able to set a flag on the following preexisting tasks so that they run for hybrid users. The following tasks are able to have the hybrid flag set for them:

- Delete user account
- Disable user account
- Enable user account

The respective flags can be found on their task screen:

:::image type="content" source="media/lifecycle-workflow-hybrid/delete-onprem-user.png" alt-text="Screenshot of delete user onprem flag in task.":::

## Hybrid Prerequisites

To manage synced on-premises users with Lifecycle Workflows, you must have the following on-premises prerequisites:

1. You must have the [Microsoft Entra provisioning agent](../identity/hybrid/cloud-sync/what-is-provisioning-agent.md) installed in your environment. You can follow the existing installation [prerequisites](../identity/hybrid/cloud-sync/how-to-prerequisites.md) and [steps](../identity/hybrid/cloud-sync/how-to-install.md) in our public documentation. During installation, choose “**HR-driven provisioning / Azure AD Connect Cloud Sync**” as “**extension configuration**”. You aren't required to add any other configuration for the provisioning agent, such as the cloud sync configuration, and you can install the provisioning agent even if you're currently using Microsoft Entra Connect Sync for your user synchronization (side-by-side).

1. Ensure the gMSA used by the provisioning agent has the [appropriate permissions](../identity/hybrid/cloud-sync/how-to-prerequisites.md#custom-gmsa-account) to delete user accounts.

1. Enable the Active Directory recycle bin. For a step-by-step guide on enabling the recycle bin, see: [Active Directory Recycle Bin step-by-step](/windows-server/identity/ad-ds/get-started/adac/introduction-to-active-directory-administrative-center-enhancements--level-100-#active-directory-recycle-bin-step-by-step).

## [Section 1 heading]
TODO: add your content

## [Section 2 heading]
TODO: add your content

## [Section n heading]
TODO: add your content

<!-- 5. Next step/Related content ------------------------------------------------------------------------ 

Optional: You have two options for manually curated links in this pattern: Next step and Related content. You don't have to use either, but don't use both.
  - For Next step, provide one link to the next step in a sequence. Use the blue box format
  - For Related content provide 1-3 links. Include some context so the customer can determine why they would click the link. Add a context sentence for the following links.

-->

## Next step

TODO: Add your next step link(s)

> [!div class="nextstepaction"]
> [Write concepts](article-concept.md)

<!-- OR -->

## Related content

TODO: Add your next step link(s)

- [Write concepts](article-concept.md)

<!--
Remove all the comments in this template before you sign-off or merge to the main branch.
-->


<!-- 6. Next step/Related content ------------------------------------------------------------------------

Optional: You have two options for manually curated links in this pattern: Next step and Related
content. You don't have to use either, but don't use both. For Next step, provide one link to the
next step in a sequence. Use the blue box format For Related content provide 1-3 links. Include some
context so the customer can determine why they would click the link. Add a context sentence for the
following links.

-->

## Next step
TODO: Add your next step link(s)
> [!div class="nextstepaction"]
> [Write concepts](article-concept.md)

<!-- OR -->

## Related content
TODO: Add your next step link(s)
- [Write concepts](article-concept.md)

<!--
Remove all the comments in this template before you sign-off or merge to the 
main branch.

-->
