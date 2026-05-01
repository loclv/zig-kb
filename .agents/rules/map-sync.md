---
name: map-json-sync-rule
description: Mandatory rule for the zig-kb knowledge base. Ensures that ./map.json stays synchronized with the actual file tree. Must use when creating or deleting any content file or directory.
---

# map.json Synchronization Rule

The file `./map.json` is the canonical navigation index for this knowledge base. It must remain synchronized with the actual file tree at all times.

## Rules

- When creating a new `.md` file or directory, update `./map.json` to include it.
- When deleting a `.md` file or directory, remove its entry from `./map.json`.
- When renaming or moving a `.md` file or directory, update the corresponding `path` field in `./map.json`.
- Do not create, delete, or move any content file without updating `./map.json` in the same operation.
