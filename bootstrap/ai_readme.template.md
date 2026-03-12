# AI-SDLC — Session Entry Point

> This file bootstraps every AI session. Read it first, follow the instructions, then proceed.

---

## Workspace

This project uses the [AI-SDLC methodology](https://github.com/alberto-conan-ui/ai-sdlc).

```
.ai-sdlc/
├── memory/          ← project memory (journal, knowledge tree, action tree)
├── methodology/     ← ai-sdlc process docs and role definitions
└── workspace.yaml   ← folder mapping ({code}, {memory}, {methodology})
```

Read `.ai-sdlc/workspace.yaml` to resolve `{code}`, `{memory}`, `{methodology}` path references.

---

## Session Start Protocol

### 1. Orient

Read `{memory}/action-tree/STATUS.md`. It tells you: active stack, current phase, and next step.

### 2. Determine the role

The human will tell you which role to operate as, or you can infer from context:

| If the human says... | Load this role |
|---|---|
| "Let's design / plan / shape / architect" | `{methodology}/roles/architect.md` |
| "Write prompts / translate to prompts" | `{methodology}/roles/tech-lead.md` |
| "Execute this prompt / implement" | `{methodology}/roles/developer.md` |
| "Where are we? / Catch me up / Orient me" | `{methodology}/roles/navigator.md` |
| "Audit the knowledge tree / Review memory" | `{methodology}/roles/curator.md` |
| "Bootstrap / Set up the project" | `{methodology}/roles/bootstrapper.md` |

### 3. Load the role

Every role (except Bootstrapper and Developer) loads in this order:

1. `{methodology}/roles/operating-rules.md` — how you operate
2. `{methodology}/roles/common.md` — shared responsibilities
3. The role file itself (e.g., `{methodology}/roles/architect.md`)
4. `{memory}/action-tree/STATUS.md` — current state
5. `{memory}/knowledge-tree/index.spec.md` — project orientation
6. Role-specific files as listed in the role's "Files to Load" section

The **Developer** loads only `operating-rules.md` and the implementation prompt — nothing else.
The **Bootstrapper** loads `operating-rules.md` and its own file, plus the full `process/` folder.

### 4. Announce

State which role you are operating as and confirm the active action. Then proceed with the human's request.

---

## Quick Reference

| Resource | Location |
|---|---|
| Status (start here) | `{memory}/action-tree/STATUS.md` |
| Knowledge tree root | `{memory}/knowledge-tree/index.spec.md` |
| Journal (current week) | `{memory}/journal/` |
| Methodology docs | `{methodology}/process/` |
| Role definitions | `{methodology}/roles/` |
