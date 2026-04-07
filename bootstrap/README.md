# Bootstrap a New AI-Lore Project

Two steps. One minute.

## 1. Create your project folder

```bash
mkdir my-project && cd my-project
```

Or `cd` into an existing project — AI-Lore works with any repo.

## 2. Open Claude and paste this

In Claude Code (CLI) or Cowork, paste:

```
Fetch https://raw.githubusercontent.com/alberto-conan-ui/ai-sdlc/main/bootstrap/setup.md and follow its instructions.
```

Claude will:
- Clone the AI-Lore methodology into your project
- Ask you a few questions (what the project is, which plugin to use)
- Create the full memory structure
- Set everything up so your next session just works

When it's done, start every AI session with:

```
Read ai_readme.md and follow its instructions.
```

That's it.

---

## What gets created

```
my-project/
├── .ai-lore/
│   ├── memory/            ← project memory (its own git repo)
│   │   ├── status/        ← entry point — active focus, mode
│   │   ├── journal/       ← session records
│   │   ├── knowledge-tree/← curated insights, notepad, payload
│   │   └── action-tree/   ← optional work decomposition
│   ├── methodology/       ← ai-lore (cloned)
│   └── workspace.yaml     ← plugin declaration and version info
├── ai_readme.md           ← session entry point
└── .gitignore             ← includes .ai-lore/ and ai_readme.md
```

## Available plugins

| Plugin | Domain | Stances |
|---|---|---|
| **sdlc** | Software development | Architect, Tech Lead |
| **ttrpg** | Tabletop RPG campaigns | Game Master |
| **spec** | Methodology/process design | Editor, Strategist |

The **Auditor** is a core stance available to all plugins. More plugins may be available — Claude will discover them during setup.

## Already have a project on an older version?

If your project uses `.ai-sdlc/` or predates the plugin architecture, tell Claude:

```
Read ai_readme.md and load the Auditor. Migrate this project to v0.3.
```

The Auditor reads the version changelogs and handles the migration.
