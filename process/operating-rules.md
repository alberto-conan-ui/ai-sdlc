# Operating rules

The runtime rules and operations the AI uses to operate a session. Universal-load, so any session, any stance, knows them. The other pillars describe *what the system is* (project structure, memory), *where the session is working* (modes, tracker), and *how the AI behaves* (dials). This file describes *what the session does at runtime* — the rules it holds across every interaction and the operations the Human Lead can invoke into a running session.

## Stance awareness

When the session notices the character of its work changing — design drifting into implementation detail, execution into critique — it flags the shift so the Human Lead can confirm or redirect. [Redial](#redial) is the reactive correction when the session fails to notice.

When the Human Lead's direction implies switching to a different stance, the session pauses and confirms rather than silently switching. The Human Lead can always override; the session's job is to ask, not to block.

## Verbs

A verb is a named operation the Human Lead invokes by saying its name. Verbs are how the Human Lead reaches into a running session and asks for a specific operation.

Verbs fall on a proactive–reactive axis.

**Proactive** verbs are invoked before or during planned work — Reshape, Rewrite, Digest, Dictation.

**Reactive** verbs are corrections invoked after the session has failed in a specific way — Split, Redial.

### Targets

A proactive verb walks up the current context's [ancestry](./tracker/tracker.index.md#ancestry-and-context) — following the [tracker chain](./tracker/tracker.index.md#the-chain) — to locate the target node and sanitise references along the way. It then acts on the target's [context](./tracker/tracker.index.md#ancestry-and-context) — the node and its subtree. The ancestry's references to the target move with the change. The session infers the target from the conversation; if unsure, it proposes a likely one and asks the Human Lead to confirm or redirect.

Reactive verbs (Split, Redial) do not take a target. They operate on the session itself.

### Production verbs

Three verbs sit on a trust axis over a body of Memory:

- **Reshape** writes on trust — content is right, shape is wrong.
- **Rewrite** writes on distrust — content cannot be carried forward.
- **Digest** evaluates — neither writes nor restructures; surfaces whether the content can be trusted at all.

#### Reshape

The Human Lead has a body of Memory whose content is trusted but whose shape is not. Reshape moves the content around and rewrites the structure in one pass; the content itself comes out largely the same.

Trigger: Human Lead says "reshape" and names the target.

#### Rewrite

The content itself can no longer be carried forward; reshaping it would propagate the problem. Rewrite returns to the underlying sources and produces a fresh replacement. The previous memory is reference-only — read to understand what was there, not cherry-picked for pieces to carry forward. The replacement stands on its own.

Trigger: Human Lead says "rewrite" and names the target.

#### Digest

The Human Lead is unsure of the shape of an area of Memory and orders a digest. Digest does not summarise — it diagnoses. The session reads the target with Critical pushback and reports gaps, contradictions, unfounded claims, and stale references. Digest is read-only; whether to Reshape or Rewrite is a separate decision the Human Lead makes from the output.

Trigger: Human Lead says "digest" and names the target.

### Split

A reactive correction for a delivery failure. A session has delivered a wall of findings in one block, the default collapse when a stance drops its dials during delivery. Split takes that wall and redelivers it as ranked items, one at a time, in voice.

Trigger: Human Lead says "split" after a wall-of-text delivery.

The session leads with its verdict, ranks the findings by severity, presents the first item, and waits. Human Lead says continue, next item, and so on. The stance stays in character throughout — split is not a formatting fix, it is a return to the dials the stance was supposed to be holding.

Structured findings should already be delivered one-at-a-time ranked by default. Split is the correction for when the AI failed and dumped a wall anyway.

### Redial

A reactive correction for dial drift. The session has drifted off its stance's dial settings — Contractor walls of text under a CxO jacket, Partner overreach on a task that called for External scope, OCD taxonomy under a Goal-oriented precision. Redial re-applies the stance's declared dials from cold.

Trigger: Human Lead says "redial" (or "redial yourself").

The session re-reads its stance's dial settings, names the drift it is correcting from, and writes the next response from the re-applied dials, not the drifted ones.

Redial is the first verb added from observation rather than theory. Every other verb in this file was designed in the role system. Redial was named after watching the process fail to hold a dial under pressure across a single session and naming the correction the Human Lead had been invoking unnamed. Its existence is evidence the universal-load architecture works: a recurring failure becomes a loadable word.

### Dictation

A collaborative input polish. The Human Lead wants to feed the session a block of text — a paragraph, a rule, a finding — but wants it shaped before it is consumed, not after.

Trigger: Human Lead prefixes the input with `[PROMPT]`.

The session reads the input as raw material, not as instruction. It proposes a polished version — same meaning, tighter shape, consistent voice with the target artifact — and waits for the Human Lead to confirm, edit, or reject before the input takes effect anywhere.

## Session close

Run at the close of every session, regardless of stance.

1. **Propose the status update.** The active stance proposes the full status: mode, active focus, next step, relevant journal links. The Human Lead confirms or corrects. This leverages the session's full context rather than asking the Human Lead to reconstruct it.
2. **Write the journal file** in `journal/live/YYYY-MM-DD_NN.md` — header metadata (date, stance, mode, active focus), session body covering the work done, and a handover section as the last part of the file, using the status the Human Lead confirmed in step 1. File format and handover mechanics live in the [Journal sub-pillar](./memory/journal.md).
3. **Update `memory/status/status.index.md`** with the confirmed state: mode, active focus, relevant journal reference, next step.
4. **Update the knowledge tree** if insights from this session are immediately clear and well-placed.
5. **Verify all links** in new files point to `.md` files and resolve correctly.
