---
name: zig-kb-metadata-rule
description: Mandatory rule for all markdown files in zig-kb. Enforces that every ".md" file must have YAML frontmatter with "name" and "description" fields. Must use when creating or editing any markdown file in this repository.
---

# Metadata Frontmatter Rule

All markdown files in this repository must start with a YAML frontmatter block containing "name" and "description" fields.

## Format

```yaml
---
name: <kebab-case-identifier>
description: <One or two sentences describing the file's purpose and when to use it.>
---
```

## Rules

- The frontmatter block must be the first content in the file.
- "name" must be a short, unique, kebab-case identifier.
- "description" must summarize the file's purpose and include a usage cue.
- Do not create or edit any ".md" file without adding or preserving this frontmatter.
