# Cowork Bootstrap — AI Instructions

> The human selected their code repo folder in Cowork and pasted the seed prompt.
> You fetched this file from GitHub.

---

## Your job

Bootstrap is a two-step process (see `bootstrap/README.md`):

- **Step A** — Get ai-sdlc into the code repo's `.ai-sdlc/` folder. This is what
  you're guiding now.
- **Step B** — Add the project memory, skeleton files, workspace.yaml. This is handled
  by the bootstrapper role once ai-sdlc is readable locally.

## Cowork constraints

You are in a sandboxed Cowork VM. **The folder the human selected is the
code repo root — it is already mounted and accessible. Do not create a new folder or
`cd` into it; you are already there.**

You **do not have git credentials or SSH keys.** You cannot clone repos. You
guide the human — they run commands in their own terminal, in the folder they
selected for Cowork. Do not attempt git operations yourself.

## Step A

### 1. Fetch the manual steps

Fetch `bootstrap/manual.md` — it is the single source of truth for the setup
commands and expected folder structure:

`https://raw.githubusercontent.com/alberto-conan-ui/ai-sdlc/refs/heads/main/bootstrap/manual.md`

### 2. Check what's already in the code repo

Before giving any instructions, list the contents of the code repo root. The
human may have already set things up.

- If `.ai-sdlc/methodology/` already exists → skip the clone step.
- If `.ai-sdlc/` exists but no `methodology/` inside → only guide the methodology clone.
- If no `.ai-sdlc/` folder exists → proceed with the full setup.
- Check if `.ai-sdlc/` is already in `.gitignore`. If not, include that step.

### 3. Guide the human through manual.md

Walk them through the steps from `manual.md`, with these Cowork overrides:

- **Skip any folder creation** beyond `.ai-sdlc/` — the code repo already exists.
- Give only the commands that are actually needed based on what you found in step 2.
- Tell the human to run them **in the folder they selected for Cowork**.
- Wait for the human to confirm they ran the commands.

### 4. Verify

List the workspace contents again. Check against the **Verify** section in
`manual.md`. If anything is missing, help the human fix it before moving on.

## Step B — Enter SDLC Mode

ai-sdlc is now local. **From this point forward, you operate within the AI-SDLC
methodology.** You are the Bootstrapper role.

Read the files listed in `.ai-sdlc/methodology/roles/bootstrapper.md` under "Files to Load"
— including `roles/operating-rules.md`, the full `process/` folder, `bootstrap/README.md`, and
`process/conventions.md`. The bootstrapper role file has everything you need: your stance,
your steps, approval gates, and boundaries. Follow it.
