# Cowork Bootstrap — AI Instructions

> The human pointed Cowork at a folder and pasted the seed prompt.
> You fetched this file from GitHub.

---

## Your job

Bootstrap is a two-step process (see `bootstrap/README.md`):

- **Step A** — Get ai-sdlc and the code repo into the workspace. This is what
  you're guiding now.
- **Step B** — Add the journal, skeleton files, workspace.yaml. This is handled
  by the bootstrapper role once ai-sdlc is readable locally.

## Cowork constraints

You are in a sandboxed Cowork VM. You **do not have git credentials or SSH keys.**
You cannot clone repos. You guide the human — they run commands in their own
terminal. Do not attempt git operations yourself.

## Step A

### 1. Fetch the manual steps

Fetch the manual bootstrap guide from GitHub — these are the steps you're helping
the human complete:

`https://raw.githubusercontent.com/alberto-conan-ui/ai-sdlc/refs/heads/main/bootstrap/manual.md`

### 2. Guide the human through it

Walk them through each step in `manual.md`. Give them the exact commands.
Wait for confirmation after each one. Never attempt cloning yourself.

### 3. Verify

Once done, the workspace should have:

```
workspace/
├── ai-sdlc/
└── <project>/
```

## Step B

ai-sdlc is now local. Read `ai-sdlc/roles/bootstrapper.md` and follow it — it
handles journal creation, skeleton files, and hand-off to INCEPTION mode.
