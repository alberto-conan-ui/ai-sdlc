# AI-SDLC: Workspace Setup

> How to set up the three-folder workspace convention so AI tools can access code, process, and project knowledge in a single session.

---

## The Convention

Every project uses a **workspace parent folder** that contains three siblings:

```
my-project-workspace/              ← AI tool (Cowork, etc.) points here
├── my-project/                    ← The code repo (git clone)
├── my-project-sdlc/              ← Project journal repo (git repo, per-project)
│   ├── INDEX.md
│   ├── JOURNAL.md
│   ├── DECISIONS.md
│   ├── LESSONS_LEARNED.md
│   └── <workstream>/
└── ai-sdlc/                      ← Methodology repo (git repo, shared across projects)
    ├── PROCESS.md
    ├── TEMPLATES.md
    ├── SETUP.md
    └── lessons-learned/
        └── GLOBAL.md
```

Three repos, three concerns, three change cadences:

| Folder | What it holds | Changes when | Scope |
|---|---|---|---|
| `my-project/` | Source code | Code changes | This project only |
| `my-project-sdlc/` | Specs, plans, phases, session logs, decisions, lessons learned | Every session | This project only |
| `ai-sdlc/` | The methodology itself (process guide, templates, conventions) | The process evolves | Shared across all projects |

The AI tool mounts the workspace folder, giving it access to all three in a single session. No symlinks needed within the code repo, no submodules, no files copied into the code repo.

---

## Step-by-step Setup

### First time (setting up ai-sdlc)

1. Create the ai-sdlc repo on GitHub (or your preferred host)
2. Clone it somewhere convenient: `git clone <url> ~/repos/ai-sdlc`
3. The repo ships with PROCESS.md, TEMPLATES.md, SETUP.md, and a `lessons-learned/` folder

### For each new project

1. **Create a workspace folder:**
   ```bash
   mkdir ~/workspaces/my-project-workspace
   ```

2. **Clone (or symlink) the code repo into it:**
   ```bash
   cd ~/workspaces/my-project-workspace
   git clone <code-repo-url> my-project
   ```
   Or, if it's already cloned elsewhere:
   ```bash
   ln -s ~/repos/my-project ~/workspaces/my-project-workspace/my-project
   ```

3. **Clone (or symlink) ai-sdlc into it:**
   ```bash
   cd ~/workspaces/my-project-workspace
   ln -s ~/repos/ai-sdlc ai-sdlc
   ```
   Symlink is recommended — you want a single ai-sdlc clone shared across all workspaces.

4. **Create the project journal repo:**
   ```bash
   cd ~/workspaces/my-project-workspace
   mkdir my-project-sdlc
   cd my-project-sdlc
   git init
   ```
   Optionally push to GitHub as its own repo.

5. **Initialise the project journal** using the templates from TEMPLATES.md:
   - Create `INDEX.md`
   - Create `JOURNAL.md`
   - Create `DECISIONS.md`
   - Create `LESSONS_LEARNED.md`

6. **Point your AI tool at the workspace folder:**
   In Cowork: select `~/workspaces/my-project-workspace/` as the folder.
   In Claude Code: `cd ~/workspaces/my-project-workspace/`

---

## Working with Multiple Projects

Each project gets its own workspace folder and its own journal repo. The ai-sdlc methodology is shared via symlink:

```
~/workspaces/
├── formforge-workspace/
│   ├── formforge/                ← code
│   ├── formforge-sdlc/           ← project journal (its own git repo)
│   └── ai-sdlc/                  ← symlink → ~/repos/ai-sdlc
├── client-project-workspace/
│   ├── client-project/            ← code
│   ├── client-project-sdlc/       ← project journal (its own git repo)
│   └── ai-sdlc/                   ← symlink → ~/repos/ai-sdlc
└── oss-contrib-workspace/
    ├── some-oss-repo/             ← code
    ├── some-oss-repo-sdlc/        ← project journal (its own git repo)
    └── ai-sdlc/                   ← symlink → ~/repos/ai-sdlc
```

With this setup:
- There's only one ai-sdlc clone on disk. Process improvements are immediately available everywhere.
- Each project journal has its own clean git history. No noise from other projects.
- You can share a project journal with collaborators without exposing other projects.

---

## Why Three Folders

### Clean separation of concerns

Each folder has a single reason to change:
- Code repo changes when the **code** changes
- Project journal changes when you **plan, decide, or learn something**
- ai-sdlc changes when the **process itself** evolves

Mixing these creates noise. A session log entry shouldn't show up in the code repo's git history. A methodology tweak shouldn't appear in a project's commit log.

### No footprint in the code repo

You never add files, folders, symlinks, or configuration to the code repository. This means:
- Other developers on the project are unaffected
- You can use this on repos you don't own
- No gitignore changes, no submodule configuration

### AI tools see everything

Because the AI tool is pointed at the parent workspace folder, it can:
- Read and write code in the project repo
- Read and write project knowledge in the journal repo
- Read the methodology from ai-sdlc
- Follow relative paths between all three (e.g., `../my-project/src/...` from the journal)
- Run build/test commands in the code repo

### Knowledge flows in two directions

**Project → Global:** When a lesson learned on one project proves broadly applicable, promote it from the project journal's LESSONS_LEARNED.md to ai-sdlc's lessons-learned/GLOBAL.md.

**Global → Project:** At the start of any session, the AI reads both the project-specific lessons and the global ones. Wisdom from project A informs how you approach project B.

### Each journal has its own history

With the two-folder approach (project knowledge inside ai-sdlc), every `git log` showed noise from all projects mixed together. With separate journal repos, each project's history is clean and self-contained.

---

## Path References

From the project journal, reference code files using relative paths:

```
../my-project/src/services/auth.ts
```

From implementation prompts, the same pattern works:

```
# In my-project-sdlc/dx/phases/1-baseline/impl/01-tests.md
Open ../../../my-project/src/services/dx/core/registry.ts
```

All paths resolve correctly because Cowork's mount point is the parent workspace folder.

---

## FAQ

**Q: What if I already have the code repo cloned somewhere else?**
Symlink it into the workspace folder:
```bash
ln -s ~/repos/my-project ~/workspaces/my-project-workspace/my-project
```

**Q: Can I use this with multiple AI tools?**
Yes. Everything is plain markdown — any AI tool that can read files can consume it. The planner/executor split maps naturally to different tools (e.g., Cowork for planning, Windsurf or Cursor for execution).

**Q: What about the `.claude/` folder convention?**
If your code repo already has a `.claude/` folder (e.g., from Claude Code), you can migrate its contents into the project journal repo and remove the `.claude/` folder. Or keep both during a transition period — just be clear about which is authoritative.

**Q: Does the project journal repo need to be on GitHub?**
No. It can be a local-only git repo if you prefer. The git history is the main value — having a remote is optional but useful for backup and sharing.

**Q: Can multiple people share a project journal?**
Yes. Push the journal repo to GitHub and collaborators can clone it into their own workspace folders alongside the code repo and their ai-sdlc symlink. Everyone follows the same methodology, contributes to the same knowledge base.
