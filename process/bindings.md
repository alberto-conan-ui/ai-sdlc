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

`install-claude` writes the following into the project, all idempotent on re-install:

- **CLAUDE.md handshake.** A delimited block appended to (or replaced in) the project's `CLAUDE.md`, holding a one-liner: *"Read `ai_readme.md` and follow its instructions."* The block has clear start/end markers so re-install replaces only the block and preserves the rest of `CLAUDE.md`. Claude Code loads `CLAUDE.md` at session open; the handshake fires the universal load against the methodology already on disk.
- **Verbs → skills.** Each verb file under `.ai-lore-<project>/process/verbs/` becomes a skill at `.claude/skills/ai-lore-<verb>/SKILL.md`. Skill body is the verb file's content, verbatim. Trigger keyword is the verb name. Skills are project-scoped (the project's `.claude/`, not user-global), so each project's install is isolated.
- **Bookends → hooks.** `orient` and `close-session` are skills like the others *and* are wired to Claude Code's `SessionStart` and `SessionEnd` hooks in `.claude/settings.json`. The hook invokes the skill — the bookend's content stays in one place (the verb file), and the hook just triggers it. In the plain-text path the bookends are intrinsic behaviour; installed, they are reinforced.
- **`dictation`** binds to the `[PROMPT]` input prefix — Claude detects the prefix and invokes the `dictation` skill.

Re-running `install-claude` after [`upgrade`](./verbs/upgrade.md) re-projects the new methodology into the same locations.

## Binding: other engines

Other engines bind by the same shape — verbs to whatever invocable unit the engine offers, bookends to whatever reinforcement it offers, the plain-text `ai_readme.md` handshake to whatever auto-load file the engine reads at session open. Each is its own binding section, added when the engine is supported. The neutral methodology is the shared source for all of them.

## The companion app

A companion app is a **runtime**, not part of the methodology. It hosts AI-Lore projects, reads the focus chain, and surfaces Memory and the review queue to the Human Lead. It is one consumer of the neutral Memory model — never a dependency of it.

The methodology stays **companion-agnostic**: a session with no companion runs identically, the Human Lead reading raw Memory files. The Memory file schema ([`memory.md`](./memory.md)) is what lets a companion parse Memory; it never assumes a companion is present.
