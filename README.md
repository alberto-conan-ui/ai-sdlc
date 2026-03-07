# AI-SDLC

A methodology for AI-assisted software development. Tool-agnostic, derived from real project experience.

**This is not vibe coding.** Vibe coding is "give the AI a vague idea, let it generate, hope for the best." It works for throwaway prototypes. It does not work for anything you need to maintain, extend, or trust. AI-SDLC is the deliberate opposite: structured intent, human accountability at every gate, and AI constrained by process — not unleashed without it.

---

## The Problem

AI coding assistants are powerful executors but unreliable architects. They don't remember previous sessions, don't know why decisions were made, and will happily contradict earlier choices. Left unsupervised, they produce code that works locally but accumulates debt globally.

This methodology fixes that. The core mechanism: structured context that persists across sessions. Session 10 benefits from every mistake caught in sessions 1 through 9 — not through model fine-tuning, but through a knowledge base the AI reads at the start of each session.

**This is a human-driven process.** AI-SDLC exists to empower humans through AI, not to replace human judgement with AI output. The AI does more of the work — planning, coding, testing. But the human defines every goal, sets every gatekeep, and approves every plan. If the human disengages, the process breaks. The methodology is only as strong as the person driving it.

## Principles

1. **Goals first, always.** Everything starts with a human-defined goal — abstract, non-technical, outcome-oriented. Every goal has a gatekeep: who decides it's achieved, and what they're evaluating. Without clear goals and gatekeeps, the process optimises for technical correctness while potentially missing what the human actually wanted. See [PROCESS.md](./PROCESS.md) for the full goals and gatekeeping framework.

2. **Planning is now cheap — so plan aggressively.** LLMs can hold an entire codebase in context and produce a detailed plan in minutes. The cognitive bottleneck that made upfront planning impractical for humans doesn't apply to AI. This isn't waterfall — the plans are disposable and get revised constantly. The discipline of producing them is what matters.

3. **Five roles, clear separation.** The Human Lead defines goals and gatekeeps. The Navigator orients — "where are we, what's next, what context do you need." The Senior Architect designs the approach and pushes back. The Technical Lead writes implementation prompts and reviews output. The Developer writes code. Each AI role runs in a separate session with its own context. See [PROCESS.md](./PROCESS.md) for the full role definitions.

4. **Accumulate knowledge across sessions.** Decisions, lessons learned, and session logs persist in a structured knowledge base. Each new session loads this context. The AI effectively gets better at your project over time.

5. **Phases are the unit of work.** Every piece of work is a bounded phase with a clear goal, concrete steps, and done-criteria. Small enough to finish in 1-3 sessions. Self-contained for review. Clean rollback boundaries.

6. **Plans evolve, but changes are tracked.** Specs are living documents. When new information emerges, the plan gets revised — with a version bump, a decision log entry, and a journal note. Silent changes are forbidden.

## How It Works

Every project uses a three-folder workspace:

```
my-project-workspace/
├── my-project/           ← Code repo
├── my-project-journal/    ← Project journal (specs, plans, decisions, lessons)
└── ai-sdlc/              ← This repo (methodology, shared across projects)
```

Three repos, three concerns. Code in one, project knowledge in another, the methodology itself evolving independently. The AI tool mounts the workspace folder to access all three.

The process scales. For a two-week feature, you might use a single PLAN.md with inline phase specs. For a multi-month effort, you use the full structure with workstreams, phase folders, and numbered implementation prompts. See [PROCESS.md](./PROCESS.md) for the scaling guidance.

## Documentation

| File | What it covers |
|---|---|
| [PROCESS.md](./PROCESS.md) | The full methodology — workflow, roles, scaling, anti-patterns (human-facing) |
| [MECHANICS.md](./MECHANICS.md) | Context isolation architecture — why AI roles use entry points, not PROCESS.md |
| [PROMPTS.md](./PROMPTS.md) | How to write effective implementation prompts for Developer sessions |
| [SETUP.md](./SETUP.md) | Workspace setup — the three-folder convention |
| [TEMPLATES.md](./TEMPLATES.md) | File templates, naming conventions, project journal structure |
| [roles/](./roles/) | AI role entry points — one file per role, loaded at session start |

## Quick Start

1. Clone this repo
2. Set up a workspace folder for your project (see [SETUP.md](./SETUP.md))
3. Create a project journal repo using the templates in [TEMPLATES.md](./TEMPLATES.md)
4. Read [PROCESS.md](./PROCESS.md) to understand the workflow
5. Read [MECHANICS.md](./MECHANICS.md) to understand the context isolation architecture
6. Read [PROMPTS.md](./PROMPTS.md) before writing your first implementation prompts
7. Point your AI tool at the workspace folder. Load a role entry point from `roles/` — start with the [Navigator](./roles/navigator.md)

## License

MIT
