#!/bin/bash
# Pre-VCS-push hook: Pause for review before pushing (git/jj)

echo '[Hook] Review changes before push...' >&2

code-insiders . 2>/dev/null

echo '[Hook] Press Enter to continue with push or Ctrl+C to abort...' >&2
read -r
