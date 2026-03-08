# AI-SDLC: Workspace Setup

> How to structure the three-folder workspace so AI tools can access code, process, and project knowledge in a single session.

---

## The Convention

Every project uses a workspace parent folder containing three siblings:

```
my-project-workspace/              ← AI tool points here
├── my-project/                    ← Code repo (git clone)
├── my-project-journal/              ← Project journal (its own git repo)
│   ├── STATUS.md
│   ├── JOURNAL.md
│   ├── DECISIONS.md
│   ├── LESSONS_LEARNED.md
│   ├── CONTEXT.md
│   └── goals/
└── ai-sdlc/                      ← Methodology repo (shared across projects)
    ├── README.md
    ├── PROCESS.md                 ← Full methodology (human-facing)
    ├── MECHANICS.md               ← Context isolation architecture
    ├── PROMPTS.md
    ├── SETUP.md
    ├── TEMPLATES.md
    └── roles/                     ← AI role entry points
        ├── orchestrator.md
        ├── architect.md
        ├── tech-lead.md
        └── developer.md
```

Three repos, three concerns, three change cadences:

| Folder | Holds | Changes when | Scope |
|---|---|---|---|
| `my-project/` | Source code | Code changes | This project |
| `my-project-journal/` | Specs, plans, session logs, decisions, lessons | Every session | This project |
| `ai-sdlc/` | The methodology itself | The process evolves | All projects |

The AI tool mounts the workspace folder, giving it access to all three in a single session.

---

## Setup

### First time (ai-sdlc repo)

1. Clone this repo somewhere convenient: `git clone <url> ~/repos/ai-sdlc`
2. It ships with PROCESS.md, PROMPTS.md, SETUP.md, TEMPLATES.md

### For each new project

```bash
# 1. Create the workspace
mkdir ~/workspaces/my-project-workspace
cd ~/workspaces/my-project-workspace

# 2. Clone or symlink the code repo
git clone <code-repo-url> my-project
# Or if already cloned elsewhere:
ln -s ~/repos/my-project ./my-project

# 3. Symlink ai-sdlc (one clone shared across all projects)
ln -s ~/repos/ai-sdlc ./ai-sdlc

# 4. Create the project journal
mkdir my-project-journal && cd my-project-journal && git init

# 5. Initialise using templates from TEMPLATES.md
# Create: STATUS.md, JOURNAL.md, DECISIONS.md, LESSONS_LEARNED.md, CONTEXT.md
```

Then point your AI tool at `~/workspaces/my-project-workspace/`.

---

## Multiple Projects

Each project gets its own workspace and journal. The methodology is shared via symlink:

```
~/workspaces/
├── project-a-workspace/
│   ├── project-a/              ← code
│   ├── project-a-journal/        ← journal (its own git repo)
│   └── ai-sdlc/               ← symlink → ~/repos/ai-sdlc
├── project-b-workspace/
│   ├── project-b/              ← code
│   ├── project-b-journal/        ← journal (its own git repo)
│   └── ai-sdlc/               ← symlink → ~/repos/ai-sdlc
```

One ai-sdlc clone on disk. Process improvements are immediately available everywhere. Each journal has its own clean git history.

---

## Why Three Folders

**Clean separation of concerns.** Each folder has one reason to change. A session log entry doesn't belong in the code repo's git history. A methodology tweak doesn't belong in a project's commit log.

**No footprint in the code repo.** You never add files, folders, or configuration to the code repository. This means you can use the methodology on repos you don't own, other developers are unaffected, and there are no gitignore changes or submodule configurations.

**AI tools see everything.** Because the AI is pointed at the parent workspace, it can read and write code, read and write project knowledge, read the methodology, follow relative paths between all three, and run build/test commands in the code repo.

**Knowledge accumulates.** Decisions, lessons learned, and session logs persist in the journal. Each new session loads this context. The AI effectively gets better at your project over time.

**Each journal has its own history.** Separate repos mean clean, self-contained git logs per project. Collaborators can clone a project journal without seeing other projects' histories.

---

## Path References

From the project journal, reference code files using relative paths:

```
../my-project/src/services/auth.ts
```

From implementation prompts (deeper in the folder structure):

```
# From my-project-journal/goals/1-name/phases/1-phase/impl/01-task.md
../../../../../my-project/src/services/auth.ts
```

All paths resolve correctly because the workspace convention places all three repos as siblings under a shared parent.

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
