# Workflow

> **References**
>
> | Group | File |
> |---|---|
> | Foundation | [principles.md](./principles.md) |
> | Stances | [roles.md](./roles.md) |
> | Recording system | [journaling.md](./journaling.md) |
> | Action tree | [action-tree.md](./action-tree.md) |

How you work day to day. The Human Lead drives — picking the right stance, deciding when to plan, when to execute, when to swap. The process gives you structure where it earns its keep and stays out of the way everywhere else.

---

## The Flow

There is no rigid sequence of handoffs. You start with a rough idea, shape it with the Architect, and the Tech Lead builds it — often in a single conversation. The stances shape the AI's thinking; the Human Lead decides when to shift.

**Starting a work day or returning after a break:** get oriented. Ask the AI "where are we?" in any stance — it reads `status.md` and the recent journal entries.

**During active work:** the conversation flows naturally between stances. You'll know when to shift because the work changes character — from "what should we build" (Architect) to "let's implement this" (Tech Lead).

**Session boundaries are your call.** A single session with stance shifts is the default. Separate sessions are the escalation path for complex work where stance bleed degrades output quality.

---

## The Active Stack

The active stack tracks what you're working on. Push an action when you start it, pop it when you're done. The stack tells you where you are and the path you took — including interruptions. `status.md` tracks the stack.

**Swapping actions:** Push a new action onto the stack at any time. A critical bug comes in while you're deep in a complex topic — push the fix, do it, pop it, resume. The swap gets logged in the journal.

**Entering Reflecting mode:** Reflecting pushes onto the stack above whatever you're working on. The action underneath stays untouched — no status change, no tree mutation. When you're done reflecting, pop it and resume where you were. The stack makes the reflection visible: a new session sees Reflecting on top and knows the tree is under examination, not being driven forward. See [principles.md — Interaction Modes](./principles.md#interaction-modes).

**Resuming paused work:** Pop the interrupt (or the reflection). The journal tells you where you left off.

---

## Design → Implementation

Every action passes through this cycle. A simple fix compresses it into minutes; a complex topic gets multi-phase roadmaps. The cycle is the same.

```
    ┌──────────────────────────────────────────────────────┐
    │                                                      │
    ▼                                                      │
 Design ────→ Implementation ──→ Evaluate ─────────────────┘
 (Architect)   (Tech Lead)         │
                                   ▼
                             Action done? ──→ Complete & archive
```

### Design

**Stance:** Architect.

You come in with a rough idea and work with the Architect to shape it. The Architect reads the codebase deeply — relevant source files, tests, configuration, existing patterns — and writes a phase spec: goal, concrete steps with specific file paths, test cases, and done criteria.

For simple actions, design is compressed — a few paragraphs covering the problem, the approach, and verification. You'll often flow straight from design into implementation in the same conversation.

For complex topics, design involves defining the problem and gatekeep collaboratively, designing a multi-phase roadmap, and writing the first phase spec. The Architect should push back on vague outcomes and challenge assumptions.

**Design ends** when the Human Lead approves the phase spec and the conversation shifts to implementation.

### Implementation

**Stance:** Tech Lead.

The Tech Lead reads the phase spec, discusses approach with the Human Lead, and implements. This is where most code gets written. The TL works directly from the spec — reading relevant source files, writing code, running tests, iterating.

**Review cadence is your call.** Complex work warrants reviewing each implementation step. Straightforward work is fine with less frequent check-ins.

### Handling issues

**Within-phase fixes (stay in Implementation):** A failing test, a type error, an unexpected result — the TL addresses it directly. Tight loop.

**Phase-level issues (go back to Design):** If the approach itself is flawed — assumptions were invalid, a dependency was missed — switch back to Architect thinking. The revised phase gets a new spec version (append-forward — don't silently edit the original).

### Tasks — the lightweight path

Tasks don't follow the full stance pipeline. Any stance can do the whole job — the Architect can write code, the Tech Lead can make a design call. Interaction modes still apply (you're still in Planning, Executing, or Reflecting). Workflow stages and stance handoffs don't. This is the escape valve for small changes that don't warrant ceremony. See [action-tree.md](./action-tree.md) for the full task definition.

### Phase handovers

When a phase completes, evaluate: does it move toward the action's gatekeep? The TL writes a journal entry and updates `status.md`. The typical next move is to shift back to Architect thinking — review the outcome and write the next phase spec.

---

## Action Completion

When the gatekeep is met, run the action completion checklist defined in [journaling.md](./journaling.md). In summary: review journal entries for KT-worthy insights, archive the subtree, update `status.md` and `action-tree.index.md`, resume the next action on the stack or define what's next.

Abandoned actions also move to `archive/` with a note in the journal. The knowledge tree keeps what was learned; the archive keeps the historical record.

---

## Staying Current

Codebases don't stand still. Other developers push changes, dependencies get updated, CI breaks.

**When starting a new action,** check for recent external changes. The AI can read the git log and compare against `knowledge-tree/knowledge-tree.index.md`.

**When resuming a paused action,** the same check applies — more urgently the longer the pause.

The journal captures what happens within the process. Bridging the gap with what happens outside is a human responsibility.

---

## Session Persistence Is in the Files

Every piece of state is written down: `status.md` tracks where you are, the journal captures what happened and what was learned, phase specs track the plan, and `action-tree.index.md` tracks the tree structure. The methodology never relies on an AI's memory of previous interactions. It relies on files that any session can read.

The practical approach: use a single session for Architect + Tech Lead (shared context helps). Separate sessions are the escalation path when stance bleed degrades output quality. Adjust based on what you see in the output.
