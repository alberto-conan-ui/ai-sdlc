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

2. **Files to load** — The specific project files this role needs. Not a generic table — the entry point names the files. The Orchestrator further refines this per session ("skip the project KEY_INSIGHTS.md — nothing new. But load the phase 2 spec instead").

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

## The Orchestrator — Home Base

The Orchestrator is fundamentally different from the other roles. The Architect, Tech Lead, and Developer are workers — you open a session, they do a job, the session ends. The Orchestrator is a home base — it provides orientation and guidance when you need it.

**Where the Orchestrator earns its place:**

```
Start of work day → Orchestrator briefs you
    ↓
Architect session → define goal, design roadmap, write spec
    ↓
Orchestrator → logs, updates tracking, hands off to Tech Lead
    ↓
Tech Lead + Developer loop (Orchestrator stays out)
    ↓
Phase done → Orchestrator → logs, suggests Architect for next phase
    ↓
Repeat
```

**The key insight: the Orchestrator is for transitions, not for every interaction.** During implementation, the Tech Lead and Developer pass context to each other through session receipts. The Orchestrator adds no value between prompts — the session receipt is the context bridge. The Orchestrator earns its keep at phase handovers (logging what happened, suggesting the next move), at the start of a work day (bringing you up to speed), and when you've lost track of where things stand.

**The Orchestrator generates handoff prompts.** This is its most valuable output. When the Human Lead needs to start a new role session, the Orchestrator produces the exact prompt to paste in — which entry point to load, which project files to read, what just happened, what the session needs to achieve. This solves the context transfer problem: the human is normally the relay between roles, and humans are lossy relays. The handoff prompt packages everything into a ready-to-use opening for the next role, eliminating information loss.

**The Orchestrator is cheap.** It loads only tracking artefacts — STATUS.md and recent journal files. No source code, no specs, no prompts. Fast responses, minimal cost.

**The Orchestrator bridges promotions.** When an action is promoted (task → epic, epic → goal), the Orchestrator carries context forward via handoff prompts — the append-forward principle in practice.

**When you don't need the Orchestrator:** during implementation (Tech Lead and Developer handle their own context), and when you already know the current state and the next step. Go directly to the working role.

---

## Why Separate Sessions

Role separation serves three purposes, in order of importance:

**1. Behavioural framing.** An AI given an Architect entry point thinks in systems, trade-offs, and constraints. The same AI given a Developer entry point thinks in code, verification, and literal execution. This isn't metaphor — the entry point shapes which patterns the model activates, how it interprets ambiguity, and what it considers "done." Mixing roles in one session produces an AI that's neither a good architect nor a good developer.

**2. Context efficiency.** The Developer loads one implementation prompt (~50–100 lines). The Architect loads the full knowledge base (~300+ lines) plus source files. If every session loaded Architect-level context, you'd pay for tokens that don't improve code quality. If the Architect loaded Developer-level context, it would miss the big picture. Each role loads exactly what it needs.

**3. Clean authority boundaries.** The Developer cannot decide to go back to Planning — it follows prompts. The Tech Lead can flag a phase-level issue but cannot authorise a mode transition. Only the Human Lead switches modes. When roles are in separate sessions, these authority boundaries are physical, not just instructional.

---

## Session Persistence Is in the Artefacts, Not the Tool

Some AI tools maintain persistent sessions — the Orchestrator stays open across role switches and retains its full conversation history. Others reset context with every new conversation. Both work with this methodology, because persistence lives in the written artefacts, not in the AI's memory.

Every piece of state is written down: STATUS.md tracks where you are, the journal tracks what happened, phase specs track the plan, session receipts track what the Developer did. When the Orchestrator opens a fresh session, it loads its entry point, reads STATUS.md and the recent journal, and knows exactly where things stand — not because it remembers, but because everything was recorded.

Tools with persistent sessions get convenience: the Orchestrator doesn't need to reload context between role switches. Tools without persistent sessions get the same information, just re-read from disk. The handoff prompts the Orchestrator generates are especially valuable in stateless tools — they're the packaged context bridge that would otherwise be lost between conversations.

This is a deliberate design choice. The methodology never relies on an AI role's memory of previous interactions. It relies on written artefacts that any session can read. If your tool offers persistence, you benefit from faster Orchestrator interactions. If it doesn't, the process still works — the journal and STATUS.md are the memory.

---

## How to Use the Entry Points

### The typical workflow

1. **Open the Orchestrator** when you need orientation — start of day, after a break, at phase handovers.
2. **Open working roles** based on the Orchestrator's advice (or your own judgement). Architect for planning, Tech Lead for prompts, Developer for execution.
3. **During implementation,** the Tech Lead and Developer cycle directly — session receipts are the context bridge. No Orchestrator between prompts.
4. **At phase handovers,** return to the Orchestrator. It logs, updates tracking, and suggests the next move.

Working roles open and close as needed. The Orchestrator is there when you need it.

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

The entry points work identically regardless of project size or action tier. A task-heavy project has many small action folders; a goal-driven project has fewer, deeper ones. The roles operate the same way. The Architect loads the active action's document (TASK.md, EPIC.md, or GOAL.md) and phase SPEC.md whether there's one action or twenty. The entry point says "load the active spec" — it doesn't care about the folder structure's depth or the action's tier.

---

## Maintaining Entry Points

Entry points evolve with the methodology. When a role's responsibilities change in PROCESS.md, its entry point must be updated to match. The Human Lead owns this alignment — it's part of maintaining the ai-sdlc repo.

The test for a well-maintained entry point: **does the AI produce the right behaviour without reading PROCESS.md?** If the answer is no, the entry point is missing something. If the entry point exceeds 120 lines, it's absorbing scope that belongs elsewhere.
