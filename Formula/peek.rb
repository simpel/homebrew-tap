class Peek < Formula
  desc "Inline shell autocomplete daemon for package scripts and tools"
  homepage "https://github.com/simpel/peek"
  version "1.2.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simpel/peek/releases/download/v1.2.2/peek-aarch64-apple-darwin.tar.gz"
      sha256 "b6c5c748323d72c04cc245856852559ca26ae222175b8de8f1d4a4f932d45938"
    else
      url "https://github.com/simpel/peek/releases/download/v1.2.2/peek-x86_64-apple-darwin.tar.gz"
      sha256 "d547ff17a863b14c14c6c97b589cf8962ecd050ae8c70802a0b38ae117f969f2"
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
