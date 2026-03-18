# Bootstrap: Manual (Step A)

> Get ai-sdlc into your code repo's `.ai-sdlc/` folder. That's it.
> Step B (project memory, skeleton files) is covered in [README.md](./README.md).

---

## 1. Ensure .ai-sdlc/ is gitignored

From your code repo root:

```bash
# Add to .gitignore if not already present:
echo '.ai-sdlc/' >> .gitignore
echo 'ai_readme.md' >> .gitignore
```

> **Alternatively**, add `.ai-sdlc/` and `ai_readme.md` to your global gitignore (`~/.gitignore_global`)
> if you prefer zero modifications to the code repo.

## 2. Create the .ai-sdlc folder and add the methodology

```bash
mkdir -p .ai-sdlc

# First project — clone directly:
git clone https://github.com/alberto-conan-ui/ai-sdlc.git .ai-sdlc/methodology

# Additional projects — symlink a shared clone instead:
# ln -s ~/repos/ai-sdlc .ai-sdlc/methodology
```

## Verify

You should now have:

```
my-project/                    ← your code repo root
├── .ai-sdlc/
│   └── methodology/           ← ai-sdlc
└── .gitignore                 ← includes .ai-sdlc/
```

---

## Next

Step A is done. Continue with **Step B** in [README.md](./README.md) — point your
AI tool at the code repo root and follow the setup steps.
