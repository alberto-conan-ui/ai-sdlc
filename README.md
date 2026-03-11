# AI-SDLC

A methodology for AI-assisted software development. Tool-agnostic, derived from real project experience.

**This is not vibe coding.** Vibe coding is "give the AI a vague idea, let it generate, hope for the best." It works for throwaway prototypes. It does not work for anything you need to maintain, extend, or trust. AI-SDLC is the deliberate opposite: structured intent, human accountability at every gate, and AI constrained by process — not unleashed without it.

---

## The Problem

AI coding assistants are powerful executors but unreliable architects. They don't remember previous sessions, don't know why decisions were made, and will happily contradict earlier choices. Left unsupervised, they produce code that works locally but accumulates debt globally.

This methodology fixes that. The core mechanism: structured context that persists across sessions. Session 10 benefits from every mistake caught in sessions 1 through 9 — not through model fine-tuning, but through a knowledge base the AI reads at the start of each session.

**This is a human-driven process for senior developers.** AI-SDLC exists to empower humans through AI, not to replace human judgement with AI output. The AI does more of the work — planning, coding, testing. But the human defines every action, sets every gatekeep, and approves every plan. Every review gate requires experienced judgement. If the human disengages, the process breaks.

**Use it for the right work.** Not everything needs this process. A one-line fix, a config change, a dependency bump — just do it. AI-SDLC earns its keep when the work has dependencies, touches shared state, or requires decisions that constrain future work. The test: would you benefit from a written plan before coding this? If yes, create an action. If not, skip the process.

> **Fair warning.** This methodology is deliberately demanding. It will ask more of you than unstructured AI-assisted development, not less. You will review plans, specs, prompts, code, journal entries, insights, and status updates — every session, every phase. The cognitive load is real and sustained. This is not a way to make coding with AI easier. It is a way to make it *reliably productive* over weeks and months — but the price is disciplined, critical attention at every review gate.
>
> If that sounds like too much overhead, you should know that now rather than three weeks in. The payoff is back-loaded: early sessions feel expensive, but by session ten the compound knowledge base means the AI starts producing useful output in minutes instead of spending half an hour re-learning your project. The first few sessions pay for the next fifty. But only if you do the work — actually reading, actually reviewing, actually engaging with what the AI produces. Rubber-stamping the artefacts gives you all the overhead with none of the returns.
>
> This process is not meant to be easy. It is not meant to be fun. It is meant to be *incredibly productive* for those willing to pay the mental tax. If that's not the trade-off you want, keep vibe coding — no judgement. But if you've felt the pain of AI sessions that forget everything, code that degrades over time, and plans that dissolve on contact with reality, this is the discipline that fixes it.

---

## Getting Started

1. Set up your workspace — see [bootstrap/README.md](./bootstrap/README.md) for the three-folder convention and step-by-step guides
2. Read the methodology — the reading order below
3. Flows (practical walkthroughs) — TBC, being rewritten to align with the reorganised methodology

## The Methodology

Read in this order. Each file is self-contained, but they build on each other.

| # | File | What it covers |
|---|---|---|
| 1 | [foundations.md](./process/foundations.md) | Why this methodology exists — the foundational insight, who it's for, when to use it |
| 2 | [principles.md](./process/principles.md) | Human accountability, append-forward, insight promotion — the non-negotiable operating model |
| 3 | [actions.md](./process/actions.md) | The unit of work — tiers (task, epic, goal), gatekeeping, promotion |
| 4 | [roles.md](./process/roles.md) | The Human Lead and AI stances (Architect, Tech Lead, Developer, Navigator, Curator), model tiers |
| 5 | [workflow.md](./process/workflow.md) | Inception, planning, implementation, session discipline, scaling, non-negotiables |
| 6 | [mechanics.md](./process/mechanics.md) | Context isolation, role framing, entry points, session management trade-offs |
| 7 | [prompts.md](./process/prompts.md) | How to write effective implementation prompts for Developer sessions |
| 8 | [templates.md](./process/templates.md) | File templates, naming conventions, project journal structure |
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

- **Core process defined.** The process guide covers actions, tiers, gatekeeping, roles, workflow, scaling, and anti-patterns.
- **Context isolation architecture.** The mechanics document explains why roles use entry points, how cognitive framing works, and the trade-offs between separate sessions and mode switching.
- **Prompt craft guide.** The prompts document covers the four principles, just-in-time prompting, session receipts, and common failures.
- **Templates and conventions.** The templates document defines the full project journal structure, file templates, naming conventions, and insight promotion model.
- **Workspace setup.** The bootstrap guide covers the three-folder convention, workspace.yaml, and multi-project scaling.
- **Role entry points.** Five AI roles (Architect, Tech Lead, Developer, Navigator, Curator) have entry points in `roles/`, plus a shared foundation in `roles/common.md`.
- **One example flow.** The flows folder has a solo goal walkthrough.
- **Session flexibility.** Role separation reframed as a cognitive framing technique with compression as the default (March 2026 revision).
- **Distributed upkeep model.** Orchestrator replaced with common.md (shared responsibilities for all roles) + Navigator (lightweight advisory). Journal, insights, and STATUS.md are now every role's responsibility. Human Lead reviews insights directly (March 2026 revision).
- **Curator stance.** Dedicated knowledge maintenance stance that audits insights, distills journals, and proposes editorial changes to the insight hierarchy (March 2026 addition).
- **Overhead discipline framing.** Explicit section in the workflow making the honest case for why the tracking overhead compounds in value over sessions (March 2026 addition).

### Known Gaps — Will Be Addressed

- **First-impression weight.** The documents are comprehensive but read as heavy. A quick-start guide ("tasks in 5 minutes") would give newcomers an entry point that doesn't require reading the full process first. Deferred until the core methodology stabilizes.
- **More flows.** Only a solo goal walkthrough exists. Task and epic flows are the most common daily scenarios and are needed. Deferred because the goal flow covers the most moving parts — simpler flows are subsets of it.
- **Version control guidance.** Nothing about branching strategy, commit cadence, or how to handle AI-generated code that needs multiple iterations before it's commit-worthy. Will be added based on practical patterns.
- **Cost management.** No discussion of when Tier 1 models aren't worth the cost, or how to manage token budgets across a multi-phase epic. Will be informed by real usage data.
- **Project-level failure recovery.** The append-forward principle handles phase-level revisions well, but there's no guidance on when to abandon an epic entirely and start over. Will be addressed as edge cases emerge.
- **Model tier table freshness.** The illustrative model mapping in the roles document will go stale. Consider removing specific model names and keeping only the tier characteristics.

### Known Concerns — Acknowledged, Not Yet Validated

- **Insight curation durability.** The three-level KEY_INSIGHTS.md hierarchy (project, action, phase) is theoretically sound but may be too much editorial overhead in practice. The Curator stance offloads the editorial labor to the AI — it reads all journals and insights, proposes promotions/demotions/retirements, and the human approves. This should reduce curation lapses, but needs real-world validation.
- **Context window limits.** As projects accumulate insights, CONTEXT.md, three levels of KEY_INSIGHTS.md, and a phase spec may push useful context limits for smaller models. No data yet on where the practical ceiling is.
- **Process-as-procrastination.** The methodology could become a way to avoid shipping — endlessly refining specs, curating insights, and updating STATUS.md while writing no code. No anti-pattern for this yet because the right framing hasn't been found.

---

## License

MIT
