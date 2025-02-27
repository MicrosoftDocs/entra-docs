---
author: rwike77
ms.author: ryanwi
ms.date: 06/05/2024
ms.topic: include
ms.service: entra-id
ms.subservice: managed-identities
ms.custom:
  - devx-track-azurecli
---

## Assign a managed identity access to another application's app role using CLI

[!INCLUDE [azure-cli-prepare-your-environment-no-header.md](~/../docs/reusable-content/azure-cli/azure-cli-prepare-your-environment-no-header.md)]

1. Enable managed identity on an Azure resource, [such as an Azure virtual machines](~/identity/managed-identities-azure-resources/how-to-configure-managed-identities.md).

1. Find the object ID of the managed identity's service principal.

   - **For a system-assigned managed identity**, you can find the object ID on the Azure portal on the resource's **Identity** page. 
   - You can also use the following script to find the object ID. You'll need the resource ID of the resource you created in the previous step, which is available in the Azure portal on the resource's **Properties** page.

    ```azurecli
    resourceIdWithManagedIdentity="/subscriptions/{my subscription ID}/resourceGroups/{my resource group name}/providers/Microsoft.Compute/virtualMachines/{my virtual machine name}"
    
    oidForMI=$(az resource show --ids $resourceIdWithManagedIdentity --query "identity.principalId" -o tsv | tr -d '[:space:]')
    echo "object id for managed identity is: $oidForMI"
    ```

    - **For a user-assigned managed identity**, you can find the managed identity's object ID on the Azure portal on the resource's **Overview** page. You can also use the following script to find the object ID. You'll need the resource ID of the user-assigned managed identity.

    ```azurecli
    userManagedIdentityResourceId="/subscriptions/{my subscription ID}/resourceGroups/{my resource group name}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{my managed identity name}"
    
    oidForMI=$(az resource show --id $userManagedIdentityResourceId --query "properties.principalId" -o tsv | tr -d '[:space:]')
    echo "object id for managed identity is: $oidForMI"
    ```

1. Create a new application registration to represent the service that your managed identity sends a request to.
   -  If the API or service that exposes the app role grant to the managed identity already has a service principal in your Microsoft Entra tenant, skip this step.

1. Find the object ID of the service application's service principal. You can find this using the Azure portal. 
   - Go to Microsoft Entra ID and open the **Enterprise applications** page, then find the application and look for the **Object ID**. 
   - You can also find the service principal's object ID by its display name using the following script:

    ```azurecli
    appName="{name for your application}"
    serverSPOID=$(az ad sp list --filter "displayName eq '$appName'" --query '[0].id' -o tsv | tr -d '[:space:]')
    echo "object id for server service principal is: $serverSPOID"
    ```

    > [!NOTE]
    > Display names for applications are not unique, so you should verify that you obtain the correct application's service principal.

    Or you can find the Object ID by the unique Application ID for your application registration:

    ```azurecli
    appID="{application id for your application}"
    serverSPOID=$(az ad sp list --filter "appId eq '$appID'" --query '[0].id' -o tsv | tr -d '[:space:]')
    echo "object id for server service principal is: $serverSPOID"
    ```

1. Add an [app role](~/identity-platform/howto-add-app-roles-in-apps.md) to the application you created in the previous step. You can create the role using the Azure portal or using Microsoft Graph. For example, you could add an app role like this:

    ```json
    {
        "allowedMemberTypes": [
            "Application"
        ],
        "displayName": "Read data from MyApi",
        "id": "0566419e-bb95-4d9d-a4f8-ed9a0f147fa6",
        "isEnabled": true,
        "description": "Allow the application to read data as itself.",
        "value": "MyApi.Read.All"
    }
    ```

1. Assign the app role to the managed identity. You'll need the following information to assign the app role:
    * `managedIdentityObjectId`: the object ID of the managed identity's service principal, which you found in step 2.
    * `serverServicePrincipalObjectId`: the object ID of the server application's service principal, which you found in step 4.
    * `appRoleId`: the ID of the app role exposed by the server app, which you generated in step 5 - in the example, the app role ID is `00000000-0000-0000-0000-000000000000`.
   
1. Execute the following script to add the role assignment. This functionality isn't directly exposed on the Azure CLI and that a REST command is used here instead:

    ```azurecli
    roleguid="00000000-0000-0000-0000-000000000000"
    az rest -m POST -u https://graph.microsoft.com/v1.0/servicePrincipals/$oidForMI/appRoleAssignments -b "{\"principalId\": \"$oidForMI\", \"resourceId\": \"$serverSPOID\",\"appRoleId\": \"$roleguid\"}"
    ```
