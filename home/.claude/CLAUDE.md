# Global preferences (all projects)

## Git commits
- When creating a git commit, add the trailer `Assisted-by: Claude Code (Model: <modelname>)` where `<modelname>` is the actual model running the session (e.g. `Opus 4.8`).
- Do NOT add a `Co-authored-by` trailer. Use `Assisted-by` instead.

## GitHub Actions workflows
- When adding or editing a step that uses an action (`uses: owner/repo@vX`), always look up the latest released version of that action first (e.g. `gh release view --repo owner/repo` or `gh api repos/owner/repo/releases/latest`) instead of relying on memory, and reference it by its major tag only (e.g. `@v5`), not a full version like `@v5.2.1` or a commit SHA.
