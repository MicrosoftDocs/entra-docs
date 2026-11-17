---
title: Microsoft Entra External ID Custom HTML
titleSuffix: ""
description: Create branded page layouts and step-aware guidance with custom HTML and custom JavaScript around Microsoft-rendered sign-in controls.
ms.topic: concept-article
ms.date: 11/16/2026
ms.custom: msecd-doc-authoring-1026
ai-usage: ai-generated
#customer intent: As an administrator, I want to understand custom HTML capabilities and boundaries so that I can choose an appropriate branded experience for my customers.
---

# Microsoft Entra External ID custom HTML and JavaScript overview

[!INCLUDE [applies-to-external-only](includes/applies-to-external-only.md)]

Create a sign-in experience that feels like part of your application. Custom HTML in Microsoft Entra External ID gives your brand a broader canvas, with your own layout, imagery, navigation, and content around Microsoft's sign-in and sign-up controls. Put onboarding guidance where your users need it, make support easy to find, and keep your brand recognizable throughout the journey.

Bring the page to life with custom JavaScript that adapts your content to the current step. From timely verification guidance to clear progress indicators, help your users move forward with confidence.

:::image type="content" source="customers/media/modern-ux-customization/overview-custom-html.png" alt-text="Screenshot of a Contoso Journeys custom HTML page with branded navigation, contextual guidance, and a progress indicator around the sign-in box." lightbox="customers/media/modern-ux-customization/overview-custom-html.png":::

> [!IMPORTANT]
> Custom HTML and custom JavaScript are scheduled to become available in preview on December 7, 2026. This information relates to a prerelease product that may be substantially modified before it's released. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.
>
> For an overview of the customization options, see [Customize your authentication experience](customization-overview.md).

## When to choose custom HTML

Use custom HTML when you need your own page layout and content around the sign-in box.

| Customer need | How custom HTML helps |
|---|---|
| **A recognizable brand experience** | Create a richer page with your own header, footer, background, imagery, navigation, and layout around the sign-in box. |
| **Guidance when users need it** | Add instructions, disclaimers, support links, and next-step messaging that give users context around sign-in. |
| **A guided onboarding experience** | Use custom JavaScript and documented events to adapt your guidance and progress text as the sign-in view changes. |
| **A layout tailored to your audience** | Build the surrounding page to accommodate desktop and mobile screens, browser zoom, and different localized text lengths. |
| **Defined customization contracts** | Customize your page and documented content slots while Microsoft provides the sign-in controls and authentication flow. |

A custom page isn't required for supported logos, sign-in guidance, colors, or typography. Use built-in branding properties or [Basic and Advanced styling](styling.md) for those changes. You can also combine custom HTML with Advanced styling to carry your page's design into the supported authentication controls.

<a name='upload-and-verify-the-html'></a>

## Prerequisites

Before you begin, you need:

- An **external tenant** with the customization preview and [modern authentication experience (Fluent)](modern-authentication-experience.md) enabled.
- A **custom domain** configured for your application's authentication experience.
- If you use **custom JavaScript**, an organization-controlled public HTTPS location to host the scripts. Reference them from the HTML and ensure the page's security policy allows them; don't weaken the policy to load blocked resources.

You're responsible for ensuring your custom HTML and JavaScript changes keep the page keyboard-accessible, readable, and usable across screen sizes, without obscuring the sign-in box.

## What you control and what Microsoft controls

You own the surrounding page shell: header, footer, navigation, background, support content, compliance messaging, and other customer-owned content around the sign-in box. Microsoft provides the sign-in controls and authentication flow, including credential fields, challenge controls, and submit actions. Inside the sign-in box, customize only through the documented content slots and event contracts described in this article.

> [!IMPORTANT]
> You're responsible for securing your custom domain and all HTML, scripts, and external resources loaded into your page.

| You can | You must not |
|---|---|
| **Design the surrounding page** with branding, navigation, campaign, compliance, help, privacy, and contextual content. | Recreate, replace, cover, obscure, or intercept authentication controls. |
| **Leave `<div id="sisuBox"></div>` empty** so Microsoft can render authentication there. | Place your own fields, buttons, or fallback content inside it. |
| **Use supported static HTML and CSS** for the surrounding page. | Inspect, copy, alter, click, relabel, disable, restyle, or attach handlers to Microsoft-owned inputs, buttons, or challenge controls. |
| **Use documented content areas and UI events** to update your content. | Depend on undocumented DOM structure, internal or generated Fluent/Fabric classes, current element locations, event ordering, or returned element IDs remaining stable across views. |
| **Use approved externally hosted resources that fail gracefully.** | Make sign-in depend on a script, resource, or event being available. |
| **Use the application's authentication response for the result.** | Read or collect credentials, verification codes, secrets, tokens, protocol data, or entered values; automate controls; or skip authentication steps. |

:::image type="content" source="customers/media/modern-ux-customization/custom-html-ownership-unified.png" alt-text="Diagram of one page shell showing customer-owned header, footer, background, layout, and content around Microsoft-owned sign-in controls rendered at the required sisuBox mount point." lightbox="customers/media/modern-ux-customization/custom-html-ownership-unified.png":::

<a name='use-supported-events-and-content-areas'></a>

<a name='supported-content-areas-inside-the-sign-in-box'></a>

## Content areas and Microsoft-owned controls

The sign-in box includes areas for your content and authentication controls that remain Microsoft-owned. Event metadata can identify both; an element's ID doesn't grant permission to customize it.

### Content areas and placement metadata

Supported content slots let you add guidance without changing Microsoft's controls. The bottom area provides placement metadata rather than a general-purpose injection slot.

| Area | Purpose and boundary |
|---|---|
| **Subheading area** (`subHeadingSection`) | Content you provide between the Microsoft-rendered title and description. |
| **Form area** (`formSection`) | Content you provide after Microsoft fields and before submit actions. |
| **Bottom area** (`bottomSection`) | Identifies the area after the actions, including display message box text. Doesn't allow arbitrary script injection. |

:::image type="content" source="customers/media/modern-ux-customization/custom-html-content-areas.png" alt-text="Screenshot of annotated sign-in content areas showing the subheading and form slots above the actions and the bottom area after them." lightbox="customers/media/modern-ux-customization/custom-html-content-areas.png":::

### Microsoft-owned controls

| Control | Ownership and restrictions |
|---|---|
| **Authentication controls** | Inputs, buttons, and challenge UI remain Microsoft-controlled, even when their IDs appear in metadata. |
| **Action buttons** (`primaryButton`, `secondaryButton`) | Microsoft-owned controls. Don't click, relabel, disable, replace, style, or attach handlers through the returned IDs. |

<a name='contextual-guidance-and-progress-indicators'></a>

## Respond to supported sign-in UI events

Supported sign-in UI events let your custom JavaScript react to the current sign-in view without taking over authentication. An event is a read-only notification from the Microsoft-rendered sign-in box. Your page can use its information to keep customer-owned guidance, progress text, accessibility hints, or busy indicators in sync with what the user sees.

For example, use an event to show guidance for a verification step or explain why profile information is needed. The event tells your page which view is displayed, not whether the user completed that step or signed in successfully.

| Event | What it tells your page | How you can use it |
|---|---|---|
| **`sisuBox:scenariochange`** | The active sign-in scenario or its metadata changed. Its `detail` object includes `schemaVersion`, `activeAction`, and optional `elements` metadata. | Update customer-owned explanations, progress text, or accessibility context for the current view. |
| **`sisuBox:actionprocessing`** | An authentication action started or stopped processing. Its `detail` object includes `schemaVersion` and the Boolean `actionProcessing`. | Show coarse busy feedback or pause duplicate actions in your own content. A value of `false` doesn't mean authentication succeeded or failed. |

Register listeners on `#sisuBox`, preferably before it initializes. The events bubble, so a listener on `window` can also receive them. For scripts that load later, the container exposes the latest event details through current-state properties. See [Event names and readable information](#event-names-and-readable-information) for the reference and [the JavaScript sample](#sample-javascript) for listener setup.

> [!IMPORTANT]
> Ensure your event handlers and added content don't compromise page security or authentication data. Validate and sanitize any HTML inserted into supported content slots.

### Event do's and don'ts

| Do | Don't |
|---|---|
| Use events to update customer-owned explanatory, progress, or accessibility content. | Use events to determine whether authentication succeeded or failed. |
| Validate `schemaVersion === 1` and ignore versions or fields your code doesn't understand. | Assume event order, timing, or repetition will always be the same. |
| Use only documented content slots and elements returned by the event. | Use undocumented DOM structure, internal CSS classes, or arbitrary element IDs as customization contracts. |
| Re-resolve exposed element IDs whenever scenario metadata changes. | Retain returned IDs or slot elements across views, or assume their locations remain stable. |
| Keep the static shell useful when events are unavailable. | Allow event handlers, scripts, or external resources to block sign-in. |
| Register listeners before initialization. If your script loads late, register listeners before reading the current-state properties. | Rely on a late-loading script receiving events that already occurred. |
| Allow only supported `activeAction` values and ignore unknown actions. | Treat unknown actions or payload fields as supported behavior. |
| Use `sisuBox:scenariochange` only for customer-owned content or accessibility context. | Use scenario changes to perform, skip, or bypass authentication steps. |
| Use `sisuBox:actionprocessing` only as a coarse busy signal. | Treat `actionProcessing=false` as success or failure. |
| Make handlers safe to run repeatedly, without duplicating content or actions. | Assume an event fires only once. |
| Inject customer-owned content only into `subHeadingSection` or `formSection`. | Inject content into arbitrary sign-in-box locations or treat `bottomSection` as an injection slot. |
| Use the application callback or protocol response for the final authentication outcome. | Modify `event.detail`, log user-entered values, collect data from Microsoft controls, or cancel or modify authentication. |

## Understand scenario actions

The `activeAction` value in `sisuBox:scenariochange` describes the kind of step currently displayed. Use it to choose relevant guidance, not to direct the authentication flow. For example, `verify` can prompt a reminder about verification codes, while `collectAttributes` can explain why profile information is needed.

Allow only the supported values below. Ignore unknown values and leave the page usable when an event isn't available.

| Value | Meaning |
|---|---|
| **`discover`** | Enter an identifier and begin account or tenant discovery. |
| **`select`** | Choose an available account, tenant, credential, or other option. |
| **`challenge`** | Choose an authentication method or challenge. |
| **`verify`** | Enter and submit proof, such as a password or one-time code. |
| **`disambiguate`** | Choose among matching accounts or tenants after ambiguous discovery. |
| **`collectAttributes`** | Provide required registration or profile attributes. |
| **`enroll`** | Choose and begin setting up a new authentication method. |
| **`activate`** | Complete activation of a newly enrolled authentication method. |
| **`consent`** | Review and respond to a consent or confirmation experience. |
| **`prompt`** | Respond to a standalone prompt or decision. |
| **`update`** | Update an existing credential, such as setting a new password. |

For field definitions and implementation notes, see [Appendix: Custom HTML and event-listener reference](#appendix-custom-html-and-event-listener-reference).

<a name='set-up-a-custom-page'></a>

## Configure custom HTML in the admin center

1. Open your branding theme's **Custom HTML** settings.

   :::image type="content" source="customers/media/modern-ux-customization/custom-html-upload-pane.png" alt-text="Screenshot of Edit Custom HTML with template download links, the custom-domain requirement, and the HTML file upload area." lightbox="customers/media/modern-ux-customization/custom-html-upload-pane.png":::

1. Select **Download the HTML template** to get started, or adapt the [sample HTML](#sample-html) below. Replace the organization text, links, and layout.
1. Define exactly one empty `<div id="sisuBox"></div>` in the document's body, after the closing `</head>` tag. Microsoft renders the sign-in experience in this container. Don't put your own content inside it or use `sisuBox` as another element's ID.
1. Under **Upload file**, drag and drop your HTML file or select the upload area to browse for it.

   :::image type="content" source="customers/media/modern-ux-customization/custom-html-editor-pane.png" alt-text="Screenshot of an uploaded custom HTML template in the editor with Save, Remove, Upload, and Download controls." lightbox="customers/media/modern-ux-customization/custom-html-editor-pane.png":::

1. Select **Apply** to apply the custom HTML to the theme.
1. Preview and test the authentication experience through your application's configured custom domain. Start without JavaScript and check that users can complete sign-in, including with a keyboard and on mobile screens.

To add dynamic guidance, download the **JavaScript event-listener template** or adapt the [sample JavaScript](#sample-javascript). Host the script at an organization-controlled public HTTPS URL, reference it from your HTML, and upload the updated HTML. Confirm the page's security policy allows the script and that sign-in still works if it fails to load.

## Sample HTML

This starter creates a responsive page shell with organization text, a support link, customer-owned guidance, and the required empty sign-in container. Replace the example content and URLs. Remove the external script reference for your initial static-page validation, then add it after hosting [the JavaScript sample](#sample-javascript).

The examples illustrate the documented contracts, not a complete production design. Adapt and validate their content, localization, accessibility, and layout for your application. See [How the samples work](#how-the-samples-work) for an annotated walkthrough.

> [!IMPORTANT]
> Review the template, external resources, and script dependencies before use. Load only approved HTTPS resources, and don't weaken the page's security policy.

<br>

<details>
<summary><strong>Expand the custom HTML sample</strong></summary>

```html
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Organization account access</title>
  <style>
    body {
      margin: 0;
      color: #242424;
      background: #f5f5f5;
      font: 1rem/1.5 "Segoe UI", system-ui, sans-serif;
    }

    .site-header,
    .site-footer {
      padding: 1.25rem;
      background: #ffffff;
    }

    .page {
      display: grid;
      grid-template-columns: minmax(0, 1fr) minmax(0, 1fr);
      align-items: start;
      gap: 2rem;
      max-width: 70rem;
      margin: auto;
      padding: 2rem 1.25rem;
    }

    .introduction,
    .account-region {
      min-width: 0;
      overflow-wrap: anywhere;
    }

    .site-header a,
    .site-footer a {
      color: #0f6cbd;
    }

    .site-header a:focus-visible,
    .site-footer a:focus-visible {
      outline: 3px solid #0f6cbd;
      outline-offset: 3px;
    }

    @media (max-width: 48rem) {
      .page {
        grid-template-columns: minmax(0, 1fr);
      }
    }
  </style>
</head>
<body>
  <header class="site-header">Organization name</header>
  <main class="page">
    <section class="introduction" aria-labelledby="page-heading">
      <h1 id="page-heading">Welcome to your account</h1>
      <p>Sign in to continue to the requested service.</p>
      <p id="customer-guidance" role="status">
        Follow the instructions in the sign-in box.
      </p>
      <p id="customer-processing" role="status"></p>
    </section>
    <section class="account-region" aria-label="Account access">
      <!-- Microsoft renders authentication here. Keep this container empty. -->
      <div id="sisuBox"></div>
    </section>
  </main>
  <footer class="site-footer">
    <a href="https://www.example.com/support">Get help</a>
  </footer>
  <script
    defer
    src="https://static.example.com/custom-html-events.v1.js"
  ></script>
</body>
</html>
```

</details>

## Sample JavaScript

Host this script at your own public HTTPS URL and update the HTML reference. It listens for both events, validates schema and action values, and updates only the two customer-owned paragraphs outside the sign-in box. It also reads the current state when loaded after an event.

<br>

<details>
<summary><strong>Expand the custom JavaScript sample</strong></summary>

```javascript
(function () {
  "use strict";

  const box = document.getElementById("sisuBox");
  const guidance = document.getElementById("customer-guidance");
  const processing = document.getElementById("customer-processing");

  if (!box || !guidance || !processing) {
    console.warn("Custom page guidance is unavailable: required elements are missing.");
    return;
  }

  const defaultGuidance = guidance.textContent;
  const messages = new Map([
    ["discover", "Enter the account information requested in the sign-in box."],
    ["select", "Review the available options before continuing."],
    ["challenge", "Choose from the available authentication methods."],
    ["verify", "Complete the requested security check. Never share a verification code."],
    ["disambiguate", "Choose the account you intended to use."],
    ["collectAttributes", "Provide the required profile information to continue."],
    ["enroll", "Set up the requested sign-in method."],
    ["activate", "Follow the instructions to finish activation."],
    ["consent", "Review the request before making your selection."],
    ["prompt", "Respond to the request in the sign-in box."],
    ["update", "Update the requested credential in the sign-in box."]
  ]);

  function applyScenario(detail) {
    if (detail?.schemaVersion !== 1 || !messages.has(detail.activeAction)) {
      if (guidance.textContent !== defaultGuidance) {
        guidance.textContent = defaultGuidance;
      }
      return;
    }

    const message = messages.get(detail.activeAction);
    if (guidance.textContent !== message) {
      guidance.textContent = message;
    }
  }

  function applyProcessing(detail) {
    if (detail?.schemaVersion !== 1 ||
        typeof detail.actionProcessing !== "boolean") {
      if (processing.textContent !== "") {
        processing.textContent = "";
      }
      return;
    }

    const message = detail.actionProcessing ? "Working on your request..." : "";
    if (processing.textContent !== message) {
      processing.textContent = message;
    }
  }

  function onScenarioChange(event) {
    applyScenario(event.detail);
  }

  function onActionProcessing(event) {
    applyProcessing(event.detail);
  }

  // Subscribe before reading current state so an intervening event isn't missed.
  box.addEventListener("sisuBox:scenariochange", onScenarioChange);
  box.addEventListener("sisuBox:actionprocessing", onActionProcessing);

  if (box.sisuBoxScenarioChange) {
    applyScenario(box.sisuBoxScenarioChange);
  }
  if (box.sisuBoxActionProcessing) {
    applyProcessing(box.sisuBoxActionProcessing);
  }
})();
```

</details>

## Appendix: Custom HTML and event-listener reference

Use this reference with the [HTML](#sample-html) and [JavaScript](#sample-javascript) samples. It describes the supported event surface, current-view metadata, and ways to customize your content around Microsoft's authentication UI.

> [!IMPORTANT]
> You're responsible for securing your custom domain and all HTML, scripts, and external resources loaded into your page.

### Event names and readable information

Event payload fields are available on `event.detail`. Treat them as versioned, read-only presentation context.

| Name or property | What it is | Usage |
|---|---|---|
| **`sisuBox` / `#sisuBox`** | Required mount point. | Microsoft renders authentication here. Recommended listener target for supported events. |
| **`sisuBox:scenariochange`** | Scenario-change event. | The active scenario or its metadata changed. Read `schemaVersion`, `activeAction`, and optional `elements`. |
| **`sisuBox:actionprocessing`** | Processing-state event. | An authentication action started or stopped processing. Read `schemaVersion` and `actionProcessing`. |
| **`schemaVersion`** | Schema version in both events. | Process only `1`; ignore unknown versions. |
| **`activeAction`** | Current scenario action. | Match only the [supported action values](#understand-scenario-actions). It isn't a result or a guaranteed sequence position. |
| **`elements`** | Optional purpose-to-element-ID metadata for the current scenario. | Resolve only documented content areas using their current IDs. IDs and elements can change between views. |
| **`actionProcessing`** | Boolean processing state. | Use for coarse customer-owned busy feedback. `false` doesn't establish success or failure. |
| **`sisuBoxScenarioChange`** | Latest scenario details on the `#sisuBox` element, when available. | After registering listeners, read this property to initialize a late-loading script. Apply the same schema and action checks as for event details. |
| **`sisuBoxActionProcessing`** | Latest processing details on the `#sisuBox` element, when available. | After registering listeners, read this property to initialize busy feedback. Validate the schema and Boolean value. |

<a name='event-properties'></a>

### Working with current-view element metadata

For `subHeadingSection` or `formSection`, resolve the returned ID again after every scenario change. If the ID or element is absent, leave your surrounding page usable. Follow the [content-area boundaries](#supported-content-areas-inside-the-sign-in-box) and [event do's and don'ts](#event-dos-and-donts).

### How the samples work

Expand these notes alongside the samples when adapting them. The samples update surrounding content; using a supported inner content slot isn't required.

<br>

<details>
<summary><strong>HTML walkthrough: page shell and sign-in container</strong></summary>

The header, introduction, guidance paragraphs, and support link belong to your page. The responsive grid changes to a single column on narrower screens. Its CSS targets the page shell, not Microsoft-owned fields or buttons.

The unique, empty `sisuBox` element is the Microsoft mount point. Don't add customer-created username, password, one-time-code, passkey, or submit controls, or reproduce Microsoft's authentication UI elsewhere.

The two `role="status"` paragraphs provide customer-owned announcements without moving keyboard focus. Review the wording and announcement frequency with assistive technology. Static guidance remains visible without JavaScript.

The external script reference is a placeholder for your approved HTTPS asset host. The sign-in experience must remain usable when that resource fails or is blocked.

</details>

<br>

<details>
<summary><strong>JavaScript walkthrough: notifications, validation, and late loading</strong></summary>

The script finds the required container and the two customer-owned paragraphs. Its action-to-message map is an allowlist for schema version `1`. Unsupported versions or actions leave generic guidance instead of guessing at authentication state.

Each listener reads `event.detail` without changing it. The scenario listener updates guidance; the processing listener accepts only a Boolean and clears busy text when processing stops. Neither listener reads Microsoft-owned controls or treats a notification as a result.

The listeners are registered before the script reads `sisuBoxScenarioChange` and `sisuBoxActionProcessing`. This handles late loading without relying on another event arriving. Repeated notifications don't append duplicate content or repeat unchanged status text.

The script doesn't use `elements` because it updates only surrounding content. If you adapt it to insert guidance into a supported content slot, resolve that slot from the current event metadata each time, as described in [Working with current-view element metadata](#working-with-current-view-element-metadata).

</details>

## Related content

- [Authentication customization overview](customization-overview.md).
- [Modern authentication experience](modern-authentication-experience.md).
- [Basic and Advanced styling](styling.md).
