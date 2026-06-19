# Verbs

A **verb** is a named operation the Human Lead invokes into a running session. A **bookend** is an operation the session runs on itself, at session open and close. Together they are every operation AI-Lore defines. This folder holds one document per operation; this index defines the concepts they share.

## Verb and invocation

A verb is platform-neutral — it is defined here, in plain text, and it works on any engine. The session loads a verb's document when the verb is invoked, not before. That timing is the point: an instruction loaded the moment it is needed is high-signal, where the same instruction carried from session start degrades under task load.

When AI-Lore is installed into an engine ([`bindings.md`](../bindings.md)), each verb becomes that engine's native invocable unit — on Claude, a trigger-loaded skill. Installed or plain-text, the verb is the same; only the delivery differs.

## What earns a verb

An operation is its own verb only when it is a **different kind** of operation, or **destructive** enough to need an unambiguous trigger. Everything else is a parameter of an existing verb. This test keeps the set small.

## Naming

Verbs take short imperative names — `write-lore`, `grow`. No project prefix: a verb is named for what it does, and an engine binding adds any namespacing the engine needs.

## The operations

| Operation | Kind | What it does |
|---|---|---|
| [`write-lore`](./write-lore.md) | verb | Write or update Memory — the sole path by which lore is written |
| [`grow`](./grow.md) | verb | Add a node to the status tree — level inferred from the attach point (focus / stage / phase) |
| [`advance`](./advance.md) | verb | Move a focus's lifecycle status (`draft`/`paused`/`in progress`/`done`) on the stack file |
| [`archive`](./archive.md) | verb | Finish a focus — relocate its subtree to `status/archive/`; Human-Lead-invoked |
| [`spawn`](./spawn.md) | verb | Create a child track from home — opens its record + branch; Human-Lead-managed, does not mount |
| [`mount`](./mount.md) | verb | Attach a session to an already-opened full track — the entry to write-capable state |
| [`merge`](./merge.md) | verb | Land a child track's work onto home — Human-Lead-invoked |
| [`abandon`](./abandon.md) | verb | Discard a child track — auto-acks first, then removes branch and record |
| [`ack`](./ack.md) | verb | Commit both repos on the mounted track's branches at a deliberate pause point — acknowledge accumulated work |
| [`ack-and-continue`](./ack-and-continue.md) | verb | Light mid-execution commit — same commit shape as `ack`, minimal ceremony, session continues |
| [`save-point`](./save-point.md) | verb | Formal milestone on home — commit, ledger entry, blueprint-contract check (requires all children closed) |
| [`publish`](./publish.md) | verb | Sync the Payload's curated subset into `publish/` — the project's external deliverable. Publishing projects only. |
| [`init`](./init.md) | verb | Bootstrap a folder into an AI-Lore project |
| [`upgrade`](./upgrade.md) | verb | Migrate a project to a new core version |
| [`install`](./install.md) | verb | Bind AI-Lore into a specific AI engine |
| [`orient`](./orient.md) | bookend | Session open — load the methodology, surface open tracks and drift |
| [`close-session`](./close-session.md) | bookend | Session close — write the journal, handover, surface any drift on the mounted track |

The verbs split into six groups by what they do:

- **Ordinary work** — `write-lore`. The sole path for every Memory write; run within ongoing work on the mounted track.
- **Status tree** — `grow`, `advance`, `archive`. Own the **structure** of the status tree: `grow` adds a node (focus/stage/phase, level inferred from the attach point), `advance` moves a focus's lifecycle status, `archive` finishes a focus and relocates its subtree. The tree's structure is mutated *only* through these — no track may make free-hand structural edits (`write-lore` fills node bodies but never creates or moves nodes). See [`status.md`](../status.md#the-tree-is-verb-only).
- **Tracks** — `spawn`, `mount`, `merge`, `abandon`. Manage the full-track workspaces sessions run in. `spawn` (from home) **creates** a child track's record + branch; `mount` **attaches** a session to an already-opened track; `merge` and `abandon` are the exits. The child lifecycle is spawn → mount → merge/abandon.
- **Ack** — `ack`, `ack-and-continue`, `save-point`. Move a full track's working tree from dirty to clean by committing both repos. `ack` is the deliberate pause-point commit; `ack-and-continue` is the light mid-execution variant; `save-point` is home-only and consolidates. None of the three are coupled to `close-session` — they are independent verbs. **Light tracks may invoke none of them** (see below).
- **Outward** — `publish`. Sync the curated subset of the Payload to the external deliverable. Publishing projects only; home-only.
- **Lifecycle** — `init`, `upgrade`, `install`. Run once per project or once per engine.

## What a session may touch is its track type

v0.7 removed posture and dials. There is no chat/plan/reshape/execute mode and no register to set — **what a session may touch is governed entirely by its track type** (see [`tracks.md`](../tracks.md#track-types)):

- **Trackless** — read-only across the project; writes nothing, leaves no trace. The query / "just looking" mode.
- **Light** — may write only the journal and the [backlog](../status.md#backlog), and **only those**; not mounted, no branch, no record. Its writes land as drift on trunk for a home session to acknowledge. A light track may not `ack`, `save-point`, or invoke any status-tree or track verb.
- **Full** — mounted, claimed, branched; may write everything within its claim (Payload + Memory) through the appropriate verbs.

The track type is the gate — a write a session's type does not permit is refused. This replaces the posture machinery entirely; no flag is set per session, the type *is* the standing constraint.

## Acknowledgement and drift

The working tree's dirty state on a track's branch is the drift signal — unacknowledged work waiting for Human Lead review, per track. Three verbs move a track's tree from dirty to clean on its branches: `ack` (deliberate pause-point commit), `ack-and-continue` (light mid-execution commit), and `save-point` (formal commit + ledger; home-only; requires all children closed). Two further verbs end a child track's life: `merge` lands it on home, `abandon` discards it.

`close-session` also commits — its own writes (journal, status) plus any drift on the working tree — as a Human-Lead-confirmed closing commit. The bookend's commit is independent from `ack` and the other ack-family verbs; close-session does not run them and they do not prompt about it.

Sessions never self-ack, self-save-point, self-merge, or self-abandon — every landing onto canonical state is the Human Lead's act. close-session's closing commit is also Human-Lead-confirmed (the session drafts the message; the HL confirms before it lands), so the rule holds there too. The session flags drift at `orient` (across all open tracks) and at `close-session` (on the mounted track).

## Bookends

`orient` and `close-session` are not invoked by the Human Lead — they have no external trigger. The session opens by orienting and closes by closing; it is intrinsic behaviour. An engine binding may *reinforce* a bookend with a hook so it cannot be skipped, but the methodology never depends on the reinforcement.

## Verbs declare their prerequisites

A verb is loaded only when invoked (its content is high-signal exactly then, not carried from session start where it degrades). From v0.7 the same lazy discipline extends to the **pillars**: a session loads only a thin eager core at [`orient`](./orient.md) (`project-structure.md`, `status.md`, this index), and each verb and bookend **declares the pillars it needs** in a *Prerequisites* line. The verb is the chokepoint — a session cannot reach the action without passing the declaration, so the load is guaranteed, not left to judgement. `ack` names `git.md`; `mount` names `tracks.md`; `grow`/`archive` name `status.md` and `memory.md`; and so on. Indexes support ad-hoc browsing, but **correctness rides on the declared prerequisites**, not on the session noticing it is missing context. See the load model in [`ai_readme.md`](../ai_readme.md).
