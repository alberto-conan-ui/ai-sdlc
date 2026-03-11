# Context Isolation and Role Framing

> How the entry-point system works, why role separation improves output, and when to use separate sessions versus mode switching.
> This document is for the Human Lead. AI roles read their entry points in `roles/`.

---

## The Problem

The full methodology describes roles, modes, workflows, and anti-patterns. It's written for a human who needs the complete picture. But AI sessions are not humans reading a manual — they're workers performing a bounded job. When an AI role loads the full methodology, two things go wrong.

**Context waste.** The Developer doesn't need to know how the Architect thinks. The Architect doesn't need the Developer's stance on unexpected failures. Every role pays the token cost of the full methodology, but most of that context is irrelevant to its task. In a context window with hard limits, irrelevant tokens displace useful ones — the source files, the phase spec, the lessons learned.

**Role bleed.** This is the more insidious problem. An AI that knows about other roles' responsibilities starts doing their jobs. An Architect that knows the Developer's constraints over-specifies implementation details instead of designing systems. A Developer that knows the Architect's reasoning second-guesses the prompt instead of following it. Knowledge shapes behaviour — even knowledge the role shouldn't act on.

These problems manifest differently depending on how the Human Lead manages sessions. In separate sessions, entry points solve both problems cleanly — each role loads exactly its context, nothing more. In a shared session with mode switching, the model carries everything it's seen, which means role bleed can only be mitigated through framing instructions, not eliminated through context isolation. The Human Lead decides which trade-off is right for the work.

---

## The Principle: Cognitive Framing Through Roles

Each AI role has an **entry-point file** in the `roles/` folder. That file defines the role's identity, stance, responsibilities, context to load, and explicit boundaries. The entry point contains no knowledge of other roles' internals.

The core insight is **cognitive framing**, not just context isolation. The same model behaves differently when given an Architect's entry point versus a Developer's entry point — even with identical project files loaded. The entry point shapes how the AI interprets the codebase, what it prioritises, and what it ignores.

**Entry points serve two purposes depending on how you use them:**

- **In separate sessions:** the entry point is loaded at session start. It defines the role's entire understanding of the methodology. Context isolation is physical — the Developer literally cannot see the Architect's discussion.
- **In mode switching within a session:** the entry point is used as a framing instruction — "switch to this role, follow these responsibilities and boundaries." The model still carries prior context, but the framing instruction shifts its stance and behaviour. This is weaker isolation but preserves conversational continuity.

Both approaches use the same entry-point files. The Human Lead decides which approach to use per role and per phase.

---

## How Entry Points Work

### What they are

Small, self-contained markdown files in `roles/`. One per AI role. Each is 60–120 lines — deliberately constrained to prevent scope creep.

### What they contain

1. **Identity** — Who the role is, in one or two sentences. Not a job description — a stance. "You design systems and push back on assumptions" is a stance. "You are responsible for phase specs, CONTEXT.md updates, and design rationale" is a job description. The identity sets the AI's posture.

2. **Files to load** — The specific project files this role needs. Not a generic table — the entry point names the files. The Navigator can further refine this per session ("skip the project KEY_INSIGHTS.md — nothing new. But load the phase 2 spec instead").

3. **Responsibilities** — What the role produces. Concrete deliverables, not abstract duties.

4. **Boundaries** — What the role must not do. This is the most important section. Boundaries prevent role bleed. Every entry point has explicit "do not" instructions.

5. **Interaction patterns** — How the role communicates with the Human Lead. What questions it should expect, what format its output should take.

### What they do not contain

- The full methodology (that's `process/`, for humans)
- Other roles' responsibilities or boundaries
- The rationale for why roles are separated (that's this document)
- Cross-references to other entry points

### The constraint that makes this work

Entry points reference **project artefacts** (STATUS.md, phase specs, source code), never **other entry points**. The Navigator doesn't say "the Architect should load X." It says "the next session should load these files: [list]." The Human Lead maps that advice to the right role. This keeps roles genuinely isolated — they share a project state (via STATUS.md), not a process state (via each other).

---

## The Navigator — Advisory, Not Overhead

The Navigator is the lightest role. It's purely advisory — it helps the Human Lead see the big picture and decide what to do next. It doesn't own any upkeep. Journal writing, insight management, and STATUS.md updates are shared responsibilities handled by every role via `roles/common.md`.

**When the Navigator earns a dedicated invocation:**

```
Long break / lost context → Navigator briefs you
Resuming a paused action → Navigator checks what's changed
Complex promotion (task → epic) → Navigator bridges context
Fresh session needed → Navigator generates the handoff prompt
```

**When Navigator duties run inline:**

```
Start of work day (context is fresh) → ask current role "where are we?"
Simple phase handover → active role updates STATUS.md per common.md
Quick tracking update → any role can do this
```

**The Navigator's most valuable output is the handoff prompt.** When the Human Lead decides to open a fresh session for a role, the Navigator generates the exact prompt to paste in — entry point, files to load, context summary, session goal. This eliminates the information loss when the human relays context between sessions manually. If you're not opening separate sessions, you don't need handoff prompts, and the Navigator's value is limited to cold-context briefings and promotion bridging.

**The Navigator bridges promotions.** When an action is promoted (task → epic, epic → goal), the Navigator carries context forward — whether via a handoff prompt (separate sessions) or a context summary (same session). This is the append-forward principle in practice.

---

## Separate Sessions vs. Mode Switching

Role separation serves three purposes. How well each is achieved depends on whether roles run in separate sessions or share one.

**1. Behavioural framing.** An AI given an Architect entry point thinks in systems, trade-offs, and constraints. The same AI given a Developer entry point thinks in code, verification, and literal execution. The entry point shapes which patterns the model activates, how it interprets ambiguity, and what it considers "done." A fresh session provides the cleanest framing. A mode switch within the same session provides weaker but usually adequate framing — the model shifts stance but carries memory of prior roles.

**2. Context efficiency.** In separate sessions, each role loads exactly what it needs — the Developer loads ~50–100 lines, the Architect loads ~300+ lines plus source files. In a shared session, the model carries everything it's seen. This costs tokens but also means the Tech Lead benefits from the Architect discussion without a handoff prompt. The trade-off isn't always obvious — sometimes shared context helps more than clean context.

**3. Clean authority boundaries.** In separate sessions, the Developer physically cannot decide to go back to Planning — it doesn't know Planning exists. In a shared session, authority boundaries are instructional rather than physical, which makes them softer. The Human Lead enforces them by managing the conversation.

**The practical guideline:** the more the work demands disciplined, literal execution (Developer on complex prompts), the more separate sessions help. The more the work demands continuity and shared understanding (Architect → Tech Lead transitions), the more a shared session helps. The Human Lead reads the situation and decides.

---

## Session Persistence Is in the Artefacts, Not the Tool

Regardless of how you manage sessions — one persistent conversation or many separate ones — every piece of state is written down: STATUS.md tracks where you are, the journal tracks what happened, phase specs track the plan, session receipts track what the Developer did. The methodology never relies on an AI role's memory of previous interactions. It relies on written artefacts that any session can read.

**Tools with persistent sessions** benefit from continuity — the Architect's discussion informs the Tech Lead's prompts naturally, and upkeep duties (journal, insights, STATUS.md) are handled by the active role per common.md. The trade-off is role bleed (the model carries all prior context).

**Tools with stateless sessions** benefit from clean role separation — each role starts fresh with exactly the right context. The trade-off is information loss at handoffs, which the Navigator's handoff prompts exist to mitigate.

**Most modern tools (2025+) offer persistence within a session and reset between sessions.** The practical approach: use a single session for Architect + Tech Lead (shared context helps), a fresh session for the Developer on complex work (clean context helps), and invoke the Navigator only when context has gone cold. Adjust based on what you see in the output.

---

## How to Use the Entry Points

### In separate sessions (stateless tools or when you want clean isolation)

1. **Load the entry point** at session start — it's the role's boot sequence.
2. **The entry point tells the role what project files to load.** Follow it, but adjust based on the Navigator's advice if you have one.
3. **Session receipts bridge between sessions.** The Developer's receipt feeds the Tech Lead's next prompt.

### As mode switches (persistent tools or when you want continuity)

1. **Paste the entry point as a framing instruction** — "Switch to this role. Here are your responsibilities and boundaries."
2. **The model carries prior context.** This helps for Architect → Tech Lead transitions (shared understanding). It hurts for anything → Developer transitions (role pollution). Adjust accordingly.
3. **Every role handles its own upkeep per common.md** — update STATUS.md, log in the journal, write key insights. The Navigator is only needed when context has gone cold.

### Choosing a role

| Situation | Role | Session advice |
|---|---|---|
| "I'm setting up a new project" | Bootstrapper | Fresh session — one-time use, does not load common.md |
| "I don't know where we are" | Navigator (or any role) | Navigator if context is cold; otherwise ask the active role |
| "I need to design the next phase" | Architect | Continue or fresh — your call |
| "I need prompts for an approved spec" | Tech Lead | Usually same session as Architect |
| "I need to execute a prompt" | Developer | Fresh session recommended for complex work |
| "Phase is done, what's next?" | Navigator (or active role) | Inline is usually fine |
| "Are our insights still accurate?" | Curator | Dedicated session recommended — broad read access needed |

---

## Scaling

The entry points work identically regardless of project size or action tier. A task-heavy project has many small action folders; a goal-driven project has fewer, deeper ones. The roles operate the same way. The Architect loads the active action's document (TASK.md, EPIC.md, or GOAL.md) and phase SPEC.md whether there's one action or twenty. The entry point says "load the active spec" — it doesn't care about the folder structure's depth or the action's tier.

---

## Maintaining Entry Points

Entry points evolve with the methodology. When a role's responsibilities change in the process documentation, its entry point must be updated to match. The Human Lead owns this alignment — it's part of maintaining the ai-sdlc repo.

The test for a well-maintained entry point: **does the AI produce the right behaviour without reading the process documentation?** If the answer is no, the entry point is missing something. If the entry point exceeds 120 lines, it's absorbing scope that belongs elsewhere.
