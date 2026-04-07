# SDLC Plugin — Conventions

> **Joins:** [conventions.md](../../conventions.md) — Addendum: load core conventions first (typed files, index grammar, reference headers, status vocabulary, hierarchy discipline), then layer this file for SDLC-specific node naming, phase spec format, and recording guidance.
>
> **References**
>
> | Group | File |
> |---|---|
> | Core conventions | [conventions.md](../../conventions.md) |
> | SDLC action tree | [action-tree.md](./action-tree.md) |
> | SDLC stances | [roles.md](./roles.md) |

Core conventions define the typed file system, index grammar, reference headers, linking rules, status vocabulary, and hierarchy discipline. This adds SDLC-specific naming, file types, and recording guidance. Core defines the typed file system, index grammar, reference headers, linking rules, status vocabulary, and hierarchy discipline. This doc covers what's specific to software development projects.

---

## Node Type Naming

SDLC projects use five node types in the action tree (defined fully in [action-tree.md](./action-tree.md)):

| Type | Folder/file pattern |
|---|---|
| Goal | `NN.goal.kebab-case-name/` |
| Topic | `NN.topic.kebab-case-name/` |
| Phase | `NN.phase.kebab-case-name/` |
| Step | `NN.step.kebab-case-name/` |
| Task | `NN.task.kebab-case-name.md` |

These are SDLC-specific instantiations of core's container/leaf primitives. Other plugins define their own node types.

---

## Phase Spec Format

The phase spec is written in the phase folder's index file (`[name].index.md`). It is self-contained — a new reader should understand it without loading other files.

A spec includes:

- **Goal** — what this phase achieves
- **Steps** — numbered, concrete: file paths, code references, specific changes
- **Test cases** — specific inputs and expected outputs
- **Done criteria** — how to verify the phase is complete

Specs must reference specific file paths, show code snippets of current behaviour, and include test case tables. Vague plans produce vague code.

---

## SDLC Node Files

Beyond core's typed file system, SDLC projects use these file types within action tree nodes:

| File type | Used in | Purpose |
|---|---|---|
| `[name].index.md` | All containers | Navigation entry point. For phases, doubles as the spec. |
| `[name].gatekeep.md` | Goals, topics | Completion criteria — what "done" means. |
| `[name].context.md` | Goals, topics | Links to relevant KT nodes. Bridge between intention (AT) and knowledge (KT). |
| `[name].spec.md` | Goals, topics, steps | Design specification when the index overview isn't enough. |

See [action-tree.md — Node Files](./action-tree.md#node-files) for full details.

---

## Recording by Stance

Each stance records different things in the journal:

| Stance | Journal focus | KT contributions |
|---|---|---|
| Architect | Design decisions, trade-off rationale, scope changes, phase roadmaps | Codebase patterns, architectural insights, cross-action patterns |
| Tech Lead | Implementation progress, test results, issues encountered, phase completion | API quirks, tooling constraints, code patterns discovered during implementation |
| Auditor | Process observations, methodology friction, migration decisions | Process evolution insights, what worked and what didn't |
