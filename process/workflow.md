---
type: process
audience: [human, ai]
depends_on: [principles.md]
---

# Workflow

How you work day to day. The Human Lead drives — picking the right stance, deciding when to plan, when to execute, when to swap. The process gives you structure where it earns its keep and stays out of the way everywhere else.

> **Depends on:** [principles.md](./principles.md)
> **See also:** [roles.md](./roles.md), [journaling.md](./journaling.md), [action-tree.md](./action-tree.md)

---

## Engagement Modes

At any given moment, the project is in one of two engagement modes. The mode is a project-level declaration by the Human Lead that changes what the system focuses on, which stances are primary, and how recording behaves. It lives in `STATUS.md` as the **Engagement** field.

### Shaping

The system is oriented around the **knowledge tree** and the **structure of the action tree**. The Human Lead and the AI are stepping back to understand, design, and organise.

| Aspect | In shaping mode |
|---|---|
| **Focus** | Knowledge tree, action tree structure, codebase understanding |
| **Primary stances** | Architect, Navigator, Curator |
| **Activities** | Reading the codebase, designing approaches, defining actions and gatekeeps, writing phase specs, curating knowledge, structuring roadmaps, auditing the memory pipeline |
| **Recording focus** | Journal entries (decisions, observations), knowledge tree contributions, design rationale in action logs |
| **Output** | Specs, gatekeeps, phase designs, curated insights, roadmaps |
| **Not allowed** | Writing code, executing implementation prompts, producing session receipts |

Shaping is where you invest in clarity before committing to execution. A new project starts in shaping mode. Returning after a long break starts in shaping mode. Realising the approach is wrong mid-implementation means switching back to shaping mode.

### Working

The system is oriented around the **action tree's active stack**. The Human Lead and the AI are executing against a defined plan.

| Aspect | In working mode |
|---|---|
| **Focus** | Active action, current phase, prompt execution |
| **Primary stances** | Tech Lead, Developer |
| **Activities** | Writing implementation prompts, executing prompts, producing session receipts, logging implementation progress, surfacing implementation insights |
| **Recording focus** | Log entries (session history), session receipts, KEY_INSIGHTS.md (implementation learnings) |
| **Output** | Code, verified behaviour, session receipts |
| **Not allowed** | Restructuring the action tree, redefining gatekeeps, redesigning roadmaps, curating the knowledge tree |

Working mode assumes the shape is defined. If something forces you to question the shape — a flawed assumption, a missing dependency, a gatekeep that no longer makes sense — that's a signal to switch back to shaping. Don't redesign in working mode; switch modes explicitly.

### When to switch

The Human Lead declares the switch. It's recorded in STATUS.md and journaled as a `[process]` entry when the reason is worth capturing.

**Shaping → Working:** When the phase spec is approved and you're ready to implement. The Architect's design work is done (for now); the Tech Lead takes over.

**Working → Shaping:** When implementation reveals something that invalidates the plan. A phase-level issue (not a within-phase fix), a gatekeep that needs redefining, or the realisation that the action tree needs restructuring. Also: when an action completes and you need to decide what's next — that decision-making is shaping, not working.

The switch can happen multiple times per day. A tight loop of "shape the next phase → work it → shape the next" is normal. What matters is that the switch is explicit, not gradual. You're either shaping or working — not both at once. This prevents the most common failure mode: drifting from execution into redesign without noticing, producing code that doesn't match any plan.

### How recording changes per mode

The recording system (see [journaling.md](./journaling.md)) draws hard boundaries per mode — this is not a matter of emphasis:

| Recording target | Shaping | Working |
|---|---|---|
| `log.md` | Design decisions, exploration notes | Implementation progress, files touched |
| `KEY_INSIGHTS.md` | **Not used** — insights go directly to the knowledge tree | Implementation pitfalls, code-level patterns |
| `journal/` | **Primary output** — decisions, observations, process changes | **Exception only** — only if something cross-cutting surfaces |
| `receipt.md` | **Not produced** | **Every prompt** |
| Knowledge tree | **Active** — direct contributions, migrations, curation | **Not permitted** — deferred to KEY_INSIGHTS, migrated on action completion |

---

## The Open Flow

There is no rigid sequence of handoffs. You start with a rough idea, shape it with the Architect, translate it into prompts with the Tech Lead, execute with the Developer — often in a single conversation. The stances shape the AI's thinking; the Human Lead decides when to shift.

**Starting a work day or returning after a break:** get oriented. Ask the AI "where are we?" in any stance — it reads STATUS.md and the active action's log. If context has gone truly cold, use the Navigator for a proper briefing.

**During active work:** the conversation flows naturally between stances. You'll know when to shift because the work changes character — from "what should we build" (Architect) to "how should the prompt read" (Tech Lead) to "execute this" (Developer). Trust your judgement.

**Session boundaries are your call.** A single session with stance shifts is the default. Separate sessions are the escalation path for complex work where you notice stance bleed — the Architect over-specifying implementation, the Developer second-guessing prompts. You make this call based on the output quality you're seeing, not a blanket rule.

---

## The Active Stack

The active stack tracks what you're working on. Push an action when you start it, pop it when you're done. The stack tells you where you are and the path you took — including interruptions. STATUS.md tracks the stack.

**Swapping actions:** You can push a new action onto the stack at any time. A critical bug comes in while you're deep in a complex action — push the fix, do it, pop it, resume where you were. The swap gets logged in both actions' `log.md` files so the trail is clear.

**Resuming paused work:** Pop the interrupt off the stack. The paused action's `log.md` tells you where you left off. Use the Navigator if context has gone cold.

---

## Inception

Inception happens once per project, when the `.ai-sdlc/` folder doesn't exist yet. The Bootstrapper creates the `.ai-sdlc/` structure (memory, methodology, workspace.yaml), the journal skeleton, `action-tree/STATUS.md`, and the initial knowledge tree root at `knowledge-tree/index.spec.md`. Once the first action is defined, the project leaves inception and never returns. See [bootstrap/README.md](../bootstrap/README.md).

---

## The Planning-Implementation Loop

This is the one structured piece, and it maps directly to the engagement modes: **Planning is shaping** (Architect stance, oriented around design). **Implementation is working** (Tech Lead + Developer stances, oriented around execution). The cycle below is the mechanism by which the Human Lead moves between the two modes.

Every action — simple or complex — passes through this cycle. What differs is the weight: a simple fix compresses everything into a few minutes of conversation; a complex action gets multi-phase roadmaps and formal review gates. The cycle is the same.

```
    ┌─────────────────────────────────────────┐
    │                                         │
    ▼                                         │
 Planning ──→ Implementation ──→ Evaluate ────┤
 (Architect)   (Tech Lead +       │           │
               Developer)         │           │
                                  ▼           │
                            Phase done? ──────┘
                                  │        (plan next phase)
                                  ▼
                           Action done? ──→ Complete & archive
```

### Planning

**Stance:** Architect.

You come in with a rough idea and work with the Architect to shape it. The Architect reads the codebase deeply — relevant source files, tests, configuration, existing patterns — and writes a phase spec: problem/goal, numbered concrete steps with specific file paths, test cases, and done criteria.

For simple actions, planning is compressed — a few paragraphs covering the problem, the approach, and verification steps. You'll often flow straight from design into writing prompts in the same conversation.

For complex actions, planning involves defining the problem and gatekeep collaboratively, designing a multi-phase roadmap, and writing the first phase spec. The Architect should push back on vague outcomes and challenge assumptions — that's the stance's value.

**Planning ends** when you approve the phase spec and are ready to implement.

### Implementation

**Stances:** Tech Lead, Developer.

The Tech Lead reads the phase spec and writes implementation prompts — precise, bounded, one goal each. The Developer executes them literally and produces session receipts. How this loop works is your call:

**Single session (the default):** Fluid. Discuss the prompt approach (Tech Lead thinking), execute (Developer thinking), review the receipt, write the next prompt. The stances shape focus even in a continuous conversation.

**Separate sessions (for complex work):** The Tech Lead writes prompts in one session. The Developer executes in a fresh session — loading only the prompt, no design context. Session receipts bridge the gap. This produces more disciplined output but costs more context.

**Review cadence — your call:** High-risk phases warrant reading every prompt before execution. Low-risk phases are fine with the AI cycling through prompts, with you reviewing at the end.

### Handling issues

**Within-phase fixes (stay in Implementation):** A failing test, a type error, an unexpected result — the session receipt captures the issue. A fix prompt addresses it. This is a tight loop.

**Phase-level issues (go back to Planning):** If the approach itself is flawed — assumptions were invalid, a dependency was missed — this is not a prompt fix. Switch back to Planning. The revised phase gets a new spec version (append-forward — don't silently edit the original).

### Phase handovers

When a phase completes, evaluate: does it move toward the action's gatekeep? The AI logs what happened and updates STATUS.md. The typical next move is to shift back to Architect thinking — review the outcome and plan the next phase. Each phase builds on the previous one's insights and the updated codebase.

---

## Action Completion

When all phases are complete and the gatekeep is met, run the action completion recording checklist defined in [journaling.md — Session Recording Checklists](./journaling.md#session-recording-checklists). In summary:

1. Review KEY_INSIGHTS.md — anything worth keeping migrates to the appropriate knowledge tree nodes
2. The action subtree moves from `action-tree/` to `archive/`
3. STATUS.md updates — action popped from the active stack, status → Achieved
4. Run a Curator session to audit the memory pipeline — this is the baseline cadence for curation
5. If other actions are on the stack, resume the next one
6. If the stack is empty, define what's next

Abandoned actions also move to `archive/` with a note in the log. The knowledge tree keeps what was learned; the archive keeps the historical record.

---

## Staying Current

Codebases don't stand still. Other developers push changes, dependencies get updated, CI breaks things. The project memory reflects the state of the code at the time it was written, and that state can go stale.

**When starting a new action,** check for recent external changes. The AI can read the git log and compare it against `knowledge-tree/index.spec.md`.

**When resuming a paused action,** the same check applies — more urgently the longer the pause.

**When `knowledge-tree/index.spec.md` goes stale,** the Architect updates it as part of normal work.

The journal captures what happens within the process. Bridging the gap with what happens outside it is a human responsibility.

---

## Session Persistence Is in the Artefacts, Not the Tool

Regardless of how you manage sessions — one persistent conversation or many separate ones — every piece of state is written down: STATUS.md tracks where you are, the recording system (see [journaling.md](./journaling.md)) captures what happened and what was learned, phase.md files track the plan, and session receipts track what the Developer did. The methodology never relies on an AI role's memory of previous interactions. It relies on written artefacts that any session can read.

Tools with persistent sessions benefit from continuity — the Architect's discussion informs the Tech Lead's prompts naturally. The trade-off is role bleed. Tools with stateless sessions benefit from clean role separation — each role starts fresh with exactly the right context. The trade-off is information loss at handoffs, which handoff prompts exist to mitigate.

The practical approach: use a single session for Architect + Tech Lead (shared context helps), a fresh session for the Developer on complex work (clean context helps), and invoke the Navigator only when context has gone cold. Adjust based on what you see in the output.
