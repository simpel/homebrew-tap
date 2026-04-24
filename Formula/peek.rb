class Peek < Formula
  desc "Inline shell autocomplete daemon for package scripts and tools"
  homepage "https://github.com/simpel/peek"
  version "1.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simpel/peek/releases/download/v1.2.0/peek-aarch64-apple-darwin.tar.gz"
      sha256 "63309db5dc69cc1ad4ea78fbe0bd9ecb806ec16340194e2ded512b4067aca759"
    else
      url "https://github.com/simpel/peek/releases/download/v1.2.0/peek-x86_64-apple-darwin.tar.gz"
      sha256 "0e0e39d3a1df9d0b6376bfc365146468a0e65a7c4e9a528a22ed5c9f554f1138"
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
