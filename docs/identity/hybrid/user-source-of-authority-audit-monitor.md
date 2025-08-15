---
title: How to audit and monitor User Source of Authority (SOA) in Microsoft Entra ID (Preview)
description: Learn how to audit and monitor User Source of Authority (SOA) in Microsoft Entra ID.
author: #Required; your GitHub user alias, with correct capitalization
ms.author: #Required; microsoft alias of author
ms.service: #Required; use the name-string related to slug in ms.product/ms.service
ms.topic: concept-article #Required; leave this attribute/value as-is.
ms.date: #Required; mm/dd/yyyy format.

#CustomerIntent: As a <type of user>, I want <what?> so that <why?>.
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

# How to audit and monitor User Source of Authority (SOA) in Microsoft Entra ID (Preview)

Admins can use **Audit Logs** in the Azure portal or the onPremisesSyncBehavior Microsoft Graph API to monitor and report SOA changes in their environment. They can also integrate SOA changes with third-party monitoring systems. For more information, see [onPremisesSyncBehavior](/graph/api/resources/onpremisessyncbehavior).

<!-- 3. Prerequisites --------------------------------------------------------------------

Optional: Make **Prerequisites** your first H2 in the article. Use clear and unambiguous
language and use a unordered list format. 

-->

## How to use Audit Logs to see SOA changes  

You can access Audit Logs in the Azure portal. They retain a record of SOA changes for the last 30 days. 

1. Sign in to the [Azure portal](https://portal.azure.com) as at least a [Reports Reader](/entra/identity/role-based-access-control/permissions-reference#reports-reader). 

1. Select **Manage Microsoft Entra ID** > **Monitoring** > **Audit logs** or search for **audit logs** in the search bar.

1. Select activity as **Change Source of Authority from AD DS to cloud**.

   :::image type="content" source="media/how-to-source-of-authority-auditing-monitoring/audit-logs.png" alt-text="Screenshot of the Azure portal showing the Change Source of Authority from AD DS to cloud activity selection.":::

<!-- 4. H2s (Article body)
--------------------------------------------------------------------

Required: In a series of H2 sections, the article body should discuss the ideas that explain how "X is a (type of) Y that does Z":

* Give each H2 a heading that sets expectations for the content that follows.
* Follow the H2 headings with a sentence about how the section contributes to the whole.
* Describe the concept's critical features in the context of defining what it is.
* Provide an example of how it's used where, how it fits into the context, or what it does. If it's complex and new to the user, show at least two examples.
* Provide a non-example if contrasting it will make it clearer to the user what the concept is.
* Images, code blocks, or other graphical elements come after the text block it illustrates.
* Don't number H2s.

-->

## How to use Microsoft Graph API to create reports for SOA 

You can use Microsoft Graph to report data such as:

- Report how many objects are SOA converted
- Filter data for converted users
- Identify objects that were SOA converted and rolled back

### Filter and count converted objects

The [onPremisesSyncBehavior API](/graph/api/resources/onpremisessyncbehavior) helps you view the *isCloudManaged* property for an user. You can set the *isCloudManaged* property to `true` to convert the user SOA. 

You can also call the onPremisesSyncBehavior API to query how many users converted their SOA to cloud-managed:

```https
GET users/{ID}/onPremisesSyncBehavior?$select=id,isCloudManaged
```

You can use $search and $count to view all user objects with converted SOA. Before you can use $filter or $count, you need to set consistencyLevel = eventual in **Request headers** in Microsoft Graph Explorer:

```https
GET users?$filter=onPremisesSyncBehavior/isCloudManaged eq true&$select=id,displayName,isCloudManaged&$count=true
```

<!---NL2MSGraph is a new platform that allows customers to use Security Co-Pilot to get answers using MSGraph calls. We can simplify customer experience by adding this filter at "all users" level
Given SOA feature has no UX, this enables the ability to view bulk SOA changes after it's made.--->

## How to use Azure Monitor to create workbooks and reports using Log Analytics 

You can integrate Audit Logs with Azure Monitoring and search the following events to get SOA operations:

- Event ID 6956 is logged if an object isn't synced to the cloud because the SOA of the object is cloud-managed.

- When SOA transfer is rolled back to on-premises, user provisioning to AD DS stops syncing changes without deleting the AD DS user. The AD DS user is also removed from the configuration scope. The AD DS user remains intact, and AD DS resumes control in the next sync cycle. You can verify in the **Audit Logs** that sync doesn't happen for this object because it's managed on-premises. 

For more information about how to create custom queries, see [Understand how provisioning integrates with Azure Monitor logs](/entra/identity/app-provisioning/application-provisioning-log-analytics).

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
