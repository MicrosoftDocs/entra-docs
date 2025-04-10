---
title: How to deploy apps to Bleu Cloud using Git tooling
description: Learn how to set up and deploy applications to Bleu cloud using Git tooling, including creating release pipelines and adding various properties to your app.
services: active-directory
author: henrymbuguakiarie
manager: mwongerapk

ms.service: active-directory
ms.subservice: develop-1p
ms.workload: identity
ms.topic: how-to
ms.date: 04/04/2025
ms.author: henrymbugua
ms.reviewer: simonmuruka_microsoft
ms.custom: aaddev

#Customer intent: As a content developer, I want to learn how to set up and deploy applications to Bleu cloud using Git tooling, including creating release pipelines and adding various properties to my app so that I can manage app provisioning and deployment.
---

# Deploy apps to Bleu Cloud using Git tooling

You learn how to set up and deploy applications to Bleu cloud using Git tooling, including creating release pipelines and adding various properties to your app.

## Prerequisites

Before you read this article, it might be helpful to go through the following articles:

- [Set-ApplicationProperty sample commands](reference-app-changes-examples.md)
- [Request for directory tasksets](../graph-tasksets.md#request-for-directory-tasksets)
- [Read an app's directory state using the CLI](howto-read-app-directory-state-using-cli.md)

## Set up your local environment

Follow these steps to set up your local environment:

1. Clone the [repository](https://msazure.visualstudio.com/One/_git/AAD-FirstPartyApps?version=GBmaster&_a=contents) and set up your local environment using the generic docs at the root of the repo.
1. Change into the root directory of the repo: cd **AAD-FirstPartyApps**.
1. Run `.\Setup.ps1` to ensure everything is installed correctly. To run the setup script, open a new PowerShell window and execute:

    ```powershell
    .\Setup.ps1
    ```

   You should see a screen similar to:

   ![Screenshot of a PowerShell terminal window showing the execution of a script](media/howto-bleu-bootstrap-with-git-tooling/setup-ps1.png)

1. To create a new branch, you need to run a command similar to the following command:

    ```bash
    git checkout -b <YourServiceName>/<AppOwnerAlias>/bleuAppParamsExample origin/master 
    ```

    Replace `<YourServiceName>` with the actual service name and `<AppOwnerAlias>` with the actual alias of the app owner.

1. You can now run the New-AppPromotion command:

    ```powershell
    New-AppPromotion -appId "your app id here" -SourceEnv "Production" -TargetEnv "Bleu"
    ```

    The `New-AppPromotion` command promotes an application from one environment to another. Replace `"your app id here"` with your application's ID. This command promotes the application from the "Production" environment (`-SourceEnv`) to the "Bleu" environment (`-TargetEnv`).

    You should see a screen similar to:

    ![Screenshot showing Azure App Service deployment commands in a command-line interface](media/howto-bleu-bootstrap-with-git-tooling/azure-app-service-deployment-cli.png)

1. Open *AppReg.Parameters.Bleu.json* in your text editor. This JSON file was created using the `New-AppPromotion` command and includes configuration parameters from the `-SourceEnv`. The file contains the following properties:

    ```json
    {
      "ContentVersion": "1.0.0.0",
      "Parameters": {
        "identifierUris": {
          "value": []
        },
        "publicClient": {
          "value": {
            "redirectUris": []
          }
        },
        "spa": {
          "value": {
            "redirectUris": []
          }
        },
        "web": {
          "value": {
            "homePageUrl": null,
            "implicitGrantSettings": {
              "enableAccessTokenIssuance": false,
              "enableIdTokenIssuance": false
            },
            "logoutUrl": "https://localhost",
            "redirectUris": []
          }
        },
        "trustedSubjectNameAndIssuers": [],
        "signInAudience": {
          "value": "AzureADMultipleOrgs"
        },
        "appIdUri": {
          "value": []
        }
      }
    }
    ```

    Since our test app had few properties set, the JSON file is simple.

## Add properties to your app

Use commands like `Set-ApplicationProperty` and `Add-AADGraphTaskSet` to add properties to your app. This section includes examples to guide you through the process.

### Add a trusted certificate

To add a trusted certificate, use the `Set-ApplicationProperty` command. This command adds a trusted certificate to your app's configuration.

```powershell
Set-ApplicationProperty -AppId "6aa147eb-9c06-468b-8a8e-0848145159b9" -Env "Bleu" -Property "trustedSubjectNameAndIssuers" -NewValue '{"authorityId": "00000000-0000-0000-0000-000000000001","subjectName": "mysamplecert.chhow.fr"}' -ChangeType add -UseGradualRollout $false 
```

The `Set-ApplicationProperty` command adds a new property to an application in the Bleu environment. It specifically adds a trusted certificate subject name and issuer to the app with the ID `"6aa147eb-9c06-468b-8a8e-0848145159b9"`. The command sets the `"trustedSubjectNameAndIssuers"` property to:  

```json
{"authorityId": "00000000-0000-0000-0000-000000000001", "subjectName": "mysamplecert.chhow.fr"}
```  

The `ChangeType add` parameter indicates an addition, while `UseGradualRollout $false` ensures the change doesn't use a gradual rollout.  

**Note** that Bleu and new clouds don't support pinned certificates. Only SNI/MSI are supported as client credentials. Repeat this process for any other properties you want to add, such as `redirectUris` or `identifierUris`.

### Add task sets

Use the `Add-AADGraphTaskSet` command to add task sets to your app's configuration. Task sets play a key role in defining the service principal template. The `AADGraphTasksets.json` file contains the existing task sets for a given app. To add a task set, run the following command:

```powershell
Add-AADGraphTaskSet -AppId <your-app-id> -Env Bleu -TaskSetId <task-set-id> -Type <taskset-type> 
```

The `Add-AADGraphTaskSet` command adds a task set to your app's configuration. Replace `<your-app-id>` with your application's ID, `<task-set-id>` with the specific task set ID, and `<taskset-type>` with the task set type.

## Commit and Push Changes

After making changes to your app's configuration, commit and push the changes to your Git repository. Use the following commands:

```bash
git commit -m "sample message"
```

Then, push the changes:

```bash
git push --set-upstream origin <YourServiceName>/<AppOwnerAlias>/bleuAppParamsExample
```

Replace `<YourServiceName>` with the actual service name and `<AppOwnerAlias>` with the actual alias of the app owner.

Perform the Proof of Presence, get approval from at least one other app owner, and merge your branch. The ownership tab of your PR shows any required approvals, and the overall validation highlights any necessary tweaks.

Once you receive all required approvals and pass all validations, complete the PR to merge the branch into master. This step generates the artifacts needed to instantiate your app, SPT, and more.

## Deploy Changes to Bleu environment

To deploy the changes, create a release pipeline or add a stage to an existing one that deploys to Bleu. Follow this guide to structure the release pipeline: [Tutorial: Deploy application to national and air-gapped clouds](repo-national-clouds-deploy.md#deploy-the-application-to-air-gapped-clouds). For a full working example of the Bleu pipeline, refer to: [bleu-pipeline-test.yml](https://msazure.visualstudio.com/One/_git/AAD-FirstPartyApps?version=GBmaster&path=%2FCustomers%2FConfigs%2FAppReg%2Fc48bb140-c671-440d-a108-e1c9f69f4270%2Fbleu-pipeline-test.yml). If you already have a pipeline YAML file, don't create a new one. You can add this region directly to the existing file, such as [AAD-AzSupportCaseMgmt-PortalExtension.yml](https://msazure.visualstudio.com/DefaultCollection/One/_git/AAD-FirstPartyApps?path=/Customers/Configs/AppReg/e6694c91-1590-4e35-9bb7-b865c638b9c1/AAD-AzSupportCaseMgmt-PortalExtension.yml&_a=contents&version=GBmaster).

Once the pipeline runs successfully, visit the [Sovereign Release Manager (SRM)](https://srm.azure.com/#/ReleaseStatus/Latest) portal to check the status and progress of the deployment. Filter the releases using your service tree. The release pipeline can take about 3 hours as it copies the build artifacts to Bleu. It's a known issue that the OneBranch Infrastructure team is currently addressing. In the meantime, set timeoutIMinutes to 0 to prevent the pipeline from aborting after the default 60-minute.

MS Graph Pre-Authz and SPT deployments for Bleu are done daily. If you encounter a blocker, log a sev3 incident for Microsoft Entra ID First Party Apps\1p Git Mgmt. Prefix the incident title with [Bleu Buildout]. The service level agreement (SLA) for resolving this incident is one business day.

If you need a service principal provisioned in the tenant where your service operates, refer to this article for various provisioning methods: [Overview of service principals and app provisioning](../overview-of-service-principal-provisioning.md). For service principal creation in *FRME/Torus* infra tenants, you need to involve the tenant admin. You can do so by creating an incident for Production Tenant **Management\Prod** Tenants IcM path.

### Fixing the "Parameter File for Environment xxx Does Not Exist" Error

If you see the error **"Parameter file for environment xxx does not exist"** after running the `New-AppPromotion` command, it usually means the app doesn’t have a source environment file—typically for the Production environment.

To resolve this, make sure your app has a Production environment set up. App promotions use the Production environment as the baseline, so its absence triggers this error.

### Use PowerShell to check your App’s state in the Bleu environment

Follow these steps to check your app’s state in the Bleu environment:

  1. **Connect to the MSFT-AzVPN-MANUAL** network.

  1. **Register the Bleu environment**:

        Run this command to register the Bleu environment:

        ```powershell
        Add-AzEnvironment -Name "Bleu" -ServiceManagementUrl "https://management.core.sovcloud-api.fr/" -ActiveDirectoryAuthority "https://login.sovcloud-identity.fr/"
        ```

  1. **Login Using FRME Account**:

        Sign in with this command:

        ```powershell
        Connect-AzAccount -Environment "Bleu"
        ```

  1. **Import the Required PowerShell Module**:

        Use the following command to import the module:
  
        ```powershell
        Import-Module .\Internal\Tools\OceScripts\AppDeployment.psm1
        ```

  1. **Run the Get-FirstPartyApplication Command**:

        Check your app’s details in Bleu using:

        ```powershell
        Get-FirstPartyApplication -AppId "app-id"
        ```
