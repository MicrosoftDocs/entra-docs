---
title: Microsoft Entra Workload ID license plans FAQ

description: Learn about Microsoft Entra Workload ID license plans, features, and capabilities.
author: gargi-sinha
manager: martinco
ms.service: entra-workload-id

ms.topic: faq
ms.date: 04/09/2024
ms.author: gasinh
ms.custom: aaddev
#Customer intent: I want to know about Microsoft Entra Workload ID licensing plans
---

# Frequently asked questions about Microsoft Entra Workload ID

[Microsoft Entra Workload ID](workload-identities-overview.md) is now available in two editions: **Free** and **Microsoft Entra Workload ID Premium**. The free edition of workload identities is included with a subscription of a commercial online service such as [Azure](https://azure.microsoft.com/) and [Power Platform](https://powerplatform.microsoft.com/). The Workload ID Premium offering is available through a Microsoft representative, the [Open Volume License Program](https://www.microsoft.com/licensing/how-to-buy/how-to-buy), and the [Cloud Solution Providers program](/azure/lighthouse/concepts/cloud-solution-provider). Azure and Microsoft 365 subscribers can also purchase Workload ID Premium online.

For more information, see [what are workload identities?](workload-identities-overview.md)

>[!NOTE]
> Workload ID Premium is a standalone product and isn't included in other premium product plans. All subscribers require a license to use Workload ID Premium features.

Learn more about [Workload ID pricing](https://www.microsoft.com/security/business/identity-access/microsoft-entra-workload-identities#office-StandaloneSKU-k3hubfz).

This document addresses Microsoft Entra Workload ID most frequent customer questions.  

[Microsoft Entra Workload ID](workload-identities-overview.md) (SKU name: Workload ID Premium) is generally available. It's available through a Microsoft representative, the Open Volume License Program, and the Cloud Solution Providers program. Azure and Office 365 subscribers can also buy the SKU online. Workload ID Premium is a standalone SKU ($3 per workload identity per month) that isn't part of other existing SKUs like E5. 

The free features, for example managed identities and workload identity federation, are included with a subscription of a commercial online service such as Azure, Power Platform, and others. 

## What features are included in Workload ID Premium and which features are free? 

|Capabilities | Description | Free | Premium |                 
|:--------|:----------|:------------|:-----------|
| **Authentication and authorization**|  | | |
| Create, read, update, and delete workload identities  | Create and update identities for securing service to service access  | Yes |  Yes |
| Authenticate workload identities and tokens to access resources |  Use Microsoft Entra ID to protect resource access |  Yes|  Yes |
| Workload identities sign-in activity and audit trail |   Monitor and track workload identity behavior  |  Yes |  Yes |
| **Managed identities**| Use Microsoft Entra identities in Azure without handling credentials |  Yes| Yes |
| Workload identity federation | Use workloads tested by external Identity Providers (IdPs) to access Microsoft Entra protected resources | Yes | Yes |
|  **Microsoft Entra Conditional Access**     |   |   |    
| Conditional Access policies for workload identities |Define the condition in which a workload can access a resource, such as an IP range | |  Yes | 
|**Lifecycle Management**|    |    |   |
|Access reviews for service provider-assigned privileged roles  |   Closely monitor workload identities with impactful permissions |    |  Yes |
| Application authentication methods API |  Allows IT admins to enforce best practices for how apps in their organizations use application authentication methods. |  | Yes |
| App Health Recommendations | Identify unused or inactive workload identities and their risk levels.  Get remediation guidelines.  |  | Yes |
|**Microsoft Entra ID Protection**  |  | |
|ID Protection for workload identities  | Detect and remediate compromised workload identities | | Yes |

## What is the cost of Workload ID Premium plan? 

The [Microsoft Entra Workload ID Premium](https://www.microsoft.com/security/business/identity-access/microsoft-entra-workload-identities#office-StandaloneSKU-k3hubfz) is priced at $3/workload identity/month. There is a lead status SKU (Workload ID P1) available. 

>[!Note]
>The lead status SKU can only provide the [Conditional Access](~/identity/conditional-access/workload-identity.md) feature.


## How many licenses do I need to purchase? Do I need to license all workload identities including Microsoft applications and managed identities? 

Only the workload identities eligible for premium features require licensing. Specifically, you're required to license enterprise apps and service principals listed under the first category in the following screenshot from the Workload ID landing page in the Microsoft Entra admin center. If you want to utilize premium features for a subset of enterprise apps and service principals, you must procure licenses accordingly, tailored to your specific requirements. An exception arises if you intend to use [access reviews](~/id-governance/privileged-identity-management/pim-create-roles-and-resource-roles-review.md) for managed identities. In such cases, licenses must be obtained based on the number of managed identities depicted in the graph.

Here are more details about which workload identities eligible for specific features. Currently, Conditional Access is applicable for workload identities for single-tenant applications and [ID Protection](~/id-protection/concept-workload-identity-risk.md) protects both single and multitenant applications under Enterprise apps/Service Principals. Microsoft apps and managed identities aren't eligible for Conditional Access and ID Protection. Access reviews are applicable for service principals assigned to privileged roles including managed identities. This feature requires Entra ID P2 licenses for reviewers and Workload ID Premium licenses for service principles that they want to set access reviews for.  

## How do I purchase a Workload ID Premium plan?

You need an Azure or Microsoft 365 subscription. You can use a current subscription or set up a new one. Then, sign into the [Microsoft Microsoft Entra admin center](https://entra.microsoft.com/) with your credentials to buy Workload ID licenses.

## Do these licenses require individual workload identities assignment? 

No, license assignment isn't required.  One license in the tenant unlocks all features for all workload identities.

## How can I track which licenses are assigned to which workload identities? 

Unfortunately, we don’t provide a dashboard to track that information. You can only track enabled Conditional Access policies targeting workload identities in the **Insights and reporting** area. 

:::image type="content" source="media/workload-identities-faqs/insights-and-reportin.png" alt-text="Screenshot showing Insights and Reporting in Conditional Access." border="false":::

- Total: Number of service principals in the Last 24 hours.
- Success: Number of service principals where the selected polic(ies) granted access and the required controls were satisfied. 
- Failure: Number of service principals where the selected polic(ies) denied access and the required controls were not satisfied.
- Not applied: Number of service principals that are bypassing the selected polic(ies) because the sign-in did not match at least one of the assignments or conditions. 

## Can I get a free trial of Workload ID Premium? 

Yes. You can get a [90-day free trial](https://entra.microsoft.com/#view/Microsoft_Azure_ManagedServiceIdentity/WorkloadIdentitiesBlade). In the Modern channel, a 30-day only trial is available. Free trial is unavailable in [Microsoft Azure Government](https://azure.microsoft.com/global-infrastructure/government/) clouds.

## Is the Workload ID Premium plan available on Azure Government clouds? 

Yes. For Azure Government cloud customers, contact your account manager to proceed with the trial.

<a name='is-it-possible-to-have-a-mix-of-azure-ad-premium-p1-azure-ad-premium-p2-and-workload-identities-premium-licenses-in-one-tenant'></a>

## Is it possible to have a mix of Microsoft Entra ID P1, P2, and Workload ID Premium licenses in one tenant?

Yes, customers can have a mixture of SKUs in one tenant.

## Next steps

Learn more about [workload identities](workload-identities-overview.md).
