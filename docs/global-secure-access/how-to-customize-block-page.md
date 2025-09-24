---
title: How to customize the block page for web content filtering
description: Use custom block pages to display organization-specific messaging when users are blocked by web content filtering policies.
ms.author: fgomulka
ms.topic: how-to
ms.service: global-secure-access
ms.date: 09/24/2025
ms.reviewer: kenwith
ai-usage: ai-assisted
---

# How to customize the block page for web content filtering (preview)

Use this feature to provide a customized block page experience for users who are blocked by web content filtering and threat intelligence policies.

## Prerequisites

- You must be enrolled in the private preview for Custom Block Pages and have the appropriate preview access.
- A Global Secure Access Administrator or equivalent role in Microsoft Entra ID.

## Overview

The custom block page empowers you to customize the default body of the page from, "It's been restricted by your organization." you configure and preview tailored messaging to coincide with your organization's style guide when a user's request is blocked by a web content filtering policy. The feature 

## Configure a custom block page

1. Navigate to **Global Secure Access** > **Settings** > **Session management** > **Custom Block Page**
2. Switch **Custom body message** to **On**.
3. Configure the Customized body message you would prefer.
4. (Optional) Paste one or multiple clickable links via limited markdown language (e.g. `[click here](https://bing.com)`).
5. Preview the customized message with the **Preview** button.
6. Select **Save** to save the custom block page.


## Notes and limitations

- The Custom body message is limited to 1024 Unicode (utf-8) characters.
- Changes to a custom block page may take a few minutes to propagate to active sessions.
- The block experience differs for HTTP and HTTPS: HTTP can render the block page directly; HTTPS may show a connection reset behavior depending on browser and TLS interception. Test in your environment.
- Ensure any contact information you publish complies with your organization's privacy policies.

## Verify the block page

1. From a device with the Global Secure Access client installed and the Internet Access traffic forwarding profile enableed, attempt to navigate to a site that your policy blocks.
2. Observe the block experience and confirm the custom messaging displays (or that equivalent blocking behaviour occurs for HTTPS).

## Next steps

- If you need features beyond the preview's capabilities (richer templates, localization, or analytics), collect feedback and request expanded preview access from the product team.
- For gudidance on configuring web content filtering, see [Configure web content filtering](./how-to-configure-web-content-filtering.md).
- For gudidance on configuring threat intelligence, see [Configure threat intelligence](./how-to-configure-threat-intelligence.md).