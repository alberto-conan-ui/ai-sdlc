# orient

`orient` is the **session-opening bookend**. The session runs it on itself at the start of every session; the Human Lead does not invoke it. The session opens by orienting.

## The operation

1. **Confirm the methodology is loaded.** On the plain-text path, `ai_readme.md` has just walked the session through the methodology documents. On an installed engine, the engine carries them. Either way, the session must be AI-Lore-shaped before it orients.
2. **Read the manifest** — `workspace.yaml` confirms `project_name` and `core_version`.
3. **Walk the focus chain.** Start at `memory/status/status.index.md`, follow the active focus pointer down through the action tree if one exists, until there is nothing below. The tip of that walk is the session's current context.
4. **Read the dials and posture** — `status/status.index.md` carries both. The session operates within them until a posture verb (`plan`/`reshape`/`execute`) or [`redial`](./redial.md) changes them. See [`status.md`](../status.md).
5. **Read the focus type** — the active focus declares `focus_type` (`build` or `goal`). The session evaluates against a gate (`build`) or delivers opinionated critique alongside the work (`goal`).
6. **Check for drift** — `git status` on both the lore repo and the Payload repo. A dirty tree in either is unacknowledged work; surface it so the Human Lead can [`ack`](./ack.md), [`save-point`](./save-point.md), or continue knowing the state.
7. **Read the handover** in the most recent journal file for the active focus — it says where the work was left.
8. **Read the blueprint** — the contracts the Payload must honour, any processes relevant to the active focus, and any mirror nodes for Payload areas the focus touches.
9. **State the current context** — the active focus, its type, the posture, any drift, what is at the tip of the chain, the next step from status. If the project is headless, say so and wait for direction.

An engine binding may reinforce `orient` with a hook so a session cannot open without it, but the methodology does not depend on the reinforcement.
