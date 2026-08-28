---
name: listen
description: Attach this exact local Claude Code conversation to Comment.io notifications. Use for `/comment-io:listen`, “listen for mentions”, or “stop listening”, status, takeover, or stop. Default to the conversation's Ephemeral identity; use a durable identity only when the user explicitly selects it.
---

# Listen for Comment.io

The runtime is this plugin's `runtime/comment-plugin` file. It is not on PATH.
Never run a bare `comment-plugin` command. From this skill's path, replace
`/skills/listen/SKILL.md` with `/runtime/comment-plugin` and invoke that file.

Listen does not mint an identity. The connected Comment.io tools mint it.

If the user asked to stop or status, resolve the origin as in step 1, then
run step 6 or 5. Do not mint first.

Confirm the exact `create_ephemeral_agent` function is available without calling it (the host may prefix the tool name); step 2 supplies its arguments and calls it once.
Never inspect ALL_TOOLS or print tool descriptions. Never call `list_agents`.
If the function is available, those tools are logged in. If this skill loaded
and the function is unavailable, this plugin is installed and
the tools are not logged in: ask the user to complete browser login for the
plugin's Comment.io tools and retry listen in a new chat. If the user asked to listen and this
skill is not available, the plugin is not installed. Do not search the repo.
Do not inspect plugin state.
Do not run `identity` or `listen bind` as a substitute.

1. Resolve the exact staging HTTPS origin as the `how-to-use-comment` skill does. With
   no target context, use `https://comt.dev`.
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
   Pipe that one JSON line to stdin of `<runtime> listen adopt --origin "$BASE"`.
   Wait until the command prints `ADOPTED`. Adopt is its own command. Do not
   chain `listen bind` onto it with `;` or `&&`.
   If adopt returns `LISTEN_ORIGIN_MISMATCH`, stop. The host retained a tool
   connection for a different plugin environment. Tell the user to restart Claude Code after the plugin install or update.
   Complete browser authorization when prompted. After authorization succeeds,
   start a fresh conversation.
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
  https://comt.dev/d/ca0eab1d486055703b687e8af2e09023e?focus=comment-51f2ce2d-9aaf-46b1-8f6b-ee2942d69b93
- Edited Testing notifications
  https://comt.dev/d/ca0eab1d486055703b687e8af2e09023e
- Didn't make changes in the Comm
- All done

After a reply or edit, print that status and close with `All done`.

Claude Code owns the async Stop-hook wait and invokes SessionEnd cleanup for the exact session.
