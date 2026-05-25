---
name: ai-lore-close-session
description: "Session close — write the journal, handover, status, and surface any drift"
---

# close-session

`close-session` is the **session-closing bookend**. The session runs it on itself at the end of every session; the Human Lead does not invoke it. The session closes by closing.

## The operation

Every write goes through [`write-lore`](./write-lore.md).

1. **Propose the status update.** State the full status — active focus, focus type, posture, next step, relevant journal links. The Human Lead confirms or corrects.
2. **Write the journal file** — `journal/live/YYYY-MM-DD_NN.md`. Frontmatter (`date`, `session`, `focus`, `dials`, `posture`), a body covering the work done, and a **handover** section last: what was being worked, where it was left, what the next session does first, what to watch.
3. **Update `status/status.index.md`** with the confirmed state — active focus, posture, relevant journal reference, next step.
4. **Update the knowledge tree** if insights from this session are immediately clear and well-placed.
5. **Verify all links** in new files point to `.md` files and resolve.
6. **Surface any drift.** Re-check `git status` on both repos. If dirty, name the unacknowledged changes — the Human Lead can [`ack`](./ack.md), [`save-point`](./save-point.md), or close the session knowing work is uncommitted.

An engine binding may reinforce `close-session` with a hook so a session cannot close without it, but the methodology does not depend on the reinforcement.
