---
title: Configure F5 Kerberos Constrained Delegation for a Single-Tier SaaS App
description: Learn how to configure single sign-on (SSO) between Microsoft Entra ID and F5.
author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu
ms.custom: sfi-image-nochange
---

# Configure F5 Kerberos Constrained Delegation for a Single-Tier SaaS App

In this article,  you learn how to integrate F5 with Microsoft Entra ID. When you integrate F5 with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to F5.
* Enable your users to be automatically signed-in to F5 with their Microsoft Entra accounts.
* Manage your accounts in one central location.

To learn more about SaaS app integration with Microsoft Entra ID, see [What is application access and single sign-on with Microsoft Entra ID](~/identity/enterprise-apps/what-is-single-sign-on.md).

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]

* F5 single sign-on (SSO) enabled subscription.

* Deploying the joint solution requires the following license:
    * F5 BIG-IP&reg; Best bundle (or)

    * F5 BIG-IP Access Policy Manager&trade; (APM) standalone license

    * F5 BIG-IP Access Policy Manager&trade; (APM) add-on license on an existing BIG-IP F5 BIG-IP&reg; Local Traffic Manager&trade; (LTM).

    * In addition to the above license, the F5 system might also be licensed with:

        * A URL Filtering subscription to use the URL category database

        * An F5 IP Intelligence subscription to detect and block known attackers and malicious traffic

        * A network hardware security module (HSM) to safeguard and manage digital keys for strong authentication

* F5 BIG-IP system is provisioned with APM modules (LTM is optional)

* Although optional, it's highly recommended to Deploy the F5 systems in a [sync/failover device group](https://techdocs.f5.com/content/techdocs/en-us/bigip-14-1-0/big-ip-device-service-clustering-administration-14-1-0.html) (S/F DG), which includes the active standby pair, with a floating IP address for high availability (HA). Further interface redundancy can be achieved using the Link Aggregation Control Protocol (LACP). LACP manages the connected physical interfaces as a single virtual interface (aggregate group) and detects any interface failures within the group.

* For Kerberos applications, an on-premises AD service account for constrained delegation.  Refer to [F5 Documentation](https://support.f5.com/csp/article/K43063049) for creating an AD delegation account.

## Access guided configuration

* Access guided configuration' is supported on F5 TMOS version 13.1.0.8 and above. If your BIG-IP system is running a version below 13.1.0.8, refer to the **Advanced configuration** section.

* Access guided configuration presents a new and streamlined user experience. This workflow-based architecture provides intuitive, re-entrant configuration steps tailored to the selected topology.

* Before proceeding to the configuration, upgrade the guided configuration by downloading the latest use case pack from [downloads.f5.com](https://login.f5.com/resource/login.jsp?ctx=719748). To upgrade, follow the below procedure.

    >[!NOTE]
    >The screenshots below are for the latest released version (BIG-IP 15.0 with AGC version 5.0). The configuration steps below are valid for this use case across from 13.1.0.8 to the latest BIG-IP version.

1. On the F5 BIG-IP Web UI, select **Access >> Guide Configuration**.

2. On the **Guided Configuration** page, select **Upgrade Guided Configuration** on the top left-hand corner.

    ![Screenshot that shows the "Guided Configuration" page with the "Upgrade Guided Configuration" action selected.](./media/kerbf5-tutorial/configure14.png) 

3. On the Upgrade Guide Configuration pop screen, select **Choose File** to upload the downloaded use case pack and select **Upload and Install** button.

    ![Screenshot that shows the "Upgrade Guided Configuration" pop-up screen with "Choose File" and "Upload and Install" selected.](./media/kerbf5-tutorial/configure15.png) 

4. When upgrade is completed, select the **Continue** button.

    ![Screenshot that shows the "Guided Configuration update is complete" dialog and the "Continue" button selected.](./media/kerbf5-tutorial/configure16.png)

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* F5 supports **SP and IDP** initiated SSO
* F5 SSO can be configured in three different ways.

- [Configure F5 single sign-on for Kerberos application](#configure-f5-single-sign-on-for-kerberos-application)

- [Configure F5 single sign-on for Header Based application](f5-big-ip-headers-easy-button.md)

- [Configure F5 single sign-on for Advanced Kerberos application](advance-kerbf5-tutorial.md)

### Key Authentication Scenarios

Apart from Microsoft Entra native integration support for modern authentication protocols like OpenID Connect, SAML and WS-Fed, F5 extends secure access for legacy-based authentication apps for both internal and external access with Microsoft Entra ID, enabling modern scenarios (such as password-less access) to these applications. This include:

* Header-based authentication apps

* Kerberos authentication apps

* Anonymous authentication or no inbuilt authentication apps

* NTLM authentication apps (protection with dual prompts for the user)

* Forms Based Application (protection with dual prompts for the user)

## Adding F5 from the gallery

To configure the integration of F5 into Microsoft Entra ID, you need to add F5 from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **F5** in the search box.
1. Select **F5** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-single-sign-on-for-f5'></a>

## Configure and test Microsoft Entra single sign-on for F5

Configure and test Microsoft Entra SSO with F5 using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in F5.

To configure and test Microsoft Entra SSO with F5, complete the following building blocks:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure F5 SSO](#configure-f5-sso)** - to configure the single sign-on settings on application side.
    1. **[Create F5 test user](#create-f5-test-user)** - to have a counterpart of B.Simon in F5 that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **F5** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the edit/pen icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, if you wish to configure the application in **IDP** initiated mode, enter the values for the following fields:

    a. In the **Identifier** text box, type a URL using the following pattern:
    `https://<YourCustomFQDN>.f5.com/`

    b. In the **Reply URL** text box, type a URL using the following pattern:
    `https://<YourCustomFQDN>.f5.com/`

1. Select **Set additional URLs** and perform the following step if you wish to configure the application in **SP** initiated mode:

    In the **Sign-on URL** text box, type a URL using the following pattern:
    `https://<YourCustomFQDN>.f5.com/`

    > [!NOTE]
    > These values aren't real. Update these values with the actual Identifier, Reply URL and Sign-on URL. Contact [F5 Client support team](https://support.f5.com/csp/knowledge-center/software/BIG-IP?module=BIG-IP%20APM45) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Federation Metadata XML** and **Certificate (Base64)** then select **Download** to download the certificate and save it on your computer.

    ![The Certificate download link](common/metadataxml.png)

1. On the **Set up F5** section, copy the appropriate URL(s) based on your requirement.

    ![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure F5 SSO

- [Configure F5 single sign-on for Header Based application](f5-big-ip-headers-easy-button.md)

- [Configure F5 single sign-on for Advanced Kerberos application](advance-kerbf5-tutorial.md)

### Configure F5 single sign-on for Kerberos application

### Guided Configuration

1. Open a new web browser window and sign into your F5 (Kerberos) company site as an administrator and perform the following steps:

1. You need to import the Metadata Certificate into the F5 which is used later in the setup process.

1. Navigate to **System > Certificate Management > Traffic Certificate Management > SSL Certificate List**. Select **Import** from the right-hand corner. Specify a **Certificate Name** (is referenced Later in the config). In the **Certificate Source**, select Upload File specify the certificate downloaded from Azure while configuring SAML Single Sign on. Select **Import**.

    ![Screenshot that shows the "S S L Certificate/Key Source" page with the "Certificate Name" highlighted, "Upload File" and the "Import" button selected.](./media/kerbf5-tutorial/configure01.png) 

1. Additionally, you require **SSL Certificate for the Application Hostname. Navigate to System > Certificate Management > Traffic Certificate Management > SSL Certificate List**. Select **Import** from the right-hand corner. **Import Type** is **PKCS 12(IIS)**. Specify a **Key Name** (is referenced Later in the config) and the specify the PFX file. Specify the **Password** for the PFX. Select **Import**.

    >[!NOTE]
    >In the example our app name is `Kerbapp.superdemo.live`, we're using a Wild Card Certificate our keyname is `WildCard-SuperDemo.live`

    ![Screenshot that shows the "S S L Certificate/Key Source" page with the values entered and the "Import" button selected.](./media/kerbf5-tutorial/configure02.png) 
 
1. We use the Guided Experience to set up the Microsoft Entra Federation and Application Access. Go to – F5 BIG-IP **Main** and select **Access > Guided Configuration > Federation > SAML Service Provider**. Select **Next** then select **Next** to begin configuration.

    ![Screenshot that shows the "Guided Configuration" page with the "Federation" icon highlighted and "S A M L Service Provider" selected.](./media/kerbf5-tutorial/configure03.png) 

    ![Screenshot that shows the "Guided Configuration - S A M L Service Provider" page with the "Next" button selected.](./media/kerbf5-tutorial/configure04.png)

1. Provide a **Configuration Name**. Specify the **Entity ID** (same as what you configured on the Microsoft Entra Application Configuration). Specify the **Host name**. Add a **Description** for reference. Accept the remaining default entries and select and then select **Save & Next**.

    ![Screenshot that shows the "Service Provider Properties" with "Host name" and "Description" text boxes highlighted and the "Save & Next" button selected.](./media/kerbf5-tutorial/configure05.png) 

1. In this example we're creating a new Virtual Server as 192.168.30.200 with port 443. Specify the Virtual Server IP address in the **Destination Address**. Select the Client **SSL Profile**, select Create new. Specify previously uploaded application certificate, (the wild card certificate in this example) and the associated key, and then select **Save & Next**.

    >[!NOTE]
    >in this example our Internal webserver is running on port 80 and we want to publish it with 443.

    ![Screenshot that shows the "Virtual Server Properties" page with the "Destination Address" text box highlighted and the "Save & Next" button selected.](./media/kerbf5-tutorial/configure06.png)

1. Under **Select method to configure your IdP connector**, specify Metadata, select **Choose File** and upload the Metadata XML file downloaded earlier from Microsoft Entra ID. Specify a unique **Name** for SAML IDP connector. Choose the **Metadata Signing Certificate** which was upload earlier. Select **Save & Next**.

    ![Screenshot that shows the "External Identity Provider Connector Settings" page with the "Name" text box highlighted and the "Save & Next" button selected.](./media/kerbf5-tutorial/configure07.png)  

1. Under **Select a Pool**, specify **Create New** (alternatively select a pool it already exists). Let other value be default.    Under Pool Servers, type the IP Address under **IP Address/Node Name**. Specify the **Port**. Select **Save & Next**.
 
    ![Screenshot that shows the "Pool Properties" page with the "IP Address/Node Name" and "Port" text boxes highlighted and the "Save & Next" button selected.](./media/kerbf5-tutorial/configure08.png)

1. On the Single Sign-On Settings screen, select **Enable Single Sign-On**. 
1. Under **Selected Single Sign-On Type** choose **Kerberos**. Replace **session.saml.last.Identity**  with **session.saml.last.attr.name.Identity** under **Username Source** (this variable it set using claims mapping in the Microsoft Entra ID
1. Select **Show Advanced Setting**
1. Under **Kerberos Realm** type the Domain Name. 
1. Under **Account Name/ Account Password**, Specify the APM Delegation Account and Password. 
1. Specify the Domain Controller IP in the **KDC** Field. 
1. Select **Save & Next**.
1. For purposes of this guidance, we'll skip endpoint checks.  Refer to F5 documentation for details.  On screen, select **Save & Next**.

1. Accept the defaults and select **Save & Next**. Consult F5 documentation for details regarding SAML session management settings.


    ![Screenshot that shows the "Timeout Settings" page with the "Save & Next" button selected.](./media/kerbf5-tutorial/configure11.png) 
 
1. Review the summary screen and select **Deploy** to configure the BIG-IP.
 
    ![Screenshot that shows the "Your application is ready to be deployed page" with the "Summary" section highlighted and the "Deploy" button selected.](./media/kerbf5-tutorial/configure12.png)

1. Once the application has been configured select **Finish**.

    ![Screenshot that shows the "Your application is deployed" page with the "Finish" button selected.](./media/kerbf5-tutorial/configure13.png)

## Advanced Configuration

>[!NOTE]
>For reference select [here](https://techdocs.f5.com/kb/en-us/products/big-ip_apm/manuals/product/apm-authentication-single-sign-on-12-1-0/2.html)

### Configuring an Active Directory AAA server

You configure an Active Directory AAA server in Access Policy Manager (APM) to specify domain controllers and credentials for APM to use for authenticating users.

1. On the Main tab, select **Access Policy > AAA Servers > Active Directory**. The Active Directory Servers list screen opens.

2. Select **Create**. The New Server properties screen opens.

3. In the **Name** field, type a unique name for the authentication server.

4. In the **Domain Name** field, type the name of the Windows domain.

5. For the **Server Connection** setting, select one of these options:

   * Select **Use Pool** to set up high availability for the AAA server.

   * Select **Direct** to set up the AAA server for standalone functionality.

6. If you selected **Direct**, type a name in the **Domain Controller** field.

7. If you selected Use **Pool**, configure the pool:

   * Type a name in the **Domain Controller Pool Name** field.

   * Specify the **Domain Controllers** in the pool by typing the IP address and host name for each, and selecting the **Add** button.

   * To monitor the health of the AAA server, you have the option of selecting a health monitor: only the **gateway_icmp** monitor is appropriate in this case; you can select it from the **Server Pool Monitor** list.

8. In the **Admin Name** field, type an is case-sensitive name for an administrator who has Active Directory administrative permissions. APM uses the information in the **Admin Name** and **Admin Password** fields for AD Query. If Active Directory is configured for anonymous queries, you don't need to provide an Admin Name. Otherwise, APM needs an account with sufficient privilege to bind to an Active Directory server, fetch user group information, and fetch Active Directory password policies to support password-related functionality. (APM must fetch password policies, for example, if you select the Prompt user to change password before expiration option in an AD Query action.) If you don't provide Admin account information in this configuration, APM uses the user account to fetch information. This works if the user account has sufficient privilege.

9. In the **Admin Password** field, type the administrator password associated with the Domain Name.

10. In the **Verify Admin Password** field, retype the administrator password associated with the **Domain Name** setting.

11. In the **Group Cache Lifetime** field, type the number of days. The default lifetime is 30 days.

12. In the **Password Security Object Cache Lifetime** field, type the number of days. The default lifetime is 30 days.

13. From the **Kerberos Preauthentication Encryption Type** list, select an encryption type. The default is **None**. If you specify an encryption type, the BIG-IP system includes Kerberos preauthentication data within the first authentication service request (AS-REQ) packet.

14. In the **Timeout** field, type a timeout interval (in seconds) for the AAA server. (This setting is optional.)

15. Select **Finished**. The new server displays on the list. 
This adds the new Active Directory server to the Active Directory Servers list.

    ![Screenshot that shows the "General Properties" and "Configuration" sections.](./media/kerbf5-tutorial/configure-17.png)

### SAML Configuration

1. You need to import the Metadata Certificate into the F5 which is used later in the setup process. Navigate to **System > Certificate Management > Traffic Certificate Management > SSL Certificate List**. Select **Import** from the right-hand corner.

    ![Screenshot that shows the "Import S S L Certificate/Key Source" page with the "Import" button selected.](./media/kerbf5-tutorial/configure18.png)

2. For setting up the SAML IDP, **navigate to Access > Federation > SAML: Service Provider > External Idp Connectors**, and select **Create > From Metadata**.

    ![Screenshot that shows the "S A M L Service Provider" page with "From Metadata" selected from the "Create" drop-down.](./media/kerbf5-tutorial/configure19.png)

    ![Screenshot that shows the "Create New S A M L I d P Connector" dialog.](./media/kerbf5-tutorial/configure20.png)

    ![Screenshot that shows the "Edit S A M L I d P Connector" window with "General Settings" selected.](./media/kerbf5-tutorial/configure21.png)

    ![Screenshot that shows the "Edit S A M L I d P Connector" window with "Single Sign On Service Settings" selected.](./media/kerbf5-tutorial/configure22.png)

    ![Screenshot that shows the "Edit S A M L I d P Connector" window with "Security Settings" selected.](./media/kerbf5-tutorial/configure23.png)

    ![Screenshot that shows the "Edit S A M L I d P Connector" window with "S L O Service Settings" selected.](./media/kerbf5-tutorial/configure24.png)

1. For setting up the SAML SP, navigate to **Access > Federation > SAML Service Provider > Local SP Services** and select **Create**. Complete the following information and select **OK**.

    * Type Name: KerbApp200SAML
    * Entity ID*: https://kerb-app.com.cutestat.com
    * SP Name Settings
    * Scheme: https
    * Host: kerbapp200.superdemo.live
    * Description: kerbapp200.superdemo.live

     ![Screenshot that shows the "Edit S A M L S P Service" window with "General Settings" selected.](./media/kerbf5-tutorial/configure25.png)

     b. Select the SP Configuration, KerbApp200SAML, and Select **Bind/UnBind IdP Connectors**.

     ![Screenshot that shows the "S A M L Service Provider - Local S P Services" page with "KerbAPP200 S A M L" selected.](./media/kerbf5-tutorial/configure26.png)

     ![Screenshot that shows the "Bind/Unbind I d P Connectors" button selected.](./media/kerbf5-tutorial/configure27.png)

     c. Select **Add New Row** and Select the **External IdP connector** created in previous step, select **Update**, and then select **OK**.

     ![Screenshot that shows the "Edit S A M L I d Ps that use this S P" window with the "Add New Row" button selected.](./media/kerbf5-tutorial/configure28.png)

1. For configuring Kerberos SSO, navigate to **Access > Single Sign-on > Kerberos**, complete information and select **Finished**.

    >[!Note]
    > You need the Kerberos Delegation Account to be created and specified. Refer KCD Section (Refer Appendix for Variable References)

    * **Username Source**: session.saml.last.attr.name.http:\//schemas.xmlsoap.org/ws/2005/05/identity/claims/givenname

    * **User Realm Source**: session.logon.last.domain

        ![Screenshot that shows the "Single Sign-On - Properties" page with the "Username Source" and "User Realm Source" text boxes highlighted.](./media/kerbf5-tutorial/configure29.png)

1. For configuring Access Profile, navigate to **Access > Profile/Policies > Access Profile (per session policies)**, select **Create**, complete the following information and select **Finished**.

    * Name: KerbApp200
    * Profile Type: All
    * Profile Scope: Profile
    * Languages: English

        ![Screenshot that shows the "Profiles/Policies - Properties" page with the "Name", "Profile Type", and "Languages" text boxes highlighted.](./media/kerbf5-tutorial/configure30.png)

1. Select the name, KerbApp200, complete the following information and select **Update**.

    * Domain Cookie: superdemo.live
    * SSO Configuration: KerAppSSO_sso

        ![Screenshot that shows the "S S D/Auth Domains" page with the "Domain Cookie" text box and "S S O Configuration" drop-down highlighted, and the "Update" button selected.](./media/kerbf5-tutorial/configure31.png)

1. Select **Access Policy** and then select **Edit Access Policy** for Profile "KerbApp200".

    ![Screenshot that shows the "Access Policy" page with the "Edit Access Policy for Profile KerbApp200" action selected.](./media/kerbf5-tutorial/configure32.png)

    ![Screenshot that shows the "Access Policy" page and the "S A M L Authentication S P" dialog.](./media/kerbf5-tutorial/configure33.png)

    ![Screenshot that shows the "Access Policy" page and the "Variable Assign" dialog with the "Assignment" text boxes highlighted.](./media/kerbf5-tutorial/configure34.png)

    * **session.logon.last.usernameUPN   expr {[mcget {session.saml.last.identity}]}**

    * **session.ad.lastactualdomain  TEXT superdemo.live**

        ![Screenshot that shows the "Access Policy" page and the "Active Directory" dialog with the "SearchFilter" text box highlighted.](./media/kerbf5-tutorial/configure35.png)

    * **(userPrincipalName=%{session.logon.last.usernameUPN})**

        ![Screenshot that shows the "Access Policy" page with "A D Query - Branch Rules" dialog.](./media/kerbf5-tutorial/configure36.png)

        ![Screenshot that shows the "Custom Variable" and "Custom Expression" text boxes highlighted.](./media/kerbf5-tutorial/configure37.png)

    * **session.logon.last.username  expr { "[mcget {session.ad.last.attr.sAMAccountName}]" }**

        ![Screenshot that shows the "Username from Logon Page" text box highlighted.](./media/kerbf5-tutorial/configure38.png)

    * **mcget {session.logon.last.username}**
    * **mcget {session.logon.last.password**

1. For adding New Node, navigate to **Local Traffic > Nodes > Node List, select Create**, complete the following information, and then select **Finished**.

    * Name: KerbApp200
    * Description: KerbApp200
    * Address: 192.168.20.200

        ![Screenshot that shows the "New Node" page with the "Name", "Description", and "Address" text boxes highlighted, and the "Finished" button selected.](./media/kerbf5-tutorial/configure39.png)

1. For creating a new Pool, navigate to **Local Traffic > Pools > Pool List, select Create**, complete the following information and select **Finished**.

    * Name: KerbApp200-Pool
    * Description: KerbApp200-Pool
    * Health Monitors: http
    * Address: 192.168.20.200
    * Service Port: 81

        ![Screenshot that shows the "New Pool" page with values entered and the "Finished" button selected.](./media/kerbf5-tutorial/configure40.png)

1. For creating Virtual Server, navigate to **Local Traffic > Virtual Servers > Virtual Server List > +**, complete the following information and select **Finished**.

    * Name: KerbApp200
    * Destination Address/Mask: Host 192.168.30.200
    * Service Port: Port 443 HTTPS
    * Access Profile: KerbApp200
    * Specify the Access Profile Created in Previous Step

        ![Screenshot that shows the "Virtual Server List" page with the "Name", "Destination Address/Mask", and "Service Port" text boxes highlighted.](./media/kerbf5-tutorial/configure41.png)

        ![Screenshot that shows the "Virtual Server List" page with the "Access Profile" drop-down highlighted.](./media/kerbf5-tutorial/configure42.png)

### Setting up Kerberos Delegation 

>[!NOTE]
>For reference, select [here](https://www.f5.com/pdf/deployment-guides/kerberos-constrained-delegation-dg.pdf)

*  **Step 1:** Create a Delegation Account

    **Example:**
    * Domain Name: **superdemo.live**

    * Sam Account Name: **big-ipuser**

    * New-ADUser -Name "APM Delegation Account" -UserPrincipalName host/big-ipuser.superdemo.live@superdemo.live -SamAccountName "big-ipuser" -PasswordNeverExpires $true -Enabled $true -AccountPassword (Read-Host -AsSecureString "Password!1234")

* **Step 2:** Set SPN (on the APM Delegation Account)

    **Example:**
    * setspn –A **host/big-ipuser.superdemo.live** big-ipuser

* **Step 3:** SPN Delegation (for the App Service Account)

    Set up the appropriate Delegation for the F5 Delegation Account.

    In the example below, APM Delegation account is being configured for KCD for FRP-App1.superdemo. live app.

    ![F5 (Kerberos) configuration](./media/kerbf5-tutorial/configure43.png)

* Provide the details as mentioned in the above reference document under [this](https://techdocs.f5.com/kb/en-us/products/big-ip_apm/manuals/product/apm-authentication-single-sign-on-12-1-0/2.html).

### Create F5 test user

In this section, you create a user called B.Simon in F5. Work with [F5 Client support team](https://support.f5.com/csp/knowledge-center/software/BIG-IP?module=BIG-IP%20APM45) to add the users in the F5 platform. Users must be created and activated before you use single sign-on. 

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration using the Access Panel.

When you select the F5 tile in the Access Panel, you should be automatically signed in to the F5 for which you set up SSO. For more information about the Access Panel, see [Introduction to the Access Panel](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Additional resources

- [List of articles on How to Integrate SaaS Apps with Microsoft Entra ID](./tutorial-list.md)

- [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

- [What is Conditional Access in Microsoft Entra ID?](~/identity/conditional-access/overview.md)



- [Configure F5 single sign-on for Header Based application](f5-big-ip-headers-easy-button.md)

- [Configure F5 single sign-on for Advanced Kerberos application](advance-kerbf5-tutorial.md)

- [F5 BIG-IP APM and Microsoft Entra integration for secure hybrid access](~/identity/enterprise-apps/f5-integration.md)

- [Article to deploy F5 BIG-IP Virtual Edition VM in Azure IaaS for secure hybrid access](~/identity/enterprise-apps/f5-bigip-deployment-guide.md)

- [Article for Microsoft Entra single sign-on integration with F5 BIG-IP for Password-less VPN](~/identity/enterprise-apps/f5-passwordless-vpn.md)
