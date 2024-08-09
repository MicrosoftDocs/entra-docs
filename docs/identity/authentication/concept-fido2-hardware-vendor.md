---
title: Microsoft Entra ID attestation for FIDO2 security key vendors
description: Explains requirements to prepare FIDO2 hardware for attestation with Microsoft Entra ID
ms.date: 08/09/2024
ms.service: entra-id
ms.subservice: authentication
author: justinha
ms.author: justinha
ms.reviewer: calui
ms.topic: conceptual
---

# Microsoft Entra ID attestation for FIDO2 security key vendors

FIDO2 security keys enable phishing-resistant authentication. They can replace weak credentials with strong hardware-backed public/private-key credentials that can't be reused, replayed, or shared across services. Security keys support shared device scenarios, allowing you to carry your credential with you and safely authenticate on any supported device.

In Microsoft Entra ID Authentication methods policy, administrators can enforce attestation for FIDO2 security keys. When **Enforce attestation** is set to **Yes**, Microsoft requires extra metadata from FIDO2 security keys that are registered with the tenant. As a vendor, your FIDO2 security key is usable when attestation is enforced, if the following requirements are met.

>[!NOTE]
>Microsoft Entra ID does not support third-party passkey providers on desktop and mobile devices yet.

## Attestation requirements

Microsoft relies on the [FIDO Alliance Metadata Service (MDS)](https://fidoalliance.org/metadata/) to determine security key compatibility with Windows, Microsoft Edge browser, and online Microsoft accounts. Data in the FIDO MDS is self-reported by vendors.

During FIDO2 registration, Microsoft Entra ID requires security keys to provide an attestation statement. For vendors, the expected attestation format is 'packed', as defined by [the FIDO standard](https://www.w3.org/TR/webauthn-2/#sctn-packed-attestation).

The specific requirements vary based on how an administrator configures the FIDO2 authentication methods policy.

| Enforce attestation set to Yes | Enforce attestation set to No |
|--------------------------------|-------------------------------|
|It must provide a valid 'packed' attestation statement and a complete certificate that chains back to the attestation roots extracted from the FIDO Alliance MDS, so that Microsoft can validate the key's metadata.|It must provide a valid 'packed' attestation statement (but Microsoft will ignore attestation verification results) and a complete certificate (which doesn’t need to be associated with a particular certificate chain). |

>[!NOTE]
>Vendors are responsible to publish all root attestation certificates to the FIDO Alliance MDS; otherwise, attestation verification can fail.

Additionally, if attestation is enforced, the following requirements apply:
- Your authenticator needs to have a FIDO2 certification. This can be at 'any' level. To learn more about the certification, visit the FIDO Alliance Certification Overview [website](https://fidoalliance.org/certification/). 
- Your product metadata needs to be uploaded to the FIDO Alliance MDS, and you need to verify your metadata is in the MDS. The metadata must indicate that your authenticator supports: 
  - FIDO 2.0 or higher. 
  - User verification or client PIN - Microsoft Entra ID requires user verification with biometrics or PIN for all FIDO2 authentication attempts.
  - Resident keys (or discoverable credentials) - These are required for using a security key to sign in to Microsoft Entra ID without entering a username.
  - Hash-Based Message Authenticator Codes (HMAC) secret extension or PRF Extension - This is required for using a security key to unlock Windows in offline scenarios.

## Timelines
Microsoft ingests the latest version of the FIDO Alliance MDS every month, so there may be a maximum four-week delay from the time that your FIDO2 security key appears in FIDO Alliance MDS to when Microsoft recognizes the key model. If your key meets the Microsoft attestation requirements, it automatically appears on the Microsoft FIDO2 partner page.

## FIDO2 security keys eligible for attestation with Microsoft Entra ID

The following table lists FIDO2 security key models listed in MDS version 77. These models are eligible for attestation with Microsoft Entra ID. 

|Model|AAGUID|Biometric|USB|NFC|BLE|
|---|---|---|---|---|---|
|ACS FIDO Authenticator|50a45b0c-80e7-f944-bf29-f552bfa2e048|[n]|[y]|[n]|[n]|
|ACS FIDO Authenticator Card|973446ca-e21c-9a9b-99f5-9b985a67af0f|[n]|[n]|[y]|[n]|
|Allthenticator App: roaming BLE FIDO2 Allthenticator for Windows, Mac, Linux, and Allthenticate door readers|5ca1ab1e-1337-fa57-f1d0-a117e71ca702|[y]|[y]|[n]|[n]|
|Arculus FIDO 2.1 Key Card \[P71]|3f59672f-20aa-4afe-b6f4-7e5e916b6d98|[n]|[y]|[n]|[n]|
|Arculus FIDO2/U2F Key Card|9d3df6ba-282f-11ed-a261-0242ac120002|[n]|[y]|[n]|[n]|
|ATKey.Card CTAP2.0|d41f5a69-b817-4144-a13c-9ebd6d9254d6|[y]|[n]|[n]|[n]|
|ATKey.Card NFC|da1fa263-8b25-42b6-a820-c0036f21ba7f|[y]|[y]|[y]|[n]|
|ATKey.Pro CTAP2.0|e1a96183-5016-4f24-b55b-e3ae23614cc6|[y]|[n]|[n]|[n]|
|ATKey.Pro CTAP2.1|e416201b-afeb-41ca-a03d-2281c28322aa|[y]|[y]|[n]|[n]|
|ATKey.ProS|ba76a271-6eb6-4171-874d-b6428dbe3437|[y]|[y]|[n]|[n]|
|Atos CardOS FIDO2|1c086528-58d5-f211-823c-356786e36140|[n]|[y]|[y]|[n]|
|authenton1 - CTAP2.1|b267239b-954f-4041-a01b-ee4f33c145b6|[n]|[y]|[y]|[n]|
|Crayonic KeyVault K1 (USB-NFC-BLE FIDO2 Authenticator)|be727034-574a-f799-5c76-0929e0430973|[y]|[y]|[y]|[y]|
|Cryptnox FIDO2|9c835346-796b-4c27-8898-d6032f515cc5|[n]|[n]|[y]|[n]|
|Egomet FIDO2 Authenticator for Android|1105e4ed-af1d-02ff-ffff-ffffffffffff|[y]|[n]|[n]|[n]|
|Ensurity ThinC|454e5346-4944-4ffd-6c93-8e9267193e9a|[y]|[y]|[n]|[n]|
|eWBM eFPA FIDO2 Authenticator|61250591-b2bc-4456-b719-0b17be90bb30|[y]|[n]|[n]|[n]|
|eWBM eFPA FIDO2 Authenticator|61250591-b2bc-4456-b719-0b17be90bb30|[y]|[n]|[n]|[n]|
|Excelsecu eSecu FIDO2 Fingerprint Security Key|d384db22-4d50-ebde-2eac-5765cf1e2a44|[y]|[y]|[n]|[n]|
|Excelsecu eSecu FIDO2 Fingerprint Security Key|20f0be98-9af9-986a-4b42-8eca4acb28e4|[y]|[y]|[n]|[n]|
|Excelsecu eSecu FIDO2 NFC Security Key|fbefdf68-fe86-0106-213e-4d5fa24cbe2e|[n]|[y]|[y]|[n]|
|Excelsecu eSecu FIDO2 NFC Security Key|a3975549-b191-fd67-b8fb-017e2917fdb3|[n]|[y]|[y]|[n]|
|Excelsecu eSecu FIDO2 Pro Security Key|0d9b2e56-566b-c393-2940-f821b7f15d6d|[n]|[y]|[y]|[y]|
|Excelsecu eSecu FIDO2 PRO Security Key|bbf4b6a7-679d-f6fc-c4f2-8ac0ddf9015a|[n]|[y]|[y]|[y]|
|Excelsecu eSecu FIDO2 Security Key|cdbdaea2-c415-5073-50f7-c04e968640b6|[n]|[y]|[n]|[n]|
|Feitian AllinOne FIDO2 Authenticator|12ded745-4bed-47d4-abaa-e713f51d6393|[y]|[y]|[y]|[y]|
|Feitian BioPass FIDO2 Authenticator|77010bd7-212a-4fc9-b236-d2ca5e9d4084|[y]|[n]|[n]|[n]|
|Feitian ePass FIDO2-NFC Authenticator|ee041bce-25e5-4cdb-8f86-897fd6418464|[n]|[n]|[n]|[n]|
|Google Titan Security Key v2|42b4fb4a-2866-43b2-9bf7-6c6669c2e5d3|[n]|[y]|[y]|[n]|
|GoTrust Idem Card FIDO2 Authenticator|9f0d8150-baa5-4c00-9299-ad62c8bb4e87|[n]|[n]|[n]|[n]|
|GoTrust Idem Key FIDO2 Authenticator|3b1adb99-0dfe-46fd-90b8-7f7614a4de2a|[n]|[n]|[n]|[n]|
|HID Crescendo C2300|aeb6569c-f8fb-4950-ac60-24ca2bbe2e52|[n]|[n]|[y]|[n]|
|HID Crescendo C3000|c80dbd9a-533f-4a17-b941-1a2f1c7cedff|[n]|[n]|[y]|[n]|
|HID Crescendo Enabled|54d9fee8-e621-4291-8b18-7157b99c5bec|[n]|[n]|[y]|[n]|
|HID Crescendo Key|692db549-7ae5-44d5-a1e5-dd20a493b723|[n]|[y]|[y]|[n]|
|HID Crescendo Key V2|2d3bec26-15ee-4f5d-88b2-53622490270b|[n]|[y]|[y]|[n]|
|Hideez Key 4 FIDO2 SDK|4e768f2c-5fab-48b3-b300-220eb487752b|[n]|[y]|[y]|[y]|
|Hyper FIDO Bio Security Key|d821a7d4-e97c-4cb6-bd82-4237731fd4be|[y]|[n]|[n]|[n]|
|Hyper FIDO Pro|9f77e279-a6e2-4d58-b700-31e5943c6a98|[n]|[n]|[n]|[n]|
|HYPR FIDO2 Authenticator|0076631b-d4a0-427f-5773-0ec71c9e0279|[y]|[n]|[n]|[n]|
|IDmelon Android Authenticator|39a5647e-1853-446c-a1f6-a79bae9f5bc7|[y]|[n]|[n]|[n]|
|IDmelon Android Authenticator|39a5647e-1853-446c-a1f6-a79bae9f5bc7|[y]|[n]|[n]|[n]|
|IDmelon iOS Authenticator|820d89ed-d65a-409e-85cb-f73f0578f82a|[y]|[n]|[n]|[n]|
|IDmelon iOS Authenticator|820d89ed-d65a-409e-85cb-f73f0578f82a|[y]|[n]|[n]|[n]|
|IDPrime 3940 FIDO|b50d5e0a-7f81-4959-9b12-f45407407503|[n]|[n]|[y]|[n]|
|KeyXentic FIDO2 Secp256R1 FIDO2 CTAP2 Authenticator|4b3f8944-d4f2-4d21-bb19-764a986ec160|[y]|[y]|[n]|[n]|
|KeyXentic FIDO2 Secp256R1 FIDO2 CTAP2 Authenticator|ec31b4cc-2acc-4b8e-9c01-bade00ccbe26|[y]|[y]|[n]|[n]|
|KONAI Secp256R1 FIDO2 Conformance Testing CTAP2 Authenticator|f7c558a0-f465-11e8-b568-0800200c9a66|[y]|[y]|[y]|[n]|
|KX701 SmartToken FIDO|fec067a1-f1d0-4c5e-b4c0-cc3237475461|[n]|[y]|[y]|[n]|
|NEOWAVE Badgeo FIDO2|c5703116-972b-4851-a3e7-ae1259843399|[n]|[y]|[y]|[n]|
|NEOWAVE Winkeo FIDO2|3789da91-f943-46bc-95c3-50ea2012f03a|[n]|[y]|[n]|[n]|
|Nymi FIDO2 Authenticator|0acf3011-bc60-f375-fb53-6f05f43154e0|[y]|[n]|[y]|[n]|
|OCTATCO EzFinger2 FIDO2 AUTHENTICATOR|a1f52be5-dfab-4364-b51c-2bd496b14a56|[y]|[n]|[n]|[n]|
|OneSpan DIGIPASS FX1 BIO|30b5035e-d297-4ff1-b00b-addc96ba6a98|[y]|[y]|[n]|[y]|
|OneSpan FIDO Touch|30b5035e-d297-4fc1-b00b-addc96ba6a97|[n]|[y]|[n]|[y]|
|OnlyKey Secp256R1 FIDO2 CTAP2 Authenticator|998f358b-2dd2-4cbe-a43a-e8107438dfb3|[n]|[n]|[n]|[n]|
|Pone Biometrics OFFPAD Authenticator|69700f79-d1fb-472e-bd9b-a3a3b9a9eda0|[y]|[n]|[n]|[y]|
|Precision InnaIT Key FIDO 2 Level 2 certified|88bbd2f0-342a-42e7-9729-dd158be5407a|[y]|[y]|[n]|[n]|
|RSA DS100|7e3f3d30-3557-4442-bdae-139312178b39|[n]|[y]|[n]|[n]|
|Safenet eToken FIDO|efb96b10-a9ee-4b6c-a4a9-d32125ccd4a4|[n]|[y]|[n]|[n]|
|Security Key by Yubico|b92c3f9a-c014-4056-887f-140a2501163b|[n]|[y]|[n]|[n]|
|Security Key by Yubico|f8a011f3-8c0a-4d15-8006-17111f9edc7d|[n]|[y]|[n]|[n]|
|Security Key by Yubico with NFC|6d44ba9b-f6ec-2e49-b930-0c8fe920cb73|[n]|[y]|[y]|[n]|
|Security Key by Yubico with NFC|149a2021-8ef6-4133-96b8-81f8d5b7f1f5|[n]|[y]|[y]|[n]|
|Security Key NFC by Yubico|a4e9fc6d-4cbe-4758-b8ba-37598bb5bbaa|[n]|[y]|[y]|[n]|
|Security Key NFC by Yubico - Enterprise Edition|0bb43545-fd2c-4185-87dd-feb0b2916ace|[n]|[y]|[y]|[n]|
|Sentry Enterprises CTAP2 Authenticator|89b19028-256b-4025-8872-255358d950e4|[y]|[y]|[n]|[y]|
|SmartDisplayer BobeePass FIDO2 Authenticator|516d3969-5a57-5651-5958-4e7a49434167|[n]|[y]|[y]|[y]|
|Swissbit iShield Key FIDO2|931327dd-c89b-406c-a81e-ed7058ef36c6|[n]|[y]|[n]|[n]|
|Token Ring FIDO2 Authenticator|91ad6b93-264b-4987-8737-3a690cad6917|[y]|[n]|[y]|[n]|
|TOKEN2 FIDO2 Security Key|ab32f0c6-2239-afbb-c470-d2ef4e254db7|[n]|[n]|[n]|[n]|
|TOKEN2 PIN Plus Security Key Series |eabb46cc-e241-80bf-ae9e-96fa6d2975cf|[n]|[y]|[y]|[n]|
|uTrust FIDO2 Security Key|73402251-f2a8-4f03-873e-3cb6db604b03|[n]|[y]|[y]|[n]|
|VALMIDO PRO FIDO|5626bed4-e756-430b-a7ff-ca78c8b12738|[y]|[n]|[n]|[y]|
|VeriMark Guard Fingerprint Key|d94a29d9-52dd-4247-9c2d-8b818b610389|[y]|[n]|[n]|[n]|
|VinCSS FIDO2 Authenticator|5fdb81b8-53f0-4967-a881-f5ec26fe4d18|[n]|[n]|[n]|[n]|
|Windows Hello Hardware Authenticator|08987058-cadc-4b81-b6e1-30de50dcbe96|[y]|[n]|[n]|[n]|
|Windows Hello Hardware Authenticator|08987058-cadc-4b81-b6e1-30de50dcbe96|[y]|[n]|[n]|[n]|
|Windows Hello Software Authenticator|6028b017-b1d4-4c02-b4b3-afcdafc96bb2|[y]|[n]|[n]|[n]|
|Windows Hello Software Authenticator|6028b017-b1d4-4c02-b4b3-afcdafc96bb2|[y]|[n]|[n]|[n]|
|Windows Hello VBS Hardware Authenticator|9ddd1817-af5a-4672-a2b9-3e3dd95000a9|[y]|[n]|[n]|[n]|
|Windows Hello VBS Hardware Authenticator|9ddd1817-af5a-4672-a2b9-3e3dd95000a9|[y]|[n]|[n]|[n]|
|WiSECURE AuthTron USB FIDO2 Authenticator|504d7149-4e4c-3841-4555-55445a677357|[y]|[y]|[n]|[n]|
|YubiKey 5 FIPS Series|73bb0cd4-e502-49b8-9c6f-b59445bf720b|[n]|[y]|[n]|[n]|
|YubiKey 5 FIPS Series with Lightning|85203421-48f9-4355-9bc8-8a53846e5083|[n]|[y]|[n]|[n]|
|YubiKey 5 FIPS Series with NFC|c1f9a0bc-1dd2-404a-b27f-8e29047a43fd|[n]|[y]|[y]|[n]|
|YubiKey 5 Series|cb69481e-8ff7-4039-93ec-0a2729a154a8|[n]|[y]|[n]|[n]|
|YubiKey 5 Series|ee882879-721c-4913-9775-3dfcce97072a|[n]|[y]|[n]|[n]|
|YubiKey 5 Series with Lightning|c5ef55ff-ad9a-4b9f-b580-adebafe026d0|[n]|[y]|[n]|[n]|
|YubiKey 5 Series with NFC|2fc0579f-8113-47ea-b116-bb5a8db9202a|[n]|[y]|[y]|[n]|
|YubiKey 5 Series with NFC|fa2b99dc-9e39-4257-8f92-4a30d23c4118|[n]|[y]|[y]|[n]|
|YubiKey Bio Series|d8522d9f-575b-4866-88a9-ba99fa02f35b|[y]|[y]|[n]|[n]|
|Chunghwa Telecom FIDO2 Smart Card Authenticator|175cd298-83d2-4a26-b637-313c07a6434e|[n]|[n]|[y]|[n]|
|eWBM eFA310 FIDO2 Authenticator|95442b2e-f15e-4def-b270-efb106facb4e|[y]|[n]|[n]|[n]|
|eWBM eFA320 FIDO2 Authenticator|87dbc5a1-4c94-4dc8-8a47-97d800fd1f3c|[y]|[n]|[n]|[n]|
|Excelsecu eSecu FIDO2 Fingerprint Key|6002f033-3c07-ce3e-d0f7-0ffe5ed42543|[y]|[y]|[n]|[n]|
|Feitian BioPass FIDO2 Plus Authenticator|b6ede29c-3772-412c-8a78-539c1f4c62d2|[y]|[y]|[n]|[n]|
|Feitian ePass FIDO2 Authenticator|833b721a-ff5f-4d00-bb2e-bdda3ec01e29|[n]|[n]|[n]|[n]|
|Feitian ePass FIDO2-NFC Series (CTAP2.1| CTAP2.0| U2F)|234cd403-35a2-4cc2-8015-77ea280c77f5|[n]|[y]|[y]|[n]|
|Feitian iePass FIDO Authenticator|3e22415d-7fdf-4ea4-8a0c-dd60c4249b9d|[n]|[y]|[n]|[n]|
|FIDO KeyPass S3|f4c63eff-d26c-4248-801c-3736c7eaa93a|[n]|[y]|[n]|[n]|
|FT-JCOS FIDO Fingerprint Card|8c97a730-3f7b-41a6-87d6-1e9b62bda6f0|[n]|[n]|[y]|[n]|
|IDCore 3121 Fido|e86addcd-7711-47e5-b42a-c18257b0bf61|[n]|[n]|[y]|[n]|
|IDEMIA ID-ONE Card|8d1b1fcb-3c76-49a9-9129-5515b346aa02|[n]|[y]|[y]|[n]|
|IDPrime 3930 FIDO|ca4cff1b-5a81-4404-8194-59aabcf1660b|[n]|[n]|[y]|[n]|
|IDPrime 931 Fido|2194b428-9397-4046-8f39-007a1605a482|[n]|[n]|[y]|[n]|
|IDPrime 941 Fido|2ffd6452-01da-471f-821b-ea4bf6c8676a|[n]|[n]|[y]|[n]|
|ImproveID Authenticator|4c50ff10-1057-4fc6-b8ed-43a529530c3c|[n]|[y]|[y]|[n]|
|KEY-ID FIDO2 Authenticator|d91c5288-0ef0-49b7-b8ae-21ca0aa6b3f3|[n]|[y]|[n]|[n]|
|NXP Semiconductros FIDO2 Conformance Testing CTAP2 Authenticator|07a9f89c-6407-4594-9d56-621d5f1e358b|[n]|[n]|[n]|[n]|
|OpenSK authenticator|664d9f67-84a2-412a-9ff7-b4f7d8ee6d05|[n]|[y]|[n]|[n]|
|SafeNet eToken Fusion|74820b05-a6c9-40f9-8fb0-9f86aca93998|[n]|[y]|[n]|[n]|
|SafeNet eToken Fusion CC|23786452-f02d-4344-87ed-aaf703726881|[n]|[y]|[n]|[n]|
|Security Key NFC by Yubico|e77e3c64-05e3-428b-8824-0cbeb04b829d|[n]|[y]|[n]|[n]|
|Security Key NFC by Yubico - Enterprise Edition|47ab2fb4-66ac-4184-9ae1-86be814012d5|[n]|[y]|[n]|[n]|
|Solo Secp256R1 FIDO2 CTAP2 Authenticator|8876631b-d4a0-427f-5773-0ec71c9e0279|[n]|[n]|[n]|[n]|
|Solo Tap Secp256R1 FIDO2 CTAP2 Authenticator|8976631b-d4a0-427f-5773-0ec71c9e0279|[n]|[n]|[y]|[n]|
|Somu Secp256R1 FIDO2 CTAP2 Authenticator|9876631b-d4a0-427f-5773-0ec71c9e0279|[n]|[n]|[n]|[n]|
|Swissbit iShield Key Pro|5d629218-d3a5-11ed-afa1-0242ac120002|[n]|[y]|[y]|[n]|
|Thales IDPrime FIDO Bio|4d41190c-7beb-4a84-8018-adf265a6352d|[y]|[n]|[y]|[n]|
|YubiKey 5 Series|19083c3d-8383-4b18-bc03-8f1c9ab2fd1b|[n]|[y]|[n]|[n]|
|YubiKey 5 Series with Lightning|a02167b9-ae71-4ac7-9a07-06432ebb6f1c|[n]|[y]|[n]|[n]|
|YubiKey 5 Series with NFC|a25342c0-3cdc-4414-8e46-f4807fca511c|[n]|[y]|[n]|[n]|
|YubiKey Bio Series - Multi-protocol Edition|7d1351a6-e097-4852-b8bf-c9ac5c9ce4a3|[y]|[y]|[n]|[n]|
|YubiKey Bio Series (Enterprise Profile)|83c47309-aabb-4108-8470-8be838b573cb|[y]|[y]|[n]|[n]|


<!--Image references-->
[y]: ./media/fido2-compatibility/yes.png
[n]: ./media/fido2-compatibility/no.png

## Next steps

For more information about Microsoft Entra ID support for phishing-resistant authentication with FIDO2 security keys in browsers and native apps, see [FIDO2 compatibility](fido2-compatibility.md).
