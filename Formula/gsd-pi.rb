class GsdPi < Formula
  desc "Local-first coding agent for planning, implementing, and verifying project work from your terminal"
  homepage "https://github.com/open-gsd/gsd-pi"
  url "https://registry.npmjs.org/@opengsd/gsd-pi/-/gsd-pi-1.16.1.tgz"
  sha256 "e4b87f52f77a3d95e32f0c4715b05e15efe1a46cd6bfae1b088e2502c845eb13"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gsd --version")
  end
end