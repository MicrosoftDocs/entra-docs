---
title: Set up CORS proxy server to manage headers for SPA with native authentication
description: Learn how to set up a CORS proxy server for single-page application that uses native authentication API.

author: kengaderdus
manager: mwongerapk
ms.author: kengaderdus
ms.service: entra-external-id
ms.subservice: external
ms.topic: tutorial
ms.date: 02/07/2025
#Customer intent: As a developer or DevOps engineer, I want to set up a CORS proxy server for a React single-page application that uses native authentication API so that I can manage CORS headers and enable the app to interact with the native authentication API.
---

# Tutorial: Set up CORS proxy server to manage CORS headers for native authentication (preview)

[!INCLUDE [applies-to-external-only](../external-id/includes/applies-to-external-only.md)]

In this tutorial, you learn how to set up the CORS proxy server to manage CORS headers while interacting with native authentication API from a React single-page app (SPA). The CORS proxy server is a solution to the native authentication API's inability to support [Cross-Origin Resource Sharing (CORS)](https://developer.mozilla.org/docs/Web/HTTP/CORS).

In this tutorial, you:

>[!div class="checklist"]
>
> - Create CORS proxy server.
> - Set up the CORS proxy server to call the native authentication API.
> - Run and test your React app.

## Prerequisites

- Complete the steps in [Tutorial: Create a React single-page app to sign in users into an external tenant using native authentication API](tutorial-native-authentication-single-page-app-react-sign-up.md).  

### Create the CORS proxy server

1. In the root folder of your React app, create a file called *cors.js*, then add the following code:

    ```javascript
    const http = require("http");
    const https = require("https");
    const url = require("url");
    const proxyConfig = require("./proxy.config.js");

    http
    .createServer((req, res) => {
        const reqUrl = url.parse(req.url);
        const domain = url.parse(proxyConfig.proxy).hostname;
        if (reqUrl.pathname.startsWith(proxyConfig.localApiPath)) {
        
            const targetUrl = proxyConfig.proxy + reqUrl.pathname?.replace(proxyConfig.localApiPath, "") + (reqUrl.search || "");

            console.log("Incoming request -> " + req.url + " ===> " + reqUrl.pathname);

            const proxyReq = https.request(
                targetUrl,
                {
                    method: req.method,
                    headers: {
                        ...req.headers,
                        host: domain,
                    },
                },
                (proxyRes) => {
                    res.writeHead(proxyRes.statusCode, {
                        ...proxyRes.headers,
                        "Access-Control-Allow-Origin": "*",
                        "Access-Control-Allow-Methods": "GET, POST, PUT, DELETE, OPTIONS",
                        "Access-Control-Allow-Headers": "Content-Type, Authorization",
                    });

                    proxyRes.pipe(res);
                }
            );

            proxyReq.on("error", (err) => {
                console.error("Error with the proxy request:", err);
                res.writeHead(500, { "Content-Type": "text/plain" });
                res.end("Proxy error.");
            });

            req.pipe(proxyReq);
        } else {
            res.writeHead(404, { "Content-Type": "text/plain" });
            res.end("Not Found");
        }
    })
    .listen(proxyConfig.port, () => {
        console.log("CORS proxy running on http://localhost:3001");
        console.log("Proxying from " + proxyConfig.localApiPath + " ===> " + proxyConfig.proxy);
    });
    ```

1. In the root folder of your React app, create a file called *proxy.config.js*, then add the following code:

    ```javascript
        const tenantSubdomain = "Enter_the_Tenant_Subdomain_Here";
        const tenantId = "Enter_the_Tenant_Id_Here";
    
        const config = {
            localApiPath: "/api",
            port: 3001,
            proxy: `https://${tenantSubdomain}.ciamlogin.com/${tenantId}`,
        };
        module.exports = config;
    ```

    - Find the placeholder `Enter_the_Tenant_Subdomain_Here` and replace it with the Directory (tenant) subdomain. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use `contoso`. If you don't have your tenant subdomain, learn how to [read your tenant details](../external-id/customers/how-to-create-external-tenant-portal.md#get-the-external-tenant-details).

    - `tenantId` and replace it with the Directory (tenant) ID. If you don't have your tenant ID, learn how to [read your tenant details](../external-id/customers/how-to-create-external-tenant-portal.md#get-the-external-tenant-details).

1. Open *package.json* file, then add the following command in the *scripts* object:

    ```json
    "cors": "node cors.js",
    ```

At this point, the React app and the CORS proxy server are ready to run.

## Run and test you app

1. Open a terminal window and navigate to the root folder of your app:

    ```console
    cd reactspa
    ```

1. To start the CORS proxy server, run the following command in your terminal:

    ```console
    npm run cors
    ```

1. To start the React app, open another terminal window, then run the following command:

    ```console
    cd reactspa
    npm start
    ```

1. Open a web browser and navigate to `http://localhost:3000/`. A sign-up form appears.

1. To sign up for an account, input your details, select the **Sign Up** button, then follow the prompts.

At this point, you've successfully created a React app that can sign up a user by using the native authentication API. Next, you can update the React app to sign in a user or reset the user's password.

## Additional information about CORS proxy server

In this tutorial, you set up a local CORS server. However, you can [set up a reverse proxy server to manage CORS headers by using Azure Function App as explained in a test environment](how-to-native-authentication-cors-solution-test-environment.md).

In a production environment, you can use the steps in [Set up a reverse proxy for a single-page app that uses native authentication API by using Azure Function App](how-to-native-authentication-cors-solution-production-environment.md) to set up your CORS proxy server.

## Related content

- [Tutorial: Sign in users into a React single-page app app by using native authentication](tutorial-native-authentication-single-page-app-react-sign-in.md).
- [Tutorial: Reset password in a React single-page app app by using native authentication](tutorial-native-authentication-single-page-app-react-reset-password.md).