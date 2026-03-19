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
- Goal folders: `N.goal.kebab-case-name/` (e.g., `2.goal.v021-release/`)
- Topic folders: `N.topic.kebab-case-name/` (e.g., `1.topic.auth-redesign/`)
- Phase folders: `N.phase.kebab-case-name/` (e.g., `1.phase.baseline-tests/`)
- Step folders: `N.step.kebab-case-name/` (e.g., `1.step.interaction-modes/`)
- Task files: `N.task.kebab-case-name.md` (e.g., `3.task.update-env-docs.md`) — single file, no folder
- Journal folders: `YYYY-MM-DD_NN/` in `journal/live/` (e.g., `2026-03-19_02/`) — contains index, entries, and handover (see [journaling.md](./journaling.md#the-journal-folder))

---

## Status Vocabularies

### Action Status

- `Planning` — actively being shaped; artifacts are provisional (see [principles.md — Interaction Modes](./principles.md#interaction-modes))
- `Executing` — approved plan being implemented; artifacts are authoritative
- `Achieved` — gatekeep met, work complete
- `Paused` — work stopped temporarily, reason in journal
- `Pending` — defined but not yet started

### Phase Status

- `Complete` — done and verified
- `Implementing` — Tech Lead working on it
- `Planning` — spec being written or reviewed
- `Not planned yet` — future phase, no spec exists
- `Paused` — work stopped, reason in journal

### Task Status

- `Done` — completed
- `Pending` — not yet started

---

## Linking Rules

All links in index files follow the navigation grammar defined in [memory.md](./memory.md#the-index--navigation-primitive). These mechanical rules apply everywhere:

- All links point to `.md` files, never to folders. Use `[child/child.index.md](./child/child.index.md)`, not `[child/](./child/)`.
- **References** point up and sideways — parent index, relevant KT nodes, relevant journal entries. Each reference includes a group label explaining why it matters.
- **Siblings** list companion files in the same folder — gatekeep, context, spec. Each includes a brief role description.
- **Children** list contained nodes — child folders (via their index) and child task files. Each includes a brief description.
- Links use relative paths. When a file moves, update the references that point to it.
