#!/usr/bin/env bash
input=$(cat)

IFS=$'\t' read -r model used cwd < <(
  printf '%s' "$input" | jq -r '[
    .model.display_name // "unknown",
    (.context_window.used_percentage // 0 | tostring),
    (.workspace.current_dir // .cwd // ".")
  ] | @tsv'
)

branch=$(git -C "$cwd" --no-optional-locks branch --show-current 2>/dev/null)

color=$(awk -v u="$used" 'BEGIN {
  if (u+0 < 30) print "\033[32m";
  else if (u+0 < 75) print "\033[33m";
  else print "\033[31m";
}')
reset=$'\033[0m'
ctx_str=$(printf "%s%.0f%%%s" "$color" "$used" "$reset")

parts="$model $ctx_str"
[ -n "$branch" ] && parts="$parts   [$branch]"

printf "%s" "$parts"
