#!/bin/bash
# Points a cask at the latest GitHub release of its app.
#
#   ./update-cask.sh ruler simpel/ruler
set -euo pipefail
cd "$(dirname "$0")"

CASK="${1:?usage: update-cask.sh <cask> <owner/repo>}"
REPO="${2:?usage: update-cask.sh <cask> <owner/repo>}"
FILE="Casks/$CASK.rb"

TAG=$(gh release view --repo "$REPO" --json tagName --jq .tagName)
VERSION="${TAG#v}"
# Releases carry both a versioned DMG and an unversioned copy; the cask URL
# points at the versioned one.
ASSET=$(gh release view "$TAG" --repo "$REPO" --json assets \
  --jq '.assets[] | select(.name | test("^[A-Za-z]+-[0-9].*\\.dmg$")) | .name' | head -1)

TMP=$(mktemp -d)
gh release download "$TAG" --repo "$REPO" --pattern "$ASSET" --dir "$TMP"
SHA=$(shasum -a 256 "$TMP/$ASSET" | cut -d' ' -f1)
rm -rf "$TMP"

/usr/bin/sed -i '' -E "s/^  version \".*\"$/  version \"$VERSION\"/" "$FILE"
/usr/bin/sed -i '' -E "s/^  sha256 \".*\"$/  sha256 \"$SHA\"/" "$FILE"

if git diff --quiet -- "$FILE"; then
  echo "$CASK already points at $VERSION"
  exit 0
fi

echo "$CASK -> $VERSION ($SHA)"
git add "$FILE"
git commit -q -m "Update $CASK to $VERSION"
echo "Committed; push when ready:  git push"
