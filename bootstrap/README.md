# Bootstrap

> Set up a new AI-SDLC project. Two steps: get the methodology into the code repo,
> then add the project memory.

---

## The Nested Convention

Every project keeps its AI-SDLC artefacts inside a `.ai-sdlc/` folder at the code repo root. The code repo **is** the workspace — your IDE opens it as the project root, and all tooling (language servers, test runners, linters) works normally.

```
my-project/                        ← IDE opens HERE — this is the workspace
├── .ai-sdlc/                      ← gitignored — all AI-SDLC artefacts live here
│   ├── memory/                    ← Project memory (its own nested git repo)
│   │   ├── journal/
│   │   │   ├── live/              ← current session entries
│   │   │   └── archive/           ← processed entries
│   │   ├── knowledge-tree/
│   │   │   │   ├── knowledge-tree.index.md
│   │   │   └── archive/           ← retired insights
│   │   ├── action-tree/
│   │   │   ├── action-tree.index.md
│   │   │   ├── status.md
│   │   │   ├── 1.topic.refactor-validation/
│   │   │   └── archive/           ← completed actions
│   ├── methodology/               ← ai-sdlc repo (clone or symlink)
│   └── workspace.yaml             ← folder mapping
├── ai_readme.md                   ← session entry point (gitignored)
├── src/
├── package.json
└── .gitignore                     ← includes .ai-sdlc/ and ai_readme.md
```

Three repos, three concerns, three change cadences — but all accessible from a single root:

| Folder | Holds | Changes when | Scope |
|---|---|---|---|
| `my-project/` (root) | Source code | Code changes | This project |
| `.ai-sdlc/memory/` | Journal, knowledge tree, specs, plans, actions | Every session | This project |
| `.ai-sdlc/methodology/` | The methodology itself | The process evolves | All projects |

The AI tool points at the code repo root, giving it access to code, memory, and methodology in a single session.

### Why nested inside the code repo

**IDE-native.** The code repo is the project root. Language servers, test runners, `tsconfig.json`, `.vscode/` settings — everything works without configuration. You open the project the same way you always have.

**Clean separation of concerns.** Each nested repo has its own `.git` directory and its own history. A session log entry doesn't pollute the code repo's git history. A methodology tweak doesn't appear in a project's commit log.

**Minimal footprint in the code repo.** One line in `.gitignore` — `.ai-sdlc/` — and the code repo is untouched from other developers' perspective. No submodule configurations, no wrapper folders, no workspace files.

**Works with every AI tool.** Whether you use Cowork, Claude Code, Cursor, or Windsurf, you point the tool at the code repo. Terminal `cwd` is the code repo. Build commands just work.

**Knowledge accumulates.** The journal captures everything chronologically. The knowledge tree curates insights from the journal and organises them by codebase area. Each new session loads the relevant knowledge nodes. The AI effectively gets better at your project over time.

**Each memory repo has its own history.** The nested git repo inside `.ai-sdlc/memory/` maintains a clean, self-contained git log. Collaborators can clone a project memory without seeing other projects' histories.

### workspace.yaml

A configuration file inside `.ai-sdlc/` maps the folder names, eliminating fragile relative paths in documents and prompts:

```yaml
# workspace.yaml — single source of truth for folder names
code: ../
memory: memory
methodology: methodology
```

With this file, all documents can reference paths as `{code}/src/services/auth.ts` instead of fragile relative paths. The AI resolves these references at session start by reading `workspace.yaml`.

### Path references

Use the `workspace.yaml` shorthand in all documents and prompts:

```
{code}/src/services/auth.ts
{memory}/action-tree/1.topic.refactor-validation/1.phase.baseline-tests/baseline-tests.index.md
{methodology}/roles/architect.md
```

The AI resolves `{code}`, `{memory}`, and `{methodology}` by reading `workspace.yaml` at session start. This works regardless of where the referencing file lives — no `../` counting required.

**Fallback:** If workspace.yaml isn't present, use relative paths from the code repo root: `./` for code, `.ai-sdlc/memory/` for memory, `.ai-sdlc/methodology/` for methodology.

---

## Workspace Lifecycle

A workspace moves through a defined progression from a bare code repo to a working project. Understanding these states matters because an AI session needs to know where the workspace is in this progression — a repo missing its `.ai-sdlc/` folder is not broken, it's pre-bootstrap.

### States

**Bare repo** — The code repo exists but has no `.ai-sdlc/` folder. This is the starting point before any setup.

**Step A complete** — `.ai-sdlc/methodology/` exists (ai-sdlc is in place). The AI can now read the methodology locally. There is no memory folder yet, no workspace.yaml, no skeleton files.

```
my-project/
├── .ai-sdlc/
│   └── methodology/       ← ai-sdlc (clone or symlink)
├── src/
└── .gitignore             ← includes .ai-sdlc/
```

**Fully bootstrapped** — The memory folder, workspace.yaml, skeleton files, and `ai_readme.md` are in place. The workspace is ready for real work — the next step is to invoke the Architect to define the first action.

```
my-project/
├── .ai-sdlc/
│   ├── memory/            ← project memory (its own nested git repo)
│   │   ├── journal/
│   │   │   ├── live/
│   │   │   └── archive/
│   │   ├── knowledge-tree/
│   │   │   ├── knowledge-tree.index.md
│   │   │   └── archive/
│   │   ├── action-tree/
│   │   │   ├── action-tree.index.md
│   │   │   ├── status.md
│   │   │   └── archive/
│   ├── methodology/       ← ai-sdlc
│   └── workspace.yaml     ← folder mapping
├── ai_readme.md           ← session entry point (gitignored)
├── src/
└── .gitignore             ← includes .ai-sdlc/ and ai_readme.md
```

### Detecting workspace state

An AI session can determine the workspace state by checking what's present:

- No `.ai-sdlc/` folder → **Bare repo** (pre-Step A)
- `.ai-sdlc/methodology/` exists but no memory folder or `workspace.yaml` → **Step A complete**
- Memory folder exists with `status.md` and no active action → **Fully bootstrapped**
- Memory folder exists with an active action in `status.md` → **Active project** (past bootstrap)

This detection is useful for AI tools that need to orient themselves at session start — especially in Cowork, where the AI should check workspace state before deciding how to proceed.

---

## Step A — Get ai-sdlc into the code repo

This is the part that varies by tooling. Pick the guide that matches yours:

| Guide | When to use |
|---|---|
| [Manual](./manual.md) | You want full control, no AI assistance |
| [Cowork](./cowork/human.md) | You're using Claude Cowork to guide you through setup |

By the end of Step A your code repo should have:

```
my-project/
├── .ai-sdlc/
│   └── methodology/       ← ai-sdlc (clone or symlink)
└── .gitignore             ← includes .ai-sdlc/
```

---

## Step B — Add the project memory

Once ai-sdlc is in place, the AI can read the full methodology locally. All guides converge here. Point your AI tool at the code repo and ask it to set up the project memory. The AI should follow these steps, presenting each one for your approval before proceeding.

### 1. Gather project basics

The AI asks you: what is the project? What's the tech stack? This information goes into the initial `knowledge-tree/knowledge-tree.index.md` skeleton. A few sentences is enough — the Architect will deepen it in the first working session.

### 2. Create the memory folder structure

If `.ai-sdlc/memory/` doesn't exist, create it:

```bash
mkdir -p .ai-sdlc/memory/journal/live .ai-sdlc/memory/journal/archive \
         .ai-sdlc/memory/knowledge-tree/archive \
         .ai-sdlc/memory/action-tree/archive
cd .ai-sdlc/memory && git init -b main && cd ../..
```

If a memory folder already exists, check what's there and ask the human how to proceed — keep the existing memory, archive it, or start fresh.

### 3. Create workspace.yaml

```yaml
# workspace.yaml — single source of truth for folder names
code: ../
memory: memory
methodology: methodology
```

### 4. Create skeleton files

**`action-tree/status.md`** — the live pointer, read first every session:

```markdown
# <Project Name> — Status

**Process version:** v0.2

> Single source of truth. Every stance reads this for orientation.

## Current State

| Field | Value |
|---|---|
| **Next step** | Invoke the Architect to define the first action |

## Active Stack

*Empty — no active work.*
```

**`action-tree/action-tree.index.md`** — tree structure overview:

```markdown
# <Project Name> — Action Tree

> Structural overview of the action tree. For current state, see `status.md`.

## Action Tree

*No actions defined yet.*

## Code Repository

**Location:** `{code}/`
**Branch:** `main`
```

**`knowledge-tree/knowledge-tree.index.md`** — a few lines from the project basics:

```markdown
# Knowledge — <Project Name>

> Project-wide insights and cross-cutting patterns.
> Last updated: <today's date>

## What This Is

<One or two sentences from the human's answer.>

## Tech Stack

<Language, framework, major dependencies.>

## Repo

<URL>

## Knowledge Map

<!-- Populated as the knowledge tree grows. -->
```

### 5. Create ai_readme.md

Copy the template from `{methodology}/bootstrap/ai_readme.template.md` to the code repo root as `ai_readme.md`. Ensure `ai_readme.md` is in `.gitignore`.

### 6. Verify

The workspace should now look like the "Fully bootstrapped" diagram above. Read back `status.md`, `action-tree.index.md`, and `knowledge-tree.index.md` for the human to review. Setup is done — the next step is to invoke the Architect to define the first action.

---

## FAQ

**Can I use this on a repo I don't own?**
Yes. The `.ai-sdlc/` folder is gitignored — it never appears in commits or pull requests. Other developers are unaffected. The only change to the code repo is one line in `.gitignore`, and even that can be added to a personal global gitignore instead if you prefer zero modifications.

**Can I use multiple AI tools?**
Yes. Everything is plain markdown. Use one tool for the Architect and Tech Lead stances (e.g., Cowork, Claude) and another for the Developer (e.g., Cursor, Windsurf, Claude Code). The stance separation maps naturally to different tools. All tools point at the code repo root.

**What about existing `.claude/` folders?**
If the code repo has a `.claude/` folder, you can migrate its contents to the project memory or keep both during a transition. Be clear about which is authoritative.

**Does the memory repo need a remote?**
No. A local-only git repo inside `.ai-sdlc/memory/` works. The git history is the main value — a remote is optional but useful for backup and sharing.

**Can multiple people share a project memory?**
Yes. Push the memory repo to GitHub and collaborators clone it into their own `.ai-sdlc/memory/` alongside the methodology symlink.

**What if I don't want to touch .gitignore at all?**
Use a global gitignore instead. Add `.ai-sdlc/` to your `~/.gitignore_global` (or whatever your `core.excludesFile` points to). The effect is identical — zero footprint in the code repo.
