---
title: Configure Maverics Identity Orchestrator SAML Connector for Single sign-on
description: Learn how to configure single sign-on between Microsoft Entra ID and Maverics Identity Orchestrator SAML Connector.

author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 06/05/2024
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Maverics Identity Orchestrator SAML Connector so that I can control who has access to Maverics Identity Orchestrator SAML Connector, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Configure Maverics Identity Orchestrator SAML Connector for Single sign-on

Strata's Maverics Orchestrator provides a simple way to integrate on-premises applications with Microsoft Entra ID for authentication and access control. The Maverics Orchestrator is capable of modernizing authentication and authorization for apps that currently rely on headers, cookies, and other proprietary authentication methods. Maverics Orchestrator instances can be deployed on-premises or in the cloud.

This hybrid access article demonstrates how to migrate an on-premises web application that's currently protected by a legacy web access management product to use Microsoft Entra ID for authentication and access control. Here are the basic steps:

1. Setting up the Maverics Orchestrator
2. Proxying an application
3. Registering an enterprise application in Microsoft Entra ID
4. Authenticating via Microsoft Entra ID and authorizing access to the application
5. Adding headers for seamless application access
6. Working with multiple applications

## Prerequisites

* A Microsoft Entra ID subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* A Maverics Identity Orchestrator Platform account. Sign up at [maverics.strata.io](https://maverics.strata.io).
* At least one application that uses header based authentication. In our examples, we work against an application called Sonar that's reachable at `https://localhost:8443`.
## Step 1: Setting up the Maverics Orchestrator

After signing up for a Maverics account at [maverics.strata.io](https://maverics.strata.io), use our Learning Center article titled [**Getting Started: Evaluation Environment**](https://maverics.strata.io/learn/redirect?context=environments-create-evaluation). This article takes you through the step-by-step process of creating an evaluation environment, downloading an orchestrator, and installing the orchestrator on your machine. 

## Step 2: Extending Microsoft Entra ID to an app with a recipe

Next, use the Learning Center article,  [**Extend Microsoft Entra ID to a Legacy, Non-Standard App**](https://maverics.strata.io/learn/redirect?context=microsoft-entra-id-recipe). This article provides you with a .json recipe that automatically configures an identity fabric, header-based application, and partially complete user flow.

## Step 3: Registering an enterprise application in Microsoft Entra ID

We'll now create a new enterprise application in Microsoft Entra ID that's used for authenticating end-users.

>[!Note]
> When leveraging Microsoft Entra ID features such as Conditional Access it's important to create an enterprise application per on-premises application. This permits per-app Conditional Access, per-app risk evaluation, per-app assigned permissions, etc. Generally, an enterprise application in Microsoft Entra  ID maps to an Azure connector in Maverics.

1. In your Microsoft Entra ID tenant, go to **Enterprise applications**, select **New Application** and search for **Maverics Identity Orchestrator SAML Connector** in the Microsoft Entra ID gallery, and then select it.

1. On the Maverics Identity Orchestrator SAML Connector **Properties** pane, set **User assignment required?** to **No** to enable the application to work for all users in your directory.

1. On the Maverics Identity Orchestrator SAML Connector **Overview** pane, select **Set up single sign-on**, and then select **SAML**.

1. On the Maverics Identity Orchestrator SAML Connector **SAML-based sign on** pane, edit the **Basic SAML Configuration** by selecting the **Edit** (pencil icon) button.

   ![Screenshot of the "Basic SAML Configuration" Edit button.](common/edit-urls.png)

1. Enter an **Entity ID** of: `https://sonar.maverics.com`. The Entity ID must be unique across the apps in the tenant, and can be an arbitrary value. We use this value when defining the `samlEntityID` field for our Azure connector in the next section.

1. Enter a **Reply URL** of: `https://sonar.maverics.com/acs`. We use this value when defining the `samlConsumerServiceURL` field for our Azure connector in the next section.

1. Enter a **Sign on URL** of: `https://sonar.maverics.com/`. This field won't be used by Maverics, but it's required in Microsoft Entra ID to enable users to get access to the application through the Microsoft Entra ID My Apps portal.

1. Select **Save**.

1. In the **SAML Signing Certificate** section, select the **Copy** button to copy the **App Federation Metadata URL**, and then save it to your computer.

   ![Screenshot of the "SAML Signing Certificate" Copy button.](common/copy-metadataurl.png)

## Step 4: Authenticating via Microsoft Entra ID and authorizing access to the application

Continue on with step 4 of the Learning Center topic, **Extend Microsoft Entra ID to a Legacy, Non-Standard App** to edit your user flow in Maverics. These steps walk you through the process of adding headers to the upstream application and deploying the user flow.

Once you've deployed the user flow, to confirm authentication is working as expected, make a request to an application resource through the Maverics proxy. The protected application should now be receiving headers on the request.

Feel free to edit the header keys if your application expects different headers. All claims that come back from Microsoft Entra ID as part of the SAML flow are available to use in headers. For example, we could include another header of `secondary_email: azureSonarApp.email`, where `azureSonarApp` is the connector name and `email` is a claim returned from Microsoft Entra ID.

## Advanced Scenarios

### Identity Migration
Can't stand your end-of-life'd web access management tool, but don't have a way to migrate your users without mass password resets? The Maverics Orchestrator supports identity migration by using `migrationgateways`.

### Web Server Modules 
Don't want to rework your network and proxy traffic through the Maverics Orchestrator? Not a problem, the Maverics Orchestrator can be paired with web server modules to offer the same solutions without proxying.

## Wrapping Up

At this point, we have installed the Maverics Orchestrator, created and configured an enterprise application in Microsoft Entra ID, and configured the Orchestrator to proxy to a protected application while requiring authentication and enforcing policy. To learn more about how the Maverics Orchestrator can be used for distributed identity management use cases please [contact Strata](mailto:sales@strata.io).

