# Comment.io for Codex

Comment.io collaboration for local macOS and Linux sessions. The plugin includes how-to-use-comment, new-comm, and listen. How-to-use-comment, new-comm, and the listener use system POSIX sh, curl, OpenSSL, and direct HTTPS APIs. Work after a wake uses the connected Comment.io tools, not a local listen helper. The runtime preflights curl and OpenSSL before listen. Private runtime helpers keep stored credentials and secret text outside model-visible output.

## Install

```sh
codex plugin marketplace add comment-hq/comment-io-plugins
codex plugin add comment-codex@comment-io-plugins
codex mcp login comment-io
```

Complete browser authorization before starting a new Codex session.
