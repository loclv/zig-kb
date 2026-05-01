---
name: zig-kb-metadata-format
description: Defines the required YAML frontmatter format for all markdown files in the zig-kb repository. Must use when creating or editing any .md file in this project.
---

# Metadata Format Rule

Every `.md` file in this repository must begin with the following YAML frontmatter block:

```yaml
---
name: <kebab-case-identifier>
description: <One or two sentences describing the file's purpose and when to use it.>
---
```

## Requirements

- Location: Must be the very first lines of the file, before any Markdown content.
- Delimiter: Wrapped in triple dashes `---`.
- Fields:
  - `name`: A short, unique, kebab-case identifier. Prefix with `zig-` for topic files.
  - `description`: A concise summary of what the file covers, ending with a usage cue like "Must use when...".

## Example

```yaml
---
name: zig-error-handling
description: Zig error handling with explicit error sets, error union types (!), try/catch/if err patterns, and best practices for error propagation. Must use when reading or writing Zig files.
---
```
