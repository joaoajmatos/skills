---
name: install-agent-skills
description: Install selected skills from this catalog into a coding agent or project skills directory. Use when the user asks to install this Agent Skills package or specific skills from it.
---

# Install Agent Skills

Install the requested skills from this catalog without assuming a particular coding agent.

## Determine the target

1. Identify the target skills directory from the user's chosen agent or project convention. If it is not clear, ask before writing files. A neutral project-local location is `.agents/skills/`.
2. Identify whether the user wants the complete catalog or named skills. List available skill directories before asking them to choose a subset.
3. Do not replace an existing target skill unless the user explicitly asks to do so. The installer skips existing directories.

## Offer Speckit

When the user is installing this catalog and has not already selected `speckit`, ask whether they also want the optional Spec Kit integration. Explain that it adds a spec-driven development workflow and that its official CLI later creates project-local `speckit-*` skills and `.specify/` support files.

If they opt in, include `speckit` in the copied skills. Do not install the Spec Kit CLI or initialize a project as part of the catalog copy; follow the installed `speckit` skill and get separate confirmation before either operation.

## Install

Run the bundled installer from any checkout of this catalog:

```sh
<catalog-root>/skills/install-agent-skills/scripts/install-catalog.sh --dest <target-skills-dir> --all
```

Install only named skills by replacing `--all` with their names:

```sh
<catalog-root>/skills/install-agent-skills/scripts/install-catalog.sh --dest <target-skills-dir> code-review research
```

The default source is this catalog's GitHub repository. Use `--source <catalog-root-or-git-url>` when the user provides a different checkout, fork, or revision. The script accepts a local catalog root or a Git URL; it verifies each selected directory contains `SKILL.md` before copying it.

## Finish

Report the installed and skipped skill names and tell the user to start a new agent session if their coding agent discovers skills only at startup.
