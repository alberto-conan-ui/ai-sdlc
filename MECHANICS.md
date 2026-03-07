# AI-SDLC: Mechanics — Context Isolation by Role

> Why AI roles don't read this methodology. How the entry-point system works.
> This document is for the Human Lead. AI roles read their entry points in `roles/`.

---

## The Problem

PROCESS.md describes the full methodology: roles, modes, workflows, anti-patterns. It's written for a human who needs the complete picture. But AI sessions are not humans reading a manual — they're workers performing a bounded job. When an AI role loads the full methodology, three things go wrong.

**Context waste.** The Developer doesn't need to know how the Architect thinks. The Navigator doesn't need prompt craft guidance. The Architect doesn't need the Developer's stance on unexpected failures. Every role pays the token cost of the full methodology, but most of that context is irrelevant to its task. In a context window with hard limits, irrelevant tokens displace useful ones — the source files, the phase spec, the lessons learned.

**Role bleed.** This is the more insidious problem. An AI that knows about other roles' responsibilities starts doing their jobs. An Architect that knows the Developer's constraints over-specifies implementation details instead of designing systems. A Developer that knows the Architect's reasoning second-guesses the prompt instead of following it. A Navigator that knows about prompt craft starts writing prompts. Knowledge shapes behaviour — even knowledge the role shouldn't act on.

**No formal boot sequence.** Without a defined entry point, context loading is manual and inconsistent. The Human Lead has to remember which files each role needs, or the AI loads everything "just in case." Both lead to the same outcome: expensive sessions with unfocused context and unpredictable behaviour.

---

## The Principle: Context Isolation

Each AI role reads **one entry-point file** from the `roles/` folder. That file is the role's entire understanding of the methodology. It tells the AI:

- What its role is (identity and stance)
- Which project files to load (and which to ignore)
- What its responsibilities are (specific, bounded)
- What it must not do (explicit boundaries)

The entry point contains **no knowledge of other roles' internals**. The Navigator doesn't know how the Architect designs phase specs. The Developer doesn't know how the Tech Lead writes prompts. Each role operates within its own context boundary.

This isn't just about saving tokens (though it does). It's about **cognitive framing**. The same model behaves differently when given an Architect's entry point versus a Developer's entry point — even with identical project files loaded. The entry point shapes how the AI interprets the codebase, what it prioritises, and what it ignores. Role separation is a behavioural tool, not just a cost optimisation.

---

## How Entry Points Work

### What they are

Small, self-contained markdown files in `roles/`. One per AI role. Each is 60–120 lines — deliberately constrained to prevent scope creep.

### What they contain

1. **Identity** — Who the role is, in one or two sentences. Not a job description — a stance. "You design systems and push back on assumptions" is a stance. "You are responsible for phase specs, CONTEXT.md updates, and design rationale" is a job description. The identity sets the AI's posture.

2. **Files to load** — The specific project files this role needs. Not a generic table — the entry point names the files. The Navigator further refines this per session ("skip DECISIONS.md, load the phase 2 spec instead").

3. **Responsibilities** — What the role produces. Concrete deliverables, not abstract duties.

4. **Boundaries** — What the role must not do. This is the most important section. Boundaries prevent role bleed. Every entry point has explicit "do not" instructions.

5. **Interaction patterns** — How the role communicates with the Human Lead. What questions it should expect, what format its output should take.

### What they do not contain

- The full methodology (that's PROCESS.md, for humans)
- Other roles' responsibilities or boundaries
- The rationale for why roles are separated (that's this document)
- Cross-references to other entry points

### The constraint that makes this work

Entry points reference **project artefacts** (TRACKING.md, phase specs, source code), never **other entry points**. The Navigator doesn't say "the Architect should load X." It says "the next session should load these files: [list]." The Human Lead maps that advice to the right role. This keeps roles genuinely isolated — they share a project state (via TRACKING.md), not a process state (via each other).

---

## The Navigator as Default Entry Point

The Navigator is the cheapest role (lightest context load) and the one that prevents the most expensive mistakes (stale context feeding into an Architect or Tech Lead session).

**When the Human Lead doesn't know where things stand** — which is the common case at the start of a work day — the Navigator is the first session. It reads TRACKING.md and the recent journal, produces a 3–5 line briefing, and advises which files the next role should load. This costs a few hundred tokens of project-artefact context. The alternative — loading a full Architect session to figure out where you are — costs thousands of tokens of source code and spec context before you even know whether the Architect is the right role.

**The Navigator is the router.** It answers "where are we?" and "what context does the next role need?" This routing function is what earns the Navigator its place as a separate role. It's not doing work that another role could absorb — it's doing the meta-work that makes every other role effective.

**When you don't need the Navigator:** If you already know the current state (you just finished a session, you remember the phase and prompt number), skip the Navigator and go directly to the working role. The Navigator is for orientation, not ceremony.

---

## Why Separate Sessions

Role separation serves three purposes, in order of importance:

**1. Behavioural framing.** An AI given an Architect entry point thinks in systems, trade-offs, and constraints. The same AI given a Developer entry point thinks in code, verification, and literal execution. This isn't metaphor — the entry point shapes which patterns the model activates, how it interprets ambiguity, and what it considers "done." Mixing roles in one session produces an AI that's neither a good architect nor a good developer.

**2. Context efficiency.** The Developer loads one implementation prompt (~50–100 lines). The Architect loads the full knowledge base (~300+ lines) plus source files. If every session loaded Architect-level context, you'd pay for tokens that don't improve code quality. If the Architect loaded Developer-level context, it would miss the big picture. Each role loads exactly what it needs.

**3. Clean authority boundaries.** The Developer cannot decide to go back to Planning — it follows prompts. The Tech Lead can flag a phase-level issue but cannot authorise a mode transition. Only the Human Lead switches modes. When roles are in separate sessions, these authority boundaries are physical, not just instructional.

---

## How to Use the Entry Points

### Starting a work session

1. **Open your AI tool.** Point it at the workspace folder.
2. **Pick a role.** If you don't know where things stand, start with the Navigator. If you do know, pick the role for what you're doing.
3. **Load the entry point.** Tell the AI to read the role's entry point file and follow its instructions for loading project files.
4. **Do the work.** The AI operates within the boundaries defined by its entry point.
5. **End the session.** Run the Navigator to update tracking artefacts.

### The typical session sequence

```
Navigator (brief) → [Architect | Tech Lead | Developer] (work) → Navigator (update)
```

The Navigator bookends the working session. This is the mechanism that prevents amnesia between sessions — the Navigator captures what happened and prepares context for the next one.

### Choosing a role

| Situation | Role |
|---|---|
| "I don't know where we are" | Navigator |
| "I need to design the next phase" | Architect |
| "I need prompts for an approved spec" | Tech Lead |
| "I need to execute a prompt" | Developer |
| "I just finished work and need to log it" | Navigator |

---

## Scaling

The entry points work identically in lite mode and full mode. The difference is which project files exist (inline specs in PLAN.md vs. separate phase folders), not how the roles operate. An Architect in lite mode loads PLAN.md with inline specs. An Architect in full mode loads the phase-specific SPEC.md. The entry point says "load the active spec" — it doesn't care about the folder structure.

---

## Maintaining Entry Points

Entry points evolve with the methodology. When a role's responsibilities change in PROCESS.md, its entry point must be updated to match. The Human Lead owns this alignment — it's part of maintaining the ai-sdlc repo.

The test for a well-maintained entry point: **does the AI produce the right behaviour without reading PROCESS.md?** If the answer is no, the entry point is missing something. If the entry point exceeds 120 lines, it's absorbing scope that belongs elsewhere.
