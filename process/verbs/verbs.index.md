# Verbs

A **verb** is a named operation the Human Lead invokes into a running session. A **bookend** is an operation the session runs on itself, at session open and close. Together they are every operation AI-Lore defines. This folder holds one document per operation; this index defines the concepts they share.

## Verb and invocation

A verb is platform-neutral — it is defined here, in plain text, and it works on any engine. The session loads a verb's document when the verb is invoked, not before. That timing is the point: an instruction loaded the moment it is needed is high-signal, where the same instruction carried from session start degrades under task load.

When AI-Lore is installed into an engine ([`bindings.md`](../bindings.md)), each verb becomes that engine's native invocable unit — on Claude, a trigger-loaded skill. Installed or plain-text, the verb is the same; only the delivery differs.

## What earns a verb

An operation is its own verb only when it is a **different kind** of operation, or **destructive** enough to need an unambiguous trigger. Everything else is a parameter of an existing verb. This test keeps the set small.

## Naming

Verbs take short imperative names — `write-lore`, `redial`. No project prefix: a verb is named for what it does, and an engine binding adds any namespacing the engine needs.

## The operations

| Operation | Kind | What it does |
|---|---|---|
| [`write-lore`](./write-lore.md) | verb | Write or update Memory — the sole path by which lore is written |
| [`redial`](./redial.md) | verb | Set the dials — the conversational register |
| [`mount`](./mount.md) | verb | Attach a session to a track — the entry to write-capable state |
| [`merge`](./merge.md) | verb | Land a child track's work onto master — Human-Lead-invoked |
| [`abandon`](./abandon.md) | verb | Discard a child track — auto-acks first, then removes branch and record |
| [`ack`](./ack.md) | verb | Commit both repos on the mounted track's branches — acknowledge accumulated work |
| [`save-point`](./save-point.md) | verb | Formal milestone on master — commit, ledger entry, blueprint-contract check (requires all children closed) |
| [`chat`](./chat.md) | verb | Set posture to Chat — converse only, touch nothing |
| [`plan`](./plan.md) | verb | Set posture to Planning — discuss and write plans, Payload read-only |
| [`reshape`](./reshape.md) | verb | Set posture to Reshaping — work on Memory, Payload read-only |
| [`execute`](./execute.md) | verb | Set posture to Executing — produce the Payload (the default) |
| [`publish`](./publish.md) | verb | Sync the Payload's curated subset into `publish/` — the project's external deliverable. Publishing projects only. |
| [`init`](./init.md) | verb | Bootstrap a folder into an AI-Lore project |
| [`upgrade`](./upgrade.md) | verb | Migrate a project to a new core version |
| [`install`](./install.md) | verb | Bind AI-Lore into a specific AI engine |
| [`orient`](./orient.md) | bookend | Session open — load the methodology, surface open tracks and drift |
| [`close-session`](./close-session.md) | bookend | Session close — write the journal, handover, surface any drift on the mounted track |

The verbs split into six groups by what they do:

- **Ordinary work** — `write-lore`, `redial`. Run within ongoing work on the mounted track.
- **Tracks** — `mount`, `merge`, `abandon`. Manage the workspaces sessions run in. `mount` is the entry to writing; `merge` and `abandon` are the exits.
- **Ack** — `ack`, `save-point`. Move the mounted track's working tree from dirty to clean by committing both repos. `save-point` is master-only and consolidates.
- **Posture** — `chat`, `plan`, `reshape`, `execute`. Set *what* the session may touch on the mounted track. The posture is recorded on the track's record.
- **Outward** — `publish`. Sync the curated subset of the Payload to the external deliverable. Publishing projects only; master-only.
- **Lifecycle** — `init`, `upgrade`, `install`. Run once per project or once per engine.

## Posture is recorded on the track

The posture verbs write the session's working posture to the **mounted track's record** (`memory/tracks/<name>.track.md`). The field persists across sessions that remount the same track, so a session opening from a previous session's posture on that track knows where it stands without re-asking.

Each posture has a real behavioural rule (see [`status.md`](../status.md#posture)): Chat makes both the Payload and Memory read-only; Planning and Reshaping both make the Payload read-only; Executing lifts that and is the default. The posture is the gate, not a label — a request that would violate the current posture is refused until a posture verb changes it.

Trackless sessions are implicitly Chat — there is no record to write to, and the project is read-only. The `chat` verb is a no-op while trackless. Other posture verbs imply a mount (auto-master if free; HL-prompted otherwise) because writing a posture is itself a write.

## Acknowledgement and drift

The working tree's dirty state on a track's branch is the drift signal — unacknowledged work waiting for Human Lead review, per track. Two verbs move a track's tree from dirty to clean on its branches: `ack` (lightweight commit) and `save-point` (formal commit + ledger; master-only; requires all children closed). Two further verbs end a child track's life: `merge` lands it on master, `abandon` discards it. Sessions never self-ack, self-save-point, self-merge, or self-abandon — every landing onto canonical state is the Human Lead's act. The session flags drift at `orient` (across all open tracks) and at `close-session` (on the mounted track).

## Bookends

`orient` and `close-session` are not invoked by the Human Lead — they have no external trigger. The session opens by orienting and closes by closing; it is intrinsic behaviour. An engine binding may *reinforce* a bookend with a hook so it cannot be skipped, but the methodology never depends on the reinforcement.
