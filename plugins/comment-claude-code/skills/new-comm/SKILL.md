---
name: new-comm
description: Create a new Comment.io Comm from supplied context, a matching template, or another document. Use for `/comment-io:new-comm` or when the user asks to make, draft, import, or convert content into a new Comm.
---

# Create a new Comm

Create and fill one readable Comm, then leave the user at its canonical link.

## 1. Get the purpose

Use the supplied source, notes, or prior context to identify what the Comm
should help its readers understand, decide, or produce. With neither a source
nor enough context to determine that purpose, immediately ask:

> What should this Comm help its readers understand, decide, or produce?

Wait for the answer before invoking `how-to-use-comment` or `listen`. When a source is
already supplied, continue without asking; read it after establishing any
access route it requires and infer its purpose from the content.

This step is complete when the purpose is supplied or a source is available
from which to infer it.

## 2. Establish the route and identity

Invoke the installed `how-to-use-comment` skill before any Comment.io action.
Then invoke `listen`; this request authorizes arming the same identity.
Keep its setup in this conversation: mint once, complete adoption through
`ADOPTED`, then start the separate `listen bind` Bash command with
`run_in_background: true`. Retain the returned background task ID and the exact
mint data, then immediately continue with source resolution and writing in this
conversation. Do not wait on the background bind while content work remains.
An unavailable listener does not block creation.

This step is complete when creation, editing, and listening use one origin and
one identity policy.

## 3. Resolve the source and write

- Read a supplied file, URL, prior Comm, or other source with an available
  native capability.
- Otherwise use supplied notes or prior context.
- Confirm the purpose identified or inferred in step 1 against the resolved
  source.
- Write the complete Markdown in this conversation. Follow all document and
  section instructions, preserve requested detail, mark unknowns instead of
  guessing, and remove accidental empty sections.

This step is complete when the purpose is confirmed and the complete Markdown is
ready for the single creation call.

## 4. Create one Comm

Call `create_comm` now with `markdown` set to the requested content and
`agent_token` from this conversation's mint. When the user asked for a
template, use `list_templates` then `get_template` then `create_from_template`
with the same `agent_token`. Keep the human-openable URL from that one creation.

Immediately retain the exact human-openable URL returned by creation. Creation
is final at that point; recover later failures against that Comm instead of
creating another one.

## 5. Fill and hand off

Turn material placeholders into anchored comments with `mentions: ["owner"]`,
`allow_mentions: true`, and a `notify` brief stating the exact decision or
information needed.

Before handoff, collect any retained bind task with `TaskOutput` and blocking
enabled. Record `ARMED` on success or treat a failed bind as an unavailable
listener. Leave listening armed when available and report its honest state.
Leave the Comm unopened so the user can open it. End the final response with the
exact human-openable URL on its own line; it must be the final line.
