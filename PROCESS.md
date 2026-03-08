# AI-SDLC: Process Guide

> A methodology for AI-assisted software development.
> Derived from real project experience. Tool-agnostic — works with any AI coding assistant.
>
> **For AI roles:** Do not load this document into AI sessions. Each AI role has its own
> entry point in [`roles/`](./roles/) that contains exactly what it needs — nothing more.
> This document is for the Human Lead to understand the full methodology.
> See [`MECHANICS.md`](./MECHANICS.md) for why this separation exists.

---

## The Foundational Insight

Traditional software development resisted upfront planning for a good reason: humans can't hold enough context to plan accurately. By the time you've read the codebase, traced the dependencies, considered the edge cases, and mapped the existing patterns, you've already forgotten the first half. Waterfall failed because it demanded detailed plans from people who couldn't realistically produce them — so the industry moved to iterative discovery. Write code, see what breaks, adjust.

LLMs change this equation. An AI can read an entire codebase, hold it in context, trace execution paths, and produce a detailed plan — in minutes, not weeks. The cognitive bottleneck that made upfront planning impractical for humans does not apply to AI. Planning is now cheap.

**This methodology exists because planning is now cheap.**

But "plan more" is not "do waterfall." The distinction matters:

**Waterfall locks in the plan.** You plan once, at the start, and then execute that plan to completion. When reality diverges from the plan (and it always does), you either force the code to match the plan or engage a costly change control process. The plan is sacred.

**AI-SDLC locks in the discipline of planning, not the plan itself.** You plan before every phase. You execute. Implementation reveals new information. You replan. The cycle is tight — hours, not months. A plan that gets revised three times in two days isn't a failure of planning; it's the process working as designed. The plans are disposable. The discipline of producing them is not.

This is what makes the approach possible *now* in a way it wasn't before. The Senior Architect can load the full codebase, every previous decision, every lesson learned, and produce a phase plan that accounts for the real state of the system — not a guess from a whiteboard session. And when that plan turns out to be partially wrong (which it will), the same Architect can reload context, absorb what was learned during implementation, and produce a corrected plan just as quickly.

The process is structured. The project execution is adaptive. Don't confuse the two.

---

## Who This Is For

This methodology is for senior developers. It assumes you can already architect software, evaluate trade-offs, recognise when AI output is wrong, and make sound technical decisions without guidance. The process doesn't teach you how to build software — it gives you a structure for building software *with AI* that doesn't degrade over time.

A junior developer will struggle with this methodology — not because of its complexity, but because every review gate requires the Human Lead to evaluate AI output with experienced judgement. When the Architect produces a phase spec, you need to know whether the approach is sound. When the Developer produces code, you need to spot the subtle bugs that pass the tests. When the AI pushes back on your goal, you need to know when it's right and when it's wrong. These are senior skills. The process amplifies them; it doesn't replace them.

---

## When to Use This — and When Not To

AI-SDLC exists to bring structure to work that's complex enough to benefit from it. Not all work qualifies.

**Use this when** the work has dependencies, touches shared state, spans multiple files, or requires decisions that will constrain future work. When a mistake would be expensive to undo. When the AI needs to understand context that won't fit in a single prompt. When you'll come back to this code in three months and need to understand why decisions were made. Even a task — the lightest tier — earns its keep when the fix is non-obvious or the code is load-bearing.

**Don't use this when** the work is straightforward enough that you'd just do it. A one-line config change, a dependency bump, a typo fix, renaming a variable — if you can see the entire change in your head and there's no architectural judgement involved, skip the process and do the work directly. You can use AI to help with these — just don't route them through AI-SDLC. The methodology's value comes from structured context persistence, and trivial changes don't produce context worth persisting.

The test: **would you benefit from a written plan before coding this?** If yes, create an action. If the answer is obviously no, just do the work. If you're unsure, start with a task — the overhead is minimal and you can always drop it if the fix turns out to be trivial.

This is a judgement call, and the methodology trusts you to make it. That's by design — this is a tool for senior developers, not a rulebook that removes the need for experience.

---

## Core Principles

### Human Accountability

This methodology does not reduce the human's responsibility. It increases it.

The AI does more of the work — planning, writing code, generating tests, producing artefacts. But the human owns every decision. Every action is human-defined. Every gatekeep is human-approved. Every plan passes through a human review gate before it becomes code. The AI is the workforce. The human is the authority.

When the Human Lead is also the sole stakeholder — which is the common case for solo developers and small teams — there is no one else to defer to. The gatekeep "my own approval" means you are accountable for the quality of what ships. This is not a limitation of the process. It is the point. AI-SDLC exists to empower humans through AI, not to replace human judgement with AI output.

This is a partnership driven by humans. If the human disengages — rubber-stamps plans without reading them, skips review gates, accepts AI output without scrutiny — the process breaks. The methodology is only as strong as the human driving it.

### Append-Forward

The project journal moves forward, never backward. When a plan changes, the new plan is a new artefact. The old plan stays as the record of what was believed at the time. When a task outgrows its scope, the task stays as-is and a new epic or goal is created to continue the work. Promotion, revision, and abandonment are all forward moves — new entries, new files, new journal notes.

This principle exists because rewriting history breaks the context chain. If a spec gets silently edited, the journal entries that reference it no longer make sense. If a task folder gets renamed or restructured, the Orchestrator's references go stale. By always moving forward — creating new artefacts rather than mutating old ones — every past reference remains valid, and the journal tells a truthful story.

The only file that genuinely mutates is STATUS.md, and even that is just pointer updates: which action is active, which phase, which prompt. Everything else is append-only.

The Orchestrator is the role that ties forward moves together. It reads the journal, knows what was promoted from what, and bridges the context gap so the Human Lead and other roles don't have to trace the history manually.

---

## Actions — The Unit of Work

Everything in AI-SDLC is an **action**. An action is a human-defined piece of work with a clear outcome. The Human Lead creates actions, classifies them by tier, and drives them to completion.

There are three tiers: **Task**, **Epic**, and **Goal**. The tier determines how much ceremony the action gets — but the underlying machinery is the same. All actions live in the `actions/` folder, all follow the same phase-based execution model, and all produce journal entries and insights.

### The Three Tiers

**Task** — a bounded, concrete piece of work. One phase, one to three prompts, done in a session or two. "Fix the login redirect bug." "Add a loading spinner to the dashboard." "Update the date format in the export CSV."

The Human Lead already knows what's wrong and what done looks like. The gatekeep is concrete and verifiable: the bug is fixed, the spinner appears, the date format is correct. Role compression is the default — the Architect might get pulled in ad hoc if the fix turns out to be trickier than expected, but there's no formal design phase. The Tech Lead and Architect are often the same session. The process is deliberately loose because tasks are meant to be quick.

A task has a TASK.md (lightweight — problem statement and done-when criteria) and a single phase folder with a spec and implementation prompts.

**Epic** — a multi-phase piece of work with a concrete, measurable outcome. "Refactor the validation pipeline to use a lookup table." "Add OAuth2 support to the API." "Migrate the test suite from Jest to Vitest."

An epic gets full Planning and Implementation. The outcome is tangible — the refactor is done, the feature works, the migration is complete. The gatekeep is concrete: specific conditions that can be verified without subjective judgement. The Architect designs the phases, the Tech Lead writes the prompts, the Developer executes them. Full role separation is the default.

An epic has an EPIC.md (problem, vision, concrete gatekeep) and a phases folder with the standard spec/impl structure.

**Goal** — an abstract, outcome-oriented aspiration. "Users should be able to register without understanding the type system." "Onboarding a new developer to the DX layer should take hours, not days."

A goal gets full Planning and Implementation with the heaviest ceremony. The gatekeep involves human judgement — not just whether the code works, but whether the outcome was achieved. The Senior Architect helps refine the goal, writes GOAL.md with design principles, and plans the roadmap. This is the heavyweight tier, appropriate for work that shapes the product's direction.

A goal has a GOAL.md (problem, vision, design principles, abstract gatekeep) and a phases folder with the standard structure.

### The Tier Spectrum

| | Task | Epic | Goal |
|---|---|---|---|
| **Planning weight** | Compressed (short spec, optional prompt plan) | Full | Full |
| **Phases** | One | Multiple | Multiple |
| **Gatekeep** | Concrete, verifiable | Concrete, measurable | Abstract, human-judged |
| **Role compression** | Default | Optional | Full separation |
| **Prompt plan** | Optional (1–2 prompts may not need one) | Yes | Yes |
| **Action document** | TASK.md (lightweight) | EPIC.md (problem + concrete gatekeep) | GOAL.md (problem + vision + principles + abstract gatekeep) |

### Choosing a Tier

The Human Lead picks the tier when creating the action. The right tier is usually obvious:

- "Fix this bug" → **Task**
- "Add this feature" → **Epic** (unless the feature is trivial — then task)
- "Redesign how users interact with X" → **Goal**

When it's ambiguous, start with the lighter tier. A task that outgrows its scope can be promoted (see below). Starting heavy and discovering you over-planned is more wasteful than starting light and promoting when needed.

### Promotion

When a task turns out to need a second phase, it's no longer a task — it's an epic. When an epic's gatekeep turns out to require subjective evaluation, it's a goal.

**Promotion follows the append-forward principle.** The original action stays as-is. A new action is created at the higher tier. The journal captures the promotion decision: what was the original action, why it's being promoted, and what the new action needs to accomplish. The Orchestrator bridges the context — it knows the history and can advise the new action's Architect or Tech Lead on what was already done and what was learned.

A promoted task's TASK.md is never modified. The new epic's EPIC.md references the original task ("Promoted from task-login-bug — see journal 2026-W11") and the Orchestrator's handoff prompt carries over the relevant context.

The promotion triggers:

- **Task → Epic:** the fix needs a second phase, or the scope touches shared architecture
- **Epic → Goal:** the gatekeep becomes subjective, or the outcome needs abstract vision-setting

### One Active Action at a Time

A project may have many actions defined, but only one is active. This prevents context scatter — every role knows exactly which action it's serving. The active action and its tier are tracked in STATUS.md.

If the Human Lead wants to switch actions, they do so explicitly. The Orchestrator updates STATUS.md, logs the reason in the journal, and captures the state of the paused action. When returning to a paused action, the Orchestrator's briefing includes why it was paused and what state it was in.

Because the journal captures context for every action that's been worked on, the Orchestrator can answer "what was I working on three weeks ago?" or "can I pick this up again?" by scanning the journal history.

---

## Gatekeeping

Every action has a gatekeep — but the nature of the gatekeep varies by tier.

**Task gatekeeps** are binary. The bug is fixed or it isn't. The spinner appears or it doesn't. Tests pass. "Done" is obvious. The Human Lead verifies by looking at the result.

**Epic gatekeeps** are concrete and measurable, but may involve multiple conditions. "The switch statements are removed, all existing tests pass, the API is backward-compatible, and the new lookup table handles all 12 registered types." The Human Lead verifies against the checklist.

**Goal gatekeeps** involve human judgement. They name who decides and what they're evaluating, even if the criteria are subjective. "The Human Lead is satisfied that the demo narrative is clear and progressive." "Three beta users complete the onboarding task without asking for help." The discipline is in identifying the person accountable, not in quantifying every metric.

**Examples of gatekeeps by tier:**

| Tier | Example gatekeep |
|---|---|
| Task | "The login redirect sends users to `/dashboard` instead of `/home`." |
| Epic | "OAuth2 login works with Google and GitHub, existing session management is unchanged, all auth tests pass." |
| Goal | "The Head of Product confirms the new registration flow meets the design spec." |

**What gatekeeps are not:**

- "It should feel right." (No one is named as the decision-maker.)
- "Tests pass." (That's a done-criterion for a phase, not a gatekeep for an action.)
- "The AI says it's done." (The AI is never the gatekeeper.)

### When Gatekeeps Are Unclear

If the Human Lead cannot define a gatekeep, the action is probably scoped wrong. A task with no clear "done" condition should probably be refined. An epic where "done" is subjective should probably be a goal. A goal where "done" can't be articulated at all is a signal to stop and think — not to start planning.

---

## Roles

Five roles drive this process. The Human Lead plus four AI roles, each running in a **separate session** — this is not optional. Mixing roles in a single session degrades output because each role needs different context, different instructions, and a different stance toward the work.

**Exception: tasks.** For tasks (single-phase, quick work), role compression is the default. The Architect and Tech Lead can be the same session. The Developer remains separate. The Orchestrator overhead is minimal — a brief check-in before and after.

### Human Lead

The human. Defines actions, classifies them by tier, sets gatekeeps, and has final authority over everything — approvals, direction, trade-offs. Every review gate in this process exists so the Human Lead can catch mistakes before they become code.

The Human Lead's primary job is defining what success looks like and verifying that it was achieved. They provide the domain context the AI cannot infer, challenge the Architect's assumptions, and decide when a plan is good enough to execute. They also decide when to override the process — skip a phase, combine steps, change direction, promote a task to an epic.

When the Human Lead is also the sole stakeholder, they carry the full weight of gatekeeping. This is by design (see "Human Accountability" above).

**Not an AI role.** This is always a person.

### Senior Architect

Designs the approach. Reads the codebase deeply, writes phase specs, makes architectural decisions. This role has an explicit mandate to **push back** — on the Human Lead's assumptions, on scope, on feasibility. The Architect should challenge, not comply.

**Goal and action definition is collaborative.** The Human Lead comes in with a rough idea; the Architect helps shape it through conversation. For goals, the Architect asks probing questions — which outcomes matter, what "done" means concretely, who decides — and writes GOAL.md with design principles. For epics, the Architect helps refine scope and gatekeep. The Human Lead doesn't need to write a polished action document before involving the Architect — that's part of what the Architect is for.

The Architect also produces phase specs: what problem we're solving, what the approach is, what the steps are, how we'll verify it's correct. The conversation naturally flows from defining the action to planning the roadmap to writing the first phase spec — whether that happens in one session or several doesn't matter. The spec goes to the Human Lead for review before anyone writes code.

**Key behaviour:** broad context, systems thinking, trade-off analysis. The Architect reads the key insights, codebase reference, and source code to hold the big picture.

**Session context:** loads STATUS.md, CONTEXT.md, KEY_INSIGHTS.md (project + active action + active phase), the active action document (GOAL.md, EPIC.md, or TASK.md) and phase spec, and reads relevant source files directly. This is the heaviest context load of any role — the Architect needs it to make sound decisions.

**For tasks:** the Architect is pulled in ad hoc rather than running a formal design session. A quick assessment of the fix, maybe a three-paragraph spec, then hand off to prompts. The Architect and Tech Lead can share a session for tasks.

### Technical Lead

Translates architecture into execution. Takes the Architect's approved spec and writes numbered implementation prompts (see [PROMPTS.md](./PROMPTS.md)). Also reviews the Developer's output — verifying that what was built matches what was specified.

The Technical Lead is the bridge between design and code. They need to understand both the Architect's intent and the Developer's constraints. A good implementation prompt is precise enough that the Developer can execute without guessing, but flexible enough to handle minor codebase surprises.

**Key behaviour:** precision, prompt craft, verification. The Tech Lead writes prompts that name reference implementations, include exact verification commands, and define bounded goals (see [PROMPTS.md](./PROMPTS.md)).

**Session context:** loads the active phase spec, KEY_INSIGHTS.md (action + phase level), and reads the specific source files the prompts will touch. Does not need the full journal — the spec and insights already encode the relevant context.

### Developer

Writes code by following implementation prompts. Each prompt is self-contained — the Developer does not need to read the spec, the plan, or the lessons learned. The prompt has everything.

If the Developer encounters something unexpected, the prompt's **If unexpected** section defines exactly which surprises to handle and which require stopping. When in doubt, the correct response is to **report back to the Technical Lead**, not to improvise. Improvised fixes compound — each one makes the next prompt's assumptions less accurate.

**Key behaviour:** focused execution, discipline, literal prompt-following. The Developer optimises for correctness within the prompt's scope, not for architectural elegance.

**Session context:** loads **only the implementation prompt**. This is the lightest context load of any role. The Developer doesn't need the knowledge base — the prompt has already distilled it into actionable steps.

### Orchestrator

The Human Lead's home base. The Orchestrator provides orientation and guidance: where are we, what just happened, what should happen next. It keeps tracking current, generates handoff prompts, and bridges context between phases and actions.

**When you need the Orchestrator:** at the start of a work day (or after a break), at phase handovers, when you've lost track of where things stand, when resuming a paused action, and when the action is complete. The Orchestrator earns its place at transitions and boundaries — not within the tight loop of implementation.

**When you don't need the Orchestrator:** during implementation, the Tech Lead and Developer pass context to each other through session receipts. If you already know the current state and the next step, go directly to the working role. The Orchestrator is for guidance, not ceremony.

**Primary responsibilities:**

- **Briefing.** When the Human Lead starts work or returns after a break: "bring me up to speed." The Orchestrator reads the journal state and produces a 3–5 line summary: what action we're working on, what tier it is, what phase we're in, what the last session accomplished, what's pending.
- **Guiding next steps.** The Orchestrator doesn't just say where you are — it recommends where to go. "The Architect's spec is approved. Next step: open a Tech Lead session to write prompts. It should load these files: [list]." This reduces gate fatigue — the human doesn't have to carry the process state in their head.
- **Handoff prompts.** When the Human Lead moves between roles, the Orchestrator generates the exact prompt to paste into the next session — which entry point to load, which files to read, what just happened, what the session needs to achieve. This is the Orchestrator's most valuable output — it eliminates the information loss that happens when the human relays context between roles manually.
- **Phase handovers.** When a phase completes, the Orchestrator logs what happened, updates STATUS.md and the journal, and suggests the next move — typically an Architect session to review the outcome and plan the next phase.
- **Tracking hygiene.** The Orchestrator updates STATUS.md and the current week's journal file. It flags when the journal is stale, when decisions haven't been logged, and when journal entries should be promoted to KEY_INSIGHTS.md.
- **Insight promotion.** The Orchestrator identifies journal entries that should become key insights and flags them for the Architect (project/action level) or Tech Lead (phase level) to curate.
- **Bridging promotions.** When an action is promoted (task → epic, epic → goal), the Orchestrator carries context from the original action to the new one via handoff prompts.

**Key behaviour:** operational awareness, guidance, process fidelity. The Orchestrator doesn't design, write prompts, or code. It guides the human and maintains the tracking infrastructure that makes every other role effective.

**Session context:** loads STATUS.md and recent journal files (current + previous week). Light and fast — the Orchestrator reads tracking artefacts, not source code.

### Role Summary

| Role | Responsibility | Session context | Stance |
|---|---|---|---|
| **Human Lead** | Actions, gatekeeps, authority, domain context | — | Decides |
| **Orchestrator** | Guidance, briefing, tracking, handoff prompts, phase handovers | STATUS.md, journal/ (recent weeks) | Guides |
| **Senior Architect** | System design, phase specs, architectural decisions | KEY_INSIGHTS.md (all levels) + CONTEXT.md + source code | Challenges |
| **Technical Lead** | Implementation prompts, code review, verification | Phase spec + KEY_INSIGHTS.md (action + phase) + source files | Translates |
| **Developer** | Code execution, prompt-following | Implementation prompt only | Executes |

---

## Model Tiers

Each AI role has different cognitive demands. Rather than hardcoding specific models (which change frequently), this methodology uses a **tier system**. Map tiers to your current best-available models.

| Tier | Characteristics | Typical roles |
|---|---|---|
| **Tier 1 — Reasoning** | Strongest reasoning, largest context window. Architectural thinking, trade-off analysis, nuanced judgement. | Senior Architect, Technical Lead (complex phases) |
| **Tier 2 — Execution** | Strong code generation, good instruction-following. Fast, cost-effective. | Developer, Technical Lead (straightforward phases), Orchestrator |

**Illustrative mapping (March 2026 — update with your current best-available models):**

| Tier | Example models |
|---|---|
| Tier 1 | Claude Opus 4.6, GPT-4.5, Gemini 2.5 Pro |
| Tier 2 | Claude Sonnet 4.6, GPT-4.1, Gemini 2.5 Flash |

These are examples, not recommendations — the model landscape changes faster than any document can track. The tiers themselves are stable; the models behind them are not. Use whatever you currently consider your strongest reasoning model for Tier 1 and your best execution model for Tier 2.

**When the Technical Lead moves between tiers:** For phases that involve complex refactoring, novel architecture, or ambiguous requirements, the Tech Lead benefits from Tier 1 (writing good prompts for hard problems requires strong reasoning). For phases that follow established patterns — adding a new type that mirrors an existing one, extending a test suite — Tier 2 is sufficient. The Human Lead makes this call per phase.

**Token efficiency is the reason for role separation.** The Developer loads one implementation prompt (~50-100 lines). The Architect loads the full knowledge base (~300+ lines) plus source files. If the Developer loaded Architect-level context, you'd pay for tokens that don't improve code quality. If the Architect loaded Developer-level context, it would miss the big picture. Each role loads exactly what it needs — no more.

---

## The Workflow

This is not vibe coding. Vibe coding is "give the AI a vague idea, let it generate, hope for the best." It works for throwaway prototypes. It does not work for anything you need to maintain, extend, or trust. AI-SDLC is the deliberate opposite: structured intent, human accountability at every gate, and AI constrained by process — not unleashed without it.

### Inception — Project Cold Start

Inception happens once per project, when the workspace doesn't exist yet. It is not a recurring mode — it's the setup step.

**Who you're talking to:** Orchestrator, Senior Architect.

**What happens:**

1. **Human Lead** sets up the workspace (see [SETUP.md](./SETUP.md)).
2. **Orchestrator** creates the journal structure: STATUS.md, KEY_INSIGHTS.md, CONTEXT.md, journal/ folder with the first weekly file, and the actions/ folder.
3. **Senior Architect** writes CONTEXT.md — codebase reference: repo structure, key files, existing patterns.
4. **Human Lead** defines the first action with the **Senior Architect** — collaboratively shaping the problem, scope, and gatekeep.

Once the project is set up, Inception is done. Every action — regardless of tier — enters at Planning.

### Two Modes

After Inception, the project operates in two modes: **Planning** and **Implementation**. At any point, the project is in exactly one mode for exactly one active action. The mode is tracked in STATUS.md (see [TEMPLATES.md](./TEMPLATES.md)), which is the single source of truth for "where are we."

**One active action at a time.** A project may have multiple actions defined, but only one is active. This prevents context scatter — every role knows exactly which action it's serving. If the Human Lead wants to switch actions, they do so explicitly, and the reason for the switch is logged. The Orchestrator updates STATUS.md.

```
Planning ──→ Implementation ──→ Action achieved ──→ Pick next action
    ↑               │
    └───────────────┘
  (phase-level issue)
```

All three tiers follow this cycle. What differs is the weight of each step: a task's Planning is compressed (short spec, maybe no prompt plan), while a goal's Planning involves deep codebase analysis, multi-phase roadmaps, and formal review gates. The modes are the same — the ceremony scales with the tier.

### Planning

**Who you're talking to:** Senior Architect (primarily), Orchestrator (for orientation and handovers).

Planning is where an action gets defined, broken into phases, and each phase gets a spec. This is a conversation between the Human Lead and the Architect — not a rigid sequence of handoffs. A phase is a bounded chunk of work with a clear purpose, concrete steps, and done-criteria. A small epic might have two phases. A large goal might have twelve. A task has exactly one.

**What happens in Planning:**

The Human Lead comes in with a rough idea and works with the Architect to shape it. For goals, this means defining the problem, vision, design principles, and gatekeep collaboratively — the Architect asks probing questions, the Human Lead provides domain context. For epics, the Architect helps refine scope and gatekeep. For tasks, the Architect does a quick assessment. The conversation naturally flows from defining the action to designing the roadmap to writing the first phase spec.

The Architect reads the codebase deeply — relevant source files, tests, configuration, existing patterns. A plan written without reading the code is a guess. Specs should reference specific file paths, show code snippets of current behaviour, and include tables of test cases. Vague plans produce vague code.

The Human Lead reviews and approves the spec (or pushes back — the Architect should defend the design or revise it). Whether this takes one session or several doesn't matter. By the end of Planning, there's an approved action document, a roadmap, and a phase spec.

**Planning for tasks:** compressed. The Architect produces a short spec (a few paragraphs — problem, steps, done-when). The Architect and Tech Lead may share a session. The Human Lead reviews, but the gate is lighter — a task spec doesn't need the same scrutiny as a multi-phase epic.

**When Planning ends:** When the Human Lead approves the phase spec and is ready to move to implementation. The Orchestrator updates STATUS.md: mode switches to Implementation.

### Implementation

**Who you're talking to:** Technical Lead, Developer. Orchestrator at phase handovers.

Implementation is where code gets written. The Tech Lead reads the phase spec, writes implementation prompts, and the Developer executes them. How this loop works — how many prompts, how much review between them, whether prompts are written upfront or one at a time based on session receipts — is a conversation between the Human Lead and the Tech Lead. The process is deliberately freestyle here because the right approach depends on the work.

**The essentials:** The Tech Lead produces prompts. The Developer executes them and produces session receipts — what was done, what files changed, any surprises. The receipts feed the next prompt. This is the context bridge that keeps prompts grounded in the actual state of the code rather than pre-execution assumptions (see [PROMPTS.md](./PROMPTS.md) for just-in-time prompting).

**The Orchestrator stays out of this loop.** The Tech Lead and Developer pass context to each other through session receipts — that's the mechanism. No Orchestrator overhead between prompts. The loop is tight: Tech Lead writes prompt → Developer executes → session receipt → Tech Lead writes next prompt.

**Review cadence — the Human Lead's call:** Some phases warrant reading every prompt before the Developer gets it (high-risk, novel patterns, shared infrastructure). Others are fine with the Tech Lead and Developer cycling through, with the Human Lead reviewing at the end (low-risk, familiar patterns). The Human Lead decides per phase based on risk and complexity.

**Within-phase fixes (stay in Implementation):** If a prompt produces a failing test, a type error, or an unexpected result, the Developer's session receipt captures the issue. The Tech Lead issues a fix prompt — a targeted correction that addresses the specific issue. This is a tight loop.

**Phase-level issues (go back to Planning):** If the approach itself is flawed — assumptions were invalid, a dependency was missed — this is not a prompt fix. The Tech Lead flags it. The Human Lead decides to switch back to Planning. Following the append-forward principle, the revised phase gets a new spec version rather than silently modifying the original.

**Phase handovers:** When a phase is done, the Human Lead evaluates: does it move toward the action's gatekeep? This is where the Orchestrator comes back — it logs what happened, updates STATUS.md and the journal, and suggests the next move (typically an Architect session to review the outcome and plan the next phase). Each phase builds on the previous one's insights and the updated codebase.

### Session Discipline

**Starting a work day or returning after a break:** ask the Orchestrator for a briefing. It reads STATUS.md and the recent journal and tells you where things stand — which action, which phase, what was done last, what's next. If you need to open a new role session, the Orchestrator generates a **handoff prompt** — the exact prompt to paste in, pre-loaded with the right context.

**During implementation:** you don't need the Orchestrator between every prompt. The Tech Lead and Developer cycle through prompts using session receipts as context bridges. Come back to the Orchestrator at phase handovers or when you need orientation.

**Default context by role:**

| Role | Always load | Load on demand | Never load |
|---|---|---|---|
| **Orchestrator** | STATUS.md, journal/ (current + previous week) | Older journal weeks (asks before loading 3+ weeks back) | KEY_INSIGHTS.md, source code, phase specs, impl prompts |
| **Senior Architect** | STATUS.md, CONTEXT.md, KEY_INSIGHTS.md (project + action + phase), active action doc (GOAL/EPIC/TASK.md), active phase spec | Completed phase specs, relevant source files | journal/, impl prompts |
| **Technical Lead** | Active phase spec, KEY_INSIGHTS.md (action + phase), relevant source files | CONTEXT.md, project KEY_INSIGHTS.md | journal/, other phase specs |
| **Developer** | The current implementation prompt | Nothing else | Everything except the prompt |

The Orchestrator refines this per session. "For this Architect session, skip the project KEY_INSIGHTS.md — nothing new since last time. But load the phase 2 spec, because this phase depends on it."

**Tracking updates:** At phase handovers (or whenever you return to the Orchestrator), it updates tracking artefacts: STATUS.md, journal entries, insight promotion flags. The Human Lead verifies and commits. Keeping tracking current means the next session — whenever it happens — starts with accurate context.

### Action Completion and Transition

When all phases for the active action are complete and the Human Lead confirms the gatekeep is met:

1. **Orchestrator** updates STATUS.md — action status → Achieved
2. If other actions are defined, the **Human Lead** picks the next one to activate
3. If no other actions exist, the Human Lead defines what's next

For tasks, completion is often immediate — one phase, gatekeep verified, done. For epics and goals, the Human Lead evaluates the gatekeep across all completed phases before marking the action as achieved.

### Swapping Actions

The Human Lead can switch the active action at any time. This is a deliberate decision, not an accident, and it gets logged:

1. **Human Lead** decides to swap (e.g., a critical bug came in while working on an epic)
2. **Orchestrator** updates STATUS.md — previous action status → Paused (with reason), new action → Active
3. The reason for the swap is logged as a `[decision]` entry in the journal — this context is critical for the next session

When returning to a paused action, the Orchestrator's briefing includes why it was paused and what state it was in when work stopped.

### Staying Current with External Changes

Codebases don't stand still. Other developers push changes, dependencies get updated, CI breaks things, PRs get merged. The project journal — STATUS.md, CONTEXT.md, phase specs — reflects the state of the code at the time it was written, and that state can go stale.

This is a real-world problem, and the methodology doesn't pretend it doesn't exist. The solution isn't a special process — it's the same discipline you'd apply as a senior developer: stay current.

**When starting any new action,** ask the Orchestrator to check for recent external changes that might be relevant. The Orchestrator can read the git log of the code repo, compare it against what CONTEXT.md describes, and flag anything that looks like it could affect the current work. This takes a minute and can save hours of building on stale assumptions.

**When resuming a paused action,** the same check applies — possibly more urgently. The longer an action has been paused, the more the codebase may have drifted. The Orchestrator's briefing should include whether significant changes have landed since work was paused.

**When CONTEXT.md goes stale,** the Architect updates it. This isn't a special event — it's part of the Architect's normal session if the codebase structure has changed. The Orchestrator flags when it suspects CONTEXT.md is out of date.

The journal captures everything that happens within the process. It doesn't capture what happens outside it. Bridging that gap is a human responsibility — and the Orchestrator's briefing routine is the natural place to surface it.

---

## Scaling the Process

The methodology uses one structure for all projects. The three tiers mean the process naturally scales to the work — tasks are light, epics are moderate, goals are heavyweight. There is no "lite mode" or "full mode" to choose between. The Human Lead picks the tier that matches the work, and the process adjusts.

A project that's mostly bug fixes and small features will have many tasks and few goals. A project in active development will have a mix. A greenfield project might start with a goal to establish direction and then break into epics and tasks as the architecture solidifies.

### What Scales Naturally

- **Actions** — more work means more action folders. Each is self-contained. The naming convention (`task-*`, `epic-*`, `goal-*`) makes the tier visible at a glance.
- **Journal** — weekly rolling files mean the journal grows without becoming unwieldy. The Orchestrator loads recent weeks; old weeks are there for history.
- **Key insights** — insights accumulate at each level. Phase-level insights stay relevant during that phase; action-level insights persist across phases; project-level insights persist across actions. As the project grows, the insight hierarchy captures the knowledge that matters.

### Role Compression

For tasks and small epics (1–3 phases), the Senior Architect, Technical Lead, and Orchestrator can be the same AI session. The separation between design, prompt-writing, and tracking still happens — it's just sequential within one session. The Developer remains a separate session.

For goals and complex epics, full role separation is recommended. The cognitive demands are different enough that combining roles degrades output.

### The Non-Negotiables

Regardless of action tier, these are never skipped:

- **An action defined before work starts.** Every piece of work has a TASK.md, EPIC.md, or GOAL.md — even if it's three lines.
- **A gatekeep for every action.** Tasks get concrete verification. Epics get measurable conditions. Goals get human-judged criteria. But every action has a definition of done.
- **STATUS.md is always current.** The single source of truth for mode, active action, and next action.
- **A written spec before code.** Every phase has a spec — even a task's single phase.
- **Journal entries.** Every session, every decision, every lesson — tagged and logged in the current week's journal file. The cost is ten seconds; the value compounds.
- **Key insights curated.** When a journal entry proves important beyond its session, it gets promoted to KEY_INSIGHTS.md at the right level. This is how the AI gets better at your project over time.
- **Review gate between planning and execution.** The Human Lead approves the plan before the Developer writes code.
- **Role separation between design and execution.** The Architect/Tech Lead session and the Developer session are always separate — even for tasks.
- **Tracking updated at phase handovers.** STATUS.md and the journal reflect what happened. The cost is minutes; the value compounds across sessions.

---

## Anti-Patterns

### "Just do it"

Skipping the planning step because "it's a small change." Small changes that touch shared infrastructure are where the worst bugs hide. If it touches more than one file or changes behaviour, it deserves at least a task with a short spec — even a three-paragraph one.

### Amnesia sessions

Starting a new AI session without loading context. The AI will contradict previous decisions, reintroduce rejected patterns, or redo completed work. The context loading protocol exists for this reason — and each role has a specific loading recipe (see the context loading table above).

### The 500-line status file

Putting implementation detail in STATUS.md instead of phase specs. STATUS.md is for current state and the roadmap — action table, phase table, links, status. All detail lives in the phase specs and implementation prompts.

### Silent plan changes

Revising a spec without logging what changed. The next session reads the plan assuming it's the original and misses the context for why it was revised. Follow the append-forward principle: create a new version of the spec, log the decision in the journal. The old version stays as the record of what was believed at the time.

### Snapshot testing as a shortcut

Using snapshot tests instead of targeted assertions. Snapshots break on incidental changes and don't communicate intent. They give a false sense of coverage without proving behaviour is preserved.

### The green bar illusion

AI-generated tests that pass without asserting anything meaningful. `expect(result).toBeDefined()` proves nothing. `expect(result).toBeTruthy()` on an object that's always truthy proves nothing. When an AI writes tests, verify that the assertions are specific: exact property values, exact array lengths, exact types, exact error messages. If the test would still pass with a completely wrong implementation, it's not a test.

This is the most common AI testing failure mode. The AI optimises for green — a passing test suite — not for coverage of actual behaviour. Treat AI-generated tests with the same scrutiny you'd give a junior developer's first PR.

### Testing after the fact

Writing a separate "add tests" phase after features are built. Tests are part of the definition of done for each phase. A feature without tests is incomplete. Before any refactor that moves code between modules, write tests that assert current behaviour — run them before and after. If they pass without changes to the test files, the refactor preserved behaviour.

### The improvising Developer

A Developer session that encounters something unexpected and decides to "fix it" without going back to the Technical Lead. The Developer's job is to follow the prompt. If the prompt doesn't account for the current state of the code, the correct response is to report back, not to improvise. Improvised fixes compound — each one makes the next prompt's assumptions less accurate.

### Role bleed

Running the Architect and Developer in the same session "to save time." The Architect's job is to challenge assumptions and think broadly. The Developer's job is to follow instructions precisely. These are opposing mindsets. When combined in one session, the AI either over-thinks execution (slow, over-engineered) or under-thinks design (quick, brittle). Keep them separate.

### Misclassifying tiers

Treating everything as a task to avoid process overhead. If the work needs multiple phases, it's an epic. If the outcome requires abstract thinking, it's a goal. Forcing heavyweight work through a lightweight tier means skipping the planning that would have caught problems early. Conversely, treating a simple bug fix as a goal wastes time on ceremony that adds no value. Pick the tier honestly.
