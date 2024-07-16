---
title: Microsoft's Security Service Edge Solution Deployment Guide for Microsoft Entra Private Access
description: Plan for, deploy, and verify Microsoft Entra Private Access
author: jricketts
manager: martinco
ms.service: global-secure-access
ms.topic: conceptual
ms.date: 12/6/2023
ms.author: jricketts
---

# Microsoft's Security Service Edge Solution Deployment Guide for Microsoft Entra Private Access Proof of Concept

[Microsoft's identity-centric Security Service Edge solution](../global-secure-access/overview-what-is-global-secure-access.md) converges network, identity, and endpoint access controls so that you can secure access to any app or resource, from any location, device, or identity. It enables and orchestrates access policy management for employees, business partners, and digital workloads. You can continuously monitor and adjust user access in real time if permissions or risk level changes to your private apps, SaaS apps, and Microsoft endpoints.

This guidance helps you deploy [Microsoft Entra Private Access](../global-secure-access/concept-private-access.md) as a Proof of Concept in your production or test environment, including Conditional Access policies and application assignments. You can scope your configuration to specific test users and groups. See [Microsoft's Security Service Edge Solution Deployment Guide Introduction](sse-deployment-guide-intro.md) for prerequisites.

## Deploy and test Microsoft Entra Private Access

Complete the [Configure initial product](sse-deployment-guide-intro.md#configure-initial-product) steps. This includes enabling the Microsoft Entra Private Access traffic forwarding profile and installing the Global Secure Access Client on a test device. Use this guidance to set up your connector server and publish your application to Microsoft Entra Private Access.

### Set up connector server

The connector server communicates with Microsoft's Security Service Edge Solution as the gateway to your corporate network. It uses outbound connections through 80 and 443 and doesn't require inbound ports. Learn [How to configure connectors for Microsoft Entra Private Access](../global-secure-access/how-to-configure-connectors.md#open-ports). 

1. On the connector server, open the [Microsoft Entra admin center](https://entra.microsoft.com). Go to **Global Secure Access** > **Connect** > **Connectors**  and then click **Enable Private Network connectors**. Click **Download connector service**.
   
     :::image type="content" source="media/sse-deployment-guide-private-access/enable-private-network-connectors.png" alt-text="Screenshot of Global Secure Access, Connect, Connectors, Private Network Connector, Private Network Connector Download window." lightbox="media/sse-deployment-guide-private-access/enable-private-network-connectors-extended.png"::: 
1. Create a new connector group for your Private Network Connector.
2. Follow the installation wizard to install the connector service on your connector server. When prompted, enter your tenant credentials to complete installation.
1. Confirm that the connector server is installed in your new connector group by ensuring that it appears in the Connectors list.                            

In this guide, we use a new connector group with one connector server. In a production environment, you should create connector groups with multiple connector servers. [See detailed guidance for publishing apps on separate networks by using connector groups](../identity/app-proxy/application-proxy-connector-groups.md).

### Publish application

Microsoft Entra Private Access supports transmission control protocol (TCP) applications using any ports. To connect to the application server using RDP (TCP port 3389) over the internet, complete the following steps:
1. From the connector server, verify that you can remote desktop into the application server.
1. Open the [Microsoft Entra admin center](https://entra.microsoft.com) and then go to **Global Secure Access** > **Applications** > **Enterprise applications** > **+ New Application**.
                                           
     :::image type="content" source="media/sse-deployment-guide-private-access/enterprise-applications-inline.png" alt-text="Screenshot of Global Secure Access, Applications, Enterprise applications window." lightbox="media/sse-deployment-guide-private-access/enterprise-applications-extended.png":::
1. Enter a **Name** (such as Server1) and select the new connector group. Click **+Add application segment**. Enter the **IP address** of the application server and port 3389.

     :::image type="content" source="media/sse-deployment-guide-private-access/create-application-segment-inline.png" alt-text="Screenshot of Create Global Secure Access Application, Create application segment window." lightbox="media/sse-deployment-guide-private-access/create-application-segment-extended.png":::
1. Click **Apply** > **Save**. Verify that the application is added to the Enterprise applications list.

1. Go to **Identity** > **Applications** > **Enterprise applications** and click the newly created application.

     :::image type="content" source="media/sse-deployment-guide-private-access/all-applications-inline.png" alt-text="Screenshot of Global Secure Access, Applications, Enterprise applications, All applications window." lightbox="media/sse-deployment-guide-private-access/all-applications-extended.png":::
1. Click **Users and groups**. Add your test user that that will access this application from the internet.

     :::image type="content" source="media/sse-deployment-guide-private-access/application-users-groups-inline.png" alt-text="Screenshot of Global Secure Access, Applications, Enterprise applications, Manage, Users and groups window." lightbox="media/sse-deployment-guide-private-access/application-users-groups-extended.png":::
1. Sign in to your test client device and open a remote desktop connection to the application server.

## Sample PoC scenario: apply Conditional Access

You can apply Conditional Access policies to applications published with Microsoft Entra Private Access. Use this guidance to enforce phone sign-in (Microsoft Authenticator) for users that remote desktop to the application server.

1. Open the [Microsoft Entra admin center](https://entra.microsoft.com). Go to **Identity** > **Protection** > **Conditional Access** > **Authentication strengths**. Select **+New authentication strength**.
1. Create **New authentication strength** to require **Microsoft Authenticator (Phone Sign-in)**.

     :::image type="content" source="media/sse-deployment-guide-private-access/new-authentication-strength-inline.png" alt-text="Screenshot of Identity, Protection, Conditional Access, Authentication strengths, New authentication strength window." lightbox="media/sse-deployment-guide-private-access/new-authentication-strength-extended.png":::
1. Go to **Policies**.
1. Create a new Conditional Access Policy as follows:
   1. **Users**: select a specific user
   1. **Target resources**: select a specific published app
   1. **Grant** > **Grant Access -- Require Authentication Strengths** (choose authentication strength created above)
   
     :::image type="content" source="media/sse-deployment-guide-private-access/grant-conditional-access-inline.png" alt-text="Screenshot of Conditional Access, Policies, Grant window." lightbox="media/sse-deployment-guide-private-access/grant-conditional-access-extended.png":::
1. To accelerate the enforcement of Conditional Access policies, right-click the Global Secure Access client in the Windows taskbar. Select **Switch user**. Wait for several seconds until prompted for authentication.
1. Open a remote desktop connection to the application server. Verify enforcement of Conditional Access by checking sign-in logs or confirming that expected authentication strength is prompted.

## Sample PoC scenario: control access by multiple users to multiple apps

In the earlier section, we applied Conditional Access to one application for a single user. In production, you need access control for multiple applications and users.

In this scenario, a Marketing department user needs to use RDP to open a remote desktop session to Server1. Additionally, a user in the Developer department needs to access a file share on Server using SMB protocol. Permissions to each application are configured so that users in the Marketing department can remote desktop into Server1 but can't access the file share on Server1. For additional access control, we enforce MFA to users in the Marketing department and require users in the Developer department to agree on the Terms of Use to access their resources.

1. Open the [Microsoft Entra admin center](https://entra.microsoft.com) and create two test users, such as *FirstUser* and *SecondUser*.

     :::image type="content" source="media/sse-deployment-guide-private-access/new-user-inline.png" alt-text="Screenshot of Identity, Users, All users, New user window." lightbox="media/sse-deployment-guide-private-access/new-user-extended.png":::
1. Create a group each for Marketing and Developers. Add *FirstUser* to the Marketing group and add *SecondUser* to the Developers group.

     :::image type="content" source="media/sse-deployment-guide-private-access/all-groups-inline.png" alt-text="Screenshot of Identity, Groups, All groups window." lightbox="media/sse-deployment-guide-private-access/all-groups-extended.png":::
1. Go to **Global Secure Access** > **Applications** > **Enterprise applications**. Select your test application from the [Publish application](#publish-application) section. Remove your earlier test user from **Users and groups** and replace it with the Marketing group.

     :::image type="content" source="media/sse-deployment-guide-private-access/users-and-groups-inline.png" alt-text="Screenshot of Global Secure Access, Applications, Enterprise applications, Users and groups window." lightbox="media/sse-deployment-guide-private-access/users-and-groups-extended.png":::
1. Create a second application to connect to your application server using SMB protocol over port 445.

     :::image type="content" source="media/sse-deployment-guide-private-access/create-app-segment-smb-protocol-inline.png" alt-text="Screenshot of Create Global Secure Access Application, Create SMB application segment window." lightbox="media/sse-deployment-guide-private-access/create-app-segment-smb-protocol-extended.png":::
1. In **Users and groups** of the new SMB application, add the Developers group.

     :::image type="content" source="media/sse-deployment-guide-private-access/app-users-groups-smb-inline.png" alt-text="Screenshot of Global Secure Access, Applications, Enterprise applications, Manage, Users and groups window for SMB app." lightbox="media/sse-deployment-guide-private-access/app-users-groups-smb-extended.png":::
1. Sign in to your test client device with the Marketing user identity *FirstUser*. Verify that *FirstUser* can successfully open a remote desktop connection to Server1 and that Developer group user *SecondUser* is blocked from opening a remote desktop connection to Server1.
2. Sign in to your test client device with the Developers user *SecondUser* and confirm that you can successfully connect to file shares on Server1. Confirm that Marketing user *FirstUser* can't connect to the same file share.
1. Create Conditional Access policies to add additional controls.
   - Conditional Access Policy 1
     - Name: MarketingToServer1
     - Users: Marketing group
     - Target Resource: RDPToServer1
     - Grant: Grant access, require multifactor authentication
     - Session: Sign-in frequency 1 hour
   - Conditional Access Policy 2
     - Name: DevelopersToServer1
     - Users: Developers group
     - Target Resource: SMBToServer1
     - Grant: Grant access, require Terms of Use
     - Session: Sign-in frequency 1 hour
1. Sign in with the respective users and verify Conditional Access policies.

### Sample PoC scenario: verify application access from traffic logs

You can monitor applications accessed via Microsoft Entra Private Access via the traffic logs.

1. Open the [Microsoft Entra admin center](https://entra.microsoft.com). Go to **Global Secure Access** > **Monitor** > **Traffic logs**.
1. Select **Private Access** to apply filter.
1. Select each log to view activity details with specific information about users and accessed applications.

     :::image type="content" source="media/sse-deployment-guide-private-access/activity-details.png" alt-text="Screenshot of Activity Details window.":::

1. Select **Add Filter** to find the information of interest (for example, User Principal Name contains UserA).

 > [!NOTE]
 > The IP Address listed in the **sourceIp** section is the public IP address of the client and not the IP Address of the Microsoft's Security Service Edge Solution Network.

## Next steps

[Deploy and verify Microsoft Entra Internet Access for Microsoft Traffic](sse-deployment-guide-microsoft-traffic.md)
[Deploy and verify Microsoft Entra Internet Access](sse-deployment-guide-internet-access.md)
