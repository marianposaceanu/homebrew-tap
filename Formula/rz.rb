class Rz < Formula
  desc "Save and restore native Ghostty workspaces on macOS"
  homepage "https://github.com/marianposaceanu/rz"
  url "https://github.com/marianposaceanu/rz/archive/refs/tags/v0.3.1.tar.gz"
  sha256 "6a223b268ed6356d1c832f5d9693155eb80d0e5d6808655bf022212c8fcbdbab"
  license "MIT"

  depends_on "rust" => :build
  depends_on :macos

  def install
    system "cargo", "install", *std_cargo_args
    libexec.install "libexec/snapshot-capture.applescript"
  end

  test do
    assert_match "rz 0.3.1", shell_output("#{bin}/rz --version")

    output = shell_output("#{bin}/rz --help")
    assert_match "rz --save NAME", output
    assert_match "rz --list [NUMBER]", output
  end
end
