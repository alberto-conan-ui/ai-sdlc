# AI-SDLC

A methodology for AI-assisted software development — tool-agnostic, derived from real project experience.

## What This Is

AI coding assistants are powerful executors but unreliable architects. They don't remember previous sessions, don't know why decisions were made, and will happily contradict earlier choices. This methodology fixes that by introducing structured planning, decision tracking, and accumulated lessons that persist across sessions.

The core insight: **session 10 benefits from every mistake caught in sessions 1 through 9** — not through model fine-tuning, but through structured context the AI reads at the start of each session.

## Principles

1. **Plan before you code** — every unit of work gets a written plan before any code is written
2. **Separate the planner from the executor** — the AI that designs the approach shouldn't be the same session that writes the code
3. **Accumulate knowledge across sessions** — decisions, lessons learned, and session logs carry forward
4. **Phases are the unit of work** — bounded chunks with clear goals, concrete steps, and done-criteria
5. **Dig deep before committing to a plan** — read the code, trace paths, identify edge cases
6. **Plans evolve, but changes are tracked** — revisions are logged, never silent
7. **Test at the boundary of what's changing** — baseline behaviour before refactoring

## How It Works

Every project uses a three-folder workspace:

```
my-project-workspace/
├── my-project/           ← Code repo
├── my-project-sdlc/      ← Project journal (specs, plans, decisions, lessons)
└── ai-sdlc/              ← This repo (methodology, shared across projects)
```

Three repos, three concerns: code changes in one, project knowledge in another, and the methodology itself evolves independently. The AI tool mounts the workspace folder to access all three.

## Documentation

| File | Description |
|---|---|
| [PROCESS.md](./PROCESS.md) | The full methodology — principles, workflow, roles, anti-patterns |
| [SETUP.md](./SETUP.md) | Workspace setup guide — how to structure the three-folder convention |
| [TEMPLATES.md](./TEMPLATES.md) | File templates and naming conventions for project journals |

## Quick Start

1. Clone this repo
2. Create a workspace folder for your project (see [SETUP.md](./SETUP.md))
3. Symlink `ai-sdlc/` into the workspace alongside your code repo
4. Create a project journal repo using the templates in [TEMPLATES.md](./TEMPLATES.md)
5. Point your AI tool at the workspace folder

## License

MIT
