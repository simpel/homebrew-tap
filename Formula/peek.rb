class Peek < Formula
  desc "Inline shell autocomplete daemon for package scripts and tools"
  homepage "https://github.com/simpel/peek"
  version "1.0.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simpel/peek/releases/download/v1.0.1/peek-aarch64-apple-darwin.tar.gz"
      sha256 "ca0e5b8e1afb626ce07bcbfa236383b01600bd364e27caeedbbf7b60a27cfdb7"
    else
      url "https://github.com/simpel/peek/releases/download/v1.0.1/peek-x86_64-apple-darwin.tar.gz"
      sha256 "8bb3c08f354c49a1a3bab541504cd61a3da9658a5a2f58e959253f8cf428187d"
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
      To start the peek daemon:
        brew services start peek

      To use inline completions, run your shell through peek-wrap:
        peek-wrap

      Or add to your terminal's shell command setting.
    EOS
  end

  test do
    assert_match "Inline shell autocomplete", shell_output("#{bin}/peek --help")
  end
end
