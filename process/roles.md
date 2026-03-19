# Stances

> **References**
>
> | Group | File |
> |---|---|
> | Foundation | [principles.md](./principles.md) |
> | Workflow | [workflow.md](./workflow.md) |
> | Individual stances | [roles/](../roles/) |

This is a solo practitioner's framework. You — the human — are the only person. The AI is your tool, and you direct it by shifting between cognitive stances. The "stances" are framing techniques — telling the AI "you are an Architect, challenge assumptions" produces different output than "you are a Tech Lead, implement this phase." Different stances produce different thinking. That's the entire mechanism.

The Human Lead picks the right stance as the work demands. There is no prescribed sequence — you shift when the conversation needs a different kind of thinking.

---

## You — The Human Lead

You define actions, set gatekeeps, and have final authority over everything — approvals, direction, trade-offs. Every review gate in this process exists so you can catch mistakes before they become code.

Your primary job is defining what success looks like and verifying that it was achieved. You provide the domain context the AI cannot infer, challenge the Architect's assumptions, and decide when a plan is good enough to execute. You also decide when to override the process — skip a phase, combine steps, change direction.

You decide session boundaries. You review knowledge contributions. You carry the full weight of gatekeeping. This is by design.

---

## Three Stances in the Flow

### Architect

Designs the approach and structures the work. The Architect and Human Lead collaborate to define topics, design phase roadmaps, and write phase specs. Phases are the structural backbone — each gets a spec with a clear goal, concrete steps, and done criteria.

The Architect reads the codebase deeply, challenges assumptions, pushes back on scope. Thinks broadly — trade-offs, dependencies, patterns, long-term consequences. Also maintains knowledge tree health and processes the journal on demand.

**When you use it:** At the start of every action (defining the gatekeep, designing phases), before each phase (writing the spec), when implementation reveals the plan was wrong, and when the knowledge tree needs attention.

**Entry point:** [`roles/architect.md`](../roles/architect.md)

### Tech Lead

The primary executor. Reads the phase spec, discusses approach with the Human Lead, and implements. The Tech Lead is where most code gets written. Direct implementation from the spec is the default mode — the TL reads the spec, understands the codebase, and builds.

When the work warrants it, the TL and Human Lead agree to use bounded Developer prompts — precise, single-goal instructions executed in Developer mode. This is a technique the TL reaches for, not a default pipeline step.

**When you use it:** For all implementation work. The TL is the workhorse stance.

**Entry point:** [`roles/tech-lead.md`](../roles/tech-lead.md)

### Developer

Executes prompts literally. When the Tech Lead and Human Lead agree that a bounded implementation prompt is the right approach — complex work that benefits from clean-room execution without design context — the Developer follows the prompt, runs verification, and reports back.

The Developer doesn't design, doesn't question the architecture, doesn't improve the approach. Correctness within the prompt's scope is the entire job. This is the most constrained stance by design — its value is precisely its narrowness.

**When you use it:** When the TL has written a prompt and you want clean, literal execution. Occasional, not default.

**Entry point:** [`roles/developer.md`](../roles/developer.md)

### How they flow together

**In a single session (the default),** this is fluid. You discuss the design (Architect thinking), move into implementation (Tech Lead thinking), and occasionally execute a precise prompt (Developer thinking) — all in the same conversation. The stances shape how the AI approaches the work even when the session is continuous.

**When separate sessions earn their cost:**

- **The Developer on complex prompts.** A fresh session — loading only the implementation prompt — produces more disciplined, literal output.
- **When you notice stance pollution.** If the Architect starts writing code, or the TL starts redesigning the spec, physical separation helps.
- **Deep design work.** A dedicated Architect session for a major topic benefits from having only design context loaded.

Separate sessions are the escalation path, not the default.

---

## Situational Stance — Auditor

The Auditor evaluates whether the process itself is serving the project. Skeptical by default: is this methodology helping, or is it getting in the way? Also owns version migration — transitioning a project's memory structures when the methodology evolves.

**When you reach for it:** When you feel process friction, or when the methodology updates to a new version and active projects need migration.

**Entry point:** [`roles/auditor.md`](../roles/auditor.md)

---

## Common Foundation

All AI stances share a common foundation. [`roles/operating-rules.md`](../roles/operating-rules.md) defines the behavioural standards — session protocols, human authority, append-forward, stance drift awareness. [`roles/common.md`](../roles/common.md) defines three shared duties: status and AT root index updates, orientation ("where are we?"), and external change awareness. Recording responsibilities are defined in [journaling.md](./journaling.md).

---

## Model Selection

Use the strongest reasoning model available for Architect and Auditor work — these stances require architectural thinking, trade-off analysis, and nuanced judgement. Use whatever model is most practical for execution (Tech Lead, Developer). Token efficiency is one benefit of session separation: the Developer loads one prompt, the Architect loads knowledge tree nodes plus source files. In separate sessions, each loads exactly what it needs.
