# Adapter Guide

This repository distributes standard Agent Skills rather than plugins for a single coding agent.

## Contract

- A skill directory contains a `SKILL.md` entry point and any files it references.
- The YAML `name` is the stable skill identifier; the directory name should match it.
- Relative paths in a skill are resolved from its own directory.
- `skills/` is this repository's distribution catalog, not a runtime-specific install path.

## Project-local skills

When a skill creates another skill inside a target project, use that project's configured skills directory. Where no convention already exists, use:

```text
.agents/skills/<skill-name>/
```

An adapter for a particular agent may copy or link these directories into its own discovery location. Keep adapters outside the portable `skills/` directories so the catalog remains agent-neutral.

## Compatibility adaptations

`create-verification-skill` and `maintain-verification-skill` use the placeholder `<project-skills-dir>` rather than vendor-specific paths. Resolve it using the target project's convention before following either skill.
