---
# Required metadata
# For more information, see https://learn.microsoft.com/en-us/help/platform/learn-editor-add-metadata
# For valid values of ms.service, ms.prod, and ms.topic, see https://learn.microsoft.com/en-us/help/platform/metadata-taxonomies

title: 'Admin Control for SSO prompts '
description: IT administrators can now automatically accept SSO permissions on managed Windows devices using a supported registry setting.
author:      ploegert # GitHub alias
ms.author:   jploegert # Microsoft alias
ms.service: entra-id
ms.topic: article
ms.date:     07/14/2026
manager: asteen
---
# Admin control for SSO prompts in Windows


IT administrators can now **automatically accept SSO permissions** on managed Windows devices using a supported registry setting. In this context, SSO, or single sign-on, refers to using the Microsoft credentials from a user’s Windows sign-in to access other Microsoft apps and services without any prompts. This new capability is available beginning with the **July 2026 monthly security update** for Windows 11, version 24H2 and 25H2 via the [2026—KB5101650](https://support.microsoft.com/en-us/servicing/os/windows-11/2026/07/july-14-2026-kb5101650-os-builds-26200-8875-and-26100-8875) security update.

> [!IMPORTANT]
> - **Scope:** ✅ Applies only to **Windows** **managed enterprise devices** with Microsoft Entra ID accounts  
> - **Personal accounts:**  ❌ No admin control available — Prompts remain for personal Microsoft accounts (MSA)  
> - **Unmanaged devices:** ❌ No admin control available  —prompts remain for non-policy-controlled environments  
> - **Supported OS:** Windows 11, version 24H2 and 25H2 (with the [2026—KB5101650](https://support.microsoft.com/en-us/servicing/os/windows-11/2026/07/july-14-2026-kb5101650-os-builds-26200-8875-and-26100-8875) security update)


## Background: What changed and why 

In the European Economic Area (EEA), Microsoft updated the Windows sign-in experience so that users are not automatically signed in to other Microsoft applications and services after signing in to Windows. Instead, Windows asks users whether they want to use the same credentials to sign in to additional apps or services — giving users choice over how their Windows account is used for sign-in. For reference, review the original [blog post](https://techcommunity.microsoft.com/blog/windows-itpro-blog/upcoming-changes-to-windows-single-sign-on/4008151).

The notice appears the first time a user uses an app that enables sign-in with a personal Microsoft account, or work or school Entra ID, after signing in to Windows. If the user chooses to use the same credentials they used to sign in to Windows, this notice will not appear again.

![Image has a background of Microsoft Word with a dialog zoomed in that is overlayed in front of the background that has a Microsoft Logo on top, the second line reads "kelly@contoso.com", Third row that has a header titled "Continue to sign in?" The fourth row has with text saying "When you sign in, we use your accounts to sign you into other Microsoft apps and services. The fifth row states "Learn more at aka.ms/sso-info".  Below that information, two buttons appear - "Don't sign in" in grey background, and "continue" with a blue background that is the default selection.](media/sso-admin-control/sso-prompt.png)

For managed enterprise environments, some organizations wanted additional flexibility to manage the SSO prompt experience on devices where their organizations already manage sign-in policies and trust relationships. To support those scenarios, we’ve developed a registry-based control that lets IT administrators automatically accept SSO permissions on eligible managed Windows devices.


## Enterprise admin control for sign-in behavior 

Starting with the security update (as stated above) for Windows 11, version 24H2 and 25H2, IT administrators can deploy the following registry policy to automatically accept SSO permissions on managed devices: 

> **Registry Path:** HKLM\SOFTWARE\Policies\Microsoft\Windows\AAD    
> **Value:** AutoAcceptSsoPermission (DWORD) = 1 


![The image displays the registry editor on windows. The first line shows the path of "Computer\HKEY_LOCAL_MACHIEN\SOFTWARE\Policies\Microsoft\AAD. Below that, there is a tree view and a content pane to the right. The treeview shows "Policies", with children of "Adobe", "Google", "Microsoft", and "Microsoft has a child value of "AAD". To the right, we see the registry key that is being created. The name is "AutoAcceptSsoPermission", and to the right a pop up is displayed for creating/editing a new value with ValueName of AutoAcceptSsoPermission, ValueData as 1, and Base has a value of "Hexadecimal".](media/sso-admin-control/sso-admin-control-registry-path.png)

## Getting started

To use the admin control for the SSO Prompt:

1. Ensure that your devices are running the supported Windows version and have applied the security update mentioned above.
2. This policy can be deployed via: 
    - Group Policy (GPO) 
    - Microsoft Intune or similar mobile device management (MDM) tool 
    - Microsoft Configuration Manager 
    - Any management tool that supports registry policy deployment 
3. Validate SSO behavior across your managed device fleet. 

## Next steps

- [https://aka.ms/sso-info](https://aka.ms/sso-info)
- [What is a device identity?](https://github.com/MicrosoftDocs/entra-docs/blob/main/docs/identity/devices/overview.md)
