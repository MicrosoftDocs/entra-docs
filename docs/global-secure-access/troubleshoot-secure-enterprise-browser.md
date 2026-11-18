---
title: Troubleshoot Secure Enterprise Browser (Preview)
description: Troubleshoot secure enterprise browser in Microsoft Edge and Global Secure Access by checking configuration, policy assignments, traffic logs, and network traces.
ms.topic: troubleshooting-general
ms.date: 11/13/2026
ms.custom: msecd-doc-authoring-1026
ai-usage: ai-generated
ms.author: alexpav
#customer intent: As an IT administrator, I want to diagnose secure enterprise browser access and policy issues so that employees can use protected browsing and private web applications.
---

# Troubleshoot secure enterprise browser (preview)

Use this article to diagnose secure enterprise browser access and policy issues in Microsoft Edge with Global Secure Access. Check browser sign-in, configuration in both admin centers, and traffic logs before collecting a network trace. The guidance covers internet, Microsoft 365, and private web application access on Windows and macOS. It also helps you investigate Transport Layer Security (TLS) inspection issues for Internet Access traffic.

Before you begin, have access to the affected employee's work profile and the administrators who manage Global Secure Access and Edge policies.

## Prerequisites

- A Windows or macOS device running Microsoft Edge, version **157.0.4341.46** or newer.
- An employee work account in the tenant configured for Global Secure Access. Business-to-business (B2B) guest accounts aren't supported.
- Access to review your [secure enterprise browser configuration](how-to-configure-global-secure-access-browser-settings.md), including traffic forwarding profiles and Edge Management Experience (EMX) policy assignments.
- Access to Global Secure Access traffic logs and, for configuration changes, the required administrative roles. See [Global Secure Access traffic logs](how-to-view-traffic-logs.md).
- For Private Access issues, access to the private application's configuration and its connector administrator.

## Troubleshooting checklist

Start with the affected work profile and one failing destination. Record the reproduction time, including the time zone, so you can correlate browser results with service logs.

| Symptom | Start with |
| --- | --- |
| The Edge policy is missing or has an unexpected value. | [Check the EMX policy and effective Edge settings](#check-the-emx-policy-and-effective-edge-settings). |
| Browsing works, but you can't find the expected Global Secure Access traffic. | [Check browser enablement and traffic forwarding](#check-browser-enablement-and-traffic-forwarding), then [review traffic logs](#review-traffic-logs-and-policy-decisions). |
| Traffic is denied or an internet destination isn't inspected. | [Check Internet Access security and TLS inspection policies](#check-internet-access-security-and-tls-inspection-policies). |
| A private web application fails while internet access works. | [Check the private application and connectors](#check-the-private-application-and-connectors). |
| Edge displays a certificate error. | [Investigate certificate errors without manual Edge trust deployment](#investigate-certificate-errors-without-manual-edge-trust-deployment). |
| Edge displays certificate prompts on macOS while the Global Secure Access client is enabled. | [Check Global Secure Access client coexistence](#check-global-secure-access-client-coexistence). |

### Check the platform and signed-in work profile

Confirm that you're testing a supported browser profile:

1. Record the installed Edge version and confirm that the device runs Windows or macOS. The minimum supported preview version is **157.0.4341.46**.
1. Check that the affected Edge profile is signed in with the employee's work account in your Global Secure Access tenant.
1. Open `edge://signin-internals` to review browser sign-in status. Record any relevant errors rather than switching to a personal profile for the test.
1. Confirm that the same employee is included in the applicable Global Secure Access and EMX assignments.

For information about the browser diagnostic pages, see [Microsoft Edge sign-in and policy diagnostics](/deployedge/microsoft-edge-troubleshoot-enterprise-sync). Use the sign-in checks for this investigation, not the sync reset procedures.

### Check Global Secure Access client coexistence

Check whether the Global Secure Access client is enabled on the affected device:

- **Windows:** Running the client while Microsoft Edge is configured for Global Secure Access is supported.
- **macOS:** Running the client while Edge is configured for Global Secure Access isn't supported and results in certificate prompts. Disable the client while using the Edge integration, and retest the affected destination.

### Check browser enablement and traffic forwarding

Review both the browser enablement settings and the profiles that calculate the employee's forwarding policy:

1. In the Microsoft Entra admin center, review the secure enterprise browser configuration described in [Enable browser access](how-to-configure-global-secure-access-browser-settings.md#enable-browser-access-in-the-global-secure-access-portal).
1. Confirm that Internet Access and Microsoft 365 are enabled together if you want to forward those traffic types. Check Private Access separately.
1. Go to **Global Secure Access** > **Connect** > **Traffic forwarding**.
1. Review the enabled profiles, their user and group assignments, and the rules for the failing destination. Check whether a rule forwards or bypasses that destination.
1. Compare the Global Secure Access assignments with the employees assigned the EMX policy.

The EMX policy enables the integration; the forwarding rules come from Global Secure Access profiles, as they do for the Global Secure Access client. See [Traffic forwarding profiles](concept-traffic-forwarding.md) and [Assign users to traffic forwarding profiles](how-to-manage-users-groups-assignment.md).

### Check the EMX policy and effective Edge settings

Compare the intended cloud configuration with the policy Edge actually receives:

1. In the Microsoft 365 admin center, go to **Settings** > **Microsoft Edge** > **Configuration policies**.
1. Open the policy used for secure enterprise browser. Under **Customization Settings** > **Security settings**, confirm that **Enable secure network access (preview)** is set to **Enabled**. Review the assignments and confirm that the affected employee is in scope.
1. Check for other assigned configuration policies that configure the same setting. Review their priorities rather than assuming the most recently edited policy wins.
1. In the affected Edge work profile, open `edge://policy`. Check the integration policy's effective value, source, and any reported errors or conflicts.
1. If you changed the policy, restart Edge and check the effective value again.

EMX is the only supported configuration method for enabling this integration in the preview. Don't substitute an Intune app policy. For general cloud-policy assignment and priority behavior, see [Microsoft Edge management service](/deployedge/microsoft-edge-management-service).

For the configuration steps, see [Configure Global Secure Access policy in Microsoft Edge secure enterprise browser settings](how-to-configure-global-secure-access-edge-policy.md).

### Review traffic logs and policy decisions

Correlate the failing browser request with Global Secure Access logs:

1. Reproduce the issue once in the affected work profile. Record the time, destination, and browser error.
1. In the Microsoft Entra admin center, go to **Global Secure Access** > **Monitor** > **Traffic logs**.
1. Select **Transactions** and filter **Device Category** to **Secure enterprise browser**.
1. Use **Add filter** and the time range to narrow the results to the affected user and destination.
1. Review the matching transactions. Compare the traffic type and action, such as **Allowed** or **Denied**, with the intended forwarding and security policies.
1. Open the matching details and record the **Connection ID** and **Transaction ID**, when available, for further investigation.

See [Use Global Secure Access traffic logs](how-to-view-traffic-logs.md) for available filters and columns. A missing matching entry isn't enough to establish that forwarding failed; recheck the time range, filters, destination, and configuration.

If the behavior changed after an administrator updated configuration, review **Global Secure Access** > **Monitor** > **Audit logs**. See [Access Global Secure Access audit logs](how-to-access-audit-logs.md).

For authentication or Conditional Access failures, review the affected event under **Entra ID** > **Monitoring & health** > **Sign-in logs**. Use [Troubleshoot Microsoft Entra sign-in errors](../identity/monitoring-health/howto-troubleshoot-sign-in-errors.md) to investigate the reported failure.

### Check Internet Access security and TLS inspection policies

For an internet request that is denied or isn't inspected as expected, check the service policies:

1. Go to **Global Secure Access** > **Secure** > **Security profiles**. Review the relevant profile and its linked policies.
1. Check the web content filtering rules and the policy assignments that apply to the affected employee.
1. Go to **Global Secure Access** > **Secure** > **TLS inspection policies**. Review the rules for the destination, including bypass rules and the **Default action**.
1. Confirm that the intended TLS inspection policy is linked to the appropriate security profile and that the certificate authority is active and enabled.

For configuration details, see [Web content filtering](how-to-configure-web-content-filtering.md) and [TLS inspection policies](how-to-transport-layer-security.md). Use those articles for service-side policy configuration, not their Global Secure Access client setup or manual device certificate-deployment procedures.

Microsoft 365 traffic isn't subject to TLS inspection or web filtering policies in this preview. Use an Internet Access destination, not a Microsoft 365 destination, to test those protections.

### Check the private application and connectors

For a failing private web application, check its assignment, destination, and connector group:

1. Go to **Global Secure Access** > **Applications** > **Enterprise applications**, and open the affected application.
1. Review **Users and groups** to confirm that the employee is assigned access.
1. Review **Network access properties**. Compare the configured fully qualified domain name (FQDN), port, and protocol with the failing request, and check the selected connector group.
1. Go to **Global Secure Access** > **Connect** > **Connectors**. Check that the selected group has an active connector.
1. Work with the connector administrator to check name resolution and connectivity from the connector server to the backend application.

See [Configure per-app access](how-to-configure-per-app-access.md) and [Troubleshoot connectors](troubleshoot-connectors.md). Private DNS isn't supported in the browser preview; use FQDN-based private web application definitions.

If the main page opens but sign-in or page resources fail, use the [DevTools Network tool](#inspect-failed-requests-with-devtools) to identify the failing destinations. Compare those destinations with your forwarding rules and private application segments.

## Causes and solutions

Use the checklist results to correct configuration problems. Retest the same destination with the same employee work profile after each change.

### Correct a missing or conflicting Edge policy

If the integration policy is missing or its effective value differs from the intended value, correct the EMX setting or assignment. Review competing configuration policies with the Edge administrator, restart Edge, and recheck `edge://policy`.

Don't treat a saved Global Secure Access browser configuration as proof that Edge received its policy. Both Global Secure Access enablement and the EMX policy are required.

### Correct forwarding or application scope

If the employee or destination is outside the intended scope, correct the relevant traffic profile assignment or destination rule. For private applications, also check application assignment, the FQDN-based segment, and connector group connectivity.

Internet Access and Microsoft 365 share a browser enablement control, but their forwarding profiles still determine which traffic is forwarded. Review both profiles when only one traffic type behaves as expected.

If a logged denial matches an intended security rule, the denial isn't evidence of a forwarding failure. Review whether the rule meets your organization's access requirements before changing it.

### Investigate certificate errors without manual Edge trust deployment

Global Secure Access delivers TLS inspection certificate trust automatically to Edge. A separate manual certificate deployment to Edge isn't required for this integration.

For certificate prompts on macOS, first [check Global Secure Access client coexistence](#check-global-secure-access-client-coexistence). An enabled client alongside Edge configured for Global Secure Access is an unsupported configuration that results in certificate prompts.

If a certificate error persists, check the active Global Secure Access certificate, the inspection or bypass rule for the destination, and the effective browser policy. Record the exact error and the certificate issuer and validity information displayed by Edge. Collect a bounded network trace if the configuration checks don't explain the failure.

Automatic delivery to Edge doesn't establish device-wide certificate trust. Don't change the operating system's certificate store or bypass the browser certificate warning as a substitute for diagnosing the integration.

### Use a supported preview scenario

If the test uses an unsupported scenario, change the test rather than the policy. The preview supports Windows and macOS with employee work accounts. The Microsoft Entra traffic profile, compliant network checks, and tenant restrictions v2 for Microsoft Entra ID aren't supported.

Use Internet Access, Microsoft 365, or an FQDN-based private web application to validate the integration. Don't use a B2B guest account or private DNS functionality as a validation test.

## Advanced troubleshooting and data collection

If configuration and service logs don't explain the issue, collect browser evidence for one reproduction. Keep the browser profile, destination, and time consistent with your traffic-log investigation.

### Inspect failed requests with DevTools

Use the Network tool to identify which requests fail:

1. Open the affected page in the employee's Edge work profile.
1. Right-click the page, select **Inspect**, and open the **Network** tool.
1. Select **Preserve log** if the issue involves navigation between pages.
1. Refresh the page or reproduce the failing action. Record failed request destinations, status or error information, and timing.

See [Microsoft Edge DevTools Network reference](/microsoft-edge/devtools/network/reference) for request details. Record only the headers needed for the investigation; request headers can contain credentials.

### Capture an Edge network trace

Use NetLog when you need browser network evidence beyond the page's request list.

> [!WARNING]
> Network captures can contain sensitive information. Don't select **Include raw bytes (will include cookies and credentials)** for routine collection. Share captures only through approved support channels, not public trace viewers.

To capture one reproduction:

1. Open `edge://net-export` in the affected Edge profile.
1. Select **Start Logging to Disk**, and save the capture file.
1. Keep the capture tab open. In another tab, reproduce the issue.
1. Return to the capture tab and select **Stop Logging** promptly.
1. Record the reproduction time and the matching Global Secure Access connection and transaction IDs with the capture.

See [Capture network traffic with NetLog](/troubleshoot/entra/entra-id/app-integration/use-netlog-capture-network-traffic) for capture guidance.

### Prepare information for support

Provide the evidence needed to correlate the browser request with service-side processing:

- The affected user's tenant and work profile, shared only through the authorized support case.
- The operating system (Windows or macOS) and Edge versions, and the destination and action that reproduce the issue.
- The exact error, reproduction time, and time zone.
- The relevant EMX policy, assignment, and effective value from `edge://policy`.
- The Global Secure Access browser enablement, traffic profiles, application assignments, and applicable security policies.
- The matching traffic-log records, connection and transaction IDs, and relevant configuration changes from audit logs.
- Browser sign-in diagnostics and a bounded network capture, if requested.

## Related content

- [Secure enterprise browser overview](concept-secure-enterprise-browser.md)
- [Configure Global Secure Access secure enterprise browser settings](how-to-configure-global-secure-access-browser-settings.md)
- [Global Secure Access traffic logs](how-to-view-traffic-logs.md)
