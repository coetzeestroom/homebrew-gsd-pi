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

    # gsd-pi and its dependencies ship prebuilt binaries for every platform.
    # Homebrew rejects non-native binaries in the prefix, so keep only the
    # build that matches the host.
    prune_non_native_binaries

    # std_npm_args installs with --ignore-scripts, so gsd-pi's postinstall never
    # runs and its bundled @gsd/* packages are not linked into node_modules.
    # Link them here; the full postinstall would also download Chromium and rtk.
    cd libexec/"lib/node_modules/@opengsd/gsd-pi" do
      system "node", "scripts/link-workspace-packages.cjs"
    end

    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gsd --version")
  end

  private

  def prune_non_native_binaries
    os = OS.mac? ? "darwin" : "linux"
    arch = Hardware::CPU.arm? ? "arm64" : "x64"

    # koffi: build/koffi/<os>_<arch>
    koffi_arch = "#{os}_#{arch}"
    Dir.glob("#{libexec}/**/koffi/build/koffi/*").each do |dir|
      rm_r(dir) if File.directory?(dir) && File.basename(dir) != koffi_arch
    end

    # node-pty: prebuilds/<os>-<arch>
    pty_arch = "#{os}-#{arch}"
    Dir.glob("#{libexec}/**/node-pty/prebuilds/*").each do |dir|
      rm_r(dir) if File.directory?(dir) && File.basename(dir) != pty_arch
    end

    # @anthropic-ai/claude-agent-sdk: vendor/<tool>/<arch>-<os>
    sdk_arch = "#{arch}-#{os}"
    Dir.glob("#{libexec}/**/@anthropic-ai/claude-agent-sdk/vendor/*/*").each do |dir|
      rm_r(dir) if File.directory?(dir) && File.basename(dir) != sdk_arch
    end
  end
end
