# Flow: Starting a Session

> From cold start to productive work in one line. This flow covers how `ai_readme.md` and the AUTO skill work together to eliminate session setup friction.

---

## The Problem

Every AI session starts from zero. The AI has no memory of your project, your conventions, your current work, or where you left off. Without intervention, you spend the first five minutes of every session re-explaining context the AI already learned yesterday.

This matters more than it sounds. A typical action might span 6–10 sessions across multiple stances — Architect and Tech Lead — each needing full project context. If each session starts with manual context loading, that's an hour of overhead before any real work begins.

## The Solution

AI-SDLC solves this with two pieces that work together:

1. **`ai_readme.md`** — a file at the root of your code repo that tells the AI how to orient itself. It points to the workspace layout, the memory model, the stance definitions, and the current status. This file is created during setup (see [bootstrap/README.md](../bootstrap/README.md) Step B); you never write it from scratch.

2. **AUTO** — a Cowork skill that reads `ai_readme.md` and follows its instructions automatically. It loads whatever the file says to load, confirms briefly, and waits for your first real task.

The combination means you can open a new Cowork session, type one line, and be productive immediately.

---

## The One-Liner

```
AUTO architect: where are we?
```

That's it. This single line does three things:

1. **AUTO** triggers the skill, which finds and reads `ai_readme.md`
2. **architect** tells the AI which stance to adopt (Architect)
3. **where are we?** is your first task — the AI orients you on the current state

The AI loads the workspace mapping, reads the action tree status, loads the Architect stance files, and responds with a situational briefing. No preamble, no setup ceremony, no re-explaining what the project is.

---

## Variations

The pattern is always `AUTO [stance]: [task]`. Some examples:

| You type | What happens |
|---|---|
| `AUTO architect: where are we?` | Loads context, adopts Architect stance, gives you a status briefing |
| `AUTO architect: let's plan the next action` | Loads context, Architect stance, starts planning |
| `AUTO tech-lead: implement phase 2` | Loads context, Tech Lead stance, begins implementation |
| `AUTO auditor: review process health` | Loads context, Auditor stance, evaluates methodology compliance |

You can also use AUTO without a stance if you just want context loaded and will decide later:

```
AUTO
```

The AI loads context, confirms what it found, and waits.

---

## What Happens in Practice

To illustrate what this looks like in a real project, here's what happened on the first day of a bootstrapped monorepo project — a multi-framework UI component library with ~80k lines of TypeScript across Nx workspaces.

### Bootstrap to first action: minutes, not hours

The workspace was bootstrapped and the first action defined in a single session. From that point forward, every new session started the same way:

```
AUTO architect: where are we?
```

The AI loaded the workspace layout, read `status.md`, identified the active action and its current phase, loaded the Architect stance files and knowledge tree, and responded with a situational briefing. The human never had to explain what the project was, what the monorepo structure looked like, or what was being worked on.

### Session continuity across stance switches

The action involved moving a framework-agnostic pipeline (~82 files, ~5,200 lines) from a demo app to a shared library. This required multiple stances working in sequence:

- **Architect sessions** — scoped the action, investigated a type conflict discovered during implementation, established a design rule, defined phases, triaged a CI failure, performed a pre-PR review
- **Tech Lead sessions** — implemented phases directly, wrote bounded prompts for complex sections, updated knowledge tree rules after finding an ambiguity that caused three wasted iterations

Each session started with the same one-liner. The AI loaded `status.md`, saw which phase was active, and what the next step was. No time was spent on orientation.

### Memory accumulation across sessions

By the end of the day, the project memory had grown organically:

- **Action tree** — one completed action (2 phases, 5 prompts), one backlog item discovered during implementation and scoped out to keep the PR clean
- **Knowledge tree** — 3 area-specific nodes (DX architecture, import/export conventions, testing patterns) plus root-level insights including pre-push and pre-PR verification gates born from actual CI failures
- **Journal** — 5 entries capturing architectural decisions, process improvements, and a lesson about how knowledge tree rules should be written (state the rule, show the right pattern, stop — never name the prohibited pattern as an exception, because readers anchor on exceptions)

Every subsequent `AUTO` call loaded this accumulated knowledge. The AI in session 8 knew things the AI in session 1 didn't — not because it remembered, but because the memory model made it available.

### What this means for the one-liner

The one-liner isn't just a convenience. It's what makes the multi-session, multi-stance workflow practical. Without it, each of those 8+ sessions would have required manually loading the status file, the relevant stance, the knowledge tree nodes, and the journal. With it, every session started productive within seconds.

---

## What ai_readme.md Actually Does

The `ai_readme.md` file is the session entry point. It lives at the root of your code repo (gitignored) and contains:

- **Workspace layout** — where to find `.ai-sdlc/`, memory, methodology
- **Session start protocol** — a step-by-step sequence: read status, determine stance, load files, announce
- **Stance dispatch table** — maps natural language ("let's plan") to stance files
- **Quick reference** — paths to status, knowledge tree, journal, roles

The file is generated during [Step B of bootstrap](../bootstrap/README.md) using the [ai_readme.template.md](../bootstrap/ai_readme.template.md) template. It is project-specific — the template fills in paths and structure based on your actual workspace layout.

You should not need to edit `ai_readme.md` after bootstrap. If your workspace layout changes (rare), regenerate it by re-running the setup steps in bootstrap/README.md.

---

## How AUTO Reads It

The AUTO skill is intentionally minimal. Its entire logic is:

1. Find `ai_readme.md` in the workspace folder
2. Read it
3. Follow whatever instructions it contains
4. Confirm briefly what was loaded
5. Proceed with the user's task

The real intelligence lives in `ai_readme.md`, not in the skill. This means you can evolve your session start protocol by editing the template or the generated file — without touching the skill itself.

---

## Why This Matters

Without this flow, starting a session looks like:

```
You: "Read .ai-sdlc/workspace.yaml, then read the status file,
      then load the architect stance, then read operating-rules.md,
      then read common.md, then read the knowledge tree index..."
```

With this flow:

```
You: "AUTO architect: where are we?"
```

The difference is not just convenience — it's reliability. The `ai_readme.md` file encodes the correct loading sequence so you don't have to remember it. The AUTO skill triggers that sequence so you don't have to type it. Every session starts the same way, loads the same files in the same order, and the AI is oriented before you finish your first sentence.

---

## Prerequisites

This flow requires a fully bootstrapped workspace. If you haven't set up your project yet, see [bootstrap/README.md](../bootstrap/README.md) for the setup process.

After bootstrap, your repo should have:

```
my-project/
├── ai_readme.md           ← session entry point (this is what AUTO reads)
├── .ai-sdlc/
│   ├── memory/
│   ├── methodology/
│   └── workspace.yaml
├── src/
└── ...
```

If `ai_readme.md` is missing, AUTO has nothing to read. Run the setup steps in [bootstrap/README.md](../bootstrap/README.md) to generate it.

---

## For Non-Cowork Tools

The AUTO skill is specific to Cowork, but `ai_readme.md` works with any AI tool. If you're using Claude Code, Cursor, or another tool:

1. Point the tool at your code repo root
2. Start the session with: *"Read ai_readme.md and follow its instructions. Then adopt the Architect stance — where are we?"*

The effect is the same — the AI reads the entry point, loads context, and orients. AUTO just makes it a single word instead of a sentence.
