# Bootstrap

> Set up a new AI-SDLC project. Two steps: get the code and methodology in place,
> then add the journal.

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
