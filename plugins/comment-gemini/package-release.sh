#!/usr/bin/env bash
set -euo pipefail

git archive --format=tar --mtime=1970-01-01T00:00:00Z HEAD:plugins/comment-gemini gemini-extension.json GEMINI.md README.md |
  gzip -n > "${1:?Usage: package-release.sh OUTPUT.tar.gz}"
