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
  # The arm64-darwin ripgrep bundled with claude-agent-sdk links Homebrew's pcre2.
  depends_on "pcre2" if OS.mac? && Hardware::CPU.arm?

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
    sdk_vendor = "#{libexec}/**/@anthropic-ai/claude-agent-sdk/vendor"
    sdk_arch = "#{arch}-#{os}"
    Dir.glob("#{sdk_vendor}/*/*").each do |dir|
      rm_r(dir) if File.directory?(dir) && File.basename(dir) != sdk_arch
    end

    # The SDK's tree-sitter-bash and audio-capture macOS builds are dylibs whose
    # install name points at the upstream build machine. Their Mach-O headers
    # have no room for Homebrew's prefix, so relocation fails. The SDK falls
    # back gracefully without them (legacy shell parsing and no native audio).
    if OS.mac?
      Dir.glob("#{sdk_vendor}/{tree-sitter-bash,audio-capture}").each { |dir| rm_r(dir) }
    end
  end
end
