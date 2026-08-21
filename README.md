# simpel/homebrew-tap

Homebrew tap for my own tools.

```bash
brew tap simpel/tap
```

## Ruler

A macOS screen ruler that floats above every window — pixel rulers, live cursor
readout, crosshair marklines, draggable guides and shift-drag measuring.
Source: [simpel/ruler](https://github.com/simpel/ruler).

```bash
brew install --cask simpel/tap/ruler
```

Ruler is not signed with an Apple Developer ID, and Homebrew always applies the
macOS quarantine flag (the old `--no-quarantine` flag was removed in Homebrew
6), so clear it once after installing:

```bash
xattr -dr com.apple.quarantine /Applications/Ruler.app
```

Or open the app once from System Settings → Privacy & Security → Open Anyway.
Homebrew prints the same reminder as a caveat after installing.

## Peek

Inline shell autocomplete daemon for package scripts and tools.
Source: [simpel/peek](https://github.com/simpel/peek).

```bash
brew install simpel/tap/peek
```

## Maintaining

Point a cask at the latest GitHub release of its app:

```bash
./update-cask.sh ruler simpel/ruler
```

It reads the newest release, updates the version and checksum, and commits.
