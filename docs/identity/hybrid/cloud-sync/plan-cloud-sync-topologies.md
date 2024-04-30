---
title: Microsoft Entra Cloud Sync supported topologies and scenarios
description: Learn about various on-premises and Microsoft Entra topologies that use Microsoft Entra Cloud Sync.

author: billmath
manager: amycolannino
ms.service: entra-id
ms.topic: conceptual
ms.date: 04/26/2024
ms.subservice: hybrid-cloud-sync
ms.author: billmath

---


# Microsoft Entra Cloud Sync supported topologies and scenarios
This article describes various on-premises and Microsoft Entra topologies that use Microsoft Entra Cloud Sync. This article includes only supported configurations and scenarios.

> [!IMPORTANT]
> Microsoft doesn't support modifying or operating Microsoft Entra Cloud Sync outside of the configurations or actions that are formally documented. Any of these configurations or actions might result in an inconsistent or unsupported state of Microsoft Entra Cloud Sync. As a result, Microsoft can't provide technical support for such deployments.

For more information, see the following video.

> [!VIDEO https://www.microsoft.com/en-us/videoplayer/embed/RWJ8l5]

## Things to remember about all scenarios and topologies
The information below should be kept in mind, when selecting a solution.

- Users and groups must be uniquely identified across all forests.
- Matching across forests doesn't occur with cloud sync.
- The source anchor for objects is chosen automatically.  It uses ms-DS-ConsistencyGuid if present, otherwise ObjectGUID is used.
- You can't change the attribute that is used for source anchor.



## Active Directory to Microsoft Entra ID supported topologies
The following topologies are supported for provisioning from Active Directory to Microsoft Entra ID.

### Single forest, single Microsoft Entra tenant
![Diagram that shows the topology for a single forest and a single tenant.](media/tutorial-single-forest/diagram-2.png)

The simplest topology is a single on-premises forest, with one or multiple domains, and a single Microsoft Entra tenant.  For an example of this scenario see [Tutorial: A single forest with a single Microsoft Entra tenant](tutorial-single-forest.md)



### Multi-forest, single Microsoft Entra tenant
![Topology for a multi-forest and a single tenant](media/plan-cloud-provisioning-topologies/multi-forest-2.png)

Multiple AD forests are a common topology, with one or multiple domains, and a single Microsoft Entra tenant.  



### Existing forest with Microsoft Entra Connect, new forest with cloud Provisioning
![Diagram that shows the topology for an existing forest and a new forest.](media/tutorial-existing-forest/existing-forest-new-forest-2.png)

This scenario is topology is similar to the multi-forest scenario, however this one involves an existing Microsoft Entra Connect environment and then bringing on a new forest using Microsoft Entra Cloud Sync.  For an example of this scenario see [Tutorial: An existing forest with a single Microsoft Entra tenant](tutorial-existing-forest.md)



### Piloting Microsoft Entra Cloud Sync in an existing hybrid AD forest
![Topology for a single forest and a single tenant](media/tutorial-migrate-aadc-aadccp/diagram-2.png)
The piloting scenario involves the existence of both Microsoft Entra Connect and Microsoft Entra Cloud Sync in the same forest and scoping the users and groups accordingly. NOTE: An object should be in scope in only one of the tools. 

For an example of this scenario see [Tutorial: Pilot Microsoft Entra Cloud Sync in an existing synced AD forest](tutorial-pilot-aadc-aadccp.md)

### Merging objects from disconnected sources 
#### (Public Preview)
![Diagram for merging objects from disconnected sources](media/plan-cloud-provisioning-topologies/attributes-multiple-sources.png)
In this scenario, the attributes of a user are contributed to by two disconnected Active Directory forests. 

An example would be:

 - One forest (1) contains most of the attributes.
 - A second forest (2) contains a few attributes.

 Since the second forest doesn't have network connectivity to the Microsoft Entra Connect server, the object can't be merged through Microsoft Entra Connect. Cloud sync in the second forest allows the attribute value to be retrieved from the second forest. The value can then be merged with the object in Microsoft Entra ID that is synced by Microsoft Entra Connect.

This configuration is advanced and there are a few caveats to this topology: 

 1. You must use `ms-DS-ConsistencyGuid` as the source anchor in the cloud sync configuration.
 2. The `ms-DS-ConsistencyGuid` of the user object in the second forest must match that of the corresponding object in Microsoft Entra ID.
 3. You must populate the `UserPrincipalName` attribute and the `Alias` attribute in the second forest and it must match the ones that are synced from the first forest. 
 4. You must remove all attributes from the attribute mapping in the cloud sync configuration that don't have a value or may have a different value in the second forest – you can't have overlapping attribute mappings between the first forest and the second one. 
 5. If there's no matching object in the first forest, for an object that is synced from the second forest, then cloud sync will still create the object in Microsoft Entra ID. The object will only have the attributes that are defined in the mapping configuration of cloud sync for the second forest. 
 6. If you delete the object from the second forest, it will be temporarily soft deleted in Microsoft Entra ID. It will be restored automatically after the next Microsoft Entra Connect Sync cycle.  
 7. If you delete the object from the first forest, it will be soft deleted from Microsoft Entra ID.  The object won't be restored unless a change is made to the object in the second forest. After 30 days the object will be hard deleted from Microsoft Entra ID and if a change is made to the object in the second forest it will be created as a new object in Microsoft Entra ID. 

## Microsoft Entra ID to Active Directory supported topologies
The following topologies are supported for provisioning from Microsoft Entra ID to Active Directory.

### Single forest group provisioning to Active Directory

:::image type="content" source="media/plan-cloud-provisioning-topologies/single-forest-group-writeback.png" alt-text="Conceptual diagram of single forest writeback." lightbox="media/plan-cloud-provisioning-topologies/single-forest-group-writeback.png":::
 
 The simplest group provisioning topology is a single on-premises forest, with one or multiple domains, and a single Microsoft Entra tenant.  For an example of this scenario see [Provision groups to Active Directory](tutorial-group-provisioning.md)

### Multi-forest group provisioning to Active Directory

:::image type="content" source="media/plan-cloud-provisioning-topologies/multi-forest-group-writeback.png" alt-text="Conceptual diagram of multi-forest writeback." lightbox="media/plan-cloud-provisioning-topologies/multi-forest-group-writeback.png":::
 
 A more advanced group provisioning topology consists of [multiple on-premises AD forests sharing a single Microsoft Entra ID tenant](#multi-forest-single-microsoft-entra-tenant).  

 This configuration is advanced and there are a few things to remember with this topology: 

 - Groups provisioned to AD using cloud sync can only contain on-premises synchronized users and / or additional cloud created security groups.
 - All of these users must have the onPremisesObjectIdentifier attribute set on their account.
 - The onPremisesObjectIdentifier must match a corresponding objectGUID in the target AD environment.
 - An on-premises users objectGUID attribute to a cloud users onPremisesObjectIdentifier attribute can be synchronized using either Microsoft Entra Cloud Sync ([1.1.1370.0](../cloud-sync/reference-version-history.md#1113700)) or Microsoft Entra Connect Sync ([2.2.8.0](../connect/reference-connect-version-history.md#2280))
 - Inside your tenant you may share a common group that contains users from both forests.
 - However, users that don't exist in the other forest, WILL NOT be provisioned as members of the group when it's provisioned on-premises.  So if you have a group in Microsoft Entra ID that contains users from contoso.com and fabrikam.com, only the users that exist in the contoso.com forest will be members of the group when it's provisioned to contoso.com.  And same with fabrikam.  


## Next steps 

- [What is provisioning?](../what-is-provisioning.md)
- [What is Microsoft Entra Cloud Sync?](what-is-cloud-sync.md)
