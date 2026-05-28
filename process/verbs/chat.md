# chat

`chat` sets the session's posture to Chat. While in Chat, the session converses with the Human Lead and touches nothing substantive — both the Payload and Memory are read-only, with one narrow exception: **marginalia** (defined below).

## The operation

1. **If mounted on a track**, write `posture: chat` to the mounted track's record (`memory/tracks/<name>.track.md`) via [`write-lore`](./write-lore.md). The posture-write itself is one Memory write Chat permits on the track. Skip the write if the track already records `chat`.
2. **If trackless**, `chat` is a no-op — the session is already read-only across the project. The implicit posture *is* chat.
3. **Converse.** Answer, acknowledge, think out loud. Findings, decisions, and corrections that surface during the chat are held mentally for the next posture — not written, with the marginalia exception below.
4. **Refuse substantive writes** while in Chat. A request that would write content to the Payload, or that would compose new content / restructure / rewrite Memory, is held until the Human Lead invokes [`execute`](./execute.md), [`reshape`](./reshape.md), or [`plan`](./plan.md). Those verbs, if invoked while trackless, trigger the [`mount`](./mount.md) flow before they can write the new posture.

## Marginalia — the chat carve-out

Some operations are housekeeping, not composition: spotting a stale reference, fixing a broken link, adding a missing index entry, bumping a date. Asking the Human Lead to redial out of chat just to make a one-character correction is ceremony. Chat permits these — and only these — as **marginalia**.

**Marginalia is:**

- **Frontmatter edits.** Anything in a Memory file's YAML frontmatter — references, `updated:`, status, title, type-specific fields.
- **Link repair.** Changing a link target where the file's surrounding content stays the same — fixing a stale path, repointing a moved reference.
- **Single-token typo or punctuation fix** in existing prose. One word, one character, one mark.
- **Index entries.** Adding a sibling or child line in an `.index.md` file.

**Marginalia is not:**

- New sections, headings, or paragraphs.
- Rewriting or restructuring existing prose.
- Adding content nodes (KT entries, AT nodes, focus bodies, blueprint entries, journal entries).
- Anything in the Payload — Payload changes always require [`execute`](./execute.md).

**The litmus:** *if removing the change wouldn't shift what the file means to a future reader, it's marginalia*. Anything that changes meaning is composition, not housekeeping, and needs `plan` / `reshape` / `execute`.

**Marginalia is Human-Lead-initiated.** Chat is "converse first"; the session does not decide to write marginalia on its own. The Human Lead reaches for marginalia explicitly while chatting — *"while we're here, fix that broken link"* — and the session executes the narrow write.

**Marginalia still goes through [`write-lore`](./write-lore.md).** Placement, schema, and claim enforcement all apply. The chat exemption permits the write under chat posture; it does not bypass `write-lore`'s guarantees. If a marginalia request would land outside the mounted track's claim (carve-outs aside), `write-lore` refuses it normally.

**Marginalia is Memory only.** The Payload's read-only rule under chat is absolute. There is no Payload marginalia.

## Trackless marginalia triggers mount

If the Human Lead initiates marginalia from a trackless chat session, the [`mount`](./mount.md) flow fires the same way it does for any write — auto-home if home is free, HL-prompted otherwise. Once mounted, the marginalia write lands. The mount-on-first-write rule is universal; marginalia is not a bypass.

The posture is the gate. Chat is for the moments where the Human Lead wants to think, vent, or align — without the session reaching for action — while leaving the door open to fix a stray reference along the way.
