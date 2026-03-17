# Copilot Instructions for Microsoft Learn

These instructions define a unified style and process standard for authoring and maintaining learn.microsoft.com documentation with GitHub Copilot or other AI assistance.

## Learn-wide Instructions

Below are instructions that apply to all Microsoft Learn documentation authored with AI assistance. Learn product team will update this periodically as needed. Each repository SHOULD NOT update this to avoid being overwritten, but update the repository-specific instructions below as needed.

### AI Usage & Disclosure
All Markdown content created or substantially modified with AI assistance must include an `ai-usage` front matter entry:
- `ai-usage: ai-generated` – AI produced the initial draft with minimal human authorship
- `ai-usage: ai-assisted` – Human-directed, reviewed, and edited with AI support
- Omit only for purely human-authored legacy content

If missing, **add it**. However, do not add or update the ai-usage tag if the changes proposed are confined solely to:
- Links (link text and/or URLs)
- Single words or short phrases, such as entries in table cells
- Less than 5% of the article's word count

### Writing Style

Follow [Microsoft Writing Style Guide](https://learn.microsoft.com/style-guide/welcome/) with these specifics:

#### Voice and Tone

- Active voice, second person addressing reader directly
- Conversational tone with contractions
- Present tense for instructions/descriptions
- Imperative mood for instructions ("Call the method" not "You should call the method")
- Use "might" instead of "may" for possibility
- Avoid "we"/"our" referring to documentation authors

#### Structure and Format

- Sentence case headings (no gerunds in titles)
- Be concise, break up long sentences
- Oxford comma in lists
- Number all ordered list items as "1." (not sequential numbering like "1.", "2.", "3.", etc.)
- Complete sentences with proper punctuation in all list items
- Avoid "etc." or "and so on" - provide complete lists or use "for example"
- No consecutive headings without content between them

#### Formatting Conventions

- **Bold** for UI elements
- `Code style` for file names, folders, custom types, non-localizable text
- Raw URLs in angle brackets
- Use relative links for files in this repo
- Remove `https://learn.microsoft.com/en-us` from learn.microsoft.com links

## Repository-Specific Instructions

Below are instructions specific to this repository. These may be updated by repository maintainers as needed.

<!--- Add additional repository level instructions below. Do NOT update this line or above. --->

### Product Terminology

- Always use **Microsoft Entra ID** — never "Azure AD," "Azure Active Directory," or "AAD."
- Use the full product name on first reference in an article, then "Entra ID" is acceptable in subsequent references within the same article.
- Related product names follow the same pattern: **Microsoft Entra External ID**, **Microsoft Entra ID Governance**, **Microsoft Entra ID Protection**, **Microsoft Entra Workload ID**, **Microsoft Entra Verified ID**.
- For the admin portal, use **Microsoft Entra admin center** (not "Azure portal" unless the action genuinely requires the Azure portal).

### Required Front Matter

Every Markdown article must include these YAML front matter fields:

```yaml
---
title: Sentence-case title — Microsoft Entra ID
description: A concise one-to-two sentence summary of the article.
ms.topic: overview | concept | how-to | tutorial | reference
ms.date: MM/DD/YYYY
author: GitHub-username
ms.author: Microsoft-alias
ms.reviewer: GitHub-username-or-alias
---
```

**Field guidance:**

- **title** — Sentence case. Include the product name or let the `titleSuffix` from `docfx.json` append it. Don't duplicate the suffix.
- **ms.topic** — Choose the value that best describes the article's purpose:
  - `overview` — High-level introduction to a feature or service.
  - `concept` — Explains how something works without step-by-step instructions.
  - `how-to` — Procedural steps to accomplish a task.
  - `tutorial` — End-to-end guided learning experience.
  - `reference` — API, cmdlet, or configuration reference.
- **ms.date** — Set to the current date in `MM/DD/YYYY` format when creating or substantially updating an article.
- **ms.custom** — Optional. Use for tracking tags (for example, `it-pro`, `has-azure-ad-ps-ref`). Don't invent new tags without checking existing conventions.

### Content Types and ms.topic Values

| ms.topic value | Use when | Typical H2 headings |
|---|---|---|
| `overview` | Introducing a feature area | Prerequisites, Key concepts, How it works, Next steps |
| `concept` | Explaining architecture or design | How it works, Key components, Considerations |
| `how-to` | Step-by-step task | Prerequisites, Steps (numbered), Verify, Next steps |
| `tutorial` | Guided learning scenario | Prerequisites, Step 1…N, Clean up resources, Next steps |
| `reference` | API or config reference | Syntax, Parameters, Examples, Related content |

### File Naming and Path Conventions

- Place new articles under the appropriate feature area: `docs/identity/{feature-area}/`.
- Use lowercase kebab-case for file names.
- Prefix file names with the content type when it aids discoverability: `overview-`, `howto-`, `concept-`, `tutorial-`.
- Example: `docs/identity/monitoring-health/howto-configure-diagnostic-settings.md`
- Author and manager assignments are controlled per path in `docfx.json` — check the file metadata section before adding new articles to confirm the correct defaults.

### Article Structure

- Every article starts with an introductory paragraph immediately after the H1 heading (no heading-only openings).
- End procedural articles with a **Next steps** H2 linking to logical follow-up content.
- Use [!INCLUDE] references from the `includes/` folder for reusable boilerplate (for example, portal navigation steps). Don't duplicate shared content inline.
- Reference images from `media/{article-name}/` using relative paths.

### Portal Navigation Steps

When documenting steps in the Microsoft Entra admin center:

1. Start with: "Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [*required role*](/entra/identity/role-based-access-control/permissions-reference#role-name)."
1. Use **bold** for every UI element the reader must interact with (menu items, buttons, blades).
1. Provide the full navigation path: **Identity** > **Feature area** > **Specific page**.
