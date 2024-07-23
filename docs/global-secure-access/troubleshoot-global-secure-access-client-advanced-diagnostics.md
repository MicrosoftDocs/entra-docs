---
title: Troubleshoot the Global Secure Access client: advanced diagnostics
description: Troubleshoot the Global Secure Access client using the health check tab in the advanced diagnostics utility.
ms.service: global-secure-access
ms.topic: troubleshooting
ms.date: 07/22/2024
ms.author: jayrusso
author: HULKsmashGithub
manager: amycolannino
ms.reviewer: lirazb


# Customer intent: I want to troubleshoot the Global Secure Access client using the Advanced diagnostics utility.
---
# Troubleshoot the Global Secure Access client with advanced diagnostics
This document provides troubleshooting guidance for the Global Secure Access client using the advanced diagnostics utility.

## Introduction
The Global Secure Access client runs in the background and routes relevant network traffic to Global Secure Access. It doesn't require user interaction. The advanced diagnostics tool makes the client's behavior visible to the administrator and helps in troubleshooting.

## Launch the advanced diagnostics tool
To launch the advanced diagnostics tool:
1. Right-click the **Global Secure Access client** icon in the system tray.
1. Select **Advanced Diagnostics**. If enabled, User Account Control (UAC) prompts for elevation of privileges.

## Overview tab
The advanced diagnostics overview tab shows general configuration details about the client:
- **Username** - The Microsoft Entra user principal name of the user who authenticated to the client. To change the authenticated user.
- **Device ID** - The ID of the device in Microsoft Entra. The device must be joined to the tenant.
- **Tenant ID** - The ID of the tenant that the client points to, which is the same tenant the device is joined to.
- **Forwarding Profile ID** - The ID of the forwarding profile currently in use by the client.
- **Forwarding Profile last checked** - The time when the client last checked for an updated forwarding profile.
- **Client version** - The version of the Global Secure Access client that is currently installed on the device.

## Health Check tab
The health check tab executes