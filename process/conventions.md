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
- Every folder: `[folder-name].index.md` — mandatory authority file
- Topic folders: `N.topic.kebab-case-name/` (e.g., `1.topic.auth-redesign/`)
- Phase folders: `N.phase.kebab-case-name/` (e.g., `1.phase.baseline-tests/`)
- Task files: `N.task.kebab-case-name.md` (e.g., `3.task.update-env-docs.md`) — single file, no folder
- Journal files: `YYYY-MM-DD_NN.md` in `journal/live/` (e.g., `2026-03-17_01.md`)

---

## Status Vocabularies

### Action Status

- `Active` — currently being worked on (on the active stack)
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
