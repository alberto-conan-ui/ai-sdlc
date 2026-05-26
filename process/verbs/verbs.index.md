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
| [`ack`](./ack.md) | verb | Commit both repos with a focused message — acknowledge accumulated work |
| [`save-point`](./save-point.md) | verb | Formal milestone — commit, ledger entry, blueprint-contract check |
| [`chat`](./chat.md) | verb | Set posture to Chat — converse only, touch nothing |
| [`plan`](./plan.md) | verb | Set posture to Planning — discuss and write plans, Payload read-only |
| [`reshape`](./reshape.md) | verb | Set posture to Reshaping — work on Memory, Payload read-only |
| [`execute`](./execute.md) | verb | Set posture to Executing — produce the Payload (the default) |
| [`publish`](./publish.md) | verb | Sync the Payload's curated subset into `publish/` — the project's external deliverable. Publishing projects only. |
| [`init`](./init.md) | verb | Bootstrap a folder into an AI-Lore project |
| [`upgrade`](./upgrade.md) | verb | Migrate a project to a new core version |
| [`install`](./install.md) | verb | Bind AI-Lore into a specific AI engine |
| [`orient`](./orient.md) | bookend | Session open — load the methodology, walk the focus chain, check for drift |
| [`close-session`](./close-session.md) | bookend | Session close — write the journal, handover, status, and surface any drift |

The verbs split into five groups by what they do:

- **Posture** — `chat`, `plan`, `reshape`, `execute`. Set *where* the session is working. The active posture is recorded in `status/status.index.md`.
- **Ack** — `ack`, `save-point`. Move the working tree from dirty to clean by committing both repos.
- **Ordinary work** — `write-lore`, `redial`. Run within ongoing work.
- **Outward** — `publish`. Sync the curated subset of the Payload to the external deliverable. Publishing projects only.
- **Lifecycle** — `init`, `upgrade`, `install`. Run once per project or once per engine.

## Posture is recorded

The posture verbs write the session's working posture to `status/status.index.md`. The field carries across the session and across handovers, so a session opening from a previous session's posture knows where it stands without re-asking.

Each posture has a real behavioural rule (see [`status.md`](../status.md#posture)): Chat makes both the Payload and Memory read-only; Planning and Reshaping both make the Payload read-only; Executing lifts that and is the default. The posture is the gate, not a label — a request that would violate the current posture is refused until a posture verb changes it.

## Acknowledgement and drift

The working tree's dirty state is the drift signal — unacknowledged work waiting for Human Lead review. Two verbs move the tree from dirty to clean: `ack` (lightweight commit) and `save-point` (formal commit + ledger). The session flags drift at `orient` and at `close-session`; it never self-acks. Acknowledgement is always a Human Lead action — that is what makes it acknowledgement.

## Bookends

`orient` and `close-session` are not invoked by the Human Lead — they have no external trigger. The session opens by orienting and closes by closing; it is intrinsic behaviour. An engine binding may *reinforce* a bookend with a hook so it cannot be skipped, but the methodology never depends on the reinforcement.
