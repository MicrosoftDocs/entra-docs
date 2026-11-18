---
title: Troubleshoot Microsoft Entra Kerberos
description: Learn how to diagnose Microsoft Entra Kerberos ticket acquisition, key synchronization, and resource access issues.
ms.topic: troubleshooting
ms.date: 11/06/2026
ai-usage: ai-assisted
# Customer intent: As an identity administrator, I want to diagnose Microsoft Entra Kerberos ticket acquisition, key synchronization, and resource access issues.
---

# Troubleshoot Microsoft Entra Kerberos

Microsoft Entra Kerberos allows Microsoft Entra ID to act as a cloud-based Key Distribution Center (KDC). Depending on the scenario, Windows can receive a Cloud Ticket Granting Ticket (Cloud TGT) to request service tickets from Microsoft Entra ID or a partial TGT that an on-premises Active Directory Domain Services (AD DS) domain controller exchanges for a full AD DS TGT.

This article focuses on Kerberos authentication and ticket acquisition. Obtaining a service ticket doesn't by itself confirm that the resource can validate the ticket or that the identity is authorized. If ticket issuance succeeds but resource access fails, check server-side ticket validation, network connectivity, and resource authorization separately.

## Before you begin

Identify the ticket flow that your resource uses:

- Resources configured to use Microsoft Entra Kerberos use the Cloud TGT to request a service ticket from Microsoft Entra ID. This includes supported cloud services and on-premises resources configured for the cloud-only identity preview.
- Resources that use traditional AD DS Kerberos require an AD DS TGT. For supported hybrid identities, Windows exchanges the partial TGT with an on-premises domain controller before requesting the service ticket. This flow requires connectivity to AD DS and isn't available to a cloud-only identity that has no AD DS account.

For more information, see [How the Kerberos ticket flow is selected](kerberos.md#how-the-kerberos-ticket-flow-is-selected). Check the supported device, Windows version, and sign-in requirements for your workload before you test.

Run the client commands in the affected user's Windows session. Don't use a different administrator account to inspect the user's sign-in state or ticket cache. For an agent user, first establish a session through the supported agent user authentication flow. For prerequisites, see [Agent user support](configure-cloud-only-identities-on-premises-access-kerberos.md#agent-user-support).

## Step 1: Verify the device and sign-in state

On the affected Windows device, open a command prompt in the user's session and run:

```console
dsregcmd /status
```

Review **Device State** and **SSO State**. For a Microsoft Entra joined or Microsoft Entra hybrid joined device, verify that `AzureAdJoined` is `YES`. Also verify that `AzureAdPrt` is `YES`.

The following shortened example shows the expected values for a Microsoft Entra joined client that has a Cloud TGT:

```output
AzureAdJoined : YES
AzureAdPrt    : YES
CloudTgt      : YES
```

The Kerberos fields describe different ticket states:

| Field | Meaning |
| --- | --- |
| `CloudTgt : YES` | A Cloud Kerberos ticket for cloud-resource access is present for the signed-in user. |
| `OnPremTgt : YES` | A Cloud Kerberos ticket for on-premises resource access is present for the signed-in user. This value doesn't confirm that the partial TGT was exchanged for a full AD DS TGT. |

Don't require `OnPremTgt` for a cloud-only identity that uses the Cloud TGT flow. Use the field names in the **SSO State** section; diagnostic fields can differ by Windows version and output section.

If `AzureAdPrt` is `NO`, troubleshoot device registration and the Primary Refresh Token (PRT) before continuing. If the expected `CloudTgt` is `NO`, continue to step 2 and verify the client configuration and supported sign-in method.

For field definitions and PRT diagnostics, see [Troubleshoot devices by using the dsregcmd command](../devices/troubleshoot-device-dsregcmd.md#sso-state).

## Step 2: Verify the Cloud TGT

In the same Windows session, run:

```console
klist cloud_debug
```

Review whether Cloud Kerberos is enabled and whether the client has the expected Cloud TGT. For background, see [Cloud TGT issuance](kerberos.md#cloud-tgt-issuance).

If the output includes the following value, check whether the ticket retrieval policy was applied:

```output
Cloud Kerberos enabled by policy: 0
```

Enable the [CloudKerberosTicketRetrievalEnabled policy](/windows/client-management/mdm/policy-csp-kerberos#cloudkerberosticketretrievalenabled) with a value of `1` through Microsoft Intune, or enable **Allow retrieving the Azure AD Kerberos Ticket Granting Ticket during logon** under **Computer Configuration** > **Administrative Templates** > **System** > **Kerberos** in Group Policy.

Apply the policy and restart the device as described in the [client configuration guidance](configure-cloud-only-identities-on-premises-access-kerberos.md#enable-cloud-kerberos-ticket-retrieval). Establish a new session by using the supported sign-in flow, and check the ticket state again. Enabling ticket retrieval doesn't replace the workload's identity and authentication prerequisites.

If a partial TGT is missing in a hybrid AD DS scenario, verify the Microsoft Entra Kerberos server object and configuration in AD DS. For instructions, see [View and verify the Microsoft Entra Kerberos server](howto-authentication-passwordless-security-key-on-premises.md#view-and-verify-the-microsoft-entra-kerberos-server). Don't create or change a Trusted Domain Object (TDO) unless the scenario requires one.

## Step 3: Request a service ticket

After you verify the required TGT state, test whether Windows can obtain a service ticket for the resource. For a Server Message Block (SMB) resource, use its Common Internet File System (CIFS) service principal name (SPN):

```console
klist get cifs/<server-fqdn>
```

Replace `<server-fqdn>` with the fully qualified domain name (FQDN) that the application or SMB client uses. For another service, use its service class and resource SPN.

Inspect the ticket cache:

```console
klist
```

Verify that a ticket for the expected resource SPN appears. Test with the same host name that the application uses, including any alias. A ticket requested for a different host name doesn't validate the application's Kerberos configuration.

For command syntax, see [klist](/windows-server/administration/windows-commands/klist).

## Step 4: Check the configuration if no service ticket is issued

If the required TGT is available but the service-ticket request fails, check the realm mapping, resource name, and configuration for the selected ticket flow.

### Verify the host-to-realm mapping

Windows uses host-to-realm mappings to determine which Kerberos realm handles a resource. You can configure mappings through:

- Group Policy: **Computer Configuration** > **Administrative Templates** > **System** > **Kerberos** > **Define host name-to-Kerberos realm mappings**.
- Microsoft Intune: The [ADMX_Kerberos/HostToRealm policy CSP](/windows/client-management/mdm/policy-csp-admx-kerberos#hosttorealm).

For a resource configured to use Microsoft Entra Kerberos, the expected realm is:

```text
KERBEROS.MICROSOFTONLINE.COM
```

Verify that the resource host name is mapped to this realm. Don't redirect resources that require traditional AD DS Kerberos to the Microsoft Entra Kerberos realm. Prefer a specific host mapping over a domain-wide mapping that could affect unrelated services.

For more information, see [Realm mapping](kerberos.md#realm-mapping).

### Verify the resource name and SPN

Confirm that the host name used by the client matches the name in the Kerberos configuration. For SMB, the requested SPN is `cifs/<server-fqdn>`.

Verify that the SPN is registered on the account that runs the target service and isn't duplicated on another account. For instructions, see [How to configure SPNs](/windows-server/identity/ad-ds/manage/how-to-configure-spn).

### Verify the configuration for the selected flow

For an on-premises resource configured for the cloud-only identity preview, confirm that the resource application, SPN association, tenant-specific KDC proxy mapping, and synchronized service key are configured. Use [Configure on-premises resource access for cloud-only identities](configure-cloud-only-identities-on-premises-access-kerberos.md).

For a hybrid identity accessing a resource in an AD DS realm, verify connectivity to an on-premises domain controller and the partial-TGT exchange prerequisites. Use [Enable passwordless security key sign-in to on-premises resources](howto-authentication-passwordless-security-key-on-premises.md).

For cloud services, follow the target workload's Microsoft Entra Kerberos requirements and troubleshooting guidance.

## Step 5: Identify the next troubleshooting area

Use the results to choose where to investigate next.

| Result | Next step |
| --- | --- |
| Device registration or PRT state isn't established. | Troubleshoot device registration and Microsoft Entra sign-in. |
| The expected Cloud TGT isn't available. | Verify the client policy, supported sign-in flow, and workload prerequisites. |
| A TGT is available, but the service ticket can't be obtained. | Verify realm mapping, the resource name, SPN, and configuration for the selected Kerberos flow. |
| A service ticket is issued, but the server can't validate it. | Check the target service's Kerberos logs, service account, encryption requirements, and current service key. For synchronized keys, check provisioning logs. For SMB error 1396, see [Service ticket is issued, but SMB access fails with error 1396](#service-ticket-is-issued-but-smb-access-fails-with-error-1396). Ticket issuance doesn't prove that server-side authentication succeeded. |
| A service ticket is issued, but the client can't connect to the resource. | Troubleshoot DNS, required ports, and the network path. If you use Microsoft Entra Private Access, see [Troubleshoot application access](~/global-secure-access/troubleshoot-app-access.md). |
| Required on-premises group SIDs are missing for the cloud-only identity preview. | Verify the application configuration in [Configure optional group SID claims for Microsoft Entra Kerberos tickets](configure-optional-group-claims-kerberos.md). Check the SID category, group assignment, membership, and membership scope. |
| The server accepts the ticket, but SMB access is denied. | Verify the authorization group's SID in the server's logon session and check both share and NTFS permissions. A valid ticket doesn't grant permissions that the resource hasn't assigned. |

Ticket acquisition, server-side authentication, and resource authorization are separate operations. In the traditional hybrid AD DS flow, the domain controller issues the full AD DS TGT with the authorization data used to request resource tickets. In the cloud-only identity preview, the resource uses the SIDs in the Microsoft Entra Kerberos service ticket instead.

## Service ticket is issued, but SMB access fails with error 1396

Use this section when a client obtains a Cloud Ticket Granting Ticket (Cloud TGT) and a CIFS service ticket from Microsoft Entra Kerberos, but can't access an on-premises SMB share.

### Symptoms

Connecting to the share fails with the following error:

```output
System error 1396 has occurred.
The target account name is incorrect.
```

The client's ticket cache contains a service ticket for the expected `cifs/<server-fqdn>` service principal name (SPN), but access to the share fails.

> [!IMPORTANT]
> Obtaining a service ticket confirms ticket issuance. It doesn't confirm that the resource server can decrypt and validate the ticket or that the identity has permission to access the resource.

### Possible causes

If Kerberos events or a trace confirm `KRB_AP_ERR_MODIFIED`, investigate whether the target server can decrypt the ticket with the key for the account that runs the service. Possible causes include:

- The SPN is associated with an incorrect AD DS account or is duplicated.
- The client connects by using a host name or alias that doesn't match the intended service configuration.
- The synchronized Kerberos key in Microsoft Entra ID no longer matches the current key of the AD DS account that owns the resource SPN.

For synchronized resource keys, a failed synchronization match can prevent key updates after the AD DS account password changes.

> [!NOTE]
> Windows error 1396 alone doesn't establish that a stale key caused the failure. Confirm the Kerberos error and review SPN configuration and provisioning history before determining the cause.

### Diagnose the failure

Follow these steps to distinguish ticket validation failures from authorization failures.

#### 1. Confirm the requested resource and service ticket

In the affected user's Windows session, run:

```console
klist get cifs/<server-fqdn>
klist
```

Replace `<server-fqdn>` with the host name used in the failing UNC path, such as `\\<server-fqdn>\<share-name>`. If the application uses an alias, test that alias.

Record the requested SPN, ticket timestamps, and KDC information.

#### 2. Check the resource server

Review Kerberos events on the client and resource server for the same access attempt.

On the resource server, also check Security events for the affected identity:

- **4624**: Successful logon.
- **4625**: Failed logon.
- **4627**: Group membership information.

Missing Security events alone don't prove that the server rejected the ticket before logon. Confirm that the relevant audit policies are enabled. See [Verify group membership on the resource server](#verify-group-membership-on-the-resource-server).

If ticket decryption fails, resolve that failure before troubleshooting group claims or share permissions.

#### 3. Verify SPN ownership

Confirm that the requested SPN resolves to the AD DS account whose key the target service uses. Check for incorrect or duplicate SPN registrations and verify any host name aliases.

For configuration guidance, see [How to configure SPNs](/windows-server/identity/ad-ds/manage/how-to-configure-spn).

#### 4. Check the resource's synchronization mapping

Inspect the enterprise application that represents the resource. Verify the effective SPN associations and `tags` collection on its service principal, not only the application registration manifest.

The resource service principal must contain the matching tag:

```text
KerberosSync:cifs/<server-fqdn>
```

The current synchronization implementation excludes a service principal from matching if it contains another distinct `KerberosSync:` tag. For example, adding a separate `KerberosSync:MSSQLSvc/...` tag to the same service principal can prevent key updates.

Use separate resource applications and corresponding service principals for separate key-sync mappings.

For this configuration's symptoms and recovery guidance, see [Kerberos key synchronization fails when multiple SPNs are configured](#kerberos-key-synchronization-fails-when-multiple-spns-are-configured).

#### 5. Verify the last successful key export

Review the synchronization job status and provisioning logs for the affected resource.

- Look for failed or skipped matching operations, including `JoinNotFound`.
- Identify the last successful key export for this resource.
- Compare the export history with the AD DS account's password-change time and `msDS-KeyVersionNumber`.
- Inspect the synchronized Kerberos credential on the resource service principal.

A running provisioning agent or a started job doesn't confirm that this resource's key was updated. An old credential timestamp or an increased AD DS key version is a diagnostic clue, not definitive proof of a mismatch.

See [Verify key synchronization](configure-cloud-only-identities-on-premises-access-kerberos.md#verify-key-synchronization).

### Resolve and verify

1. Correct any SPN ownership or synchronization-mapping errors. Preserve unrelated tags and credentials.
1. Resolve provisioning errors and allow the next synchronization cycle to complete. If necessary, follow the supported procedure to restart the job with a full synchronization.
1. Confirm a successful key export and an updated synchronized Kerberos credential for the affected resource.
1. Follow [Clear cached tickets and test again](#clear-cached-tickets-and-test-again) to request fresh tickets in the affected test session.
1. Retry access to the same UNC path.
1. Confirm that the resource server accepts the authentication and that the intended file or folder access succeeds.

> [!CAUTION]
> Don't clear the entire `keyCredentials` collection as a routine recovery step. Normal key synchronization replaces the previous synchronized Kerberos credential while preserving non-Kerberos credentials. Clearing the collection can remove credentials used for other purposes.

If the server accepts the ticket but access is denied, investigate authorization separately. Verify the required group SIDs and both SMB share permissions and NTFS permissions.

### Clear cached tickets and test again

After a configuration change, use a test session to request fresh tickets.

> [!CAUTION]
> Purging the cache removes the current session's cached Kerberos tickets and can interrupt authenticated connections. Use this command only when you can safely repeat the authentication attempt.

In the affected test session, run:

```console
klist purge
```

Reproduce the authentication attempt, and run `klist` again to inspect the newly acquired tickets.

## Kerberos key synchronization fails when multiple SPNs are configured

Microsoft Entra Kerberos key synchronization supports one `KerberosSync:<SPN>` mapping per resource service principal. If multiple distinct `KerberosSync:<SPN>` tags are configured on the same enterprise application, Kerberos key synchronization might not update the key as expected. This limitation is specific to the key synchronization mapping. Kerberos itself supports multiple SPNs.

### Symptoms

You might experience one or more of the following symptoms:

- Kerberos authentication initially works after you configure the resource.
- The client can obtain a Microsoft Entra Kerberos TGT and a service ticket for the on-premises resource.
- Access to the resource later fails after the on-premises resource account password or Kerberos key is rotated.
- The resource's key credential in Microsoft Entra ID isn't updated after the on-premises key changes.
- The on-premises resource can't decrypt a service ticket issued by Microsoft Entra ID because the ticket was encrypted with an older key. This can result in errors such as `SEC_E_WRONG_PRINCIPAL` for SMB scenarios.

An SMB error alone doesn't confirm a key mismatch. Review the Kerberos error, SPN configuration, and provisioning history as described in [Service ticket is issued, but SMB access fails with error 1396](#service-ticket-is-issued-but-smb-access-fails-with-error-1396).

### Cause

This issue can occur when a single Microsoft Entra resource service principal contains more than one distinct `KerberosSync:<SPN>` tag.

For example, don't configure a resource service principal with both of the following mappings:

```text
KerberosSync:cifs/fileserver.contoso.com
KerberosSync:MSSQLSvc/sqlserver.contoso.com:1433
```

The Kerberos key synchronization process uses the `KerberosSync:<SPN>` mapping to identify the Microsoft Entra service principal that corresponds to an on-premises Kerberos principal. The current synchronization model expects a single Kerberos key mapping for the resource service principal.

If multiple distinct `KerberosSync:<SPN>` mappings are configured, synchronization matching can fail and the existing key in Microsoft Entra ID can remain unchanged.

This condition might not be immediately apparent. For example, if Microsoft Entra ID and the on-premises resource initially have the same key, access can continue to work. The problem can become visible after the resource account password changes and a new Kerberos key is generated. If synchronization doesn't publish the new key, Microsoft Entra ID retains the previous key and tickets issued with that key can't be decrypted by the resource.

### Resolution

Configure one Kerberos key synchronization mapping per Microsoft Entra resource enterprise application.

For a file server resource application, use:

```text
KerberosSync:cifs/fileserver.contoso.com
```

For a SQL Server resource application, use:

```text
KerberosSync:MSSQLSvc/sqlserver.contoso.com:1433
```

If the CIFS and MSSQLSvc SPNs require separate key-sync mappings, configure them as separate Microsoft Entra enterprise applications instead of adding both `KerberosSync` tags to the same resource application.

> [!IMPORTANT]
> This restriction doesn't mean that Kerberos doesn't support multiple SPNs. The restriction applies to the current Microsoft Entra Kerberos key synchronization mapping, where the synchronized Kerberos credential is associated with the resource service principal rather than an individual SPN.

### Verify the configuration

Check the resource service principal and make sure that it contains only one distinct `KerberosSync:<SPN>` tag associated with the Kerberos key synchronization configuration.

For example, for an SMB file server:

```text
KerberosSync:cifs/fileserver.contoso.com
```

Also verify that the SPN in the tag exactly matches the SPN associated with the on-premises Kerberos principal being synchronized. The key-sync design joins the on-premises resource to its Microsoft Entra service principal by using both the resource SPN and the corresponding `KerberosSync:<SPN>` mapping.

Check the effective `tags` collection on the resource service principal, including tags from the associated application registration. For setup instructions, see [Create the resource application](configure-cloud-only-identities-on-premises-access-kerberos.md#create-the-resource-application).

### Verify key synchronization

After correcting the resource configuration, allow the Kerberos synchronization process to run again and verify that the resource service principal contains the synchronized Kerberos key credential.

For example, with Microsoft Graph PowerShell:

```powershell
Connect-MgGraph -Scopes "Application.Read.All"

(Get-MgServicePrincipal `
    -ServicePrincipalId "<resource-service-principal-object-id>" `
    -Property Id,DisplayName,KeyCredentials).KeyCredentials |
    Select-Object DisplayName,Type,Usage,StartDateTime,EndDateTime
```

A missing Kerberos key credential can indicate that the resource isn't in synchronization scope or that the SPN-to-resource-application mapping didn't succeed. Other credentials can appear in this collection, so a nonempty collection alone doesn't confirm that the Kerberos key was updated. Review the provisioning logs and the last successful key export. For instructions, see [Verify key synchronization](configure-cloud-only-identities-on-premises-access-kerberos.md#verify-key-synchronization).

Also verify that the Microsoft Entra provisioning agent is healthy under **Entra ID** > **Entra Connect** > **Cloud sync** in the Microsoft Entra admin center. For agent health checks, see [Microsoft Entra Cloud Sync troubleshooting](../hybrid/cloud-sync/how-to-troubleshoot.md#agent-problems). A healthy agent doesn't by itself confirm that this resource's key was synchronized.

### Why the issue can appear after password rotation

Under normal operation, when the password or Kerberos key of the on-premises resource changes, the synchronization process updates the corresponding Kerberos credential in Microsoft Entra ID.

With an invalid multiple-`KerberosSync` configuration, the sequence can instead be:

1. The on-premises resource and Microsoft Entra ID initially have matching Kerberos keys.
1. Access works successfully.
1. The resource password changes and the on-premises Kerberos key changes.
1. Kerberos key synchronization can't correctly match the resource application.
1. The new key isn't written to the Microsoft Entra service principal.
1. Microsoft Entra ID continues issuing service tickets by using the previously synchronized key.
1. The on-premises resource can no longer decrypt those tickets and access fails.

### Recommended configuration

For resources that require different Kerberos key mappings, use separate Microsoft Entra resource applications:

| On-premises resource SPN | Microsoft Entra resource application |
| --- | --- |
| `cifs/fileserver.contoso.com` | File Server application |
| `MSSQLSvc/sqlserver.contoso.com:1433` | SQL Server application |

Configure each resource application with only the `KerberosSync:<SPN>` mapping for the Kerberos principal whose key is synchronized to that application.

## Logging

Use the resource server's Security log to verify logon group memberships and enable the required auditing when events aren't generated.

### Verify group membership on the resource server

For a network logon, such as access to an SMB share, Windows records logon events on the server that hosts the resource. With auditing enabled, Security event 4627 shows the group memberships associated with that logon session. It isn't a complete dump of the ticket's Privilege Attribute Certificate (PAC).

You need permission to read the server's Security log. Administrative permissions are required to change its audit policy.

On the resource server:

1. Open **Event Viewer**.
1. Browse to **Windows Logs** > **Security**.
1. Select **Filter Current Log**, enter `4627` in **Event IDs**, and select **OK**.
1. Find the event for the affected identity and access attempt. Review **New Logon** to identify the account and its **Logon ID**. Correlate that ID with the corresponding event 4624.
1. Review **Group Membership** for the required group SIDs. If membership data spans multiple events, review all events for that logon.
1. Compare the authorization group SIDs with the resource's permissions. For SMB, check both share permissions and NTFS ACLs.

For field definitions, see [Event 4627: Group membership information](/windows/security/threat-protection/auditing/event-4627).

### Enable auditing if event 4627 isn't generated

Enable **Success** auditing for both **Audit Group Membership** and **Audit Logon** on the resource server, and then reproduce the access attempt.

In Local Security Policy, browse to **Advanced Audit Policy Configuration** > **System Audit Policies** > **Logon/Logoff**. For a Group Policy-managed server, configure the same subcategories under **Computer Configuration** > **Policies** > **Windows Settings** > **Security Settings** > **Advanced Audit Policy Configuration** > **Audit Policies** > **Logon/Logoff**.

Follow your organization's audit policy and log-retention requirements. For more information, see [Audit Group Membership](/windows/security/threat-protection/auditing/audit-group-membership) and [Advanced Audit Policy Configuration](/windows-server/identity/ad-ds/plan/security-best-practices/advanced-audit-policy-configuration).

## Related content

- [Introduction to Microsoft Entra Kerberos](kerberos.md)
- [Configure on-premises resource access for cloud-only identities](configure-cloud-only-identities-on-premises-access-kerberos.md)
- [Configure optional group SID claims for Microsoft Entra Kerberos tickets](configure-optional-group-claims-kerberos.md)
- [Microsoft Entra Kerberos FAQ](kerberos-faq.yml)
