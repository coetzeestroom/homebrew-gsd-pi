class GsdPi < Formula
  desc "Local-first coding agent for planning and implementing project work"
  homepage "https://github.com/open-gsd/gsd-pi"
  url "https://registry.npmjs.org/@opengsd/gsd-pi/-/gsd-pi-1.20.0.tgz"
  Q36d04266f550c4b4568f815f5d077be7e7dc94c6d9912e523ec8e2fd26269babb66e7ac4fbeeeaf5fbb0200c9915998b394dc3262505cf45df7fa145ca8592
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
