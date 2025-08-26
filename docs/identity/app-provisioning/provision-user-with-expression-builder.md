---
title: Provision a User with Expression Builder
description: Learn how to simplify user provisioning with Expression Builder, handle duplicate users, and transform user attributes for seamless integration. 
author: jenniferf-skc
manager: pmwongera
ms.author: jfields
ms.service: entra-id
ms.subservice: app-provisioning
ms.topic: reference
ms.date: 03/04/2025
---

# Provision a User with Expression Builder

User provisioning can sometimes be challenging such as when there are duplicate users present in enterprise applications that use Microsoft Entra ID. The Expression Builder tool simplifies this process, offering the flexibility to transform and map user attributes. 

By default, user provisioning happens based on the UPN. However, there might be instances where customers are using legacy methods, and UPNs can be in formats like a.b@onmicrosoft.com and a_b@onmicrosoft.com. 

When we have this situation, there might be user provisioning failures at the application side. For example, some applications like GitHub Copilot (GHCP) provision users in the format a-b-test, where **"a"** is the first name in the UPN, **"b"** is the second name, and **test** is the GHCP instance name. 

Now, if we have users a.b@onmicrosoft.com and a_b@onmicrosoft.com, GHCP provisions one user, and the other user fails due to duplication. 

Expression Builder simplifies user provisioning by enabling attribute transformation and mapping based on organizational needs. While it offers flexibility and precision, proper testing and validation are crucial for successful implementation in production environments.

## Example scenarios

What follows are scenarios and sample expressions for handling unique attribute mapping and user provisioning challenges.

### Scenario 1: Ensure unique usernames without duplication

When unique attributes like **Employee ID** are unavailable or restricted due to security, **Object ID** can serve as a reliable option. **Object IDs** are globally unique for each user, ensuring no duplication. 

> [!NOTE]
> Each application has character limits for user provisioning. For example, GitHub's character limit is 39. 

**Expression:** 

Append(Mid([displayName], 1, 15), Mid([objectId], 1, 8)) 

**Explanation:** 

- Takes the first 15 characters of the user's display name. 
- Appends the first eight characters of the user's **Object ID**. 
- Creates a unique identifier by combining the two. 

**Advantages:** 

- Uniqueness ensured through **Object ID**. 
- Mitigates risk of duplication. 

### Scenario 2: Modify the user principal name (UPN) for compatibility 

In some systems, UPNs need modifications for proper integration. For instance, appending parts of Object ID ensures uniqueness. 

**Expression:** 

Append(Mid([objectId], 1, 2), Mid([userPrincipalName], 1, 50)) 

**Explanation:** 

- Extracts the first 2 characters from the **Object ID**. 

- Appends these characters to the existing UPN (which is limited to the first 50 characters. While most users typically don't have a UPN that reaches this limit, the intent is to append 2 characters from the **Object ID** to the full UPN for uniqueness). 

### Scenario 3: Conditional modifications for specific users 
To apply custom changes for a subset of users, conditional logic with IIF statements can be employed. 

**Expression:**

IIF([userPrincipalName] = "Aman.Gupta@xpl57.onmicrosoft.com", Append(Mid([objectId], 1, 2), [userPrincipalName]), IIF( [userPrincipalName] = "Aarti@xpl57.onmicrosoft.com", Append(Mid([objectId], 1, 2), [userPrincipalName]), IIF([userPrincipalName] = "AdeleV@xpl57.onmicrosoft.com", Append(Mid([objectId], 1, 2), [userPrincipalName]), [userPrincipalName] ) ) )

The expression checks for specific users based on UPN and applies a custom modification by appending the first two characters from the **Object ID** to the userPrincipalName for Aman.Gupta@xpl57.onmicrosoft.com, Aarti@xpl57.onmicrosoft.com, and AdeleV@xpl57.onmicrosoft.com. 

**Example test case:** 

- Input UPN: Aman.Gupta@xpl57.onmicrosoft.com 

- Expected Output: 39Aman.Gupta@xpl57.onmicrosoft.com

**A more advanced example is as follows:**

IIF([userPrincipalName] = "Aman.Gupta@xpl57.onmicrosoft.com", Append([displayName], Append("", Mid([objectId], 1, 8))), IIF([userPrincipalName] = "harjit@xpl57.onmicrosoft.com", Append([displayName], Append("", Mid([objectId], 1, 8))), IIF( [userPrincipalName] = "AdeleV@xpl57.onmicrosoft.com", Append([displayName], Append("_", Mid([objectId], 1, 8))), [userPrincipalName] ) ) )

**Expression for testing:** 

Append(Mid([objectId], 1, 8), [userPrincipalName]) 

The process checks for specific users based on UPN and applies a custom modification by appending the first eight characters of their **Object IDs** to the display name. The more users included, the longer the expression becomes, which increases complexity. Therefore, this method is best suited for small subsets of users.  

## Key recommendations 

- **Test Extensively:** Always test expressions in a non-production environment to verify functionality. 
- **Character Limitations:** Ensure the transformed username doesn’t exceed character limits specified by the application (for example, GitHub has a 39-character limit). 
- **Documentation:** Maintain clear documentation of expressions and changes for troubleshooting and future reference. 

## Tools and steps for testing 

1. Open the Expression Builder in Entra ID or the relevant provisioning interface. 
1. Use the Test Expression feature with sample user data. 
1. Validate outputs to ensure proper transformation. 

## Next steps 

[Find out when a specific user is able to access an app in Microsoft Entra Application Provisioning](/entra/identity/app-provisioning/application-provisioning-when-will-provisioning-finish-specific-user)






