---
name: ai-lore-install
description: "Bind AI-Lore into a specific AI engine"
---

# install

`install` adds engine-native delivery on top of the AI-agnostic plain-text baseline. It runs once per project per engine.

The plain-text baseline is what [`init`](./init.md) puts in place: `ai_readme.md` at the project root and the methodology pillars under `.ai-lore-<project>/process/`. Any AI — Claude, Gemini, anything — can be pointed at the project, told *"read ai_readme.md"*, and operate. `install` does not replace that. It wires the same methodology into the engine's native mechanisms (skills, hooks, prefixes) so the engine triggers the handshake automatically instead of waiting for the Human Lead to type it.

## Invocation

`install` is invoked per engine, and the engine names the invocation: `install-claude`, `install-gemini`, and so on. It is one verb — the engine is its argument. The engine must have a binding section in [`bindings.md`](../bindings.md); installing an unsupported engine is refused.

## The operation

1. **Read the target engine's binding** — the section in [`bindings.md`](../bindings.md) that defines what "native form" means for this engine.
2. **Read the project's methodology** — the files [`init`](./init.md) placed at the project root and under `.ai-lore-<project>/process/`. This is the source for the engine projection.
3. **Write the engine-native form** per the engine's binding section.
   - For Claude (see [`bindings.md`](../bindings.md#binding-claude)): write the `CLAUDE.md` handshake block (create the file, or replace only the delimited block if the file exists); write each verb as a skill at `.claude/skills/ai-lore-<verb>/SKILL.md` with synthesized frontmatter drawn from `verbs.index.md`; create or merge `.claude/settings.json` with `SessionStart`, `SessionEnd`, and `UserPromptSubmit` hook entries.
   - For other engines: follow the binding section in [`bindings.md`](../bindings.md).

   Idempotency: re-running install replaces the delimited block in `CLAUDE.md`, overwrites skill files, and re-merges only the named hook entries in `.claude/settings.json`. Content outside those locations is preserved.
4. **Verify** — confirm the verbs are invocable in the engine and the bookends fire.

`install` never changes the methodology. It is a one-way projection: plain text in, engine-native form out. When the methodology changes (typically via [`upgrade`](./upgrade.md)), re-running `install` re-projects it. Re-install is idempotent — the delimited block in `CLAUDE.md` is replaced, skills are overwritten.

## install and the methodology

`install` does not touch Memory. It needs the project to exist — the methodology files [`init`](./init.md) placed are its input.
