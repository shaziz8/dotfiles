#!/bin/sh
# Check upstream mpv-file-browser, show what changed line by line,
# then update the local stripped copy.
#
# Usage: update-check-diff.sh

# Where your installed copy lives.
DIR="$HOME/.config/mpv/scripts/file-browser"

# Where the official script is downloaded from.
REPO="https://github.com/CogentRedTester/mpv-file-browser"

# Temporary folder to download into.
TMP=$(mktemp -d) || exit 1

# On every exit, delete the temp folder and leftover git/repo files.
trap 'rm -rf "$TMP" "$DIR/.git" "$DIR/.github" "$DIR/.gitignore" "$DIR/.luarc.json"' EXIT

# Download only the newest snapshot.
if ! git clone --depth 1 -q "$REPO" "$TMP/new"; then
    echo "Could not clone upstream (network problem?)"
    exit 1
fi

# Remove the part you don't keep, so it isn't reported as a change.
rm -rf "$TMP/new/modules/defs"

# Compare and keep the full diff text.
#   -r  recurse into folders
#   -u  unified format: lines starting with "-" were removed from your copy,
#       lines starting with "+" are new in upstream
# Empty output means the two copies are identical.
CHANGES=$(
    diff -ru "$DIR/main.lua" "$TMP/new/main.lua" 2>&1
    diff -ru "$DIR/modules" "$TMP/new/modules" 2>&1
)

if [ -z "$CHANGES" ]; then
    echo "No changes: you are up to date."
    exit 0
fi

# Show the diff. Left side (---) is your copy, right side (+++) is upstream.
echo "Changes found:"
echo
echo "$CHANGES"
echo

# Apply the update: replace main.lua and modules/ with the new versions.
# Any edits you made yourself to these files are overwritten.
cp "$TMP/new/main.lua" "$DIR/main.lua"
rm -rf "$DIR/modules"
cp -r "$TMP/new/modules" "$DIR/modules"

echo "Updated. Restart mpv."
