# The Workflow

This is not vibe coding. Vibe coding is "give the AI a vague idea, let it generate, hope for the best." It works for throwaway prototypes. It does not work for anything you need to maintain, extend, or trust. AI-SDLC is the deliberate opposite: structured intent, human accountability at every gate, and AI constrained by process — not unleashed without it.

---

## Inception — Project Cold Start

Inception happens once per project, when the workspace doesn't exist yet. It is not a recurring mode — it's the getting-ready-to-start-working step. The project stays in INCEPTION until the first action is defined.

**Stance:** Bootstrapper (see [`roles/bootstrapper.md`](../roles/bootstrapper.md)).

**What happens:**

1. The Bootstrapper walks you through creating the three-folder workspace: code repo, project memory, and ai-sdlc. See [bootstrap/](../bootstrap/) for the convention.
2. It creates the journal skeleton: STATUS.md (in INCEPTION mode), CONTEXT.md (a few lines — project name, stack, repo URL), journal/ with a single setup entry, the knowledge/ folder (with a root index.md), and the actions/ folder.
3. The Bootstrapper verifies the structure and hands off. It does not define actions, explore the codebase deeply, or start any work.

**What INCEPTION means in STATUS.md:** The workspace exists and the structure is in place, but no work has started. There is no active action, no roadmap, no phase. The next step is for the human to invoke the Architect, who will deepen CONTEXT.md by reading the codebase and help define the first action.

Once the first action is defined, the project leaves INCEPTION and enters Planning. INCEPTION is never revisited — it is a one-time setup state.

---

## Two Modes

After Inception, the project operates in two modes: **Planning** and **Implementation**. At any point, the top of the active stack determines which action is being worked on and in which mode. The mode is tracked in STATUS.md (see [templates.md](./templates.md)), which is the single source of truth for "where are we."

**The active stack tracks what you're working on.** You push an action onto the stack when you start it, pop it when you're done or switching. The stack tells you where you are and the path you took — including interruptions. It works across action trees. See [actions.md](./actions.md) for the full model.

```
Planning ──→ Implementation ──→ Action achieved ──→ Pop stack, pick next
    ↑               │
    └───────────────┘
  (phase-level issue)
```

All actions follow this cycle regardless of complexity. What differs is the weight of each step: a simple leaf action's Planning is compressed (short spec, maybe no prompt plan), while a deeply nested action tree involves codebase analysis, multi-phase roadmaps, and formal review gates. The modes are the same — the ceremony scales with the work.

---

## Planning

**Stance:** Architect (primarily).

Planning is where an action gets defined, broken into phases, and each phase gets a spec. This is a conversation between you and the AI in Architect stance — not a rigid sequence of handoffs. A phase is a bounded chunk of work with a clear purpose, concrete steps, and done-criteria. A small epic might have two phases. A large goal might have twelve. A task has exactly one.

**What happens in Planning:**

You come in with a rough idea and work with the Architect to shape it. For complex actions, this means defining the problem, vision, and gatekeep collaboratively — the Architect asks probing questions, you provide domain context. For simple actions, the Architect does a quick assessment. The conversation naturally flows from defining the action to designing the roadmap to writing the first phase spec.

The Architect reads the codebase deeply — relevant source files, tests, configuration, existing patterns. A plan written without reading the code is a guess. Specs should reference specific file paths, show code snippets of current behaviour, and include tables of test cases. Vague plans produce vague code.

You review and approve the spec (or push back — the Architect should defend the design or revise it). Whether this takes one session or several doesn't matter. By the end of Planning, there's an approved action document, a roadmap, and a phase spec.

**Planning for simple actions:** compressed. The Architect produces a short spec (a few paragraphs — problem, steps, done-when). You'll often flow straight from design into writing prompts in the same conversation. The gate is lighter — a single-phase action doesn't need the same scrutiny as a deeply nested action tree.

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
| **Architect** | STATUS.md, CONTEXT.md, relevant knowledge/ nodes, active action's gatekeep.md + context.md, active phase spec | Completed phase specs, relevant source files | impl prompts |
| **Tech Lead** | Active phase spec, action KEY_INSIGHTS.md, relevant knowledge/ nodes, source files | CONTEXT.md | other phase specs |
| **Developer** | The current implementation prompt | Nothing else | Everything except the prompt |
| **Navigator** | STATUS.md, journal/ (current + previous week), active action's log.md | Older journal weeks, git log | knowledge/, source code, phase specs, impl prompts |
| **Curator** | knowledge/ (full tree), journal/ (all weeks), action logs and KEY_INSIGHTS.md files, completed action specs | CONTEXT.md | Source code, impl prompts |

In a single session, the AI has seen everything from prior stances — the table defines what each stance *focuses on*, not what it can see. Be aware that a Developer stance in the same session as a prior Architect conversation carries that context. For complex work, a fresh Developer session produces more disciplined output.

**Tracking updates:** The AI handles its own tracking per common.md — journal entries, STATUS.md updates, knowledge contributions — regardless of stance. Your job is not to produce these artefacts but to verify them: scan the journal entry for accuracy, check that STATUS.md reflects reality, review knowledge contributions for specificity and placement. The mechanism matters less than the discipline: keeping things current *and accurate* means the next session starts with trustworthy context.

---

## Action Completion and Transition

When all phases for the active action are complete and you've confirmed the gatekeep is met:

1. Any insights worth keeping migrate from the action's KEY_INSIGHTS.md to the appropriate knowledge tree nodes
2. The action subtree moves from `actions/` to `archive/`
3. The AI updates STATUS.md — action popped from the active stack, status → Achieved
4. If other actions are on the stack, you resume the next one
5. If the stack is empty, you define what's next

For leaf actions, completion is often immediate — one phase, gatekeep verified, archive, done. For branch actions, you evaluate the gatekeep across all children before marking the branch as achieved.

Abandoned actions also move to `archive/` with a note in the action's log. The knowledge tree keeps what was learned; the archive keeps the historical record.

---

## Swapping Actions

You can push a new action onto the active stack at any time. This is a deliberate decision, not an accident, and it gets logged:

1. You decide to swap (e.g., a critical bug came in while working on a complex action tree)
2. The AI updates STATUS.md — push the new action onto the stack, note the reason
3. The reason for the swap is logged in the paused action's `log.md`

When returning to a paused action, pop the interrupt off the stack — the paused action's `log.md` tells you where you left off. Use the Navigator stance for a briefing if context has gone cold.

---

## Staying Current with External Changes

Codebases don't stand still. Other developers push changes, dependencies get updated, CI breaks things, PRs get merged. The project memory — STATUS.md, CONTEXT.md, phase specs — reflects the state of the code at the time it was written, and that state can go stale.

This is a real-world problem, and the methodology doesn't pretend it doesn't exist. The solution isn't a special process — it's the same discipline you'd apply as a senior developer: stay current.

**When starting any new action,** check for recent external changes. The AI can read the git log and compare it against CONTEXT.md — in Navigator stance for a quick check, or in Architect stance as part of its normal codebase read. This takes a minute and can save hours of building on stale assumptions.

**When resuming a paused action,** the same check applies — possibly more urgently. The longer an action has been paused, the more the codebase may have drifted.

**When CONTEXT.md goes stale,** the AI updates it in Architect stance. This isn't a special event — it's part of the Architect's normal work if the codebase structure has changed.

The journal captures everything that happens within the process. It doesn't capture what happens outside it. Bridging that gap is a human responsibility.

---

## Scaling the Process

The methodology uses one structure for all projects. The action tree naturally scales to the work — a simple fix is a single leaf node, complex work decomposes into nested branches. There is no "lite mode" or "full mode" to choose between. You shape the tree to match the work.

A project that's mostly bug fixes and small features will have many shallow leaf actions. A project in active development will have a mix. A greenfield project might start with a broad action tree to establish direction and then add children as the architecture solidifies.

### What Scales Naturally

- **The action tree** — more work means more nodes. Completed subtrees move to `archive/`, keeping `actions/` clean. The tree structure makes the decomposition visible at a glance.
- **The journal** — weekly rolling files mean the journal grows without becoming unwieldy. The journal captures cross-cutting decisions; action-level history lives in each action's `log.md`.
- **The knowledge tree** — grows organically as work touches new areas of the codebase. Each session loads only the relevant nodes, not the entire tree. Completed actions contribute their KEY_INSIGHTS to the tree before archiving — the knowledge outlives the action that produced it.

### Stance Compression

**A single session with stance shifts is the default.** For simple actions, flow naturally between Architect and Tech Lead thinking in one conversation — the shared context helps. The Developer can stay in the same session for low-risk work or get a fresh session when disciplined prompt-following matters. Use the Navigator stance only when context has gone cold.

**Separate sessions are the escalation path.** For complex action trees where you notice stance pollution — the Architect over-specifying implementation, the Developer second-guessing prompts — separate them physically. You make this call based on what you're seeing in the output, not based on a blanket rule.

### What Matters

The process has ceremony — specs, journals, knowledge, status tracking. But the ceremony exists to serve a small number of principles. If you understand the principles, you'll know when to follow the ceremony closely and when to keep it light.

**Define the work before starting it.** Every piece of work has a `gatekeep.md` — a definition of done. Even three lines counts. The point is clarity of intent, not documentation for its own sake.

**Plan before you code.** Every phase has a spec. The spec can be short — a task's spec might be a few paragraphs. But the discipline of writing down what you're about to do catches problems that thinking alone misses.

**Keep the logs honest.** Every session at an action node gets logged in that action's `log.md`. Cross-cutting decisions go in the journal. The AI writes the entries. You verify they're accurate. This takes seconds and compounds over weeks.

**Grow the knowledge tree.** When insights emerge from the work that matter beyond the current session, capture them in the knowledge tree at the right node. This happens through conversation — the AI proposes, you confirm or redirect. No formal write-back ceremony; just the discipline of noticing what's worth keeping.

**Review what the AI produces.** Plans, specs, journal entries, knowledge — the AI generates volume. Your engaged review is what makes the volume trustworthy. Rubber-stamping gives you all the overhead with none of the returns.

**Keep STATUS.md current.** It's the single source of truth for where the project is. The AI updates it; you verify it reflects reality.

**Separate design from execution.** The Architect/Tech Lead and the Developer are different cognitive stances. Whether they run in separate sessions is your call — but be aware that shared context affects the Developer's discipline. For complex work, a fresh Developer session helps.

### Why the Overhead Pays Off

The process asks you to review a lot — plans, specs, journal entries, knowledge, status updates. None of that is busywork, but it's worth understanding why.

**Session 1 is the most expensive session you'll ever run.** The AI knows nothing about your project. Without the journal and knowledge tree, every correction evaporates when the session ends. Session 2 starts from zero again.

**The journal and knowledge tree make sessions get cheaper.** When the AI loads a knowledge node and reads "Never use direct DOM manipulation in this codebase — the framework's reactivity system breaks" — that's a lesson you taught it once, in session 4, and it carries forward permanently. But only if you reviewed it. An AI-written insight that says "the refactor was complex" teaches nothing. One that you refined to say "before moving validators between modules, write assertion tests for current behaviour first" teaches permanently.

**The compound curve is real but not instant.** For a two-session task, the overhead barely pays for itself. For a five-phase epic spanning three weeks, session 12 loads everything from sessions 1–11, avoids every mistake already caught, and starts producing useful output in minutes. The overhead per session stays roughly constant; the value grows with every session.

If you find the overhead isn't paying off, check: are you actually engaging with the AI's output — refining vague insights, correcting inaccurate journal entries, removing noise from the knowledge tree? The discipline is not in producing the artefacts. The AI handles that. The discipline is in the quality of your attention.
