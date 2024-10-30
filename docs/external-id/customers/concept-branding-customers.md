---
title: Customize the company branding
description: Learn how to customize the sign-in and sign-up experiences for your customers.
 
author: csmulligan
manager: celestedg
ms.service: entra-external-id
 
ms.subservice: external
ms.topic: concept-article
ms.date:  04/10/2024
ms.author: cmulligan
ms.custom: it-pro

#Customer intent: As an it admin, I want to know how can I customize my customers' sign-in experiences, including company branding and languages customizations.
---

# Customize the look and feel of the authentication experience for the external tenant

After creating a new external tenant, you can customize the appearance of your web-based applications for customers who sign in, sign up, or sign out to personalize their end-user experience. The external tenant comes with a default neutral branding that doesn’t include any existing Microsoft branding. However, this neutral default branding can be customized to meet your company’s specific needs. You have the flexibility to add a custom background image or color, favicon, layout, header, and footer to your authentication experience. You can add each custom branding property individually to the custom sign-in page, or you can upload a custom CSS. For more information, see [Customize the neutral branding in your external tenant](how-to-customize-branding-customers.md).

If the custom company branding fails to load, the sign-in page reverts to the neutral branding. 

The following list and image outline the elements of the neutral branding sign-in experience:

1. Background image and color.
1. Favicon.
1. Banner logo.
1. Footer as a page layout element.
1. Footer hyperlinks, for example,  Privacy & cookies, Terms of use and troubleshooting details also known as ellipsis in the right bottom corner of the screen.

   :::image type="content" source="media/how-to-customize-branding-customers/ciam-neutral-branding.png" alt-text="Screenshot of the neutral branding." lightbox="media/how-to-customize-branding-customers/ciam-neutral-branding.png":::

As a comparison, here’s how the [default Microsoft sign-in experience](~/fundamentals/how-to-customize-branding.md) in a Microsoft Entra ID tenant looks:

   :::image type="content" source="media/how-to-customize-branding-customers/microsoft-branding.png" alt-text="Screenshot of the Microsoft Entra ID default Microsoft branding." lightbox="media/how-to-customize-branding-customers/microsoft-branding.png":::



## Text customization

You might have different requirements for the information you want to collect during sign-up and sign-in. The external tenant comes with a built-in set of information stored in attributes, such as Given Name, Surname, City, and Postal Code. In the external tenant, we have two options to add custom text to the sign-up and sign-in experience. The function is available under each user flow during language customization and also under **Company Branding**. Although we have two ways to customize strings, both ways modify the same JSON file. The most recent change made either via **User flows** or via **Company Branding** will always override the previous one.

## Language customization

You can create a personalized sign-in experience for users who sign in using a specific browser language by customizing the branding elements. If you don't make any changes to the elements, the default elements will be displayed.
In the tenant you can add a custom language to the sign-in experience under **Company Branding** or to a specific user flow under **User flows**. The language customization is available for a list of languages. For more information, see [Customize the language of the authentication experience](how-to-customize-languages-customers.md).

## Microsoft Graph APIs

You can also manage company branding and configure all assets programmatically. 
- For the default branding, use the [organizationalBranding resource type](/graph/api/resources/organizationalbranding) and its associated methods.
- To customize branding based on locale, using the [organizationalBrandingLocalization resource type](/graph/api/resources/organizationalbrandinglocalization) resource type and its associated methods.

## Next steps
- [Customize the user experience for your customers](how-to-customize-branding-customers.md)
- [Customize the language of the authentication experience](how-to-customize-languages-customers.md)
