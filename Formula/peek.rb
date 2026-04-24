class Peek < Formula
  desc "Inline shell autocomplete daemon for package scripts and tools"
  homepage "https://github.com/simpel/peek"
  version "1.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simpel/peek/releases/download/v1.1.0/peek-aarch64-apple-darwin.tar.gz"
      sha256 "6a54cc2916edecc71dbc3ecea1d64367ccd6ae95406b2ab96085889fe4f654ec"
    else
      url "https://github.com/simpel/peek/releases/download/v1.1.0/peek-x86_64-apple-darwin.tar.gz"
      sha256 "3a5c75640472f47683ff15d163e81f5fce286fcaf6fe743e6dc623940ca7f66d"
    end
  end

  def install
    bin.install "peek"
    bin.install "peekd"
    bin.install "peek-wrap"
    prefix.install "com.peek.daemon.plist"
  end

  def post_install
    system bin/"peek", "setup"
  end

  service do
    run [opt_bin/"peekd"]
    keep_alive true
    log_path var/"log/peek.log"
    error_log_path var/"log/peek.log"
  end

  def caveats
    <<~EOS
      peek has been added to your shell config.
      Restart your terminal to activate.
    EOS
  end

  test do
    assert_match "Inline shell autocomplete", shell_output("#{bin}/peek --help")
  end
end
