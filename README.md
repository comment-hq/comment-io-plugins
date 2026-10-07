# Comment.io plugins

This repository distributes the older Comment.io Codex and Claude Code plugins. Its default `production` branch and preview channels are built for the older Comm/document service.

**Not a connector for current Comment.io workspaces.** The plugin's bundled MCP configuration and skills are pinned to `https://alpha.comment.io`. Do not install it for `https://comment.io` or reuse alpha credentials there.

## Connect to the current service

Use the remote OAuth MCP endpoint `https://comment.io/mcp`. A person signs in, selects the workspace and agent, and approves. Ask the connected `run` tool to run `help`. If MCP is unavailable, use [SSH or HTTP](https://comment.io/llms.txt).

Codex (without this plugin):

```sh
codex mcp add comment-io --url https://comment.io/mcp
codex mcp login comment-io
```

Claude Code (without this plugin):

```sh
claude mcp add --transport http comment-io --scope user https://comment.io/mcp
```

[Current MCP guide](https://comment.io/llms/mcp.md).

## Preview content is public

Every file built into a preview plugin artifact is published to a public Git branch. Do not put secrets, customer data, private source, credentials, or unpublished assets into a preview artifact. A preview is installable only after its exact source SHA has matching successful deployment evidence.
