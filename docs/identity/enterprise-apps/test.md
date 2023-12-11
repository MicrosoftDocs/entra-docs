## Microsoft Entra Application Gallery

The Microsoft Entra application gallery is a collection of software as a service (SaaS) applications that are preintegrated with Microsoft Entra ID. The gallery makes it easy to deploy and configure single sign-on (SSO) and automated user provisioning.

To access the gallery, sign into your tenant, select **Enterprise applications**, then **All applications**, and finally **New application**. From there, you can choose from applications that follow the SaaS model, allowing users to connect to and use cloud-based applications over the Internet. Examples include email, calendaring, and office tools like [Microsoft Office 365](https://www.microsoft.com/microsoft-365/enterprise).

Using applications from the gallery offers several benefits. The benefits include the best possible SSO experience for the application, simple and minimal configuration, and the ability to find the needed application quickly. Additionally, free, basic, and premium Microsoft Entra users can all use the application, and step-by-step configuration tutorials are available for onboarding gallery applications.

### Applications in the Gallery

The gallery contains thousands of preintegrated applications that you can search for by name or filter by specific criteria. The filters include SSO options (SAML, OpenID Connect, Password, or Linked), automated provisioning, and categories like Business Management, Collaboration, or Education. You can also find applications specific to major cloud platforms like AWS, Google, or Oracle.

#### Search for Applications

If you can't find the application you're looking for in the featured applications, you can search for a specific application by name. When searching for an application, you can also specify specific filters, such as single sign-on options, automated provisioning, and categories.

- **Single sign-on options** – You can search for applications that support these SSO options: SAML, OpenID Connect (OIDC), Password, or Linked. For more information about these options, see [Plan a single sign-on deployment in Microsoft Entra ID](~/identity-platform/single-sign-on-saml-protocol.md).
- **User account management** – The only option available is [automated provisioning](~/identity/app-provisioning/user-provisioning.md).
- **Categories** – When an application is added to the gallery it can be classified in a specific category. Many categories are available such as **Business management**, **Collaboration**, or **Education**.

#### Cloud Platforms

Applications that are specific to major cloud platforms, such as AWS, Google, or Oracle can be found by selecting the appropriate platform.

#### On-premises Applications

On-premises applications are connected to Microsoft Entra ID using Microsoft Entra application proxy. From the on-premises section of the Microsoft Entra gallery, you can:

- Configure Application Proxy to enable remote access to an on-premises application
- Use documentation to learn more about how to use Application Proxy to secure remote access to on-premises applications
- Manage any Application Proxy connectors that you created.

### Create Your Own Application

When you select **Create your own application**, you can choose to register an application to integrate with Microsoft Entra ID (App you're developing), integrate any other application you don't find in the gallery (Non-gallery), or configure Application Proxy for secure remote access to an on-premises application.

### Request New Gallery Application

If you can't find the application you're looking for in the gallery, you can request for it to be added by following the process outlined in [Request new gallery application](~/identity/enterprise-apps/v2-howto-app-gallery-listing.md).

## Conclusion

The Microsoft Entra application gallery is a valuable resource for users looking to deploy and configure SaaS applications with minimal effort. With thousands of preintegrated applications available, users can find the applications they need quickly and easily. Additionally, the gallery offers step-by-step configuration tutorials and supports various SSO options and automated provisioning.
