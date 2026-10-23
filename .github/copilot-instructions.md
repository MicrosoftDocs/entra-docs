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

### Entra Documentation Style Rules

#### Product and Feature Naming
- **"multitenant"** (no hyphen) in all content unless directly mirroring UI text
- **"preexisting"** (no hyphen)
- **"Azure portal"** (lowercase "portal")
- **"Microsoft Entra"** must always include "Microsoft" — never use "Entra" alone
- **"preview"** not "public preview" when describing preview features

#### Markdown Formatting
- Use regular spaces for indentation — never non-breaking spaces (U+00A0 / `\xa0`)
- Sublists under numbered steps need 4-space indentation to render correctly
- Single-step procedures should use a bullet (`-`), not a numbered list (`1.`)
- When a verb phrase is used in a filename (e.g., "set up"), hyphenate it: `how-to-set-up-*`

### Repository architecture

This is a Microsoft Learn (OPS/OpenPublishing) documentation repo for the Microsoft Entra product family. There is no application code to build — content is Markdown (`.md`) and structured YAML (`.yml`) published to <https://learn.microsoft.com/entra>.

- All published content lives under `docs/`. Top-level folders map to product areas: `identity/` (with per-feature subfolders like `authentication`, `conditional-access`, `enterprise-apps`, `saas-apps`, `users`), plus `external-id`, `fundamentals`, `global-secure-access`, `id-governance`, `id-protection`, `identity-platform`, `permissions-management`, `verified-id`, `workload-id`, `agent-id`, `architecture`, `standards`, and `security-copilot`.
- Each content folder owns a `toc.yml` (left-nav) and colocated `media/` (images) and `includes/` (reusable snippets) subfolders.
- `docs/reusable-content`, `azure-docs-pr`, `microsoft-graph`, and several sample repos are pulled in as dependent repositories (see `.openpublishing.publish.config.json`) — they aren't present locally but resolve at build time.

### Metadata is applied by folder, not per file

`docs/docfx.json` `fileMetadata` auto-assigns `author`, `ms.author`, `manager`, `ms.service`, `ms.subservice`, and `titleSuffix` based on the file's folder path. Do **not** hardcode these in front matter just to match a folder default — rely on the folder mapping and only set them in front matter to intentionally override. When you add a new folder, add its mappings to `docs/docfx.json`.

Front matter you typically author per article: `title`, `description`, `ms.topic`, `ms.date` (format `MM/DD/YYYY`, bump on substantive edits), an `ai-usage` value when AI-assisted, and a `# Customer intent:` comment. `ms.reviewer` and `ms.custom` are set per article as needed.

### Linking and includes

- Use `~/` for root-relative links into `docs/` (e.g., `~/identity/domain-services/overview.md`); use plain relative paths within the same folder. Always link to the `.md` source, not the published URL, and strip `https://learn.microsoft.com/en-us` from Learn links.
- Reuse content with `[!INCLUDE [label](~/includes/.../file.md)]`. Files under any `includes/` folder are excluded from standalone build (see `docfx.json` and `.docutune`).

### Redirects instead of broken links

When you rename, move, or delete an article, add an entry to `.openpublishing.redirection.json` (`source_path`, `redirect_url`, `redirect_document_id`) rather than leaving the old path to 404. Update every `toc.yml` and inbound link that referenced the old path.

### Validation (no local build)

There is no compile/test step. Content is validated by the OPS build plus:
- **markdownlint** (`.markdownlint.json`) — note `MD044` enforces casing of proper nouns (`.NET`, `ASP.NET`, `JavaScript`, `NuGet`, `PowerShell`, `macOS`, `C#`, `CLI`).
- **Acrolinx** (`.acrolinx-config.edn`) for editorial/terminology scoring.
- **docutune** and the What's New automation configs under `.whatsnew/`.

Branches must match `main` or `release-*` (`.docutune`). PRs target `main`.
