# AI-SDLC: Process Guide

> A methodology for AI-assisted software development.
> Derived from real project experience. Tool-agnostic — works with any AI coding assistant.
>
> **For AI sessions:** Do not load this document into AI sessions. Each AI stance has its own
> entry point in [`roles/`](./roles/) that contains exactly what it needs — nothing more.
> This document is for you — the human — to understand the full methodology.
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

A junior developer will struggle with this methodology — not because of its complexity, but because every review gate requires you to evaluate AI output with experienced judgement. When the Architect produces a phase spec, you need to know whether the approach is sound. When the Developer produces code, you need to spot the subtle bugs that pass the tests. When the AI pushes back on your goal, you need to know when it's right and when it's wrong. These are senior skills. The process amplifies them; it doesn't replace them.

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

This methodology demands more from you, not less.

The AI handles production — planning, writing code, generating tests, producing artefacts, and all the bookkeeping that holds the process together: journal entries, STATUS.md updates, key insights, session receipts. The AI writes; you don't. But you own every decision, and ownership lives in review.

Every plan passes through your review before it becomes code. Every insight the AI writes gets your scrutiny before it joins the knowledge base. Every gatekeep requires your judgement — not the AI's assertion that it's done. The AI is the workforce. You are the authority. And authority means active review, not passive approval.

You are typically both the lead and the sole stakeholder — which means there is no one else to defer to. The gatekeep "my own approval" means you are accountable for the quality of what ships. This is not a limitation of the process. It is the point. AI-SDLC exists to empower you through AI, not to replace your judgement with AI output.

**This is where the process makes its real demand.** When the AI produces a phase spec, you need to evaluate whether the approach is sound — not skim it and approve. When the AI writes a journal entry, you need to verify it captured what actually happened — not assume it did. When the AI writes a key insight, you need to judge whether it's specific enough to be useful and placed at the right level — not let it accumulate unchecked. The AI generates volume. You supply the judgement that makes the volume valuable.

This is a partnership driven by you. If you disengage — rubber-stamp plans without reading them, skip review gates, accept AI output without scrutiny — the process breaks. The methodology is only as strong as the person driving it.

### Append-Forward

The project journal moves forward, never backward. When a plan changes, the new plan is a new artefact. The old plan stays as the record of what was believed at the time. When a task outgrows its scope, the task stays as-is and a new epic or goal is created to continue the work. Promotion, revision, and abandonment are all forward moves — new entries, new files, new journal notes.

This principle exists because rewriting history breaks the context chain. If a spec gets silently edited, the journal entries that reference it no longer make sense. If a task folder gets renamed or restructured, references go stale. By always moving forward — creating new artefacts rather than mutating old ones — every past reference remains valid, and the journal tells a truthful story.

The only file that genuinely mutates is STATUS.md, and even that is just pointer updates: which action is active, which phase, which prompt. Everything else is append-only.

---

## Actions — The Unit of Work

Everything in AI-SDLC is an **action**. An action is a human-defined piece of work with a clear outcome. You create actions, classify them by tier, and drive them to completion.

There are three tiers: **Task**, **Epic**, and **Goal**. The tier determines how much ceremony the action gets — but the underlying machinery is the same. All actions live in the `actions/` folder, all follow the same phase-based execution model, and all produce journal entries and insights.

### The Three Tiers

**Task** — a bounded, concrete piece of work. One phase, one to three prompts, done in a session or two. "Fix the login redirect bug." "Add a loading spinner to the dashboard." "Update the date format in the export CSV."

You already know what's wrong and what done looks like. The gatekeep is concrete and verifiable: the bug is fixed, the spinner appears, the date format is correct. Stance compression is the default — Architect thinking might get pulled in ad hoc if the fix turns out to be trickier than expected, but there's no formal design phase. You'll often flow between Architect and Tech Lead thinking in the same conversation. The process is deliberately loose because tasks are meant to be quick.

A task has a TASK.md (lightweight — problem statement and done-when criteria) and a single phase folder with a spec and implementation prompts.

**Epic** — a multi-phase piece of work with a concrete, measurable outcome. "Refactor the validation pipeline to use a lookup table." "Add OAuth2 support to the API." "Migrate the test suite from Jest to Vitest."

An epic gets full Planning and Implementation. The outcome is tangible — the refactor is done, the feature works, the migration is complete. The gatekeep is concrete: specific conditions that can be verified without subjective judgement. The Architect designs the phases, the Tech Lead writes the prompts, the Developer executes them. Full stance separation is optional — compression is the default for most epics.

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
| **Stance compression** | Default | Optional | Full separation |
| **Prompt plan** | Optional (1–2 prompts may not need one) | Yes | Yes |
| **Action document** | TASK.md (lightweight) | EPIC.md (problem + concrete gatekeep) | GOAL.md (problem + vision + principles + abstract gatekeep) |

### Choosing a Tier

You pick the tier when creating the action. The right tier is usually obvious:

- "Fix this bug" → **Task**
- "Add this feature" → **Epic** (unless the feature is trivial — then task)
- "Redesign how users interact with X" → **Goal**

When it's ambiguous, start with the lighter tier. A task that outgrows its scope can be promoted (see below). Starting heavy and discovering you over-planned is more wasteful than starting light and promoting when needed.

### Promotion

When a task turns out to need a second phase, it's no longer a task — it's an epic. When an epic's gatekeep turns out to require subjective evaluation, it's a goal.

**Promotion follows the append-forward principle.** The original action stays as-is. A new action is created at the higher tier. The journal captures the promotion decision: what was the original action, why it's being promoted, and what the new action needs to accomplish. The AI bridges the context — whether via Navigator stance for a formal briefing or simply carrying it forward in the same session.

A promoted task's TASK.md is never modified. The new epic's EPIC.md references the original task ("Promoted from task-login-bug — see journal 2026-W11"). The relevant context carries over through the journal and the AI's continuity.

The promotion triggers:

- **Task → Epic:** the fix needs a second phase, or the scope touches shared architecture
- **Epic → Goal:** the gatekeep becomes subjective, or the outcome needs abstract vision-setting

### One Active Action at a Time

A project may have many actions defined, but only one is active. This prevents context scatter — the AI always knows which action it's serving. The active action and its tier are tracked in STATUS.md.

If you want to switch actions, do so explicitly. Update STATUS.md and log the reason in the journal. When returning to a paused action, the journal captures why it was paused and what state it was in — the AI can surface this when asked.

---

## Gatekeeping

Every action has a gatekeep — but the nature of the gatekeep varies by tier.

**Task gatekeeps** are binary. The bug is fixed or it isn't. The spinner appears or it doesn't. Tests pass. "Done" is obvious. You verify by looking at the result.

**Epic gatekeeps** are concrete and measurable, but may involve multiple conditions. "The switch statements are removed, all existing tests pass, the API is backward-compatible, and the new lookup table handles all 12 registered types." You verify against the checklist.

**Goal gatekeeps** involve human judgement. They name who decides and what they're evaluating, even if the criteria are subjective. "I'm satisfied that the demo narrative is clear and progressive." "Three beta users complete the onboarding task without asking for help." The discipline is in identifying the person accountable, not in quantifying every metric.

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

If you cannot define a gatekeep, the action is probably scoped wrong. A task with no clear "done" condition should probably be refined. An epic where "done" is subjective should probably be a goal. A goal where "done" can't be articulated at all is a signal to stop and think — not to start planning.

---

## Roles

This is a solo practitioner's framework. You — the human — are the only person. The AI is your tool, and you direct it by shifting between cognitive stances. The "roles" are not people or separate agents. They are **framing techniques** — telling the AI "you are an Architect, challenge assumptions" produces genuinely different output than "you are a Developer, follow this prompt." Different stances produce different thinking. That's the entire mechanism.

There are four AI stances: **Architect** (design), **Tech Lead** (prompt craft), **Developer** (execution), and **Navigator** (orientation). All share a common foundation (`roles/common.md`) that handles journal writing, key insight management, and STATUS.md updates. Each stance adds its specific focus on top.

**In practice, you'll usually stay in one session and shift stances as the conversation flows.** You discuss the design (Architect thinking), then translate it into prompts (Tech Lead thinking), then execute (Developer thinking) — all in the same conversation. This is the default. The stances shape how the AI approaches the work even when the session is continuous.

**When separate sessions earn their cost:**

- **The Developer on complex work.** A fresh session — loading only the implementation prompt, with no memory of the design discussion — produces more disciplined, literal output. For high-risk work, a clean session is worth the overhead.
- **When you notice stance pollution.** If the Architect starts writing implementation details instead of designing systems, or the Developer starts second-guessing prompts, that's a signal that physical separation would help.
- **Goals with deep design work.** The full Architect → Tech Lead → Developer pipeline in separate sessions produces the cleanest output for work that demands genuine systems thinking.

**Separate sessions are the escalation path, not the default.** Most work — especially tasks and straightforward epics — runs fine in a single session with stance shifts. You'll know when to escalate because the output quality tells you.

### You — The Human Lead

You define actions, classify them by tier, set gatekeeps, and have final authority over everything — approvals, direction, trade-offs. Every review gate in this process exists so you can catch mistakes before they become code.

Your primary job is defining what success looks like and verifying that it was achieved. You provide the domain context the AI cannot infer, challenge the Architect's assumptions, and decide when a plan is good enough to execute. You also decide when to override the process — skip a phase, combine steps, change direction, promote a task to an epic.

**You decide session boundaries.** When to open a fresh session for a stance, when to shift stances within the same conversation, when to ask the AI for a Navigator-style briefing versus just asking "where are we?" This is a judgement call informed by the work's complexity and the output quality you're seeing.

**You review key insights.** The AI writes insights directly to KEY_INSIGHTS.md (per common.md) regardless of which stance it's in. You review these as they appear — revising, removing, or promoting insights that don't hold up or that apply more broadly than the AI realized.

You carry the full weight of gatekeeping. This is by design (see "Human Accountability" above).

### Architect Stance

The design stance. When you frame the AI as Architect, it reads the codebase deeply, writes phase specs, and makes architectural decisions. It has an explicit mandate to **push back** — on your assumptions, on scope, on feasibility. The Architect should challenge, not comply.

**Action definition is collaborative.** You come in with a rough idea; the Architect helps shape it through conversation. For goals, it asks probing questions — which outcomes matter, what "done" means concretely, who decides — and writes GOAL.md with design principles. For epics, it helps refine scope and gatekeep. You don't need a polished action document before starting — shaping it is what this stance is for.

The Architect also produces phase specs: what problem you're solving, what the approach is, what the steps are, how you'll verify it's correct. The conversation naturally flows from defining the action to planning the roadmap to writing the first phase spec. The spec goes to you for review before any code gets written.

**Key behaviour:** broad context, systems thinking, trade-off analysis. The Architect reads the key insights, codebase reference, and source code to hold the big picture.

**Context focus:** STATUS.md, CONTEXT.md, KEY_INSIGHTS.md (project + active action + active phase), the active action document (GOAL.md, EPIC.md, or TASK.md) and phase spec, plus relevant source files. This is the heaviest context load of any stance — the Architect needs it to make sound decisions.

**For tasks:** the Architect is a quick assessment, not a formal design session. A few paragraphs of spec, then shift to writing prompts. You'll often flow from Architect thinking into Tech Lead thinking in the same conversation.

### Tech Lead Stance

The translation stance. When you shift the AI to Tech Lead, it takes the approved spec and writes numbered implementation prompts (see [PROMPTS.md](./PROMPTS.md)). It also reviews execution output — verifying that what was built matches what was specified.

This stance bridges design and code. A good implementation prompt is precise enough that the Developer stance can execute without guessing, but flexible enough to handle minor codebase surprises. In practice, you'll often flow into Tech Lead thinking naturally after the Architect conversation — the shared context helps the AI write better prompts because it was part of the design discussion.

**Key behaviour:** precision, prompt craft, verification. The Tech Lead writes prompts that name reference implementations, include exact verification commands, and define bounded goals (see [PROMPTS.md](./PROMPTS.md)).

**Context focus:** the active phase spec, KEY_INSIGHTS.md (action + phase level), and the specific source files the prompts will touch. Does not need the full journal — the spec and insights already encode the relevant context.

### Developer Stance

The execution stance. When you frame the AI as Developer, it writes code by following an implementation prompt. Each prompt is self-contained — the Developer does not need the spec, the plan, or the lessons learned. The prompt has everything.

If the Developer encounters something unexpected, the prompt's **If unexpected** section defines exactly which surprises to handle and which require stopping. When in doubt, the correct response is to **report back** (to you, so you can shift to Tech Lead thinking), not to improvise. Improvised fixes compound — each one makes the next prompt's assumptions less accurate.

**Key behaviour:** focused execution, discipline, literal prompt-following. The Developer optimises for correctness within the prompt's scope, not for architectural elegance.

**Context focus:** **only the implementation prompt**. This is the lightest context load of any stance. The Developer doesn't need the knowledge base — the prompt has already distilled it into actionable steps. For complex work, consider running the Developer in a fresh session — an AI with no memory of the design discussion produces more disciplined, literal output.

### Navigator Stance

The orientation stance. You invoke this when you need the AI to answer: where are we, what just happened, what should happen next. It's the lightest stance — purely advisory, no upkeep responsibilities.

**When to use the Navigator stance:**

- Returning after a long break or resuming a paused action — context is cold and needs synthesizing
- Bridging promotions (task → epic, epic → goal) — carrying context from the original action forward
- When you've genuinely lost track and need a clean briefing
- When a transition requires judgment about the smartest next move

**When you don't need it:**

- Quick status checks — ask the AI in whatever stance it's in, or read STATUS.md yourself
- Simple phase handovers — the AI updates STATUS.md per common.md regardless of stance
- During implementation — the execution loop is self-contained

**What the Navigator produces:**

- **Briefing** — a 3–5 line summary from STATUS.md and the journal: what action, what tier, what phase, what happened last, what's next.
- **Next-step advice** — not just "where are we" but "where should we go." Which stance to shift to, which files it should load, whether the current spec still makes sense.
- **Handoff prompts** — when you open a fresh session, the Navigator generates the exact prompt to paste in: entry points to load, files to read, context to carry over. (If you're staying in the same session, a brief context summary is enough.)
- **External change checks** — reading the code repo's git log and flagging codebase drift that might affect the current plan.

**Key behaviour:** process-level judgment, orientation, guidance. The Navigator doesn't design, write prompts, or code.

**Context focus:** STATUS.md and recent journal files (current + previous week). Light and fast — tracking artefacts, not source code.

### Curator Stance

The knowledge maintenance stance. The Curator reads everything — journals, insights at all levels, completed specs, session receipts — and proposes editorial actions on the project's accumulated knowledge. It identifies stale insights, promotes lessons that apply more broadly than where they were first captured, retires knowledge that's no longer relevant, and flags gaps where important patterns were learned but never written down.

**When to use the Curator stance:**

- Periodically during a long-running epic or goal — when journal entries have accumulated across several phases and the insight files may have drifted from what's actually true
- After completing an action — to distill what was learned into insights that will serve the next action
- When you notice the AI making mistakes that a previous session already caught — this is a signal that the insight wasn't captured or was captured at the wrong level
- When starting a new project that shares patterns with a completed one — the Curator can identify which insights should carry over

**What the Curator produces:**

- **Insight audit** — a review of all KEY_INSIGHTS.md files (project, action, phase), flagging which insights are stale, which should be promoted to a higher level, which should be retired, and which are missing
- **Promotion recommendations** — specific insights that have proven applicable beyond their original scope, with proposed text for the higher-level file
- **Journal distillation** — scanning recent journal entries for lessons and decisions that haven't been captured as insights yet
- **Cross-action patterns** — identifying recurring themes across completed actions that should become project-level insights

**Key behaviour:** editorial judgment, pattern recognition, knowledge organization. The Curator thinks like a senior architect reviewing what the project has learned — not what to build next, but what to remember.

**Context focus:** KEY_INSIGHTS.md (all levels), journal/ (all available weeks), completed action documents and specs. The Curator has the broadest read access of any stance — it needs to see everything to judge what matters. It does not read source code directly; it reads what the other stances wrote about the source code.

**The Curator proposes; you decide.** Like the Navigator, the Curator is purely advisory. It recommends editorial changes to the insight files — you review and approve them. This keeps the human in control of what the project "knows" while offloading the editorial labor of maintaining the knowledge hierarchy.

### Common Foundation

All AI stances share a common foundation (`roles/common.md`) that defines:

- **Journal writing** — the AI logs `[session]`, `[decision]`, and `[lesson]` entries as part of its normal output, regardless of stance
- **Key insight management** — the AI writes insights directly to the appropriate KEY_INSIGHTS.md, decides the level (phase, action, project), and scans for insights from lower levels to promote
- **STATUS.md updates** — the AI updates STATUS.md when its work changes the project state
- **Orientation** — the AI can answer "where are we?" by reading STATUS.md and the recent journal, in any stance

You review insights as they appear and maintain final authority over what stays.

### Stance Summary

| Stance | Focus | Context | Behaviour | When to separate sessions |
|---|---|---|---|---|
| **Architect** | System design, phase specs, architectural decisions | KEY_INSIGHTS.md (all levels) + CONTEXT.md + source code | Challenges | Rarely — shares well with Tech Lead |
| **Tech Lead** | Implementation prompts, code review, verification | Phase spec + KEY_INSIGHTS.md (action + phase) + source files | Translates | Rarely — benefits from Architect context |
| **Developer** | Code execution, prompt-following | Implementation prompt only | Executes | Often — clean context produces disciplined output |
| **Navigator** | Orientation, briefing, handoff prompts, external change checks | STATUS.md + journal/ (recent weeks) | Guides | When context is cold |
| **Curator** | Knowledge maintenance, insight audit, journal distillation | KEY_INSIGHTS.md (all levels) + journal/ (all weeks) + completed specs | Curates | Dedicated session recommended |

---

## Model Tiers

Each AI stance has different cognitive demands. Rather than hardcoding specific models (which change frequently), this methodology uses a **tier system**. Map tiers to your current best-available models.

| Tier | Characteristics | Typical stances |
|---|---|---|
| **Tier 1 — Reasoning** | Strongest reasoning, largest context window. Architectural thinking, trade-off analysis, nuanced judgement. | Architect, Tech Lead (complex phases) |
| **Tier 2 — Execution** | Strong code generation, good instruction-following. Fast, cost-effective. | Developer, Tech Lead (straightforward phases), Navigator |
| **Tier 1 — Reasoning** (periodic) | Broad context, editorial judgment, pattern recognition across history. | Curator |

**Illustrative mapping (March 2026 — update with your current best-available models):**

| Tier | Example models |
|---|---|
| Tier 1 | Claude Opus 4.6, GPT-4.5, Gemini 2.5 Pro |
| Tier 2 | Claude Sonnet 4.6, GPT-4.1, Gemini 2.5 Flash |

These are examples, not recommendations — the model landscape changes faster than any document can track. The tiers themselves are stable; the models behind them are not. Use whatever you currently consider your strongest reasoning model for Tier 1 and your best execution model for Tier 2.

**When the Tech Lead moves between tiers:** For phases that involve complex refactoring, novel architecture, or ambiguous requirements, the Tech Lead benefits from Tier 1 (writing good prompts for hard problems requires strong reasoning). For phases that follow established patterns — adding a new type that mirrors an existing one, extending a test suite — Tier 2 is sufficient. You make this call per phase.

**Token efficiency is one benefit of session separation.** The Developer loads one implementation prompt (~50-100 lines). The Architect loads the full knowledge base (~300+ lines) plus source files. In separate sessions, each stance loads exactly what it needs — no more. In a shared session, the model carries everything it's seen, which costs tokens and can influence behaviour. You weigh this against the cost of context loss from handoff prompts — and decide per phase.

---

## The Workflow

This is not vibe coding. Vibe coding is "give the AI a vague idea, let it generate, hope for the best." It works for throwaway prototypes. It does not work for anything you need to maintain, extend, or trust. AI-SDLC is the deliberate opposite: structured intent, human accountability at every gate, and AI constrained by process — not unleashed without it.

### Inception — Project Cold Start

Inception happens once per project, when the workspace doesn't exist yet. It is not a recurring mode — it's the setup step.

**Stance:** Architect.

**What happens:**

1. You set up the workspace (see [SETUP.md](./SETUP.md)) and create the journal structure: STATUS.md, KEY_INSIGHTS.md, CONTEXT.md, journal/ folder with the first weekly file, and the actions/ folder.
2. The AI (in Architect stance) writes CONTEXT.md — codebase reference: repo structure, key files, existing patterns.
3. You define the first action with the Architect — collaboratively shaping the problem, scope, and gatekeep.

Once the project is set up, Inception is done. Every action — regardless of tier — enters at Planning.

### Two Modes

After Inception, the project operates in two modes: **Planning** and **Implementation**. At any point, the project is in exactly one mode for exactly one active action. The mode is tracked in STATUS.md (see [TEMPLATES.md](./TEMPLATES.md)), which is the single source of truth for "where are we."

**One active action at a time.** A project may have multiple actions defined, but only one is active. This prevents context scatter — the AI always knows which action it's serving. If you want to switch actions, do so explicitly — update STATUS.md and log the reason in the journal.

```
Planning ──→ Implementation ──→ Action achieved ──→ Pick next action
    ↑               │
    └───────────────┘
  (phase-level issue)
```

All three tiers follow this cycle. What differs is the weight of each step: a task's Planning is compressed (short spec, maybe no prompt plan), while a goal's Planning involves deep codebase analysis, multi-phase roadmaps, and formal review gates. The modes are the same — the ceremony scales with the tier.

### Planning

**Stance:** Architect (primarily).

Planning is where an action gets defined, broken into phases, and each phase gets a spec. This is a conversation between you and the AI in Architect stance — not a rigid sequence of handoffs. A phase is a bounded chunk of work with a clear purpose, concrete steps, and done-criteria. A small epic might have two phases. A large goal might have twelve. A task has exactly one.

**What happens in Planning:**

You come in with a rough idea and work with the Architect to shape it. For goals, this means defining the problem, vision, design principles, and gatekeep collaboratively — the Architect asks probing questions, you provide domain context. For epics, the Architect helps refine scope and gatekeep. For tasks, the Architect does a quick assessment. The conversation naturally flows from defining the action to designing the roadmap to writing the first phase spec.

The Architect reads the codebase deeply — relevant source files, tests, configuration, existing patterns. A plan written without reading the code is a guess. Specs should reference specific file paths, show code snippets of current behaviour, and include tables of test cases. Vague plans produce vague code.

You review and approve the spec (or push back — the Architect should defend the design or revise it). Whether this takes one session or several doesn't matter. By the end of Planning, there's an approved action document, a roadmap, and a phase spec.

**Planning for tasks:** compressed. The Architect produces a short spec (a few paragraphs — problem, steps, done-when). You'll often flow straight from design into writing prompts in the same conversation. The gate is lighter — a task spec doesn't need the same scrutiny as a multi-phase epic.

**When Planning ends:** When you approve the phase spec and are ready to move to implementation. The AI updates STATUS.md: mode switches to Implementation.

### Implementation

**Stances:** Tech Lead, Developer.

Implementation is where code gets written. In Tech Lead stance, the AI reads the phase spec and writes implementation prompts. In Developer stance, it executes them. How this loop works — how many prompts, how much review between them, whether prompts are written upfront or one at a time — is your call. The process is deliberately freestyle here because the right approach depends on the work.

**In a single session (the default),** this is fluid. You discuss the prompt approach with the AI (Tech Lead thinking), then tell it to execute (Developer thinking). The AI naturally carries the context forward. When it finishes executing, it produces a session receipt — what was done, what files changed, any surprises — and you discuss the next prompt. The stances shape the AI's focus even when the session is continuous.

**In separate sessions (for complex work),** the loop is more formal. You write or review a prompt in one session (Tech Lead), then paste it into a fresh session (Developer) for execution. The session receipt bridges the gap — it captures the actual state of the code so the next prompt is grounded in reality rather than pre-execution assumptions (see [PROMPTS.md](./PROMPTS.md) for just-in-time prompting).

**Review cadence — your call:** Some phases warrant reading every prompt before execution (high-risk, novel patterns, shared infrastructure). Others are fine with the AI cycling through prompts, with you reviewing at the end (low-risk, familiar patterns). You decide per phase based on risk and complexity.

**Within-phase fixes (stay in Implementation):** If a prompt produces a failing test, a type error, or an unexpected result, the session receipt captures the issue. A fix prompt — a targeted correction — addresses it. This is a tight loop.

**Phase-level issues (go back to Planning):** If the approach itself is flawed — assumptions were invalid, a dependency was missed — this is not a prompt fix. You switch back to Planning. Following the append-forward principle, the revised phase gets a new spec version rather than silently modifying the original.

**Phase handovers:** When a phase is done, you evaluate: does it move toward the action's gatekeep? The AI logs what happened and updates STATUS.md (per common.md). The typical next move is to shift back to Architect thinking — review the outcome and plan the next phase. If context has gone cold or the transition is complex, use the Navigator stance for a briefing. Each phase builds on the previous one's insights and the updated codebase.

### Session Discipline

**Starting a work day or returning after a break:** get oriented. Ask the AI "where are we?" — it can read STATUS.md and the journal in any stance per common.md. If context has gone truly cold (returning after weeks, resuming a paused action), use the Navigator stance for a proper briefing.

**During implementation:** the loop between writing prompts and executing them is tight and self-contained. In a single session, this is just a flowing conversation. In separate sessions, session receipts bridge the gap.

**Context focus by stance:**

| Stance | Primary focus | On demand | Exclude |
|---|---|---|---|
| **Architect** | STATUS.md, CONTEXT.md, KEY_INSIGHTS.md (project + action + phase), active action doc (GOAL/EPIC/TASK.md), active phase spec | Completed phase specs, relevant source files | impl prompts |
| **Tech Lead** | Active phase spec, KEY_INSIGHTS.md (action + phase), relevant source files | CONTEXT.md, project KEY_INSIGHTS.md | other phase specs |
| **Developer** | The current implementation prompt | Nothing else | Everything except the prompt |
| **Navigator** | STATUS.md, journal/ (current + previous week) | Older journal weeks, git log | KEY_INSIGHTS.md, source code, phase specs, impl prompts |
| **Curator** | KEY_INSIGHTS.md (all levels), journal/ (all weeks), completed action docs and specs | CONTEXT.md | Source code, impl prompts |

In a single session, the AI has seen everything from prior stances — the table defines what each stance *focuses on*, not what it can see. Be aware that a Developer stance in the same session as a prior Architect conversation carries that context. For complex work, a fresh Developer session produces more disciplined output.

**Tracking updates:** The AI handles its own tracking per common.md — journal entries, STATUS.md updates, insight writing — regardless of stance. Your job is not to produce these artefacts but to verify them: scan the journal entry for accuracy, check that STATUS.md reflects reality, review insights for specificity. The mechanism matters less than the discipline: keeping tracking current *and accurate* means the next session starts with trustworthy context.

### Action Completion and Transition

When all phases for the active action are complete and you've confirmed the gatekeep is met:

1. The AI updates STATUS.md — action status → Achieved
2. If other actions are defined, you pick the next one to activate
3. If no other actions exist, you define what's next

For tasks, completion is often immediate — one phase, gatekeep verified, done. For epics and goals, you evaluate the gatekeep across all completed phases before marking the action as achieved.

### Swapping Actions

You can switch the active action at any time. This is a deliberate decision, not an accident, and it gets logged:

1. You decide to swap (e.g., a critical bug came in while working on an epic)
2. The AI updates STATUS.md — previous action status → Paused (with reason), new action → Active
3. The reason for the swap is logged as a `[decision]` entry in the journal — this context is critical for the next session

When returning to a paused action, the journal captures why it was paused and what state it was in. Use the Navigator stance for a briefing if context has gone cold.

### Staying Current with External Changes

Codebases don't stand still. Other developers push changes, dependencies get updated, CI breaks things, PRs get merged. The project journal — STATUS.md, CONTEXT.md, phase specs — reflects the state of the code at the time it was written, and that state can go stale.

This is a real-world problem, and the methodology doesn't pretend it doesn't exist. The solution isn't a special process — it's the same discipline you'd apply as a senior developer: stay current.

**When starting any new action,** check for recent external changes. The AI can read the git log and compare it against CONTEXT.md — in Navigator stance for a quick check, or in Architect stance as part of its normal codebase read. This takes a minute and can save hours of building on stale assumptions.

**When resuming a paused action,** the same check applies — possibly more urgently. The longer an action has been paused, the more the codebase may have drifted.

**When CONTEXT.md goes stale,** the AI updates it in Architect stance. This isn't a special event — it's part of the Architect's normal work if the codebase structure has changed.

The journal captures everything that happens within the process. It doesn't capture what happens outside it. Bridging that gap is a human responsibility.

---

## Scaling the Process

The methodology uses one structure for all projects. The three tiers mean the process naturally scales to the work — tasks are light, epics are moderate, goals are heavyweight. There is no "lite mode" or "full mode" to choose between. You pick the tier that matches the work, and the process adjusts.

A project that's mostly bug fixes and small features will have many tasks and few goals. A project in active development will have a mix. A greenfield project might start with a goal to establish direction and then break into epics and tasks as the architecture solidifies.

### What Scales Naturally

- **Actions** — more work means more action folders. Each is self-contained. The naming convention (`task-*`, `epic-*`, `goal-*`) makes the tier visible at a glance.
- **Journal** — weekly rolling files mean the journal grows without becoming unwieldy. Recent weeks are loaded by the active stance; old weeks are there for history.
- **Key insights** — insights accumulate at each level. Phase-level insights stay relevant during that phase; action-level insights persist across phases; project-level insights persist across actions. As the project grows, the insight hierarchy captures the knowledge that matters.

### Stance Compression

**A single session with stance shifts is the default.** For tasks and small epics, flow naturally between Architect and Tech Lead thinking in one conversation — the shared context helps. The Developer can stay in the same session for low-risk work or get a fresh session when disciplined prompt-following matters. Use the Navigator stance only when context has gone cold.

**Separate sessions are the escalation path.** For goals and complex epics where you notice stance pollution — the Architect over-specifying implementation, the Developer second-guessing prompts — separate them physically. You make this call based on what you're seeing in the output, not based on a blanket rule.

### The Non-Negotiables

Regardless of action tier, these are never skipped:

- **An action defined before work starts.** Every piece of work has a TASK.md, EPIC.md, or GOAL.md — even if it's three lines.
- **A gatekeep for every action.** Tasks get concrete verification. Epics get measurable conditions. Goals get human-judged criteria. But every action has a definition of done.
- **STATUS.md is always current.** The single source of truth for mode, active action, and next action.
- **A written spec before code.** Every phase has a spec — even a task's single phase.
- **Journal entries.** Every session, every decision, every lesson — tagged and logged in the current week's journal file. The AI writes them (per common.md). You verify they're accurate. The cost is seconds; the value compounds.
- **Key insights written and reviewed.** The AI writes insights directly to KEY_INSIGHTS.md at the right level (per common.md), regardless of stance. You actively review them — revising what's vague, removing what's wrong, promoting what applies more broadly. This is how the AI gets better at your project over time, and your review is what makes the insights trustworthy.
- **Review gate between planning and execution.** You approve the plan before any code gets written.
- **Stance separation between design and execution.** The Architect/Tech Lead and the Developer are different cognitive stances. Whether they run in separate sessions is your call — but be aware that a Developer in the same session as a design conversation will carry that context. For complex work, a fresh Developer session produces more disciplined output.
- **Tracking updated at phase handovers.** The AI keeps STATUS.md and the journal current per common.md, regardless of stance. You verify the updates are accurate — especially after complex phases where the AI may mischaracterise what happened. The cost is minutes; the value compounds across sessions.

### The Overhead Discipline

Reading those nine non-negotiables, you might think: this is a lot of overhead for someone who just wants to ship code. But notice what the list actually asks of you: review, verify, approve. Not write, not track, not update. The AI does the production. You do the thinking.

This is a critical distinction. The AI writes journal entries, updates STATUS.md, writes insights, produces session receipts — all per common.md. You never stare at a blank journal file wondering what to write. But the methodology demands something harder than writing: it demands that you actually read what the AI wrote and verify it's correct. That you catch the insight that's too vague to be useful. That you notice when a STATUS.md update mischaracterises the phase outcome. That you push back on a spec that looks plausible but misses the real constraint.

**The process demands more from you, not less.** Without this methodology, you'd write code, review code, ship code. With it, you review plans, review specs, review prompts, review code, review journal entries, review insights, review status updates. Every artefact the AI produces passes through your judgement. The AI's throughput is high — it will generate more artefacts in a day than you'd produce in a week. Your job is to make sure that volume is accurate, specific, and trustworthy. That's harder than writing it yourself, because it requires you to think critically about someone else's output at speed.

Here's why it's worth it.

**Session 1 is the most expensive session you'll ever run.** The AI knows nothing about your project. It reads source files, makes wrong assumptions, produces plans you have to correct, and writes code that doesn't match your patterns. Every correction is a lesson — but without the journal and insight files, that lesson evaporates when the session ends. Session 2 starts from zero again. So does session 3. You're paying the same teaching cost every time.

**The tracking overhead is the mechanism that makes sessions get cheaper.** When the AI loads KEY_INSIGHTS.md and reads "Never use direct DOM manipulation in this codebase — the framework's reactivity system breaks" — that's a lesson you taught it once, in session 4, and it carries forward into every session after. When STATUS.md says "Phase 2 complete, phase 3 specced, the lookup table approach worked but watch for the type narrowing issue in registry.ts" — that's ten minutes of orientation that would otherwise cost thirty minutes of re-reading code and re-discovering context. But those insights are only as good as your review. An AI-written insight that says "the refactor was complex" teaches nothing. One that you refined to say "before moving validators between modules, write assertion tests for current behaviour first" teaches permanently. The AI writes the first draft. Your review turns it into durable knowledge.

**The compound curve is real but not instant.** For a two-session task, the overhead barely pays for itself — you'd have been fine without it. For a five-phase epic spanning three weeks, the difference is dramatic. Session 12 loads the insights from sessions 1–11, avoids every mistake already caught, follows every pattern already established, and starts producing useful output in minutes instead of spending the first half-hour re-learning the project. The overhead per session stays roughly constant (a few minutes of review), but the value it delivers grows with every session that contributes to the knowledge base.

**This is why the methodology requires discipline, not enthusiasm.** You don't need to enjoy reviewing journal entries. You need to review them anyway, because the version of you that comes back after a two-week break — or the AI that opens a fresh session tomorrow — will depend on them being accurate. The journal is not documentation for its own sake. It is the mechanism that turns individual sessions into cumulative progress. And your review is what makes it trustworthy.

If you find the overhead isn't paying off, check two things: Are you actually reading the AI's tracking output at session end and the insights at session start? And when you read them, are you engaging critically — refining vague insights, correcting inaccurate summaries, removing noise? The discipline is not in producing the artefacts. The AI handles that. The discipline is in the quality of your attention to what the AI produces.

---

## Anti-Patterns

### "Just do it"

Skipping the planning step because "it's a small change." Small changes that touch shared infrastructure are where the worst bugs hide. If it touches more than one file or changes behaviour, it deserves at least a task with a short spec — even a three-paragraph one.

### Amnesia sessions

Starting a new AI session without loading context. The AI will contradict previous decisions, reintroduce rejected patterns, or redo completed work. The context loading protocol exists for this reason — and each stance has a specific context focus (see the context table above).

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

A Developer session that encounters something unexpected and decides to "fix it" instead of reporting back. The Developer stance's job is to follow the prompt. If the prompt doesn't account for the current state of the code, the correct response is to report back so you can shift to Tech Lead thinking and issue a fix prompt. Improvised fixes compound — each one makes the next prompt's assumptions less accurate.

### Stance bleed

When the AI's output starts mixing stances — the Architect over-specifying implementation details, the Developer second-guessing prompts instead of following them, the Tech Lead redesigning the spec instead of translating it. This is a signal, not a catastrophe. If you notice stance bleed, separate the stances into different sessions. If you don't notice it, compression is working fine. The risk is highest between design (Architect/Tech Lead) and execution (Developer) — which is why a fresh Developer session is recommended for complex work.

### The rubber stamp

The AI writes a journal entry — you glance at it, looks fine, move on. The AI writes a key insight — seems reasonable, leave it. The AI updates STATUS.md — sure, whatever. The tracking artefacts accumulate, all technically present, none actually reviewed. Three weeks later, the AI loads insights that are too vague to be actionable, journal entries that mischaracterise what happened, and a STATUS.md that doesn't reflect the real state. The knowledge base looks complete but teaches nothing.

This is the most insidious failure mode because the process *appears* to be working. All the artefacts exist. All the non-negotiables are technically satisfied. But the human review that gives those artefacts their value never happened. The AI generates volume; only your critical attention makes that volume trustworthy. If you're approving tracking output without engaging with it, you're paying the overhead cost without getting the compound returns.

The fix is not to review more — it's to review better. Read the AI's journal entry and ask: does this actually capture what happened, or is it a plausible-sounding summary? Read the key insight and ask: is this specific enough that a fresh AI session could act on it, or is it generic advice? If the answer is "generic," rewrite it or remove it. Five minutes of engaged review at session end is worth more than an hour of passive accumulation.

### Misclassifying tiers

Treating everything as a task to avoid process overhead. If the work needs multiple phases, it's an epic. If the outcome requires abstract thinking, it's a goal. Forcing heavyweight work through a lightweight tier means skipping the planning that would have caught problems early. Conversely, treating a simple bug fix as a goal wastes time on ceremony that adds no value. Pick the tier honestly.
