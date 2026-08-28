# Comment.io plugins

This repository is the public distribution for the Comment.io Codex and Claude Code plugins. Its default branch is the production channel; named `preview/<name>` branches are explicit test channels pinned to their recorded preview origin.

This `production` publication is pinned to `https://comment.io`.

## Install production

Codex:

```sh
codex plugin marketplace add comment-hq/comment-io-plugins
codex plugin add comment-codex@comment-io-plugins
```

Claude Code:

```sh
claude plugin marketplace add comment-hq/comment-io-plugins --scope user
claude plugin install comment-io@comment-io-plugins --scope user
```

Ordinary production installs use the repository default branch and omit channel, ref, and `production` selectors.

- Codex: after installation or update, restart Codex. Then run `codex mcp login comment-io` and complete browser authorization. After authorization succeeds, start a fresh conversation.
- Claude Code: after installation or update, restart Claude Code. Complete browser authorization when prompted. After authorization succeeds, start a fresh conversation.

## Preview content is public

Every file built into a preview plugin artifact is published to a public Git branch. Do not put secrets, customer data, private source, credentials, or unpublished assets into a preview artifact. A preview is installable only after its exact source SHA has matching successful deployment evidence.
