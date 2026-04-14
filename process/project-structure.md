# Project structure

Project structure is the foundation layer of the process. It defines the vocabulary every other document uses, the disk layout those documents assume, and the manifest that ties a Project to a specific version of the methodology.

## Disk layout

```
my-project/                            ← Project ("my-project" = project_name)
├── ai_readme.md                       session entry point (installed at Part 2)
├── [Payload files]                    ← Payload
│
└── .ai-lore-my-project/               ← Lore (folder name = .ai-lore-${project_name})
    ├── workspace.yaml                 manifest (project_name, core_version, plugin)
    │
    ├── memory/                        ← Memory
    │   ├── status/                      status.index.md + focus/
    │   ├── journal/                     live/ and archive/
    │   ├── blueprint/                   production rules and standing contracts
    │   ├── action-tree/                 optional, tracker nodes
    │   └── knowledge-tree/              reconciled / working / notepad
    │
    ├── upstream/                      ← Upstream (source, pristine, pinned)
    │   ├── core-<core_version>/         e.g. core-0.4/ — one folder per pinned version
    │   └── core-<next_version>/         coexists during migration
    │
    ├── dist/                          ← Scratch for script-produced intermediate output
    │   └── process/                     process-build namespace
    │       └── core-<core_version>/     staged build; promoted by move into process/
    │
    └── process/                       ← Process (dist, built output, single-version)
```

**Upstream is versioned; Process is single-version.** `upstream/` holds one folder per pinned version (`core-0.4/`, `core-0.5/`, …) so Migrator can read old and new pins side by side during a migration. `process/` always holds exactly the currently-active build, with no version suffix, so sessions searching under `process/` never cross version boundaries. The `core_version` field in `workspace.yaml` names the active pin.

**`dist/` is project-wide scratch.** Any script-produced intermediate output lives under `dist/`; each tool claims its own namespace. Process builds stage at `dist/process/core-<core_version>/` and promote to `process/` as the last step of the build via an atomic filesystem move. The staging-then-promote pattern keeps `process/` whole at all times: a build failure leaves `process/` untouched, and a successful build swaps in completely in one move. Sessions never read `dist/` — it is build scratch, not runtime state.

The tree is the shape. Everything below names the boxes and the rules that hold between them.

## The Lore folder is uniquely named per project

The Lore folder is **not** `.ai-lore/`. It is `.ai-lore-<project_name>/`, where `<project_name>` is the identifier from `workspace.yaml`. Every project has a different Lore folder name, and `project_name` is load-bearing: the directory name is the real directory name on disk.

This uniqueness matters because AI sessions resolve paths by walking ancestors. Two projects sharing `.ai-lore/` in the same ancestor chain — e.g. a nested project under another AI-Lore project — would give ambiguous path resolution. Unique names remove that ambiguity: a search for `.ai-lore-foo/` at any nesting depth returns exactly one result.

Project names must be filesystem-safe directory segments: `^[a-zA-Z0-9_][a-zA-Z0-9_-]*$`. `setup-project.sh` validates the name at bootstrap and refuses to run if an enclosing ancestor already contains a `.ai-lore-<name>/` with the same name.

Renaming a project is a migration: both the folder and every reference to it must move together. That is a **Migrator** responsibility and is not a normal build rerun.

## The six terms

| Term         | Definition                                                                                                                                                                                                 |
| ------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Project**  | The root directory where work happens. Has a name (`project_name`). Contains a Payload and a Lore.                                                                                                         |
| **Payload**  | What the Project produces. The Project root minus the Lore folder.                                                                                                                                         |
| **Lore**     | The support system. Everything AI-Lore uses to help produce the Payload. Lives at `<project>/.ai-lore-<project_name>/`, whose last segment matches `project_name` from the manifest.                       |
| **Memory**   | The Project's record of its own thinking: status, focus, journal, trees, blueprint. Lives at `<lore>/memory/`.                                                                                             |
| **Upstream** | **Source.** The pristine, pinned AI-Lore checkout the Process was built from. Byte-comparable against the git pin, never hand-edited. Versioned — one folder per pin at `<lore>/upstream/core-<core_version>/`. Old and new pins coexist during migration. |
| **Process**  | **Dist.** The built, substituted set of documents sessions read to orient and behave. Produced from Upstream by `build-process.sh`, not hand-edited; hand-edits are overwritten by the next build. Single-version — always holds exactly the currently-active build at `<lore>/process/`, no version suffix. |

**Source and dist.** Upstream is source; Process is dist. Substitution flows one way — source → dist. The build never writes back into Upstream. A session reading a file under `process/` sees fully substituted content with no placeholders; a session reading the same file under `upstream/core-<version>/process/` would see the raw template with `{project_name}`, `{lore_dir}`, and `{upstream_dir}` unresolved. Sessions never read Upstream directly at runtime.

**Who manages what.** Payload and Memory are actively written — Payload by you and AI during work, Memory by AI with your review. Upstream and Process are build-managed: hand-edits to either are invalid and get overwritten by the next build. Project and Lore are containers; they hold the others and have no direct management of their own.

## `workspace.yaml`

Lives at `<lore>/workspace.yaml`. Declares facts about the Project. It is a manifest, not a configuration file — behavior is determined by Process and Memory, not by switches in the manifest.

### Required fields

```yaml
project_name: my-project       # the Project's name; also the Lore folder suffix
core_version: "0.4"            # pinned AI-Lore version
```

`project_name` is required and load-bearing: it names the Project unambiguously and it is the last segment of the Lore folder name. `core_version` is required because it selects the Upstream checkout that determines how Process reads and behaves.

Other fields are extension-defined and belong here when the Project uses an extension mechanism.
