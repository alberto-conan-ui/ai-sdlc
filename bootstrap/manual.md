# Bootstrap: Manual (Step A)

> Get ai-sdlc and the code repo into the workspace folder. That's it.
> Step B (journal, skeleton files) is handled by the bootstrapper role —
> see [README.md](./README.md).

---

## 1. Set up the workspace folder

> **Cowork users — skip this.** Your selected folder is already the workspace.

```bash
mkdir <path-to-your-workspace>
cd <path-to-your-workspace>
```

## 2. Add ai-sdlc

```bash
# First project — clone directly:
git clone https://github.com/alberto-conan-ui/ai-sdlc.git
# Additional projects — symlink a shared clone instead:
# ln -s ~/repos/ai-sdlc ./ai-sdlc
```

## 3. Clone the code repo

```bash
git clone <code-repo-url> my-project
# Or if already cloned elsewhere:
# ln -s ~/repos/my-project ./my-project
```

## Verify

You should now have:

```
<workspace>/
├── ai-sdlc/
└── my-project/
```

---

## Next

Step A is done. Continue with **Step B** in [README.md](./README.md) — point your
AI tool at the workspace folder and let the bootstrapper role handle the rest.

