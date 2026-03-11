# AI-SDLC: Bootstrap

> This file is for the AI. It is fetched via raw GitHub URL during project setup,
> before anything is cloned locally. The human has pasted the seed prompt into their
> AI tool. You are now reading the entry point.

---

## What to Do

1. **Clone ai-sdlc** into the workspace folder. Run the command directly — the workspace is already mounted and you have write access:

   ```bash
   git clone https://github.com/alberto-conan-ui/ai-sdlc.git
   ```

   If the user said this is not their first ai-sdlc project, ask if they want to symlink a shared clone instead.

2. **Verify** the `ai-sdlc/` folder is now visible in the workspace.

3. **Read the bootstrapper role** at `ai-sdlc/roles/bootstrapper.md`. It contains the full setup instructions.

4. **Follow the bootstrapper role** step by step. It will walk through creating the three-folder workspace, populating skeleton files, and verifying the result.

That's it. The bootstrapper role has all the intelligence. This file just gets you there.

---

## Important

- Do not read any other ai-sdlc files until the bootstrapper role tells you to.
- Do not start creating files until the bootstrapper role's step 1 (orientation) is complete.
- Run commands directly — the workspace folder is mounted and writable. Only ask the user to run commands if something fails (e.g. private repo clone needing SSH credentials).
