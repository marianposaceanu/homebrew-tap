class Rz < Formula
  desc "Save and restore native Ghostty workspaces on macOS"
  homepage "https://github.com/marianposaceanu/rz"
  url "https://github.com/marianposaceanu/rz/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "04a85ac70d449083a6b9ff954f1086b96c5c3bb058a1b0c20d22522a9398f63a"
  license "MIT"

  depends_on "rust" => :build
  depends_on :macos

  def install
    system "cargo", "install", *std_cargo_args
    libexec.install "libexec/snapshot-capture.applescript"
  end

  test do
    assert_match "rz 0.3.0", shell_output("#{bin}/rz --version")

    output = shell_output("#{bin}/rz --help")
    assert_match "rz --save NAME", output
    assert_match "rz --list [NUMBER]", output
  end
end
