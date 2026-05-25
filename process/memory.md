# Memory

Memory is the project's durable record — the persistent half of the Lore. Without it, every AI session starts from zero; with it, session 10 benefits from everything sessions 1 through 9 learned. The live half — status, focus, dials, posture — lives in [`status.md`](./status.md).

## The components

`.ai-lore-<project>/memory/` holds five persistent components. Status also lives under `memory/status/` on disk but is documented in [`status.md`](./status.md).

| Component          | Role                                                                                | Required |
| ------------------ | ----------------------------------------------------------------------------------- | -------- |
| **Journal**        | Continuity wire — session records and handovers.                                    | Yes      |
| **Blueprint**      | Standing commitments — contracts, processes, and the mirror of the Payload's shape. | Yes      |
| **Save-points**    | Append-only ledger of committed milestones.                                         | Yes      |
| **Action tree**    | Decomposition for focuses too large for one node.                                   | Optional |
| **Knowledge tree** | Curated, compounding insight.                                                       | Optional |

Across every component, **emptiness is a valid state**. An empty knowledge tree, an absent action tree, a blueprint with placeholder-only sections — none are gaps. They mean the project has not yet committed to anything in that area.

## The components in brief

**Journal** — one file per session in `journal/live/`, named `YYYY-MM-DD_NN.md`. Header, a body of what happened, and a **handover** to the next session as the last section. Journal files are **append-forward unconditionally** — never edited or deleted after they are written; they are the audit trail. Files roll from `live/` to `archive/` on a cadence the Human Lead triggers.

**Blueprint** — the project's **standing commitments**, organised in three branches:

- **`contracts/`** — evergreen, evaluable rules the Payload must honour: *"all Payload files have front matter,"* *"tests pass before any merge."* If it cannot be checked by reading the Payload against it, it is an aspiration, not a contract. Contracts also define what counts as a `save-point` beyond the required git commit.
- **`processes/`** — repeated procedures the project performs: a release runbook, a migration ritual, a checklist the AI executes against. Processes are project-specific operations; they may invoke verbs but are not themselves verbs.
- **`mirror/`** — a description of the Payload's own shape. The Payload's directory tree is mirrored here, with a node where the project has something standing to say about an area: what it is, what it owns, what an AI session needs to know before working it. Most folders have no mirror node — emptiness is valid. Mirror is *committed* description; the knowledge tree is *learned* insight.

**Save-points** — `memory/save-points/` is an append-only ledger that never rolls and is never archived. The [`save-point`](./verbs/save-point.md) verb records a milestone here — date, description, lore commit ID, Payload commit ID. A save-point must stay reachable forever, which is why journal files (which roll) cannot hold it.

**Action tree** — captures **intention**: how work decomposes. AT nodes are focus nodes (the primitive is defined in [`status.md`](./status.md)) extended with intent and gates. Optional — a simple focus needs only a focus file. It carries intention and gates only, never design knowledge.

**Knowledge tree** — the project's **long-term learning memory**, organised by the boundaries where different knowledge applies. Three branches: **reconciled** (validated, authoritative), **working** (structured drafts, not yet validated), **notepad** (low-friction, focus-scoped observations). Insights are prescriptive, not descriptive.

## Drift signal

Both repositories — the lore repo (`.ai-lore-<project>/memory/`) and the Payload repo (the project root) — live in git. The **working tree's dirty state is the drift signal**: a dirty tree is unacknowledged work, a clean tree is acknowledged.

Two verbs move the tree from dirty to clean by committing both repos as one unit:

- [`ack`](./verbs/ack.md) — the lightweight acknowledgement. A commit with a focused message; nothing written to Memory beyond the commit.
- [`save-point`](./verbs/save-point.md) — the formal acknowledgement plus a ledger entry, marking a return point. A save-point is **always** a git commit; blueprint contracts can add gates above that minimum.

The session checks both repos at [`orient`](./verbs/orient.md) and at [`close-session`](./verbs/close-session.md) and surfaces any drift it finds. **The session never self-acks**: acknowledgement is the Human Lead's confirmation that accumulated work has been reviewed.

## Tree discipline

Structural conventions that keep every memory tree navigable:

- **Typed files.** Every file is `[name].[type].md` — the suffix says what it is without opening it.
- **Index per folder.** Every folder carries `[folder-name].index.md`. Its body follows a three-section grammar: **References** (context this folder depends on, up and sideways), **Siblings** (companion files in the same folder), **Children** (nodes below).
- **Single source.** Content lives in exactly one place; references point to it. All links point to `.md` files, never folders, using relative paths.
- **Append-forward.** Memory moves forward by adding new artifacts alongside old ones. The [`write-lore`](./verbs/write-lore.md) verb is the sole path for every write.

## The file schema

Every Memory file carries **YAML frontmatter plus a per-type body structure** — parseable by a program, readable by a person, from the same file. Frontmatter does not replace the body; it makes the file machine-addressable while the body stays the human read.

**Common frontmatter — every Memory file:**

| Field | Value |
|---|---|
| `type` | `status` · `focus` · `at-node` · `journal` · `blueprint` · `kt-node` · `save-point` · `index` |
| `title` | human-readable title |
| `updated` | date last written (`YYYY-MM-DD`) |
| `references` | list of `{group, path}` — the reference header, as data |

**Per-type extension:**

| `type` | Extra frontmatter | Body |
|---|---|---|
| `status` | `active_focus` (path), `posture` (`plan`/`reshape`/`execute`), `dials` | focus stack, journal trail, children |
| `focus` | `status`, `focus_type` (`build`/`goal`) | gate (build) or vision (goal), context, stack, active child pointer, journal trail |
| `at-node` | `node_kind` (`container`/`leaf`), `gated`, `status` | intent, gate, stack, active child pointer, journal trail |
| `journal` | `date`, `session`, `focus` (path), `dials`, `posture` | session body, handover |
| `blueprint` | `branch` (`contracts`/`processes`/`mirror`) | per-branch — contract text, process steps, or area description |
| `kt-node` | `branch` (`reconciled`/`working`/`notepad`) | insight format — Context / Insight / Source |
| `save-point` | `date`, `lore_commit`, `payload_commit` | milestone description; contract-override notes if any |
| `index` | — | References / Siblings / Children navigation grammar |

The schema lets a program parse Memory — for example a companion runtime (see [`bindings.md`](./bindings.md)). It never depends on one: a session with no companion reads raw frontmatter'd markdown directly.
