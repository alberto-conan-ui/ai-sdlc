---
type: process
audience: [human, ai]
depends_on: [principles.md, workflow.md]
---

# Roles

This is a solo practitioner's framework. You — the human — are the only person. The AI is your tool, and you direct it by shifting between cognitive stances. The "roles" are not people or separate agents. They are **framing techniques** — telling the AI "you are an Architect, challenge assumptions" produces genuinely different output than "you are a Developer, follow this prompt." Different stances produce different thinking. That's the entire mechanism.

The Human Lead picks the right stance as the work demands it. There is no prescribed sequence or ceremony for switching — you shift when the conversation needs a different kind of thinking.

> **Depends on:** [principles.md](./principles.md), [workflow.md](./workflow.md)
> **See also:** Individual role files in [roles/](../roles/)

---

## You — The Human Lead

You define actions, set gatekeeps, and have final authority over everything — approvals, direction, trade-offs. Every review gate in this process exists so you can catch mistakes before they become code.

Your primary job is defining what success looks like and verifying that it was achieved. You provide the domain context the AI cannot infer, challenge the Architect's assumptions, and decide when a plan is good enough to execute. You also decide when to override the process — skip a phase, combine steps, change direction.

**You declare the engagement mode.** The project is always in one of two modes — **Shaping** (oriented around the knowledge tree and action tree structure) or **Working** (oriented around executing the active stack). You switch between them explicitly. The mode gates which stances are primary, what recording looks like, and what activities are appropriate. See [workflow.md — Engagement Modes](./workflow.md#engagement-modes).

**You decide session boundaries.** When to open a fresh session for a stance, when to shift stances within the same conversation, when to ask the AI for a Navigator-style briefing versus just asking "where are we?" This is a judgement call informed by the work's complexity and the output quality you're seeing.

**You review knowledge contributions.** The AI proposes insights for the knowledge tree and action-level scratchpads (per common.md) regardless of which stance it's in. You review these as they appear — confirming placement, revising what's vague, removing what's wrong, redirecting to a better node in the tree.

You carry the full weight of gatekeeping. This is by design (see [Principles](./principles.md) — Human Accountability).

---

## The Core Flow — Architect, Tech Lead, Developer

These three stances drive every action from design through to code. The Human Lead flows between them as the work progresses — often within a single session.

```
Architect ──→ Tech Lead ──→ Developer
 (design)     (prompts)     (execute)
    ↑                           │
    └───────────────────────────┘
         (phase-level issue)
```

### Architect

**Engagement mode:** Shaping.

Designs the approach. Reads the codebase deeply, writes phase specs, challenges assumptions, pushes back on scope. The Architect thinks broadly — trade-offs, dependencies, patterns, long-term consequences.

**When you use it:** At the start of every action (defining the gatekeep, designing the roadmap), before every phase (writing the spec), and when implementation reveals the plan was wrong (revising the spec).

**Entry point:** [`roles/architect.md`](../roles/architect.md)

### Tech Lead

**Engagement mode:** Working.

Translates architecture into execution. Reads the phase spec and writes precise implementation prompts — specific file paths, code references, bounded goals. The Tech Lead thinks precisely — every noun in a prompt is a concrete reference, not a vague description.

**When you use it:** After the Architect's spec is approved. The Tech Lead writes the prompt plan and each implementation prompt just in time, informed by the Developer's session receipts.

**Entry point:** [`roles/tech-lead.md`](../roles/tech-lead.md)

### Developer

**Engagement mode:** Working.

Executes prompts literally. Follows the steps, runs verification commands, produces a session receipt. The Developer doesn't design, doesn't question the architecture, doesn't improve the approach. Correctness within the prompt's scope — that's the entire job.

**When you use it:** When there's an approved implementation prompt to execute. The Developer loads only the prompt — nothing else.

**Entry point:** [`roles/developer.md`](../roles/developer.md)

### How they flow together

**In a single session (the default),** this is fluid. You discuss the design (Architect thinking), translate it into prompts (Tech Lead thinking), execute (Developer thinking) — all in the same conversation. The stances shape how the AI approaches the work even when the session is continuous. Most work runs fine this way.

**When separate sessions earn their cost:**

- **The Developer on complex work.** A fresh session — loading only the implementation prompt, with no memory of the design discussion — produces more disciplined, literal output.
- **When you notice stance pollution.** If the Architect starts writing implementation details, or the Developer starts second-guessing prompts, physical separation helps.
- **Deep design work.** The full Architect → Tech Lead → Developer pipeline in separate sessions produces the cleanest output for work that demands genuine systems thinking.

Separate sessions are the escalation path, not the default. You'll know when to escalate because the output quality tells you.

---

## Situational Stances — Navigator, Curator

These stances serve specific needs that arise periodically, not as part of the regular design→prompts→code flow.

### Navigator

**Engagement mode:** Shaping.

Helps the Human Lead see the big picture and decide what to do next. The Navigator reads STATUS.md and the recent journal, synthesises process state into actionable guidance: what mode we're in, what's on the stack, what happened last, what to do next.

**When you reach for it:** Start of day. After a break. Resuming paused work after days or weeks away. When you need a handoff prompt for a fresh session. When checking for external codebase changes that might affect the plan.

**When you don't need it:** If you already know where you are, just ask the AI "where are we?" in any stance — that's a common responsibility, not Navigator-specific.

**Entry point:** [`roles/navigator.md`](../roles/navigator.md)

### Curator

**Engagement mode:** Shaping.

Audits the memory pipeline. In dedicated sessions, the Curator reads the full journal, action logs, and KEY_INSIGHTS.md files (the recording system defined in [journaling.md](./journaling.md)), then proposes editorial actions — promote, demote, retire, rewrite, or add insights in the knowledge tree. The journal is the Curator's primary audit trail.

**When you reach for it:** At minimum, every time an action is archived — this is the baseline cadence. Also after a week of active work across multiple actions, or when you suspect the knowledge tree has drifted from reality. Not as part of regular work.

**Entry point:** [`roles/curator.md`](../roles/curator.md)

---

## One-Time — Bootstrapper

The Bootstrapper sets up a new project's `.ai-sdlc/` folder — creating the memory structure, workspace.yaml, the journal skeleton, `action-tree/STATUS.md`, and the initial knowledge tree root at `knowledge-tree/index.spec.md`. It runs once during project inception and is never used again.

**Entry point:** [`roles/bootstrapper.md`](../roles/bootstrapper.md)

---

## Common Foundation

All AI stances share a common foundation ([`roles/common.md`](../roles/common.md)) that defines:

- **Process anchoring** — the AI always knows and makes explicit which engagement mode, stance, and action are active. When the Human Lead's direction implies a change, the AI confirms before proceeding (see [principles.md — Formalise the Implicit](./principles.md#formalise-the-implicit))
- **Recording responsibilities** — every role participates in the recording system as defined in [journaling.md](./journaling.md): log entries, insight surfacing, journal writing, and session receipts (Developer). The memory model that these recordings feed is defined in [memory.md](./memory.md)
- **STATUS.md updates** — the AI updates STATUS.md when its work changes the project state
- **Orientation** — any role can answer "where are we?" by reading STATUS.md and the active action's log

The Human Lead reviews knowledge contributions as they appear and maintains final authority over what stays and where it goes.

---

## Model Tiers

Each AI stance has different cognitive demands. Rather than hardcoding specific models (which change frequently), this methodology uses a **tier system**. Map tiers to your current best-available models.

| Tier | Characteristics | Typical stances |
|---|---|---|
| **Tier 1 — Reasoning** | Strongest reasoning, largest context window. Architectural thinking, trade-off analysis, nuanced judgement. | Architect, Tech Lead (complex phases), Curator |
| **Tier 2 — Execution** | Strong code generation, good instruction-following. Fast, cost-effective. | Developer, Tech Lead (straightforward phases), Navigator |

**When the Tech Lead moves between tiers:** For phases that involve complex refactoring, novel architecture, or ambiguous requirements, the Tech Lead benefits from Tier 1. For phases that follow established patterns, Tier 2 is sufficient. You make this call per phase.

**Token efficiency is one benefit of session separation.** The Developer loads one implementation prompt (~50-100 lines). The Architect loads relevant knowledge tree nodes (~300+ lines) plus source files. In separate sessions, each stance loads exactly what it needs. In a shared session, the model carries everything it's seen, which costs tokens and can influence behaviour.
