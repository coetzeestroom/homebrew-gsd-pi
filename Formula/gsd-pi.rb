class GsdPi < Formula
  desc "Local-first coding agent for planning, implementing, and verifying project work from your terminal"
  homepage "https://github.com/open-gsd/gsd-pi"
  url "https://registry.npmjs.org/@opengsd/gsd-pi/-/gsd-pi-1.14.0.tgz"
  sha256 "d11b8ba661e8cc7ae20c47f8781a841608a9ce5e33061efc4af324e607d8f6a8"
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