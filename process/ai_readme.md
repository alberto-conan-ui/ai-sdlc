# AI-Lore — Session Entry Point

The first thing every AI-Lore session reads. It loads the methodology, then hands off to the project.

AI-Lore is a methodology for building a **Payload** — software, a campaign, a specification, anything that benefits from persistent context — with an AI partner that remembers across sessions and challenges its own prior decisions.

---

## 1. Load the methodology

Read these documents in order. Reading them is what makes the session AI-Lore-shaped for the rest of its lifetime.

1. [`project-structure.md`](./project-structure.md) — the vocabulary, the disk layout, the manifest
2. [`memory.md`](./memory.md) — the persistent record: journal, blueprint, save-points, trees, the file schema
3. [`status.md`](./status.md) — the live register: status as registry, focus, dials, posture, the conversational register
4. [`tracks.md`](./tracks.md) — the workspace primitive: master and children, mounting, claims, sessions
5. [`git.md`](./git.md) — the git contract: two repos, branches per track, drift signal, the explicit `git -C` discipline
6. [`verbs/verbs.index.md`](./verbs/verbs.index.md) — the operations a session runs and the Human Lead invokes
7. [`bindings.md`](./bindings.md) — how the platform-neutral methodology binds to a specific AI engine

A session that has read these seven knows the whole methodology. Everything below this folder is reference.

## 2. Orient

Run the `orient` bookend ([`verbs/orient.md`](./verbs/orient.md)): read the registry in `memory/status/status.index.md`, decide how deep to walk based on what tracks are open, surface drift, and state where the work stands. If the project is headless, say so and wait for direction.

## 3. Work

From there, ordinary work proceeds. The Human Lead invokes verbs as needed; the session closes by running `close-session`.

---

## Plain text, and installed

This is the **plain-text path**: it works on any AI, with no setup. Point a session at the project and say *"read ai_readme.md"* — the AI reads the two-line shim at the project root, which redirects here, and everything above happens by the session reading files. The shim is the path-less handshake the Human Lead types; this file is the real entry point.

AI-Lore can also be **installed** into an engine — see [`bindings.md`](./bindings.md) and the [`install`](./verbs/install.md) verb. Installing wires the verbs into the engine's native mechanisms and reinforces the bookends so they cannot be skipped. The methodology is identical either way; installing changes how it is delivered, not what it says. Until a project is installed, the plain-text path is the methodology in full — and the plain-text path stays available *after* install too, so a different AI can open the same project and run on it.
