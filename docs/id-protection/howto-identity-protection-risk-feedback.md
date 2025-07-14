---
title: Provide risk feedback in Microsoft Entra ID Protection
description: How and why should you provide feedback on ID Protection risk detections.

ms.service: entra-id-protection

ms.topic: how-to
ms.date: 05/27/2025

author: shlipsey3
ms.author: sarahlipsey
manager: femila
ms.reviewer: cokoopma
---
# How To: Give risk feedback in Microsoft Entra ID Protection

Microsoft Entra ID Protection allows you to give feedback on its risk assessment.

Your feedback helps us optimize detections in the future, improve their accuracy, and reduce false positives.

## What is a detection?

An ID Protection detection is an indicator of suspicious activity related to identity risk. These suspicious activities are called risk detections. These identity-based detections can be based on heuristics, machine learning or can come from partner products. These detections are used to determine sign-in risk and user risk:

* User risk represents the probability an identity is compromised.
* Sign-in risk represents the probability a sign-in is compromised (for example, the identity owner didn't authorize the sign-in).

## Why should I give risk feedback to risk assessments? 

There are several reasons why you should give risk feedback:

- **You found a Microsoft Entra ID Protection user or sign-in risk assessment incorrect**.
    - For example, a sign-in shown in **Risky sign-ins** report was benign and all the detections on that sign-in were false positives.
- **You validated that Microsoft Entra ID Protection user or sign-in risk assessment was correct**.
    - For example, a sign-in shown in **Risky sign-ins** report was indeed malicious and you want Microsoft Entra ID to know that all the detections on that sign-in were true positives.
- **You remediated the risk on that user outside of Microsoft Entra ID Protection** and you want the user's risk level to be updated.

## How does Microsoft use my risk feedback?

Microsoft uses your feedback to update the risk of the underlying user and/or sign-in and the accuracy of these events. This feedback helps secure the end user. For example, once you confirm a sign-in is compromised, we immediately increase the user's risk and sign-in's aggregate risk (not real-time risk) to high. If this user is included in your user risk policy to force high risk users to securely reset their passwords, they're able to automatically remediate the next time they sign-in.

[!INCLUDE [id-protection-admin-action-sign-in](../includes/id-protection-admin-action-sign-in.md)]

[!INCLUDE [id-protection-admin-action-user](../includes/id-protection-admin-action-user.md)]

Feedback on risk detections in ID Protection is processed offline and might take some time to update. The **risk processing state** column provides the current state of feedback processing.

## Related content

- [Microsoft Entra ID Protection risk detections reference](./concept-identity-protection-risks.md)
- [Identify risky workload identities](concept-workload-identity-risk.md#identify-risky-workload-identities)