# Bootstrap a project

> **References**
>
> | Group            | File                                                   |
> |------------------|--------------------------------------------------------|
> | Parent           | [../project-lifecycle.index.md](../project-lifecycle.index.md) |
> | Project structure | [../../project-structure.md](../../project-structure.md) |
> | Build            | [../build/build.index.md](../build/build.index.md)     |

## Children

- [step1.md](./step1.md) — Part 1 mechanical walkthrough. Vendor Upstream, run `setup-project.sh`, compose Process.
- [step2.md](./step2.md) — Part 2 Migrator-driven walkthrough. Initialize Memory, seed the blueprint, capture context, install the root `ai_readme.md`.
- [ai_readme-bootstrap.md](./ai_readme-bootstrap.md) — minimal session loader used once per project to bring a Migrator session into the bootstrapped folder for Part 2.
- [setup-project.sh](./setup-project.sh) — the Part 1 script, called at the end of step1's Step B.
- [focus.template.md](./focus.template.md) — focus file template. Step 6 copies this from Upstream when an initial focus is set.
- memory-skeleton/ — the conformant Memory tree shape. Step 4 copies this wholesale into `{lore_dir}/memory/` from Upstream.

---

Bootstrap turns a folder — empty or pre-existing — into an operational AI-Lore project. It runs in two parts. **Part 1 — Kickstart** brings AI-Lore onto disk and prepares the ground for a Migrator session: it vendors Upstream, writes the project manifest, and composes the Process dist. No methodology is loaded in Part 1 — it is mechanical setup. **Part 2 — Initialisation** is a Migrator session opened against the bootstrapped folder. Migrator initializes Memory from the conformant skeleton, seeds the blueprint from the chosen plugin, asks you for a one-line project description and an optional first focus, verifies the result, and installs the project-root session entry point as its closing move. The walkthrough Migrator follows lives in [`step2.md`](./step2.md) for reference — you do not need to read it yourself.

## Pick a project name first

Before running any command, decide the project's name. The name becomes a real directory on disk: the Lore folder is `.ai-lore-<project_name>/`, not `.ai-lore/`. Every project has a different Lore folder name so that two projects in the same ancestor chain cannot collide in path resolution.

Rules:

- Must match `^[a-zA-Z0-9_][a-zA-Z0-9_-]*$` — letters, digits, underscore, hyphen. No spaces, no slashes, no leading dot or hyphen.
- Must be unique among AI-Lore projects in the same ancestor chain. If an enclosing parent directory already contains `.ai-lore-<name>/` with the same name, bootstrap refuses.

Short, specific, filesystem-safe. `setup-project.sh` validates both rules and fails loudly on violation. See [`project-structure.md`](../../project-structure.md) for the reasoning.

There are two ways to drive bootstrap end-to-end. Pick the one that matches who is in the room. Both flows finish in the same place: an operational project.

## If you want an AI to help you

Open an AI assistant (Claude Code, Cursor, Aider, or similar) against the folder you want to bootstrap, and paste:

> *Read `https://raw.githubusercontent.com/alberto-conan-ui/ai-sdlc/main/process/project-lifecycle/bootstrap/step1.md` and run the commands yourself. Project name: `<name>`. Plugin: `<plugin>`. When `step1` exits cleanly, do not stop, do not summarize, do not wait for confirmation — its clean exit is the start of Part 2, not the end of the task. The final line of `setup-project.sh` prints a `Read ... ai_readme-bootstrap.md` instruction with the versioned Process path filled in; follow that instruction exactly. That file loads the pillars, loads Migrator, and walks you through Part 2 in the same session.*

Replace `<name>` and `<plugin>` with your chosen project name (following the rules above) and one of the plugins shipped under the core's `plugins/` folder. The same session that ran Part 1 stays open and continues straight into Part 2 as Migrator. No fresh session needed.

## If you prefer to run this

1. Open [`step1.md`](./step1.md) and run the two commands yourself. When the script exits cleanly, Part 1 is done. `setup-project.sh` prints the versioned Part 2 kickoff prompt at the end — copy it.
2. Open an AI assistant against the bootstrapped folder — a fresh session, since you ran Part 1 in a shell — and paste the prompt the script printed (the shape is `Read .ai-lore-<name>/process/project-lifecycle/bootstrap/ai_readme-bootstrap.md and follow it.`).

    That loader reads the pillars from the now-local Process, loads Migrator, and walks the session through Part 2.

## After bootstrap

The project is operational. Every subsequent session opens against the project-root `ai_readme.md` and the bootstrap files are never read again. Upgrades to the Process are handled by [migration](../migration/migration.index.md), which reruns the build against new Upstream pins.

Bootstrap always runs against the latest release; the version that lands in `workspace.yaml` is captured from the cloned Upstream by [`step1.md`](./step1.md)'s setup script.
