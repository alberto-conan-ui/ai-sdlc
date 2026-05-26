# Project structure

The foundation layer: the vocabulary every other document uses, the disk layout those documents assume, and the manifest that ties a Project to a version of the methodology.

## The five terms

| Term | Definition |
|---|---|
| **Project** | The root directory where work happens. Has a name (`project_name`). Contains a Payload and a Lore. |
| **Payload** | What the Project produces. The Project root minus the Lore folder and the root `ai_readme.md` entry point. |
| **Lore** | The support system. Lives at `<project>/.ai-lore-<project_name>/`. |
| **Memory** | The Project's record of its own thinking — status, focus, journal, blueprint, trees, save-points. Lives at `<lore>/memory/`. |
| **References** | Pointers to other AI-Lore projects on disk this project consults for context. Read-only by contract. Live at `<lore>/references/`. Optional. |

The Payload is the point. The Lore exists to serve it; Memory is the part of the Lore the session reads and writes as work proceeds; References, when present, point outward at other projects this one looks at.

## Disk layout

```
my-project/                          ← Project
├── ai_readme.md                     entry point — any AI: "read ai_readme.md"
├── [Payload files]                  ← Payload
│
└── .ai-lore-my-project/             ← Lore  (folder name = .ai-lore-${project_name})
    ├── workspace.yaml                manifest
    │
    ├── process/                     methodology — plain text, pinned by core_version
    │   ├── ai_readme.md
    │   ├── project-structure.md
    │   ├── memory.md
    │   ├── status.md
    │   ├── bindings.md
    │   └── verbs/...
    │
    ├── memory/                      ← Memory
    │   ├── status/                    status.index.md + focus/
    │   ├── journal/                   live/ and archive/
    │   ├── blueprint/                 standing commitments
    │   │   ├── contracts/               evergreen rules the Payload must honour
    │   │   ├── processes/               repeated procedures the project performs
    │   │   └── mirror/                  description of the Payload's shape
    │   ├── save-points/               append-only milestone ledger
    │   ├── action-tree/               decomposition, optional
    │   └── knowledge-tree/            reconciled / working / notepad, optional
    │
    └── references/                  ← References (optional)
        ├── references.index.md        registry
        └── <name>.md                  one file per referenced project
```

The methodology is placed into the project at [`init`](./verbs/init.md) time, version-pinned by `core_version`. Two pieces:

- **A two-line shim at `ai_readme.md` (project root)** — the AI-agnostic entry point. Says *"This project uses AI-Lore. Read `.ai-lore-<project_name>/process/ai_readme.md` and follow its instructions."* Any AI can be pointed at it.
- **The full methodology under `.ai-lore-<project>/process/`** — pillars and verbs, copied verbatim. The real entry point lives here as `process/ai_readme.md`; the root shim is just the path-less handshake the Human Lead types.

[`upgrade`](./verbs/upgrade.md) re-copies the methodology when the project moves to a new `core_version`. Engine bindings (see [`bindings.md`](./bindings.md)) layer engine-native delivery on top — they never replace this AI-agnostic baseline.

## Two repositories

Memory and Payload are each their own git repository. The lore repo lives at `.ai-lore-<project>/memory/`; the Payload repo lives at the Project root. They commit independently but acknowledge together — the `ack` and `save-point` verbs commit both as a single unit (see [`memory.md`](./memory.md#drift-signal) and [`verbs/ack.md`](./verbs/ack.md)).

Three details a session reading or writing these repos has to know:

- **The Payload's `.gitignore` excludes `.ai-lore-<project>/`.** The Lore folder, the methodology, the vendored `process/`, and Memory all sit outside Payload tracking. `init` writes this entry on project creation.
- **The lore repo's `.git/` lives at `<lore>/memory/.git/`, not at `<lore>/.git/`.** `cd <lore>` does not put a session inside the lore repo — git walks up and finds the Payload's `.git/` instead. To address the lore repo explicitly, use `git -C <lore>/memory ...`. The `orient` bookend's drift check relies on this.
- **The vendored `<lore>/process/` is tracked by neither repo.** The Payload's `.gitignore` excludes the whole Lore folder; the lore repo only covers `memory/`. The vendored methodology is an on-disk mirror of the canonical source, placed by `init` and re-placed by `upgrade`. In self-hosting projects — where the canonical methodology *is* the Payload, as in `ai-sdlc` itself — edits to the methodology must be applied to both `/process/` (canonical, Payload-tracked) and `<lore>/process/` (vendored, untracked) to stay in sync.

## The Lore folder is uniquely named per project

The Lore folder is `.ai-lore-<project_name>/`, where `<project_name>` is the identifier from `workspace.yaml`. Every project has a different Lore folder name. AI sessions resolve paths by walking ancestors — two projects sharing a `.ai-lore/` name in the same ancestor chain would give ambiguous resolution. Unique names remove the ambiguity.

Project names must be filesystem-safe directory segments: `^[a-zA-Z0-9_][a-zA-Z0-9_-]*$`.

## workspace.yaml

Lives at `<lore>/workspace.yaml`. A manifest, not a configuration file — behaviour is determined by Memory and the methodology, not by switches here.

```yaml
project_name: my-project       # the Project's name; also the Lore folder suffix
core_version: "0.5"            # pinned AI-Lore version
```

Both fields are required. `project_name` names the Project and is the last segment of the Lore folder name. `core_version` records which version of AI-Lore the project runs against.

## References

A project may consult other AI-Lore projects for context — a sibling project doing similar work, a parent project, a reference implementation. References make this explicit: the project declares which other projects it looks at and why.

References live at `<lore>/references/` — sibling to `memory/`, not inside it. Memory is the project's own thinking; references are pointers outward. The folder is **optional** — a project with no references simply has no `references/` folder.

Each reference is one file, `references/<name>.md`, with frontmatter and a body:

| Field | Value |
|---|---|
| `type` | `reference` |
| `target_path` | the on-disk path to the referenced project's root (relative or absolute) |
| `purpose` | one line — why this project is referenced |
| `scope` | what part of the referenced project matters (all, a blueprint area, a KT branch, a Payload module) |

The body explains how to consult the reference — what to look at, when to look at it, any caveats. `references/references.index.md` lists what is registered.

References are **read-only by contract.** A session never writes through a reference into another project's Memory or Payload. Cross-project edits happen the other way around: open the other project explicitly and work there.

References are **link metadata only.** Insights this project draws from reading a referenced project belong in this project's knowledge tree, with `source` pointing back at the reference name. The reference file describes the link, not the project's interactions with it — otherwise it turns into a competing journal.

References are **not auto-loaded.** The session knows the folder exists from this document; it consults a reference when the work calls for cross-project context, not at every session open.
