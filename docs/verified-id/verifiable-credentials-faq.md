---
title: Frequently asked questions - Azure Verifiable Credentials
description: Find answers to common questions about Verifiable Credentials.
author: barclayn
manager: amycolannino
ms.service: entra-verified-id

ms.topic: faq
ms.date: 08/11/2022
ms.author: barclayn
# Customer intent: As a developer I am looking for information on how to enable my users to control their own information 
---

# Frequently Asked Questions (FAQ)

  
This page contains commonly asked questions about Verifiable Credentials and Decentralized Identity. Questions are organized into the following sections.

- [Vocabulary and basics](#the-basics)
- [Conceptual questions about decentralized identity](#conceptual-questions)


## The basics

### What is a DID? 

Decentralized Identifiers (DIDs) are unique identifiers used to secure access to resources, sign and verify credentials, and facilitate data exchange between applications. Unlike traditional usernames and email addresses, entities and owning and controlling the DIDs themselves (be it a person, device, or company). DIDs exist independently of any external organization or trusted intermediary. [The W3C Decentralized Identifier spec](https://www.w3.org/TR/did-core/) explains DIDs in further detail.

### Why do we need a DID?

Digital trust fundamentally requires participants to own and control their identities, and identity begins at the identifier.
In an age of daily, large-scale system breaches and attacks on centralized identifier honeypots, decentralizing identity is becoming a critical security need for consumers and businesses.
Individuals owning and controlling their identities are able to exchange verifiable data and proofs. A distributed credential environment allows for the automation of many business processes that are currently manual and labor intensive.

### What is a Verifiable Credential? 

Credentials are a part of our daily lives. Driver's licenses are used to assert that we're capable of operating a motor vehicle. University degrees can be used to assert our level of education and government-issued passports enable us to travel between countries and regions. Verifiable Credentials provides a mechanism to express these sorts of credentials on the Web in a way that is cryptographically secure, privacy respecting, and machine-verifiable. [The W3C Verifiable Credentials spec](https://www.w3.org/TR/vc-data-model/) explains verifiable credentials in further detail.


## Conceptual questions

### What happens when a user loses their phone? Can they recover their identity?

There are multiple ways of offering a recovery mechanism to users, each with their own tradeoffs. Microsoft currently evaluating options and designing approaches to recovery that offer convenience and security while respecting a user's privacy and self-sovereignty.

### How can a user trust a request from an issuer or verifier? How do they know a DID is the real DID for an organization?

We implement [the Decentralized Identity Foundation's Well Known DID Configuration spec](https://identity.foundation/.well-known/resources/did-configuration/) in order to connect a DID to a highly known existing system, domain names. Each DID created using the Microsoft Entra Verified ID has the option of including a root domain name that is encoded in the DID Document. Follow the article titled [Link your Domain to your Distributed Identifier](how-to-dnsbind.md) to learn more about linked domains.  

### What are the size limitations for a Verifiable Credential in Verified ID?

- For issuance request - 1 MB
- Photo in the Verifiable credential - 1 MB
- Callback result 10 MB without receipt

### What are the licensing requirements?

There are no special licensing requirements to issue Verifiable credentials.

### How do I reset the Microsoft Entra Verified ID service?

Resetting requires that you opt out and opt back into the Microsoft Entra Verified ID service. Your existing verifiable credentials configuration is reset and your tenant obtains a new DID to use during issuance and presentation.

1. Follow the [opt out](how-to-opt-out.md) instructions.
1. Go over the Microsoft Entra Verified ID [deployment steps](verifiable-credentials-configure-tenant-quick.md) to reconfigure the service.
    1. If you're manually setting up Verified ID, choose a location for your Azure Key Vault to be in the same or closest region. Choosing same region avoids performance and latency issues.
1. Finish [setting up](verifiable-credentials-configure-tenant.md#set-up-verified-id) your verifiable credentials service. You need to recreate your credentials.
    1. You also need to issue new credentials because your tenant now holds a new DID.

### How can I check my Microsoft Entra tenant's region?

1. In the [Azure portal](https://portal.azure.com), go to Microsoft Entra ID for the subscription you use for your Microsoft Entra Verified ID deployment.
1. Under Manage, select Properties.

    :::image type="content" source="media/verifiable-credentials-faq/region.png" lightbox="media/verifiable-credentials-faq/region.png" alt-text="Screenshot of settings delete and opt out.":::

1. See the value for Country or Region. If the value is a country or a region in Europe, your Microsoft Entra Verified ID service is set up in Europe.

### Does Microsoft Entra Verified ID support ION as its DID method?

Verified ID supported the DID:ION method in preview until December 2023, after which it was discontinued.

### How do I move to did:web from did:ion?

If you want to move to `did:web` from `did:ion`, you can follow these steps via the [Admin API](admin-api.md). Changing authority requires reissuance of all credentials:

#### Export existing did:ion credential definitions

1. For the `did:ion` authority, use the [portal](https://entra.microsoft.com/#view/Microsoft_AAD_DecentralizedIdentity/CardsListBlade) to copy out all display and rules definition of the existing credentials. 
1. If you have more than one authority, you have to use the Admin APIs if the `did:ion` authority isn't the default authority. On the Verified ID tenant, connect using Admin API,  [list the authorities](admin-api.md#list-authorities) to get the authority ID for the `did:ion` authority. Then use the [list contracts](admin-api.md#list-contracts) API to export them and save the result to a file so you can recreate them.

#### Creating new did:web authority

1. Using the [onboard](admin-api.md#onboarding) API, create the new `did:web` authority. Alternatively, if your tenant has only one did:ion authority, you could also perform a service opt out followed by an opt-in operation to restart with Verified ID configurations. In this case, you could choose between [Quick](verifiable-credentials-configure-tenant-quick.md) and [Manual](verifiable-credentials-configure-tenant.md) setup.
1. If you're setting up a did:web authority using Admin API, you need to call [generate DID document](admin-api.md#generate-did-document) to generate your did document and call [generate well-known document](admin-api.md#well-known-did-configuration) and then upload JSON files to the respective well-known path.

#### Recreate credential definitions

When you have created your new `did:web` authority, you need to recreate your credential definitions. You can either do that via the [portal](https://entra.microsoft.com/#view/Microsoft_AAD_DecentralizedIdentity/CardsListBlade) if you opted-out and reonboarded, or you need to use the [create contract](admin-api.md#create-contract) API to recreate them.

#### Update existing applications

1. Update any of your existing application (issuer/verifier apps) to use the new `did:web authority`. For issuance apps, update the credential manifest URL too.
1. Test issuance and verification flows from the new did:web authority. Once the tests are successful, proceed to the next step for did:ion authority deletion.

#### Delete did:ion authority

If you didn't opt out and reonboarded, you need to remove your old `did:ion` authority. Use the [delete authority](admin-api.md#delete-authority) API to delete the did:ion authority. 

### If I reconfigure the Microsoft Entra Verified ID service, do I need to relink my DID to my domain?

Yes, after reconfiguring your service, your tenant has a new DID use to issue and verify verifiable credentials. You need to [associate your new DID](how-to-dnsbind.md) with your domain.

### Is it possible to request Microsoft to retrieve "old DIDs"?

No, at this point it isn't possible to keep your tenant's DID after you have opt out of the service.

### I can't use ngrok, what do I do?

The tutorials for deploying and running the [samples](verifiable-credentials-configure-issuer.md#prerequisites) describes the use of the `ngrok` tool as an application proxy. This tool is sometimes blocked by IT admins from being used in corporate networks. An alternative is to deploy the sample to [Azure App Service](/azure/app-service/overview) and run it in the cloud. The following links help you deploy the respective sample to Azure App Service. The Free pricing tier is sufficient for hosting the sample. For each tutorial, you need to start by first creating the Azure App Service instance, then skip creating the app since you already have an app and then continue the tutorial with deploying it.

- Dotnet - [Publish to App Service](/azure/app-service/quickstart-dotnetcore?tabs=net60&pivots=development-environment-vs#2-publish-your-web-app)
- Node - [Deploy to App Service](/azure/app-service/quickstart-nodejs?tabs=linux&pivots=development-environment-vscode#deploy-to-azure)
- Java - [Deploy to App Service](/azure/app-service/quickstart-java?tabs=javase&pivots=platform-linux-development-environment-maven#4---deploy-the-app). You need to add the maven plugin for Azure App Service to the sample.
- Python - [Deploy using Visual Studio Code](/azure/app-service/quickstart-python?tabs=flask%2Cwindows%2Cazure-cli%2Cvscode-deploy%2Cdeploy-instructions-azportal%2Cterminal-bash%2Cdeploy-instructions-zip-azcli#3---deploy-your-application-code-to-azure)

Regardless of which language of the sample you're using, the Azure AppService hostname `https://something.azurewebsites.net` is used as the public endpoint. You don't need to configure something extra to make it work. If you make changes to the code or configuration, you need to redeploy the sample to Azure AppServices. Troubleshooting/debugging isn't as easy as running the sample on your local machine, where traces to the console window show you errors, but you can achieve almost the same by using the [Log Stream](/azure/app-service/troubleshoot-diagnostic-logs#stream-logs).

### Network hardening for callback events

The Request Service API makes use of callbacks to a [URL](presentation-request-api.md#callback-type) provided by the relying party application. This URL needs to be reachable from the Verified ID system for the callbacks to be received. Callbacks are coming from Azure infrastructure in the same region as your Microsoft Entra tenant. If you need to harden your network, you have two options.

- Use [Azure firewall service tags](/azure/firewall/service-tags) [AzureCloud](/azure/virtual-network/service-tags-overview#available-service-tags).
- Use the published [CIDR range](https://www.microsoft.com/download/details.aspx?id=56519) to configure your firewall.  You need to use AzureCloud.***regions*** that matches where your Microsoft Entra tenant is deployed to config their firewalls to let callback traffic from Request Service API through. For instance, if your tenant is in EU, you should pick all CIDR ranges from AzureCloud.***northeurope***, ***.westeurope***, etc., to your firewalls config.

## Next steps

- [Customize your verifiable credentials](credential-design.md)