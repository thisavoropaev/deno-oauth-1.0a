#!/bin/sh
# Symlink .githooks/pre-push to .git/hooks/pre-push
HOOKS_DIR=".git/hooks"
SCRIPT_DIR=".githooks"
HOOK_NAME="pre-push"

mkdir -p "$HOOKS_DIR"
ln -sf "../../$SCRIPT_DIR/$HOOK_NAME" "$HOOKS_DIR/$HOOK_NAME"
chmod +x "$HOOKS_DIR/$HOOK_NAME"
echo "Git pre-push hook installed!"
