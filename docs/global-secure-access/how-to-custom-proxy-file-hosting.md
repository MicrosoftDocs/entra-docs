---
title: Host custom Proxy Automatic Configuration files for Explicit Forward Proxy in Microsoft Entra Internet Access
description: Learn how to upload and host your own Proxy Auto-Configuration (PAC) files
author: idmdev
ms.author: alexpav
ms.service: global-secure-access
ms.topic: how-to
ms.date: 06/19/2026
---

# Host custom Proxy Automatic Configuration (PAC) files for Explicit Forward Proxy (Preview)

> [!IMPORTANT]
> The Explicit Forward Proxy feature is currently in preview. This information relates to a prerelease product that might be substantially modified before release. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

Global Secure Access (GSA) Explicit Forward Proxy (EFP) automatically generates a Proxy Automatic Configuration (PAC) file that routes traffic through the service with recommended settings. If you need more control over proxy routing decisions, you can host your own custom PAC files.

Custom PAC files allow you to:

- Exclude specific hosts or IP ranges from Explicit Forward Proxy traffic acquisition.
- Route traffic to different proxies based on URL patterns or destination hosts for coexistence with your existing proxy solutions.
- Implement proxy logic relevant to your organization.

## Prerequisites

- A Global Secure Access license. For more information about licensing, see [Global Secure Access licensing](/entra/global-secure-access/overview-what-is-global-secure-access#licensing).
- An administrator account with the [Global Secure Access Administrator](/entra/identity/role-based-access-control/permissions-reference#global-secure-access-administrator) role.
- Explicit Forward Proxy [enabled and configured](/entra/global-secure-access/how-to-configure-explicit-forward-proxy) in your tenant.

## Create a custom PAC file

> [!NOTE]
> While custom PAC file hosting validates basic JavaScript, it does not validate your intent for traffic routing and JavaScript logic that was implemented. We recommend that you approach PAC files as any other custom code artifact and review the code before relying on it in production. One way to achieve this is to use AI tools to review proposed PAC file contents and check it for validity, syntax, and intended logic. Example prompt: "Analyze this custom proxy automatic configuration file for explicit forward proxy. Check for syntax and routing decisions logic. Produce a report that includes details on what conditions influence routing decisions."

1. Sign in to the [Microsoft Entra Admin Center](https://entra.microsoft.com) as at least a [Global Secure Access Administrator](/entra/identity/role-based-access-control/permissions-reference#global-secure-access-administrator).
1. Browse to **Global Secure Access** > **Connect** > **Session Management**.
1. Select the **Explicit Forward Proxy** tab.
1. In the **Internet Access** section, select the link to download the default PAC file for your tenant.
:::image type="content" source="media/how-to-custom-proxy-autoconfiguration-files/download-template.png" alt-text="Screenshot of the Explicit Forward Proxy configuration page." lightbox="media/how-to-custom-proxy-autoconfiguration-files/download-template.png":::

1. Open the downloaded PAC file in a text editor.
1. Delete lines that start with "var tenantId" and "var efpEndpoint".
1. Update the line that starts with "var efpURL" to the following code:
   ```javascript
   var efpURL = "HTTPS ${GSAEFP}";
   ```
1. Make your modifications to implement your custom PAC file logic. Always use the **${GSAEFP}** variable when you reference the EFP proxy endpoint.
1. Save the PAC file with a *.pac extension.
1. Next to **Custom PAC files**, select **Manage**.
1. Select **+ Add PAC file**.
1. Enter a unique **Name** for the PAC file. The `.pac` extension is appended automatically.
1. Select **Load from file**. In the file picker dialog box, find the custom PAC file you modified and select it.
:::image type="content" source="media/how-to-custom-proxy-autoconfiguration-files/upload-file.png" alt-text="Screenshot of the Explicit Forward Proxy upload file page." lightbox="media/how-to-custom-proxy-autoconfiguration-files/upload-file.png":::

1. Set the **Enabled** toggle to **On** when you're ready to make the file available to devices.
1. Select **Save**.
:::image type="content" source="media/how-to-custom-proxy-autoconfiguration-files/save-configuration.png" alt-text="Screenshot of the Explicit Forward Proxy save configuration page." lightbox="media/how-to-custom-proxy-autoconfiguration-files/save-configuration.png":::

## Edit a custom PAC file

1. In the **Custom PAC files** panel, select the PAC file you want to edit.
1. Make your changes in the editor.
1. Select **Save**.

> [!IMPORTANT]
> Connected devices cache PAC files. Edits to an enabled file can take some time to roll out to all devices using the file.

## Enable or disable a custom PAC file

You can enable or disable a custom PAC file without deleting it:

1. In the **Custom PAC files** panel, select the PAC file.
1. Toggle the **Enabled** switch on or off.
1. Select **Save**.

When a PAC file is disabled, users with browsers that are configured with the URL of that PAC could experience issues with accessing resources. Ensure that browser PAC file settings are reconfigured before you disable existing PAC files. 

## PAC file placeholder variables

Global Secure Access provides placeholder variables that are substituted with the correct values when the PAC file is served to devices. Variable values are replaced contextually at the time when the browser requests the PAC file. 

| Variable | Description |
|----------|-------------|
| `${GSAEFP}` | The Explicit Forward Proxy hostname for your tenant. To route traffic through GSA EFP, use this variable in `PROXY` or `HTTPS` return statements. |


## Considerations and limitations

- **Caching**: Connected devices cache PAC files. When you edit an enabled PAC file, changes might take time to propagate to all devices.
- **Maximum PAC file size**: you can upload files that are up to 950 KB in size. Larger PAC files take longer to load and we recommend that you avoid exceeding 250 KB for each PAC file.
- **Maximum number of PAC files**: you can have up to 20 PAC files hosted in your tenant.

## Related content

- [What is Global Secure Access?](/entra/global-secure-access/overview-what-is-global-secure-access)
- [Configure Explicit Forward Proxy](/entra/global-secure-access/how-to-configure-explicit-forward-proxy)
- [Learn about Explicit Forward Proxy](/entra/global-secure-access/concept-explicit-forward-proxy)
