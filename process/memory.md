# Memory

Memory is the project's durable record — the persistent half of the Lore. Without it, every AI session starts from zero; with it, session 10 benefits from everything sessions 1 through 9 learned. The live half — status, tracks, focus — lives in [`status.md`](./status.md).

## The components

`.ai-lore-<project>/memory/` holds five persistent components. The **status tree** also lives under `memory/status/` on disk and is documented in [`status.md`](./status.md) — it carries the project's intent *and* its decomposition in one structure, absorbing what earlier versions kept as a separate **action tree**.

| Component          | Role                                                                                | Required |
| ------------------ | ----------------------------------------------------------------------------------- | -------- |
| **Tracks**         | Persistent workspaces — branch + claim + focus pointer (full tracks). The **home** track is always present; child tracks branch from home and merge back. | Yes      |
| **Journal**        | Continuity wire — session records and handovers.                                    | Yes      |
| **Blueprint**      | Standing commitments — contracts, processes, tooling, and the mirror of the Payload's shape. | Yes      |
| **Save-points**    | Append-only ledger of committed milestones.                                         | Yes      |
| **Knowledge tree** | Curated, compounding insight.                                                        | Optional |

Across every component, **emptiness is a valid state**. An empty knowledge tree, a focus with no stages, a blueprint with placeholder-only sections — none are gaps. They mean the project has not yet committed to anything in that area.

## The components in brief

**Tracks** — `memory/tracks/` holds one record per open track. The track primitive is documented in [`tracks.md`](./tracks.md); the git arrangement underneath is in [`git.md`](./git.md).

**Journal** — one file per session in `journal/live/`, named `YYYY-MM-DD_NN.md`. Header (with `track` pointer in frontmatter), a body of what happened, and a **handover** to the next session as the last section. Journal files are **append-forward unconditionally** — never edited or deleted after they are written; they are the audit trail. Files roll from `live/` to `archive/` on a cadence the Human Lead triggers. The journal's index (`journal/live/live.index.md`) carries the **journal trail** — the newest-first list of session one-liners — as its single source; status does not duplicate it. Trackless sessions do not write journal entries.

**Blueprint** — the project's **standing commitments**, organised in four branches:

- **`contracts/`** — evergreen, evaluable rules the Payload must honour: *"all Payload files have front matter,"* *"tests pass before any merge."* If it cannot be checked by reading the Payload against it, it is an aspiration, not a contract. Contracts also define what counts as a `save-point` beyond the required git commit.
- **`processes/`** — repeated procedures the project performs: a release runbook, a migration ritual, a checklist the AI executes against. Processes are project-specific operations; they may invoke verbs but are not themselves verbs.
- **`tooling/`** — a registry of the executable resources the project owns: a build script, a doc generator, an auxiliary app. One entry per tool — its path, how to invoke it, its purpose, when to reach for it. Distinct from `processes/`: a process is a checklist the AI *executes by hand*; a tooling entry points at something that *executes for it*. The scripts themselves live in the Payload; the registry is the catalog.
- **`mirror/`** — a description of the Payload's own shape. The Payload's directory tree is mirrored here, with a node where the project has something standing to say about an area: what it is, what it owns, what an AI session needs to know before working it. Most folders have no mirror node — emptiness is valid. Mirror is *committed* description; the knowledge tree is *learned* insight.

**Save-points** — `memory/save-points/` is an append-only ledger that never rolls and is never archived. The [`save-point`](./verbs/save-point.md) verb records a milestone here — date, description, lore commit ID, Payload commit ID. A save-point must stay reachable forever, which is why journal files (which roll) cannot hold it.

**Knowledge tree** — the project's **long-term learning memory**, organised by the boundaries where different knowledge applies. Three branches: **reconciled** (validated, authoritative), **working** (structured drafts, not yet validated), **notepad** (low-friction, focus-scoped observations). Insights are prescriptive, not descriptive.

## Drift and acknowledgement

Memory and Payload are both in git; the working-tree state on each track's branches is the project's drift signal. The mechanics — branches, the per-track drift check, the explicit `git -C` commands, what each verb commits — live in [`git.md`](./git.md). The methodology meaning: every Memory write is reviewable through [`write-lore`](./verbs/write-lore.md), and every commit through [`ack`](./verbs/ack.md), [`ack-and-continue`](./verbs/ack-and-continue.md), [`save-point`](./verbs/save-point.md), or [`close-session`](./verbs/close-session.md) is the Human Lead's act, not the session's.

## Tree discipline

Structural conventions that keep every memory tree navigable:

- **Typed files.** Every file is `[name].[type].md` — the suffix says what it is without opening it.
- **Index per folder.** Every folder carries `[folder-name].index.md`. Its body follows a three-section grammar: **References** (context this folder depends on, up and sideways), **Siblings** (companion files in the same folder), **Children** (nodes below). An index is **pure wiring** — pointers and structure only. Instructions, history, status narrative, and prose belong in the typed body files, never in an index. (This is enforcement of a long-standing rule, hardened in v0.7: an index stuffed with narrative is the defect that bloated pre-v0.7 status pages.)
- **Single source.** Content lives in exactly one place; references point to it. All links point to `.md` files, never folders, using relative paths.
- **Append-forward.** Memory moves forward by adding new artifacts alongside old ones. The [`write-lore`](./verbs/write-lore.md) verb is the sole path for every write.

## The file schema

Every Memory file carries **YAML frontmatter plus a per-type body structure** — parseable by a program, readable by a person, from the same file. Frontmatter does not replace the body; it makes the file machine-addressable while the body stays the human read.

**Common frontmatter — every Memory file:**

| Field | Value |
|---|---|
| `type` | `status` · `track` · `focus` · `stage` · `phase` · `backlog` · `journal` · `blueprint` · `kt-node` · `save-point` · `index` |
| `title` | human-readable title |
| `updated` | date last written (`YYYY-MM-DD`) |
| `references` | list of `{group, path}` — the reference header, as data |

**Per-type extension:**

| `type` | Extra frontmatter | Body |
|---|---|---|
| `status` | — | **the focus stack** — one line per focus (link + status + active-mark); the registry body of `status.stack.md`. See [`status.md`](./status.md#statusstackmd--the-focus-registry) |
| `track` | `name`, `branch` (the branch name on both repos, or `trunk` for home), `claim`, `focus` (path, optional), `mounted_by` (session ID, optional) | claim detail, per-track journal trail, notes. **Only full tracks have a record.** |
| `focus` | `status`, `focus_type` (`build`/`goal`), `claim` (optional — path prefixes the focus owns when active on a track) | gate (build) or vision (goal), context, stack, active child pointer, journal trail. **L1 of the status tree.** |
| `stage` | `gated`, `status` | intent, gate, stack, active child pointer, journal trail. **L2 — a focus's child; may hold phases.** |
| `phase` | `gated`, `status` | intent, gate, stack (optional), journal trail. **L3 — a stage's child; a buildable step, no children.** |
| `backlog` | `status` (optional) | a future to-do, pre-focus; lives in `status/backlog/`; graduates into a focus via [`grow`](./verbs/grow.md). Not in `status.stack.md`. |
| `journal` | `date`, `session`, `track` (name), `focus` (path) | session body, handover |
| `blueprint` | `branch` (`contracts`/`processes`/`tooling`/`mirror`) | per-branch — contract text, process steps, tooling-registry entry, or area description |
| `kt-node` | `branch` (`reconciled`/`working`/`notepad`) | insight format — Context / Insight / Source |
| `save-point` | `date`, `lore_commit`, `payload_commit` | milestone description; contract-override notes if any |
| `index` | — | References / Siblings / Children navigation grammar |

The schema lets a program parse Memory — for example a companion runtime (see [`bindings.md`](./bindings.md)). It never depends on one: a session with no companion reads raw frontmatter'd markdown directly.
