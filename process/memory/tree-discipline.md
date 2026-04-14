# Tree discipline

Structural conventions for the memory model. These apply across every memory tree — status, journal, action tree, knowledge tree. They are what keep any tree in Memory navigable.

## The typed file system

Every file in the memory system follows one naming convention: **`[name].[type].md`**. The type suffix tells you what the file is without opening it.

## The index — navigation primitive

The index file is the core navigation mechanism of the memory model. Every orientation decision the session makes flows through an index. When the session enters a folder, it reads the index. When it needs to decide what to load next, it follows links from the index. The index is not a bureaucratic requirement — it is the interface between the session and the project's memory.

Every folder has `[folder-name].index.md`. No exceptions. The index uses a three-section navigation grammar:

**References** — external context this folder depends on. The parent index, relevant knowledge tree nodes, relevant journal entries. References point up and sideways — they tell the session what else it needs to understand this node. References appear on all files (not just indexes), but they are the first section of every index.

**Siblings** — typed companion files in the same folder. Siblings are listed with a brief role description so the session knows what each file contributes without opening it.

**Children** — nodes below this one in the hierarchy. Child folders or files, listed with brief descriptions. Children are the downward navigation path.

The grammar is the same everywhere: AT indexes, KT indexes, status folders. The session uses the same pattern to navigate: find the index, read References to understand context, scan Siblings to see companion files, scan Children to decide whether to go deeper.

## Reference headers

Every file in the memory system carries a reference header that declares its dependencies — what other files need to be read to understand this one. Content lives in exactly one place; references point to it. In index files, this is the References section of the navigation grammar. In non-index files, it serves the same purpose: declare what the reader needs to load for context.

```markdown
> **References**
>
> | Group            | File                                                         |
> | ---------------- | ------------------------------------------------------------ |
> | Parent           | [../parent.index.md](../parent.index.md)                     |
> | Knowledge        | [../../knowledge-tree/area/area.index.md](../../knowledge-tree/area/area.index.md) |
```

Groups are labeled (why the reference matters), ordered by importance (reading strategy for the session), and point up and sideways — downward traversal is implicit, the session reads children when the task requires it.

When a file moves, update the references that point to it. Single-source means there is nothing else to update.

## Naming

- Project memory folder: `{lore_dir}/memory/`
- File naming: `[name].[type].md` — every file declares its type in the name
- Every folder: `[folder-name].index.md` — navigation entry point
- Journal files: `YYYY-MM-DD_NN.md` in `journal/live/`
- KT branches: `reconciled/`, `working/`, `notepad/`
- AT node folders and files follow the plugin's naming

## Linking rules

All links in memory files follow the navigation grammar:

- All links point to `.md` files, never to folders. Use `[child/child.index.md](./child/child.index.md)`, not `[child/](./child/)`.
- **References** point up and sideways — parent index, relevant KT nodes, relevant journal entries. Each reference includes a group label.
- **Siblings** list companion files in the same folder. Each includes a brief role description.
- **Children** list contained nodes — child folders (via their index) and child files. Each includes a brief description.
- Links use relative paths. When a file moves, update the references that point to it.

## How memory changes

Memory can change in two ways.

**Append-forward** moves the project forward by adding new artifacts. Previous artifacts remain in place; new state sits alongside them. The full record of the project's thinking accumulates over time.

**Verbs** change existing artifacts directly. Reshape restructures a body of memory in place, keeping its content. Rewrite replaces it with a fresh version. See [operating-rules — Verbs](../operating-rules.md#verbs).

The two serve different purposes. Append-forward is suited to work that builds on past state — the accumulated record is the value. Verbs are suited to work where the past state would obscure the current truth, or where the shape itself has drifted from what the content needs to be.

The journal is exempt from verbs. Journal files follow append-forward unconditionally — Reshape and Rewrite do not touch them. The journal is the audit trail; transformations are recorded in it, never applied to it.

## Archive

Every memory tree has an `archive/` subfolder. Content moves there when it is no longer part of active work but is kept as historical record — closed focuses, completed action-tree subtrees, rolled journal files, retired knowledge nodes. Archived content is preserved unchanged, is load-on-demand (a session does not read `archive/` at open), and is available when a session needs to retrieve past state. The trigger and mechanism for archiving differ by tree type and live in the relevant sub-pillar.

## Hierarchy discipline

Well-structured trees keep references short and navigation efficient. This is a Human Lead responsibility — the process signals when the hierarchy is degraded, but only the Human Lead decides how to restructure.

### What makes a good node

A node earns its folder when it has a distinct concern that is loaded independently. In the KT, that means the information is needed for work in this area but not in sibling areas. In the AT, that means the work has its own completion criteria and its own lifecycle.

### Signals the hierarchy needs attention

- A file exceeds ~200 lines — split into children.
- A folder has more than 5–7 direct children — add intermediate grouping.
- A reference header has more than 4–5 entries — the hierarchy is not carrying enough context implicitly.
- The same information appears in multiple siblings — cross-cutting concern should move up.

The Human Lead owns the tree shape. Stances propose; the Human Lead confirms, redirects, or restructures.
