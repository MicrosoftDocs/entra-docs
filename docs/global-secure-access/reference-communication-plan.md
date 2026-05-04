---
title: Global Secure Access change communication plan template
description: "Use this template to plan how you communicate Global Secure Access changes to stakeholders, support teams, and users."
ms.topic: reference
ms.date: 05/04/2026
ms.reviewer: tdetzner
ai-usage: ai-assisted
---

# Global Secure Access change communication plan template

Use this template for **normal** and **major** changes that have user-visible impact. Adapt the communication channels and timing to your organization's practices.

---

## Communication plan details

| Field | Value |
| --- | --- |
| **Change ID** | _(match the change request template)_ |
| **Change summary** | _(one-sentence description)_ |
| **Change date and time** | |
| **Expected duration** | |
| **Expected user impact** | _(e.g., brief reconnection, temporary access loss, new client version required)_ |

## Stakeholder notification matrix

| Audience | When to notify | Channel | Owner | Sent? |
| --- | --- | --- | --- | --- |
| **Operations team** | 5 business days before change | Team meeting or Teams channel | Service Owner | [ ] |
| **IT Support / Help desk** | 3 business days before change | Email and knowledge base article update | Network Security Engineer | [ ] |
| **Affected users** | 2 business days before change | Email or company portal announcement | Service Owner | [ ] |
| **Security / SOC team** | 2 business days before change | Email or SIEM notification | Network Security Engineer | [ ] |
| **Management / leadership** | 2 business days before major changes | Email summary | Service Owner | [ ] |
| **All stakeholders** | Immediately after change completion | Email or Teams channel update | Service Owner | [ ] |

## Pre-change notification template

**Subject:** Planned Global Secure Access maintenance — [date and time]

---

**What is happening:**

[Brief description of the change. Keep it nontechnical for users.]

**When:**

[Date, start time, expected end time, and time zone]

**Who is affected:**

[Describe the affected user groups, sites, or applications]

**Expected impact:**

[Describe what users will experience. Be specific:
- "You might be briefly disconnected and need to reconnect"
- "Access to [application] will be temporarily unavailable"
- "No user impact expected, but we are notifying you as a precaution"]

**What you need to do:**

[If users need to take action, list it here. If no action needed, say so:
- "No action required on your part"
- "Restart the Global Secure Access client after [time]"
- "Save your work before [time] as a precaution"]

**Questions?**

Contact [help desk email or Teams channel] if you have questions or experience issues after the maintenance window.

---

## Post-change notification template

**Subject:** Global Secure Access maintenance complete — [date]

---

**The planned maintenance on [date] is complete.**

**What was changed:** [Brief summary]

**Impact:** [Confirm whether the maintenance completed within the expected window and whether any unexpected impact occurred]

**If you experience issues:** Contact [help desk email or Teams channel]. Reference ticket [Change ID].

---

## Communication checklist

- [ ] Pre-change notification drafted and reviewed
- [ ] Help desk briefed and knowledge base updated with expected issues and responses
- [ ] Pre-change notification sent to all audiences per the matrix above
- [ ] Day-of reminder sent (for major changes affecting many users)
- [ ] Post-change notification sent after successful completion
- [ ] Help desk debriefed on any unexpected issues reported during the change

## Escalation during change

If unexpected issues arise during the change, use this escalation path:

| Severity | Escalation action | Contact |
| --- | --- | --- |
| Minor (cosmetic, < 5 users affected) | Notify operations team; continue monitoring | [Team channel or on-call engineer] |
| Moderate (> 5 users affected, workaround available) | Notify Service Owner; decide whether to continue or roll back | [Service Owner name and contact] |
| Major (widespread outage, no workaround) | Roll back immediately; notify all stakeholders; open incident | [Incident management process / bridge call number] |

---

**Notes:**

_______________________________________________________________________________

_______________________________________________________________________________
