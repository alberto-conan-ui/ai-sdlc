# AI-Lore

A methodology for building a **Payload** — software, a campaign, a specification, anything that benefits from persistent context — with an AI partner that remembers across sessions and challenges its own prior decisions.

The Payload is what you produce. Everything else exists to serve it: a Memory model that compounds across sessions — status, focus, journal, blueprint, knowledge tree, action tree — so session 10 starts with everything sessions 1 through 9 learned. The compound curve is the point. But compounding only works if you review what the AI writes — the AI populates the memory; your review makes it trustworthy.

---

## The shape

AI-Lore organises every project around four terms. Learn them once and the rest reads cleanly.

| Term        | What it is                                                          |
| ----------- | ------------------------------------------------------------------- |
| **Project** | The root directory where work happens.                              |
| **Payload** | What the Project produces. Project root minus the Lore folder.      |
| **Lore**    | The support system. Lives at `<project>/.ai-lore-<project_name>/`.  |
| **Memory**  | Lives at `<lore>/memory/`. The Project's record of its own thinking — status, focus, journal, blueprint, trees, save-points. |

---

## How a session runs

You open an AI in your project root and say: *read `ai_readme.md`*. That is the four-word handshake.

1. **Load the methodology.** [`process/ai_readme.md`](./process/ai_readme.md) walks the AI through five documents — project structure, memory, dials, verbs, bindings. The AI is now AI-Lore-shaped.
2. **Orient.** It reads `memory/status/status.index.md`, walks the tracker chain into the active focus, and picks up the last session's handover. Three-second orientation is the test.
3. **Work.** The session produces against the focus's gate, recording everything as it goes. The Human Lead invokes verbs as needed.
4. **Close.** The session writes a journal entry, updates status, and hands the work over to the next session.

---

## The two dials

A session's conversational register is set by two dials:

| Dial           | Settings                  | What it controls            |
| -------------- | ------------------------- | --------------------------- |
| **Altitude**   | Low / Mid / High          | How lean the talk is        |
| **Commitment** | Go / Neutral / Challenge  | How hard the session pushes |

The dials shape the *conversation*, not what the session does — with one honest limit: at their extremes they cost you information, not just words. The Human Lead sets them with the `redial` verb. See [`process/dials.md`](./process/dials.md).

---

## Verbs

A **verb** is a named operation the Human Lead invokes. Verbs are loaded the moment they are invoked, not carried as standing instructions — an instruction loaded when it is needed is high-signal.

| Verb          | What it does                                              |
| ------------- | --------------------------------------------------------- |
| `write-lore`  | Write or update Memory — the sole path for writing lore   |
| `redial`      | Set the dials                                             |
| `dictation`   | Shape Human Lead input before the session consumes it     |
| `ack`         | Commit both repos with a focused message — acknowledge accumulated work |
| `save-point`  | Formal milestone — commit, ledger entry, blueprint-contract check |
| `plan`        | Set posture to Planning — produce a plan, no Payload writes |
| `reshape`     | Set posture to Reshaping — work on Memory, no Payload writes |
| `execute`     | Set posture to Executing — produce the Payload (the default) |
| `init`        | Bootstrap a folder into an AI-Lore project                |
| `upgrade`     | Migrate a project to a new core version                   |
| `install`     | Bind AI-Lore into a specific AI engine                    |

Two **bookends** — `orient` and `close-session` — are run by the session on itself at open and close. See [`process/verbs/`](./process/verbs/verbs.index.md).

---

## Memory

Memory is what makes session 10 cheaper than session 1. Six components:

| Component          | Role                                                                | Required |
| ------------------ | ------------------------------------------------------------------- | -------- |
| **Status**         | Three-second orientation. Where the project is right now.           | Yes      |
| **Journal**        | Continuity wire. One file per session, append-forward, never edited.| Yes      |
| **Blueprint**      | Production rules and standing contracts the Payload must honour.    | Yes      |
| **Save-points**    | Append-only ledger of committed milestones.                         | Yes      |
| **Action tree**    | Decomposition for focuses too large for one tracker.                | Optional |
| **Knowledge tree** | Curated, durable insights that compound over time.                  | Optional |

Status, focus, and action-tree nodes are all instances of one primitive — the **tracker** — each carrying a stack, an active child pointer, a journal trail, and a gate. The tracker chain runs from `status.index.md` down into whatever decomposition the work needs.

Across all six components, **emptiness is a valid state.** An absent action tree, an empty knowledge tree — these are not gaps. They mean the project has not yet committed to anything in that area.

Every Memory file carries a parseable schema — YAML frontmatter plus a per-type body — so a program can read Memory as easily as a person can. See [`process/memory.md`](./process/memory.md).

---

## Plain text, and installed

AI-Lore is platform-neutral plain text — complete on its own. It also **binds** to a specific AI engine: the `install` verb (`install-claude`, `install-gemini`, …) embeds the methodology into that engine's native mechanisms, so verbs become trigger-loaded units and the bookends are reinforced.

Installing changes *how the methodology is delivered*, never *what it says*. The plain-text path is always the floor; installing is a delivery upgrade, never a prerequisite. See [`process/bindings.md`](./process/bindings.md).

---

## Why this works

**Planning is cheap; discipline is the lock.** LLMs can plan in minutes. AI-Lore locks in the *discipline* of planning, not the plan. You plan, execute, learn, replan — tight cycles, disposable plans, durable discipline.

**Knowledge compounds.** The hardest problem with AI-assisted work is that every session starts from zero. AI-Lore's memory model lets session N load exactly what it needs from sessions 1 through N–1, in a fraction of the tokens rediscovery would cost. The curve is back-loaded — dramatic over a multi-month effort, barely worth it for a two-session task.

**The AI is a collaborator you can dial in.** Same model, different register, summoned on demand — and the dials persist through delivery, not just chat.

---

## Who this is for

Experienced practitioners — people who know their domain well enough to evaluate AI output critically. The methodology does not teach you your craft; it gives you a structure for practicing it *with AI* that does not degrade over time.

**Use it for the right work.** A quick task, a one-off question — just do it. AI-Lore earns its keep when the work has dependencies, spans sessions, or makes decisions that constrain future work.

> **Fair warning.** This methodology is deliberately demanding. The payoff is back-loaded: early sessions feel expensive; by session ten the compounded memory makes the AI productive immediately. Rubber-stamping the artefacts gives you all the overhead with none of the returns.

---

## Getting started

1. **Initialise.** Run the `init` verb in your project folder — it creates the Lore, the manifest, the Memory skeleton, and seeds the blueprint. See [`process/verbs/init.md`](./process/verbs/init.md).
2. **Open a session.** *Read `ai_readme.md`*.
3. **Work.**

Already on an older version? The `upgrade` verb drives the migration — see [`process/migration-from-v0.4.md`](./process/migration-from-v0.4.md).

---

## Contributing

This is a personal methodology, shared because it might be useful to others. Issues and discussions are welcome. If you want to propose changes, open an issue first.

---

## Version

**v0.5** — May 2026. The methodology is plain text, bound to an engine via the `install` verb. Memory files carry a parseable schema; a save-points ledger records committed milestones. See [`process/changelog/v0.5.md`](./process/changelog/v0.5.md).

## License

MIT — see [LICENSE](./LICENSE).
