cask "ruler" do
  version "1.2.0"
  sha256 "5deda06555b1f364a81fdb5428bd6d6a4ed1171deebf97d7951d23c60eaf0bbd"

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
    "~/Library/Preferences/se.joelsanden.ruler.plist",
    "~/Library/Saved Application State/se.joelsanden.ruler.savedState",
  ]

  caveats <<~EOS
    Ruler is not signed with an Apple Developer ID, so macOS quarantines it.
    The first launch will be blocked; clear the flag once with

      xattr -dr com.apple.quarantine #{appdir}/Ruler.app

    or open it from System Settings -> Privacy & Security -> Open Anyway.
  EOS
end
