---
name: zig-kb-overview
description: Master index for the Zig Knowledge Base. Lists all topics including philosophy, syntax, memory, errors, comptime, build system, stdlib patterns, and migration guides.
---

# Zig Knowledge Base (zig-kb)

A structured, AI-optimized knowledge base for the Zig programming language. Designed to help AI agents understand Zig's unique features, idioms, and best practices.

## Table of Contents
Human and AI agents can use "./map.json" to navigate the knowledge base.

## How to use this KB
All documents is store at "<root>/docs/" folder.

Each document follows a consistent structure:
1. Concept: High-level explanation.
2. Syntax: Formal representation.
3. Examples: Clear, idiomatic code snippets.
4. Agent Tips: Specific advice for LLMs writing Zig code.

## Write the best prompt that save most token

### For Windsurf / Cursor / Claude Code / other AI coding assistants, fetch, rtk, codedb mcp...
Base on logs. instead of "<link> read and write".

Copy-paste template:

```text
Fetch <url>. Read meta.md and map.json. Write <path> with YAML frontmatter (name: kebab-case, description: 1-2 sentences with "Must use when..."). Update map.json title/path/description. No intro, no summary, execute only.
```

Example:

```
Fetch <https://raw.githubusercontent.com/zigcc/awesome-zig/refs/heads/main/README.md>. Read meta.md and map.json. Write <path> with YAML frontmatter (name: kebab-case, description: 1-2 sentences with "Must use when..."). Update map.json title/path/description. No intro, no summary, execute only.
```

Even shorter variant:

```
Fetch <url>. Read meta.md + map.json. Write <path> with required frontmatter. Patch map.json. No chatter.
```

Why this saves tokens:
- Eliminates "read and write", "please", "can you", explanatory fluff.
- `meta.md + map.json` replaces "read the metadata format rule and the map file".
- `required frontmatter` relies on the file itself (already in context) instead of restating constraints.
- `No chatter` suppresses the AI's habit of writing progress summaries.

## Formatter
Use <https://github.com/loclv/agent-md> to format markdown files.
After install, run `agent-md <file>` to format a file.

Use with VSCode, Cursor, Windsurf..., press `Cmd+Shift+P` and search for "Preferences: Open Settings (JSON)" and add:

```json
{
  "[markdown]": {
    "editor.formatOnSave": true,
    "editor.defaultFormatter": "loclv.agent-md-formatter"
  }
}
```
