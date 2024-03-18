---
title: Become a Microsoft-Compatible FIDO2 Security Key Vendor for sign-in to Microsoft Entra ID
description: Explains process to become a FIDO2 hardware partner
ms.date: 03/18/2023
ms.service: entra-id
ms.subservice: authentication
author: martincoetzer
ms.author: martinco
ms.topic: conceptual
---

# Become a Microsoft-compatible FIDO2 security key vendor

FIDO2 security keys enable phishing-resistant authentication. They can replace weak credentials with strong hardware-backed public/private-key credentials that can't be reused, replayed, or shared across services. Security keys support shared device scenarios, allowing you to carry your credential with you and safely authenticate on any aypported device. Microsoft partners with FIDO2 security key vendors to ensure that security devices work on supported browsers, native apps, and operating systems. 

You can become a Microsoft-compatible FIDO2 security key vendor through the following process.  Microsoft doesn't commit to do go-to-market activities with the partner and evaluates partner priority based on customer demand.


## Prerequisites

Microsoft relies on the FIDO metadata service to determine security key compatibility with Windows, Microsoft Edge browser, and online Microsoft accounts. Data in FIDO2 metadata service is self-reported by vendors.

You can become a Microsoft-compatible FIDO2 security key vendor by meeting the following requirements:
- Your authenticator needs to have a FIDO2 certification. To learn more about the certification, visit the [FIDO Alliance Certification Overview website](https://fidoalliance.org/certification/). 
- Your product metadata has been uploaded to the FIDO Alliances backend metadata services (MDS) and you have verified your metadata is in the MDS. The metadata must indicate that your authenticator supports: 
  - FIDO 2.0 or FIDO 2.1. Entra ID does not support single factor UAF/U2F. 
  - User verification. Entra ID requires user verification for all FIDO2 authentication attempts. 
  - Resident keys. 
  - HMAC secret extension. This is required for using a security key to unlock Windows in offline scenarios. 
  - ClientPIN.
  - Is certified at 'any' level.


## Attestation requirements

The following table compares requirements to allow Microsoft-compatible FIDO2 security key when attestation enforcement is on or off. 

| Attestation enforced | Attestation not enforced |
|----------------------|--------------------------|
|It must provide a valid 'packed' attestation statement<br>AND<br>It must provide a valid/complete certificate that chains back to the attestation roots extracted from the FIDO MDS |It must provide a valid 'packed' attestation statement (but Microsoft will ignore attestation verification results)<br>AND<br>It must provide a valid/complete certificate, which doesn’t need to be associated with a particular certificate chain |

## Current partners

The following table lists partners who are Microsoft-compatible FIDO2 security key vendors.

|Aaguid|Description|Biometric|Usb|Nfc|Bluetooth|IsAutoApproved|
|---|---|---|---|---|---|---|
|50a45b0c-80e7-f944-bf29-f552bfa2e048|"ACS FIDO Authenticator"|![n]|![y]|![n]|![n]|![n]|
|973446ca-e21c-9a9b-99f5-9b985a67af0f|"ACS FIDO Authenticator Card"|![n]|![n]|![y]|![n]|![n]|
|5ca1ab1e-1337-fa57-f1d0-a117e71ca702|"Allthenticator App: roaming BLE FIDO2 Allthenticator for Windows, Mac, Linux, and Allthenticate door readers"|![y]|![y]|![n]|![n]|![n]|
|3f59672f-20aa-4afe-b6f4-7e5e916b6d98|"Arculus FIDO 2.1 Key Card \[P71\]"|![n]|![y]|![n]|![n]|![n]|
|9d3df6ba-282f-11ed-a261-0242ac120002|"Arculus FIDO2/U2F Key Card"|![n]|![y]|![n]|![n]|![n]|
|d41f5a69-b817-4144-a13c-9ebd6d9254d6|"ATKey.Card CTAP2.0"|![y]|![n]|![n]|![n]|![n]|
|da1fa263-8b25-42b6-a820-c0036f21ba7f|"ATKey.Card NFC"|![y]|![y]|![y]|![n]|![n]|
|e1a96183-5016-4f24-b55b-e3ae23614cc6|"ATKey.Pro CTAP2.0"|![y]|![n]|![n]|![n]|![n]|
|e416201b-afeb-41ca-a03d-2281c28322aa|"ATKey.Pro CTAP2.1"|![y]|![y]|![n]|![n]|![n]|
|ba76a271-6eb6-4171-874d-b6428dbe3437|"ATKey.ProS"|![y]|![y]|![n]|![n]|![n]|
|1c086528-58d5-f211-823c-356786e36140|"Atos CardOS FIDO2"|![n]|![y]|![y]|![n]|![n]|
|b267239b-954f-4041-a01b-ee4f33c145b6|"authenton1 - CTAP2.1"|![n]|![y]|![y]|![n]|![n]|
|175cd298-83d2-4a26-b637-313c07a6434e|"Chunghwa Telecom FIDO2 Smart Card Authenticator"|![n]|![n]|![y]|![n]|![y]|
|be727034-574a-f799-5c76-0929e0430973|"Crayonic KeyVault K1 (USB-NFC-BLE FIDO2 Authenticator)"|![y]|![y]|![y]|![y]|![n]|
|9c835346-796b-4c27-8898-d6032f515cc5|"Cryptnox FIDO2"|![n]|![n]|![y]|![n]|![n]|
|1105e4ed-af1d-02ff-ffff-ffffffffffff|"Egomet FIDO2 Authenticator for Android"|![y]|![n]|![n]|![n]|![n]|
|454e5346-4944-4ffd-6c93-8e9267193e9a|"Ensurity ThinC"|![y]|![y]|![n]|![n]|![n]|
|95442b2e-f15e-4def-b270-efb106facb4e|"eWBM eFA310 FIDO2 Authenticator"|![y]|![n]|![n]|![n]|![y]|
|87dbc5a1-4c94-4dc8-8a47-97d800fd1f3c|"eWBM eFA320 FIDO2 Authenticator"|![y]|![n]|![n]|![n]|![y]|
|61250591-b2bc-4456-b719-0b17be90bb30|"eWBM eFPA FIDO2 Authenticator"|![y]|![n]|![n]|![n]|![n]|
|61250591-b2bc-4456-b719-0b17be90bb30|"eWBM eFPA FIDO2 Authenticator"|![y]|![n]|![n]|![n]|![n]|
|6002f033-3c07-ce3e-d0f7-0ffe5ed42543|"Excelsecu eSecu FIDO2 Fingerprint Key"|![y]|![y]|![n]|![n]|![y]|
|d384db22-4d50-ebde-2eac-5765cf1e2a44|"Excelsecu eSecu FIDO2 Fingerprint Security Key"|![y]|![y]|![n]|![n]|![n]|
|20f0be98-9af9-986a-4b42-8eca4acb28e4|"Excelsecu eSecu FIDO2 Fingerprint Security Key"|![y]|![y]|![n]|![n]|![n]|
|fbefdf68-fe86-0106-213e-4d5fa24cbe2e|"Excelsecu eSecu FIDO2 NFC Security Key"|![n]|![y]|![y]|![n]|![n]|
|a3975549-b191-fd67-b8fb-017e2917fdb3|"Excelsecu eSecu FIDO2 NFC Security Key"|![n]|![y]|![y]|![n]|![n]|
|0d9b2e56-566b-c393-2940-f821b7f15d6d|"Excelsecu eSecu FIDO2 Pro Security Key"|![n]|![y]|![y]|![y]|![n]|
|bbf4b6a7-679d-f6fc-c4f2-8ac0ddf9015a|"Excelsecu eSecu FIDO2 PRO Security Key"|![n]|![y]|![y]|![y]|![n]|
|cdbdaea2-c415-5073-50f7-c04e968640b6|"Excelsecu eSecu FIDO2 Security Key"|![n]|![y]|![n]|![n]|![n]|
|12ded745-4bed-47d4-abaa-e713f51d6393|"Feitian AllinOne FIDO2 Authenticator"|![y]|![y]|![y]|![y]|![n]|
|77010bd7-212a-4fc9-b236-d2ca5e9d4084|"Feitian BioPass FIDO2 Authenticator"|![y]|![n]|![n]|![n]|![n]|
|b6ede29c-3772-412c-8a78-539c1f4c62d2|"Feitian BioPass FIDO2 Plus Authenticator"|![y]|![y]|![n]|![n]|![y]|
|833b721a-ff5f-4d00-bb2e-bdda3ec01e29|"Feitian ePass FIDO2 Authenticator"|![n]|![n]|![n]|![n]|![y]|
|ee041bce-25e5-4cdb-8f86-897fd6418464|"Feitian ePass FIDO2-NFC Authenticator"|![n]|![n]|![n]|![n]|![n]|
|3e22415d-7fdf-4ea4-8a0c-dd60c4249b9d|"Feitian iePass FIDO Authenticator"|![n]|![y]|![n]|![n]|![y]|
|f4c63eff-d26c-4248-801c-3736c7eaa93a|"FIDO KeyPass S3"|![n]|![y]|![n]|![n]|![y]|
|8c97a730-3f7b-41a6-87d6-1e9b62bda6f0|"FT-JCOS FIDO Fingerprint Card"|![n]|![n]|![y]|![n]|![y]|
|42b4fb4a-2866-43b2-9bf7-6c6669c2e5d3|"Google Titan Security Key v2"|![n]|![y]|![y]|![n]|![n]|
|9f0d8150-baa5-4c00-9299-ad62c8bb4e87|"GoTrust Idem Card FIDO2 Authenticator"|![n]|![n]|![n]|![n]|![n]|
|3b1adb99-0dfe-46fd-90b8-7f7614a4de2a|"GoTrust Idem Key FIDO2 Authenticator"|![n]|![n]|![n]|![n]|![n]|
|aeb6569c-f8fb-4950-ac60-24ca2bbe2e52|"HID Crescendo C2300"|![n]|![n]|![y]|![n]|![n]|
|c80dbd9a-533f-4a17-b941-1a2f1c7cedff|"HID Crescendo C3000"|![n]|![n]|![y]|![n]|![n]|
|54d9fee8-e621-4291-8b18-7157b99c5bec|"HID Crescendo Enabled"|![n]|![n]|![y]|![n]|![n]|
|692db549-7ae5-44d5-a1e5-dd20a493b723|"HID Crescendo Key"|![n]|![y]|![y]|![n]|![n]|
|2d3bec26-15ee-4f5d-88b2-53622490270b|"HID Crescendo Key V2"|![n]|![y]|![y]|![n]|![n]|
|4e768f2c-5fab-48b3-b300-220eb487752b|"Hideez Key 4 FIDO2 SDK"|![n]|![y]|![y]|![y]|![n]|
|d821a7d4-e97c-4cb6-bd82-4237731fd4be|"Hyper FIDO Bio Security Key"|![y]|![n]|![n]|![n]|![n]|
|9f77e279-a6e2-4d58-b700-31e5943c6a98|"Hyper FIDO Pro"|![n]|![n]|![n]|![n]|![n]|
|0076631b-d4a0-427f-5773-0ec71c9e0279|"HYPR FIDO2 Authenticator"|![y]|![n]|![n]|![n]|![n]|
|8d1b1fcb-3c76-49a9-9129-5515b346aa02|"IDEMIA ID-ONE Card"|![n]|![y]|![y]|![n]|![y]|
|39a5647e-1853-446c-a1f6-a79bae9f5bc7|"IDmelon Android Authenticator"|![y]|![n]|![n]|![n]|![n]|
|39a5647e-1853-446c-a1f6-a79bae9f5bc7|"IDmelon Android Authenticator"|![y]|![n]|![n]|![n]|![n]|
|820d89ed-d65a-409e-85cb-f73f0578f82a|"IDmelon iOS Authenticator"|![y]|![n]|![n]|![n]|![n]|
|820d89ed-d65a-409e-85cb-f73f0578f82a|"IDmelon iOS Authenticator"|![y]|![n]|![n]|![n]|![n]|
|b50d5e0a-7f81-4959-9b12-f45407407503|"IDPrime 3940 FIDO"|![n]|![n]|![y]|![n]|![n]|
|4c50ff10-1057-4fc6-b8ed-43a529530c3c|"ImproveID Authenticator"|![n]|![y]|![y]|![n]|![y]|
|d91c5288-0ef0-49b7-b8ae-21ca0aa6b3f3|"KEY-ID FIDO2 Authenticator"|![n]|![y]|![n]|![n]|![y]|
|4b3f8944-d4f2-4d21-bb19-764a986ec160|"KeyXentic FIDO2 Secp256R1 FIDO2 CTAP2 Authenticator"|![y]|![y]|![n]|![n]|![n]|
|ec31b4cc-2acc-4b8e-9c01-bade00ccbe26|"KeyXentic FIDO2 Secp256R1 FIDO2 CTAP2 Authenticator"|![y]|![y]|![n]|![n]|![n]|
|f7c558a0-f465-11e8-b568-0800200c9a66|"KONAI Secp256R1 FIDO2 Conformance Testing CTAP2 Authenticator"|![y]|![y]|![y]|![n]|![n]|
|fec067a1-f1d0-4c5e-b4c0-cc3237475461|"KX701 SmartToken FIDO"|![n]|![y]|![y]|![n]|![n]|
|c5703116-972b-4851-a3e7-ae1259843399|"NEOWAVE Badgeo FIDO2"|![n]|![y]|![y]|![n]|![n]|
|3789da91-f943-46bc-95c3-50ea2012f03a|"NEOWAVE Winkeo FIDO2"|![n]|![y]|![n]|![n]|![n]|
|07a9f89c-6407-4594-9d56-621d5f1e358b|"NXP Semiconductros FIDO2 Conformance Testing CTAP2 Authenticator"|![n]|![n]|![n]|![n]|![y]|
|0acf3011-bc60-f375-fb53-6f05f43154e0|"Nymi FIDO2 Authenticator"|![y]|![n]|![y]|![n]|![n]|
|a1f52be5-dfab-4364-b51c-2bd496b14a56|"OCTATCO EzFinger2 FIDO2 AUTHENTICATOR"|![y]|![n]|![n]|![n]|![n]|
|30b5035e-d297-4ff1-b00b-addc96ba6a98|"OneSpan DIGIPASS FX1 BIO"|![y]|![y]|![n]|![y]|![n]|
|30b5035e-d297-4fc1-b00b-addc96ba6a97|"OneSpan FIDO Touch"|![n]|![y]|![n]|![y]|![n]|
|998f358b-2dd2-4cbe-a43a-e8107438dfb3|"OnlyKey Secp256R1 FIDO2 CTAP2 Authenticator"|![n]|![n]|![n]|![n]|![n]|
|69700f79-d1fb-472e-bd9b-a3a3b9a9eda0|"Pone Biometrics OFFPAD Authenticator"|![y]|![n]|![n]|![y]|![n]|
|88bbd2f0-342a-42e7-9729-dd158be5407a|"Precision InnaIT Key FIDO 2 Level 2 certified"|![y]|![y]|![n]|![n]|![n]|
|7e3f3d30-3557-4442-bdae-139312178b39|"RSA DS100"|![n]|![y]|![n]|![n]|![n]|
|efb96b10-a9ee-4b6c-a4a9-d32125ccd4a4|"Safenet eToken FIDO"|![n]|![y]|![n]|![n]|![n]|
|b92c3f9a-c014-4056-887f-140a2501163b|"Security Key by Yubico"|![n]|![y]|![n]|![n]|![n]|
|f8a011f3-8c0a-4d15-8006-17111f9edc7d|"Security Key by Yubico"|![n]|![y]|![n]|![n]|![n]|
|6d44ba9b-f6ec-2e49-b930-0c8fe920cb73|"Security Key by Yubico with NFC"|![n]|![y]|![y]|![n]|![n]|
|149a2021-8ef6-4133-96b8-81f8d5b7f1f5|"Security Key by Yubico with NFC"|![n]|![y]|![y]|![n]|![n]|
|a4e9fc6d-4cbe-4758-b8ba-37598bb5bbaa|"Security Key NFC by Yubico"|![n]|![y]|![y]|![n]|![n]|
|0bb43545-fd2c-4185-87dd-feb0b2916ace|"Security Key NFC by Yubico - Enterprise Edition"|![n]|![y]|![y]|![n]|![n]|
|89b19028-256b-4025-8872-255358d950e4|"Sentry Enterprises CTAP2 Authenticator"|![y]|![y]|![n]|![y]|![n]|
|516d3969-5a57-5651-5958-4e7a49434167|"SmartDisplayer BobeePass FIDO2 Authenticator"|![n]|![y]|![y]|![y]|![n]|
|8876631b-d4a0-427f-5773-0ec71c9e0279|"Solo Secp256R1 FIDO2 CTAP2 Authenticator"|![n]|![n]|![n]|![n]|![y]|
|8976631b-d4a0-427f-5773-0ec71c9e0279|"Solo Tap Secp256R1 FIDO2 CTAP2 Authenticator"|![n]|![n]|![y]|![n]|![y]|
|9876631b-d4a0-427f-5773-0ec71c9e0279|"Somu Secp256R1 FIDO2 CTAP2 Authenticator"|![n]|![n]|![n]|![n]|![y]|
|931327dd-c89b-406c-a81e-ed7058ef36c6|"Swissbit iShield Key FIDO2"|![n]|![y]|![n]|![n]|![n]|
|91ad6b93-264b-4987-8737-3a690cad6917|"Token Ring FIDO2 Authenticator"|![y]|![n]|![y]|![n]|![n]|
|ab32f0c6-2239-afbb-c470-d2ef4e254db7|"TOKEN2 FIDO2 Security Key"|![n]|![n]|![n]|![n]|![n]|
|eabb46cc-e241-80bf-ae9e-96fa6d2975cf|"TOKEN2 PIN Plus Security Key Series "|![n]|![y]|![y]|![n]|![n]|
|73402251-f2a8-4f03-873e-3cb6db604b03|"uTrust FIDO2 Security Key"|![n]|![y]|![y]|![n]|![n]|
|5626bed4-e756-430b-a7ff-ca78c8b12738|"VALMIDO PRO FIDO"|![y]|![n]|![n]|![y]|![n]|
|d94a29d9-52dd-4247-9c2d-8b818b610389|"VeriMark Guard Fingerprint Key"|![y]|![n]|![n]|![n]|![n]|
|5fdb81b8-53f0-4967-a881-f5ec26fe4d18|"VinCSS FIDO2 Authenticator"|![n]|![n]|![n]|![n]|![n]|
|08987058-cadc-4b81-b6e1-30de50dcbe96|"Windows Hello Hardware Authenticator"|![y]|![n]|![n]|![n]|![n]|
|6028b017-b1d4-4c02-b4b3-afcdafc96bb2|"Windows Hello Software Authenticator"|![y]|![n]|![n]|![n]|![n]|
|9ddd1817-af5a-4672-a2b9-3e3dd95000a9|"Windows Hello VBS Hardware Authenticator"|![y]|![n]|![n]|![n]|![n]|
|504d7149-4e4c-3841-4555-55445a677357|"WiSECURE AuthTron USB FIDO2 Authenticator"|![y]|![y]|![n]|![n]|![n]|
|73bb0cd4-e502-49b8-9c6f-b59445bf720b|"YubiKey 5 FIPS Series"|![n]|![y]|![n]|![n]|![n]|
|85203421-48f9-4355-9bc8-8a53846e5083|"YubiKey 5 FIPS Series with Lightning"|![n]|![y]|![n]|![n]|![n]|
|c1f9a0bc-1dd2-404a-b27f-8e29047a43fd|"YubiKey 5 FIPS Series with NFC"|![n]|![y]|![y]|![n]|![n]|
|cb69481e-8ff7-4039-93ec-0a2729a154a8|"YubiKey 5 Series"|![n]|![y]|![n]|![n]|![n]|
|ee882879-721c-4913-9775-3dfcce97072a|"YubiKey 5 Series"|![n]|![y]|![n]|![n]|![n]|
|c5ef55ff-ad9a-4b9f-b580-adebafe026d0|"YubiKey 5 Series with Lightning"|![n]|![y]|![n]|![n]|![n]|
|2fc0579f-8113-47ea-b116-bb5a8db9202a|"YubiKey 5 Series with NFC"|![n]|![y]|![y]|![n]|![n]|
|fa2b99dc-9e39-4257-8f92-4a30d23c4118|"YubiKey 5 Series with NFC"|![n]|![y]|![y]|![n]|![n]|
|d8522d9f-575b-4866-88a9-ba99fa02f35b|"YubiKey Bio Series"|![y]|![y]|![n]|![n]|![n]|
|83c47309-aabb-4108-8470-8be838b573cb|"YubiKey Bio Series (Enterprise Profile)"|![y]|![y]|![n]|![n]|![y]|


<!--Image references-->
[y]: ./media/fido2-compatibility/yes.png
[n]: ./media/fido2-compatibility/no.png

## Next steps

[FIDO2 Compatibility](fido2-compatibility.md)
