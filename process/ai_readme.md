# AI-Lore — Session Entry Point

The first thing every AI-Lore session reads. It loads the methodology, then hands off to the project.

AI-Lore is a methodology for building a **Payload** — software, a campaign, a specification, anything that benefits from persistent context — with an AI partner that remembers across sessions and challenges its own prior decisions.

---

## 1. Load the thin core

Read these three documents now. They are the **eager core** — what a session needs *before* it can reach any verb, and what makes it AI-Lore-shaped enough to operate:

1. [`project-structure.md`](./project-structure.md) — the vocabulary, the disk layout, the manifest
2. [`status.md`](./status.md) — the status tree, the stack-file registry, focus, the chain, the backlog
3. [`verbs/verbs.index.md`](./verbs/verbs.index.md) — the map of operations a session runs and the Human Lead invokes

The remaining pillars load **on demand**, not up front:

- [`memory.md`](./memory.md) — the persistent record: journal, blueprint, save-points, trees, the file schema
- [`tracks.md`](./tracks.md) — the workspace primitive: home and child tracks, mounting, claims, sessions
- [`git.md`](./git.md) — the git contract: two repos, branches per track, drift signal, the explicit `git -C` discipline
- [`bindings.md`](./bindings.md) — how the platform-neutral methodology binds to a specific AI engine

**The load model.** A verb is high-signal exactly when invoked, not when carried from session start — so verbs load on invocation, and from v0.7 the pillars do too. Each verb and bookend **declares the pillars it needs** (a *Prerequisites* line); a session cannot reach the action without passing that declaration, so the load is *guaranteed*, not left to the session noticing it is missing context. The thin core above is the bootstrap that makes this work; everything else arrives the moment it is used. Indexes support ad-hoc browsing, but correctness rides on the declared prerequisites. (See [`verbs/verbs.index.md`](./verbs/verbs.index.md#verbs-declare-their-prerequisites).)

## 2. Orient

Run the `orient` bookend ([`verbs/orient.md`](./verbs/orient.md)): read the registry in `memory/status/status.stack.md` (the focus registry) and `status.index.md` (the tree's root index), decide how deep to walk based on what tracks are open, surface drift, and state where the work stands. If the project is headless, say so and wait for direction.

## 3. Work

From there, ordinary work proceeds. The Human Lead invokes verbs as needed; the session closes by running `close-session`.

---

## Plain text, and installed

This is the **plain-text path**: it works on any AI, with no setup. Point a session at the project and say *"read ai_readme.md"* — the AI reads the two-line shim at the project root, which redirects here, and everything above happens by the session reading files. The shim is the path-less handshake the Human Lead types; this file is the real entry point.

AI-Lore can also be **installed** into an engine — see [`bindings.md`](./bindings.md) and the [`install`](./verbs/install.md) verb. Installing wires the verbs into the engine's native mechanisms and reinforces the bookends so they cannot be skipped. The methodology is identical either way; installing changes how it is delivered, not what it says. Until a project is installed, the plain-text path is the methodology in full — and the plain-text path stays available *after* install too, so a different AI can open the same project and run on it.
