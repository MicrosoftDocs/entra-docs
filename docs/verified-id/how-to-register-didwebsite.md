---
title: Register your website ID
description: Learn how to register your website ID for did:web.
documentationCenter: ''
author: barclayn
manager: femila
ms.service: entra-verified-id
ms.topic: how-to
ms.date: 12/18/2024
ms.author: barclayn

#Customer intent: As an administrator, I'm looking for information to help me register my website ID.
---

# Register your decentralized ID for did:web

In this article, we go over the steps to register your decentralized ID (DID) for did:web.

## Prerequisites

- Complete verifiable credentials onboarding with **web** as the selected trust system.
- Complete the linked domain setup. Without completing this step, you can't perform this registration step.

## Why do I need to register my decentralized ID?

For the web trust system, you need to register your DID to be able to issue and verify your credentials. You have to make this information available on your website and complete this registration. Otherwise, your public key isn't made public.

## How do I register my decentralized ID?

1. Go to the **Verified ID** page in the Azure portal.
1. On the leftmost menu, select **Setup**.
1. On the middle menu, under **Register decentralized ID**, select **Update**.

   :::image type="content" source="media/how-to-register-didwebsite/how-to-register-didwebsite-domain.png" alt-text="Screenshot that shows the website registration page.":::
1. Copy or download the DID document that appears in the box.

   :::image type="content" source="media/how-to-register-didwebsite/how-to-register-didwebsite-diddoc.png" alt-text="Screenshot that shows did.json.":::
1. Upload the file to your web server. The DID document JSON file must be uploaded to `/.well-known/did.json` on your web server.
1. After the file is available on your web server, you need to select **Refresh registration status** to verify that the system can request the file.

## When is the DID document in the did.json file used?

The DID document contains the public keys for your issuer and is used during both issuance and presentation. For example, authenticator, working as the wallet, uses the public keys to validate the signature of an issuance or presentation request.

## When does the did.json file need to be republished to the web server?

The DID document in the `did.json` file must be republished if you changed the linked domain or if you rotate your signing keys.

## How can I verify that the registration is working?

The portal verifies that `did.json` is reachable and correct when you select **Refresh registration status**. You should also consider verifying that you can request that URL in a browser to avoid errors like not using HTTPS, a bad TLS/SSL certificate, or the URL not being public. If the `did.json` file can't be requested anonymously in a browser or via tools such as `curl`, without warnings or errors, the portal won't be able to complete the **Refresh registration status** step.

>[!NOTE]
> If you're experiencing problems refreshing your registration status, you can troubleshoot it by running `curl -Iv https://yourdomain.com/.well-known/did.json` on a machine with Ubuntu OS. Windows Subsystem for Linux with Ubuntu also works. If curl fails, refreshing the registration status won't work.

## Next steps

- [Tutorial for issuing a verifiable credential](verifiable-credentials-configure-issuer.md)