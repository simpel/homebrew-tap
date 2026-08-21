cask "ruler" do
  version "1.0.0"
  sha256 "9e6840db74f4fa00e8d0eade32af696533e7101712aa88e8f0d56aad3168b2d6"

  url "https://github.com/simpel/ruler/releases/download/v#{version}/Ruler-#{version}.dmg"
  name "Ruler"
  desc "Screen ruler overlay with live cursor readout, guides and drag measuring"
  homepage "https://github.com/simpel/ruler"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "Ruler.app"

  zap trash: [
    "~/Library/Preferences/com.github.simpel.ruler.plist",
    "~/Library/Saved Application State/com.github.simpel.ruler.savedState",
  ]

  caveats <<~EOS
    Ruler is not signed with an Apple Developer ID, so macOS quarantines it.
    The first launch will be blocked; clear the flag once with

      xattr -dr com.apple.quarantine #{appdir}/Ruler.app

    or open it from System Settings -> Privacy & Security -> Open Anyway.
  EOS
end
