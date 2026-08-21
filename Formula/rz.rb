class Rz < Formula
  desc "Save and restore native Ghostty workspaces on macOS"
  homepage "https://github.com/marianposaceanu/rz"
  url "https://github.com/marianposaceanu/rz/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "fdc012f2c2311e7ed934a070dd9782a97dcadfd9906ae1c3090609c12bbb78f8"
  license "MIT"

  depends_on :macos
  depends_on "ruby"

  def install
    bin.install "bin/rz"
    libexec.install "libexec/snapshot-capture.applescript"
  end

  test do
    output = shell_output("#{bin}/rz --help")
    assert_match "rz --save NAME", output
    assert_match "rz --list [NUMBER]", output
  end
end
