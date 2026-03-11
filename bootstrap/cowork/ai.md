# Cowork Bootstrap — AI Instructions

> The human selected a folder in Cowork and pasted the seed prompt.
> You fetched this file from GitHub.

---

## Your job

Bootstrap is a two-step process (see `bootstrap/README.md`):

- **Step A** — Get ai-sdlc and the code repo into the workspace. This is what
  you're guiding now.
- **Step B** — Add the journal, skeleton files, workspace.yaml. This is handled
  by the bootstrapper role once ai-sdlc is readable locally.

## Cowork constraints

You are in a sandboxed Cowork VM. **The folder the human selected is the
workspace — it is already mounted and accessible. Do not create a new folder or
`cd` into it; you are already there.**

You **do not have git credentials or SSH keys.** You cannot clone repos. You
guide the human — they run commands in their own terminal, in the folder they
selected for Cowork. Do not attempt git operations yourself.

## Step A

### 1. Fetch the manual steps

Fetch `bootstrap/manual.md` — it is the single source of truth for the clone
commands and expected folder structure:

`https://raw.githubusercontent.com/alberto-conan-ui/ai-sdlc/refs/heads/main/bootstrap/manual.md`

### 2. Check what's already in the workspace

Before giving any instructions, list the contents of the workspace folder. The
human may have already cloned repos into it.

- If `ai-sdlc/` already exists → skip its clone step.
- If a code repo already exists → confirm which folder it is and skip its clone.
- If the folder is empty → proceed with the full setup.

### 3. Ask for the code repo URL (if needed)

If the code repo isn't already present, ask the human for the git URL.

### 4. Guide the human through manual.md

Walk them through the steps from `manual.md`, with these Cowork overrides:

- **Skip section 1** (workspace folder creation) — the selected folder is the
  workspace.
- **Sections 2 and 3** — give only the commands that are actually needed based
  on what you found in step 2. Tell the human to run them **in the folder they
  selected for Cowork**.
- Wait for the human to confirm they ran the commands.

### 5. Verify

List the workspace contents again. Check against the **Verify** section in
`manual.md`. If anything is missing, help the human fix it before moving on.

## Step B

ai-sdlc is now local. Read `ai-sdlc/roles/bootstrapper.md` and follow it — it
handles journal creation, skeleton files, and hand-off to INCEPTION mode.
