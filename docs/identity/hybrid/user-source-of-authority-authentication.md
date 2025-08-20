---
title: Supported Device Authentication for Users Converted Using Source of Authority (SOA) 
description: This article lists authentication methods  for users using Microsoft Entra joined-devices, and information on if it supports users converted using Source of Authority.
author: owinfreyATL
ms.author: owinfrey
ms.service: entra-id
ms.subservice: hybrid
ms.topic: concept-article #Required; leave this attribute/value as-is.
ms.date: 08/19/2025
ms.reviewer: dhanyak

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

# Device Authentication for Users Converted Using Source of Authority (SOA) 

Device authentication is a critical component for organizations managing hybrid or cloud environments. This article provides an overview of supported authentication methods for users converted using Source of Authority (SOA) in Microsoft Entra joined and hybrid joined devices. It outlines the compatibility of password-based and passwordless sign-in methods, such as Windows Hello for Business and FIDO2 keys, across various trust configurations. If you have requirements to access on-premises resources tied to Active Directory, we recommend that you switch to cloud authentication first (PTA, PHS, native cloud authentication like certificates, passkeys, or password hashes) or go passwordless. 

## Hybrid Joined Devices

The following sections contain information that shows the currently supported authentication methods for SOA converted users for Users using [Hybrid Joined Devices](/identity/devices/concept-hybrid-join).

### Hybrid Joined Password based sign-in

Using Hybrid Joined Devices, no password-based sign-ins are supported for converted SOA users.

### Hybrid Joined Windows Hello for Business and FIDO2 Sign-in

Support for passwordless authentication methods like Windows Hello for Business, or FIDO2 keys, using Hybrid Joined Devices are as follows:

#### Hybrid Joined Certificate or Key Trust

Not Supported.

#### Hybrid Joined Cloud Trust or no Trust Type

##### Hybrid Joined Legacy Kerberos

- **Apps with App Proxy**: Not Supported.
- **Apps with Entra Private Access**: Not Supported.

##### Hybrid Joined Microsoft Entra Kerberos

- **Azure Files**: Supported
- **On-premises SSO**: Supported as long as authentication user attributes are synced between Microsoft Entra ID and Active Directory
- **Apps with App Proxy**: Not Supported.
- **Apps with Entra Private Access**: Not Supported.

## Microsoft Entra Joined Devices

The following sections contain information that shows the currently supported authentication methods for SOA converted users for Users using [Microsoft Entra Joined Devices](/identity/devices/concept-directory-join).

### Microsoft Entra Joined Devices Password based sign-in

Using Microsoft Entra Joined Devices, no password-based sign-ins are supported for converted SOA users.

### Microsoft Entra Joined Devices Windows Hello for Business and FIDO2 Sign-in

Support for passwordless authentication methods like Windows Hello for Business, or FIDO2 keys, using Microsoft Entra Joined Devices are as follows:

#### Microsoft Entra Joined Devices Certificate or Key Trust

Not Supported.

#### Microsoft Entra Joined Devices Cloud Trust or no Trust Type

##### Microsoft Entra Joined Devices Legacy Kerberos

- **Apps with App Proxy**: Supported as long as authentication user attributes are synced between Microsoft Entra ID and Active Directory
- **Apps with Entra Private Access**: Supported as long as authentication user attributes are synced between Microsoft Entra ID and Active Directory

##### Microsoft Entra Joined Devices Microsoft Entra Kerberos

- **Azure Files**: Supported
- **On-premises SSO**: Supported as long as authentication user attributes are synced between Microsoft Entra ID and Active Directory
- **Apps with App Proxy**: Not Supported.
- **Apps with Entra Private Access**: Not Supported.


## Related content
TODO: Add your next step link(s)
- [Write concepts](article-concept.md)

<!--
Remove all the comments in this template before you sign-off or merge to the 
main branch.

-->
