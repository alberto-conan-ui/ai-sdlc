# Bootstrap

> Set up a new AI-SDLC project. Two steps: get the code and methodology in place,
> then add the journal.

---

## The Three-Folder Convention

Every project uses a workspace parent folder containing three siblings:

```
my-project-workspace/              ← AI tool points here
├── my-project/                    ← Code repo (git clone)
├── my-project-journal/            ← Project journal (its own git repo)
│   ├── STATUS.md
│   ├── KEY_INSIGHTS.md
│   ├── CONTEXT.md
│   ├── journal/
│   │   └── YYYY-WNN.md
│   └── actions/
│       ├── task-fix-login-bug/
│       ├── epic-refactor-validation/
│       └── goal-plugin-architecture/
└── ai-sdlc/                      ← Methodology repo (shared across projects)
```

Three repos, three concerns, three change cadences:

| Folder | Holds | Changes when | Scope |
|---|---|---|---|
| `my-project/` | Source code | Code changes | This project |
| `my-project-journal/` | Specs, plans, session logs, decisions, lessons | Every session | This project |
| `ai-sdlc/` | The methodology itself | The process evolves | All projects |

The AI tool mounts the workspace folder, giving it access to all three in a single session.

### Why three folders

**Clean separation of concerns.** Each folder has one reason to change. A session log entry doesn't belong in the code repo's git history. A methodology tweak doesn't belong in a project's commit log.

**No footprint in the code repo.** You never add files, folders, or configuration to the code repository. This means you can use the methodology on repos you don't own, other developers are unaffected, and there are no gitignore changes or submodule configurations.

**AI tools see everything.** Because the AI is pointed at the parent workspace, it can read and write code, read and write project knowledge, read the methodology, follow relative paths between all three, and run build/test commands in the code repo.

**Knowledge accumulates.** The journal captures everything chronologically. Key insights are curated from journal entries and placed at the right scope level (project, action, phase). Each new session loads the relevant insights. The AI effectively gets better at your project over time.

**Each journal has its own history.** Separate repos mean clean, self-contained git logs per project. Collaborators can clone a project journal without seeing other projects' histories.

### workspace.yaml

A configuration file at the workspace root defines the folder names once, eliminating fragile relative paths in documents and prompts:

```yaml
# workspace.yaml — single source of truth for folder names
code: my-project
journal: my-project-journal
methodology: ai-sdlc
```

With this file, all documents can reference paths as `{code}/src/services/auth.ts` instead of `../my-project/src/services/auth.ts`. The AI resolves these references at session start by reading `workspace.yaml`. The Navigator's handoff prompts use the same shorthand.

### Path references

Use the `workspace.yaml` shorthand in all documents and prompts:

```
{code}/src/services/auth.ts
{journal}/actions/epic-refactor-validation/phases/1-baseline-tests/SPEC.md
{methodology}/roles/architect.md
```

The AI resolves `{code}`, `{journal}`, and `{methodology}` by reading `workspace.yaml` at session start. This works regardless of where the referencing file lives — no `../` counting required.

**Fallback:** If workspace.yaml isn't present, use relative paths from the workspace root.

---

## Workspace Lifecycle

A workspace moves through a defined progression from empty folder to working project. Understanding these states matters because an AI session needs to know where the workspace is in this progression — a workspace missing its journal is not broken, it's mid-bootstrap.

### States

**Empty** — The workspace folder exists but contains nothing (or unrelated files). This is the starting point before any setup.

**Step A complete** — The code repo and ai-sdlc are present as siblings in the workspace. The AI can now read the methodology locally. There is no journal yet, no workspace.yaml, no skeleton files.

```
my-project-workspace/
├── ai-sdlc/           ← methodology (clone or symlink)
└── my-project/        ← code repo (clone)
```

**Fully bootstrapped (INCEPTION)** — The journal folder, workspace.yaml, and skeleton files are in place. STATUS.md shows INCEPTION mode. The workspace is ready for real work — the next step is to invoke the Architect to define the first action.

```
my-project-workspace/
├── ai-sdlc/
├── my-project/
├── my-project-journal/  ← journal (its own git repo)
│   ├── STATUS.md
│   ├── KEY_INSIGHTS.md
│   ├── CONTEXT.md
│   ├── journal/
│   │   └── YYYY-WNN.md
│   └── actions/
└── workspace.yaml       ← folder mapping
```

### Detecting workspace state

An AI session can determine the workspace state by checking what's present:

- No `ai-sdlc/` folder → **Empty** (or pre-Step A)
- `ai-sdlc/` exists but no journal folder or `workspace.yaml` → **Step A complete**
- Journal folder exists with `STATUS.md` showing INCEPTION and no active action → **Fully bootstrapped**
- Journal folder exists with an active action in `STATUS.md` → **Active project** (past bootstrap)

This detection is useful for AI tools that need to orient themselves at session start — especially in Cowork, where the AI should check workspace state before deciding how to proceed.

---

## Step A — Get ai-sdlc and the code repo

This is the part that varies by tooling. Pick the guide that matches yours:

| Guide | When to use |
|---|---|
| [Manual](./manual.md) | You want full control, no AI assistance |
| [Cowork](./cowork/human.md) | You're using Claude Cowork to guide you through setup |

By the end of Step A your workspace folder should have:

```
my-project-workspace/
├── ai-sdlc/           ← Methodology (clone or symlink)
└── my-project/        ← Code repo (clone)
```

---

## Step B — Add the journal

Once ai-sdlc is in place, the AI can read the full methodology locally.
All guides converge here.

Point your AI tool at the workspace folder and invoke the bootstrapper role
([`roles/bootstrapper.md`](../roles/bootstrapper.md)). It will create the project
journal, workspace.yaml, skeleton files, and leave everything in INCEPTION mode:

```
my-project-workspace/
├── ai-sdlc/
├── my-project/
├── my-project-journal/  ← Created by the bootstrapper
└── workspace.yaml       ← Created by the bootstrapper
```

The bootstrap is a two-step process. **Step A** gets the code and methodology in place — this varies by tooling (manual clone, Cowork-guided, etc.). **Step B** creates the journal, skeleton files, and workspace.yaml — this is handled by the Bootstrapper role (`roles/bootstrapper.md`), which operates within the SDLC methodology: it announces its role, explains each action, and waits for human approval at each step.

The Bootstrapper role is invoked once and never used again — once the workspace reaches INCEPTION, all subsequent work uses the standard roles (Architect, Tech Lead, Developer, Navigator, Curator).

---

## FAQ

**Can I use this on a repo I don't own?**
Yes. The code repo is untouched — no files added, no configuration changed. Your planning artefacts live entirely in the journal repo.

**Can I use multiple AI tools?**
Yes. Everything is plain markdown. Use one tool for the Architect and Tech Lead roles (e.g., Cowork, Claude) and another for the Developer (e.g., Cursor, Windsurf, Claude Code). The role separation maps naturally to different tools.

**What about existing `.claude/` folders?**
If the code repo has a `.claude/` folder, you can migrate its contents to the project journal or keep both during a transition. Be clear about which is authoritative.

**Does the journal repo need a remote?**
No. A local-only git repo works. The git history is the main value — a remote is optional but useful for backup and sharing.

**Can multiple people share a journal?**
Yes. Push the journal repo to GitHub and collaborators clone it into their own workspace alongside the code repo and ai-sdlc symlink.
