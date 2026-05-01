---
name: sync-map-json-skill
description: Updates ./map.json to reflect changes in the knowledge base file tree. Run this whenever creating, deleting, or moving content files or directories.
---

# Synchronize map.json

Ensure `./map.json` remains the canonical index of the knowledge base.

## When to run

- After creating any `.md` file or directory under `basics/`, `memory/`, `errors/`, `comptime/`, `stdlib/`, `build/`, `tools/`, or `migrations/`.
- After deleting or renaming any of those files or directories.

## Steps

1. Read `./map.json`.
2. Identify whether the change affects a root entry or a nested `children` entry.
3. Edit `./map.json` to:
   - Add a new object with `title`, `path`, and optionally `description` or `children`.
   - Remove the object whose `path` matches the deleted file or directory.
   - Update the `path` field if a file or directory was renamed or moved.
4. Ensure the JSON structure remains valid and the `title` fields are human-readable.
