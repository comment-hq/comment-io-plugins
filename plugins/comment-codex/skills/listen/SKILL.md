---
name: listen
description: Attach this exact Codex conversation to Comment.io notifications. Use for `$listen`, “listen for mentions”, or “stop listening”, status, takeover, or stop. Default to the conversation's Ephemeral identity; use a durable identity only when the user explicitly selects it.
---

# Listen for Comment.io

The runtime is this plugin's `runtime/comment-plugin` file. It is not on PATH.
Never run a bare `comment-plugin` command. From this skill's path, replace
`/skills/listen/SKILL.md` with `/runtime/comment-plugin` and invoke that file.

Listen does not mint an identity. The connected Comment.io tools mint it.

If the user asked to stop or status, resolve the origin as in step 1, then
run step 6 or 5. Do not mint first.

Codex defers plugin tool definitions. Resolve `create_ephemeral_agent` from the host's current
tool catalog, using only a discovery capability the host actually exposes if the
catalog marks the function deferred. Keep the exact `comment-io` function
ready without calling it; step 2 supplies its arguments and calls it once. Do not
invent a search function or normalized tool name.
Never print tool descriptions. Never call `list_agents`. Ask the user to complete
browser login only when discovery or the call returns an explicit
authentication-required error for `comment-io`; then retry listen in a new
chat. If the exact function and a supported discovery capability are both absent,
report the tool-discovery failure instead of asking the user to log in. If the
user asked to listen and this skill is not available, the plugin is not installed.
Do not search the repo or inspect plugin state.
Do not run `identity` or `listen bind` as a substitute.

1. Resolve the exact production HTTPS origin as the `how-to-use-comment` skill does. With
   no target context, use `https://comment.io`.
2. Describe the work this conversation is doing with a concise 1-3 word `task`.
   Choose a fun one-word `name` that alliterates with that task. For example,
   use `task: "Architecture Review"` and `name: "Archie"`. Call
   `create_ephemeral_agent` once with those two arguments and omit
   `idempotency_key`. Keep the returned `data` object, including its canonical
   `display_name`, in this conversation. A saved Durable Agent Token skips this
   mint. Do not reread skills from disk.
3. Adopt by writing that mint `data` object as one JSON line on stdin (never
   argv). Extra keys are fine. Do not rebuild fields. Durable adopt uses a
   `dat_` token and omits grant fields.
   Start exactly `<runtime> listen adopt --origin "$BASE"` with stdin open. Do not wrap it in `read`, `printf`, a pipe, a fifo, or a temp file. Write that JSON line to the process stdin, then close stdin.
   Wait until the command prints `ADOPTED`. Adopt is its own command. Do not
   chain `listen bind` onto it with `;` or `&&`.
   If adopt returns `LISTEN_ORIGIN_MISMATCH`, stop. The host retained a tool
   connection for a different plugin environment. Tell the user to restart Codex after the plugin install or update.
   Then run `codex mcp login comment-io` and complete browser authorization.
   After authorization succeeds, start a fresh conversation.
   Then retry. Do not mint again or attempt bind in this conversation.
4. After `ADOPTED`, run `<runtime> listen bind --origin "$BASE"` as a new
   command. Wait until it prints `ARMED`. Then say
   `Listening as {display_name}` using the canonical value from the mint and
   stop. Do not expose the handle, mint again, or run status unless asked.
5. For status, run `<runtime> listen status --origin "$BASE"`. If it is
   armed, say `Listening as {display_name}` using the value printed by status.
6. For stop, run `<runtime> listen stop --origin "$BASE"`. Removal of the
   local bind happens before the generation-fenced remote stop so takeover can
   never strand the handle.

When woken, call `receive` with `agent_token` set to the Agent Token from `create_ephemeral_agent` or a saved Durable Agent Token. It returns the work item and the current comm.
Then `reply_to_comment` or `edit_comm` with the same `agent_token` — those settle the work item.
The host lifecycle re-arms listening.

Speak like a chat status. Use the comm title and the link the tool returns.
Examples:
- Listening as Archie (Architecture Review)
- Replied on Testing notifications
  https://comment.io/d/ca0eab1d486055703b687e8af2e09023e?focus=comment-51f2ce2d-9aaf-46b1-8f6b-ee2942d69b93
- Edited Testing notifications
  https://comment.io/d/ca0eab1d486055703b687e8af2e09023e
- Didn't make changes in the Comm
- All done

After a reply or edit, print that status and close with `All done`.

Codex listening is a detached waiter for this thread on the shared app-server. Bind arms wake then returns; the waiter must outlive that command. If bind yields a session before ARMED, wait on that same session. Injection uses the idle app-server thread and does not require the bind process to remain the owned terminal. The waiter exits on explicit stop, SessionEnd, or app-server socket loss.
