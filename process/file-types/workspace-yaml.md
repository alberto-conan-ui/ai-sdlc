# workspace.yaml

**Type name:** workspace-yaml
**File:** `workspace.yaml`
**Location:** Workspace root (sibling of code, memory, and methodology folders)
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
code: <code-repo-folder-name>
memory: <memory-repo-folder-name>
methodology: ai-sdlc
```

---

## Notes

- If `workspace.yaml` isn't present, use relative paths from the workspace root as a fallback.
- The file rarely changes — only when folders are renamed or the workspace is restructured.
- See [bootstrap/README.md](../../bootstrap/README.md) for the full bootstrap flow that creates this file.
