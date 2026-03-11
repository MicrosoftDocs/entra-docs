---
title: Configuration management in tenant governance
titleSuffix: Microsoft Entra ID Governance
description: Learn about configuration management capabilities in Microsoft Entra tenant governance, including baselines and drift monitoring.
author: nicharl
ms.author: nicharl
ms.service: entra-id-governance
ms.topic: concept-article
ms.date: 03/11/2026
---

# Configuration Management

## Resources

A resource represents a macro configuration component that can be managed via configuration-as-code. The tenant configuration management solution support hundreds of different resources types that can be used as part of your configuration baselines. Each resource defines multiple properties that can be managed by the solution. As an example, a Conditional Access Policy in Entra Id is represented by the microsoft.entra.conditionalaccesspolicy resource in Tenant Configuration Management. That resource exposes properties such as ExcludedUsers, IncludedGroups, State, etc. that can all be defined within your configuration baseline. For a full list of resources, please refer to [Overview of Tenant Configuration Management](https://learn.microsoft.com/en-us/graph/unified-tenant-configuration-management-concept-overview).

## Baselines

Baselines are the JSON representation of the resulting configuration you want to monitor for a given tenant. They consist of a list of resources and their defined values for the associated properties. A baseline can contain multiple instances of a given resource type. For example, a configuration baseline could defined multiple instances of Exchange Online Transport Rules as part of its definition. To learn more about configuration baselines, please refer to [Configuration baseline](https://learn.microsoft.com/en-us/graph/api/resources/configurationbaseline?view=graph-rest-beta).

## Monitors

Monitors are core to the Tenant Configuration Management solution. They run the processes responsible for continuously monitoring your tenants for any configuration drifts. Each monitor is defined by a JSON configuration baseline which specifies the resources it needs to validate, a name and description, a schedule run frequency that specifies how often it should execute, along with a configuration mode which specifies actions to be performed when drifts are encountered. In order to execute successfully, it is important to ensure that the Unified Tenant Configuration Management service principal has been granted the permissions to read resource types defined by the associated baselines. You can refer to the following [article](https://learn.microsoft.com/en-us/graph/utcm-authentication-setup) to learn more about how you can ensure proper permissions are granted to the monitors. To learn more about monitors, please refer to [configurationMonitor](https://learn.microsoft.com/en-us/graph/api/resources/configurationmonitor?view=graph-rest-beta).

## Monitoring Results

Every time a monitor executes, based on its specified schedule, it will produce a monitoring result, which is a summary of the execution. A monitoring result will contain information about how long it took to complete its execution, a status indicating whether or not the execution was successful in evaluating resources defined in the baseline associated with the monitor and information about how many drifts have been detected. It is important to note that if drifts have been detected, that the monitoring result will simply indicate that a drift was detected, but will not provide additional details about what the actual drift was. In order to get that information you will need to refer to the associated configuration drifts objects. To learn more about monitoring results, please refer to [configurationMonitoringResult](https://learn.microsoft.com/en-us/graph/api/configurationmonitoringresult-get?view=graph-rest-beta).

## Configuration Drifts

When a delta between what is defined in a configuration baseline and what the actual settings are on a given tenant are found, a configuration drift it raised. Configuration drifts are associated with a monitor and contain detailed information about what the detected delta is. It provides information about the actual resource in which the drift was detected, and lists the properties that have a different value than what was initially defined in the configuration baseline. Upon remediating to a detected drifts, the subsequent configuration monitor execution will automatically mark the configuration drift object as 'fixed'. To learn more about configuration drifts, please refer to [configurationDrift](https://learn.microsoft.com/en-us/graph/api/resources/configurationdrift?view=graph-rest-beta).

## Snapshot Jobs

When initiating a request to generate a snapshot, an asynchronous job is created which will collect the current state of the specified resources. This job is known as a snapshot job and is responsible for generating the actual JSON content of the requested snapshot. Once it successfully completes its task, the snapshot job will return with a status of 'succeeded' and its 'resourceLocation' property will expose a url for the binary content of the JSON snapshot to be retrieved. A snapshot job and its associated snapshots have a retention period of 7 days after which they will be deleted. It is therefore up to the customer to download the generated snapshots and to store them in their environments. The schema of generated snapshots is the same as the schema of configuration baslines and therefore can be leveraged as-is to create monitors. Similar to the monitors, snapshot jobs require that the proper permissions to read the requested resource types have been granted to the Unified Tenant Configuration Management service principal. You can refer to the following [article](https://learn.microsoft.com/en-us/graph/utcm-authentication-setup) to learn more about how you can ensure proper permissions are granted to the snapshot jobs. To learn more about snapshot jobs, please refer to [configurationSnapshotJob](https://learn.microsoft.com/en-us/graph/api/resources/configurationsnapshotjob?view=graph-rest-beta).
