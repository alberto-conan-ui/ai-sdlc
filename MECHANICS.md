# AI-SDLC: Mechanics — Context Isolation by Role

> Why AI roles don't read this methodology. How the entry-point system works.
> This document is for the Human Lead. AI roles read their entry points in `roles/`.

---

## The Problem

PROCESS.md describes the full methodology: roles, modes, workflows, anti-patterns. It's written for a human who needs the complete picture. But AI sessions are not humans reading a manual — they're workers performing a bounded job. When an AI role loads the full methodology, three things go wrong.

**Context waste.** The Developer doesn't need to know how the Architect thinks. The Orchestrator doesn't need prompt craft guidance. The Architect doesn't need the Developer's stance on unexpected failures. Every role pays the token cost of the full methodology, but most of that context is irrelevant to its task. In a context window with hard limits, irrelevant tokens displace useful ones — the source files, the phase spec, the lessons learned.

**Role bleed.** This is the more insidious problem. An AI that knows about other roles' responsibilities starts doing their jobs. An Architect that knows the Developer's constraints over-specifies implementation details instead of designing systems. A Developer that knows the Architect's reasoning second-guesses the prompt instead of following it. An Orchestrator that knows about prompt craft starts writing prompts. Knowledge shapes behaviour — even knowledge the role shouldn't act on.

**No formal boot sequence.** Without a defined entry point, context loading is manual and inconsistent. The Human Lead has to remember which files each role needs, or the AI loads everything "just in case." Both lead to the same outcome: expensive sessions with unfocused context and unpredictable behaviour.

---

## The Principle: Context Isolation

Each AI role reads **one entry-point file** from the `roles/` folder. That file is the role's entire understanding of the methodology. It tells the AI:

- What its role is (identity and stance)
- Which project files to load (and which to ignore)
- What its responsibilities are (specific, bounded)
- What it must not do (explicit boundaries)

The entry point contains **no knowledge of other roles' internals**. The Orchestrator doesn't know how the Architect designs phase specs. The Developer doesn't know how the Tech Lead writes prompts. Each role operates within its own context boundary.

This isn't just about saving tokens (though it does). It's about **cognitive framing**. The same model behaves differently when given an Architect's entry point versus a Developer's entry point — even with identical project files loaded. The entry point shapes how the AI interprets the codebase, what it prioritises, and what it ignores. Role separation is a behavioural tool, not just a cost optimisation.

---

## How Entry Points Work

### What they are

Small, self-contained markdown files in `roles/`. One per AI role. Each is 60–120 lines — deliberately constrained to prevent scope creep.

### What they contain

1. **Identity** — Who the role is, in one or two sentences. Not a job description — a stance. "You design systems and push back on assumptions" is a stance. "You are responsible for phase specs, CONTEXT.md updates, and design rationale" is a job description. The identity sets the AI's posture.

2. **Files to load** — The specific project files this role needs. Not a generic table — the entry point names the files. The Orchestrator further refines this per session ("skip DECISIONS.md, load the phase 2 spec instead").

3. **Responsibilities** — What the role produces. Concrete deliverables, not abstract duties.

4. **Boundaries** — What the role must not do. This is the most important section. Boundaries prevent role bleed. Every entry point has explicit "do not" instructions.

5. **Interaction patterns** — How the role communicates with the Human Lead. What questions it should expect, what format its output should take.

### What they do not contain

- The full methodology (that's PROCESS.md, for humans)
- Other roles' responsibilities or boundaries
- The rationale for why roles are separated (that's this document)
- Cross-references to other entry points

### The constraint that makes this work

Entry points reference **project artefacts** (STATUS.md, phase specs, source code), never **other entry points**. The Orchestrator doesn't say "the Architect should load X." It says "the next session should load these files: [list]." The Human Lead maps that advice to the right role. This keeps roles genuinely isolated — they share a project state (via STATUS.md), not a process state (via each other).

---

## The Orchestrator — The Human Lead's Companion

The Orchestrator is fundamentally different from the other roles. The Architect, Tech Lead, and Developer are workers — you open a session, they do a job, the session ends. The Orchestrator is a companion — it stays open. The Human Lead tabs back to it between every role session.

This changes the workflow. Instead of "run a Navigator session to get a briefing, close it, run an Architect, close it, run a Navigator to update tracking," the Orchestrator is always there:

```
[Orchestrator always open]
   ├── Human asks: "where are we?" → Orchestrator briefs
   ├── Human: "what next?" → Orchestrator generates handoff prompt for Architect
   ├── Human pastes handoff prompt into Architect session → does design work → closes it
   ├── Human tabs back: "just finished with the Architect, what next?"
   │   → Orchestrator updates tracking, generates handoff prompt for Tech Lead
   ├── Human pastes handoff prompt into Tech Lead session → writes prompts → closes it
   ├── Human tabs back: "prompts are done, ready for implementation?"
   │   → Orchestrator updates tracking, generates handoff prompt for Developer
   └── ...
```

**The Orchestrator reduces gate fatigue.** The methodology has many review gates — spec review, prompt review, phase completion, gatekeep evaluation. Without the Orchestrator, the Human Lead has to remember which gate they're at, what's pending, and what the next step is. With the Orchestrator, they just ask. The process has the same rigour, but the human doesn't have to carry the process state in their head.

**The Orchestrator earns its place by being cheap.** It loads only tracking artefacts — STATUS.md, JOURNAL.md, STATUS.md. No source code, no specs, no prompts. This means the context window stays small, responses are fast, and the cost per interaction is minimal. You can ask the Orchestrator ten questions in the time it takes to load one Architect session.

**The Orchestrator generates handoff prompts.** This is its most valuable output. When the Human Lead finishes with one role and needs to start another, the Orchestrator produces the exact prompt to paste into the new session — including which entry point to load, which project files to read, what just happened, and what the session needs to achieve. This solves the context transfer problem: the human is normally the relay between roles, and humans are lossy relays. They forget what decisions were made, which files changed, what constraints apply. The handoff prompt packages everything the Orchestrator knows into a ready-to-use opening for the next role, eliminating that information loss.

**When you don't need the Orchestrator:** If you already know the current state and the next step, go directly to the working role. The Orchestrator is for guidance, not ceremony. But most of the time — especially at the start of a work day, or after a complex session — the Orchestrator is where you start.

---

## Why Separate Sessions

Role separation serves three purposes, in order of importance:

**1. Behavioural framing.** An AI given an Architect entry point thinks in systems, trade-offs, and constraints. The same AI given a Developer entry point thinks in code, verification, and literal execution. This isn't metaphor — the entry point shapes which patterns the model activates, how it interprets ambiguity, and what it considers "done." Mixing roles in one session produces an AI that's neither a good architect nor a good developer.

**2. Context efficiency.** The Developer loads one implementation prompt (~50–100 lines). The Architect loads the full knowledge base (~300+ lines) plus source files. If every session loaded Architect-level context, you'd pay for tokens that don't improve code quality. If the Architect loaded Developer-level context, it would miss the big picture. Each role loads exactly what it needs.

**3. Clean authority boundaries.** The Developer cannot decide to go back to Planning — it follows prompts. The Tech Lead can flag a phase-level issue but cannot authorise a mode transition. Only the Human Lead switches modes. When roles are in separate sessions, these authority boundaries are physical, not just instructional.

---

## How to Use the Entry Points

### The typical workflow

1. **Open the Orchestrator.** This is your home base. Load `roles/orchestrator.md`.
2. **Ask where you are.** The Orchestrator reads tracking artefacts and briefs you.
3. **Open a working role.** Based on the Orchestrator's advice, open an Architect, Tech Lead, or Developer session with its entry point.
4. **Do the work.** The working role operates within its boundaries.
5. **Tab back to the Orchestrator.** Tell it what happened. It updates tracking and advises the next step.

The Orchestrator stays open throughout. Working roles open and close as needed.

### Choosing a role

| Situation | Role |
|---|---|
| "I don't know where we are" | Orchestrator |
| "What should I do next?" | Orchestrator |
| "I need to design the next phase" | Architect |
| "I need prompts for an approved spec" | Tech Lead |
| "I need to execute a prompt" | Developer |
| "I just finished with a role session" | Orchestrator |

---

## Scaling

The entry points work identically in lite mode and full mode. The difference is which project files exist (inline specs in STATUS.md vs. separate phase folders), not how the roles operate. An Architect in lite mode loads STATUS.md with inline specs. An Architect in full mode loads the goal's GOAL.md and the phase-specific SPEC.md. The entry point says "load the active spec" — it doesn't care about the folder structure.

---

## Maintaining Entry Points

Entry points evolve with the methodology. When a role's responsibilities change in PROCESS.md, its entry point must be updated to match. The Human Lead owns this alignment — it's part of maintaining the ai-sdlc repo.

The test for a well-maintained entry point: **does the AI produce the right behaviour without reading PROCESS.md?** If the answer is no, the entry point is missing something. If the entry point exceeds 120 lines, it's absorbing scope that belongs elsewhere.
