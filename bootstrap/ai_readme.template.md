# AI-Lore — Session Entry Point

> This file bootstraps every AI session. Read it first, follow the instructions, then proceed.

---

## Workspace

This project uses the [AI-Lore methodology](https://github.com/alberto-conan-ui/ai-sdlc).

```
.ai-lore/
+-- memory/          <- project memory (journal, knowledge tree, action tree)
+-- methodology/     <- ai-lore core + plugin process docs and stance definitions
+-- workspace.yaml   <- folder mapping and plugin declaration
```

Read `.ai-lore/workspace.yaml` to resolve `{code}`, `{memory}`, `{methodology}` path references, find which plugin this project uses, and check version information (`core_version`, `plugin_version`).

---

## Session Start Protocol

### 1. Orient

Read `{memory}/status/status.md`. It tells you: active focus, current mode, and the last journal entry. If there's an active focus, read the focus file and the relevant journal handover — orient to where work was left. If headless, read the description in status.md and wait for direction.

### 2. Load the core process

| # | File | What it covers |
|---|---|---|
| 1 | `{methodology}/roles/roles.md` | The role system — four dials, gestures, menu, plugin composition |
| 2 | `{methodology}/roles/operating-rules.md` | Universal constants — identity, tree operations, session protocols |
| 3 | `{methodology}/roles/common.md` | Shared responsibilities across all stances |
| 4 | `{methodology}/process/principles.md` | Non-negotiable operating principles |
| 5 | `{methodology}/process/workflow.md` | Focus, modes, stack, headless, checkpoints |
| 6 | `{methodology}/process/conventions.md` | Typed files, index grammar, naming, status vocabulary |

### 3. Load the plugin

Read the plugin's session configuration file — the path is declared in `workspace.yaml` under `plugin_readme`. That file contains the plugin's loading table, stance catalogue, and additional references. Each plugin file has a **Joins** declaration explaining its relationship to the core file it extends or replaces.

**If no plugin is declared, stop.** This project is either not bootstrapped or needs migrating to the current version. Tell the human:

> *"This project doesn't declare a plugin in workspace.yaml. This likely means it predates the plugin architecture. I recommend loading the Auditor stance to diagnose and migrate the project. Which plugin should this project use? (e.g., SDLC, TTRPG, spec)"*

Do not proceed without a plugin. Load the Auditor to fix the project — see [the Auditor's migration responsibilities]({methodology}/roles/auditor.md#version-migration).

### 4. Load the stance

The human will tell you which stance to operate as, or you can infer from context. Available stances are listed in the plugin's session configuration (step 3).

Load the stance's entry point file. Each stance file carries its four dial settings and lists additional files to load under "Files to Load."

### 5. Announce

State which stance you are operating as, confirm the active focus and mode (or headless), and the next step from status. Then proceed with the human's request.

---

## Quick Reference

| Resource | Location |
|---|---|
| Status (start here) | `{memory}/status/status.md` |
| Knowledge tree root | `{memory}/knowledge-tree/knowledge-tree.index.md` |
| Journal (current) | `{memory}/journal/live/` |
| Core process docs | `{methodology}/process/` |
| Role system | `{methodology}/roles/roles.md` |
| Plugin (if any) | See `workspace.yaml` -> `plugin_readme` |

---

## Core reference (load on demand)

These core files are loaded when the work requires them, not at every session start:

| File | When to load |
|---|---|
| `{methodology}/process/memory.md` | When you need to understand the memory model |
| `{methodology}/process/focus.md` | When setting or managing focuses |
| `{methodology}/process/action-tree.md` | When the focus needs tracked decomposition |
| `{methodology}/process/knowledge-tree.md` | When working with the knowledge tree |
| `{methodology}/process/journaling.md` | When writing journal entries or processing the journal |
| `{methodology}/process/plugins.md` | When you need to understand the core/plugin boundary |
