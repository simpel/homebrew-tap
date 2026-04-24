class Peek < Formula
  desc "Inline shell autocomplete daemon for package scripts and tools"
  homepage "https://github.com/simpel/peek"
  version "1.2.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simpel/peek/releases/download/v1.2.1/peek-aarch64-apple-darwin.tar.gz"
      sha256 "c62af711a632ddd17c02db663e9b8b3b0c1b37f928bcb9dc031146a121ec4744"
    else
      url "https://github.com/simpel/peek/releases/download/v1.2.1/peek-x86_64-apple-darwin.tar.gz"
      sha256 "205707a2038b569dd36b904df6be959a7df022d0f7844278cb92e4a509565546"
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
