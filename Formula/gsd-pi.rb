class GsdPi < Formula
  desc "Local-first coding agent for planning and implementing project work"
  homepage "https://github.com/open-gsd/gsd-pi"
  url "https://registry.npmjs.org/@opengsd/gsd-pi/-/gsd-pi-1.21.1.tgz"
  sha256 "e79f53893c73c2949ff310d8a8fc5c318c39af0123d6b0c742f0aa36d5fcf0c6abb66e7ac4fbeeeaf5fbb0200c9915998b394dc3262505cf45df7fa145ca8592
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
