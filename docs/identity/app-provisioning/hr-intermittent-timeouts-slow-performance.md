---
title: Microsoft Entra HR provisioning timeouts
description: Diagnose intermittent timeouts and slow Microsoft Entra HR provisioning to on-premises Active Directory by checking matching attributes, agents, and connectivity.
author: cmmdesai
ms.author: chmutali
ms.service: entra-id
ms.subservice: app-provisioning
ms.workload: identity
ms.topic: troubleshooting-general
ms.date: 10/22/2026
ms.custom: msecd-doc-authoring-1030
ai-usage: ai-assisted
#customer intent: As an administrator, I want to diagnose intermittent timeouts and slow HR provisioning to on-premises Active Directory so that I can identify the cause and restore reliable provisioning.
---

# Troubleshoot intermittent timeouts and slow Microsoft Entra provisioning to on-premises Active Directory

Microsoft Entra inbound provisioning can provision users from Workday, SAP SuccessFactors, and API-driven HR integrations to on-premises Active Directory through the Microsoft Entra provisioning agent.

Use this article to diagnose unusually slow provisioning or intermittent timeout errors. It helps administrators distinguish delays in HR data retrieval and provisioning processing from Active Directory lookup and connectivity problems.

## Prerequisites

Before you begin, review these prerequisites:

- Coordinate with the teams that manage the provisioning application, provisioning-agent servers, Active Directory, and networking.
- Run the optional PowerShell connectivity checks from the provisioning-agent server. The provisioning agent package includes `ADConnectivityTools` in `C:\Program Files\Microsoft Azure AD Connect Provisioning Agent\Utility`. For cmdlet details, see the [ADConnectivityTools PowerShell reference](../hybrid/connect/reference-connect-adconnectivitytools.md).
- If you need to index an attribute, the [indexing procedure](index-employeeid-attribute-entra-id-to-active-directory.md) requires membership in the **Schema Admins** group. This requirement applies to the schema change, not to every diagnostic check.
- Use privileged access only for approved diagnostic, configuration, or schema-change tasks, and remove elevated access when each task is complete.
- Use the [Application Administrator](../role-based-access-control/permissions-reference.md#application-administrator) role to configure the provisioning application's attribute mappings.
- Use the [Hybrid Identity Administrator](../role-based-access-control/permissions-reference.md#hybrid-identity-administrator) role when configuring the provisioning agent.

## Check job status and identify symptoms

Confirm that the provisioning job is running, then review the symptoms of the slow or failing operations.

### Check provisioning job status

Before investigating directory latency, check the provisioning application's **Current Status**. Review the last synchronization time, the progress of the current initial or incremental cycle, and any quarantine reason.

Confirm that the provisioning job is running. A registered, healthy provisioning agent alone doesn't establish that the job is processing users successfully. If the job hasn't started or is in quarantine, investigate the reported status before treating the lack of progress as a slow Active Directory operation.

For details, see [Check the status of user provisioning](check-status-user-account-provisioning.md#provisioning-progress-bar).

<a name="symptoms"></a>

### Identify the symptoms

You might encounter one or more of these symptoms:

- Provisioning operations intermittently time out.
- A provisioning job takes much longer than expected to process users.
- Individual create or update operations take an unusually long time.
- Provisioning works successfully for some users but times out for others.
- Provisioning behavior differs between provisioning-agent instances.
- Operations succeed when retried.
- Network traces show Lightweight Directory Access Protocol (LDAP) connections to domain controllers or directory endpoints that don't respond promptly.
- Multiple provisioning agents appear to communicate with different domain controllers.

For these timeout issues, the provisioning or audit logs might show the error code `HybridIdentityServiceAgentTimeout`. A shortened example includes these diagnostic fields:

```text
ErrorCode: HybridIdentityServiceAgentTimeout
Response Status Code: GatewayTimeout
x-ms-proxy-error-details: ConnectorTimeout
Response Content: The provisioning service did not receive a timely response from your on-premises environment.
```

This error identifies a timeout but doesn't establish its underlying cause. Use the checks in this article to investigate Active Directory operations, domain-controller discovery, DNS, and network connectivity.

Successful retries or different domain-controller selections alone don't establish the cause of a problem. Use the diagnostic checks to correlate these observations with the slow or failed operations.

## Troubleshooting checklist

Use this table to choose a starting point based on the behavior you observe. The same timeout error can have several causes. Confirm the cause with diagnostic evidence before changing the configuration.

| Potential cause | Diagnostic check | Resolution |
| --- | --- | --- |
| Unindexed matching attributes slow directory searches. | [Check matching-attribute indexing](#verify-that-matching-attributes-are-indexed) for every configured matching property. | Index the relevant attributes using the documented procedure, accounting for storage and replication impact. |
| Multiple matching properties require additional searches. | [Review matching properties](#review-whether-multiple-matching-attributes-are-necessary) and determine whether each is necessary. | Simplify matching only after evaluating identity joins and testing the change. |
| Stale DNS entries or incorrect subnet-to-site mappings affect discovery. | [Validate DNS and site topology](#validate-active-directory-site-topology) from the provisioning-agent server. | Remove confirmed stale DNS entries and correct missing or incorrect subnet-to-site associations. |
| Selected domain controllers are unavailable or respond slowly. | [Investigate domain controllers](#investigate-all-domain-controllers-used-by-the-provisioning-path) used throughout the provisioning path; compare selection across agents. | Address controller availability or connectivity issues, and review controller priority where appropriate. |
| Network, firewall, or proxy problems interrupt communication. | [Check network and firewall behavior](#check-network-and-firewall-behavior), including internal and external DNS resolution. | Correct the identified DNS, network-path, firewall, or proxy configuration. |
| Active Directory connections legitimately need more time to establish. | [Review connection timing](#consider-the-ldap-connection-timeout-only-after-investigating-connectivity) after investigating connectivity problems. | Consider increasing the LDAP connection timeout as a mitigation, not as a substitute for fixing connectivity. |

If you're unsure where to start, [collect logs and determine where the delay occurs](#determine-whether-the-delay-occurs-during-active-directory-access).

<a name="1-check-the-active-directory-matching-attributes"></a>

### Check the Active Directory matching attributes

During provisioning, Microsoft Entra searches Active Directory to determine whether the incoming HR identity corresponds to an existing Active Directory account.

Review the attribute mappings for the provisioning application and identify every target Active Directory attribute configured as a **matching property**.

Common examples include:

- `employeeId`.
- `sAMAccountName`.
- Extension attributes.
- Organization-specific immutable identifiers.

If multiple matching properties are configured with matching precedence, review all of them.

For details about configuring **Match objects using this attribute** and **Matching precedence**, see [Understanding attribute-mapping properties](customize-application-attributes.md#understanding-attribute-mapping-properties).

#### Verify that matching attributes are indexed

The `employeeId` attribute isn't indexed in Active Directory by default. If it is used as a matching property without an index, directory searches can become slower as the directory grows.

The same principle applies to other attributes configured as matching properties.

For configurations with multiple matching properties, check whether every matching attribute used by the provisioning application is indexed in Active Directory.

For indexing guidance, see [Index the employeeId attribute](index-employeeid-attribute-entra-id-to-active-directory.md).

#### Review whether multiple matching attributes are necessary

Using multiple matching properties can require additional Active Directory searches.

If several matching properties are configured, determine whether they're all needed to match existing identities. Review the corrective actions in [Causes and solutions](#causes-and-solutions) before changing the configuration.

<a name="2-determine-whether-the-delay-occurs-during-active-directory-access"></a>

### Determine whether the delay occurs during Active Directory access

If matching attributes are correctly indexed but provisioning remains slow, isolate the time spent in each part of the operation.

The investigation should distinguish between:

- Retrieving source HR data.
- Applying provisioning mappings and synchronization rules.
- Reading or matching the user in Active Directory.
- Creating or updating the Active Directory object.

Use [`Export-AADCloudSyncToolsLogs`](../hybrid/cloud-sync/reference-powershell.md#export-aadcloudsynctoolslogs) to collect provisioning-agent logs and compare timestamps for the affected operation.

> [!IMPORTANT]
> The default collection enables and disables verbose tracing, which restarts the provisioning-agent service. Coordinate the collection window with the team that manages the agent.

To collect and review the logs:

1. Review the [AADCloudSyncTools module prerequisites and setup](../hybrid/cloud-sync/reference-powershell.md#prerequisites). On the provisioning-agent server, open Windows PowerShell with administrative privileges and import the module:

    ```powershell
    Import-Module -Name "C:\Program Files\Microsoft Azure AD Connect Provisioning Agent\Utility\AADCloudSyncTools"
    ```

1. Start the log collection:

    ```powershell
    Export-AADCloudSyncToolsLogs
    ```

1. Reproduce the slow or failing provisioning operation during the capture window. By default, the cmdlet captures verbose logs for three minutes. Record the operation's time and any available request or correlation IDs.
1. After collection finishes, open the exported `.zip` file in your **Documents** folder. The package includes agent logs, verbose logs, and Event Viewer logs from the last 24 hours.
1. Find entries for the affected operation and compare their timestamps with the provisioning logs. Use the elapsed time between related entries to investigate where the delay occurs. Correlate the operation's request or correlation IDs when available.

Logs can contain personal data and sensitive environment information. Review and redact sensitive information before sharing the exported package, and use your organization's approved support channels.

If most of the delay occurs during the Active Directory operation, continue with the provisioning-agent, Active Directory, and network checks.

<a name="3-review-provisioning-agent-domain-controller-selection"></a>

### Review provisioning-agent domain controller selection

The provisioning agent uses DNS-based discovery to locate Active Directory domain controllers. For details about the discovery process, see [Locate Active Directory domain controllers](/windows-server/identity/ad-ds/manage/dc-locator?tabs=dns-based-discovery).

In environments with multiple domain controllers, geographically distributed sites, or multiple provisioning-agent instances, verify which domain controllers the agents are using.

Pay particular attention when errors are intermittent rather than persistent.

<a name="review-domain-controller-priority"></a>

#### Review domain controller priority

Review the configured domain-controller priority and compare the configuration across provisioning agents.

By default, the provisioning agent uses DNS-based discovery. To configure a preferred set of domain controllers, update the domain controller priority setting in the provisioning agent wizard.

Completing the wizard restarts the provisioning-agent service. Coordinate the configuration window with the team that manages the agent.

1. On the provisioning-agent server, open **Microsoft Entra Provisioning Agent Wizard**.
1. In the **Connect Microsoft Entra ID** step, authenticate and connect to your Microsoft Entra tenant.
1. In the **Connect Active Directory** step, select your configured domain, then select **Change Credentials**.

    :::image type="content" source="./media/hr-intermittent-timeouts-slow-performance/select-configured-domain.png" alt-text="Screenshot of the provisioning agent wizard with Change Credentials highlighted for a configured Active Directory domain." lightbox="./media/hr-intermittent-timeouts-slow-performance/select-configured-domain.png":::

1. Enter your domain administrator credentials and select **Select domain controller priority**.
1. Add the domain controllers that the provisioning agent should connect to, and use the arrow controls to set their priority order.

    :::image type="content" source="./media/hr-intermittent-timeouts-slow-performance/select-domain-controller-priority.png" alt-text="Screenshot of the AD Domain Account dialog with Select domain controller priority and the controller list highlighted." lightbox="./media/hr-intermittent-timeouts-slow-performance/select-domain-controller-priority.png":::

    If the first domain controller in the list is unavailable, the agent tries the next controller in the configured order.

1. Select **OK** to save the domain credentials and domain-controller priority list.
1. On the **Connect Active Directory** screen, select **Next**.
1. On the **Confirm** screen, review the configuration, then select **Confirm** to apply it and restart the agent.
1. Wait for the notification that the agent configuration was successfully verified, then select **Exit**. If the initial setup screen remains open, select **Close**.
1. Reopen the wizard and review the domain-controller priority list to verify that the intended controllers and order were saved.

<a name="4-validate-active-directory-site-topology"></a>

### Validate Active Directory site topology

The server hosting the provisioning agent should be correctly represented in the organization's Active Directory topology.

In **Active Directory Sites and Services**, verify that the server's IP subnet is associated with the appropriate site. Also check for stale DNS entries that could affect domain-controller discovery or communication.

Check:

- DNS configuration on the provisioning-agent server.
- Active Directory subnet definitions.
- Subnet-to-site mappings.
- Active Directory Sites and Services configuration.
- Connectivity from the agent host to the expected domain controllers.

For DNS validation from the provisioning-agent server, use [`Confirm-DnsConnectivity`](../hybrid/connect/reference-connect-adconnectivitytools.md#confirm-dnsconnectivity). This cmdlet tests name resolution for the forest and the relevant domain controllers. It doesn't validate subnet-to-site mappings; review those separately in **Active Directory Sites and Services**.

To verify the provisioning-agent server's subnet-to-site mapping:

1. On the provisioning-agent server, open **Command Prompt** as an administrator. Run `ipconfig` to identify the server's IP address and subnet mask.
1. Run `nltest /dsgetsite` to identify the server's current Active Directory site. Compare the returned site name with the site expected for the server's network location.
1. In **Active Directory Sites and Services**, expand **Subnets**. Verify that a subnet covering the server's IP address exists and is associated with the intended site.
1. If the subnet is missing or associated with the wrong site, work with the Active Directory team to correct the configuration. Allow the change to replicate, then repeat the verification from the provisioning-agent server.

For subnet-to-site association guidance, see [Creating a site design](/windows-server/identity/ad-ds/plan/creating-a-site-design). The `ipconfig` and `nltest /dsgetsite` checks are also documented under [device network-location verification](/intune/configmgr/core/servers/deploy/configure/boundaries).

These checks verify the server's site association, not which domain controller a particular provisioning operation used.

Incorrect subnet or site configuration can cause the agent host to locate unexpected domain controllers, including controllers in remote sites.

This can lead to intermittent connectivity problems, synchronization failures, or increased provisioning latency.

> [!NOTE]
> In one customer investigation, stale DNS entries caused calls from the provisioning agent to take about 20 seconds or longer to respond.
>
> These delays created a backlog of users awaiting provisioning, extending overall job execution times. After the customer removed the stale DNS entries, provisioning-agent timeouts were no longer observed.

<a name="5-investigate-all-domain-controllers-used-by-the-provisioning-path"></a>

### Investigate all domain controllers used by the provisioning path

Check every domain controller involved in provisioning, rather than using the health of one controller to assess the entire path.

This is especially important for:

- Multi-domain forests.
- Child-domain deployments.
- Environments using LDAP referrals.
- Geographically distributed Active Directory deployments.

Verify that the domain controllers involved in the provisioning path are available and responding.

If network traces show repeated LDAP connection attempts to an IP address that doesn't respond, investigate that endpoint with the Active Directory and networking teams.

For environments using referrals, also verify the availability of domain controllers serving the referred domain.

<a name="6-test-the-ad-operation-independently-of-the-provisioning-agent"></a>

### Test the Active Directory operation independently of the provisioning agent

When possible, reproduce the relevant directory operation directly from the provisioning-agent server outside the provisioning agent.

For a basic matching-attribute lookup using `employeeId`, use the [`Get-ADUser` cmdlet](/powershell/module/activedirectory/get-aduser). This test requires the `ActiveDirectory` PowerShell module and an account with permission to read the relevant users.

1. On the provisioning-agent server, open Windows PowerShell using an account with the required directory read permissions.
1. Run the following command, replacing `12345` with a valid `employeeId` value for an existing user involved in the slow or failing provisioning operation:

    ```powershell
    Get-ADUser -LDAPFilter "(employeeId=12345)"
    ```

1. Check whether the command returns the expected user and whether the lookup experiences a delay. If no user is returned, verify the employee ID and search scope. If the command reports an error, investigate the reported error rather than treating it as an empty search result.

This is a basic lookup test, not proof that the provisioning agent uses the same domain controller, credentials, or search scope. A successful lookup alone doesn't establish that the agent's connection is healthy.

The Active Directory PowerShell cmdlet connects through Active Directory Web Services (ADWS) on port 9389 rather than directly to the LDAP endpoint. Its network trace doesn't directly reproduce the provisioning agent's LDAP connection. For details, see [Active Directory PowerShell connection behavior](/troubleshoot/windows-server/active-directory/specify-server-port-active-directory-powershell-cmdlet).

If a comparable independent lookup experiences about the same delay, use that evidence to investigate the Active Directory or network path.

Run the test while capturing a network trace. Collect the evidence listed in [Collect evidence for further investigation](#advanced-troubleshooting-and-data-collection).

<a name="7-check-network-and-firewall-behavior"></a>

### Check network and firewall behavior

The provisioning agent communicates both with Microsoft Entra and with on-premises Active Directory.

From the provisioning-agent server, check DNS resolution separately for the Active Directory domain controllers and the required Microsoft Entra service endpoints. Successful resolution of internal Active Directory names doesn't confirm that external service names resolve correctly.

If external name resolution fails, work with the DNS and networking teams to review the server's DNS configuration and the organization's DNS forwarding configuration.

For agent-to-Microsoft Entra communication, follow [Provisioning-agent troubleshooting](../hybrid/cloud-sync/how-to-troubleshoot.md#verify-the-required-open-ports) to verify the required outbound ports, allowed destinations, and firewall or proxy rules. The same guide covers endpoint DNS resolution. Review firewall logs around the timeout timestamp to determine whether a connection was terminated before the agent could report completion.

For agent-to-Active Directory communication, investigate:

- LDAP connectivity.
- Dropped or unanswered connections.
- Slow domain-controller responses.
- Network paths between the agent host and domain controllers.

Use [`Confirm-NetworkConnectivity`](../hybrid/connect/reference-connect-adconnectivitytools.md#confirm-networkconnectivity) from the provisioning-agent server to test connectivity to the relevant domain controllers. The cmdlet checks ports 53 (DNS), 88 (Kerberos), and 389 (LDAP). If DNS is hosted on a separate server rather than on the domain controllers, use the documented `-SkipDnsPort` option and validate DNS resolution separately.

These DNS and network checks don't reproduce the matching-attribute LDAP lookup or establish that provisioning performance is healthy. Continue with the [independent directory-operation test](#6-test-the-ad-operation-independently-of-the-provisioning-agent) to investigate the operation itself.

## Causes and solutions

Use the diagnostic evidence to choose a corrective action. Don't change matching or timeout settings solely because provisioning is slow.

### Address unindexed matching attributes

If the checks identify unindexed matching attributes, review [Index the employeeId attribute](index-employeeid-attribute-entra-id-to-active-directory.md) before making changes.

The indexing guidance applies to all configured matching properties. Plan for increased domain storage and allow time for schema changes to replicate to all domain controllers.

### Simplify matching configuration when appropriate

If several matching properties are configured, determine whether the identity data can be normalized so that one stable, unique matching property can be used.

For example, if `employeeId` is stable and unique across the organization, consider whether secondary and tertiary matching properties are still required.

Don't change matching configuration in production without first evaluating how existing identities are joined and testing the change.

### Address domain-controller selection and connectivity problems

Work with the Active Directory and networking teams to address the DNS, site-topology, domain-controller availability, or connectivity problems identified by the checklist.

If the investigation identifies stale DNS entries, work with those teams to remove the confirmed stale entries. Verify the server's subnet-to-site mapping in **Active Directory Sites and Services**, then repeat the affected provisioning operations to check whether the delays and timeouts persist.

If multiple provisioning agents service the same provisioning configuration, review whether domain-controller discovery should use a consistent order. For configuration steps, see [Review domain controller priority](#review-domain-controller-priority).

<a name="8-consider-the-ldap-connection-timeout-only-after-investigating-connectivity"></a>

### Consider the LDAP connection timeout only after investigating connectivity

If investigation shows that the provisioning agent's connection to Active Directory regularly needs more time to establish, review the provisioning-agent LDAP connection-timeout configuration.

The [agent registry-options documentation](../hybrid/cloud-sync/how-to-manage-registry-options.md#configure-ldap-connection-timeout) describes `LdapConnectionTimeoutInMilliseconds`. This setting also applies to the HR provisioning scenarios covered in this article.

Increasing the timeout can help in environments where Active Directory connections legitimately require more time. Don't use a longer timeout to hide an unhealthy domain controller, DNS problem, incorrect Active Directory site configuration, or network issue.

Treat timeout changes as a mitigation after investigating the underlying connectivity path.

### Verify the result

After applying a corrective action, repeat the previously slow or failing operation and compare the result with the original behavior.

<a name="suggested-troubleshooting-order"></a>
<a name="advanced-troubleshooting-and-data-collection"></a>

## Collect evidence for further investigation

If the checks don't isolate the problem, collect evidence for further investigation with the provisioning, Active Directory, and networking teams.

Logs and network traces can contain personal data and sensitive environment information. Review and redact sensitive information before sharing diagnostic files, and use your organization's approved support channels.

Collect:

- The log package exported by following [Determine whether the delay occurs during Active Directory access](#determine-whether-the-delay-occurs-during-active-directory-access).
- Network traces.
- Timestamps of failed provisioning operations.
- Provisioning job IDs.
- Request or correlation IDs available in the provisioning logs.

For additional diagnostic guidance, see the [agent troubleshooting documentation](../hybrid/cloud-sync/how-to-troubleshoot.md#log-files).

For an independent directory-operation test, correlate the timestamps with:

- Source server.
- Destination domain controller.
- DNS resolution.
- Connection establishment.
- LDAP request.
- Response latency.

If the issue remains unresolved, create a support case:

- In the [Microsoft Entra admin center](https://entra.microsoft.com), select **New support request**. Describe the issue and the troubleshooting steps you've completed. Include the relevant timestamps, provisioning job IDs, and request or correlation IDs, and provide the collected logs and traces after reviewing and redacting sensitive information.
