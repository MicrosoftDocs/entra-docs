---
author: joflore
ms.service: entra-id-protection

ms.topic: include
ms.date: 08/20/2024
ms.author: joflore
---

Taking action on the user level applies to all the detections currently associated with that user. Administrators can take action on users and choose to:

- **Reset password** - This action revokes user's current sessions.
- **Confirm user compromised** - This action is taken on a true positive. ID Protection sets the user risk to high and adds a new detection, Admin confirmed user compromised. The user is considered risky until remediation steps are taken.
- **Confirm user safe** - This action is taken on a false positive. Doing so removes risk and detections on this user and places it in learning mode to relearn the usage properties. You might use this option to mark false positives.
- **Dismiss user risk** - This action is taken on a benign positive user risk. This user risk we detected is real, but not malicious, like those from a known penetration test. Similar users should continue being evaluated for risk going forward.
- **Block user** - This action blocks a user from signing in if attacker has access to password or ability to perform MFA.
- **Investigate with Microsoft 365 Defender** - This action takes administrators to the Microsoft Defender portal to allow an administrator to investigate further.
