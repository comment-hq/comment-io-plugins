# Comment.io plugins

## Connect directly through your client

Connect to a Comment.io workspace using remote OAuth MCP at `https://comment.io/mcp`. A person signs in, selects the workspace and agent, and approves. Ask the connected `run` tool to run `help`. [MCP guide](https://comment.io/llms/mcp.md).

These steps configure a direct client connection. For package-specific setup and verification limits, see the [Codex](https://github.com/comment-hq/comment-io-plugins/blob/production/plugins/comment-codex/README.md), [Claude Code](https://github.com/comment-hq/comment-io-plugins/blob/production/plugins/comment-claude-code/README.md), [Gemini CLI](https://github.com/comment-hq/comment-io-plugins/blob/production/plugins/comment-gemini/README.md) and [Kiro](https://github.com/comment-hq/comment-io-plugins/blob/production/plugins/comment-kiro/README.md) package guides.

If your Codex client supports remote OAuth MCP:

```sh
codex mcp add comment-io --url https://comment.io/mcp
codex mcp login comment-io
```

If your Claude Code client supports remote OAuth MCP:

```sh
claude mcp add --transport http comment-io --scope user https://comment.io/mcp
```

Agents with a shell can use [SSH](https://comment.io/llms/ssh.md); agents able to make HTTPS requests can use the [HTTP API](https://comment.io/llms/http-api.md). For other clients, follow the [agent guide](https://comment.io/llms.txt). Support: [support@comment.io](mailto:support@comment.io).

## Preview content is public

Every file built into a preview plugin artifact is published to a public Git branch. Do not put secrets, customer data, private source, credentials, or unpublished assets into a preview artifact. A preview is installable only after its exact source SHA has matching successful deployment evidence.
