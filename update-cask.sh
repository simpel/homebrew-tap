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
ASSET=$(gh release view "$TAG" --repo "$REPO" --json assets \
  --jq '.assets[] | select(.name | endswith(".dmg")) | .name')

TMP=$(mktemp -d)
gh release download "$TAG" --repo "$REPO" --pattern "*.dmg" --dir "$TMP"
SHA=$(shasum -a 256 "$TMP/$ASSET" | cut -d' ' -f1)
rm -rf "$TMP"

/usr/bin/sed -i '' -E "s/^  version \".*\"$/  version \"$VERSION\"/" "$FILE"
/usr/bin/sed -i '' -E "s/^  sha256 \".*\"$/  sha256 \"$SHA\"/" "$FILE"

echo "$CASK -> $VERSION ($SHA)"
git add "$FILE"
git commit -m "$CASK $VERSION"
echo "Commit made; push when ready:  git push"
