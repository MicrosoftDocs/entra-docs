---
title: Using networks and countries/regions in Microsoft Entra ID
description: Use GPS locations and public IPv4 and IPv6 networks in Conditional Access policy to make access decisions.

ms.service: entra-id
ms.subservice: conditional-access
ms.topic: conceptual
ms.date: 02/01/2024

ms.author: joflore
author: MicrosoftGuyJFlo
manager: amycolannino
ms.reviewer: lhuangnorth
---
# Using the location condition in a Conditional Access policy 

Conditional Access policies are at their most basic an if-then statement combining signals, to make decisions, and enforce organization policies. One of those signals is location.

![Conceptual Conditional signal plus decision to get enforcement](./media/location-condition/conditional-access-signal-decision-enforcement.png)

As mentioned in the blog post [IPv6 is coming to Microsoft Entra ID](https://techcommunity.microsoft.com/t5/microsoft-entra-azure-ad-blog/ipv6-coming-to-azure-ad/ba-p/2967451), we now support IPv6 in Microsoft Entra services.

Organizations can use these locations for common tasks like: 

- Requiring multifactor authentication for users accessing a service when they're off the corporate network.
- Blocking access for users accessing a service from specific countries or regions your organization never operates from.

The location is found using the public IP address a client provides to Microsoft Entra ID or GPS coordinates provided by the Microsoft Authenticator app. Conditional Access policies by default apply to all IPv4 and IPv6 addresses. For more information about IPv6 support, see the article [IPv6 support in Microsoft Entra ID](/troubleshoot/azure/active-directory/azure-ad-ipv6-support).

> [!TIP]
> Conditional Access policies are enforced after first-factor authentication is completed. Conditional Access isn't intended to be an organization's first line of defense for scenarios like denial-of-service (DoS) attacks, but it can use signals from these events to determine access.

## Named locations

Locations exist under **Protection** > **Conditional Access** > **Named locations**. These named network locations might include locations like an organization's headquarters network ranges, VPN network ranges, or ranges that you wish to block. Named locations are defined by IPv4 and IPv6 address ranges or by countries/regions. 

> [!VIDEO https://www.youtube.com/embed/P80SffTIThY]

### IPv4 and IPv6 address ranges

To define a named location by IPv4/IPv6 address ranges, you need to provide: 

- A **Name** for the location.
- One or more IP ranges.
- Optionally **Mark as trusted location**.

![New IP locations](./media/location-condition/new-trusted-location.png)

Named locations defined by IPv4/IPv6 address ranges are subject to the following limitations: 

- Configure up to 195 named locations.
- Configure up to 2000 IP ranges per named location.
- Both IPv4 and IPv6 ranges are supported.
- The number of IP addresses contained in a range is limited. Only CIDR masks greater than /8 are allowed when defining an IP range. 

#### Trusted locations

Locations such as your organization's public network ranges can be marked as trusted. This marking is used by features in several ways.

- Conditional Access policies can include or exclude these locations.
- Sign-ins from trusted named locations improve the accuracy of Microsoft Entra ID Protection's risk calculation, lowering a user's sign-in risk when they authenticate from a location marked as trusted.
- Locations marked as trusted can't be deleted. Remove the trusted designation before attempting to delete.

> [!WARNING]
> Even if you know the network and mark it as trusted does not mean you should exclude it from policies being applied. Verify explicitly is a core principle of a Zero Trust architecture. To find out more about Zero Trust and other ways to align your organization to the guiding principles, see the [Zero Trust Guidance Center](/security/zero-trust/).

### Countries/regions

Organizations can determine country/region location by IP address or GPS coordinates. 

To define a named location by country/region, you need to provide: 

- A **Name** for the location.
- Choose to determine location by IP address or GPS coordinates.
- Add one or more countries/regions.
- Optionally choose to **Include unknown countries/regions**.

![Country as a location](./media/location-condition/new-named-location-country-region.png)

If you select **Determine location by IP address**, the system collects the IP address of the device the user is signing into. When a user signs in, Microsoft Entra ID resolves the user's IPv4 or [IPv6](/troubleshoot/azure/active-directory/azure-ad-ipv6-support) address (starting April 3, 2023) to a country or region, and the mapping updates periodically. Organizations can use named locations defined by countries/regions to block traffic from countries/regions where they don't do business. 

If you select **Determine location by GPS coordinates**, the user needs to have the Microsoft Authenticator app installed on their mobile device. Every hour, the system contacts the user’s Microsoft Authenticator app to collect the GPS location of the user’s mobile device.

The first time the user must share their location from the Microsoft Authenticator app, the user receives a notification in the app. The user needs to open the app and grant location permissions. For the next 24 hours, if the user is still accessing the resource and granted the app permission to run in the background, the device's location is shared silently once per hour.

- After 24 hours, the user must open the app and approve the notification.
- Users who have number matching or additional context enabled in the Microsoft Authenticator app won't receive notifications silently and must open the app to approve notifications.
 
Every time the user shares their GPS location, the app does jailbreak detection (Using the same logic as the Intune MAM SDK). If the device is jailbroken, the location isn't considered valid, and the user isn't granted access. The Microsoft Authenticator app on Android uses the Google Play Integrity API to facilitate jailbreak detection. If the Google Play Integrity API is unavailable, the request is denied and the user isn't able to access the requested resource unless the Conditional Access policy is disabled. For more information about the Microsoft Authenticator app, see the article [Common questions about the Microsoft Authenticator app](https://support.microsoft.com/account-billing/common-questions-about-the-microsoft-authenticator-app-12d283d1-bcef-4875-9ae5-ac360e2945dd).

> [!NOTE]
> A Conditional Access policy with GPS-based named locations in report-only mode prompts users to share their GPS location, even though they aren't blocked from signing in.

GPS location doesn't work with [passwordless authentication methods](~/identity/authentication/concept-authentication-passwordless.md). 

Multiple Conditional Access policies might prompt users for their GPS location before all are applied. Because of the way Conditional Access policies are applied, a user might be denied access if they pass the location check but fail another policy. For more information about policy enforcement, see the article [Building a Conditional Access policy](concept-conditional-access-policies.md).

> [!IMPORTANT]
> Users may receive prompts every hour letting them know that Microsoft Entra ID is checking their location in the Authenticator app. The preview should only be used to protect very sensitive apps where this behavior is acceptable or where access needs to be restricted to a specific country/region.

#### Deny requests with modified location

Users can modify the location reported by iOS and Android devices. As a result, Microsoft Authenticator is updating its security baseline for location-based Conditional Access policies. Authenticator denies authentications where the user might be using a different location than the actual GPS location of the mobile device where Authenticator installed.  

In the November 2023 release of Authenticator, users who modify the location of their device get a denial message in Authenticator when they try location-based authentication. Beginning January 2024, any users that run older Authenticator versions are blocked from location-based authentication:
  
- Authenticator version 6.2309.6329 or earlier on Android
- Authenticator version 6.7.16 or earlier on iOS
  
To find which users run older versions of Authenticator, use [Microsoft Graph APIs](/graph/api/resources/microsoftauthenticatorauthenticationmethod#properties). 

#### Include unknown countries/regions

Some IP addresses don't map to a specific country or region. To capture these IP locations, check the box **Include unknown countries/regions** when defining a geographic location. This option allows you to choose if these IP addresses should be included in the named location. Use this setting when the policy using the named location should apply to unknown locations.

### Configure MFA trusted IPs

You can also configure IP address ranges representing your organization's local intranet in the [multifactor authentication service settings](https://account.activedirectory.windowsazure.com/usermanagement/mfasettings.aspx). This feature enables you to configure up to 50 IP address ranges. The IP address ranges are in CIDR format. For more information, see [Trusted IPs](~/identity/authentication/howto-mfa-mfasettings.md#trusted-ips).  

If you have Trusted IPs configured, they show up as **MFA Trusted IPs** in the list of locations for the location condition.

#### Skipping multifactor authentication

On the multifactor authentication service settings page, you can identify corporate intranet users by selecting  **Skip multifactor authentication for requests from federated users on my intranet**. This setting indicates that the inside corporate network claim, which is issued by AD FS, should be trusted and used to identify the user as being on the corporate network. For more information, see [Enable the Trusted IPs feature by using Conditional Access](~/identity/authentication/howto-mfa-mfasettings.md#enable-the-trusted-ips-feature-by-using-conditional-access).

After checking this option, including the named location **MFA Trusted IPs** will apply to any policies with this option selected.

For mobile and desktop applications, which have long lived session lifetimes, Conditional Access is periodically reevaluated. The default is once an hour. When the inside corporate network claim is only issued at the time of the initial authentication, we might not have a list of trusted IP ranges. In this case, it's more difficult to determine if the user is still on the corporate network:

1. Check if the user’s IP address is in one of the trusted IP ranges.
1. Check whether the first three octets of the user’s IP address match the first three octets of the IP address of the initial authentication. The IP address is compared with the initial authentication when the inside corporate network claim was originally issued and the user location was validated.

If both steps fail, a user is considered to be no longer on a trusted IP.

## Define locations

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](~/identity/role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Protection** > **Conditional Access** > **Named locations**.
1. Choose **New location**.
1. Give your location a name.
1. Choose **IP ranges** if you know the specific externally accessible IPv4 address ranges that make up that location or **Countries/Regions**.
   1. Provide the **IP ranges** or select the **Countries/Regions** for the location you're specifying.
      * If you choose Countries/Regions, you can optionally choose to include unknown areas.
1. Choose **Save**

## Location condition in policy

When you configure the location condition, you can distinguish between:

- Any location
- All trusted locations
- All Compliant Network locations
- Selected locations

### Any location

By default, selecting **Any location** causes a policy to apply to all IP addresses, which means any address on the Internet. This setting isn't limited to IP addresses you've configured as named location. When you select **Any location**, you can still exclude specific locations from a policy. For example, you can apply a policy to all locations except trusted locations to set the scope to all locations, except the corporate network.

### All trusted locations

This option applies to:

- All locations marked as trusted locations.
- **MFA Trusted IPs**, if configured.

#### Multifactor authentication trusted IPs

Using the trusted IPs section of multifactor authentication's service settings is no longer recommended. This control only accepts IPv4 addresses and should only be used for specific scenarios covered in the article [Configure Microsoft Entra multifactor authentication settings](~/identity/authentication/howto-mfa-mfasettings.md#trusted-ips)

If you have these trusted IPs configured, they show up as **MFA Trusted IPs** in the list of locations for the location condition.

### All Compliant Network locations

Organizations with access to Global Secure Access preview features have another location listed that is made up of users and devices that comply with your organization's security policies. For more information, see the section [Enable Global Secure Access signaling for Conditional Access](/entra/global-secure-access/how-to-compliant-network#enable-global-secure-access-signaling-for-conditional-access). It can be used with Conditional Access policies to perform a compliant network check for access to resources.

### Selected locations

With this option, you can select one or more named locations. For a policy with this setting to apply, a user needs to connect from any of the selected locations. When you **Select** the named network selection control that shows the list of named networks opens. The list also shows if the network location is marked as trusted.

## IPv6 traffic

Conditional Access policies apply to all IPv4 **and** [IPv6](/troubleshoot/azure/active-directory/azure-ad-ipv6-support) traffic (starting April 3, 2023).

<a name='identifying-ipv6-traffic-with-azure-ad-sign-in-activity-reports'></a>

### Identifying IPv6 traffic with Microsoft Entra Sign-in activity reports

You can discover IPv6 traffic in your tenant by going the [Microsoft Entra sign-in activity reports](~/identity/monitoring-health/concept-sign-ins.md). After you have the activity report open, add the “IP address” column and add a colon (**:**) to the field. This filter helps distinguish IPv6 traffic from IPv4 traffic.

You can also find the client IP by clicking a row in the report, and then going to the “Location” tab in the sign-in activity details. 

:::image type="content" source="media/location-condition/sign-in-logs-showing-ip-address-filter-for-ipv6.png" alt-text="A screenshot showing Microsoft Entra sign-in logs and an IP address filter for IPv6 addresses." lightbox="media/location-condition/sign-in-logs-showing-ip-address-filter-for-ipv6.png":::

> [!NOTE]
> IPv6 addresses from service endpoints may appear in the sign-in logs with failures due to the way they handle traffic. It's important to note that [service endpoints are not supported](/azure/virtual-network/virtual-network-service-endpoints-overview#limitations). If users are seeing these IPv6 addresses, remove the service endpoint from their virtual network subnet configuration.

## What you should know

### Cloud proxies and VPNs

When you use a cloud hosted proxy or VPN solution, the IP address Microsoft Entra ID uses while evaluating a policy is the IP address of the proxy. The X-Forwarded-For (XFF) header that contains the user’s public IP address isn't used because there's no validation that it comes from a trusted source, so would present a method for faking an IP address.

When a cloud proxy is in place, a policy that requires a [Microsoft Entra hybrid joined or compliant device](howto-conditional-access-policy-compliant-device.md#create-a-conditional-access-policy) can be easier to manage. Keeping a list of IP addresses used by your cloud hosted proxy or VPN solution up to date can be nearly impossible.

We recommend organizations utilize Global Secure Access to enable [source IP restoration](/entra/global-secure-access/how-to-source-ip-restoration) to avoid this change in address and simplify management.

### When is a location evaluated?

Conditional Access policies are evaluated when:

- A user initially signs in to a web app, mobile or desktop application.
- A mobile or desktop application that uses modern authentication, uses a refresh token to acquire a new access token. By default this check is once an hour.

This check means for mobile and desktop applications using modern authentication, a change in location is detected within an hour of changing the network location. For mobile and desktop applications that don’t use modern authentication, the policy applies on each token request. The frequency of the request can vary based on the application. Similarly, for web applications, policies apply at initial sign-in and are good for the lifetime of the session at the web application. Because of differences in session lifetimes across applications, the time between policy evaluation varies. Each time the application requests a new sign-in token, the policy is applied.

By default, Microsoft Entra ID issues a token on an hourly basis. After users move off the corporate network, within an hour the policy is enforced for applications using modern authentication.

### User IP address

The IP address used in policy evaluation is the public IPv4 or IPv6 address of the user. For devices on a private network, this IP address isn't the client IP of the user’s device on the intranet, it's the address used by the network to connect to the public internet.

### When you might block locations?

A policy that uses the location condition to block access is considered restrictive, and should be done with care after thorough testing. Some instances of using the location condition to block authentication might include:

- Blocking countries/regions where your organization never does business.
- Blocking specific IP ranges like:
   - Known malicious IPs before a firewall policy can be changed.
   - For highly sensitive or privileged actions and cloud applications.
   - Based on user specific IP range like access to accounting or payroll applications.

### User exclusions

[!INCLUDE [active-directory-policy-exclusions](~/includes/entra-policy-exclude-user.md)]

### Bulk uploading and downloading of named locations

When you create or update named locations, for bulk updates, you can upload or download a CSV file with the IP ranges. An upload replaces the IP ranges in the list with those ranges from the file. Each row of the file contains one IP Address range in CIDR format.

### API support and PowerShell

A preview version of the Graph API for named locations is available, for more information, see the [namedLocation API](/graph/api/resources/namedlocation).

## Next steps

- Configure an example Conditional Access policy using location, see the article [Conditional Access: Block access by location](howto-conditional-access-policy-location.yml).
