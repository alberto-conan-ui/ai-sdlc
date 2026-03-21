# AI-SDLC — Session Entry Point

> This file bootstraps every AI session. Read it first, follow the instructions, then proceed.

---

## Workspace

This project uses the [AI-SDLC methodology](https://github.com/alberto-conan-ui/ai-sdlc).

```
.ai-sdlc/
├── memory/          ← project memory (journal, knowledge tree, action tree)
├── methodology/     ← ai-sdlc process docs and stance definitions
└── workspace.yaml   ← folder mapping ({code}, {memory}, {methodology})
```

Read `.ai-sdlc/workspace.yaml` to resolve `{code}`, `{memory}`, `{methodology}` path references.

---

## Session Start Protocol

### 1. Orient

Read `{memory}/action-tree/status.md`. It tells you: current mode (Planning, Executing, or Reflecting), active stack, relevant journal sessions, and what to do next. Then read the handover(s) linked from the Relevant Journal field — the handover tells you where work was left and how to interpret artifacts.

### 2. Determine the stance

The human will tell you which stance to operate as, or you can infer from context:

| If the human says... | Load this stance |
|---|---|
| "Let's design / plan / shape / architect" | `{methodology}/roles/architect.md` |
| "Implement / build / execute phase" | `{methodology}/roles/tech-lead.md` |
| "Audit the process / Review methodology" | `{methodology}/roles/auditor.md` |
| "Where are we? / Catch me up" | Any stance — orientation is a shared responsibility |

### 3. Load the stance

Every stance loads in this order:

1. `{methodology}/roles/operating-rules.md` — how you operate
2. `{methodology}/roles/common.md` — shared responsibilities
3. The stance file itself (e.g., `{methodology}/roles/architect.md`)
4. `{memory}/action-tree/status.md` — current state, active stack
5. `{memory}/action-tree/action-tree.index.md` — tree structure
6. `{memory}/knowledge-tree/knowledge-tree.index.md` — project orientation
7. Stance-specific files as listed in the stance's "Files to Load" section

### 4. Announce

State which stance you are operating as, confirm the active mode (Planning, Executing, or Reflecting), the active action, and the next step from `status.md`. Then proceed with the human's request.

---

## Quick Reference

| Resource | Location |
|---|---|
| Status (start here) | `{memory}/action-tree/status.md` |
| AT root index | `{memory}/action-tree/action-tree.index.md` |
| Knowledge tree root | `{memory}/knowledge-tree/knowledge-tree.index.md` |
| Journal (current) | `{memory}/journal/live/` |
| Methodology docs | `{methodology}/process/` |
| Stance definitions | `{methodology}/roles/` |
