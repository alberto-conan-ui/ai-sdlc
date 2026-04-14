# AI-Lore Bootstrap — Setup Instructions

> You are an AI assistant. A human just asked you to fetch this file and follow it.
> These are your instructions. Execute them step by step, presenting each step
> to the human for confirmation before proceeding.

---

## Step 1 — Clone the methodology

Check if `.ai-lore/methodology/` already exists in the current directory.

**If it doesn't exist**, run:

```bash
mkdir -p .ai-lore
git clone https://github.com/alberto-conan-ui/ai-sdlc.git .ai-lore/methodology
```

If git fails (no credentials, network error), ask the human to run the clone command themselves, then continue.

**If it already exists**, skip this step and tell the human.

---

## Step 2 — Set up gitignore

Check if `.gitignore` exists. Create it if needed. Ensure `.ai-lore/` and `ai_readme.md` are listed.

---

## Step 3 — Read the process

Now that the methodology is local, read these files to understand what you're building:

| File | What you learn |
|---|---|
| `.ai-lore/methodology/process/memory.md` | The memory model — folder structure, status entry point, three layers |
| `.ai-lore/methodology/process/plugins.md` | What plugins are, which ones exist, how they connect to core |
| `.ai-lore/methodology/process/conventions.md` | File naming, index navigation grammar, reference headers |

Read all three before proceeding. You need to understand the memory model to create it correctly.

---

## Step 4 — Ask the human

**1. What is this project?** Brief description — what it does, who it's for, tech stack if applicable.

**2. Which plugin?** Read the plugin folders in `.ai-lore/methodology/process/plugins/` to discover what's available. For each, read its `ai_readme.md` and present a one-line description. The human picks one.

**3. Anything else?** Optional context for session one.

---

## Step 5 — Hydrate the project

Using what you learned from the process docs in Step 3 and the human's answers in Step 4:

1. **Create the memory folder structure** as defined in `memory.md` — status, focus, journal, knowledge tree (four branches: reconciled, working, notepad, blueprint), action tree. Initialize it as a git repo.
2. **Create `workspace.yaml`** in `.ai-lore/` with the folder mappings, chosen plugin, and version fields as described in `memory.md` and `plugins.md`.
3. **Create all skeleton files** — `status.md`, knowledge tree indexes (root, reconciled, working, notepad, blueprint), and action tree index. Follow the conventions from `conventions.md` and the structures from `memory.md`. Copy the plugin's `blueprint-seed.md` to `knowledge-tree/blueprint/blueprint.index.md`. Use the human's project description for the KT root.
4. **Copy `ai_readme.md`** from `.ai-lore/methodology/bootstrap/ai_readme.template.md` to the project root.

---

## Step 6 — Verify and hand off

Read back `status.md` and `knowledge-tree.index.md` for the human to review. Verify all files exist and all links resolve.

Tell the human:

> **Your project is ready.** Start every AI session with:
>
> *"Read ai_readme.md and follow its instructions."*
