# Conventions

> **References**
>
> | Group | File |
> |---|---|
> | File types | [file-types/](./file-types/) |
> | Memory model | [memory.md](./memory.md) |
> | Setup guide | [bootstrap/README.md](../bootstrap/README.md) |

Naming conventions, status indicators, and structural rules. For file type definitions, see the [File Type Catalogue](./file-types/). For the typed file system and hierarchy rules, see [memory.md](./memory.md). For project setup, see [bootstrap/README.md](../bootstrap/README.md).

---

## Naming Conventions

- Project memory folder: `.ai-sdlc/memory/` (nested inside the code repo, gitignored)
- File naming: `[name].[type].md` — every file declares its type in the name (see [memory.md](./memory.md) for the type catalogue)
- Every folder: `[folder-name].index.md` — navigation entry point (see [memory.md — The Index](./memory.md#the-index--navigation-primitive))
- Node numbering: two-digit IDs starting at `05`, incrementing by `5` — see [action-tree.md — Numbering Convention](./action-tree.md#numbering-convention) for the full scheme (insertion gaps, parking-lot, hierarchical addressing)
- Goal folders: `NN.goal.kebab-case-name/` (e.g., `10.goal.v021-release/`)
- Topic folders: `NN.topic.kebab-case-name/` (e.g., `05.topic.auth-redesign/`)
- Phase folders: `NN.phase.kebab-case-name/` (e.g., `05.phase.baseline-tests/`)
- Step folders: `NN.step.kebab-case-name/` (e.g., `05.step.interaction-modes/`)
- Task files: `NN.task.kebab-case-name.md` (e.g., `15.task.update-env-docs.md`) — single file, no folder
- Journal folders: `YYYY-MM-DD_NN/` in `journal/live/` (e.g., `2026-03-19_02/`) — contains index, entries, and handover (see [journaling.md](./journaling.md#the-journal-folder))

---

## Status Vocabulary

One vocabulary for all node types. The interaction mode (Planning, Executing, or Reflecting — see [principles.md — Interaction Modes](./principles.md#interaction-modes)) tells you how to interpret artifacts; the status tells you where the work stands.

- `Pending` — defined, not started
- `Active` — work in progress. The interaction mode says whether the work is being shaped (Planning) or executed (Executing). In Reflecting mode, the action stays Active but the session has stepped outside the tree — see [principles.md — Interaction Modes](./principles.md#interaction-modes).
- `Paused` — stopped temporarily, reason in journal
- `Review` — work complete, awaiting Human Lead assessment
- `Done` — Human Lead confirmed (ungatkept nodes: steps, tasks)
- `Achieved` — Human Lead confirmed, gatekeep passed (gatekept nodes: goals, topics, phases)

**The rule:** no node transitions to Done or Achieved without an explicit Human Lead decision. The AI can move things to Review. Only the Human Lead moves things past Review. This enforces Human Accountability at the status vocabulary level.

---

## Linking Rules

All links in index files follow the navigation grammar defined in [memory.md](./memory.md#the-index--navigation-primitive). These mechanical rules apply everywhere:

- All links point to `.md` files, never to folders. Use `[child/child.index.md](./child/child.index.md)`, not `[child/](./child/)`.
- **References** point up and sideways — parent index, relevant KT nodes, relevant journal entries. Each reference includes a group label explaining why it matters.
- **Siblings** list companion files in the same folder — gatekeep, context, spec. Each includes a brief role description.
- **Children** list contained nodes — child folders (via their index) and child task files. Each includes a brief description.
- Links use relative paths. When a file moves, update the references that point to it.
