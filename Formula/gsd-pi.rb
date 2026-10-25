class GsdPi < Formula
  desc "Local-first coding agent for planning and implementing project work"
  homepage "https://github.com/open-gsd/gsd-pi"
  url "https://registry.npmjs.org/@opengsd/gsd-pi/-/gsd-pi-1.22.0.tgz"
  sha256 "eec58d51a3579d5e3e1bdcdd856733c9d0fcc355c97667b93ad154172a8a0ddb"
  license "MIT"

  livecheck do
    url :stable
    strategy :npm
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gsd --version")
  end
end
