# SDLC Plugin — Workflow

> **Joins:** [workflow.md](../../workflow.md) — Addendum: load core workflow first (focus, modes, stack, headless, checkpoints), then layer this file for the SDLC-specific design → implementation cycle and stance flow.
>
> **References**
>
> | Group | File |
> |---|---|
> | Core workflow | [workflow.md](../../workflow.md) |
> | Core focus | [focus.md](../../focus.md) |
> | SDLC stances | [roles.md](./roles.md) |
> | SDLC action tree | [action-tree.md](./action-tree.md) |

Core workflow defines focus, modes, the focus stack, headless, and checkpoints. This adds the SDLC-specific work cycle on top: the Architect/Tech Lead stance flow, the design → implementation cycle, and phase handovers. Core defines focus, modes, the focus stack, headless, and checkpoints. This doc defines how SDLC projects move through design and implementation using the Architect and Tech Lead stances.

---

## The Stance Flow

There is no rigid handoff sequence. You start with a rough idea, shape it with the Architect, and the Tech Lead builds it — often in a single conversation. The stances shape the AI's thinking; the Human Lead decides when to shift.

**During active work:** the conversation flows naturally between stances. The shift happens when the work changes character — from "what should we build" (Architect) to "let's implement this" (Tech Lead).

**Session boundaries are the human's call.** A single session with stance shifts is the default. Separate sessions are the escalation path for complex work where stance bleed degrades output quality — when the Architect starts writing code, or the TL starts redesigning the spec.

---

## Design → Implementation

The primary work cycle for SDLC projects. A simple fix compresses it to minutes; a complex topic gets multi-phase roadmaps. The cycle is the same.

```
    ┌──────────────────────────────────────────────────────┐
    │                                                      │
    ▼                                                      │
 Design ────→ Implementation ──→ Evaluate ─────────────────┘
 (Architect)   (Tech Lead)         │
                                   ▼
                             Gate met? ──→ Complete & archive
```

### Design

**Stance:** Architect.

The Human Lead comes in with a rough idea and works with the Architect to shape it. The Architect reads the codebase deeply — relevant source files, tests, configuration, existing patterns — and writes a phase spec: goal, concrete steps with specific file paths, test cases, and done criteria.

For simple work, design is compressed — a few paragraphs covering the problem, the approach, and verification. The conversation often flows straight from design into implementation.

For complex work, design involves defining the problem and gate collaboratively, designing a multi-phase roadmap, and writing the first phase spec. The Architect should push back on vague outcomes and challenge assumptions.

**Design ends** when the Human Lead approves the phase spec and the conversation shifts to implementation.

### Implementation

**Stance:** Tech Lead.

The Tech Lead reads the phase spec, discusses approach with the Human Lead, and implements. This is where most code gets written. The TL works directly from the spec — reading relevant source files, writing code, running tests, iterating.

**Review cadence is the human's call.** Complex work warrants reviewing each implementation step. Straightforward work is fine with less frequent check-ins.

### Handling issues

**Within-phase fixes (stay in Implementation):** A failing test, a type error, an unexpected result — the TL addresses it directly. Tight loop.

**Phase-level issues (go back to Design):** If the approach itself is flawed — assumptions were invalid, a dependency was missed — switch back to Architect thinking. The revised phase gets a new spec version (append-forward — new version, not silent edit of the original).

### Phase handovers

When a phase completes, evaluate: does it move toward the focus gate? The TL writes a journal entry and updates status. The typical next move is to shift back to Architect thinking — review the outcome and write the next phase spec.

---

## Tasks — The Lightweight Path

Tasks don't follow the full stance pipeline. Any stance can do the whole job — the Architect can write code, the Tech Lead can make a design call. Modes still apply (Planning, Executing, or Reflecting). The design → implementation cycle and stance handoffs don't. This is the escape valve for small changes that don't warrant ceremony. See [action-tree.md — Tasks](./action-tree.md#tasks--leaves-ungated) for the full task definition.

---

## Staying Current

Codebases don't stand still. Other developers push changes, dependencies get updated, CI breaks.

**When starting a new focus,** check for recent external changes. The AI can read the git log and compare against knowledge tree state.

**When resuming a paused focus,** the same check applies — more urgently the longer the pause.

The journal captures what happens within the process. Bridging the gap with what happens outside is a human responsibility.

---

## Session Persistence Advice

The practical approach: use a single session for Architect + Tech Lead work — shared context helps both stances. Separate sessions are the escalation path when stance bleed degrades output quality. Adjust based on what you see in the output.
