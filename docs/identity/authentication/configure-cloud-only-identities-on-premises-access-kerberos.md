---
title: Configure on-premises resource access for cloud-only identities with Microsoft Entra Kerberos (Preview)
description: Learn how to configure Microsoft Entra Kerberos so cloud-only users and agent users can access Kerberos-protected on-premises resources.
ms.topic: how-to
ms.date: 11/06/2026
ms.reviewer: Vimala
ai-usage: ai-assisted
# Customer intent: As an identity administrator, I want cloud-only identities to access Kerberos-protected on-premises resources by using Microsoft Entra Kerberos.
---

# Configure on-premises resource access for cloud-only identities with Microsoft Entra Kerberos (Preview)

Microsoft Entra Kerberos can issue a Kerberos service ticket that allows a cloud-only Microsoft Entra user or agent user to authenticate to a Kerberos-protected on-premises application or resource. The resource validates the ticket and uses the security identifiers (SIDs) in the ticket's Privilege Attribute Certificate (PAC) to authorize access through its existing Windows access control model.

In this article, *cloud-only user* refers to a user whose home tenant is the Microsoft Entra tenant configured to issue tickets for the resource and who has no corresponding Active Directory Domain Services (AD DS) user account. Agent users are covered separately in [Agent user support](#agent-user-support).

This article doesn't establish support for B2B guest identities. Guest access requires scenario-specific confirmation of the supported client, authentication flow, ticket issuance, and resource authorization.

This article shows you how to configure a proof-of-concept environment with:

- A Microsoft Entra joined Windows client.
- An AD DS domain.
- An AD DS joined Windows server that hosts a Kerberos-protected resource.
- A Microsoft Entra application registration that represents the resource.
- Microsoft Entra Cloud Sync for group and Kerberos key synchronization.
- Network connectivity between the client and the resource.

The procedures use a Server Message Block (SMB) file share as a worked example. Replace the example server name, service principal name (SPN), ports, and permissions with the values for your resource. For example, an SMB resource uses the `cifs` service class and TCP port 445; another application uses its own service class and network requirements.

> [!IMPORTANT]
> This feature is in preview. Confirm that your tenant and target resource support this preview, and validate the configuration in a test environment before you use it for production resources. A resource must support Kerberos authentication and authorization with the SIDs in the ticket PAC; these steps don't enable applications that require a password or a separate AD DS user account.

## Understand the authentication flow

Microsoft Entra ID authenticates the identity and issues a Kerberos service ticket for the target service. The application server decrypts and validates the ticket by using its local service key.

Authentication, authorization, and network connectivity are separate:

- **Authentication**: Microsoft Entra ID issues a Kerberos service ticket encrypted with key material associated with the target service. The target service uses its local key to decrypt and validate the ticket.
- **Authorization**: A valid ticket doesn't automatically grant access. The target service uses the user and group SIDs in the PAC to evaluate the share and NTFS access control lists (ACLs).
- **Network connectivity**: The client-to-server connection is independent of the ticket-issuance path. You can use any supported network connection, such as [Microsoft Entra Private Access](#step-6-configure-network-connectivity), that provides name resolution and TCP connectivity to the resource.

:::image type="content" source="media/configure-cloud-only-identities-on-premises-access-kerberos/cloud-only-identity-file-server-flow.png" alt-text="Diagram showing a cloud-only identity obtaining a Kerberos service ticket from Microsoft Entra ID and using it to access an on-premises SMB server." lightbox="media/configure-cloud-only-identities-on-premises-access-kerberos/cloud-only-identity-file-server-flow.png":::

The authentication flow works as follows:

1. The cloud-only identity signs in to a Microsoft Entra joined Windows device.
1. Windows obtains a Primary Refresh Token (PRT) and Cloud Ticket Granting Ticket (Cloud TGT) from Microsoft Entra ID.
1. The user opens the SMB file share, such as `\\WS1.contoso.com\share`.
1. The Windows Kerberos client uses the Cloud TGT to request a service ticket for the SMB service principal name (SPN), such as `cifs/WS1.contoso.com`.
1. Microsoft Entra ID locates the resource application associated with the SPN and reads its ticket configuration and synchronized service key.
1. Microsoft Entra ID resolves the configured user and group SIDs and constructs the PAC.
1. Microsoft Entra ID issues an AES-256 Kerberos service ticket for the SMB service.
1. Windows connects to the SMB server over TCP 445 and sends the ticket in a Simple and Protected GSSAPI Negotiation Mechanism (SPNEGO) Kerberos request.
1. The SMB server decrypts the ticket, validates the request, and reads the PAC.
1. When required, the SMB server uses its domain secure channel to contact a domain controller for PAC validation. This connection is separate from the client-to-server SMB path.
1. Windows constructs an access token from the SIDs in the PAC. The SMB server compares the SIDs with the share and NTFS ACLs.
1. The SMB server grants or denies access based on the ACL evaluation.
1. Windows reuses the cached service ticket until it expires.

If you use Microsoft Entra Private Access, the Global Secure Access client routes the SMB connection through the Private Access tunnel. A Private Network connector receives the connection and forwards TCP 445 traffic to the SMB server. The Kerberos authentication flow doesn't require Microsoft Entra Private Access.

## Agent user support

Microsoft Entra Kerberos supports agent users when they access Kerberos-protected resources that are configured to use Microsoft Entra Kerberos.

Agent users are managed in Microsoft Entra ID and don't have a corresponding user account in Active Directory Domain Services (AD DS). For these identities, the traditional AD DS Kerberos flow, which requires an AD DS user account to obtain a full AD TGT, isn't available.

Instead, an agent user can use the Cloud TGT to request a Kerberos service ticket from Microsoft Entra ID for a resource configured to use Microsoft Entra Kerberos.

For an Agent User, establish the Windows session by using the supported Agent User session flow for Windows 365 for Agents. The Agent User session must be established through the supported Agent User authentication flow and obtain a PRT and Cloud TGT before accessing the Kerberos-protected resource. A human-user password sign-in isn't supported as a substitute for establishing an Agent User session.

> [!IMPORTANT]
> Agent User access is a preview scenario and requires a supported Agent User environment and authentication flow. Before testing Microsoft Entra Kerberos access, complete the applicable Agent User and Windows 365 for Agents preview prerequisites and establish an Agent User Windows session. Don't use a human-user password sign-in as a substitute for the Agent User authentication flow.

The authentication flow is:

1. The agent user establishes a Windows session through the supported agent user authentication flow. For more information, see [Set up a Cloud PC to access on-premises applications and resources](#step-1-set-up-a-cloud-pc-to-access-on-premises-applications-and-resources).
1. As part of the session establishment, Microsoft Entra ID issues the PRT and Cloud TGT used by the Windows client for subsequent Microsoft Entra Kerberos authentication.
1. When the agent user accesses a resource configured to use Microsoft Entra Kerberos, Windows uses the Cloud TGT to request a service ticket for the target service.
1. Microsoft Entra ID issues a Kerberos service ticket by using the key material associated with the target service.
1. The client presents the service ticket to the target resource.
1. The target resource decrypts and validates the ticket by using its corresponding service key.
1. After authentication, the target resource uses the authorization information in the ticket, including applicable security identifiers (SIDs) in the privilege attribute certificate (PAC), to determine whether access is allowed.

For an on-premises resource, the resource must be configured to use Microsoft Entra Kerberos. This includes configuring the resource so that Microsoft Entra ID has the information and key material required to issue a service ticket that the target service can validate.

> [!IMPORTANT]
> Agent user support doesn't change the Kerberos routing behavior for other users. The Kerberos realm associated with the target resource determines the ticket flow. Resources configured to use Microsoft Entra Kerberos use the Microsoft Entra Kerberos ticket flow, while resources associated with an AD DS realm continue to use the traditional AD DS Kerberos flow.

For more information, see [How the Kerberos ticket flow is selected](kerberos.md#how-the-kerberos-ticket-flow-is-selected).

Kerberos ticket issuance and network connectivity to the target resource are separate. The client must have network connectivity and name resolution for the target resource. When you use Microsoft Entra Private Access, the Global Secure Access client can provide the network path to the on-premises resource.

## Prerequisites

Before you begin, make sure that you have:

- A Microsoft Entra tenant with access to this Microsoft Entra Kerberos preview.
- A supported Microsoft Entra joined Windows client. Review [Supported Windows versions for cloud-only identities](kerberos.md#supported-windows-versions-for-cloud-only-identities) and confirm the requirements for your target workload and agent execution environment.
- An on-premises AD DS domain with working Domain Name System (DNS) resolution.
- A Windows server that's joined to AD DS and hosts a Kerberos-protected resource.
- A unique SPN registered on the AD DS account that runs the service. For an SMB file share, an example SPN is `cifs/WS1.contoso.com`.
- A Microsoft Entra Cloud Sync provisioning agent that can access the resource object in AD DS.
- Permissions to create or reuse an AD DS security group and grant it access to the resource.
- A supported network path from the client to the resource.
- Administrative access to configure Microsoft Entra Kerberos trust, the resource application, and group source of authority. Review the role and permission requirements in the linked configuration articles before you begin.
- The Active Directory and Microsoft Graph PowerShell modules for the PowerShell examples.
- The following Microsoft Graph permissions for the administrator who configures Kerberos key synchronization:

    - `Synchronization.Read.All`.
    - `Synchronization.ReadWrite.All`.
    - `Application.ReadWrite.All`.
    - `Directory.ReadWrite.All`.

Use administrator accounts and Microsoft Graph permissions appropriate to each task. Group verification uses `Group.Read.All`, and key verification uses `Application.Read.All`. Transferring group source of authority has additional permission requirements described in [Configure group source of authority](../hybrid/how-to-group-source-of-authority-configure.md#prerequisites).

> [!NOTE]
> The resource server must be joined to AD DS. It doesn't need to be Microsoft Entra joined or Microsoft Entra hybrid joined.

## Step 1: Set up a Cloud PC to access on-premises applications and resources

Many organizations rely on applications and data that remain on their private networks. An agent might need to access a file on an on-premises file share, work with an internal application, or complete a task in a legacy application that doesn't provide an API.

Windows 365 for Agents provides a managed Cloud PC where the agent can perform this work. You can configure access to supported on-premises resources and control which resources the agent can use. When a task requires interaction with a browser or desktop application, the agent can use the application's user interface from the Cloud PC.

For an agent workload, complete the following steps. If you're configuring access for a cloud-only human user on an existing supported Windows client, continue to [step 2](#step-2-prepare-the-on-premises-environment).

1. Set up a Windows 365 for Agents Cloud PC pool that the agent can use. Configure billing and create a provisioning policy for the Cloud PCs. For prerequisites and setup instructions, see [Create a provisioning policy for Windows 365 for Agents](/windows-365/agents/create-provisioning-policy-agents).
1. Confirm that the Cloud PC is Microsoft Entra joined and meets the Windows version requirements in [Prerequisites](#prerequisites).

Configure the private network path and, if you use Microsoft Entra Private Access, install the Global Secure Access client in [step 6](#step-6-configure-network-connectivity). Before you test Kerberos access, establish the agent user's Windows session through the supported agent user authentication flow described in [Agent user support](#agent-user-support).

### Troubleshoot Cloud PC setup

For Cloud PC issues, see [Troubleshoot Windows 365](/windows-365/enterprise/troubleshooting). For agent pool provisioning failures or warnings, see [Troubleshoot Windows 365 for Agents provisioning errors](/troubleshoot/windows-365/windows-365-agents-pool-errors).

These articles address the Cloud PC environment. Use [Troubleshoot network connectivity](#troubleshoot-network-connectivity) for the Microsoft Entra Private Access network path and [Troubleshoot Microsoft Entra Kerberos](troubleshoot-microsoft-entra-kerberos.md) for ticket acquisition.

## Step 2: Prepare the on-premises environment

Prepare the existing on-premises application for Microsoft Entra Kerberos by identifying the Kerberos-protected resource and its SPN. Configure the AD DS security group used to authorize access, and apply that group to the application's existing access control lists (ACLs), as described in step 3.

### Configure Microsoft Entra Kerberos trust

Configure Microsoft Entra Kerberos trust for the AD DS domain. This configuration establishes an inbound trust relationship in which AD DS trusts Microsoft Entra ID as a Kerberos Key Distribution Center (KDC).

For instructions, see [Configure Microsoft Entra Kerberos trust](configure-microsoft-entra-kerberos-trust.md).

### Configure the Kerberos-protected resource

1. Confirm that the resource server is joined to the AD DS domain.
1. Configure the application or resource to use Kerberos authentication and its existing SID-based authorization mechanism.
1. Confirm that DNS resolves the server's fully qualified domain name (FQDN) from the client.
1. Identify the AD DS account that runs the service, and register its SPN on that account. For an SMB file share, the following example registers `cifs/WS1.contoso.com` on the `WS1` computer account:

    ```console
    setspn -S cifs/WS1.contoso.com WS1
    ```

1. Verify the SPNs registered on the service account. For the SMB example:

    ```console
    setspn -L WS1
    ```

> [!IMPORTANT]
> Each SPN must uniquely identify the account that runs the Kerberos-protected service. Duplicate or incorrect SPNs can cause Kerberos authentication to fail.

For more information, see [Service principal names](/windows/win32/ad/service-principal-names) and [How to configure SPNs](/windows-server/identity/ad-ds/manage/how-to-configure-spn?tabs=add%2Caduc).

## Step 3: Configure the authorization group

Use an AD DS security group for access to the on-premises application, and synchronize the group to Microsoft Entra ID. Moving management of the group to Microsoft Entra ID allows cloud-only users and agent users to become members while preserving the group's existing on-premises SID. The application can continue using its existing group and SID-based authorization model when those identities access the resource through Microsoft Entra Kerberos.

### Create and synchronize the group

1. Identify an existing AD DS security group that authorizes access to the resource, or create one. For example:

    ```powershell
    New-ADGroup `
        -Name "Kerberos resource users" `
        -SamAccountName "KerberosResourceUsers" `
        -GroupCategory Security `
        -GroupScope Global
    ```

1. Configure the on-premises application or resource to authorize the security group by using its existing access control mechanism. Grant the group the permissions required for access.

    For example, for an SMB file share, add the group to the share and NTFS ACLs. For another Kerberos-protected application, configure the group in the application's existing group or SID-based authorization policy.
1. Configure Microsoft Entra Cloud Sync to provision the group to Microsoft Entra ID. For more information, see [Configure Microsoft Entra Cloud Sync](../hybrid/cloud-sync/how-to-configure.md).
1. Wait for synchronization to finish.
1. Verify that the synchronized group has both a cloud SID and an on-premises SID:

    ```powershell
    Connect-MgGraph -Scopes "Group.Read.All"

    Get-MgGroup `
        -Filter "displayName eq 'Kerberos resource users'" `
        -Property Id,DisplayName,SecurityEnabled,SecurityIdentifier,OnPremisesSecurityIdentifier,OnPremisesSyncEnabled |
        Format-List
    ```

    Confirm that `OnPremisesSyncEnabled` is `True` and that `SecurityIdentifier` and `OnPremisesSecurityIdentifier` contain values. If the query returns multiple groups with the same display name, identify the intended group by its object ID. Record that ID and `OnPremisesSecurityIdentifier` before you transfer its source of authority.

### Transfer the group's source of authority

By default, membership for a synchronized group is managed in AD DS, so you can't add cloud-only identities directly in Microsoft Entra ID. Transfer the group's source of authority to Microsoft Entra ID to manage its membership in the cloud while preserving its on-premises SID.

1. Follow [Convert the source of authority for a test group](../hybrid/how-to-group-source-of-authority-configure.md#convert-soa-for-a-test-group), and verify that `isCloudManaged` is `true`.
1. Add the cloud-only users or agent users that require access to the group.
1. Confirm that the group's `OnPremisesSecurityIdentifier` matches the value you recorded before the transfer.
1. Confirm that the on-premises application or resource continues to reference the security group's on-premises SID for authorization. This check ensures that the existing SID-based access control configuration remains in place.

    For example, for an SMB file share, confirm that the group is still represented by its on-premises SID in both the share permissions and NTFS ACLs.

## Step 4: Configure Microsoft Entra Kerberos for on-premises resources

Microsoft Entra configuration creates a cloud representation of the existing on-premises Kerberos application and associates it with the application's SPN. In step 5, you synchronize the resource's Kerberos key to Microsoft Entra ID so that its KDC can issue service tickets that the on-premises server can decrypt.

Configure group claims so that the ticket PAC contains the security-group SIDs required by the application's existing Windows authorization model. A cloud-only user or agent user can then authenticate through Microsoft Entra Kerberos while the application continues to use its existing AD DS group and ACL-based authorization model.

### Create the resource application

Create an application registration that represents the Kerberos-protected on-premises resource.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).
1. Browse to **Entra ID** > **App registrations**.
1. Select **New registration**.
1. Enter a name for the resource application, and then select **Register**.
1. Record the application (client) ID and object ID.
1. Open the application manifest, set `api.requestedAccessTokenVersion` to `2`, and save the manifest.
1. Select **Expose an API**.
1. Next to **Application ID URI**, select **Add**.
1. Enter an application ID URI that includes the application (client) ID and the resource SPN. For the SMB example:

    ```text
    api://{application-client-id}/cifs/WS1.contoso.com
    ```

1. Save the application ID URI.
1. Update the resource application's `tags` collection to associate the application with the resource SPN. Use one of the following options:

    - **Microsoft Entra admin center**: Open the application manifest and add the `KerberosSync:<SPN>` value to its `tags` collection. For the SMB example:

        ```json
        "tags": [
          "KerberosSync:cifs/WS1.contoso.com"
        ]
        ```

    - **Microsoft Graph PowerShell**: Connect with the `Application.ReadWrite.All` permission, retrieve the resource application, and update its tags:

        ```powershell
        Connect-MgGraph -Scopes "Application.ReadWrite.All"

        $app = Get-MgApplication -Filter "displayName eq 'My Application'"

        if (@($app).Count -ne 1) {
            throw "Expected exactly one resource application. Retrieve it by its application registration object ID."
        }

        Update-MgApplication `
            -ApplicationId $app.Id `
            -Tags @("Tag1", "Tag2", "KerberosSync:<SPN>")
        ```

        Replace `My Application` with the resource application's display name and `<SPN>` with the resource SPN, such as `cifs/WS1.contoso.com`. If the display name isn't unique, retrieve the application with `Get-MgApplication -ApplicationId "<application-registration-object-id>"` instead.

        The `-Tags` parameter replaces the application's existing tags. Replace `Tag1` and `Tag2` with the complete set of other application tags required in your environment. If no other tags are required, include only the `KerberosSync:<SPN>` value.

    > [!WARNING]
    > Configure only one distinct `KerberosSync:<SPN>` tag on each resource service principal. The current key-synchronization implementation excludes a service principal from matching when another distinct `KerberosSync:` tag is present. This can prevent subsequent key updates even though the configuration can be saved.
    >
    > Use separate resource applications and corresponding service principals for separate key-sync mappings, such as CIFS and MSSQLSvc.

1. If you updated the manifest, save your changes. The Microsoft Graph PowerShell update doesn't require a separate save.

The SPN in the application ID URI and `KerberosSync` tag must exactly match the SPN registered for the resource.

Record the **Object ID** of the corresponding enterprise application under **Entra ID** > **Enterprise applications**. This ID identifies the resource service principal for key verification in step 5. It isn't the object ID of the application registration.

### Configure group SID claims

Configure the resource application to include the required group SIDs in Microsoft Entra Kerberos service tickets.

For instructions, see [Configure optional group SID claims for Microsoft Entra Kerberos tickets](configure-optional-group-claims-kerberos.md).

For a resource that authorizes access with the existing AD DS group SID:

1. Include `hybrid_group_onpremises_sids` in the `groups` claim's `additionalProperties` under `optionalClaims.kerberosTicket`. This selector requests the group's original on-premises SID.
1. Use `ApplicationGroup` when possible, and assign the authorization group to the resource's enterprise application. Only assigned groups that the identity belongs to are eligible in this scope.
1. Request other SID categories only when the resource requires them. A cloud group SID isn't a substitute for the on-premises SID in the resource's existing ACLs.

Limiting the group scope reduces ticket size and follows least-privilege principles.

## Step 5: Synchronize the resource Kerberos key

Microsoft Entra ID must have the resource's Kerberos service key so it can issue a ticket that the on-premises resource server can decrypt. The AD-to-Microsoft Entra Kerberos key synchronization process uses the Microsoft Entra Cloud Sync provisioning agent to synchronize the key from the AD DS account that owns the resource SPN to the corresponding Microsoft Entra resource.

### Confirm that the resource is eligible

1. Review the SPNs registered on the AD DS account that runs the service. For the SMB example:

    ```console
    setspn -L WS1
    ```

1. Check whether the AD DS account is eligible for the key-synchronization scope. If that scope excludes accounts with `RestrictedKrbHost` SPNs, check for these SPNs on the account. For the SMB example, remove the following SPNs only if no workload depends on them:

    ```console
    setspn -D RestrictedKrbHost/WS1 WS1
    setspn -D RestrictedKrbHost/WS1.contoso.com WS1
    ```

1. Confirm that the resource's AD DS object isn't marked as a critical system object (`isCriticalSystemObject = TRUE`).

> [!CAUTION]
> Remove an SPN only when you have confirmed that no workload depends on it and that the key-synchronization scope requires its removal. Don't remove a required SPN just to make an account eligible for synchronization.

### Create the synchronization configuration

The following examples use the Microsoft Graph beta endpoint. Send the requests with a Microsoft Graph access token that has the required permissions. Replace all values in braces and the example domain with values from your environment.

The provisioning application created here manages key synchronization. It's separate from the resource application that you created in step 4.

1. Instantiate the AD-to-Microsoft Entra Kerberos provisioning application:

    ```http
    POST https://graph.microsoft.com/beta/applicationTemplates/4617df1a-9dec-4a66-9a3b-61677870ec5c/instantiate
    Content-Type: application/json

    {
      "displayName": "Active Directory to Microsoft Entra ID Kerberos Provisioning"
    }
    ```

1. Record `servicePrincipal.id` from the response as `{servicePrincipalId}`. If you need to retrieve it again, use:

    ```http
    GET https://graph.microsoft.com/beta/servicePrincipals?$filter=displayName eq 'Active Directory to Microsoft Entra ID Kerberos Provisioning'
    ```

    If more than one result has the same display name, use the service principal that the instantiate request created.

1. Create the synchronization job:

    ```http
    POST https://graph.microsoft.com/beta/servicePrincipals/{servicePrincipalId}/synchronization/jobs
    Content-Type: application/json

    {
      "templateId": "AS2AADApplicationKerberosKeysSynchronization"
    }
    ```

    Record the returned job `id` as `{jobId}`.

1. Add the AD DS domain information:

    ```http
    PUT https://graph.microsoft.com/beta/servicePrincipals/{servicePrincipalId}/synchronization/secrets
    Content-Type: application/json

    {
      "value": [
        {
          "key": "Domain",
          "value": "{\"domain\":\"contoso.com\"}"
        }
      ]
    }
    ```

1. Start the synchronization job:

    ```http
    POST https://graph.microsoft.com/beta/servicePrincipals/{servicePrincipalId}/synchronization/jobs/{jobId}/start
    ```

1. Allow time for AD DS replication and the next provisioning cycle. The provisioning agent:

    1. Identifies eligible AD DS objects that own a configured SPN.
    1. Associates the object with the Microsoft Entra application by using the SPN and `KerberosSync:{SPN}` tag.
    1. Synchronizes the Kerberos key for the corresponding resource.

### Verify key synchronization

Check the synchronization job's status and provisioning logs before you test access:

```http
GET https://graph.microsoft.com/beta/servicePrincipals/{servicePrincipalId}/synchronization/jobs/{jobId}
```

Resolve any provisioning errors. A started job doesn't by itself confirm that the resource key was synchronized.

Use Microsoft Graph PowerShell to inspect the resource service principal's key credentials. Use the enterprise application's object ID recorded in step 4, not the provisioning application's service principal ID:

```powershell
Connect-MgGraph -Scopes "Application.Read.All"

(Get-MgServicePrincipal `
    -ServicePrincipalId "{resource-service-principal-object-id}" `
    -Property Id,AppId,DisplayName,KeyCredentials).KeyCredentials |
    Select-Object DisplayName,Type,Usage,CustomKeyIdentifier,StartDateTime,EndDateTime
```

Confirm that the `KeyCredentials` collection contains the synchronized resource key. Other credentials can also appear in this collection, so a nonempty collection alone isn't sufficient. Use the provisioning logs and the access test to confirm synchronization and ticket decryption.

## Step 6: Configure network connectivity

Ensure that the client can securely reach and resolve the on-premises application or resource. If you use Microsoft Entra Private Access, configure the required connector and application segment to route traffic to the private resource.

For example, for an SMB file share, ensure connectivity to the file server on TCP 445, and access the resource by using its FQDN, such as `\\WS1.contoso.com\share`. For another application, allow the ports that the application requires.

If you use Microsoft Entra Private Access:

1. Enable the Private Access traffic forwarding profile. For more information, see [Manage the Private Access traffic forwarding profile](~/global-secure-access/how-to-manage-private-access-profile.md).
1. Create a connector group, install a Private Network connector, and confirm that the connector is active.
1. Configure a Quick Access application with an application segment for the resource's FQDN and required ports. For an SMB file share, include the file server and TCP port 445. For more information, see [Configure Quick Access](~/global-secure-access/how-to-configure-quick-access.md).
1. Assign the required users or groups to the Quick Access application. This assignment controls network access and is separate from assigning the authorization group to the Kerberos resource application in step 4.
1. Install the [Global Secure Access client for Windows](~/global-secure-access/how-to-install-windows-client.md), and confirm that Private Access is active. Review the licensing and client prerequisites in the linked articles.

Verify connectivity from the client. For the SMB example:

```powershell
Test-NetConnection -ComputerName WS1.contoso.com -Port 445
```

Confirm that `TcpTestSucceeded` is `True`. If name resolution fails, verify your DNS configuration. For Microsoft Entra Private Access, see [Private DNS configuration](~/global-secure-access/how-to-configure-quick-access.md#add-private-dns-suffixes).

Microsoft Entra Private Access provides the network path; it doesn't replace the Kerberos trust, key synchronization, or authorization configuration.

### Troubleshoot network connectivity

If you experience network connectivity issues with Microsoft Entra Private Access, use the article that matches the symptom:

- If you can't install or configure the Microsoft Entra private network connector, see [Troubleshoot problems installing the Microsoft Entra private network connector](~/global-secure-access/troubleshoot-connectors.md). The article covers installation, registration, connectivity, certificates, and connector functionality.
- If the connector is configured but users can't access an on-premises resource, see [Troubleshoot application access](~/global-secure-access/troubleshoot-app-access.md). The article covers application traffic, connectivity requirements, DNS resolution, and Microsoft Entra Private Access resource-access failures.

## Step 7: Configure the Windows client

Configure the Windows client to retrieve and use Microsoft Entra Kerberos tickets when accessing the on-premises application. Enable the required Kerberos client policies, configure resource and realm discovery, and verify that the client can obtain a Kerberos service ticket for the target application.

For example, for an SMB file share, access the server by using its FQDN, and use `klist` to confirm that a `cifs/<server-FQDN>` Kerberos service ticket was issued.

### Enable Cloud Kerberos ticket retrieval

For managed devices, enable [CloudKerberosTicketRetrievalEnabled](/windows/client-management/mdm/policy-csp-kerberos#cloudkerberosticketretrievalenabled) through Microsoft Intune or the **Allow retrieving the Azure AD Kerberos Ticket Granting Ticket during logon** Group Policy setting.

For a test device, run the following command from an elevated command prompt:

```console
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa\Kerberos\Parameters" /v CloudKerberosTicketRetrievalEnabled /t REG_DWORD /d 1 /f
```

Sign out and sign back in, or restart the device.

### Configure and verify the Kerberos realm mapping

Map the resource host name to the `KERBEROS.MICROSOFTONLINE.COM` realm by using **Computer Configuration** > **Administrative Templates** > **System** > **Kerberos** > **Define host name-to-Kerberos realm mappings**, or the Microsoft Intune [ADMX_Kerberos/HostToRealm policy](/windows/client-management/mdm/policy-csp-admx-kerberos#hosttorealm).

For the SMB example, configure `KERBEROS.MICROSOFTONLINE.COM` as the realm and `WS1.contoso.com` as the host name. Prefer a mapping for the specific resource host over a domain-wide mapping that could redirect requests for unrelated services.

Use the following command to inspect the configured mappings:

```console
reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\Kerberos\domain_realm" /s
```

For more information, see [Realm mapping](kerberos.md#realm-mapping).

Also apply the KDC proxy configuration described in [Configure clients to retrieve Kerberos tickets](configure-microsoft-entra-kerberos-trust.md#configure-clients-to-retrieve-kerberos-tickets). Use your Microsoft Entra tenant ID in the proxy mapping.

## Test access

1. Start a session on the Microsoft Entra joined client for a cloud-only user or agent user that's a member of the authorization group. Use the supported Windows sign-in flow for that identity.
1. Confirm that the device has a PRT:

    ```console
    dsregcmd /status
    ```

    Verify that `AzureAdPrt` is `YES`.

1. In your test session, clear existing Kerberos tickets:

    ```console
    klist purge
    ```

    Clearing cached tickets can interrupt existing authenticated connections. Use a test session rather than an active production session.

1. Confirm the signed-in identity:

    ```console
    whoami /upn
    ```

1. Access the on-premises application or resource by using the FQDN associated with its SPN. For an SMB file share:

    ```console
    net use \\WS1.contoso.com\share
    ```

1. Inspect the Kerberos ticket cache:

    ```console
    klist
    ```

1. Confirm that a ticket exists for the target resource SPN and that the ticket uses AES-256 encryption. For the SMB example, the SPN is `cifs/WS1.contoso.com`.
1. Perform an operation allowed by the group's resource permissions, and confirm that it succeeds. For an SMB file share, test the configured read or write operation.
1. Repeat the test with a test identity that isn't authorized to access the resource, and confirm that access is denied. Account for any other groups or permissions that could grant access.

## Validate authorization

Use the resource's authorization logs to confirm that the expected group SID is used for access decisions.

For a Windows resource server, run the following commands from an elevated command prompt to enable successful logon and group membership auditing:

```console
auditpol /set /subcategory:"Logon" /success:enable
auditpol /set /subcategory:"Group Membership" /success:enable
auditpol /get /subcategory:"Logon"
auditpol /get /subcategory:"Group Membership"
```

After the identity accesses the resource, review Windows security event 4627 on the server, and correlate it with event 4624 by using the logon ID. Confirm that the group membership data contains the authorization group's on-premises SID. Event 4627 records group membership, not the complete ticket PAC.

For an SMB file share, also confirm that the same SID has the required permissions in both the share and NTFS ACLs.

## Troubleshoot

For a step-by-step diagnostic workflow, see [Troubleshoot Microsoft Entra Kerberos](troubleshoot-microsoft-entra-kerberos.md). For Cloud PC or network issues, use [Troubleshoot Cloud PC setup](#troubleshoot-cloud-pc-setup) or [Troubleshoot network connectivity](#troubleshoot-network-connectivity).

| Symptom | Cause or action |
| --- | --- |
| The client doesn't receive a Cloud TGT. | Confirm that the device is Microsoft Entra joined, `AzureAdPrt` is `YES`, and `CloudKerberosTicketRetrievalEnabled` is enabled. |
| No service ticket is issued for the resource SPN. | Confirm that the application ID URI, `KerberosSync` tag, and AD DS SPN match. Check the host-to-realm mapping and tenant-specific KDC proxy configuration. |
| The resource server can't decrypt the ticket. | Check provisioning logs and confirm that the current key for the AD DS account that owns the SPN was synchronized. Inspect the resource service principal's `keyCredentials`, and request a new ticket after synchronization. |
| The ticket is issued, but access is denied. | Confirm that `hybrid_group_onpremises_sids` is configured, the group is assigned when you use `ApplicationGroup`, and the expected on-premises group SID is in the PAC. Verify that the resource's authorization policy references the same SID. For SMB, check both the share and NTFS ACLs. |
| The group doesn't include cloud-only identities. | Confirm that the group's source of authority was transferred to Microsoft Entra ID and that the identities are direct or supported members of the group. |
| The client can't reach the resource server. | Verify DNS resolution and connectivity to the application's required ports. For SMB, verify TCP 445. If you use Microsoft Entra Private Access, verify the traffic profile, application segment, connector, and client status. |
| The service ticket uses an unexpected encryption type. | Confirm that the current resource key was synchronized and request a new ticket after clearing the ticket cache. |

## Security guidance

- Test the configuration with a nonproduction resource and a limited security group.
- Use `ApplicationGroup` and assign only the groups required by the resource.
- Grant the synchronization permissions only to administrators who configure and manage the provisioning job.
- Protect the Cloud Sync provisioning agent and monitor its provisioning logs.
- Use unique SPNs and monitor for duplicate SPN registration.
- Apply least-privilege permissions to the resource's authorization policy. For SMB, configure both share and NTFS permissions.
- Monitor Microsoft Entra sign-in logs and Windows security events during deployment.

## Related content

- [Introduction to Microsoft Entra Kerberos](kerberos.md)
- [Configure optional group SID claims for Microsoft Entra Kerberos tickets](configure-optional-group-claims-kerberos.md)
- [Configure Microsoft Entra Kerberos trust](configure-microsoft-entra-kerberos-trust.md)
- [Troubleshoot Microsoft Entra Kerberos](troubleshoot-microsoft-entra-kerberos.md)
- [Use Microsoft Entra Kerberos authentication for hybrid identities](howto-authentication-passwordless-security-key-on-premises.md)
- [Configure Microsoft Entra Cloud Sync](../hybrid/cloud-sync/how-to-configure.md)
- [Configure group source of authority](../hybrid/how-to-group-source-of-authority-configure.md)
