#!/usr/bin/env bash
set -euo pipefail

git archive --format=tar HEAD:plugins/comment-gemini gemini-extension.json GEMINI.md README.md |
  gzip -n > "${1:?Usage: package-release.sh OUTPUT.tar.gz}"
