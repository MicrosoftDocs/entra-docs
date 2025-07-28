---
title: Disable sign-up in a sign-up and sign-in user flow
description: Disable sign-up in your user flow with Microsoft Graph API. Prevent new registrations and allow only sign-in for your external users. 
ms.author: kengaderdus
author: kengaderdus
manager: dougeby
ms.service: entra-external-id
ms.subservice: external
ms.topic: how-to
ms.date: 06/30/2025
ms.custom: it-pro, seo-july-2024, sfi-image-nochange
#Customer intent: As a developer or IT admin, I want to disable sign-up in a user flow so that only existing external users can sign in. 
---

# Disable sign-up in a sign-up and sign-in user flow

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

To restrict access so that only existing external users can sign in, you can disable the sign-up option in your sign-up and sign-in user flow. This article shows you how to use the Microsoft Graph API to update your user flow settings, preventing new registrations while allowing sign-in for current users.

You use the [Update authenticationEventsFlow API in Microsoft Graph](/graph/api/authenticationeventsflow-update) to update the **onInteractiveAuthFlowStart** property > **isSignUpAllowed** property to `false`. 

## Prerequisites

- **A sign-up and sign-in user flow**: Before you begin, [create the user flow](how-to-user-flow-sign-up-sign-in-customers.md) that you want to associate with your application.
- **Application registration**: In your external tenant, [register your application](/entra/identity-platform/quickstart-register-app).

## Disable sign-up flow

To disable sign-up flow, you need to know the ID of the user flow whose sign-up you want to disable. You can't read the user flow ID from the Microsoft Entra admin center, but you can retrieve it via Microsoft Graph API if you know the app associated with it.

Follow these steps to disable the sign-up flow:

1. Read the application ID associated with the user flow:
    1. Browse to **Entra ID** > **External Identities** > **User flows**.
    1. From the list, select your user flow.
    1. In the left menu, under **Use**, select **Applications**.
    1. From the list, under **Application (client) ID** column, copy the Application (client) ID.

1. Identify the ID of the user flow whose sign-up you want to disable. To do so, [List the user flow associated with the specific application](/graph/api/identitycontainer-list-authenticationeventsflows#example-4-list-user-flow-associated-with-specific-application-id). This Microsoft Graph API endpoint requires you to know the application ID you obtained from the previous step. 

1. [Update your user flow](/graph/api/authenticationeventsflow-update) to disable sign-up. 

    **Example**:

   ```http
   PATCH https://graph.microsoft.com/beta/identity/authenticationEventsFlows/{user-flow-id} 
   ```   

    **Request body**

    ```json
        {    
            "@odata.type": "#microsoft.graph.externalUsersSelfServiceSignUpEventsFlow",    
            "onInteractiveAuthFlowStart": {    
                "@odata.type": "#microsoft.graph.onInteractiveAuthFlowStartExternalUsersSelfServiceSignUp",    
                "isSignUpAllowed": false    
          }    
        }
    ```

    Replace `{user-flow-id}` with the user flow ID that you obtained in the previous step. Notice the `isSignUpAllowed` parameter is set to *false*. To re-enable sign-up, make a call to the Microsoft Graph API endpoint, but set the `isSignUpAllowed` parameter to *true*.   

## Next steps

- [Add your application to the user flow](how-to-user-flow-add-application.md)
- [Create custom user attributes and customize the order of the attributes on the sign-up page](how-to-define-custom-attributes.md).


## Related content

- [Test your user flow](./how-to-test-user-flows.md).