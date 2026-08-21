class Mextdisplay < Formula
  desc "Terminal UI for managing external displays on Apple Silicon Macs"
  homepage "https://github.com/marianposaceanu/mextdisplay"
  url "https://github.com/marianposaceanu/mextdisplay/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "7f557d682ba7a932ccba31b18d0fc7891a2f0c0f902a27627f9aac2e0daa7cc4"
  license "MIT"

  depends_on "rust" => :build
  depends_on arch: :arm64
  depends_on :macos

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mextdisplay --version")
    assert_match "Manage external displays", shell_output("#{bin}/mextdisplay --help")
  end
end
