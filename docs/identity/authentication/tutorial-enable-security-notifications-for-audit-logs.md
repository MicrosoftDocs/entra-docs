---
title: Enable security notifications for audit log events
description: Create an Azure Logic App that monitors Microsoft Entra audit logs and sends a security email notification to users based on different audit log events.

ms.service: entra-id
ms.subservice: authentication
ms.topic: tutorial
ms.date: 12/06/2023

author: camilasinelli
ms.author: justinha
manager: amycolannino
ms.reviewer: jupetter
---
# Tutorial: Enable security notifications for audit log events

In this tutorial, you learn how to create an [Azure Logic App](/azure/logic-apps/logic-apps-overview) that monitors Microsoft Entra audit logs. A logic app can send a security email notification to users based on different audit log events.   

This tutorial focuses on security notifications that get emailed when there's a change to a user's authentication methods. You can also use logic apps to create workflows that send security notifications for other audit log events. These security notifications help update users and notify them of any risky activity. Users can quickly take the correct steps to report it. 

:::image type="content" border="true" source="./media/tutorial-enable-security-notifications-for-audit-logs/notification-example.png" alt-text="Screenshot of a security notification.":::

## Prerequisites
To use this feature, you need:

- An Azure subscription. If you don't have an Azure subscription, you can [sign up for a free trial](https://azure.microsoft.com/free/).
- A Microsoft Entra tenant.
- A user who's at least a [Security Administrator](../role-based-access-control/permissions-reference.md#security-administrator) for the Microsoft Entra tenant.
- An Event Hubs namespace and an event hub in your Azure subscription. Learn how to [create an event hub](/azure/event-hubs/event-hubs-create).
- Enable logs to be streamed to the event hub. Learn how to [stream logs to an event hub](/azure/azure-monitor/essentials/stream-monitoring-data-event-hubs). Only select the logs that you want the security notification to be sent for. For this tutorial, we'll stream Audit Logs.
- An email account from a service that works with Azure Logic Apps, such as Office 365 Outlook or Outlook.com. For other supported email providers, review [Connectors for Azure Logic Apps](/connectors/connector-reference/connector-reference-logicapps-connectors).

## Create a logic app

1. Sign in to the Microsoft Entra admin center.
1. In the home page, under **Azure services**, select **Logic Apps**. 
1. Select **Add**.
1. In **Create Logic App**, configure your logic app: 
   1. Select the **Subscription** in which you want to create the logic app.
   1. Select the **Resource Group** you created for the event hub.
   1. Enter the **Logic App name**, and the system immediately checks to see if the name is available. 
   1. Select a **Region** for the logic app.
   1. For **Plan type**, select the **Consumption** tier. Choose a region and plan type that aligns with your organization's size and needs. To learn about differences between tiers, see the [Standard and Consumption logic app workflow](/azure/logic-apps/logic-apps-overview#create-and-deploy-to-different-environments). 
   1. Don't change any other settings. 

      >[!NOTE]
      >Only some regions support Zone redundancy. Depending on your location, your Zone redundancy section might be automatically enabled or disabled. For more information, see [Protect logic apps from region failures with zone redundancy and availability zones](/azure/logic-apps/set-up-zone-redundancy-availability-zones).

      :::image type="content" border="true" source="./media/tutorial-enable-security-notifications-for-audit-logs/app-name.png" alt-text="Screenshot of application name.":::

    1. Select **Review + create**. Then, review your logic app settings and select **Create**.
    1. Wait for the deployment to be complete.

## Select the blank template

1. After Azure successfully deploys your logic app resource, select **Go to resource** or find and select your logic app resource by typing the name in the Azure search box.

   :::image type="content" border="true" source="./media/tutorial-enable-security-notifications-for-audit-logs/go-to-resource.png" alt-text="Screenshot of Go to resource.":::

1. Scroll down past the video under **Templates**, select **Blank Logic App**. After you select the template, the designer shows an empty workflow.

   :::image type="content" border="true" source="./media/tutorial-enable-security-notifications-for-audit-logs/blank-logic-app.png" alt-text="Screenshot of blank logic app.":::

## Logic Apps Designer   

1. In the connectors and triggers section, select **Event Hubs** or search for it in the search bar.
    
   :::image type="content" border="true" source="./media/tutorial-enable-security-notifications-for-audit-logs/event-hubs.png" alt-text="Screenshot of Events Hubs.":::

1. Select **When events are available in Event Hubs trigger**. If you're using the Event Hubs trigger for the first time, you'll be prompted to create a connection to your event hub. For more information and steps, see [Create an event hub connection](/azure/connectors/connectors-create-api-azure-event-hubs#create-an-event-hub-connection).
1. In **Event Hub name**, select the event hub you created in [Prerequisites](#prerequisites). Select the event hub where you want your logic app to send security notifications.
1. Under **How often do you want to check for items?**, select how often you want the event hub to be checked. In this tutorial, we check for events every one (1) minute. 

   :::image type="content" border="true" source="./media/tutorial-enable-security-notifications-for-audit-logs/frequency.png" alt-text="Screenshot of how often to check for events.":::

## Initialize Variables

Here, we'll initialize three variables. One is the content of the event that was triggered and streamed to the event hub. The two others are empty variables for our email body, and the date and time of the activity, which we'll later fill with information from the event.

1. On the designer, under **When events are available in Event Hubs trigger**, select **New step**.
1. Under **Choose an operation**, select **Built-in**. In the search box, enter *variables*, and select **Initialize variable**.

   :::image type="content" border="true" source="./media/tutorial-enable-security-notifications-for-audit-logs/initialize-variable.png" alt-text="Screenshot of Initialize variable.":::

1. For **Name**, type *content*.
1. For **Type**, select **String**.
1. Place the cursor in the **Value** property, and **Dynamic Content** appears.
1. In **Dynamic Content**, search for and select **Content**.

   :::image type="content" border="true" source="./media/tutorial-enable-security-notifications-for-audit-logs/dynamic-content.png" alt-text="Screenshot of Dynamic Content.":::

1. Select **New step**.
1. Under **Choose an operation**, select **Built-in**. In the search box, enter *variables*, and select **Initialize variable**.
1. Give the variable a name, such as *emailBody*.
1. For **Type**, select **String**, and leave **Value** blank.

   :::image type="content" border="true" source="./media/tutorial-enable-security-notifications-for-audit-logs/email-body.png" alt-text="Screenshot of email body variable.":::
   
1. Select **New step**.
1. Under **Choose an operation**, select **Built-in**. In the search box, enter *variables*, and select **Initialize variable**.
1. Give the variable a name, such as *dateTime*.
1. For **Type**, select **String**, and leave **Value** blank.

   :::image type="content" border="true" source="./media/tutorial-enable-security-notifications-for-audit-logs/date-time.png" alt-text="Screenshot of date-timeInitialize variable.":::
   
## Parse JSON

Now we'll format the raw JSON that we received from the events that were streamed to the event hub by parsing the JSON so we can access specific data within that content.

1. Under **Initialize variable 3**, select **New step**.
1. In the Search connectors and actions search bar, type *Parse JSON*.
1. Switch to the **Actions** tab and select **Parse JSON**.

   :::image type="content" border="true" source="./media/tutorial-enable-security-notifications-for-audit-logs/initialize-variable.png" alt-text="Screenshot of Initialize variable.":::
   
1. In **Content**, select **Add dynamic content**.
1. In **Dynamic Content**, select **content** under Variables.
1. In the Schema section, copy and paste the following JSON template:
   
   ```json
   {
    "type": "object",
    "properties": {
        "records": {
            "type": "array",
            "items": {
                "type": "object",
                "properties": {
                    "time": {
                        "type": "string"
                    },
                    "resourceId": {
                        "type": "string"
                    },
                    "operationName": {
                        "type": "string"
                    },
                    "operationVersion": {
                        "type": "string"
                    },
                    "category": {
                        "type": "string"
                    },
                    "tenantId": {
                        "type": "string"
                    },
                    "resultSignature": {
                        "type": "string"
                    },
                    "durationMs": {
                        "type": "integer"
                    },
                    "correlationId": {
                        "type": "string"
                    },
                    "Level": {
                        "type": "integer"
                    },
                    "properties": {
                        "type": "object",
                        "properties": {
                            "id": {
                                "type": "string"
                            },
                            "category": {
                                "type": "string"
                            },
                            "correlationId": {
                                "type": "string"
                            },
                            "result": {
                                "type": "string"
                            },
                            "resultReason": {
                                "type": "string"
                            },
                            "activityDisplayName": {
                                "type": "string"
                            },
                            "activityDateTime": {
                                "type": "string"
                            },
                            "loggedByService": {
                                "type": "string"
                            },
                            "operationType": {
                                "type": "string"
                            },
                            "userAgent": {},
                            "initiatedBy": {
                                "type": "object",
                                "properties": {
                                    "user": {
                                        "type": "object",
                                        "properties": {
                                            "id": {
                                                "type": "string"
                                            },
                                            "displayName": {},
                                            "userPrincipalName": {
                                                "type": "string"
                                            },
                                            "ipAddress": {
                                                "type": "string"
                                            },
                                            "roles": {
                                                "type": "array"
                                            }
                                        }
                                    }
                                }
                            },
                            "targetResources": {
                                "type": "array",
                                "items": {
                                    "type": "object",
                                    "properties": {
                                        "id": {
                                            "type": "string"
                                        },
                                        "displayName": {},
                                        "type": {
                                            "type": "string"
                                        },
                                        "userPrincipalName": {
                                            "type": "string"
                                        },
                                        "modifiedProperties": {
                                            "type": "array"
                                        },
                                        "administrativeUnits": {
                                            "type": "array"
                                        }
                                    },
                                    "required": [
                                        "id",
                                        "displayName",
                                        "type",
                                        "userPrincipalName",
                                        "modifiedProperties",
                                        "administrativeUnits"
                                    ]
                                }
                            },
                            "additionalDetails": {
                                "type": "array"
                            }
                        }
                    }
                },
                "required": [
                    "time",
                    "resourceId",
                    "operationName",
                    "operationVersion",
                    "category",
                    "tenantId",
                    "resultSignature",
                    "durationMs",
                    "correlationId",
                    "Level",
                    "properties"
                ]
            }
        }
    }
   }

   ```

1. The **Parse JSON** action should now look like this screenshot:

   :::image type="content" border="true" source="./media/tutorial-enable-security-notifications-for-audit-logs/parse-json.png" alt-text="Screenshot of Parse JSON.":::
   
## Security notification email body

Next, we'll compose and style the security email that alerts users about the actions taken on their account. Here, we want to inform users of the activity that took place, and prompt them to report it if it wasn't their action.

1. Under **Parse JSON**, select **New step**.
1. Under **Choose an operation**, select **Built-in**. In the search box, enter *for each*, and from the list of **Actions**, select **For each**.

   :::image type="content" border="true" source="./media/tutorial-enable-security-notifications-for-audit-logs/for-each.png" alt-text="Screenshot of for each step.":::
   
1. Under **Select an output from previous steps**, select **Add dynamic content**. 
1. In **Dynamic content**, select **records**.

   :::image type="content" border="true" source="./media/tutorial-enable-security-notifications-for-audit-logs/records.png" alt-text="Screenshot of Records.":::
   
1. Inside the **For each** action, select **Add an action**.

   :::image type="content" border="true" source="./media/tutorial-enable-security-notifications-for-audit-logs/add-an-action-records.png" alt-text="Screenshot of how to add an action for Records.":::
   
1. Under **Choose an operation**, select **Built-in**. In the search box, enter **variables**, and select **Set variable**.
1. Under **Name**, select the *dateTime* variable you created.
1. Inside **Value**, select **Add dynamic content**.
1. In **Dynamic content**, search for and select **time** under Parse JSON.

   :::image type="content" border="true" source="./media/tutorial-enable-security-notifications-for-audit-logs/time.png" alt-text="Screenshot of how to select Time.":::
   
1. Under **Set variable**, select **Built-in**. In the search box, enter **variables**, and select **Set variable**.
1. Under **Name**, select the *emailBody* variable you created.
1. Under **Value**, input the text you want to display in the body of the security notification email. The body can be formatted with html. You can start with this template and customize it. For example, replace the href placeholders with links that are relevant to your organization.

   ```html
   <div>
    <h2>
        You recently changed your authentication methods
    </h2>
    <p>
        We have been notified of the following action: (operation) on (date & time). <br><br>
        If you initiated this, no action is required. <br><br>
        If you haven't, please report it now. <br><br>
        <b>Instructions</b>
        <ol>
            <li>Review your account activity in <a href="https://mysignins.microsoft.com/security-info" class="link">Microsoft Security Info</a>.</li>
            <li>If you do not recognize this action, report it immediately:</li>
            <ul>
                <li>Go to <a href="#" class="link">ReportItNow</a> and select your security event.</li>
                <li>Provide any additional information in the form and submit.</li>
            </ul>
        </ol>
        <b>Information and Support</b>
        <ul>
            <li>Technical Assistance - Contact <a href="#" class="link">Helpdesk</a> support services</li>
        </ul>
        <b>Do NOT reply to this email. This is an unmonitored mailbox.</b><br>
        For more information, contact the <a href="#" class="link">Security Department</a>
        <br><br>
        <a href="#"><button type="button">Report device</button></a><br><br>
        <div class="footer">
            Contoso, Ltd., 4567 Main St Buffalo, NY 98052<br>
            <br>Facilitated by <br>
            <img src="#" alt="Company Logo" style="height:70px;">
        </div>
        <style>
            .link {
                text-decoration:none;
                color: #0078D4
            }
            button {
                background-color: #0078D4;
                color: white;
                padding: 10px;
                border-radius: 5px;
                text-decoration: none;

            }
            button:hover {
                cursor: pointer;
            }
            .footer {
                width: 100%;
                height: 10%;
                padding-top: 10px;
                padding-left: 10px;
                padding-right: 10px;
                background-color: rgb(237, 237, 237);
            }
        </style>
    </p>
   </div>

   ```

## Adding dynamic content to the email body

1. If you're using the above template, copy and paste it into the Value field of the Set Variable action.
1. Inside the value field where you pasted the template, go back to the first few lines of text and highlight "(content)". See the image below.
1. Once that text has been highlighted, you'll see **Dynamic content** pop up on the right of the action box. In the search bar of Dynamic content, search and select operationName. 

   :::image type="content" border="true" source="./media/tutorial-enable-security-notifications-for-audit-logs/select-operation-name.png" alt-text="Screenshot of how to select operationName.":::
 
1. Again, inside the value field where you pasted the template, go back to the first few lines of text and highlight "(date & time)". See the image below.
1. Once that text has been highlighted, you should see the Dynamic content section pop up on the right of the action box. Go to the Expression tab and input the following code in the input box:

   ```code
   formatDateTime(variables('dateTime'),'yyyy-MM-dd tH:mm:ss')
   ```

1. After pasting the preceding code in the input box, select **OK**.

   :::image type="content" border="true" source="./media/tutorial-enable-security-notifications-for-audit-logs/set-variable.png" alt-text="Screenshot of how to set a variable.":::
 
For more information about using dynamic content to customize the email further, see [Workflow dynamic content](/purview/how-to-use-workflow-dynamic-content).

## Sending the security email

1. Below the **Set variable** action, select **Add an action**.
1. Under **Choose an operation**, select **Built-in**. In the search box, enter **for each** and from the actions list, select the action named **For each**.

   :::image type="content" border="true" source="./media/tutorial-enable-security-notifications-for-audit-logs/for-each-action.png" alt-text="Screenshot of how to select For each action.":::
   
1. Inside **Select an output from previous steps**, select **targetResources** from the **Dynamic content**.

   :::image type="content" border="true" source="./media/tutorial-enable-security-notifications-for-audit-logs/target-resources.png" alt-text="Screenshot of how to select target resources.":::
   
1. Inside the **For each 2** action block and under **targetResources**, select **Add an action**.
1. Under **Choose an operation**, select **Built-in**. In the search box, enter *condition* and from the actions list, select the action named **Condition**.

   :::image type="content" border="true" source="./media/tutorial-enable-security-notifications-for-audit-logs/condition.png" alt-text="Screenshot of how to select a condition.":::
   
1. Inside **Choose a value**, search for and select **operationName**.

   :::image type="content" border="true" source="./media/tutorial-enable-security-notifications-for-audit-logs/operation-name.png" alt-text="Screenshot of how to select an operation name.":::
   
1.  In **Choose a value**, type the exact name of the activity you want to send the security notification emails. For the full list of activities you can filter through and send notifications for, see [Audit Log Activities](/purview/audit-log-activities). 
1. For this tutorial, we'll send email for the **Reset user password** activity.

   :::image type="content" border="true" source="./media/tutorial-enable-security-notifications-for-audit-logs/operation-name.png" alt-text="Screenshot of how to select reset user password.":::
   
1. If you want to send security emails for multiple activities, select **Add** inside the **Condition** action block, then select **Add row**, and repeat those steps for different activity names in **Choose a value**.

## Email notification setup

1. Under **Condition**, there are actions for **True** and **False**. Select **Add an action** inside the **True** action box.

   :::image type="content" border="true" source="./media/tutorial-enable-security-notifications-for-audit-logs/add-true-action.png" alt-text="Screenshot of how to add a True action.":::

1. Under **Choose an operation**, select **Built-in**. In the search box, enter **email**, and select **Office 365 Outlook**. Instead of Outlook emails, you can send notifications with different services. To find different services, go to the search bar in **Choose an operation** and search for the service you prefer.

   :::image type="content" border="true" source="./media/tutorial-enable-security-notifications-for-audit-logs/outlook.png" alt-text="Screenshot of how to select Outlook.":::

1. Under **Actions**, scroll down and select **Send an email (V2)**.

   :::image type="content" border="true" source="./media/tutorial-enable-security-notifications-for-audit-logs/send-email.png" alt-text="Screenshot of how to select Send an email.":::

1. Inside the **To** field, search in **Dynamic content** for **userPrincipalName** and select the second option.

   :::image type="content" border="true" source="./media/tutorial-enable-security-notifications-for-audit-logs/user-principal-name.png" alt-text="Screenshot of how to select userPrincipalName.":::

1. In the **Subject** field, search in **Dynamic content** for **operationName** and select it. 

   :::image type="content" border="true" source="./media/tutorial-enable-security-notifications-for-audit-logs/operation-name-dynamic.png" alt-text="Screenshot of how to select operation name in Dynamic content.":::

1. In the Body field, search in **Dynamic content** for **emailBody** and select it.

   :::image type="content" border="true" source="./media/tutorial-enable-security-notifications-for-audit-logs/email-body-dynamic.png" alt-text="Screenshot of how to select the email body in the Dynamic content.":::

7. You can select **Importance** to change the importance of the email.

## Run your workflow

To manually start your workflow, on the Designer toolbar, select **Run Trigger** > **Run**. When the audit logs stream to the event hub, they trigger the logic app to send the security notification.

This workflow can be customized to filter other logs and activities, or send notifications through different services such as Teams, to create the best experience to make your users aware of suspicious activities.


## Next steps

- [How Entra ID multifactor authentication works](concept-mfa-howitworks.md)
