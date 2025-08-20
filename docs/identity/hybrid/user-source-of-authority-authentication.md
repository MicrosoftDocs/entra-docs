---
title: #Required; Keep the title body to 60-65 chars max including spaces and brand
description: #Required; Keep the description within 100- and 165-characters including spaces 
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

# Supported Device Authentication Methods with User Source of Authority (SOA)

If you have requirements to access on-premises resources tied to Active Directory, we recommend that you switch to cloud authentication first (PTA, PHS, native cloud authentication like certificates, passkeys, password hashes etc) or go passwordless. This article lists what authentication methods are supported with SOA converted users


[Introductory paragraph]
TODO: Add your introductory paragraph

<!-- 3. Prerequisites --------------------------------------------------------------------

Optional: Make **Prerequisites** your first H2 in the article. Use clear and unambiguous
language and use a unordered list format. 

-->

## Hybrid Joined Devices

The sections contain tables that show the currently supported authentication methods for SOA converted users for Users using [Hybrid Joined Devices](/identity/devices/concept-hybrid-join).

### Password based sign-in

Using Hybrid Joined Devices, no password-based sign-ins are supported for converted SOA users.

### WHFB + Fido2 Sign-in

Support for passwordless authentication methods like Windows Hello for Business, or FIDO2 keys, using Hybrid Joined Devices are as follows:

#### Certificate or Key Trust

Not Supported.

#### Cloud Trust or no Trust Type

##### Legacy Kerberos

- Apps with App Proxy:
- Apps with Entra Private Access:

##### Entra Kerberos

- Azure Files:
- On-premises SSO:
- Apps with App Proxy:
- Apps with Entra Private Access:

## Entra Joined Devices

### Entra Joined Devices Password based sign-in

Using Hybrid Joined Devices, no password-based sign-ins are supported for converted SOA users.

### Entra Joined Devices WHFB + Fido2 Sign-in

Support for passwordless authentication methods like Windows Hello for Business, or FIDO2 keys, using Hybrid Joined Devices are as follows:

#### Entra Joined Devices Certificate or Key Trust

Not Supported.

#### Entra Joined Devices Cloud Trust or no Trust Type

##### Entra Joined Devices Legacy Kerberos

- Apps with App Proxy:
- Apps with Entra Private Access:

##### Entra Joined Devices Entra Kerberos

- Azure Files:
- On-premises SSO:
- Apps with App Proxy:
- Apps with Entra Private Access:

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
