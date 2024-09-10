---
title: Secure JBoss EAP Java apps with Microsoft Entra ID and OpenID Connect
description: Integrate JBoss EAP primitives with Microsoft Entra ID and OpenID Connect.

author: deewhyweb
ms.service: entra-id
ms.subservice: enterprise-apps
ms.topic: how-to
ms.date: 09/05/2024
ms.author: edburns
ms.collection: M365-identity-device-management
ms.custom: enterprise-apps

#customer intent: As a developer, I want to make my JBoss EAP Java app use Microsoft Entra ID and OpenID Connect verify a user's identity.
---

# Secure JBoss EAP Java apps with Microsoft Entra ID & OpenID Connect

Red Hat JBoss EAP 8.0 (Enterprise Application Platform) includes native support for OpenID Connect (OIDC) via the `elytron-oidc-client` subsystem. OIDC is an identity layer that enables clients, such as JBoss EAP, to verify a user’s identity based on authentication performed by an OpenID provider. For example, you can secure your JBoss EAP applications using the Red Hat build of Keycloak as the OpenID provider. For more information on the Red Hat build of Keycloak, see the [Red Hat build of Keycloak getting started guide](https://docs.redhat.com/en/documentation/red_hat_build_of_keycloak/24.0/html/getting_started_guide/index).

In this article, we use the `elytron-oidc-subsystem` to secure a web application using Microsoft Entra ID (formerly Azure Active Directory) as the OpenID provider.

## Prerequisites

* A local installation of JBoss EAP 8.0. [Download the installation manager from Red Hat Developer.](https://developers.redhat.com/content-gateway/file/eap/8.0.0/jboss-eap-8.0.0-installation-manager.zip)
* JBOSS_HOME environment variable set as the installation folder for JBoss EAP 8.0.
* A Microsoft Azure account with an active subscription.

## Connect a web application to Microsoft Entra ID

In this section, we configure the connection to Microsoft Entra ID.

1. Check out the sample application here.
2. Create a file src/main/webapp/WEB-INF/oidc.json with the following contents:

    ```json
    {
        "client-id" : "<<from azure>",
        "provider-url" : "<<from azure>",
        "ssl-required" : "EXTERNAL",
        "credentials" : {
            "secret" : "<<from azure>>"
        }
    }
    ```

3. In the Azure portal, go to the All Services page and select **Microsoft Entra ID**.
4. In the left-hand menu, select **App registrations** and select **New Registration**. You see the **Register an application** page shown next.

    :::image type="content" source="./media/connect-web-application-to-microsoft-entra-id/azure-register-app.jpg" alt-text="Register a new application.":::

5. Enter a name (for example, `java`) and select the **Register** button. You see the **App registrations** overview page for your application.
6. Select **Add a Redirect URL**, then select **Add a Platform**.
7. Select **Web**; you see the **Configure Web** page, as shown next.

    :::image type="content" source="./media/connect-web-application-to-microsoft-entra-id/app-register.jpg" alt-text="Configure a web application.":::

8. Enter the following URL: `<http://localhost:8080/simple-webapp-oidc/secured>
9. Select the **Configure** button.
10. Go back to the **Overview** page and select **Add a certificate or secret**.
11. Select **+ New Client secret**. You see the **Add a client secret** page as shown next

    :::image type="content" source="./media/connect-web-application-to-microsoft-entra-id/add-secret.jpg" alt-text="Create a new secret.":::

12. Enter the description `EAP` and select the **Add** button.
13. Copy the value shown on the next page and paste this value into src/main/webapp/WEB-INF/oidc.json as the secret value.
14. Return to the **Overview** page and select **Endpoints**.
15. Copy the value from **OpenID Connect metadata** document and paste it into src/main/webapp/WEB-INF/oidc.json as the provider-url. Be sure to remove the text /.well-known/openid-configuration.
16. Return to the **Overview** page. Copy the **Application (client) ID** and paste this value in `src/main/webapp/WEB-INF/oidc.json` as the **client-id**.
17. Save the changes to the oidc.json file.

Our connection to Microsoft Entra ID is now configured, and we can deploy our application to JBoss EAP 8.0 and test the authentication.

## Test the Azure authentication

In this section, we deploy our application to a local instance of JBoss EAP and test integration to Microsoft Entra ID

1. First, we're going to start our JBoss EAP 8.0 instance. Run the following command to start JBoss EAP 8.0:

    ```bash
    $JBOSS_HOME/bin/standalone.sh 
    ```

2. We can now deploy our app. From the folder containing the sample application source code, enter:

    ```bash
    mvn wildfly:deploy 
    ```

3. We can access our application using <http://localhost:8080/simple-webapp-oidc/>.
4. Select **Access Secured Servlet**. you're redirected to the Azure sign in page as shown next. Sign in with your Azure credentials.

    :::image type="content" source="./media/connect-web-application-to-microsoft-entra-id/azure-login.jpg" alt-text="Azure Sign In Page":::

5. Next, you're redirected back to our application and you should see the secured servlet page. It contains the text `Secured Servle Current Principal 'xxxx'`

We were able to successfully sign in to our application via the Microsoft Entra ID provider!

With JBoss EAP 8.0, OpenID Connect support is provided by the included elytron-oidc-subsytem. In this article, we demonstrated how to secure a JBoss EAP 8.0 web application with Azure authentication via Open ID Connect.

## Next steps

- For more information on JBoss EAP on Azure, see [Red Hat JBoss EAP on Azure](/azure/developer/java/ee/jboss-on-azure).

- For more information on JBoss EAP 8.0 OpenID support, see [JBoss EAP product documentation](https://access.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/8.0/html/using_single_sign-on_with_jboss_eap/single-sign-on-in-server_default)
