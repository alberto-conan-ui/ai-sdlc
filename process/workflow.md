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

## The Planning-Implementation Loop

This is the one structured piece. Every action — simple or complex — passes through this cycle. What differs is the weight: a simple fix compresses everything into a few minutes of conversation; a complex action gets multi-phase roadmaps and formal review gates. The cycle is the same.

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
