---
# required metadata

title: Investigate identity risk in Microsoft Copilot for Security
description: Use Microsoft Copilot for Security and Microsoft Entra skills to quickly investigate identity-based security incident.
keywords:
author: rwike77
ms.author: ryanwi
manager: celestedg
ms.date: 08/08/2024
ms.topic: conceptual
ms.service: entra
ms.custom: microsoft-copilot
ms.collection: ce-skilling-ai-copilot

# Customer intent: As a SOC analyst or IT admin, I want to learn how to use the Microsoft Entra skills in Microsoft Copilot for Security so that I can quickly respond to a potential identity-based security incident.
---

# Investigate security incidents using Microsoft Copilot for Security

[Microsoft Copilot for Security](/security-copilot/microsoft-security-copilot) gets insights from your Microsoft Entra data through many different skills, such as Get Entra Risky Users and Get Audit Logs. IT admins and security operations center (SOC) analysts can use these skills and others to gain the right context to help investigate and remediate identity-based incidents using natural language prompts. 

This article describes how a SOC analyst or IT admin could use the Microsoft Entra skills to investigate a potential security incident. 

## Scenario

Natasha, a security operations center (SOC) analyst at Woodgrove Bank, receives an alert about a potential identity-based security incident. The alert indicates suspicious activity from a user account that has been flagged as a risky user.

## Investigate

Natasha starts her investigation and signs in to [Microsoft Copilot for Security](https://securitycopilot.microsoft.com/).  In order to view user, group, risky user, sign-in logs, audit-logs, and diagnostic logs details, she signs in as at least a [Security Reader](/entra/identity/role-based-access-control/permissions-reference#security-reader).

### Get user details

Natasha starts by looking up details of the flagged user: karita@woodgrovebank.com.  She reviews the user’s profile information such as job title, department, manager, and contact information. She also checks the user’s assigned roles, applications, and licenses to understand what applications and services the user has access to.

She uses the following prompts to get the information she needs:

- *Give me all user details for karita@woodgrovebank.com and extract the user Object ID.*
- *Is this user's account enabled?*
- *When was the password last changed or reset for karita@woodgrovebank.com?*
- *Does karita@woodgrovebank.com have any registered devices in Microsoft Entra?*
- *What are the authentication methods that are registered for karita@woodgrovebank.com if any?*

### Get risky user details 

To understand why karita@woodgrovebank.com was flagged as a risky user, Natasha starts looking at the risky user details.  She reviews the risk level of the user (low, medium, high, or hidden), the risk detail (for example, sign-in from unfamiliar location), and the risk history (changes in risk level over time). She also checks the risk detections and the recent risky sign-ins, looking for suspicious sign-in activity or impossible travel activity.  

She uses the following prompts to get the information she needs:

- *What is the risk level, state, and risk details for karita@woodgrovebank.com?*
- *What is the risk history for karita@woodgrovebank.com?*
- *List the recent risky sign-ins for karita@woodgrovebank.com.* 
- *List the risk detections details for karita@woodgrovebank.com.*

### Get sign-in logs details

Natasha then reviews the sign-in logs for the user and the sign-in status (success or failure), location (city, state, country), IP address, device information (device ID, operating system, browser), and sign-in risk level. She also checks the correlation ID for each sign-in event, which can be used for further investigation.

She uses the following prompts to get the information she needs:

- *Can you give me sign-in logs for karita@woodgrovebank.com for the past 48 hours? Put this information in a table format.*
- *Show me failed sign-ins for karita@woodgrovebank.com for the past 7 days and tell me what the IP addresses are.*

### Get audit logs details

Natasha checks the audit logs, looking for any unusual or unauthorized actions performed by the user. She checks the date and time of each action, the status (success or failure), the target object (for example, file, user, group), and the client IP address. She also checks the correlation ID for each action, which can be used for further investigation.

She uses the following prompts to get the information she needs:

- *Get Microsoft Entra audit logs for karita@woodgrovebank.com for the past 72 hours. Put information in table format.*
- *Show me audit logs for this event type.*

### Get group details

Natasha then reviews the groups that karita@woodgrovebank.com is a part of to see if Karita is a member of any unusual or sensitive groups. She reviews the group memberships and permissions associated with Karita's user ID. She checks the group type (security, distribution, or Office 365), membership type (assigned or dynamic), and the group’s owners in the group details. She also reviews the group’s roles to determine what permissions it has for managing resources.

She uses the following prompts to get the information she needs:

- *Get the Microsoft Entra user groups that karita@woodgrovebank.com is a member of. Put information in table format.*
- *Tell me more about the Finance Department group.*
- *Who are the owners of the Finance Department group?*
- *What roles does this group have?*

### Get diagnostic logs details

Finally, Natasha reviews the diagnostic logs to get more detailed information about the system’s operations during the times of the suspicious activities. He filters the logs by John’s user ID and the times of the unusual sign-ins.

She uses the following prompts to get the information she needs:

- *What are the diagnostics log configuration for the tenant that is karita@woodgrovebank.com registered in?*
- *Which logs are being collected in this tenant?*

## Remediate

By using Copilot for Security, Natasha is able to gather comprehensive information about the user, sign-in activities, audit logs, risky user detections, group memberships, and system diagnostics. After completing her investigation, Natasha needs to take action to remediate the risky user or unblock them.

She reads about [risk remediation](/entra/id-protection/howto-identity-protection-remediate-unblock#risk-remediation), [unblocking users](/entra/id-protection/howto-identity-protection-remediate-unblock#unblocking-users), and [response playbooks](/security/operations/incident-response-playbooks) to determine possible actions to take next.

## Next steps

Learn more about: 
- [Risky users](/entra/id-protection/howto-identity-protection-investigate-risk#risky-users)
- [What is risk in ID Protection?](/entra/id-protection/concept-identity-protection-risks)
- [Risk-based Access Policies](/entra/id-protection/concept-identity-protection-policies)

