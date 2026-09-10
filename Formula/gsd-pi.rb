class GsdPi < Formula
  desc "Local-first coding agent for planning and implementing project work"
  homepage "https://github.com/open-gsd/gsd-pi"
  url "https://registry.npmjs.org/@opengsd/gsd-pi/-/gsd-pi-1.19.0.tgz"
  sha256 "48005e5e3e7fbcedd11390e90e4ae710fa56a525ebd5556b33458ad3870e90aa"
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
