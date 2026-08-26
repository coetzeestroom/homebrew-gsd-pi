class GsdPi < Formula
  desc "Local-first coding agent for planning, implementing, and verifying project work from your terminal"
  homepage "https://github.com/open-gsd/gsd-pi"
  url "https://registry.npmjs.org/@opengsd/gsd-pi/-/gsd-pi-1.16.2.tgz"
  sha256 "c3f298f33bb315e6bf2c50f7596430e125502ee96138c21e157a467fe98ec6f5"
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