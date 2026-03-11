# AI-SDLC

A methodology for AI-assisted software development. Tool-agnostic, derived from real project experience.

**This is not vibe coding.** Vibe coding is "give the AI a vague idea, let it generate, hope for the best." It works for throwaway prototypes. It does not work for anything you need to maintain, extend, or trust. AI-SDLC is the deliberate opposite: structured intent, human accountability at every gate, and AI constrained by process — not unleashed without it.

---

## The Problem

AI coding assistants are powerful executors but unreliable architects. They don't remember previous sessions, don't know why decisions were made, and will happily contradict earlier choices. Left unsupervised, they produce code that works locally but accumulates debt globally.

This methodology fixes that through two mechanisms: a **journal** that captures what happens, and a **knowledge tree** that captures what you've learned. Together, they give the AI a durable memory that compounds across sessions — session 10 benefits from every mistake caught in sessions 1 through 9.

**This is a human-driven process for senior developers.** AI-SDLC exists to empower humans through AI, not to replace human judgement with AI output. The AI does more of the work — planning, coding, testing. But the human defines every action, sets every gatekeep, and approves every plan. Every review gate requires experienced judgement. If the human disengages, the process breaks.

**Use it for the right work.** Not everything needs this process. A one-line fix, a config change, a dependency bump — just do it. AI-SDLC earns its keep when the work has dependencies, touches shared state, or requires decisions that constrain future work. The test: would you benefit from a written plan before coding this? If yes, create an action. If not, skip the process.

> **Fair warning.** This methodology is deliberately demanding. It will ask more of you than unstructured AI-assisted development, not less. The cognitive load is real and sustained. This is not a way to make coding with AI easier. It is a way to make it *reliably productive* over weeks and months — but the price is disciplined, critical attention at every review gate.
>
> The payoff is back-loaded: early sessions feel expensive, but by session ten the compound knowledge tree means the AI starts producing useful output in minutes instead of spending half an hour re-learning your project. The first few sessions pay for the next fifty. But only if you do the work — actually reading, actually reviewing, actually engaging with what the AI produces. Rubber-stamping the artefacts gives you all the overhead with none of the returns.

---

## The Core Ideas

AI-SDLC rests on a small number of concepts. The process documents elaborate on each, but this is the conceptual map.

### Memory — Journal and Knowledge

This is the central mechanism. Everything else serves it. The project memory (`<project-name>-memory/`) holds two complementary systems:

The project memory holds two trees and a journal:

**The Action Tree** (`actions/`) is the short-term memory. It holds the work in progress — each action carries its own session log, working insights, and links to relevant knowledge. This is where the AI finds out what's happening *right now*. When an action completes, its insights migrate to the knowledge tree and the action subtree archives. See [actions.md](./process/actions.md).

**The Knowledge Tree** (`knowledge/`) is the long-term memory. It mirrors your codebase — a folder hierarchy where each node holds what the team has learned about that area of the code. An `index.md` at each level maps the sub-areas. Knowledge is distilled from action work, placed at the right structural location, and maintained as a living resource. See [principles.md](./process/principles.md) for the knowledge model, [templates.md](./process/templates.md) for the tree structure.

**The Journal** (`journal/`) is the bridge between the two. It captures cross-cutting annotations — project-level decisions, observations spanning multiple actions, process changes. The journal is the Curator's key input: the raw material from which long-term knowledge is distilled.

The flow is natural: work produces action logs and insights → the Curator and the Human Lead surface what's worth keeping → those insights land in the knowledge tree at the right node. There is no formal "write-back ceremony." It happens organically as part of the work.

`CONTEXT.md` sits alongside the trees — a lightweight map that describes the repo structure and points into the knowledge tree. It tells the AI where to look, not what to know.

### The Action Tree — Short-Term Memory

Everything you build is an **action**. Actions live in a tree — nested however you want, named whatever you want, structured to match how you think about the work. A single node is a simple fix. A node with children decomposes complex work into sub-actions. Every node has a `gatekeep.md` that defines "done" — the status of any subtree is always computable from the leaves up.

The action tree is the project's short-term memory. Each action carries its own `log.md` (session history), `KEY_INSIGHTS.md` (working scratchpad), and `context.md` (links to relevant knowledge). When an action completes, its insights migrate to the knowledge tree and the action archives. See [actions.md](./process/actions.md).

### Roles — Cognitive Framing for the AI

You direct the AI by shifting between cognitive stances: **Architect** (design), **Tech Lead** (prompt craft), **Developer** (execution), **Navigator** (orientation), **Curator** (knowledge maintenance). These aren't separate agents — they're framing techniques that shape how the AI approaches the work. In practice, you'll usually stay in one session and shift stances as the conversation flows. Separate sessions are the escalation path for complex work. See [roles.md](./process/roles.md), [mechanics.md](./process/mechanics.md).

### Prompt Craft — The Execution Interface

The quality of AI-generated code depends almost entirely on the quality of the prompts that produce it. The methodology defines a just-in-time prompting model: plan the sequence, detail each prompt only when its turn comes, use session receipts to keep subsequent prompts grounded in reality. See [prompts.md](./process/prompts.md).

### Human Accountability — The Governance Model

The AI generates volume. You supply the judgement that makes the volume valuable. Every plan passes through your review. Every insight gets your scrutiny. Every gatekeep requires your judgement. This is a partnership driven by you — if you disengage, the process breaks. See [principles.md](./process/principles.md).

---

## Getting Started

1. Set up your workspace — see [bootstrap/README.md](./bootstrap/README.md) for the three-folder convention and step-by-step guides
2. Read the methodology — the reading order below
3. Flows (practical walkthroughs) — TBC, being rewritten to align with the reorganised methodology

## Reading Order

Each file is self-contained, but they build on each other.

| # | File | What it covers |
|---|---|---|
| 1 | [foundations.md](./process/foundations.md) | The three insights that make AI-SDLC possible — cheap planning, compound knowledge, cognitive framing |
| 2 | [principles.md](./process/principles.md) | Human accountability, append-forward, and the journal → knowledge model |
| 3 | [actions.md](./process/actions.md) | The action tree — hierarchical actions, gatekeeping at every level, the active stack |
| 4 | [roles.md](./process/roles.md) | The Human Lead and AI stances, model tiers, when to separate sessions |
| 5 | [workflow.md](./process/workflow.md) | Inception, planning, implementation, session discipline |
| 6 | [mechanics.md](./process/mechanics.md) | Context isolation, role framing, entry points, session management trade-offs |
| 7 | [prompts.md](./process/prompts.md) | How to write effective implementation prompts for Developer sessions |
| 8 | [templates.md](./process/templates.md) | File templates, naming conventions, journal and knowledge tree structure |
| 9 | [anti-patterns.md](./process/anti-patterns.md) | Common failure modes and how to avoid them |

## AI Role Entry Points

The `roles/` folder contains one file per AI stance, loaded at session start or when switching stances. Each role loads [principles.md](./roles/principles.md) first, then [common.md](./roles/common.md) for shared duties, then its own entry point: [architect.md](./roles/architect.md), [tech-lead.md](./roles/tech-lead.md), [developer.md](./roles/developer.md), [navigator.md](./roles/navigator.md), [curator.md](./roles/curator.md), or [bootstrapper.md](./roles/bootstrapper.md) (one-time setup only).

---

## Roadmap

> Where the methodology itself stands. Read this before critiquing — it captures known gaps
> and deliberate deferrals so reviews can focus on what's genuinely unknown.

### Current Stage: Inception

The methodology is being written and refined. The core documents describe the full process, but the project is not yet battle-tested across multiple real codebases. Expect revisions as practical experience accumulates.

### What's Done

- **Core process defined.** Action tree, gatekeeping at every level, roles, workflow, scaling, and anti-patterns.
- **Two-tree memory model.** Action tree (short-term, work in progress) and knowledge tree (long-term, curated) with the journal as the bridge between them.
- **Context isolation architecture.** Role entry points, cognitive framing, trade-offs between separate sessions and mode switching.
- **Prompt craft guide.** Four principles, just-in-time prompting, session receipts, common failures.
- **Templates and conventions.** Journal structure, knowledge tree layout, file templates, naming conventions.
- **Workspace setup.** Three-folder convention, workspace.yaml, multi-project scaling.
- **Role entry points.** Five AI stances plus shared foundation in `roles/common.md`.
- **Session flexibility.** Role separation reframed as cognitive framing with compression as the default.
- **Distributed upkeep model.** Action logs, insights, and STATUS.md are every role's responsibility. Human Lead reviews directly.
- **Curator stance.** Dedicated knowledge maintenance stance for auditing and distilling.
- **Active stack.** Push/pop model replacing "one active action at a time" — supports interrupt-driven, depth-first work across trees.

### Known Gaps — Will Be Addressed

- **First-impression weight.** A quick-start guide ("tasks in 5 minutes") would help newcomers. Deferred until core stabilizes.
- **More flows.** Only a solo goal walkthrough exists. Task and epic flows are needed.
- **Version control guidance.** Branching strategy, commit cadence, AI-generated code iteration patterns.
- **Cost management.** When Tier 1 models aren't worth the cost, token budget management.
- **Project-level failure recovery.** When to abandon an epic and start over.
- **Model tier table freshness.** Specific model names will go stale — consider keeping only tier characteristics.

### Known Concerns — Acknowledged, Not Yet Validated

- **Knowledge tree curation durability.** The tree structure is theoretically sound but needs real-world validation of the maintenance effort. The Curator stance offloads editorial labor to the AI, but the Human Lead's engaged review is what makes it trustworthy.
- **Context window limits.** As knowledge accumulates, loading the right subset matters. The tree structure helps (load only relevant nodes), but practical ceilings aren't known yet.
- **Process-as-procrastination.** The methodology could become a way to avoid shipping — endlessly refining specs and curating knowledge while writing no code.

---

## License

MIT
