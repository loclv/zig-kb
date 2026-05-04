# Tasks

## Completed

- [x] Scaffold KB structure with `docs/` categories and `map.json`
- [x] Create `meta.md` with required YAML frontmatter rules
- [x] Create `README.md` with regenerate instructions and prompt templates
- [x] Write topic docs: basics (syntax, control flow, types), build system, comptime, ecosystem, errors, memory, stdlib, migrations (0.15, 0.16), tools (zls, zigdoc, ziglint, zlint, sig)
- [x] Add code samples in `docs/samples/`
- [x] Create `update_map.zig` to regenerate `map.json`
- [x] Index project with codedb

## TODO

- [ ] Fix `map.json` `description` for `tools/zlint.md` (currently shows `">"` instead of full multi-line text)
- [ ] Improve generic sample descriptions in `map.json` (e.g., ziggzagg, hello-world, generic-type)
- [ ] Expand `docs/libraries/libxev.md` with code examples and Agent Tips
- [ ] Add missing topic docs: concurrency/threads, C interop, testing patterns, `build.zig.zon` dependencies
- [ ] Run `agent-md` formatter on all `.md` files
- [ ] Review and clean up test log files (`test_*.zig.log`)
- [ ] Add missing frontmatter to `docs/samples/samples.md` and any other `.md` files missing it
