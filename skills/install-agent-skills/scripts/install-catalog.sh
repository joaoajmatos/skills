#!/usr/bin/env sh
set -eu

source='https://github.com/joaoajmatos/skills.git'
destination=''
install_all=false
selection=''
temporary_checkout=''

usage() {
  printf '%s\n' 'Usage: install-catalog.sh --dest <skills-directory> [--source <catalog-root-or-git-url>] (--all | <skill-name>...)'
}

cleanup() {
  if [ -n "$temporary_checkout" ]; then
    rm -rf "$temporary_checkout"
  fi
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    --dest)
      [ "$#" -ge 2 ] || { usage >&2; exit 2; }
      destination=$2
      shift 2
      ;;
    --source)
      [ "$#" -ge 2 ] || { usage >&2; exit 2; }
      source=$2
      shift 2
      ;;
    --all)
      install_all=true
      shift
      ;;
    --help|-h)
      usage
      exit 0
      ;;
    -*)
      usage >&2
      exit 2
      ;;
    *)
      selection="$selection $1"
      shift
      ;;
  esac
done

[ -n "$destination" ] || { usage >&2; exit 2; }
[ "$install_all" = false ] || [ -z "$selection" ] || { printf '%s\n' 'Use --all or named skills, not both.' >&2; exit 2; }
[ "$install_all" = true ] || [ -n "$selection" ] || { usage >&2; exit 2; }

case "$source" in
  *://*|git@*)
    temporary_checkout=$(mktemp -d)
    trap cleanup EXIT HUP INT TERM
    git clone --depth 1 "$source" "$temporary_checkout/catalog" >/dev/null
    catalog_root="$temporary_checkout/catalog"
    ;;
  *)
    catalog_root=$source
    ;;
esac

catalog_skills="$catalog_root/skills"
[ -d "$catalog_skills" ] || { printf 'No skills directory found in %s\n' "$catalog_root" >&2; exit 1; }
mkdir -p "$destination"

if [ "$install_all" = true ]; then
  selection=$(find "$catalog_skills" -mindepth 1 -maxdepth 1 -type d -exec sh -c 'test -f "$1/SKILL.md" && basename "$1"' sh {} \; | sort)
fi

for skill in $selection; do
  case "$skill" in
    *[!ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-]*|'')
      printf 'Invalid skill name: %s\n' "$skill" >&2
      exit 2
      ;;
  esac

  source_skill="$catalog_skills/$skill"
  target_skill="$destination/$skill"
  [ -f "$source_skill/SKILL.md" ] || { printf 'Skill not found: %s\n' "$skill" >&2; exit 1; }

  if [ -e "$target_skill" ]; then
    printf 'Skipped existing skill: %s\n' "$skill"
    continue
  fi

  cp -R "$source_skill" "$target_skill"
  printf 'Installed skill: %s\n' "$skill"
done
