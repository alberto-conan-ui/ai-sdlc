# Bindings

AI-Lore is **platform-neutral plain text**. The methodology — the Memory model, the dials, the verbs, the bookends — is this folder of documents, and it is complete on its own. A session uses it by reading it. A **binding** layers engine-native delivery on top — same content, automatic invocation.

## Two paths

**Plain text.** The methodology works on any AI, with no setup. Point a session at the project and say *"read ai_readme.md"*. The entry point is at the project root (placed there by [`init`](./verbs/init.md)); the pillars and verbs sit under `.ai-lore-<project>/process/`. The session reads the methodology, orients, and works. Verbs are loaded the moment they are invoked. This path is always available and is the methodology in full.

**Installed.** AI-Lore can be embedded into an engine so its mechanisms carry the methodology automatically — verbs as the engine's native invocable units, bookends fired by engine hooks. Nothing about the methodology changes — installing changes *how it is delivered*, not *what it says*. Both paths share the same files on disk; installing wires those files into engine machinery so the engine triggers them without the Human Lead having to.

The plain-text path is the floor. Installing is an upgrade in delivery, never a prerequisite — and it never removes the plain-text path. After `install-claude`, you can still open Gemini in the same project and say *"read ai_readme.md"*.

## The install verb

A binding is applied by the [`install`](./verbs/install.md) verb, invoked once per project per engine — `install-claude`, `install-gemini`, and so on. The engine names the binding. `install` reads the methodology already placed in the project and writes it into the target engine's native form.

Each engine has its own binding section below — what "native form" means there. Adding support for a new engine means adding a binding section and an `install` target; the methodology itself does not change.

## Binding: Claude

`install-claude` writes the following into the project, all idempotent on re-install.

### CLAUDE.md handshake

A delimited block in the project's `CLAUDE.md`:

```
<!-- AI-LORE:BEGIN -->
This project uses AI-Lore. Read `ai_readme.md` and follow its instructions.

Use `/ai-lore-plan` (not `/plan`) in this project — plans live in Memory under the active focus.
<!-- AI-LORE:END -->
```

If `CLAUDE.md` does not exist, install creates it with this block as the entire content. If it exists, install replaces only the delimited block and preserves the rest of the file. Claude Code loads `CLAUDE.md` at session open, so the handshake fires the universal load against the methodology already on disk.

### Verbs → skills

Each verb file under `.ai-lore-<project>/process/verbs/` becomes a skill at `.claude/skills/ai-lore-<verb>/SKILL.md`. The skill file is the verb's content with **synthesized YAML frontmatter prepended**:

```markdown
---
name: ai-lore-<verb>
description: <the verb's one-line entry from verbs.index.md>
---

<verb file content, unchanged>
```

Claude Code triggers skills by **description matching** — the description field is what makes the skill discoverable. Descriptions are sourced from the operations table in [`verbs/verbs.index.md`](./verbs/verbs.index.md); that table is the canonical list, used by every engine binding that triggers on descriptions.

Skills are project-scoped (`.claude/skills/`, not `~/.claude/skills/`), so each project's install is isolated.

### Bookends → hooks

`orient` and `close-session` are skills (as above) **and** are wired into Claude Code's `SessionStart` and `SessionEnd` hooks in `.claude/settings.json`. The hook command is a shell command whose stdout becomes session context — it emits the instruction telling the running session to invoke the bookend skill:

```json
{
  "hooks": {
    "SessionStart": [{ "matcher": "*", "hooks": [
      { "type": "command", "command": "echo 'Invoke the ai-lore-orient skill now.'" }
    ]}],
    "SessionEnd": [{ "matcher": "*", "hooks": [
      { "type": "command", "command": "echo 'Invoke the ai-lore-close-session skill now.'" }
    ]}]
  }
}
```

In the plain-text path the bookends are intrinsic behaviour the session performs on itself; installed, the hook reinforces that so the session cannot silently skip them.

### Merge behavior

If `.claude/settings.json` does not exist, install creates it with the two hook entries above. If it exists, install merges the `SessionStart` and `SessionEnd` hook entries while preserving every other key and entry — other hooks, permissions, etc., are untouched. The user's separate `.claude/settings.local.json` is never read or written. Re-install replaces these specific entries; nothing else.

Re-running `install-claude` after [`upgrade`](./verbs/upgrade.md) re-projects the new methodology into the same locations.

### Plan-mode collision

Claude Code ships a built-in `/plan` slash command that enables a native plan mode. The mode forces plan files to `~/.claude/plans/`, outside the project — invisible to both AI-Lore git repos and to any future session. AI-Lore's plan posture, by contrast, writes plans into Memory (focus body or action tree) where they persist and walk in the focus chain.

The two collide. Claude Code provides no mechanism to disable a built-in command — not via project `.claude/settings.json`, not via skill, hook, or permission rule — so the collision cannot be enforced away. `install-claude` handles it by **documentation**:

- The `CLAUDE.md` handshake block includes a one-line steer telling the user to invoke `/ai-lore-plan` instead of `/plan`.
- The `ai-lore-plan` skill text says explicitly that the plan lands in Memory through `write-lore`, regardless of any harness-side plan-file assignment.

A user who invokes `/plan` anyway gets Claude Code's native plan-mode behaviour — including the harness plan file at `~/.claude/plans/`. The Memory plan is the authoritative one; the harness plan file is scratch and should be discarded once the AI-Lore plan lands.

## Binding: other engines

Other engines bind by the same shape — verbs to whatever invocable unit the engine offers, bookends to whatever reinforcement it offers, the plain-text `ai_readme.md` handshake to whatever auto-load file the engine reads at session open. Each is its own binding section, added when the engine is supported. The neutral methodology is the shared source for all of them.

## The companion app

A companion app is a **runtime**, not part of the methodology. It hosts AI-Lore projects, reads the focus chain, and surfaces Memory and the review queue to the Human Lead. It is one consumer of the neutral Memory model — never a dependency of it.

The methodology stays **companion-agnostic**: a session with no companion runs identically, the Human Lead reading raw Memory files. The Memory file schema ([`memory.md`](./memory.md)) is what lets a companion parse Memory; it never assumes a companion is present.
