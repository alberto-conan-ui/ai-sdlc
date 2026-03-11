# Bootstrap: Manual (Step A)

> Get ai-sdlc and the code repo into the workspace folder. That's it.
> Step B (journal, skeleton files) is handled by the bootstrapper role —
> see [README.md](./README.md).

---

## Steps

```bash
# 1. Create the workspace
mkdir ~/workspaces/my-project-workspace
cd ~/workspaces/my-project-workspace

# 2. Add ai-sdlc
# First project — clone directly:
git clone https://github.com/alberto-conan-ui/ai-sdlc.git
# Additional projects — symlink a shared clone instead:
# ln -s ~/repos/ai-sdlc ./ai-sdlc

# 3. Clone the code repo
git clone <code-repo-url> my-project
# Or if already cloned elsewhere:
# ln -s ~/repos/my-project ./my-project
```

You should now have:

```
my-project-workspace/
├── ai-sdlc/
└── my-project/
```

---

## Next

Step A is done. Continue with **Step B** in [README.md](./README.md) — point your
AI tool at the workspace folder and let the bootstrapper role handle the rest.

---

## Multiple Projects

Each project gets its own workspace and journal. The methodology is shared via symlink:

```
~/workspaces/
├── project-a-workspace/
│   ├── project-a/
│   ├── project-a-journal/
│   └── ai-sdlc/          ← symlink → ~/repos/ai-sdlc
├── project-b-workspace/
│   ├── project-b/
│   ├── project-b-journal/
│   └── ai-sdlc/          ← symlink → ~/repos/ai-sdlc
```
