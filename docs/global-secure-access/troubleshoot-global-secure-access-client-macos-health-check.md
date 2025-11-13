---
title: "Troubleshoot the macOS Global Secure Access client: Health check"
description: Troubleshoot the macOS Global Secure Access client using the Health check tab in the Advanced diagnostics utility.
ms.service: global-secure-access
ms.topic: troubleshooting
ms.date: 11/12/2025
ms.author: jayrusso
author: HULKsmashGithub
manager: dougeby
ms.reviewer: LuisPFlores
ms.custom: sfi-image-nochange

# Customer intent: I want to troubleshoot the macOS Global Secure Access client using the Health check tab in the Advanced diagnostics utility.

---
# Troubleshoot the macOS Global Secure Access client: Health check tab
This document provides troubleshooting guidance for the macOS Global Secure Access client using the **Health check** tab in the Advanced diagnostics utility.

## Introduction
The Advanced diagnostics Health check runs tests to verify that the macOS Global Secure Access client is working correctly and that its components are running.

## Run the health check
To run a health check for the macOS Global Secure Access client:
1. Select **Global Secure Access** in the menu bar and select **Settings**.   
    :::image type="content" source="media/troubleshoot-global-secure-access-client-macos-health-check/system-tray-settings.png" alt-text="Screen shot of the system tray menu with the Settings option highlighted.":::
1. Select the **Troubleshooting** tab. 
1. In the **Advanced Diagnostics tool** section, select **Run tool**.
1. In the **Advanced Diagnostics** window, select the **Health Check** tab. Switching tabs runs the health check.   

### Resolution process
Most of the Health check tests depend on one another. If tests fail:
1. Resolve the first failed test in the list.
1. Select **Refresh** to view the updated test status.
1. Repeat until you resolve all failed tests.   
    :::image type="content" source="media/troubleshoot-global-secure-access-client-macos-health-check/macos-health-check-results.png" alt-text="Screen shot of the macOS Global Secure Access client, open to the Health check tab, with example health check results listed.":::

## Health check tests
The following checks verify the health of the Global Secure Access client.

### Notifications enabled
Notifications for macOS client are enabled. If disabled, enable the notifications from System Settings.

<img src="./attachments/img03.png" alt="Left Aligned Image" width="40%">


### System extension
Indicates whether the client's System Extension is installed and active. If this test fails, do the following:
1. Check if there is an option to "Allow System Extension" visible in the client menu bar options. If this option is visible, use it to enable the system extension.

 <img src="./attachments/img04.png" alt="Left Aligned Image" width="20%">


2. Check if there is a request to allow the system extension visible in Privacy and Security settings.

<img src="./attachments/img05.png" alt="Left Aligned Image" width="45%">


3. Use the following command to check if the system extension is running and enabled:
```
     systemextensionsctl list | grep -E '.*com.microsoft.naas.globalsecure.tunnel-df.*Global Secure Access'
```
<img src="./attachments/img06.png" alt="Left Aligned Image" width="90%">

### Transparent proxy service
Indicates whether the Transparent Proxy Service is running. If the test fail, try to enable the Transparent Proxy: 
1. Open System Settings
2. Select Network
3. Select Filters
4. Verify that the Global Secure Access Transparent Proxy is enabled. If it's disabled, enable it. 
5. If enabling the Transparent Proxy fails, check in the log file.

<img src="./attachments/img07.png" alt="Left Aligned Image" width="45%">

### UI - System Extension Bridge (IPC)
Indicates whether System Extension Bridge is active.
If the test fails, disable and re-enable the client. 

### Connected Active Interface
Shows the active interface being used for traffic. Run `ifconfig` to see all the active interfaces. We get this info from this path State:/Network/Global/IPv4
``` 
  scutil <<< "show State:/Network/Global/IPv4"
```

### Tunnel interface (L3)
This test shows the name of the tunnel interface used by the client. If the test fails, the tunnel interface was not created successfully. To fix the issue: 
1. Disable and re-enable client from the system tray
2. Look for errors in the logs file (Amit, which log file?) (tunnel log file)

### DNS Server IP
This test shows the IP of the preferred DNS server configured at the OS level. A DNS server that can resolve internet hostnames must be set for the client to work. An empty value means that no DNS server is configured. 

<img src="./attachments/img08.png" alt="Left Aligned Image" width="50%">

### Is Non-Encrypted DNS
For the client to acquire network traffic by FQDN destination (as opposed to IP destination), the client needs to read the DNS requests sent by the device to the DNS server. Hence, DNS over HTTPS needs to be disabled, if the forwarding profile contains FQDNs rules.
<!-->we need a better way to detect Encrypted DNS then a fixed number of IP adresses.-->
For system user can run below command to check if using a secure DNS,some examples of secure DNS servers are:
* Google DNS: 8.8.8.8, 8.8.4.4
* Cloudflare DNS: 1.1.1.1, 1.0.0.1
* OpenDNS: 208.67.222.222, 208.67.220.220

```
 scutil --dns | grep 'nameserver\[[0-9]*\'
```

<img src="./attachments/img09.png" alt="Left Aligned Image" width="30%">

If you want to know if a specific port is closed, use the `nc` command (Netcat).

<img src="./attachments/img13.png" alt="Left Aligned Image" width="55%">

if is closed then it is not encrypted dns. If any one of the connections succeeds then it encrypted DNS server.

### Authentication succeeded
Authentication to Global Secure Access succeeded. If the test fails:
1. Look for an interactive sign in window. It might require interactive sign in or present an error for a failed authentication that need be fixed. 
2. Open Company Portal and verify that the device is registered to your Entra tenant and that user is signed-in
3. look at the logs: **com.microsoft.naas.globalsecure-df xx.xx.xx.xx.log**


### Forwarding profile cached in a file
This test checks that a forwarding profile exists in the file system. If the test fails, do the following: 
1. Click on the system tray icon -> choose **Settings** -> On the Troubleshooting tab press clear cache. 
2. The user will be prompted to sign in again to the client.
3. An updated forwarding profile will be retrieved from the Global Secure Access service. 
4. Run the test again. 
5. If the test fails, look for an error in the log file. The tunnel log file for errors and this plist file for checking if policy is stored in the path:

```
 /private/var/root/Library/Preferences/com.microsoft.naas.globalsecure.tunnel-df.plist
```

### Breakglass mode disabled
Break-glass mode allows the IT admin to stop the client from tunneling any network traffic to the Global Secure Access cloud service. This is done by unchecking all the traffic profiles in Global Secure Access portal, which results in a forwarding profile that does not contain rules to tunnel any traffic. 

If break-glass mode is enabled, the client is not expected to tunnel any traffic.

If you would like the client to acquire traffic and send it to Global Secure Access service, enable at least one of the traffic profile according to your organization's needs.
This setting can be modified by the tenant admin in the Entra portal, under Global Secure Access, Connect, [Traffic forwarding](https://entra.microsoft.com/#view/Microsoft_Azure_Network_Access/ForwardingProfile.ReactView).

After the change in the portal, the updated forwarding profile should be received by the clients within 1 hour. 



### Proxy configured
A test that checks whether proxy is configured on the device. If the end-user device is configured to use a proxy for outgoing traffic to the internet, the destination IPs/FQDNs acquired by the client need to be excluded by a PAC file (or WPAD). 

### Changes to PAC file: 
Add the FQDNs/IPs to be tunneled to Global Secure Access edge as exclusions in the PAC file, so that HTTP requests for these destinations won’t be redirected to the proxy. (These FQDNs/IPs are also set to be tunneled to Global Secure Access in the forwarding profile). 

For the client's status health to be shown properly, add the FQDN used for health probing to the exclusions list: edgediagnostic.globalsecureaccess.microsoft.com

Example for a PAC file containing exclusions:   

```
function FindProxyForURL(url, host) {  
        if (isPlainHostName(host) ||   
            dnsDomainIs(host, ".edgediagnostic.globalsecureaccess.microsoft.com") || //tunneled
            dnsDomainIs(host, ".contoso.com") || //tunneled 
            dnsDomainIs(host, ".fabrikam.com")) // tunneled 
           return "DIRECT";                    // For tunneled destinations, use "DIRECT" connection (and not the proxy)
        else                                   // for all other destinations 
           return "PROXY 10.1.0.10:8080";  // route the traffic to the proxy.
}

```

<!--Amit, how do we make sure that the GRPC connection is forwarded to the proxy. (need to understand more)-->
### Internet Reachable
Checks whether the internet is reachable or not when the client is running.
Run the following command in terminal:

```
curl https://internet.edgediagnostic.globalsecureaccess.microsoft.com:6543/connectivitytest/ping
```

### Diagnostic URLs in forwarding profile
This test is conducted for each channel activated in the forwarding profile, checking that the configuration contains a URI for probing the service's health. The health status can be viewed by double-clicking on the system tray icon. 
If this test fails, it is usually an internal problem in Global Secure Access and macOS support team needs to be contacted. 

###  Diagnostics URL's monitoring status
This test verified whether the diagnostics URL's monitoring is working or not. If the test fails, disable and re-enable the client. 

### Magic-IP received for EDS
This test validates if magic IP is received for EDS URLs. If the test fails, do the following:
1. Ensure that the DNS Server is responsive by running `nslookup microsoft.com` and verify that an answer was returned, for example:

   <img src="./attachments/img14.png" alt="Left Aligned Image" width="20%">
1. Ensure that the DNS server set on your macOS device doesn't support Secure DNS. 

### Edges are reachable 

```
nc -vz 9d39e890-4c9e-433b-9b7a-625f7e26d855.m365.client.globalsecureaccess.microsoft.com 443
```

<img src="./attachments/img15.png" alt="Left Aligned Image" width="85%">

### Tunneling succeeded
This test validates if tunneling succeeded for all EDS URLs. if it fails, do the following:
1. make sure that all other health check tests passed. 
2. make sure that tunneling works on other devices 
3. check logs 
4. restart the client
5. open a case in Microsoft

* * *

## 📋 How to Use Diagnostic Scripts

### 🔋 Battery Health Logs Collection

One can collect battery health and usage data from your machine using the provided script.
1.  **Download the script**:  
    [collect_battery_diagnostics.zip](https://chatgpt.com/.attachments/collect_battery_diagnostics-0d142459-c9e0-4a40-a207-1425e090d550.zip)
    
2.  **Run the script**:
    *   Unzip the downloaded file.
        
    *   Open Terminal and run:
        
            ./collect_battery_diagnostics.sh
            
        
3.  **Wait for completion**:  
    The script may take up to **15 minutes** to gather all battery stats and will generate a **ZIP file** containing the report.
    

* * *

### 🗂️ Logs Collection via Terminal

To collect client logs directly from the command line:
1.  Open Terminal and run the following command:
    
        sudo /Applications/GlobalSecureAccessClient/Global\ Secure\ Access\ Client.app/Contents/Resources/install_scripts/collect_and_export_logs
        
    
2.  Once completed:
    *   A **Finder window** will open showing the logs directory.
        
    *   A **ZIP file** containing the collected logs will be saved in your **home directory**.
        

* * *
