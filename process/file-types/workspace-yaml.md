# workspace.yaml

**Type name:** workspace-yaml
**File:** `workspace.yaml`
**Location:** `.ai-sdlc/workspace.yaml` (inside the `.ai-sdlc/` folder at the code repo root)
**Required:** Yes — one per workspace
**Created by:** Bootstrapper
**Maintained by:** Human Lead (rarely changes)

---

## Purpose

Maps the physical folder names in the workspace so that all documents and prompts can use shorthand references (`{code}`, `{memory}`, `{methodology}`) instead of brittle relative paths.

The AI resolves these references at session start by reading `workspace.yaml`. The Navigator's handoff prompts use the same shorthand.

---

## Format

```yaml
# workspace.yaml — single source of truth for folder names
code: ../
memory: memory
methodology: methodology
```

The paths are relative to the `.ai-sdlc/` folder: `code` points up to the repo root (`../`), while `memory` and `methodology` are siblings inside `.ai-sdlc/`.

---

## Notes

- If `workspace.yaml` isn't present, use relative paths from the code repo root as a fallback: `./` for code, `.ai-sdlc/memory/` for memory, `.ai-sdlc/methodology/` for methodology.
- The file rarely changes — only when the workspace is restructured.
- See [bootstrap/README.md](../../bootstrap/README.md) for the full bootstrap flow that creates this file.
