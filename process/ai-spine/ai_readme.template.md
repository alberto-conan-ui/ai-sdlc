# {project_name} — Session Entry Point

The entry point every AI session loads first. Directs the session through the universal load and into a stance.

---

## Before you start

Read `{lore_dir}/workspace.yaml`. It declares `project_name`, `core_version`, and the chosen `plugin`. Every path below is fixed under `{lore_dir}/`; the manifest exists so sessions can confirm the methodology version they are reading against.

The composed Process is plugin-blind: the session loads from plugin-agnostic paths under `{lore_dir}/process/`. Plugins are a build-time concept and do not appear in the runtime load.

---

## 1. Load the pillars

Load the six universal pillars in order. Each pillar specifies behaviour; loading them makes the session AI-Lore-shaped for the rest of its lifetime. When a pillar declares its own "load with me" contract, follow those declarations — the pillar is the authoritative source for what must be in context when it is loaded.

1. [`{lore_dir}/process/project-structure.md`]({lore_dir}/process/project-structure.md) — vocabulary (Project, Payload, Lore, Memory, Upstream, Process), disk layout, `workspace.yaml` as manifest
2. [`{lore_dir}/process/stances.md`]({lore_dir}/process/stances.md) — the stance concept, the four dials (Voice, Precision, Pushback, Ownership) across two domains (Chat, Work), and the menu of protected and example profiles
3. [`{lore_dir}/process/modes.md`]({lore_dir}/process/modes.md) — the four modes (Reflecting, Planning, Executing, Salvaging) and their transitions
4. [`{lore_dir}/process/operating-rules.md`]({lore_dir}/process/operating-rules.md) — runtime rules, the six verbs (Reshape, Rewrite, Digest, Split, Redial, Dictation), and session close
5. [`{lore_dir}/process/tracker/tracker.index.md`]({lore_dir}/process/tracker/tracker.index.md) — the tracker primitive, with `status.md` and `focus.md` as children
6. [`{lore_dir}/process/memory/memory.index.md`]({lore_dir}/process/memory/memory.index.md) — the memory model; this pillar declares a mandatory spine of sub-pillars (`journal.md`, `tree-discipline.md`, `blueprint.md`) that must be loaded with it

---

## 2. Orient

Walk the tracker chain from `{lore_dir}/memory/status/status.index.md` into the active focus. If the project is headless, status says so and the session waits for direction.

---

## 3. Read standing project state

- [`{lore_dir}/memory/blueprint/blueprint.index.md`]({lore_dir}/memory/blueprint/blueprint.index.md) — production rules and standing contracts.

---

## 4. Stance selection

Read the `{lore_dir}/process/stances/` folder. Each file there is a stance: the file name (without `.md`) is the identifier, the H1 inside is the display name, and the `## Purpose` section tells you what the stance does. If the Human Lead has already named a stance, load its file directly. Otherwise list the available stances to the Human Lead and wait for a choice.

Once a stance is chosen, load its file and apply any `## Load increment` it declares on top of the universal load.

---

## 5. Announce

State which stance is active. Confirm the active focus and mode (or headless) and the next step from status. Then proceed.

---

## Quick reference

| Resource          | Location                                        |
|-------------------|-------------------------------------------------|
| Status            | `{lore_dir}/memory/status/status.index.md`      |
| Focus files       | `{lore_dir}/memory/status/focus/`               |
| Journal (current) | `{lore_dir}/memory/journal/live/`               |
| Knowledge tree    | `{lore_dir}/memory/knowledge-tree/`             |
| Blueprint         | `{lore_dir}/memory/blueprint/`                  |
| Pillars           | `{lore_dir}/process/`                           |
| Stances           | `{lore_dir}/process/stances/`                   |
