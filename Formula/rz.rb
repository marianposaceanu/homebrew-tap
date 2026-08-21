class Rz < Formula
  desc "Save and restore native Ghostty workspaces on macOS"
  homepage "https://github.com/marianposaceanu/rz"
  url "https://github.com/marianposaceanu/rz/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "c0c0c9838c059e8a5115fcc95f57fd3194767e6e7625ba0e4be6211f2a7305d0"
  license "MIT"

  depends_on "rust" => :build
  depends_on :macos

  def install
    system "cargo", "install", *std_cargo_args
    libexec.install "libexec/snapshot-capture.applescript"
  end

  test do
    assert_match "rz 0.2.1", shell_output("#{bin}/rz --version")

    output = shell_output("#{bin}/rz --help")
    assert_match "rz --save NAME", output
    assert_match "rz --list [NUMBER]", output
  end
end
