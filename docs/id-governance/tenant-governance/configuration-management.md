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

A resource represents a macro configuration component that can be managed via configuration-as-code. The tenant configuration management solution support hundreds of different resources types that can be used as part of your configuration baselines. Each resource defines multiple properties that cna be managed by the solution. As an example, a Conditional Access Policy in Entra Id is represented by the microsoft.entra.conditionalaccesspolicy resource in Tenant Configuration Management. That resource exposes properties such as ExcludedUsers, IncludedGroups, State, etc. that can all be defined within your configuration baseline. For a full list of resources, please refer to [Overview of Tenant Configuration Management](https://learn.microsoft.com/en-us/graph/unified-tenant-configuration-management-concept-overview).

## Baselines

Baselines are the JSON representation of the resulting configuration you want to monitor for a given tenant. They consist of a list of resources and their defined values for the associated properties. A baseline can contain multiple instances of a given resource type. For example, a configuration baseline could defined multiple instance of Exchange Online Transport Rules as part of its definition. To learn more about configuration baselines, please refer to [Configuration baseline](https://learn.microsoft.com/en-us/graph/api/resources/configurationbaseline?view=graph-rest-beta).

## Monitors

Monitors are core to the Tenant Configuration Management solution. They run the processes responsible for continuously monitoring your tenants for any configuration drifts. Each monitor is defined by a JSON configuration baseline which specifies the resources it needs to validate, a name and description, a schedule run frequency that specifies how often it should execute, along with a configuration mode which specifies actions to be performed when drifts are encountered. To learn more about monitrs, please refer to [configurationMonitor](https://learn.microsoft.com/en-us/graph/api/resources/configurationmonitor?view=graph-rest-beta).

## Monitoring Results

Every time a monitor exectues, based on its specified schedule, it will produce a monitoring result, which is a summary of the execution. A monitoring result will contain information about how long it took to complete its execution, a stauts indicating whether or not the execution was successful in evaluating resources defined in the baseline associated with the monitor and information about how many drifts have been detected. It is important to note that if drifts have been detected, that the monitoring result will simply indicate that a drfit was detected, but will not provide addtional details about what the actual drift was. In order to get that information you will need to refer to the associated configuration drifts objects. To learn more about monitoring results, please refer to [configurationMonitoringResult](https://learn.microsoft.com/en-us/graph/api/configurationmonitoringresult-get?view=graph-rest-beta).

## Configuration Drifts

When a delta between what is defined in a configuration baseline and what the actual settings are on a given tenant are found, a configuration drift it raised. Configuration drifts are associated with a monitor and contain detailed information about what the detected delta is. It provides information about the actual resource in which the drift was detected, and lists the properties that have a different value than what was initially defined in the configuration baseline. Upon remediating to a detected drifts, the subsequent configuration monitor execution will automatically mark the configuration drift object as 'fixed'. To learn more about configuration drifts, please refer to [configurationDrift](https://learn.microsoft.com/en-us/graph/api/resources/configurationdrift?view=graph-rest-beta)
