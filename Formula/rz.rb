class Rz < Formula
  desc "Save and restore native Ghostty workspaces on macOS"
  homepage "https://github.com/marianposaceanu/rz"
  url "https://github.com/marianposaceanu/rz/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "c367ad917aaa775688cd45739dd0a1502901ee7d180bceac163af33b027f6432"
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
