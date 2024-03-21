---
title: 'Tutorial: Microsoft Entra ID integration with Oracle HCM'
description: Integrating Oracle HCM with Microsoft Entra ID / on premises Active Directory using the Inbound Provisioning API.
author: jfields
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: tutorial
ms.date: 03/20/2024
ms.author: jeedes
---

# Tutorial: Microsoft Entra ID integration with Oracle HCM

The Inbound Provisioning API is a capability that allows you to create,
update, and delete users in Microsoft Entra ID / on premises Active
Directory from an external source, such as Oracle HCM. This enables
organizations to improve productivity, strengthen security and more
easily meet compliance and regulatory requirements. 

You can use Microsoft Entra ID Governance to automatically ensure that the right
people have the right access to the right resources, with identity and
access process automation, delegation to business groups, and increased
visibility.

In this tutorial, we will guide you through the steps and best practices
for integrating Oracle HCM with Microsoft Entra ID via API-driven
provisioning. You will learn how to:

- Prepare your environment and configure the API settings.
- Export your worker data from Oracle HCM in CSV format and transform it to the SCIM format using Microsoft scripts.
- Send your worker data to the Inbound Provisioning API using PowerShell or Logic Apps.
- Perform delta syncs to keep your worker data up to date using Oracle ATOM feed APIs or HCM Extracts.
- Configure writeback (if required) from Microsoft Entra ID to Oracle HCM using the Oracle HCM SCIM APIs.

## Terminology

-   [Oracle HCM Fusion Cloud](https://go.oracle.com/LP=139597?src1=:ad:pas:bi:dg:a_nas:l5:RC_MSFT220512P00060C01584:MainAd&gclid=9c09cb5c768b188a186aaea4b3735c3e&gclsrc=3p.ds&msclkid=9c09cb5c768b188a186aaea4b3735c3e): This guide focuses specifically on how to integrate from Oracle HCM Fusion Cloud to Entra ID. Other Oracle offerings like Peoplesoft and Taleo are not in scope for this tutorial.

-   Licensing:

    a. [Entra ID P1 License](https://www.microsoft.com/en-us/security/business/microsoft-entra-pricing) / [EMS E3](https://www.microsoft.com/en-us/licensing/product-licensing/enterprise-mobility-security#:~:text=Enterprise%20Mobility%20%2B%20Security%20E3%20includes%20Azure%20Active,Information%20Protection%29%20and%20the%20Windows%20Server%20CAL%20rights.) / [M365 E3](https://www.microsoft.com/en-us/microsoft-365/enterprise/e3?activetab=pivot:overviewtab): These licenses allow you to use our new API-driven
        provisioning feature.

    b. [Entra ID Governance License:](https://learn.microsoft.com/en-us/entra/id-governance/licensing-fundamentals): This add-on license is required to configure lifecycle workflows.

    c. [Azure subscription](https://azure.microsoft.com/en-us/): Required if you plan to use Logic Apps.

## Prerequisites

Before you start integrating Oracle HCM with Microsoft Entra ID using the Inbound Provisioning API, you need to ensure that you have the following prerequisites:

-  An [Oracle HCM](https://docs.oracle.com/en/cloud/saas/human-resources/23c/oawpm/Human_Capital_Management_Integration_Specialist_job_roles.html#Human_Capital_Management_Integration_Specialist_job_roles) account with privileges to:

    a.  View and export HCM data.

    b.  Access to the Oracle HCM REST APIs. For this tutorial we
        referenced [Human Resources 24A](https://docs.oracle.com/en/cloud/saas/human-resources/24a/farws/rest-endpoints.html).
        and [Applications Commo 24A](https://docs.oracle.com/en/cloud/saas/applications-common/24a/farca/rest-endpoints.html).

-  An Entra ID tenant with a minimum Entra ID P1 license (EMS E3 / M365 E3):

    a.  For installing the provisioning agent (hybrid users only): Access to Windows Server connected to your AD Domain.

    b.  To create gallery app and provisioning job: Entra Admin with [Application Admin](https://learn.microsoft.com/en-us/entra/identity/role-based-access-control/permissions-reference#application-administrator) and [Hybrid Identity Admin](https://learn.microsoft.com/en-us/entra/identity/role-based-access-control/permissions-reference#hybrid-identity-administrator) roles.

## Integration Overview

To set up an HR integration there are 3 main scenarios. The diagram below illustrates the 3 sync scenarios. This guide is split up and organized into these 3 sections. For each workflow, we provide a recommendation on how to configure.

- **Initial / Full Sync** is the process of synchronizing all worker data between two systems, in this case: Oracle HCM and Microsoft Entra ID directly or to on-premises Active Directory. This includes all worker identities and attributes such as personal information, contact information, employment information, and more. A full sync
is typically performed during the initial integration setup to ensure that all worker data is consistent and up to date across both systems.

- **Delta Sync** is the process of synchronizing only the changes or updates that have occurred since the last sync with Oracle HCM. Delta syncs are typically performed after the initial full sync to keep worker data up to date with any changes that occur in the
source system. This includes new employees, updated employee data, or deleted employees. Delta syncs are incremental updates and are faster and more efficient than performing a full sync every time any worker data changes.

- **Writeback** is the optional process of sending user attribute changes that occur in Entra ID (such as username, email, and phone numbers) back to Oracle HCM.

:::image type="content" border="true" source="./media/oracle-hcm-provisioning/oracle-hcm-provisioning.png" alt-text="Diagram of Oracle HCM driven provisioning plus writeback.":::

## Integration Steps


+---+------------------+----------------------------+-----------------+
| * | **Step**         | **What to do**             | **Who to        |
| * |                  |                            | engage**        |
| \ |                  |                            |                 |
| # |                  |                            |                 |
| * |                  |                            |                 |
| * |                  |                            |                 |
+===+==================+============================+=================+
| 1 | Determine which  | -                          | Oracle HCM      |
|   | set of           | -                          | Admin & IT      |
|   | attributes you   | -                          | Admin           |
|   | want to          |                            |                 |
|   | provision from   |                            |                 |
|   | HCM.             |                            |                 |
+---+------------------+----------------------------+-----------------+
| 2 | Determine your   | -   If your target is      | For             |
|   | provisioning     |     Entra ID (cloud-only   | provisioning    |
|   | target. Are you  |     identity provisioning) | agent           |
|   | provisioning     |                            | installation:   |
|   | cloud-only       |     -   [Configure gallery | involve windows |
|   | identities to    |         ap                 | admin           |
|   | Entra ID or      | p](#_For_cloud-only_users) |                 |
|   | hybrid           |                            | For gallery app |
|   | identities to    |     -   [Map SCIM to Entra | configuration:  |
|   | on-prem AD?      |         ID                 | engage admin    |
|   |                  |                            | with            |
|   |                  |        attributes](#worksh | application     |
|   |                  | eet-6-scim-attribute-to-en | admin           |
|   |                  | tra-id-attributes-mapping) | privileges      |
|   |                  |                            |                 |
|   |                  | -   If your target is      |                 |
|   |                  |     on-premises Active     |                 |
|   |                  |     Directory (hybrid      |                 |
|   |                  |     identity               |                 |
|   |                  |     provisioning):         |                 |
|   |                  |                            |                 |
|   |                  |     -   [Download and      |                 |
|   |                  |         configure          |                 |
|   |                  |         provisioning       |                 |
|   |                  |                            |                 |
|   |                  |  agent](#for-hybrid-users) |                 |
|   |                  |                            |                 |
|   |                  |     -   [Configure gallery |                 |
|   |                  |                            |                 |
|   |                  |    app](#for-hybrid-users) |                 |
|   |                  |                            |                 |
|   |                  |     -                      |                 |
|   |                  |                            |                 |
|   |                  |     -                      |                 |
+---+------------------+----------------------------+-----------------+
| 3 | Perform Initial  | -   [Prepare for Initial   | IT Admin        |
|   | Sync to send     |     Sync](                 |                 |
|   | full scope of    | #prepare-for-initial-sync) |                 |
|   | data to          |                            |                 |
|   | provisioning     | -   [Perform CSV export    |                 |
|   | endpoint         |     and send data to       |                 |
|   |                  |     API](#cs               |                 |
|   |                  | v-export-for-initial-sync) |                 |
|   |                  |                            |                 |
|   |                  | -   Validate that the      |                 |
|   |                  |     right workers have     |                 |
|   |                  |     been matched and are   |                 |
|   |                  |     present in Entra ID /  |                 |
|   |                  |     AD                     |                 |
+---+------------------+----------------------------+-----------------+
| 4 | Perform Delta    | Use 1 of the below 2       | IT Admin        |
|   | Syncs to keep    | methods                    |                 |
|   | data in Entra ID |                            |                 |
|   | up to date.      | -                          |                 |
|   |                  | -                          |                 |
+---+------------------+----------------------------+-----------------+
| 5 | Writeback data   | -   [Configure and run     | IT Admin        |
|   | to Oracle HCM    |     writeback provisioning |                 |
|   |                  |     jo                     |                 |
|   |                  | b](#writeback-from-microso |                 |
|   |                  | ft-entra-id-to-oracle-hcm) |                 |
+---+------------------+----------------------------+-----------------+
| 6 | Recommended:     | -   [Automate your Joiner, | IT Admin        |
|   | Configure Entra  |     Mover, Leaver          |                 |
|   | Lifecycle        |     processes using Entra  |                 |
|   | Workflows        |     LCW](https:            |                 |
|   |                  | //learn.microsoft.com/en-u |                 |
|   |                  | s/entra/id-governance/what |                 |
|   |                  | -are-lifecycle-workflows). |                 |
|   |                  |                            |                 |
|   |                  | -   [Governance License    |                 |
|   |                  |     required](https        |                 |
|   |                  | ://learn.microsoft.com/en- |                 |
|   |                  | us/entra/id-governance/ide |                 |
|   |                  | ntity-governance-overview) |                 |
+---+------------------+----------------------------+-----------------+

## Configure gallery application

Before you can configure the provisioning job in Entra, you need to
determine if the target for your provisioning is on-prem AD, or Entra
ID. If you wish to have hybrid users with an on-prem dependency, AD will
be your target. If your users are cloud only, you can provision them
directly to Entra ID.

## For cloud-only users

Configure the gallery application "API-driven provisioning to Microsoft
Entra ID". Follow these steps to [create the gallery
application.](https://learn.microsoft.com/en-us/entra/identity/app-provisioning/inbound-provisioning-api-configure-app#create-your-api-driven-provisioning-app)

Next, follow these steps to [configure the
application.](https://learn.microsoft.com/en-us/entra/identity/app-provisioning/inbound-provisioning-api-configure-app#configure-api-driven-inbound-provisioning-to-microsoft-entra-id)

## For hybrid users

You will need to work with your Windows admin to install the
provisioning agent on a domain-joined Windows Server. Reference this
link for steps on [configuring the
application](https://learn.microsoft.com/en-us/entra/identity/app-provisioning/inbound-provisioning-api-configure-app#create-your-api-driven-provisioning-app)
and [installing the provisioning
agent.](https://learn.microsoft.com/en-us/entra/identity/hybrid/cloud-sync/how-to-install)

Configure the gallery application "API-driven provisioning to
on-premises Active Directory". Follow these steps to [create the gallery
application.](https://learn.microsoft.com/en-us/entra/identity/app-provisioning/inbound-provisioning-api-configure-app#create-your-api-driven-provisioning-app)

# Prepare for initial sync

Before sending your initial sync payload, you need to make sure your
data is prepared to properly sync with Entra. The steps below help
ensure a smooth integration.

1)  **[Matching
    identifier](https://learn.microsoft.com/en-us/entra/identity/app-provisioning/customize-application-attributes#matching-users-in-the-source-and-target--systems)
    presence and uniqueness:** The provisioning service uses a matching
    attribute to uniquely identify and link worker records in your
    Oracle system with corresponding user accounts in AD / Entra ID. The
    default matching attribute pair is Person Number in Oracle HCM
    mapped to employee ID attribute in Entra ID / on-prem AD. Ensure
    that the value of employee ID is populated in Entra ID (for
    cloud-only users) and on-premises AD (for hybrid users) before
    initiating full sync and it uniquely identifies a user.

2)  **Use [scoping
    filters](https://learn.microsoft.com/en-us/entra/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts?pivots=cross-tenant-synchronization)
    to skip HR records that are no longer relevant:** HR systems have
    several years of employment data probably going all the way back to
    1970s. On the other hand, your IT team may only be interested in the
    list currently active employees and termination records that will
    come through after go-live. To filter out HR records that are no
    longer relevant from your IT team perspective, identify scoping
    filters rules that you'd like to configure in Entra.

# CSV Export for initial sync

In this step you will export your worker data from Oracle HCM in CSV
format and transform it to SCIM format using the Microsoft CSV to SCIM
scripts. This will allow you to send your worker data to the Inbound
Provisioning API in a standards-based payload that it can understand and
process.

Share the list of Oracle HCM worker attributes you wish to export with
your Oracle HCM administrator. To export your worker data from Oracle
HCM in CSV format, Oracle provides multiple options.

1.  Using HCM Extract tool - The main way to retrieve data in bulk from
    Oracle HCM Cloud is by using HCM Extracts, a tool for generating
    data files and reports. HCM Extracts has a dedicated interface for
    specifying the records and attributes to be extracted. With this
    tool, you can:

    a.  Identify records for extraction using complex selection
        criteria.

    b.  Define data elements in an HCM extract using fast formula
        database items and rules.

> Refer to this link to get started with creating your HCM Extracts:
> [Define Extracts
> (oracle.com)](https://docs.oracle.com/en/cloud/saas/human-resources/23c/fahex/define-extracts.html#s20034537)

2.  Using BI Publisher - Oracle BI Publisher supports both scheduled and
    unplanned reporting, based on either predefined Oracle Transactional
    Business Intelligence analysis structures or your own data models.
    You can generate reports in various formats. To use Oracle BI
    Publisher for outbound integrations, you generate reports in a
    format suitable for automatic downstream processing, such as XML or
    CSV. Refer to this link to get started with creating your BI
    Publisher report: [Define the BI Publisher Template in HCM Extracts
    (oracle.com)](https://docs.oracle.com/en/cloud/saas/human-resources/23c/fahex/define-the-bi-publisher-template-in-hcm-extracts.html#s20043805)

3.  Oracle Integration Cloud Service - If you have a subscription to
    OIC, you can configure the integration with the [Oracle HCM
    Adapter](https://docs.oracle.com/en/cloud/paas/integration-cloud/hcm-adapter/understand-oracle-hcm-cloud-adapter.html#GUID-40A15882-F8D1-452E-9E9C-1B184616E1A8)
    to extract the required data from Oracle HCM. Oracle provides a
    [recipe](https://docs.oracle.com/en/cloud/paas/integration-cloud/int-get-started/export-employee-data-oracle-hcm-cloud-identity-management-system.html#GUID-DE0A58BC-25F1-4013-A87C-E4A0123A94EE)
    that you can use for guidance. You can use this recipe to get
    started.

Work with your Oracle HCM administrator to export your required
attributes into a CSV file.

After you have exported your worker data to a CSV file, you need to
transform the CSV to SCIM format so that the payload is in a format that
we can accept. We provide documentation and sample code for how to
transform your CSV into a SCIM payload via 2 methods: PowerShell and
Logic Apps. Here are the steps for how to perform this transformation
with each method:

1)  PowerShell

    a.  [API-driven inbound provisioning with PowerShell script -
        Microsoft Entra ID \| Microsoft
        Learn](https://learn.microsoft.com/en-us/entra/identity/app-provisioning/inbound-provisioning-api-powershell)

2)  Logic Apps

    a.  [API-driven inbound provisioning with Azure Logic Apps -
        Microsoft Entra ID \| Microsoft
        Learn](https://learn.microsoft.com/en-us/entra/identity/app-provisioning/inbound-provisioning-api-logic-apps)

The inbound provisioning steps above include sending the provisioning
payload. Before you send the payload, make sure to click "Start
provisioning" in the Entra portal so that the provisioning job is
listening to new requests. Before sending the full file for processing,
send 5-10 records to validate the correct matching of workers and
attributes. After the payload is sent, the users will show up shortly in
your Entra ID tenant /on-prem AD.

# Delta syncs

After you have sent your worker data to the Inbound Provisioning API for
the initial sync, you need to perform delta syncs to keep your worker
data up to date. Delta syncs are incremental updates that only send the
changes that have occurred since the last sync, such as new workers,
updated workers, or deleted workers.

To perform delta syncs, you have three options:

**Option 1:** Use the Oracle ATOM feed APIs to get real-time
notifications of worker changes in Oracle HCM and send them to the
Inbound Provisioning API

**Option 2:** Use CSV Extracts to generate periodic reports of worker
changes in Oracle HCM and send the extracts to the Inbound Provisioning
API using your own automation tool or Logic Apps

**Option 3:** [Oracle Integration Cloud
Service](https://docs.oracle.com/en/cloud/paas/application-integration/) -
If you have a subscription to OIC, you can configure the integration
with the [Oracle HCM
Adapter](https://docs.oracle.com/en/cloud/paas/integration-cloud/hcm-adapter/understand-oracle-hcm-cloud-adapter.html#GUID-40A15882-F8D1-452E-9E9C-1B184616E1A8)
to extract the required data from Oracle HCM. Oracle provides a
[recipe](https://docs.oracle.com/en/cloud/paas/integration-cloud/int-get-started/export-employee-data-oracle-hcm-cloud-identity-management-system.html#GUID-DE0A58BC-25F1-4013-A87C-E4A0123A94EE)
that you can use for guidance.

## Option 1: Use the Oracle ATOM feed APIs

The Oracle ATOM feed APIs provide real-time notifications of worker
changes in Oracle HCM. You can subscribe to the ATOM feed APIs and
receive a JSON representation of attributes that contain the worker data
that has changed. You can then transform the JSON to SCIM format and
send them to the Inbound Provisioning API using our sample PowerShell
script or Logic Apps integration.

If you intend to use the ATOM feeds integration, make sure to turn on
ATOM feeds immediately after your initial sync. A delay in this step can
lead to loss of changes.

To get started with Oracle[']{.underline}s ATOM feeds, reference the
[Oracle
documentation](https://docs.oracle.com/en/cloud/saas/human-resources/23d/farws/Working_with_Atom.html)
and guidance. We recommend subscribing to the [Employee
workspace](https://docs.oracle.com/en/cloud/saas/human-resources/24a/farws/Employee_Atom_Feeds.html)
and leveraging these Atom Feed collections: **newhire, empassignment,
empupdate, termination, cancelworkrelship, workrelshipupdate**. You can
also review the
[Workstructures](https://docs.oracle.com/en/cloud/saas/human-resources/24a/farws/Workstructures_Atom_Feeds.html)
workspace and can include it if you want to handle scenarios such as
organization name changes and job name changes.

Once you have configured ATOM feeds in your HCM tenant, you will need to
create a custom module that reads the output of the ATOM feed API and
sends the data to Microsoft Entra ID using the Inbound Provisioning API.
The logic in the custom module is responsible for handling the following
scenarios:

1)  Data validation

2)  Unique ID generation

3)  Sequencing of ATOM feeds

4)  Conversion of ATOM feeds to SCIM payloads

5)  Error handling

We recommend using an Oracle HCM partner or a Microsoft System
Integrator to build this custom module. You can host this custom module
either in an Oracle middleware like Oracle Integration Cloud, or in
Azure cloud as an Azure function or Azure Logic Apps.

Implement logic in the custom module to query ATOM feed endpoints of
interest. The response returned is the JSON representation of the
changes. Process the JSON payload to extract attributes of interest. If
required, query the
[Workers](https://docs.oracle.com/en/cloud/saas/human-resources/24a/farws/op-workers-workersuniqid-get.html)
or
[Employees](https://docs.oracle.com/en/cloud/saas/human-resources/24a/farws/api-employees.html)
endpoints directly to retrieve additional worker attributes. Combine the
data to create a SCIM payload to send to the Microsoft API-driven
provisioning endpoint.

Here is a generic example of how the Oracle HCM attributes could map to
attributes in the SCIM payload based on the Oracle HCM to SCIM
worksheet:

{

\"schemas\": \[\"urn:ietf:params:scim:api:messages:2.0:BulkRequest\"\],

\"Operations\": \[

{

\"method\": \"POST\",

\"bulkId\": \"897401c2-2de4-4b87-a97f-c02de3bcfc61\",

\"path\": \"/Users\",

\"data\": {

\"schemas\": \[\"urn:ietf:params:scim:schemas:core:2.0:User\",

\"urn:ietf:params:scim:schemas:extension:enterprise:2.0:User\"\],

\"externalId\": \"\<Oracle HCM workers.PersonNumber\>\",

\"userName\": "\<Oracle HCM employee.UserName",

\"name\": {

\"familyName\": \"\< Oracle HCM workers.names.LastName\>\",

\"givenName\": \" \<Oracle HCM workers.names.FirstName\> \",

\"middleName\": \" \<Oracle HCM workers.names.MiddleName\>\",

},

\"displayName\": \" \< Oracle HCM workers.DisplayName\>\",

\"emails\": \[

{

\"value\": \"\<Oracle HCM workers.emails.EmailAddress\> \",

\"type\": \"work\",

\"primary\": true

}

\],

\"addresses\": \[

{

\"type\": \"work\",

\"streetAddress\": \" \<Oracle HCM workers.addresses.AddressLine1\>\",

\"locality\": \" \<Oracle HCM workers.addresses.TownorCity\>\",

\"region\": \" \<Oracle HCM workers.addresses.Region1\>\",

\"postalCode\": \" \<Oracle HCM workers addresses.PostalCode\> \",

\"country\": \" \<Oracle HCM workers addresses.Country\> \",

\"primary\": true

}

\],

\"phoneNumbers\": \[

{

\"value\": \" \<Oracle HCM workers. phones.PhoneNumber \",

\"type\": \"work\"

}

\],

\"userType\": \" \<Oracle HCM workers.workRelationships.WorkerType \",

\"title\": \" \<Oracle HCM
worker.workRelationships.assignments.JobName\",

\"active\":true,

\"urn:ietf:params:scim:schemas:extension:enterprise:2.0:User\": {

\"employeeNumber\": \" \<Oracle HCM workers.PersonNumber\> \",

\"division\":

\" \<Oracle HCM worker.workRelationships.assignments.BusinessUnitId\>
\",

\"department\":

> \"\<Oracle HCM worker.workRelationships.assignments.DepartmentId \>\",

\"manager\": {

value\": \" \<Oracle HCM
worker.workRelationships.assignments.allReports.ManagerPersonNumber\>
\",

\"displayName\": \" \<Oracle HCM
worker.workRelationships.assignments.allReports.ManagerDisplayName\"

}

}

}

},

Once it is in [SCIM bulk
request](https://learn.microsoft.com/en-us/entra/identity/app-provisioning/inbound-provisioning-api-graph-explorer#bulk-request-with-scim-enterprise-user-schema)
format, you can send the data to the
/[bulkUpload](https://learn.microsoft.com/en-us/graph/api/synchronization-synchronizationjob-post-bulkupload?view=graph-rest-1.0&source=recommendations)
API endpoint via API-driven provisioning. Before enabling the
integration, run manual tests and verifications to validate the SCIM
bulk request payload structure. You may use tools like use tools like
[Postman](https://learn.microsoft.com/en-us/entra/identity/app-provisioning/inbound-provisioning-api-postman)
or [Graph
Explorer](https://learn.microsoft.com/en-us/entra/identity/app-provisioning/inbound-provisioning-api-graph-explorer)
to confirm that the bulk request payloads are processed as expected.

If you do not wish to engage a partner or build your own custom module,
we recommend choosing "Option 2: Use HCM Extracts" below.

## Option 2: Use CSV Extracts

Like the method used in the initial sync, you can use CSV extracts to
handle your delta syncs. You can configure your extract to only run new
changes from the previous sync, or you can send the full scope of your
worker data and the Entra ID Provisioning Service will manage and update
any changes such as new hires, attributes changes, and terminations.

Like in initial sync, you can use multiple options to obtain the CSV
extract:

1.  Using HCM Extract tool - The main way to retrieve data in bulk from
    Oracle HCM Cloud is by using HCM Extracts, a tool for generating
    data files and reports. HCM Extracts has a dedicated interface for
    specifying the records and attributes to be extracted. With this
    tool, you can:

    a.  Identify records for extraction using complex selection
        criteria.

    b.  Define data elements in an HCM extract using fast formula
        database items and rules.

> Refer to this link to get started with creating your HCM Extracts:
> [Define Extracts
> (oracle.com)](https://docs.oracle.com/en/cloud/saas/human-resources/23c/fahex/define-extracts.html#s20034537)

2.  Using BI Publisher - Oracle BI Publisher supports both scheduled and
    unplanned reporting, based on either predefined Oracle Transactional
    Business Intelligence analysis structures or your own data models.
    You can generate reports in various formats. To use Oracle BI
    Publisher for outbound integrations, you generate reports in a
    format suitable for automatic downstream processing, such as XML or
    CSV. Refer to this link to get started with creating your BI
    Publisher report: [Define the BI Publisher Template in HCM Extracts
    (oracle.com)](https://docs.oracle.com/en/cloud/saas/human-resources/23c/fahex/define-the-bi-publisher-template-in-hcm-extracts.html#s20043805)

3.  Oracle Integration Cloud Service - If you have a subscription to
    OIC, you can configure the integration with the [Oracle HCM
    Adapter](https://docs.oracle.com/en/cloud/paas/integration-cloud/hcm-adapter/understand-oracle-hcm-cloud-adapter.html#GUID-40A15882-F8D1-452E-9E9C-1B184616E1A8)
    to extract the required data from Oracle HCM. Oracle provides a
    [recipe](https://docs.oracle.com/en/cloud/paas/integration-cloud/int-get-started/export-employee-data-oracle-hcm-cloud-identity-management-system.html#GUID-DE0A58BC-25F1-4013-A87C-E4A0123A94EE)
    that you can use for guidance. You can use this recipe to get
    started.

Once you have your worker data in CSV format, use either of the
following two methods to convert that into a SCIM payload and send the
data to our provisioning service.

1)  PowerShell

    a.  [API-driven inbound provisioning with PowerShell script -
        Microsoft Entra ID \| Microsoft
        Learn](https://learn.microsoft.com/en-us/entra/identity/app-provisioning/inbound-provisioning-api-powershell)

2)  Logic Apps

    a.  [API-driven inbound provisioning with Azure Logic Apps -
        Microsoft Entra ID \| Microsoft
        Learn](https://learn.microsoft.com/en-us/entra/identity/app-provisioning/inbound-provisioning-api-logic-apps)

# Writeback from Microsoft Entra ID to Oracle HCM

After you have synchronized your worker data from Oracle HCM using the
Inbound Provisioning API, you may want to configure writeback from the
Microsoft Entra Provisioning Service to Oracle HCM. Writeback is the
process of sending user changes that occur in Entra ID back to Oracle
HCM, such as username, email, and phone numbers. This ensures that your
data is consistent and accurate across both systems.

To configure writeback, you need to use the Oracle HCM SCIM APIs. The
[Oracle HCM SCIM
APIs](https://docs.oracle.com/en/cloud/saas/applications-common/24a/farca/Quick_Start.html)
are RESTful web services that allow you to create, update, and delete
users in Oracle HCM from an external source, such as Entra. You can use
the Microsoft Entra Provisioning Service to connect Entra to the Oracle
HCM SCIM APIs and map the user attributes that you want to write back.

To set up writeback you'll need to configure an outbound provisioning
job to your Oracle HCM tenant. To configure writeback, you'll need the
following info:

1)  **REST Server URL**, which is normally the URL of your Oracle Cloud
    Service. It should look like this:
    [https://servername.fa.us2.oraclecloud.com](https://servername.fa.us2.oraclecloud.com/hcmRestApi/scim).

2)  **Secret Token** from HCM environment which will provide your HCM
    tenant with access to other systems (like Microsoft Entra).

    a.  Create an OAUTH token in HCM and save it for use in the steps
        below. You can create an OAUTH token by going to step 4 in the
        following guide:
        <https://docs.oracle.com/en/cloud/saas/applications-common/24a/farca/Quick_Start.html>
        )

Once you have your REST Server URL and your Secret Token, follow the
steps below to configure the writeback job in Entra ID:

1)  Create a new Enterprise application.

2)  Select the Provisioning option and switch the mode to Automatic.

3)  Enter the endpoint URL of your Oracle HCM tenant and the
    authentication token in the REST Server URL and Secret Token fields.

4)  Test the connection and save the settings.

5)  Go back to the provisioning "overview" page for this application and
    select "edit provisioning". Click the arrow under mappings and click
    the link of the mapping schema.

6)  In the edit Attribute Mapping section, select only the "Update"
    operation under "target object actions".

7)  You will see that HCM attributes have been automatically populated
    in the attribute mappings section. Just remove attributes that you
    do not want to writeback data.

8)  Save the settings and enable the provisioning status.

9)  Use Entra's Provision on Demand capability to test and validate the
    writeback integration.

10) Once you have validated the workflow, start the job and keep it
    running for Entra to continuously sync data back to Oracle HCM.

# Appendix

## Worksheet 1: Oracle HCM attributes 

This table represents attributes that you can export from Oracle HCM.
The names of these attributes may differ in your HCM system, but this
represents a common list of attributes in an HR integration. Determine
which attributes you wish to export for your integration.

  -----------------------------------------------------------------------
  Oracle HCM Attribute (from CSV file)
  -----------------------------------------------------------------------
  Person Number **(mandatory attribute)**

  Account Status **(mandatory attribute) -\> set value as true for
  non-terminated workers**

  Street Adress

  City

  State

  Postal Code

  Country

  Department Name

  Division

  Company

  Username

  First Name **(mandatory attribute)**

  Last Name **(mandatory attribute)**

  Job Code

  Job Name

  Email Address

  Manager

  Mobile Phone Number

  Phone Number

  Work Address

  Phone Number

  Hire Date **(required by Lifecycle Workflows)**

  Termination Date **(required by Lifecycle Workflows)**

  -----------------------------------------------------------------------

We have also included blank rows in this worksheet as you can add any
other attributes not in this list that you wish to include in your
provisioning job.

## Worksheet 2: Oracle HCM to SCIM attribute mapping 

This table displays a sample mapping from the Oracle HCM attributes to
the generic SCIM attributes supported by the API.

+--------------+-------------------------------------------------------+
| Oracle HCM   | SCIM Attribute                                        |
| Attribute    |                                                       |
| (from CSV    |                                                       |
| file)        |                                                       |
+==============+=======================================================+
| Person       | ExternalId                                            |
| Number       |                                                       |
+--------------+-------------------------------------------------------+
| Account      | Active                                                |
| Status       |                                                       |
+--------------+-------------------------------------------------------+
| Street       | addresses\[type eq \"work\"\].streetAddress           |
| Adress       |                                                       |
+--------------+-------------------------------------------------------+
| City         | addresses\[type eq \"work\"\].locality                |
+--------------+-------------------------------------------------------+
| State        | addresses\[type eq \"work\"\].region                  |
+--------------+-------------------------------------------------------+
| Postal Code  | addresses\[type eq \"work\"\].postalCode              |
+--------------+-------------------------------------------------------+
| Country      | addresses\[type eq \"work\"\].country                 |
+--------------+-------------------------------------------------------+
| Department   | urn:ietf:params:scim:schemas:                         |
| Name         |                                                       |
|              | extension:enterprise:2.0:User:department              |
+--------------+-------------------------------------------------------+
| Division     | urn:ietf:params:scim:schemas:                         |
|              |                                                       |
|              | extension:enterprise:2.0:User:division                |
+--------------+-------------------------------------------------------+
| Company      | urn:ietf:params:sc                                    |
|              | im:schemas:extension:enterprise:2.0:User:organization |
+--------------+-------------------------------------------------------+
| Username     | displayName                                           |
+--------------+-------------------------------------------------------+
| First Name   | name.givenName                                        |
+--------------+-------------------------------------------------------+
| Last Name    | name.familyName                                       |
+--------------+-------------------------------------------------------+
| Job Code     | urn:ietf:param                                        |
|              | s:scim:schemas:extension:COMPANYNAME:1.0:User:JobCode |
+--------------+-------------------------------------------------------+
| Job Name     | title                                                 |
+--------------+-------------------------------------------------------+
| Email        | emails\[type eq \"work\"\].value                      |
| Address      |                                                       |
+--------------+-------------------------------------------------------+
| Manager      | urn:ietf:params:scim:schemas:extension:               |
|              |                                                       |
|              | enterprise:2.0:User:manager                           |
+--------------+-------------------------------------------------------+
| Mobile Phone | phoneNumbers\[type eq \"mobile\"\].value              |
| Number       |                                                       |
+--------------+-------------------------------------------------------+
| Phone Number | phoneNumbers\[type eq \"work\"\].value                |
+--------------+-------------------------------------------------------+
| Work Address | addresses\[type eq \"work\"\].formatted               |
+--------------+-------------------------------------------------------+
| Hire Date    | urn:ietf:params                                       |
|              | :scim:schemas:extension:COMPANYNAME:1.0:User:HireDate |
+--------------+-------------------------------------------------------+
| Termination  | urn:ietf:param                                        |
| Date         | s:scim:schemas:extension:COMPANYAME:1.0:User:TermDate |
+--------------+-------------------------------------------------------+

## Worksheet 3: Define unique ID generation and transformation rules

There are certain attributes that require unique generation or specific
transformation rules. These are 3 commonly used attributes that have
additional rules to set their value. Reference the links to populate
these attributes properly.

  ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  Attributes                          How to set attribute value
  ----------------------------------- ------------------------------------------------------------------------------------------------------------------------------------------------------
  userPrincipalName **(mandatory      [Plan cloud HR application to Microsoft Entra user provisioning - Microsoft Entra ID \| Microsoft
  attribute)**                        Learn](https://learn.microsoft.com/en-us/entra/identity/app-provisioning/plan-cloud-hr-provision#generate-a-unique-attribute-value)

  SamAccountName (on-prem AD only)    [Plan cloud HR application to Microsoft Entra user provisioning - Microsoft Entra ID \| Microsoft
                                      Learn](https://learn.microsoft.com/en-us/entra/identity/app-provisioning/plan-cloud-hr-provision#generate-a-unique-attribute-value)

  parentDistinguishedName (on-prem AD [Plan cloud HR application to Microsoft Entra user provisioning - Microsoft Entra ID \| Microsoft
  only)                               Learn](https://learn.microsoft.com/en-us/entra/identity/app-provisioning/plan-cloud-hr-provision#configure-active-directory-ou-container-assignment)
  ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

## Worksheet 4: SCIM attributes On-premises AD attributes mapping

This table represents the set of on-prem attributes that Active
Directory supports. Map your SCIM attributes to the attributes in this
table if your provisioning target is AD.

+---------------------------------------------------+------------------+
| SCIM Attribute                                    | On-premises AD   |
|                                                   | attribute        |
+===================================================+==================+
| ExternalId                                        | employeeID       |
+---------------------------------------------------+------------------+
| Active                                            | accountDisabled  |
+---------------------------------------------------+------------------+
| addresses\[type eq \"work\"\].streetAddress       | streetAddress    |
+---------------------------------------------------+------------------+
| addresses\[type eq \"work\"\].locality            | l                |
+---------------------------------------------------+------------------+
| addresses\[type eq \"work\"\].region              | st               |
+---------------------------------------------------+------------------+
| addresses\[type eq \"work\"\].postalCode          | postalCode       |
+---------------------------------------------------+------------------+
| addresses\[type eq \"work\"\].country             | co               |
+---------------------------------------------------+------------------+
| urn:ietf:params:scim:schemas:                     | department       |
|                                                   |                  |
| extension:enterprise:2.0:User:department          |                  |
+---------------------------------------------------+------------------+
| urn:ietf:params:scim:schemas:                     | division         |
|                                                   |                  |
| extension:enterprise:2.0:User:division            |                  |
+---------------------------------------------------+------------------+
| urn:ietf:params:scim:schemas:                     | company          |
|                                                   |                  |
| extension:enterprise:2.0:User:organization        |                  |
+---------------------------------------------------+------------------+
| displayName                                       | cn               |
+---------------------------------------------------+------------------+
| name.givenName                                    | givenName        |
+---------------------------------------------------+------------------+
| name.familyName                                   | sn               |
+---------------------------------------------------+------------------+
| urn:ietf:params:sc                                | ext              |
| im:schemas:extension:COMPANYNAME:1.0:User:JobCode | ensionAttribute1 |
+---------------------------------------------------+------------------+
| title                                             | title            |
+---------------------------------------------------+------------------+
| emails\[type eq \"work\"\].value                  | \<Generated by   |
|                                                   | AD\>             |
+---------------------------------------------------+------------------+
| urn:ietf:params:s                                 | manager          |
| cim:schemas:extension:enterprise:2.0:User:manager |                  |
+---------------------------------------------------+------------------+
| phoneNumbers\[type eq \"mobile\"\].value          | mobile           |
+---------------------------------------------------+------------------+
| phoneNumbers\[type eq \"work\"\].value            | telephoneNumber  |
+---------------------------------------------------+------------------+
| addresses\[type eq \"work\"\].formatted           | physicalDe       |
|                                                   | liveryOfficeName |
+---------------------------------------------------+------------------+
| urn:ietf:params:sci                               | ext              |
| m:schemas:extension:COMPANYNAME:1.0:User:HireDate | ensionAttribute2 |
+---------------------------------------------------+------------------+
| urn:ietf:params:sc                                | ext              |
| im:schemas:extension:COMPANYAME:1.0:User:TermDate | ensionAttribute3 |
+---------------------------------------------------+------------------+

If you are defining SCIM schema extension attributes that don\'t have a
corresponding on-prem AD attribute, you can map them to
extensionAttributes 1-15 or [extend the AD
schema](https://learn.microsoft.com/en-us/windows/win32/ad/how-to-extend-the-schema)
to add a new auxiliary object class with required attributes.

## Worksheet 5: On-prem AD to Entra ID mapping

Once you have your identities synced to on-prem AD, you can send them to
Entra ID via cloud sync or Entra ID connect. Reference the linked
documentation on how to use these tools. Below is an example attribute
mapping from the AD attributes to Worksheet 4, to Entra ID attributes.

Note custom attribute "extensionAttribute1", was the workers job code.
It was mapped to AD extensionAttribute1 in the previous step, and now we
are mapping it to Entra ID extensionAttribute1 since there is no
corresponding attribute in Entra. The extensionAttribute2 and
extensionAttribute3 (hire date and termination date) are .

  -----------------------------------------------------------------------
  On-premises AD attribute         Entra ID Attribute
  -------------------------------- --------------------------------------
  employeeID                       employeeId

  accountDisabled                  accountEnabled

  streetAddress                    streetAddress

  l                                city

  st                               state

  postalCode                       postalCode

  co                               country

  department                       department

  division                         EmployeeOrgData.division

  company                          companyName

  cn                               displayName

  givenName                        givenName

  sn                               surname

  extensionAttribute1              extensionAttribute1

  title                            jobTitle

  \<Generated by AD\>              mail

  manager                          manager

  mobile                           mobile

  telephoneNumber                  telephoneNumber

  physicalDeliveryOfficeName       physicalDeliveryOfficeName

  extensionAttribute2              employeeHireDate

  extensionAttribute3              employeeLeaveDateTime
  -----------------------------------------------------------------------

## Worksheet 6: SCIM attribute to Entra ID attributes mapping

This table represents the set of attributes that Entra ID supports. Map
your SCIM attributes to the attributes in this table if your
provisioning target is Entra ID. To add custom SCIM attributes to you
gallery application, refer to this doc: [Extend API-driven provisioning
to sync custom attributes - Microsoft Entra ID \| Microsoft
Learn](https://learn.microsoft.com/en-us/entra/identity/app-provisioning/inbound-provisioning-api-custom-attributes)

+---------------------------------------------------+------------------+
| SCIM Attribute                                    | Entra ID         |
|                                                   | Attribute        |
+===================================================+==================+
| ExternalId                                        | employeeId       |
+---------------------------------------------------+------------------+
| Active                                            | accountEnabled   |
+---------------------------------------------------+------------------+
| addresses\[type eq \"work\"\].streetAddress       | streetAddress    |
+---------------------------------------------------+------------------+
| addresses\[type eq \"work\"\].locality            | city             |
+---------------------------------------------------+------------------+
| addresses\[type eq \"work\"\].region              | state            |
+---------------------------------------------------+------------------+
| addresses\[type eq \"work\"\].postalCode          | postalCode       |
+---------------------------------------------------+------------------+
| addresses\[type eq \"work\"\].country             | country          |
+---------------------------------------------------+------------------+
| urn:ietf:params:scim:schemas:                     | department       |
|                                                   |                  |
| extension:enterprise:2.0:User:department          |                  |
+---------------------------------------------------+------------------+
| urn:ietf:params:scim:schemas:                     | Employee         |
|                                                   | OrgData.division |
| extension:enterprise:2.0:User:division            |                  |
+---------------------------------------------------+------------------+
| urn:ietf:params:scim:s                            | companyName      |
| chemas:extension:enterprise:2.0:User:organization |                  |
+---------------------------------------------------+------------------+
| displayName                                       | displayName      |
+---------------------------------------------------+------------------+
| name.givenName                                    | givenName        |
+---------------------------------------------------+------------------+
| name.familyName                                   | surname          |
+---------------------------------------------------+------------------+
| urn:ietf:params:sc                                | ext              |
| im:schemas:extension:COMPANYNAME:1.0:User:JobCode | ensionAttribute1 |
+---------------------------------------------------+------------------+
| title                                             | jobTitle         |
+---------------------------------------------------+------------------+
| emails\[type eq \"work\"\].value                  | mail             |
+---------------------------------------------------+------------------+
| urn:ietf:params:scim:schemas:extension:           | manager          |
|                                                   |                  |
| enterprise:2.0:User:manager                       |                  |
+---------------------------------------------------+------------------+
| phoneNumbers\[type eq \"mobile\"\].value          | mobile           |
+---------------------------------------------------+------------------+
| phoneNumbers\[type eq \"work\"\].value            | telephoneNumber  |
+---------------------------------------------------+------------------+
| addresses\[type eq \"work\"\].formatted           | physicalDe       |
|                                                   | liveryOfficeName |
+---------------------------------------------------+------------------+
| urn:ietf:params:sci                               | employeeHireDate |
| m:schemas:extension:COMPANYNAME:1.0:User:HireDate |                  |
+---------------------------------------------------+------------------+
| urn:ietf:params:sc                                | emplo            |
| im:schemas:extension:COMPANYAME:1.0:User:TermDate | yeeLeaveDateTime |
+---------------------------------------------------+------------------+
