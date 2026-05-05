---
title: Configure a Microsoft Edge Application Management Policy for Explicit Forward Proxy
description: Learn how to configure a Microsoft Intune app management policy for Microsoft Edge to use the Explicit Forward Proxy feature of Global Secure Access.
ms.topic: how-to
ms.date: 04/22/2026
ms.subservice: entra-internet-access
ms.author: alexpav
author: idmdev
---

# Configure Microsoft Edge with Explicit Forward Proxy (preview) by using an Intune application management policy

You can automatically deliver proxy settings and automatic certificate authority trust settings in Microsoft Edge by using an Intune mobile application management (MAM) policy. The policy can take advantage of the Explicit Forward Proxy feature of Global Secure Access.

> [!IMPORTANT]
> The Explicit Forward Proxy feature is currently in preview. This information relates to a prerelease product that might be substantially modified before release. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

## Prerequisites

- A Microsoft Entra identity with at least the Global Secure Access Administrator Reader role and Intune Administrator role.
- Explicit Forward Proxy configured in the Microsoft Entra admin center.
- A security group in Microsoft Entra ID with users who should receive Explicit Forward Proxy configuration in Microsoft Edge.
- The plain-text public key of the Transport Layer Security (TLS) inspection root certificate that you used when you configured Microsoft Entra Internet Access TLS inspection.

## Limitations

- This method to apply a policy works only on Microsoft Edge for Windows.
- If mobile device management (MDM) is configured on the device, and the MDM policy has conflicting Microsoft Edge settings, the MAM policy isn't applied.

## Configuration

### 1. Get the URL of the PAC file

1. Open the [Microsoft Entra admin center](https://entra.microsoft.com).

1. Go to **Global Secure Access** > **Settings** > **Session management** > **Explicit Forward Proxy**.

1. Copy the URL of the proxy automatic configuration (PAC) file from settings page. Save it for the Intune app management policy that you configure next.

### 2. Select Microsoft Edge for the app

1. Open the [Intune admin center](https://intune.microsoft.com).

1. Under **Apps** > **Manage apps**, select **Configuration**.

1. Select **+ Create** > **Managed Apps**.

1. For **Name**, enter a name of your choice. For example, enter **GSA Explicit Forward Proxy Settings for Edge**.

1. For **Target policy to**, choose **Selected apps**.

1. Choose **+ Select public apps**. In the **Select apps to target** pane:

   1. Search for **Edge**.
   1. Select **Microsoft Edge** / **Windows**.
   1. Choose **Select**.

   ![Screenshot that shows Microsoft Edge and Windows selected for a public app.](media/how-to-configure-microsoft-edge-mam-policy/select-target-apps.png)

1. Select **Next** to advance to the **Settings catalog** tab.

### 3. Add proxy settings

1. Select **+ Add setting**.

1. In the **Settings picker** pane:

   1. Enter **proxy** in the search box, and then select **Search**.
   1. In the results, select **Microsoft Edge** > **Proxy server**.
   1. Select the **Proxy settings** checkbox.

      ![Screenshot that shows the configuration of proxy settings.](media/how-to-configure-microsoft-edge-mam-policy/proxy-settings.png)

   1. Enter **TLS** in the search box, and then select **Search**.
   1. In the search results, select **Microsoft Edge Certificate management settings**.
   1. Select the **TLS server certificates that should be trusted by Microsoft Edge** checkbox.

      ![Screenshot that shows the configuration of TLS certificate settings.](media/how-to-configure-microsoft-edge-mam-policy/tls-certificate-settings.png)

   1. Close the **Settings picker** pane (**X** on the upper right).

1. In the **Proxy Server** section, configure proxy settings as follows:

   ```json
   {"ProxyMode":"pac_script","ProxyPacMandatory":false,"ProxyPacUrl":"URL_you_copied_from_the_Entra_portal"}
   ```

### 4. Convert the key into a string

Convert the TLS inspection root public key (certificate) to a contiguous plain-text string. You can use either PowerShell or a Linux/macOS terminal.

#### PowerShell

1. Change the directory to where the `.pem` or `.cer` plain-text key is stored.

1. Confirm that the key is plain text by running the following command:

   ```powershell
   if ((Get-Content cert.pem -First 1) -match '-----BEGIN') { 'PEM (plain text)' } else { 'DER (binary)' }
   ```

   If the output is `PEM (plain text)`, you can continue. Otherwise, convert the binary encoded file to PEM.

1. Convert the PEM certificate string to extract only the key, without the line breaks:

   ```powershell
   (Get-Content cert.pem | Where-Object { $_ -notmatch '-----' }) -join ''
   ```

1. Copy the resulting string from the console output and save it for the next step.

#### Linux/macOS terminal

1. Change the directory to where the `.pem` or `.cer` plain-text key is stored.

1. Confirm that the key is plain text by running the following command:

   ```bash
   head -c 15 cert.pem | grep -q 'BEGIN' && echo 'PEM (plain text)' || echo 'DER (binary)'
   ```

   If the output is `PEM (plain text)`, you can continue. Otherwise, convert the binary encoded file to PEM.

1. Extract the key from the file, without the line breaks:

   ```bash
   awk '!/-----/{printf "%s",$0}' cert.pem | tr -d '\r'
   ```

1. Copy the resulting string from the console output and save it for the next step. Don't copy the trailing `%` if it appears in the terminal output.

### 5. Paste the copied string

1. In the **Certificate management settings** section, paste the output of the converted, plain-text string (without line breaks) into the text box.

   > [!NOTE]
   > Don't use the **Import** button in this section. Import is intended for bulk configuration settings, where you have multiple certificates that need to be trusted. The import function of the Intune portal expects a CSV file with a list of plain-text contiguous keys, not the PEM/CER file.

1. Your resulting configuration should look similar to the following screenshot. Select **Next**.

   ![Screenshot that shows a completed proxy and certificate configuration.](media/how-to-configure-microsoft-edge-mam-policy/completed-settings-configuration.png)

### 6. Assign the security group and create the policy

1. On the **Settings** pane, select **Next**.

1. On the **Assignments** pane:

   1. Select **Add Groups**.
   1. Select the security group in Microsoft Entra ID that contains users of Explicit Forward Proxy.
   1. Select **Next**.

1. Your **Review + create** pane should look similar to the following screenshot. Select **Create**.

   ![Screenshot that shows the pane for reviewing and creating a configured policy.](media/how-to-configure-microsoft-edge-mam-policy/review-create.png)

## Validation

1. Open Microsoft Edge on a Windows device. Sign in with a work or school account.

1. Go to `edge://policy`. Confirm that the policy settings that you configured for Explicit Forward Proxy appear.

   ![Screenshot that shows configured Microsoft Edge policy settings for Explicit Forward Proxy.](media/how-to-configure-microsoft-edge-mam-policy/edge-policy-validation.png)
