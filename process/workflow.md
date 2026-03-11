# The Workflow

This is not vibe coding. Vibe coding is "give the AI a vague idea, let it generate, hope for the best." It works for throwaway prototypes. It does not work for anything you need to maintain, extend, or trust. AI-SDLC is the deliberate opposite: structured intent, human accountability at every gate, and AI constrained by process — not unleashed without it.

---

## Inception — Project Cold Start

Inception happens once per project, when the workspace doesn't exist yet. It is not a recurring mode — it's the getting-ready-to-start-working step. The project stays in INCEPTION until the first action is defined.

**Stance:** Bootstrapper (see [`roles/bootstrapper.md`](../roles/bootstrapper.md)).

**What happens:**

1. The Bootstrapper walks you through creating the three-folder workspace: code repo, project journal, and ai-sdlc. See [bootstrap/](../bootstrap/) for the convention.
2. It creates the journal skeleton: STATUS.md (in INCEPTION mode), KEY_INSIGHTS.md (empty), CONTEXT.md (a few lines — project name, stack, repo URL), journal/ with a single setup entry, and the actions/ folder.
3. The Bootstrapper verifies the structure and hands off. It does not define actions, explore the codebase deeply, or start any work.

**What INCEPTION means in STATUS.md:** The workspace exists and the structure is in place, but no work has started. There is no active action, no roadmap, no phase. The next step is for the human to invoke the Architect, who will deepen CONTEXT.md by reading the codebase and help define the first action.

Once the first action is defined, the project leaves INCEPTION and enters Planning. INCEPTION is never revisited — it is a one-time setup state.

---

## Two Modes

After Inception, the project operates in two modes: **Planning** and **Implementation**. At any point, the project is in exactly one mode for exactly one active action. The mode is tracked in STATUS.md (see [templates.md](./templates.md)), which is the single source of truth for "where are we."

**One active action at a time.** A project may have multiple actions defined, but only one is active. This prevents context scatter — the AI always knows which action it's serving. If you want to switch actions, do so explicitly — update STATUS.md and log the reason in the journal.

```
Planning ──→ Implementation ──→ Action achieved ──→ Pick next action
    ↑               │
    └───────────────┘
  (phase-level issue)
```

All three tiers follow this cycle. What differs is the weight of each step: a task's Planning is compressed (short spec, maybe no prompt plan), while a goal's Planning involves deep codebase analysis, multi-phase roadmaps, and formal review gates. The modes are the same — the ceremony scales with the tier.

---

## Planning

**Stance:** Architect (primarily).

Planning is where an action gets defined, broken into phases, and each phase gets a spec. This is a conversation between you and the AI in Architect stance — not a rigid sequence of handoffs. A phase is a bounded chunk of work with a clear purpose, concrete steps, and done-criteria. A small epic might have two phases. A large goal might have twelve. A task has exactly one.

**What happens in Planning:**

You come in with a rough idea and work with the Architect to shape it. For goals, this means defining the problem, vision, design principles, and gatekeep collaboratively — the Architect asks probing questions, you provide domain context. For epics, the Architect helps refine scope and gatekeep. For tasks, the Architect does a quick assessment. The conversation naturally flows from defining the action to designing the roadmap to writing the first phase spec.

The Architect reads the codebase deeply — relevant source files, tests, configuration, existing patterns. A plan written without reading the code is a guess. Specs should reference specific file paths, show code snippets of current behaviour, and include tables of test cases. Vague plans produce vague code.

You review and approve the spec (or push back — the Architect should defend the design or revise it). Whether this takes one session or several doesn't matter. By the end of Planning, there's an approved action document, a roadmap, and a phase spec.

**Planning for tasks:** compressed. The Architect produces a short spec (a few paragraphs — problem, steps, done-when). You'll often flow straight from design into writing prompts in the same conversation. The gate is lighter — a task spec doesn't need the same scrutiny as a multi-phase epic.

**When Planning ends:** When you approve the phase spec and are ready to move to implementation. The AI updates STATUS.md: mode switches to Implementation.

---

## Implementation

**Stances:** Tech Lead, Developer.

Implementation is where code gets written. In Tech Lead stance, the AI reads the phase spec and writes implementation prompts. In Developer stance, it executes them. How this loop works — how many prompts, how much review between them, whether prompts are written upfront or one at a time — is your call. The process is deliberately freestyle here because the right approach depends on the work.

**In a single session (the default),** this is fluid. You discuss the prompt approach with the AI (Tech Lead thinking), then tell it to execute (Developer thinking). The AI naturally carries the context forward. When it finishes executing, it produces a session receipt — what was done, what files changed, any surprises — and you discuss the next prompt. The stances shape the AI's focus even when the session is continuous.

**In separate sessions (for complex work),** the loop is more formal. You write or review a prompt in one session (Tech Lead), then paste it into a fresh session (Developer) for execution. The session receipt bridges the gap — it captures the actual state of the code so the next prompt is grounded in reality rather than pre-execution assumptions (see [prompts.md](./prompts.md) for just-in-time prompting).

**Review cadence — your call:** Some phases warrant reading every prompt before execution (high-risk, novel patterns, shared infrastructure). Others are fine with the AI cycling through prompts, with you reviewing at the end (low-risk, familiar patterns). You decide per phase based on risk and complexity.

**Within-phase fixes (stay in Implementation):** If a prompt produces a failing test, a type error, or an unexpected result, the session receipt captures the issue. A fix prompt — a targeted correction — addresses it. This is a tight loop.

**Phase-level issues (go back to Planning):** If the approach itself is flawed — assumptions were invalid, a dependency was missed — this is not a prompt fix. You switch back to Planning. Following the append-forward principle, the revised phase gets a new spec version rather than silently modifying the original.

**Phase handovers:** When a phase is done, you evaluate: does it move toward the action's gatekeep? The AI logs what happened and updates STATUS.md (per common.md). The typical next move is to shift back to Architect thinking — review the outcome and plan the next phase. If context has gone cold or the transition is complex, use the Navigator stance for a briefing. Each phase builds on the previous one's insights and the updated codebase.

---

## Session Discipline

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

---

## Action Completion and Transition

When all phases for the active action are complete and you've confirmed the gatekeep is met:

1. The AI updates STATUS.md — action status → Achieved
2. If other actions are defined, you pick the next one to activate
3. If no other actions exist, you define what's next

For tasks, completion is often immediate — one phase, gatekeep verified, done. For epics and goals, you evaluate the gatekeep across all completed phases before marking the action as achieved.

---

## Swapping Actions

You can switch the active action at any time. This is a deliberate decision, not an accident, and it gets logged:

1. You decide to swap (e.g., a critical bug came in while working on an epic)
2. The AI updates STATUS.md — previous action status → Paused (with reason), new action → Active
3. The reason for the swap is logged as a `[decision]` entry in the journal — this context is critical for the next session

When returning to a paused action, the journal captures why it was paused and what state it was in. Use the Navigator stance for a briefing if context has gone cold.

---

## Staying Current with External Changes

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
