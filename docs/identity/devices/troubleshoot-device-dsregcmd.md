---
title: Troubleshoot devices by using the dsregcmd command
description: This article covers how to use the output from the dsregcmd command to understand the state of devices in Microsoft Entra ID.

ms.service: entra-id
ms.subservice: devices
ms.topic: troubleshooting
ms.date: 06/27/2025

ms.author: owinfrey
author: owinfreyATL
manager: dougeby
ms.reviewer: jploegert
---
# Troubleshoot devices by using the dsregcmd command

This article explains how to use the output from the `dsregcmd` command to understand the state of devices in Microsoft Entra ID. Run the `dsregcmd /status` utility as a domain user account.

## Device state

This section lists the device join state parameters. The criteria that are required for the device to be in various join states are listed in the following table:

| AzureAdJoined | EnterpriseJoined | DomainJoined | Device state |
| --- | --- | --- | --- |
| YES | NO | NO | Microsoft Entra joined |
| NO | NO | YES | Domain Joined |
| YES | NO | YES | Microsoft Entra hybrid joined |
| NO | YES | YES | On-premises DRS Joined |

> [!NOTE]
> The Workplace Joined (Microsoft Entra registered) state is displayed in the ["User state"](#user-state) section.

- **AzureAdJoined**: Set the state to *YES* if the device is joined to Microsoft Entra ID. Otherwise, set the state to *NO*.
- **EnterpriseJoined**: Set the state to YES if the device is joined to an on-premises Active Directory (AD). A device can't be both EnterpriseJoined and AzureAdJoined.

- **DomainJoined**: Set the state to *YES* if the device is joined to a domain (Active Directory).
- **DomainName**: Set the state to the name of the domain if the device is joined to a domain.

### Sample device state output

```
+----------------------------------------------------------------------+
| Device State                                                         |
+----------------------------------------------------------------------+
             AzureAdJoined : YES
          EnterpriseJoined : NO
              DomainJoined : YES
                DomainName : HYBRIDADFS
+----------------------------------------------------------------------+
```

## Device details

The state is displayed only when the device is Microsoft Entra joined or Microsoft Entra hybrid joined, not Microsoft Entra registered. This section lists device-identifying details that are stored in Microsoft Entra ID.

- **DeviceId**: The unique ID of the device in the Microsoft Entra tenant.
- **Thumbprint**: The thumbprint of the device certificate.
- **DeviceCertificateValidity**: The validity status of the device certificate.
- **KeyContainerId**: The containerId of the device private key associated with the device certificate.
- **KeyProvider**: The KeyProvider (Hardware/Software) used to store the device private key.
- **TpmProtected**: The state is set to *YES* if the device private key is stored in a hardware Trusted Platform Module (TPM).
- **DeviceAuthStatus**: Performs a check to determine the device's health in Microsoft Entra ID. The health statuses are:  
   - *SUCCESS* if the device is present and enabled in Microsoft Entra ID.  
   - *FAILED. Device is either disabled or deleted* if the device is either disabled or deleted. For more information about this issue, see [Microsoft Entra device management FAQ](faq.yml#why-do-my-users-see-an-error-message-saying--your-organization-has-deleted-the-device--or--your-organization-has-disabled-the-device--on-their-windows-10-11-devices).
   - *FAILED. ERROR* if the test was unable to run. This test requires network connectivity to Microsoft Entra ID under the system context.
   > [!NOTE]
   > The **DeviceAuthStatus** field was added in the Windows 10 May 2021 update (version 21H1).  
- **Virtual Desktop**: There are three cases where this line appears.
   - NOT SET - VDI device metadata isn't present on the device.
   - YES - VDI device metadata is present and dsregcmd outputs associated metadata including:
      - Provider: Name of the VDI vendor.
      - Type: Persistent VDI or non-persistent VDI.
      - User mode: Single user or multi-user.
      - Extensions: Number of key value pairs in optional vendor specific metadata, followed by key value pairs.
   - INVALID - The VDI device metadata is present but not set correctly. In this case, dsregcmd outputs the incorrect metadata.

### Sample device details output

```
+----------------------------------------------------------------------+
| Device Details                                                       |
+----------------------------------------------------------------------+

                  DeviceId : 00aa00aa-bb11-cc22-dd33-44ee44ee44ee
                Thumbprint : AA11BB22CC33DD44EE55FF66AA77BB88CC99DD00
 DeviceCertificateValidity : [ 2019-01-11 21:02:50.000 UTC -- 2029-01-11 21:32:50.000 UTC ]
            KeyContainerId : 00aa00aa-bb11-cc22-dd33-44ee44ee44ee
               KeyProvider : Microsoft Software Key Storage Provider
              TpmProtected : NO
          DeviceAuthStatus : SUCCESS
+----------------------------------------------------------------------+
```

## Tenant details

The tenant details are displayed only when the device is Microsoft Entra joined or Microsoft Entra hybrid joined, not Microsoft Entra registered. This section lists the common tenant details that are displayed when a device is joined to Microsoft Entra ID.

> [!NOTE]
> If the mobile device management (MDM) URL fields in this section are empty, it indicates either that the MDM wasn't configured or that the current user isn't in scope of MDM enrollment. Check the Mobility settings in Microsoft Entra ID to review your MDM configuration.
>
> The presence of MDM URLs doesn't guarantee that the device is managed by an MDM. The information is displayed if the tenant has MDM configuration for automatic enrollment even if the device itself isn't managed.

### Sample tenant details output

```
+----------------------------------------------------------------------+
| Tenant Details                                                       |
+----------------------------------------------------------------------+

                TenantName : HybridADFS
                  TenantId : aaaabbbb-0000-cccc-1111-dddd2222eeee
                       Idp : login.windows.net
               AuthCodeUrl : https://login.microsoftonline.com/aaaabbbb-0000-cccc-1111-dddd2222eeee/oauth2/authorize
            AccessTokenUrl : https://login.microsoftonline.com/aaaabbbb-0000-cccc-1111-dddd2222eeee/oauth2/token
                    MdmUrl : https://enrollment.manage-beta.microsoft.com/EnrollmentServer/Discovery.svc
                 MdmTouUrl : https://portal.manage-beta.microsoft.com/TermsOfUse.aspx
          MdmComplianceUrl : https://portal.manage-beta.microsoft.com/?portalAction=Compliance
               SettingsUrl : eyJVx{lots of characters}xxxx==
            JoinSrvVersion : 1.0
                JoinSrvUrl : https://enterpriseregistration.windows.net/EnrollmentServer/device/
                 JoinSrvId : urn:ms-drs:enterpriseregistration.windows.net
             KeySrvVersion : 1.0
                 KeySrvUrl : https://enterpriseregistration.windows.net/EnrollmentServer/key/
                  KeySrvId : urn:ms-drs:enterpriseregistration.windows.net
        WebAuthNSrvVersion : 1.0
            WebAuthNSrvUrl : https://enterpriseregistration.windows.net/webauthn/aaaabbbb-0000-cccc-1111-dddd2222eeee/
             WebAuthNSrvId : urn:ms-drs:enterpriseregistration.windows.net
    DeviceManagementSrvVer : 1.0
    DeviceManagementSrvUrl : https://enterpriseregistration.windows.net/manage/aaaabbbb-0000-cccc-1111-dddd2222eeee/
     DeviceManagementSrvId : urn:ms-drs:enterpriseregistration.windows.net
+----------------------------------------------------------------------+
```

## User state

This section lists the statuses of various attributes for users who are currently logged in to the device.

> [!NOTE]
> The command must run in a user context to retrieve a valid status.

- **NgcSet**: Set the state to *YES* if a Windows Hello key is set for the current logged-in user.
- **NgcKeyId**: The ID of the Windows Hello key if one is set for the current logged-in user.
- **CanReset**: Denotes whether the Windows Hello key can be reset by the user.
- **Possible values**: DestructiveOnly, NonDestructiveOnly, DestructiveAndNonDestructive, or Unknown if error.
- **WorkplaceJoined**: Set the state to *YES* if Microsoft Entra registered accounts have been added to the device in the current NTUSER context.
- **WamDefaultSet**: Set the state to *YES* if a Web Account Manager (WAM) default WebAccount is created for the logged-in user. This field could display an error if `dsregcmd /status` is run from an elevated command prompt.
- **WamDefaultAuthority**: Set the state to *organizations* for Microsoft Entra ID.
- **WamDefaultId**: Always use *https://login.microsoft.com* for Microsoft Entra ID.
- **WamDefaultGUID**: The WAM provider's (Microsoft Entra ID / Microsoft account) GUID for the default WAM WebAccount.

### Sample user state output

```
+----------------------------------------------------------------------+
| User State                                                           |
+----------------------------------------------------------------------+

                    NgcSet : YES
                  NgcKeyId : {aaaaaaaa-0b0b-1c1c-2d2d-333333333333}
                  CanReset : DestructiveAndNonDestructive
           WorkplaceJoined : NO
             WamDefaultSet : YES
       WamDefaultAuthority : organizations
              WamDefaultId : https://login.microsoft.com
            WamDefaultGUID : { B16898C6-A148-4967-9171-64D755DA8520 } (AzureAd)

+----------------------------------------------------------------------+
```

## SSO state

You can ignore this section for Microsoft Entra registered devices.

> [!NOTE]
> The command must run in a user context to retrieve that user's valid status.

- **AzureAdPrt**: Set the state to *YES* if a Primary Refresh Token (PRT) is present on the device for the logged-in user.
- **AzureAdPrtUpdateTime**: Set the state to the time, in Coordinated Universal Time (UTC), when the [PRT was last updated](concept-primary-refresh-token.md#how-is-a-prt-renewed).
- **AzureAdPrtExpiryTime**: Set the state to the time, in UTC, when the PRT is going to expire if it isn't renewed.
- **AzureAdPrtAuthority**: The Microsoft Entra authority URL
- **EnterprisePrt**: Set the state to *YES* if the device has a PRT from on-premises Active Directory Federation Services (AD FS). For Microsoft Entra hybrid joined devices, the device could have a PRT from both Microsoft Entra ID and on-premises Active Directory simultaneously. On-premises joined devices have only an Enterprise PRT.
- **EnterprisePrtUpdateTime**: Set the state to the time, in UTC, when the Enterprise PRT was last updated.
- **EnterprisePrtExpiryTime**: Set the state to the time, in UTC, when the PRT is going to expire if it isn't renewed.
- **EnterprisePrtAuthority**: The AD FS authority URL

> [!NOTE]
> The following PRT diagnostics fields were added in the Windows 10 May 2021 update (version 21H1).
>
> - The diagnostics information that's displayed in the **AzureAdPrt** field is for Microsoft Entra PRT acquisition or refresh, and the diagnostics information that's displayed in the **EnterprisePrt** field is for Enterprise PRT acquisition or refresh.
> - The diagnostics information is displayed only if the acquisition or refresh failure happened after the last successful PRT update time (AzureAdPrtUpdateTime/EnterprisePrtUpdateTime).  
>On a shared device, this diagnostics information could be from a different user's login attempt.

- **AcquirePrtDiagnostics**: Set the state to *PRESENT* if the acquired PRT diagnostics information is present in the logs.  
   - This field is skipped if no diagnostics information is available.
- **Previous Prt Attempt**: The local time, in UTC, at which the failed PRT attempt occurred.  
- **Attempt Status**: The client error code that's returned (HRESULT).
- **User Identity**: The UPN of the user for whom the PRT attempt happened.
- **Credential Type**: The credential used to acquire or refresh the PRT. Common credential types are Password and Next Generation Credential (NGC) (for Windows Hello).
- **Correlation ID**: The correlation ID sent by the server for the failed PRT attempt.
- **Endpoint URI**: The last endpoint accessed before the failure.
- **HTTP Method**: The HTTP method used to access the endpoint.
- **HTTP Error**: WinHttp transport error code. Get other [network error codes](/windows/win32/winhttp/error-messages).
- **HTTP Status**: The HTTP status returned by the endpoint.
- **Server Error Code**: The error code from the server.  
- **Server Error Description**: The error message from the server.
- **RefreshPrtDiagnostics**: Set the state to *PRESENT* if the acquired PRT diagnostics information is present in the logs.  
   - This field is skipped if no diagnostics information is available.
   - The diagnostics information fields are same as **AcquirePrtDiagnostics**.

> [!NOTE]
> The following Cloud Kerberos diagnostics fields were added in the original release of Windows 11 (version 21H2).

- **OnPremTgt**: Set the state to *YES* if a Cloud Kerberos ticket to access on-premises resources is present on the device for the logged-in user.
- **CloudTgt**: Set the state to *YES* if a Cloud Kerberos ticket to access cloud resources is present on the device for the logged-in user.
- **KerbTopLevelNames**: List of top level Kerberos realm names for Cloud Kerberos.

### Sample SSO state output

```
+----------------------------------------------------------------------+
| SSO State                                                            |
+----------------------------------------------------------------------+

                AzureAdPrt : NO
       AzureAdPrtAuthority : https://login.microsoftonline.com/aaaabbbb-0000-cccc-1111-dddd2222eeee
     AcquirePrtDiagnostics : PRESENT
      Previous Prt Attempt : 2020-07-18 20:10:33.789 UTC
            Attempt Status : 0xc000006d
             User Identity : john@contoso.com
           Credential Type : Password
            Correlation ID : aaaa0000-bb11-2222-33cc-444444dddddd
              Endpoint URI : https://login.microsoftonline.com/aaaabbbb-0000-cccc-1111-dddd2222eeee/oauth2/token/
               HTTP Method : POST
                HTTP Error : 0x0
               HTTP status : 400
         Server Error Code : invalid_grant
  Server Error Description : AADSTS50126: Error validating credentials due to invalid username or password.
             EnterprisePrt : YES
   EnterprisePrtUpdateTime : 2019-01-24 19:15:33.000 UTC
   EnterprisePrtExpiryTime : 2019-02-07 19:15:33.000 UTC
    EnterprisePrtAuthority : https://fs.hybridadfs.nttest.microsoft.com:443/adfs
                 OnPremTgt : YES
                  CloudTgt : YES
         KerbTopLevelNames : .windows.net,.windows.net:1433,.windows.net:3342,.azure.net,.azure.net:1433,.azure.net:3342

+----------------------------------------------------------------------+
```

## Diagnostics data

### Pre-join diagnostics

This diagnostics section is displayed only if the device is domain-joined and unable to Microsoft Entra hybrid join.

This section performs various tests to help diagnose join failures. The information includes the: error phase, error code, server request ID, server response HTTP status, and server response error message.

- **User Context**: The context in which the diagnostics are run. Possible values: SYSTEM, UN-ELEVATED User, ELEVATED User.

   > [!NOTE]
   > Because the actual join is performed in SYSTEM context, running the diagnostics in SYSTEM context is closest to the actual join scenario. To run diagnostics in SYSTEM context, the `dsregcmd /status` command must be run from an elevated command prompt.

- **Client Time**: The system time, in UTC.
- **AD Connectivity Test**: This test performs a connectivity test to the domain controller. An error in this test likely results in join errors in the pre-check phase.
- **AD Configuration Test**: This test reads and verifies whether the Service Connection Point (SCP) object is configured properly in the on-premises Active Directory forest. Errors in this test would likely result in join errors in the discover phase with the error code 0x801c001d.
- **DRS Discovery Test**: This test gets the DRS endpoints from discovery metadata endpoint and performs a user realm request. Errors in this test would likely result in join errors in the discover phase.
- **DRS Connectivity Test**: This test performs a basic connectivity test to the DRS endpoint.
- **Token Acquisition Test**: This test tries to get a Microsoft Entra authentication token if the user tenant is federated. Errors in this test would likely result in join errors in the authentication phase. If authentication fails, sync-join is attempted as fallback, unless fallback is explicitly disabled with the following registry key settings:

   ```
   Keyname: Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CDJ
   Value: FallbackToSyncJoin
   Type:  REG_DWORD
   Value: 0x0 -> Disabled
   Value: 0x1 -> Enabled
   Default (No Key): Enabled
   ```

- **Fallback to Sync-Join**: Set the state to *Enabled* if the preceding registry key to prevent fallback to sync-join with authentication failures is *not* present. This option is available from Windows 10 1803 and later.
- **Previous Registration**: The time when the previous join attempt occurred. Only failed join attempts are logged.
- **Error Phase**: The stage of the join in which it was aborted. Possible values are *pre-check*, *discover*, *auth*, and *join*.
- **Client ErrorCode**: The client error code returned (HRESULT).
- **Server ErrorCode**: The server error code displayed if a request was sent to the server and the server responded with an error code.
- **Server Message**: The server message returned along with the error code.
- **Https Status**: The HTTP status returned by the server.
- **Request ID**: The client requestId sent to the server. The request ID is useful to correlate with server-side logs.

### Sample pre-join diagnostics output

The following example shows a diagnostics test failing with a discovery error.

```
+----------------------------------------------------------------------+
| Diagnostic Data                                                       |
+----------------------------------------------------------------------+

     Diagnostics Reference : www.microsoft.com/aadjerrors
              User Context : SYSTEM
               Client Time : 2019-01-31 09:25:31.000 UTC
      AD Connectivity Test : PASS
     AD Configuration Test : PASS
        DRS Discovery Test : FAIL [0x801c0021/0x801c000c]
     DRS Connectivity Test : SKIPPED
    Token acquisition Test : SKIPPED
     Fallback to Sync-Join : ENABLED

     Previous Registration : 2019-01-31 09:23:30.000 UTC
               Error Phase : discover
          Client ErrorCode : 0x801c0021

+----------------------------------------------------------------------+
```

The following example shows that diagnostics tests are passing but the registration attempt failed with a directory error, which is expected for sync-join. After the Microsoft Entra Connect synchronization job finishes, the device is able to join.

```
+----------------------------------------------------------------------+
| Diagnostic Data                                                       |
+----------------------------------------------------------------------+

     Diagnostics Reference : www.microsoft.com/aadjerrors
              User Context : SYSTEM
               Client Time : 2019-01-31 09:16:50.000 UTC
      AD Connectivity Test : PASS
     AD Configuration Test : PASS
        DRS Discovery Test : PASS
     DRS Connectivity Test : PASS
    Token acquisition Test : PASS
     Fallback to Sync-Join : ENABLED

     Previous Registration : 2019-01-31 09:16:43.000 UTC
         Registration Type : sync
               Error Phase : join
          Client ErrorCode : 0x801c03f2
          Server ErrorCode : DirectoryError
            Server Message : The device object by the given id (aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb) isn't found.
              Https Status : 400
                Request Id : 6bff0bd9-820b-484b-ab20-2a4f7b76c58e

+----------------------------------------------------------------------+
```

### Post-join diagnostics

This diagnostics section displays the output of checks performed on a device joined to the cloud.

- **AadRecoveryEnabled**: If the value is *YES*, the keys stored in the device aren't usable, and the device is marked for recovery. The next sign-in will trigger the recovery flow and re-register the device.
- **KeySignTest**: If the value is *PASSED*, the device keys are in good health. If KeySignTest fails, the device is usually marked for recovery. The next sign-in will trigger the recovery flow and re-register the device. For Microsoft Entra hybrid joined devices, the recovery is silent. While the devices are Microsoft Entra joined or Microsoft Entra registered, they prompt for user authentication to recover and re-register the device, if necessary.
   > [!NOTE]
   > The KeySignTest requires elevated privileges.

#### Sample post-join diagnostics output

```
+----------------------------------------------------------------------+
| Diagnostic Data                                                      |
+----------------------------------------------------------------------+

         AadRecoveryEnabled: NO
               KeySignTest : PASSED
+----------------------------------------------------------------------+
```

## NGC prerequisites check

This diagnostics section performs the prerequisites check for setting up Windows Hello for Business (WHFB).

> [!NOTE]
> You might not see NGC prerequisites check details in `dsregcmd /status` if the user configured WHFB successfully.

- **IsDeviceJoined**: Set the state to *YES* if the device is joined to Microsoft Entra ID.
- **IsUserAzureAD**: Set the state to *YES* if the logged-in user is present in Microsoft Entra ID.
- **PolicyEnabled**: Set the state to *YES* if the WHFB policy is enabled on the device.
- **PostLogonEnabled**: Set the state to *YES* if WHFB enrollment is triggered natively by the platform. If the state is set to *NO*, it indicates that Windows Hello for Business enrollment is triggered by a custom mechanism.
- **DeviceEligible**: Set the state to *YES* if the device meets the hardware requirement for enrolling with WHFB.
- **SessionIsNotRemote**: Set the state to *YES* if the current user is logged in directly to the device and not remotely.
- **CertEnrollment**: This setting is specific to WHFB Certificate Trust deployment, indicating the certificate enrollment authority for WHFB. Set the state to *enrollment authority* if the source of the WHFB policy is Group Policy, or set it to *mobile device management* if the source is MDM. If neither source applies, set the state to *none*.
- **AdfsRefreshToken**: This setting is specific to WHFB Certificate Trust deployment and present only if the CertEnrollment state is *enrollment authority*. The setting indicates whether the device has an enterprise PRT for the user.
- **AdfsRaIsReady**: This setting is specific to WHFB Certificate Trust deployment and present only if the CertEnrollment state is *enrollment authority*. Set the state to *YES* if AD FS indicates in discovery metadata that it supports WHFB *and* the logon certificate template is available.
- **LogonCertTemplateReady**: This setting is specific to WHFB Certificate Trust deployment and present only if the CertEnrollment state is *enrollment authority*. Set the state to *YES* if the state of the login certificate template is valid and helps troubleshoot the AD FS Registration Authority (RA).
- **PreReqResult**: Provides the result of all WHFB prerequisites evaluation. Set the state to *Will Provision* if WHFB enrollment would be launched as a post-login task when the user signs in next time.

> [!NOTE]
> The following Cloud Kerberos diagnostics fields were added in the Windows 10 May 2021 update (version 21H1).
>
> Before Windows 11 version 23H2, the setting **OnPremTGT** was named **CloudTGT**.

- **OnPremTGT**: This setting is specific to Cloud Kerberos trust deployment and present only if the CertEnrollment state is *none*. Set the state to *YES* if the device has a Cloud Kerberos ticket to access on-premises resources. Prior to Windows 11 version 23H2, this setting was named **CloudTGT**.

### Sample NGC prerequisites check output

```
+----------------------------------------------------------------------+
| Ngc Prerequisite Check                                               |
+----------------------------------------------------------------------+

            IsDeviceJoined : YES
             IsUserAzureAD : YES
             PolicyEnabled : YES
          PostLogonEnabled : YES
            DeviceEligible : YES
        SessionIsNotRemote : YES
            CertEnrollment : enrollment authority
          AdfsRefreshToken : YES
             AdfsRaIsReady : YES
    LogonCertTemplateReady : YES ( StateReady )
              PreReqResult : WillProvision
+----------------------------------------------------------------------+
```

## Next steps

Go to the [Microsoft Error Lookup Tool](/windows/win32/debug/system-error-code-lookup-tool).
