# Focus

> **References**
>
> | Group | File |
> |---|---|
> | Foundation | [principles.md](./principles.md) |
> | Workflow | [workflow.md](./workflow.md) |
> | Memory model | [memory.md](./memory.md) |

Focus is the central concept of the workflow. It answers one question: **what are you working on?**

A focus is stated plainly — the way you'd explain it to a colleague. "Rewriting the auth middleware." "Preparing the v0.3 release." "Figuring out why latency spiked." It is the human's intent, made explicit so the AI can orient to it.

Each focus is a file in `status/focus/`. The file persists across sessions — it's the durable home for what you're working on, surviving interrupts and session boundaries.

---

## Focus File Structure

Each focus file contains:

```markdown
# [Focus name]

## Gate
- [Concrete, evaluable criteria]
- [No implementation specifics — abstract but rigorous]

## Mode
[Planning / Executing / Reflecting]

## State
[One line: where work currently stands. Points to the source —
a journal handover, an AT action, or a short human statement.
A pointer, not a narrative.]

## Context
[What the AI needs to know to orient. Links to relevant KT nodes,
journal entries, or AT goals if the focus uses the action tree.
Kept brief — the journal carries the narrative.]
```

---

## The Gate

Every focus has a **gate**: a formal definition of done. Not a single sentence — a concrete, evaluable set of criteria that the human commits to when the focus is set. The gate is abstract (no implementation specifics) but rigorous (no ambiguity about what "done" means).

Example:

> **Focus:** Auth middleware rewrite
>
> **Gate:**
> - Token refresh works without session storage
> - All existing auth tests pass against the new middleware
> - No session tokens stored in a way that violates the compliance requirements

The gate is the most important part of the focus. Without it, work drifts. Without rigour, the gate becomes a rubber stamp. The AI must refuse to set a focus without a gate — this is mechanically enforced, not culturally expected.

---

## Focus Lifecycle

A focus moves through a simple lifecycle:

```
created → active → completed
                 → abandoned
```

**Created.** The human defines the focus and its gate. The focus file is written to `status/focus/`.

**Active.** The focus is on the stack and being worked. It has a mode (Planning, Executing, or Reflecting) that changes as work progresses. Only the top of the stack is actively worked — others are paused, waiting to resume.

**Completed.** The human evaluates the gate and decides it's met. The focus file moves to `status/focus/archive/`.

**Abandoned.** The human decides the focus is no longer worth pursuing. The focus file moves to `status/focus/archive/` with a note on why. Abandonment is a legitimate outcome, not a failure — priorities change, investigations reveal the question was wrong, or the work is superseded.

The journal captures every transition. The focus file records current state; the journal records the history of how it got there.

---

## Focus Files Stay Flat

A focus file has a gate, a mode, and context. **No children. No hierarchy. No sub-focuses.** The moment work needs decomposition into tracked stages, reach for the action tree. That's what the AT is for. A focus that grows children has become an AT goal — promote it, don't expand the focus.

---

## Setting and Clearing Focus

The human sets the focus explicitly. The AI confirms, ensures the gate is defined, and records it. The human clears the focus when the gate is met — or when they decide to abandon it. Both are journal-worthy.

The AI never sets or changes focus on its own. If the conversation implies a focus change, the AI pauses and confirms:

*"It sounds like you want to shift focus to the deployment pipeline. Should I set that as the active focus?"*

*"The current focus is the auth rewrite. This question is about something else — should I switch focus, or is this a quick aside?"*
