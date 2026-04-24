class Peek < Formula
  desc "Inline shell autocomplete daemon for package scripts and tools"
  homepage "https://github.com/simpel/peek"
  version "1.2.5"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simpel/peek/releases/download/v1.2.5/peek-aarch64-apple-darwin.tar.gz"
      sha256 "a9c63250344d7a29e092bd6fe01f34bf94e4ea6f5629bec00e6a34749d765347"
    else
      url "https://github.com/simpel/peek/releases/download/v1.2.5/peek-x86_64-apple-darwin.tar.gz"
      sha256 "5d3585176f652ee97feebd022078c214e6a839b0dda13aa4d61ba0a904b7e263"
    end
  end

  def install
    bin.install "peek"
    bin.install "peekd"
    bin.install "peek-wrap"
    prefix.install "com.peek.daemon.plist"
  end

  service do
    run [opt_bin/"peekd"]
    keep_alive true
    log_path var/"log/peek.log"
    error_log_path var/"log/peek.log"
  end

  def caveats
    <<~EOS
      To activate peek, run:
        peek setup

      Then restart your terminal.
    EOS
  end

  test do
    assert_match "Inline shell autocomplete", shell_output("#{bin}/peek --help")
  end
end
