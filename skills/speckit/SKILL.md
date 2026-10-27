---
name: speckit
description: Set up or use GitHub Spec Kit for spec-driven development in a project. Use when the user asks to establish a constitution, create a specification, plan work, generate tasks, or adopt the Speckit workflow.
---

# Speckit

Use the official [GitHub Spec Kit](https://github.com/github/spec-kit) distribution. Its `specify` CLI installs the complete, version-compatible set of project-local `speckit-*` skills and the `.specify/` support files they require. Do not copy command templates into a project by hand.

## Before setup

1. Identify the target project and its coding-agent integration. For Codex, use the `codex` integration, which installs project-local skills under `.agents/skills/`.
2. Inspect the project for an existing `.specify/` directory and `speckit-*` skills. Preserve an existing installation unless the user asks to upgrade, switch, or reinitialize it.
3. Explain that initialization creates or updates project files. Get confirmation before installing the CLI globally or running initialization in a non-empty project.

## Install and initialize

Install the official CLI with the project's approved Python tool manager. The recommended command is:

```sh
uv tool install specify-cli
specify version
```

For a new project, initialize the selected agent integration:

```sh
specify init <project-name> --integration codex
```

For an existing project, run this from its root only after the user confirms the merge:

```sh
specify init --here --force --integration codex
```

Use `--non-interactive --ignore-agent-tools` only when setup must run without a terminal prompt or the agent executable is intentionally unavailable. For another coding agent, replace `codex` with the official integration key.

## Use the workflow

Follow the process in the agent chat, reviewing each artifact before moving forward:

1. `$speckit-constitution` once per project.
2. `$speckit-specify` for the feature or change.
3. `$speckit-clarify` for meaningful ambiguity.
4. `$speckit-plan`, then `$speckit-checklist` when it adds a useful quality gate.
5. `$speckit-tasks`, `$speckit-analyze`, and `$speckit-implement`.
6. `$speckit-converge` until the artifacts and code agree.

The `$speckit-*` spelling is for Codex. Other agents expose the same generated skills with their own invocation syntax.

## Maintain

Use `specify self check` to check for an available update without changing the installation. Follow the official upgrade path for the installed tool manager and let the CLI update its project integration; do not mix files from different Spec Kit releases.
