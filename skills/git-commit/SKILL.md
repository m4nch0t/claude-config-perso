---
name: git-commit
description: Format of every git commit message (gitmoji + Conventional Commits). Use whenever you write a commit message, amend one, or squash commits.
---

Subject: `<gitmoji> <type>[(scope)][!]: <subject>`
- Under 72 chars, imperative mood, no final period.
- Body only if context is needed; wrap at 72.
- Breaking change: `!` after type/scope, or a `BREAKING CHANGE:` footer.

| Gitmoji | Type | Use for |
|---|---|---|
| ✨ | feat | new user-visible feature |
| 🐛 | fix | bug fix |
| 🚑️ | fix | critical hotfix |
| 🔒️ | fix | security fix |
| 📝 | docs | documentation only |
| 🎨 | style | formatting, no behavior change |
| ♻️ | refactor | restructure, no behavior change |
| 🏗️ | refactor | architecture change |
| ⚡️ | perf | performance |
| ✅ | test | add or fix tests |
| ⬆️ / ⬇️ | build | upgrade / downgrade dependencies |
| 👷 | ci | CI build system |
| 🔧 | chore | configuration files |
| 🔥 | chore | remove code or files |
| 🚨 | chore | fix linter warnings |
| 🏷️ | chore | types |
| 🗃️ | chore | database change |
| ⏪️ | revert | revert an earlier change |
| 💥 | any + `!` | breaking change |

Example:
```
✨ feat(s3): add bucket lifecycle policy support

The API now accepts a `lifecycle` field. Rules are validated
before they reach the backend.
```
