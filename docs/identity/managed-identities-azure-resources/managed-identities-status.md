---
title: Azure Services and resources with managed identities
description: Explore Azure services and resource types supporting managed identities for secure, credential-free authentication.

author: SHERMANOUKO
ms.author: shermanouko
ms.date: 05/09/2025
ms.topic: conceptual
ms.service: entra-id
ms.subservice: managed-identities
manager: CelesteDG

#Customer intent: As an Azure admin or developer, I want to identify which Azure services support managed identities so that I can securely configure authentication for my resources.
---

# Azure services and resource types supporting managed identities

Managed identities for Azure resources provide an automatically managed identity in Microsoft Entra ID, enabling secure, credential-free authentication to Azure services. This article lists Azure services and resource types that support managed identities.

This page provides links to services' content that can use managed identities to access other Azure resources as well as a list of Azure resource providers and resource types that support managed identities.

Additional resource provider namespace information is available in [Resource providers for Azure services](/azure/azure-resource-manager/management/azure-services-resource-providers).

>[!IMPORTANT]
> New technical content is added daily. This list does not include every article that talks about managed identities. Please refer to each service's content set for details on their managed identities support. 

## Services supporting managed identities

The following Azure services support managed identities for Azure resources:


| Service Name                    |  Documentation                                                                                                                                                                                |
|---------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| API Management                  | [Use managed identities in Azure API Management](/azure/api-management/api-management-howto-use-managed-service-identity)                                                                                            |
| Application Gateway             | [TLS termination with Key Vault certificates](/azure/application-gateway/key-vault-certs)                                                                                                             |
| Azure App Configuration         | [How to use managed identities for Azure App Configuration](/azure/azure-app-configuration/overview-managed-identity)                                                                                                           |
| Azure App Services              | [How to use managed identities for App Service and Azure Functions](/azure/app-service/overview-managed-identity)    |
| Azure Arc enabled Kubernetes    | [Quickstart: Connect an existing Kubernetes cluster to Azure Arc](/azure/azure-arc/kubernetes/quickstart-connect-cluster)                                                                                                   |
| Azure Arc enabled servers       | [Authenticate against Azure resources with Azure Arc-enabled servers](/azure/azure-arc/servers/managed-identity-authentication)                                                                                                 |
| Azure Automanage                | [Repair an Automanage Account](/azure/automanage/repair-automanage-account)                                                                     |
| Azure Automation                | [Azure Automation account authentication overview](/azure/automation/automation-security-overview#managed-identities)                                       |
| Azure Batch                     | [Configure customer-managed keys for your Azure Batch account with Azure Key Vault and Managed Identity](/azure/batch/batch-customer-managed-key)  </BR> [Configure managed identities in Batch pools](/azure/batch/managed-identity-pools)          |
| Azure Blueprints                | [Stages of a blueprint deployment](/azure/governance/blueprints/concepts/deployment-stages)                              |
| Azure Cache for Redis           | [Managed identity for storage accounts with Azure Cache for Redis](/azure/azure-cache-for-redis/cache-managed-identity) |
| Azure Chaos Studio              | [Permissions and security in Azure Chaos Studio](/azure/chaos-studio/chaos-studio-permissions-security#user-assigned-managed-identity)        |
| Azure Communications Gateway    | [Deploy Azure Communications Gateway](/azure/communications-gateway/deploy) |
| Azure Communication Services    | [How to use Managed Identity with Azure Communication Services](/azure/communication-services/how-tos/managed-identity) |
| Azure Container Apps            | [Managed identities in Azure Container Apps](/azure/container-apps/managed-identity) |
| Azure Container Instance        | [How to use managed identities with Azure Container Instances](/azure/container-instances/container-instances-managed-identity)                                                                                          |
| Azure Container Registry        | [Use an Azure-managed identity in ACR Tasks](/azure/container-registry/container-registry-tasks-authentication-managed-identity)                                                                       |
| Azure CycleCloud                | [Using Managed Identities](/azure/cyclecloud/how-to/managed-identities?view=cyclecloud-8)    |
| Azure AI services        | [Configure customer-managed keys with Azure Key Vault for Azure AI services](/azure/ai-services/encryption/cognitive-services-encryption-keys-portal)                                                                          |
| Azure Data Box                  | [Use customer-managed keys in Azure Key Vault for Azure Data Box](/azure/databox/data-box-customer-managed-encryption-key-portal)                                                                                             |
| Azure Data Explorer             | [Configure managed identities for your Azure Data Explorer cluster](/azure/data-explorer/configure-managed-identities-cluster?tabs=portal)                                                                                                     |
| Azure Data Factory              | [Managed identity for Data Factory](/azure/data-factory/data-factory-service-identity)                                                                                                           |
| Azure Data Lake Storage Gen1    | [Customer-managed keys for Azure Storage encryption](/azure/storage/common/customer-managed-keys-overview)                                                                                                  |
| Azure Data Share                | [Roles and requirements for Azure Data Share](/azure/data-share/concepts-roles-permissions)   |
| Azure DevTest Labs             | [Enable user-assigned managed identities on lab virtual machines in Azure DevTest Labs](/azure/devtest-labs/enable-managed-identities-lab-vms) |
| Azure Digital Twins             | [Enable a managed identity for routing Azure Digital Twins events](/azure/digital-twins/how-to-enable-managed-identities-portal)                                                                                            |
| Azure Event Grid                | [Event delivery with a managed identity](/azure/event-grid/managed-service-identity)|
| Azure Event Hubs                | [Authenticate a managed identity with Microsoft Entra ID to access Event Hubs Resources](/azure/event-hubs/authenticate-managed-identity)|
| Azure File Sync                 | [How to use managed identities with Azure File Sync](/azure/storage/file-sync/file-sync-managed-identities)|
| Azure Files                     | [Access Azure file shares using Microsoft Entra ID with Azure Files OAuth over REST](/azure/storage/files/authorize-oauth-rest)|
| Azure Health Data Services workspace services | [Authentication and authorization for Azure Health Data Services](/azure/healthcare-apis/authentication-authorization)|
| Azure Health Data Services de-identification service | [Use managed identities with the de-identification service](/azure/healthcare-apis/deidentification/managed-identities)|
| Azure Image Builder             | [Azure Image Builder overview](/azure/virtual-machines/image-builder-overview#permissions)                                                                                                    |
| Azure Import/Export             | [Use customer-managed keys in Azure Key Vault for Import/Export service](/azure/import-export/storage-import-export-encryption-key-portal)|
| Azure IoT Hub                   | [IoT Hub support for virtual networks with Private Link and Managed Identity](/azure/iot-hub/virtual-network-support)                                                                               |
| Azure Kubernetes Service (AKS)  | [Use managed identities in Azure Kubernetes Service](/azure/aks/use-managed-identity)                                                                                                                           |
| Azure Load Testing                | [Use managed identities for Azure Load Testing](/azure/load-testing/how-to-use-a-managed-identity)  |
| Azure Logic Apps                | [Authenticate access to Azure resources using managed identities in Azure Logic Apps](/azure/logic-apps/create-managed-service-identity)                                                                                                       |
| Azure Log Analytics workspace   | [Enable managed identity for Log Analytics workspace](/azure/azure-monitor/logs/private-storage?tabs=azure-portal##link-storage-accounts-to-your-log-analytics-workspace)  |
| Azure Log Analytics cluster     | [Azure Monitor customer-managed key](/azure/azure-monitor/logs/customer-managed-keys)|
| Azure Machine Learning Services | [Use Managed identities with Azure Machine Learning](/azure/machine-learning/how-to-identity-based-service-authentication?tabs=python)                                                                                         |
| Azure Managed Disk              | [Use the Azure portal to enable server-side encryption with customer-managed keys for managed disks](/azure/virtual-machines/disks-enable-customer-managed-keys-portal)                                                                                        |
| Azure Media services            | [Managed identities](/azure/media-services/latest/concept-managed-identities) |
| Azure Monitor                   | [Azure Monitor customer-managed key](/azure/azure-monitor/logs/customer-managed-keys?tabs=portal)                                                                                              |
| Azure Policy                    | [Remediate non-compliant resources with Azure Policy](/azure/governance/policy/how-to/remediate-resources)      |
| Microsoft Purview                   | [Credentials for source authentication in Microsoft Purview](/purview/manage-credentials) |
| Azure Quantum                   | [Authenticate using a managed identity](/azure/quantum/optimization-authenticate-managed-identity)        |
| Azure Resource Mover            | [Move resources across regions (from resource group)](/azure/resource-mover/move-region-within-resource-group)|
| Azure Site Recovery             | [Replicate machines with private endpoints](/azure/site-recovery/azure-to-azure-how-to-enable-replication-private-endpoints#enable-the-managed-identity-for-the-vault)                                  |
| Azure Search                    | [Set up an indexer connection to a data source using a managed identity](/azure/search/search-howto-managed-identities-data-sources)                                                                                            |
| Azure Service Bus               | [Authenticate a managed identity with Microsoft Entra ID to access Azure Service Bus resources](/azure/service-bus-messaging/service-bus-managed-service-identity)                                                                                                        |
| Azure Service Fabric            | [Using Managed identities for Azure with Service Fabric](/azure/service-fabric/concepts-managed-identity)                                                                                                        |
| Azure SignalR Service           | [Managed identities for Azure SignalR Service](/azure/azure-signalr/howto-use-managed-identity)                                                                                                     |
| Azure Spring Apps               | [Enable system-assigned managed identity for an application in Azure Spring Apps](/azure/spring-apps/how-to-enable-system-assigned-managed-identity) |
| Azure SQL                       | [Managed identities in Microsoft Entra for Azure SQL](/azure/azure-sql/database/authentication-azure-ad-user-assigned-managed-identity)                                                                                     |
| Azure SQL Managed Instance      | [Managed identities in Microsoft Entra for Azure SQL](/azure/azure-sql/database/authentication-azure-ad-user-assigned-managed-identity)                                                                                       |
| Azure Stack Edge                | [Manage Azure Stack Edge secrets using Azure Key Vault](/azure/databox-online/azure-stack-edge-gpu-activation-key-vault#recover-managed-identity-access)|
| Azure Static Web Apps           | [Securing authentication secrets in Azure Key Vault](/azure/static-web-apps/key-vault-secrets)|
| Azure Stream Analytics          | [Authenticate Stream Analytics to Azure Data Lake Storage Gen1 using managed identities](/azure/stream-analytics/stream-analytics-managed-identities-adls)                                                                                         |
| Azure Synapse                   | [Azure Synapse workspace managed identity](/azure/data-factory/data-factory-service-identity)                                                                                         |
| Azure VM image builder          | [Configure Azure Image Builder Service permissions using Azure CLI](/azure/virtual-machines/linux/image-builder-permissions-cli#using-managed-identity-for-azure-storage-access)|
| Azure Virtual Machine Scale Sets      | [Configure managed identities on virtual machine scale set - Azure CLI](qs-configure-cli-windows-vmss.md)                                                                  |
| Azure Virtual Machines                | [Secure and use policies on virtual machines in Azure](/azure/virtual-machines/windows/security-policy#managed-identities-for-azure-resources)                                                                  |
| Azure Web PubSub Service           | [Managed identities for Azure Web PubSub Service](/azure/azure-web-pubsub/howto-use-managed-identity)     |


## Resource providers and resource types supporting managed identities

The following resource providers and resource types support managed identities:

| Namespace | ResourceType | Identity types(s) | 
| --- | --- | --- |
| Microsoft.AVS | privateClouds | System-assigned<br/>User-assigned |
| Microsoft.ApiManagement | service | System-assigned<br/>User-assigned |
| Microsoft.App | builders | System-assigned<br/>User-assigned |
| Microsoft.App | containerApps | System-assigned<br/>User-assigned |
| Microsoft.App | jobs | System-assigned<br/>User-assigned |
| Microsoft.App | managedEnvironments | System-assigned<br/>User-assigned |
| Microsoft.App | sessionPools | System-assigned<br/>User-assigned |
| Microsoft.AppConfiguration | configurationStores | System-assigned<br/>User-assigned |
| Microsoft.AppPlatform | Spring | System-assigned |
| Microsoft.AppPlatform | Spring/apps | System-assigned<br/>User-assigned |
| Microsoft.Automation | automationAccounts | System-assigned<br/>User-assigned |
| Microsoft.AzureStackHCI | clusters | System-assigned |
| Microsoft.AzureStackHCI | devicePools | System-assigned |
| Microsoft.AzureStackHCI | edgeMachines | System-assigned |
| Microsoft.AzureStackHCI | virtualMachines | System-assigned |
| Microsoft.Batch | batchAccounts | System-assigned<br/>User-assigned |
| Microsoft.Batch | batchAccounts/pools | User-assigned |
| Microsoft.Blueprint | blueprintAssignments | System-assigned<br/>User-assigned |
| Microsoft.Cache | Redis | System-assigned<br/>User-assigned |
| Microsoft.Cache | redisEnterprise | System-assigned<br/>User-assigned |
| Microsoft.Cdn | profiles | System-assigned<br/>User-assigned |
| Microsoft.ChangeAnalysis | profile | System-assigned |
| Microsoft.CognitiveServices | accounts | System-assigned<br/>User-assigned |
| Microsoft.CognitiveServices | accounts/encryptionScopes |  |
| Microsoft.Communication | CommunicationServices | System-assigned<br/>User-assigned |
| Microsoft.Compute | diskEncryptionSets | System-assigned<br/>User-assigned |
| Microsoft.Compute | galleries | System-assigned<br/>User-assigned |
| Microsoft.Compute | virtualMachineScaleSets | System-assigned<br/>User-assigned |
| Microsoft.Compute | virtualMachines | System-assigned<br/>User-assigned |
| Microsoft.ContainerInstance | containerGroups | System-assigned<br/>User-assigned |
| Microsoft.ContainerInstance | containerScaleSets | System-assigned<br/>User-assigned |
| Microsoft.ContainerInstance | nGroups | System-assigned<br/>User-assigned |
| Microsoft.ContainerRegistry | registries | System-assigned<br/>User-assigned |
| Microsoft.ContainerRegistry | registries/credentialSets | System-assigned |
| Microsoft.ContainerRegistry | registries/exportPipelines | System-assigned<br/>User-assigned |
| Microsoft.ContainerRegistry | registries/importPipelines | System-assigned<br/>User-assigned |
| Microsoft.ContainerRegistry | registries/taskRuns | User-assigned |
| Microsoft.ContainerRegistry | registries/tasks | System-assigned<br/>User-assigned |
| Microsoft.ContainerService | fleets | System-assigned<br/>User-assigned |
| Microsoft.ContainerService | managedClusters | System-assigned<br/>User-assigned |
| Microsoft.ContainerService | managedclustersnapshots | System-assigned<br/>User-assigned |
| Microsoft.ContainerService | snapshots | System-assigned<br/>User-assigned |
| Microsoft.CustomProviders | resourceProviders | System-assigned |
| Microsoft.DBforMariaDB | servers | System-assigned |
| Microsoft.DBforMySQL | flexibleServers | User-assigned |
| Microsoft.DBforMySQL | servers | System-assigned |
| Microsoft.DBforPostgreSQL | flexibleServers | System-assigned<br/>User-assigned |
| Microsoft.DBforPostgreSQL | serverGroupsv2 | User-assigned |
| Microsoft.DBforPostgreSQL | servers | System-assigned |
| Microsoft.DataBox | jobs | System-assigned<br/>User-assigned |
| Microsoft.DataBoxEdge | DataBoxEdgeDevices | System-assigned |
| Microsoft.DataFactory | factories | System-assigned<br/>User-assigned |
| Microsoft.DataLakeStore | accounts | System-assigned |
| Microsoft.DataMigration | SqlMigrationServices | System-assigned |
| Microsoft.DataMigration | migrationServices | System-assigned |
| Microsoft.DataProtection | BackupVaults | System-assigned<br/>User-assigned |
| Microsoft.DataShare | accounts | System-assigned |
| Microsoft.Databricks | accessConnectors | System-assigned<br/>User-assigned |
| Microsoft.DesktopVirtualization | hostpools | System-assigned<br/>User-assigned |
| Microsoft.DevCenter | devcenters | System-assigned<br/>User-assigned |
| Microsoft.DevCenter | devcenters/encryptionsets | System-assigned<br/>User-assigned |
| Microsoft.DevCenter | projects | System-assigned<br/>User-assigned |
| Microsoft.DevCenter | projects/environmentTypes | System-assigned<br/>User-assigned |
| Microsoft.DevOpsInfrastructure | pools | User-assigned |
| Microsoft.DevTestLab | labs | System-assigned<br/>User-assigned |
| Microsoft.DevTestLab | labs/serviceRunners | System-assigned<br/>User-assigned |
| Microsoft.DeviceUpdate | accounts | System-assigned<br/>User-assigned |
| Microsoft.DeviceUpdate | updateAccounts | System-assigned<br/>User-assigned |
| Microsoft.Devices | IotHubs | System-assigned<br/>User-assigned |
| Microsoft.Devices | ProvisioningServices | System-assigned<br/>User-assigned |
| Microsoft.DigitalTwins | digitalTwinsInstances | System-assigned<br/>User-assigned |
| Microsoft.DocumentDB | cassandraClusters | System-assigned |
| Microsoft.DocumentDB | databaseAccounts | System-assigned<br/>User-assigned |
| Microsoft.DocumentDB | databaseAccounts/encryptionScopes | User-assigned |
| Microsoft.DocumentDB | garnetClusters | System-assigned |
| Microsoft.DocumentDB | managedResources | System-assigned |
| Microsoft.DocumentDB | throughputPools | System-assigned |
| Microsoft.DocumentDB | throughputPools/throughputPoolAccounts | System-assigned |
| Microsoft.ElasticSan | elasticSans/volumeGroups | System-assigned<br/>User-assigned |
| Microsoft.EventGrid | domains | System-assigned<br/>User-assigned |
| Microsoft.EventGrid | namespaces | System-assigned<br/>User-assigned |
| Microsoft.EventGrid | partnerTopics | System-assigned<br/>User-assigned |
| Microsoft.EventGrid | systemTopics | System-assigned<br/>User-assigned |
| Microsoft.EventGrid | topics | System-assigned<br/>User-assigned |
| Microsoft.EventHub | namespaces | System-assigned<br/>User-assigned |
| Microsoft.HDInsight | clusters | System-assigned<br/>User-assigned |
| Microsoft.HybridCompute | machines | System-assigned |
| Microsoft.HybridNetwork | networkfunctions | System-assigned<br/>User-assigned |
| Microsoft.HybridNetwork | publishers | System-assigned |
| Microsoft.HybridNetwork | serviceManagementContainers | System-assigned<br/>User-assigned |
| Microsoft.HybridNetwork | siteNetworkServices | System-assigned<br/>User-assigned |
| Microsoft.IoTCentral | IoTApps | System-assigned |
| Microsoft.KeyVault | managedHSMs | User-assigned |
| Microsoft.Kubernetes | connectedClusters | System-assigned |
| Microsoft.KubernetesConfiguration | extensions | System-assigned |
| Microsoft.Kusto | clusters | System-assigned<br/>User-assigned |
| Microsoft.LoadTestService | loadtests | System-assigned<br/>User-assigned |
| Microsoft.Logic | integrationAccounts | System-assigned<br/>User-assigned |
| Microsoft.Logic | integrationServiceEnvironments | System-assigned<br/>User-assigned |
| Microsoft.Logic | workflows | System-assigned<br/>User-assigned |
| Microsoft.MachineLearningServices | registries | System-assigned<br/>User-assigned |
| Microsoft.MachineLearningServices | workspaces | System-assigned<br/>User-assigned |
| Microsoft.MachineLearningServices | workspaces/batchEndpoints | System-assigned |
| Microsoft.MachineLearningServices | workspaces/computes | System-assigned<br/>User-assigned |
| Microsoft.MachineLearningServices | workspaces/inferencePools/groups | System-assigned<br/>User-assigned |
| Microsoft.MachineLearningServices | workspaces/linkedServices | System-assigned |
| Microsoft.MachineLearningServices | workspaces/onlineEndpoints | System-assigned<br/>User-assigned |
| Microsoft.Maps | accounts | System-assigned<br/>User-assigned |
| Microsoft.Media | mediaservices | System-assigned<br/>User-assigned |
| Microsoft.Migrate | migrateprojects | System-assigned |
| Microsoft.Migrate | modernizeProjects | System-assigned |
| Microsoft.Migrate | moveCollections | System-assigned |
| Microsoft.MobileNetwork | mobileNetworks | User-assigned |
| Microsoft.MobileNetwork | packetCoreControlPlanes | User-assigned |
| Microsoft.MobileNetwork | simGroups | System-assigned<br/>User-assigned |
| Microsoft.NetApp | netAppAccounts | System-assigned<br/>User-assigned |
| Microsoft.Network | networkWatchers/flowLogs | User-assigned |
| Microsoft.OperationalInsights | clusters | System-assigned<br/>User-assigned |
| Microsoft.OperationalInsights | workspaces | System-assigned<br/>User-assigned |
| Microsoft.PowerPlatform | enterprisePolicies | System-assigned<br/>User-assigned |
| Microsoft.Purview | accounts | System-assigned<br/>User-assigned |
| Microsoft.Quantum | Workspaces | System-assigned |
| Microsoft.RecoveryServices | vaults | System-assigned<br/>User-assigned |
| Microsoft.RedHatOpenShift | OpenShiftClusters | System-assigned |
| Microsoft.Search | searchServices | System-assigned<br/>User-assigned |
| Microsoft.Security | dataScanners | System-assigned |
| Microsoft.Security | pricings/securityOperators | System-assigned |
| Microsoft.ServiceBus | namespaces | System-assigned<br/>User-assigned |
| Microsoft.ServiceFabric | clusters | System-assigned<br/>User-assigned |
| Microsoft.ServiceFabric | clusters/applications | System-assigned<br/>User-assigned |
| Microsoft.ServiceFabric | managedclusters | System-assigned<br/>User-assigned |
| Microsoft.ServiceFabric | managedclusters/applications | System-assigned<br/>User-assigned |
| Microsoft.SignalRService | SignalR | System-assigned<br/>User-assigned |
| Microsoft.SignalRService | WebPubSub | System-assigned<br/>User-assigned |
| Microsoft.Solutions | applications | System-assigned<br/>User-assigned |
| Microsoft.Sql | managedInstances | System-assigned<br/>User-assigned |
| Microsoft.Sql | servers | System-assigned<br/>User-assigned |
| Microsoft.Sql | servers/databases | User-assigned |
| Microsoft.Sql | servers/jobAgents | User-assigned |
| Microsoft.Storage | storageAccounts | System-assigned<br/>User-assigned |
| Microsoft.Storage | storageTasks | System-assigned |
| Microsoft.StorageCache | amlFilesystems | User-assigned |
| Microsoft.StorageCache | caches | System-assigned<br/>User-assigned |
| Microsoft.StorageSync | storageSyncServices | System-assigned<br/>User-assigned |
| Microsoft.StreamAnalytics | streamingjobs | System-assigned<br/>User-assigned |
| Microsoft.Synapse | workspaces | System-assigned<br/>User-assigned |
| Microsoft.VirtualMachineImages | imageTemplates | User-assigned |
| Microsoft.Web | hostingEnvironments | System-assigned<br/>User-assigned |
| Microsoft.Web | sites | System-assigned<br/>User-assigned |
| Microsoft.Web | sites/slots | System-assigned<br/>User-assigned |
| Microsoft.Web | staticSites | System-assigned<br/>User-assigned |

## Next steps

- [Managed identities overview](Overview.md)

