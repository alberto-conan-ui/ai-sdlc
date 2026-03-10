# AI-SDLC

A methodology for AI-assisted software development. Tool-agnostic, derived from real project experience.

**This is not vibe coding.** Vibe coding is "give the AI a vague idea, let it generate, hope for the best." It works for throwaway prototypes. It does not work for anything you need to maintain, extend, or trust. AI-SDLC is the deliberate opposite: structured intent, human accountability at every gate, and AI constrained by process — not unleashed without it.

---

## The Problem

AI coding assistants are powerful executors but unreliable architects. They don't remember previous sessions, don't know why decisions were made, and will happily contradict earlier choices. Left unsupervised, they produce code that works locally but accumulates debt globally.

This methodology fixes that. The core mechanism: structured context that persists across sessions. Session 10 benefits from every mistake caught in sessions 1 through 9 — not through model fine-tuning, but through a knowledge base the AI reads at the start of each session.

**This is a human-driven process for senior developers.** AI-SDLC exists to empower humans through AI, not to replace human judgement with AI output. The AI does more of the work — planning, coding, testing. But the human defines every action, sets every gatekeep, and approves every plan. Every review gate requires experienced judgement — evaluating AI-generated specs, spotting subtle bugs in AI-written code, knowing when to push back. If the human disengages, the process breaks. The methodology is only as strong as the person driving it.

**Use it for the right work.** Not everything needs this process. A one-line fix, a config change, a dependency bump — just do it. AI-SDLC earns its keep when the work has dependencies, touches shared state, or requires decisions that constrain future work. The test: would you benefit from a written plan before coding this? If yes, create an action. If not, skip the process. See [PROCESS.md](./PROCESS.md) for the full guidance.

## Principles

1. **Actions first, always.** Everything starts with a human-defined action — a task, an epic, or a goal. Each has a gatekeep: who decides it's achieved, and what they're evaluating. Without clear actions and gatekeeps, the process optimises for technical correctness while potentially missing what the human actually wanted. See [PROCESS.md](./PROCESS.md) for the full actions and gatekeeping framework.

2. **Three tiers, right-sized ceremony.** Not all work is the same size. A bug fix (task) needs a quick spec and a prompt. A multi-phase refactor (epic) needs full planning. A product-shaping aspiration (goal) needs a GOAL.md with design principles and an abstract gatekeep. The tier determines how much process — but the machinery underneath is the same. See [PROCESS.md](./PROCESS.md) for the tier definitions.

3. **Planning is now cheap — so plan aggressively.** LLMs can hold an entire codebase in context and produce a detailed plan in minutes. The cognitive bottleneck that made upfront planning impractical for humans doesn't apply to AI. This isn't waterfall — the plans are disposable and get revised constantly. The discipline of producing them is what matters.

4. **Six AI stances, one practitioner.** This is a solo framework. You shift the AI between cognitive stances: the Bootstrapper sets up new projects (used once), the Architect designs and pushes back, the Tech Lead writes implementation prompts, the Developer writes code, the Navigator provides orientation when context is cold, and the Curator maintains the project's accumulated knowledge. A shared foundation (`roles/common.md`) gives the ongoing stances journal, insight, and tracking responsibilities. Each stance has an entry point in [`roles/`](./roles/). In practice, you'll usually stay in one session and shift stances as the conversation flows — separate sessions are the escalation path for complex work (see [MECHANICS.md](./MECHANICS.md)).

5. **Accumulate knowledge across sessions.** A rolling journal captures everything chronologically. Key insights are curated from the journal and placed at the right scope — project, action, or phase level. Each new session loads the relevant insights. The AI effectively gets better at your project over time.

6. **Phases are the unit of work.** Every piece of work is a bounded phase with a clear goal, concrete steps, and done-criteria. Small enough to finish in 1-3 sessions. Self-contained for review. Clean rollback boundaries.

7. **Append-forward, never rewrite.** The journal moves forward, never backward. When a plan changes, the new plan is a new artefact. When a task outgrows its scope, a new epic is created — the task stays as-is. Promotion, revision, and abandonment are all forward moves. The Navigator bridges context across promotions when needed.

## How It Works

Every project uses a three-folder workspace:

```
my-project-workspace/
├── my-project/           ← Code repo
├── my-project-journal/   ← Project journal (specs, plans, insights, journal)
│   ├── STATUS.md
│   ├── KEY_INSIGHTS.md   ← Project-level insights (curated from journal)
│   ├── CONTEXT.md
│   ├── journal/          ← Raw chronological log (weekly rolling files)
│   └── actions/
│       ├── task-fix-login-bug/
│       ├── epic-refactor-validation/
│       │   ├── EPIC.md
│       │   ├── KEY_INSIGHTS.md
│       │   └── phases/
│       │       └── N-phase-name/
│       │           ├── SPEC.md
│       │           ├── KEY_INSIGHTS.md
│       │           └── impl/
│       └── goal-plugin-architecture/
└── ai-sdlc/              ← This repo (methodology, shared across projects)
```

Three repos, three concerns. Code in one, project knowledge in another, the methodology itself evolving independently. The AI tool mounts the workspace folder to access all three.

The process scales through the tier system, not through mode switches. A bug fix is a task — one phase, done quickly. A feature is an epic — multiple phases, concrete gatekeep. A product direction is a goal — multiple phases, abstract gatekeep, design principles. The structure is the same; what changes is the depth and ceremony.

## Documentation

| File | What it covers |
|---|---|
| [SEED-PROMPT.md](./SEED-PROMPT.md) | The prompt to paste into your AI tool to start setup |
| [BOOTSTRAP.md](./BOOTSTRAP.md) | AI-facing entry point fetched during setup (you don't need to read this) |
| [ROADMAP.md](./ROADMAP.md) | Where this methodology stands — known gaps, deferred work, what's next |
| [FLOWS.md](./FLOWS.md) | Practical walkthroughs — start here to see the process in action |
| [PROCESS.md](./PROCESS.md) | The full methodology — actions, tiers, workflow, roles, scaling, anti-patterns (human-facing) |
| [MECHANICS.md](./MECHANICS.md) | Context isolation and role framing — entry points, session management, trade-offs |
| [PROMPTS.md](./PROMPTS.md) | How to write effective implementation prompts for Developer sessions |
| [SETUP.md](./SETUP.md) | Workspace setup — the three-folder convention |
| [TEMPLATES.md](./TEMPLATES.md) | File templates, naming conventions, project journal structure |
| [roles/](./roles/) | AI role entry points — one file per role, loaded at session start or as mode switches |

## Getting Started

### With an AI tool (recommended)

1. Create a folder for your workspace
2. Point your AI tool (Cowork, Claude Code, or similar) at that folder
3. Paste the seed prompt from [SEED-PROMPT.md](./SEED-PROMPT.md)

The AI will fetch the bootstrap instructions, walk you through cloning repos and creating the project journal, and leave your workspace in INCEPTION mode — ready for your first session with the Architect.

### Manual setup

See [SETUP.md](./SETUP.md) for the full manual process.

### Learn the methodology

Once set up, these documents explain how things work:

1. Read a flow in [FLOWS.md](./FLOWS.md) to see the process in action — the fastest way to understand how everything fits together
2. Read [PROCESS.md](./PROCESS.md) for the full methodology and reference
3. Read [MECHANICS.md](./MECHANICS.md) to understand the context isolation architecture
4. Read [PROMPTS.md](./PROMPTS.md) before writing your first implementation prompts

## License

MIT
